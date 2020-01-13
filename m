Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA2139BCC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMVpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 16:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAMVpM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 16:45:12 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8FA20CC7;
        Mon, 13 Jan 2020 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578951912;
        bh=cNM+trifQppQVmWLHDIheU3838+ouIqu4KohlNVE2W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OWYviWPlsbpybgnWy3g5GklkweM1lBUCM8pjfgSeXL/HKpXS2Odrs2N1yLhGZ7q0I
         Gvk/wcS0SZ0KR9EN771+zEkpnHodZAoo8HayesnR+fCRjRSYqTXzj/1jAg4+kR/b1+
         BOxPqHsePpONqH+K4Srs266/9ZzdFSCUJC5RhD54=
Date:   Mon, 13 Jan 2020 15:45:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Print the pci config space of devices before
 suspend
Message-ID: <20200113214510.GA119378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113060724.19571-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 02:07:24PM +0800, Chen Yu wrote:
> The pci config space was found to be insane during resume
> from hibernation(S4, or suspend to disk) on a VM:
> 
>  serial 0000:00:16.3: restoring config space at offset 0x14
>  (was 0x9104e000, writing 0xffffffff)
> 
> Either the snapshot on the disk has been scribbled or the pci
> config space becomes invalid before suspend. To narrow down
> and benefit future debugging, print the pci config space
> being saved before suspend, which is symmetric to the log
> in pci_restore_config_dword().
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Applied to pci/pm for v5.6, thanks!

> ---
>  drivers/pci/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e87196cc1a7f..34cde70440c3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1372,8 +1372,11 @@ int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
>  	/* XXX: 100% dword access ok here? */
> -	for (i = 0; i < 16; i++)
> +	for (i = 0; i < 16; i++) {
>  		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> +		pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
> +			i * 4, dev->saved_config_space[i]);
> +	}
>  	dev->state_saved = true;
>  
>  	i = pci_save_pcie_state(dev);
> -- 
> 2.17.1
> 
