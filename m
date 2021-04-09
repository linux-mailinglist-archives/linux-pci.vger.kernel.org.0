Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2835A3EB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhDIQq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 12:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDIQq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 12:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65EF610A7;
        Fri,  9 Apr 2021 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617986774;
        bh=UQn1oy9ovI4wcnd7hZW7lUvbYomqZrBjvcbkP9zVz8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hJqXuthM+urxzSEEUmo18nHrBsBJKJx61gmZHfvC7ayobxOz3yTG1IBURdFRtk9ly
         R7I5jgHmipy3w5rxg6IElx4X0MnYvW66QmD9xa0Tl9NDdv0VTNeMUIbv5X/Al70veg
         lnCwRwLLyplYP5nJ+KHa53phA2v9d1pIAwCHXVRGFmHYXmOxQ1wo8rKfWUYbw/xMJD
         yQuXKJ/LV5XNm3QvveTAFYllmCep3Qdo0tZ147QABIBhpoOdwqg4djwtJM8k5kMlak
         9DOVQqv2tnJru/wS4sZg6O9uD5WwzE3Nm3wL+7LflCV9fB1KfeYlNCpAnGVX/IAge8
         F0bCCHWybD7QA==
Date:   Fri, 9 Apr 2021 11:46:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>,
        Alay Shah <alay.shah@nutanix.com>,
        Suresh Gumpula <suresh.gumpula@nutanix.com>
Subject: Re: [PATCH] PCI: Delay after FLR of Intel DC P4510 NVMe
Message-ID: <20210409164612.GA2037722@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408190521.16897-1-raphael.norwitz@nutanix.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 07:05:27PM +0000, Raphael Norwitz wrote:
> Like the Intel DC P3700 NVMe, the Intel P4510 NVMe exhibits a timeout
> failure when the driver tries to interact with the device to soon after
> an FLR. The same reset quirk the P3700 uses also resolves the failure
> for the P4510, so this change introduces the same reset quirk for the
> P4510.
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alay Shah <alay.shah@nutanix.com>
> Signed-off-by: Suresh Gumpula <suresh.gumpula@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Applied to pci/virtualization for v5.13, thanks!

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..5a8c059b848d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3922,6 +3922,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
>  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
> +	{ PCI_VENDOR_ID_INTEL, 0x0a54, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
>  	{ 0 }
> -- 
> 2.20.1
