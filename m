Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C283F18C28F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSVth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 17:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCSVth (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 17:49:37 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E44B2076F;
        Thu, 19 Mar 2020 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584654576;
        bh=CVs01TGipmPGpf0FCCjonz7WVkscCZD6wIB3CNx0vQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H2ALHgZ04MLBIcS9leloUIRe+vDtmh0wftirNSk5X4hZDlYYjmkn4POOjdsIke53Z
         1EVLw3k+hisKl3+B5G6AryXSyrb8dGjKFtskO2feKFq3fy4v6NqkCvdKKHc/ItmUys
         hMc+PkhNlPNnrFllKgtPXkS4IljdtREQORSGZfXg=
Date:   Thu, 19 Mar 2020 16:49:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
Message-ID: <20200319214934.GA8156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219192006.16270-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 03:20:06AM +0800, Kai-Heng Feng wrote:
> The ASMedia USB XHCI Controller claims to support generating PME# while
> in D0:
> 
> 01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
>         Subsystem: SUNIX Co., Ltd. Device 312b
>         Capabilities: [78] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> 
> However PME# only gets asserted when plugging USB 2.0 or USB 1.1
> devices, but not for USB 3.0 devices.
> 
> So remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/misc for v5.7, thanks!

> ---
>  drivers/pci/quirks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 79379b4c9d7a..24c71555dc77 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5436,3 +5436,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Device [1b21:2142]
> + * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
> + */
> +static void pci_fixup_no_d0_pme(struct pci_dev *dev)
> +{
> +	pci_info(dev, "PME# does not work under D0, disabling it\n");
> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
> -- 
> 2.17.1
> 
