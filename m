Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B12380D95
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhENPwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 11:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENPwY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 11:52:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21C8B6143F;
        Fri, 14 May 2021 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621007472;
        bh=E72x2DimC2alRidZ5K5jhELQf7PEHR2vpeIfDSP77Qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MRCfYUg7CqsWH3Bn1CgqwxW1MaO47cbZxyDUCJh5dzgL/0AzMLsZMuTKr9VaBKTly
         6dUS6/juQOhN+zyde4K3C1Gz6S0uRrE9J/16OrK01qbK9uAnMwkIpDz7mQz3Uz1TN3
         GZ8JPtwTzmzd2heM0DwvK+gVSXGomghLZZNDtO2/Bo9hWs+v2/63z4l0L11PMsXT5s
         9QuyX3NnHwr3MaxVWNs6iBNsOAb+Y+i0ZdjwziieIfevlg49vko6pmeCGHGE86mvVp
         ldQPn0IJ4b/xTcf4ud2moKAGB/9mlyICBDPMaulhcvOVNT0L4qT0p+78c1uyh53Yc2
         Q34mv7/wRuxPA==
Date:   Fri, 14 May 2021 10:51:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20210514155110.GA2764013@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-5-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 04:00:24PM +0800, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> In LS7A, multifunction device use same pci PIN and different
> irq for different function, so fix it for standard pci PIN
> usage.

Apparently the defect here is that the Interrupt Pin register reports
the wrong INTx values?

Will this be fixed in future hardware so we don't have to add more
devices to the quirk?

> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/quirks.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10b3b2057940..6ab4b3bba36b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -242,6 +242,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, loongson_system_bus_quirk);
>  
> +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> +{
> +	static const struct pci_device_id devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> +		{ 0, },
> +	};
> +
> +	if (pci_match_id(devids, dev)) {
> +		u8 fun = dev->devfn & 7;

Use PCI_FUNC().

> +		dev->pin = 1 + (fun & 3);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID, loongson_pci_pin_quirk);

The usual pattern is to list each device here instead of using
pci_match_id() in the quirk, e.g.,

  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a09, loongson_pci_pin_quirk);
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a19, loongson_pci_pin_quirk);
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a29, loongson_pci_pin_quirk);

>  static void loongson_mrrs_quirk(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
> -- 
> 2.27.0
> 
