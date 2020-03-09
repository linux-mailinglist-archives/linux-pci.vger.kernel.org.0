Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4457717DB89
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCIIuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:50:50 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17842 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCIIut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583743805;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=arbMPqUJNmVr7z8xDGX4dxhr0Jiu/21GH9BeGGFEGqM=;
        b=c9gPUBVssKTdnoFnpfLyta/PBYHPP/eNOKjJboGMgjuf+KpKU/ErK1jko5L5RUDe
        e6M40FwTByqvsri6OqJNxafWBFFp9nZyJac3G61SiT9bqqDL3MHXg41EkGbbe8BQOis
        DhQPwqyOvO110mqrpmmmtgbWZTavGMQLcHpfI5GM=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 15837438034103.9039562753517885; Mon, 9 Mar 2020 16:50:03 +0800 (CST)
Date:   Mon, 09 Mar 2020 16:50:03 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhc@lemote.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-mips" <linux-mips@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-ide" <linux-ide@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>
Message-ID: <170be7ca00e.133ea84fa2305.7803335422925759322@flygoat.com>
In-Reply-To: <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH_1/6]_PCI:_Add_Loongson?=
 =?UTF-8?Q?_vendor_ID_and_7A1000_device_IDs?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:21 Tiezhu Yan=
g <yangtiezhu@loongson.cn> =E6=92=B0=E5=86=99 ----
 > Add the Loongson vendor ID and 7A1000 device IDs to pci_ids.h
 > to be used by the controller driver in the future.
 >=20
 > The Loongson IDs can be found at the following link:
 > https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
 >=20
 > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
 > ---
 >  include/linux/pci_ids.h | 18 ++++++++++++++++++
 >  1 file changed, 18 insertions(+)
 >=20
 > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
 > index 352c0d7..0125ab4 100644
 > --- a/include/linux/pci_ids.h
 > +++ b/include/linux/pci_ids.h
 > @@ -3113,4 +3113,22 @@
 > =20
 >  #define PCI_VENDOR_ID_NCUBE        0x10ff
 > =20
 > +#define PCI_VENDOR_ID_LOONGSON            0x0014
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HT    0x7a00
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_APB    0x7a02
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GMAC    0x7a03
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OTG    0x7a04
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DC    0x7a06
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HDA    0x7a07
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SATA    0x7a08
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X1    0x7a09
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SPI    0x7a0b
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_LPC    0x7a0c
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DMA    0x7a0f
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_EHCI    0x7a14
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GPU    0x7a15
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X4    0x7a19
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OHCI    0x7a24
 > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X8    0x7a29

Devices IDs are unlikely to be reused by mutiple subsystems, so probably we=
 don't need
to add them here?
=20
> +
 >  #endif /* _LINUX_PCI_IDS_H */
 > --=20
 > 2.1.0
 >=20
 >
