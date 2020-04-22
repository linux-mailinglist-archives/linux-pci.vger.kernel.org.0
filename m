Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56A1B494A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDVP63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 11:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDVP63 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 11:58:29 -0400
Received: from localhost (mobile-166-175-189-88.mycingular.net [166.175.189.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582B820767;
        Wed, 22 Apr 2020 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587571108;
        bh=Bq1sW1KrjmLs7RBfwQrrQwnrHxvmg/mYtIFsJ+cvtP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MFKid+Q+LiTCQp/l1zKp12aNJIw1xrU+8i+cDnoBADHeUHWIF5oL/RlJb9XLepV03
         1q/Q0hhkB+xeTb3ksAJMydMrnOBlSfgxf7aH6DUWFqXjgaobKRRmyn009L/LCbC14l
         f/XMXcuyPERQ5SoPp2QF1OcB82/2PV4NPXsU0BRg=
Date:   Wed, 22 Apr 2020 10:58:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] PCI: Move Apex Edge TPU class quirk to fix BAR assignment
Message-ID: <20200422155826.GA222701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415001753.145993-1-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:17:53PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some Google Apex Edge TPU devices have a class code of 0
> (PCI_CLASS_NOT_DEFINED).  This prevents the PCI core from assigning
> resources for the Apex BARs because __dev_sort_resources() ignores
> classless devices, host bridges, and IOAPICs.
> 
> On x86, firmware typically assigns those resources, so this was not a
> problem.  But on some architectures, firmware does *not* assign BARs, and
> since the PCI core didn't do it either, the Apex device didn't work
> correctly:
> 
>   apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x00000000-0x00003fff 64bit pref] not claimed
>   apex 0000:01:00.0: error enabling PCI device
> 
> f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI class") added a
> quirk to fix the class code, but it was in the apex driver, and if the
> driver was built as a module, it was too late to help.
> 
> Move the quirk to the PCI core, where it will always run early enough that
> the PCI core will assign resources if necessary.
> 
> Link: https://lore.kernel.org/r/CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=Ha8TD8XroVqiZjgg@mail.gmail.com
> Fixes: f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI class")
> Reported-by: Lu�s Mendes <luis.p.mendes@gmail.com>
> Debugged-by: Lu�s Mendes <luis.p.mendes@gmail.com>
> Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Todd Poynor <toddpoynor@google.com>

Applied to for-linus for v5.7.

> ---
>  drivers/pci/quirks.c                 | 7 +++++++
>  drivers/staging/gasket/apex_driver.c | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..ca9ed5774eb1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5567,3 +5567,10 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
>  	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
> +
> +static void apex_pci_fixup_class(struct pci_dev *pdev)
> +{
> +	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> +			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 46199c8ca441..f12f81c8dd2f 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -570,13 +570,6 @@ static const struct pci_device_id apex_pci_ids[] = {
>  	{ PCI_DEVICE(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID) }, { 0 }
>  };
>  
> -static void apex_pci_fixup_class(struct pci_dev *pdev)
> -{
> -	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
> -}
> -DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
> -			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> -
>  static int apex_pci_probe(struct pci_dev *pci_dev,
>  			  const struct pci_device_id *id)
>  {
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
