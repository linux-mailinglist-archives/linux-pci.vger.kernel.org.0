Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5717EEB5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCJCiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 22:38:09 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17897 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbgCJCiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 22:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583807858;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:To:CC:From:Message-ID;
        bh=SRB4gI+kmNulvAgHVpKm0WCkLF/bIFaCvoqIj9M+hWw=;
        b=eyGcaXh590ZfA2qIFavo5UB/lXnKcszs4kKUn+ApMEHHjltR70wUbnBtE3175l8s
        u0f4rA2VxxvQgOjrAMxyxZgDYOfxwHHPMqK5FaTYcYDgTa6LDJakuetiI4KseWtZ6h5
        SoTvq6VMRHANbwimgGILboxE0HqSu2sHqvpZlQLk=
Received: from [10.233.233.252] (125.120.190.194 [125.120.190.194]) by mx.zoho.com.cn
        with SMTPS id 158380785586338.32031942445258; Tue, 10 Mar 2020 10:37:35 +0800 (CST)
Date:   Tue, 10 Mar 2020 10:37:34 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <2ba6de2e-7880-d322-a0f6-5cea2647ea50@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn> <170be7ca00e.133ea84fa2305.7803335422925759322@flygoat.com> <2ba6de2e-7880-d322-a0f6-5cea2647ea50@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=3A=5BPATCH_1/6=5D_PCI=3A_Add_Loongs?= =?UTF-8?Q?on_vendor_ID_and_7A1000_device_IDs?=
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <7262AFE6-B850-4F34-A79F-2B59341C9B88@flygoat.com>
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8810=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
0:31:56, Tiezhu Yang <yangtiezhu@loongson=2Ecn> =E5=86=99=E5=88=B0:
>On 03/09/2020 04:50 PM, Jiaxun Yang wrote:
>>   ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:21 Tiezh=
u Yang
><yangtiezhu@loongson=2Ecn> =E6=92=B0=E5=86=99 ----
>>   > Add the Loongson vendor ID and 7A1000 device IDs to pci_ids=2Eh
>>   > to be used by the controller driver in the future=2E
>>   >
>>   > The Loongson IDs can be found at the following link:
>>   >
>https://git=2Ekernel=2Eorg/pub/scm/utils/pciutils/pciutils=2Egit/tree/pci=
=2Eids
>>   >
>>   > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson=2Ecn>
>>   > ---
>>   >  include/linux/pci_ids=2Eh | 18 ++++++++++++++++++
>>   >  1 file changed, 18 insertions(+)
>>   >
>>   > diff --git a/include/linux/pci_ids=2Eh b/include/linux/pci_ids=2Eh
>>   > index 352c0d7=2E=2E0125ab4 100644
>>   > --- a/include/linux/pci_ids=2Eh
>>   > +++ b/include/linux/pci_ids=2Eh
>>   > @@ -3113,4 +3113,22 @@
>>   >
>>   >  #define PCI_VENDOR_ID_NCUBE        0x10ff
>>   >
>>   > +#define PCI_VENDOR_ID_LOONGSON            0x0014
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HT    0x7a00
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_APB    0x7a02
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GMAC    0x7a03
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OTG    0x7a04
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DC    0x7a06
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HDA    0x7a07
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SATA    0x7a08
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X1    0x7a09
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SPI    0x7a0b
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_LPC    0x7a0c
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DMA    0x7a0f
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_EHCI    0x7a14
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GPU    0x7a15
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X4    0x7a19
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OHCI    0x7a24
>>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X8    0x7a29
>>
>> Devices IDs are unlikely to be reused by mutiple subsystems, so
>probably we don't need
>> to add them here?
>
>Hi Jiaxun,
>
>I think it is better to define the device IDs in pci_ids=2Eh,
>otherwise it seems a little disorganized=2E

Please read the comment at the start of this file=2E
New entries should be added only if they're shared by multiple drivers=2E

That's the rule=2E

And probably you can split these two patches into a new series
as they're likely to be accepted=2E

Thanks=2E

>
>Thanks,
>
>Tiezhu Yang
>
>>  =20
>>> +
>>   >  #endif /* _LINUX_PCI_IDS_H */
>>   > --
>>   > 2=2E1=2E0
>>   >
>>   >

--=20
Jiaxun Yang
