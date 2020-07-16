Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBC2219D0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 04:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGPCVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 22:21:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36429 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgGPCVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 22:21:50 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so4462849ioy.3;
        Wed, 15 Jul 2020 19:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J18DmYxRgSIpH3hV5LBxVyuh9ZY/GDYO8qmEEQaBcDU=;
        b=HH2/pf5lRrryPf/gODvUK367fqrzCytQE7otVM4Sk0MgEkKn8/DFjFf+xHZrTgdQGK
         4r5UjoBNzP7VOU97dRVzu686Ru60GVFx8DXRXhiK/awU0kYQftZB0dZB54MH3ThDYSCY
         Hox0A3JeH28lUSUU/2Zf9/8qyvidVWq4sExk4NxSJgKizGkQI6GfPdrB965rI5hJZp6G
         kVJnlIE69FDp3IjYHmGCwnupzSsxAMPiOVE1AiGbjxwfMoUB6RS7jNboZ8Y2W+W7BKgm
         CVpeNUfPHRRcoVgSKWJx4VodqnY2XPy6jk2AFO5WhLUvqRrbvskjBPtRamOmfdQh60OU
         zd+Q==
X-Gm-Message-State: AOAM530gTgSsxbad6ScY1IOTxobGFpFV3hOfOzXSHFikUmtAmZj1Uu2u
        5BEROmWUDRrS3lYHB1z9pohff58spmfuY1U55lI=
X-Google-Smtp-Source: ABdhPJxEbw11tnOzGDA14ejiynj8nJDk3EOFhaDKxlXCWWVp0V+z6Wb/dWvvlSBc+5kD70Wib7EQw+MvAGzdilLZAXQ=
X-Received: by 2002:a5e:da06:: with SMTP id x6mr2278449ioj.196.1594866109522;
 Wed, 15 Jul 2020 19:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 16 Jul 2020 10:21:38 +0800
Message-ID: <CAAhV-H7_J6oJOYujJqQqm-bpKH-ZKOy3y2yX0TFWzs5ywh=z_g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tiezhu,

You don't need to use the lower case in the title, "Loongson" is just
fine (and is recommended).

On Thu, Jul 16, 2020 at 10:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> According to the datasheet of Loongson LS7A bridge chip, the old version
> of Loongson LS7A PCIE port has a hardware bug about PCI class. As far as
> I know, the latest version has already fixed this bug.
>
> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
> early as possible.
>
> Otherwise, in the function pci_setup_device(), the related code about
> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
> = ((dev->class & 0xff) == 1);" maybe get wrong value due to without
> EARLY fixup.
>
> By the way, we can see that the PCI class fixup of other controllers are
> all EARLY fixups:
>
> [root@linux linux.git]# grep -rn -A 3 "PCI_CLASS_BRIDGE_PCI << 8" drivers/pci/controller/ | grep EARLY
> drivers/pci/controller/pcie-tango.c-327-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_class);
> drivers/pci/controller/pcie-tango.c-328-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_class);
> drivers/pci/controller/pci-tegra.c-775-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
> drivers/pci/controller/pci-tegra.c-776-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
> drivers/pci/controller/dwc/pcie-qcom.c-1442-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
> drivers/pci/controller/dwc/pcie-qcom.c-1443-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
> drivers/pci/controller/pcie-iproc-bcma.c-23-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
> drivers/pci/controller/pcie-iproc-bcma.c-24-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
>
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2: Modify the patch subject used with lower case "loongson"
>
> v3: Update the commit message
>
>  drivers/pci/controller/pci-loongson.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 459009c..58b862a 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>  {
>         dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_PCIE_PORT_0, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_PCIE_PORT_1, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_PCIE_PORT_2, bridge_class_quirk);
>
>  static void system_bus_quirk(struct pci_dev *pdev)
> --
> 2.1.0
>
