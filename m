Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4407913133F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFNy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 08:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgAFNy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 08:54:57 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60AA2071A;
        Mon,  6 Jan 2020 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578318897;
        bh=PgdwEjB+dKrFD9Ry2N2JWpkiQ6+qblfVzY+8bVOjLZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1JAkv1XART95VC99OXLkcFmjBhOZuGcvctWRi2RDbsjQubOm7l4tPRCak8C1+ZgY1
         dvqhVm0Q1vumOJHIvPi7yPPwzSxgvp1xOUWILTphDNQuhN5a+J2vu8CEpvQXnEWwSp
         /MWrIWUfevMkTIVRk4inZ3BgQCd35UVZJLAmRbVo=
Date:   Mon, 6 Jan 2020 07:54:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Warn if BME cannot be turned off during kexec
Message-ID: <20200106135455.GA104407@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104225052.27275-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Deepa,

Thanks for the patches.  Since these two patches touch the same piece
of code in pci_device_shutdown(), they conflict with each other.  I
could resolve this myself, but maybe you could make them a series that
applies cleanly together?

Can you also please edit the subject lines so they match the
convention (use "git log --oneline drivers/pci/pci-driver.c" to see
it).

On Sat, Jan 04, 2020 at 02:50:52PM -0800, Deepa Dinamani wrote:
> BME not being off is a security risk, so for whatever
> reason if we cannot disable it, print a warning.

"BME" is not a common term in drivers/pci; can you use "Bus Master
Enable" (to match the PCIe spec) or "PCI_COMMAND_MASTER" (to match the
Linux code)?

Can you also explain why this is a security risk?  It looks like we
disable bus mastering if the device is in D0-D3hot.  If the device is
in D3cold, it's powered off, so we can't read/write config space.  But
if it's in D3cold, the device is powered off, so it can't be a bus
master either, so why would we warn about it?

> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  drivers/pci/pci-driver.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..6c866a81f46c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -491,8 +491,12 @@ static void pci_device_shutdown(struct device *dev)
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> -		pci_clear_master(pci_dev);
> +	if (kexec_in_progress) {
> +		if (likely(pci_dev->current_state <= PCI_D3hot))

No need to use "likely" here unless you can measure a difference.  I
doubt this is a performance path.

> +			pci_clear_master(pci_dev);
> +		else
> +			dev_warn(dev, "Unable to turn off BME during kexec");

How often and for what sort of devices would you expect this warning
to be emitted?  If this is a common situation and the user can't do
anything about it, the warnings will clutter the logs and train users
to ignore them.

Bjorn

> +	}
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.17.1
> 
