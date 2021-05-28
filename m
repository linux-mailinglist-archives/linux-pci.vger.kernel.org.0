Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2B394813
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 22:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhE1UxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 16:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhE1UxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 16:53:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96256127C;
        Fri, 28 May 2021 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622235091;
        bh=ERoZNSLYZ0e9wNvhY3C1vLT65rbgIUv7E4RCXda+i/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oNZUuOSDhCzM8+7updZu8uSvQlF7luB8ctiAC6afztDGiHKh/18erVWxdJiFfIGN5
         k6WSttjdB3++lj6+62dV2sZ7fIftBBydOU8FN6jd1U6M5isvTGXddgBAzgkU4dy5Xm
         0eOLqDwYMnFCgNJcPZTR3+SiE8AcVuFZfIkMzqNF4EUlAT2iYzHZNpCJIHXY2euCo6
         GrytHpmmb/962LO0xXI5U7tX+wuSZgWcjDSk0WWm9gHG/PKuK1rj01wS2fzSwEnBqC
         VRs0lx7boLzWdVR3EWsg8K0m2b5sVuVeFiXSUwoKWogT2iy5MUcIfbrPxET6xkRBiI
         yq9ZioEvJigeQ==
Date:   Fri, 28 May 2021 15:51:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 4/4] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20210528205129.GA1519561@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528071503.1444680-5-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob, previous discussion at
https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn]

On Fri, May 28, 2021 at 03:15:03PM +0800, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> In LS7A, multifunction device use same PCI PIN (because the PIN register
> report the same INTx value to each function) but we need different IRQ
> for different functions, so add a quirk to fix it for standard PCI PIN
> usage.

This seems to say that PCI_INTERRUPT_PIN reports the same value for
all functions, but the functions actually use *different* IRQs.

That would be a hardware defect, and of course, we can work around
such things.  It's always better if you can assure us that the defect
will be fixed in future designs so we don't have to update the
workaround with more device IDs.

But Jiaxun suggests [1] that the FDT says all the interrupts go to the
same IRQ.

So I don't know what's going on here.  We can certainly work around a
problem, but of course, this quirk would apply for both FDT and
ACPI-based systems, and the FDT systems seem to work without it.

[1] https://lore.kernel.org/r/933330cb-9d86-2b22-9bed-64becefbe2d1@flygoat.com

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
> @@ -242,6 +242,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, loongson_system_bus_quirk);
>  
> +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> +{
> +	dev->pin = 1 + (PCI_FUNC(dev->devfn) & 3);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
> +
>  static void loongson_mrrs_quirk(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
> -- 
> 2.27.0
> 
