Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B088129C8F6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901391AbgJ0TbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 15:31:14 -0400
Received: from chronos.abteam.si ([46.4.99.117]:54301 "EHLO chronos.abteam.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1830043AbgJ0TbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 15:31:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by chronos.abteam.si (Postfix) with ESMTP id 62FBB5D00070
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 20:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bstnet.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:references:from:from:subject:subject; s=default; t=
        1603827069; x=1605641470; bh=CVpUseuAbiY+lK/TKCVXJswlPIStDXYeHC3
        eIFzcH7E=; b=Q637upha35QsF3wQW1q4zRgaqF+2NOrWIpu9WHB5ClPKirCb568
        auO7zoOheDWC/y2SADA2NCwIYRk7ceOU0dshJBIWtor9g7vAOYmRcRfMKxIMdqCc
        mRuEYdOVs2GiC2gPvO4QifnhMvf82mtg2RADKmKiwc+QnniDzS8+P+jo=
Received: from chronos.abteam.si ([127.0.0.1])
        by localhost (chronos.abteam.si [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 59omh_j7u1DQ for <linux-pci@vger.kernel.org>;
        Tue, 27 Oct 2020 20:31:09 +0100 (CET)
Received: from bst-slack.bstnet.org (unknown [IPv6:2a00:ee2:4d00:602:55ba:eee4:b8b8:69b3])
        (Authenticated sender: boris@abteam.si)
        by chronos.abteam.si (Postfix) with ESMTPSA id 12BA15D0005B
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 20:31:08 +0100 (CET)
Subject: Re: Kernel 5.9 IOMMU groups regression/change
From:   "Boris V." <borisvk@bstnet.org>
To:     linux-pci@vger.kernel.org
References: <74aeea93-8a46-5f5a-343c-790d4c655da3@bstnet.org>
Message-ID: <d76b70c1-17f6-60d7-b027-5ecda491101c@bstnet.org>
Date:   Tue, 27 Oct 2020 20:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <74aeea93-8a46-5f5a-343c-790d4c655da3@bstnet.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/10/2020 20:45, Boris V. wrote:
> With upgrade to kernel 5.9 my VMs stopped working, because some=20
> devices can't be passed through.
> This is caused by different IOMMU groups and devices being in the same=20
> group.
>
> For ex. with kernel 5.8 this are IOMMU groups:
> IOMMU Group 40:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: A=
SMedia Technology Inc. Device=20
> [1b21:118f]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller =
[0200]: Intel Corporation I211=20
> Gigabit Network Connection [8086:1539] (rev 03)
> IOMMU Group 43:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [010=
6]: ASMedia Technology Inc.=20
> ASM1062 Serial ATA Controller [1b21:0612] (rev 02)
> IOMMU Group 44:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03=
]: ASMedia Technology Inc.=20
> ASM1042A USB 3.0 Host Controller [1b21:1142]
>
> Ethernet, SATA and USB controller in its own group.
>
> And with 5.9, everything is in one group:
> IOMMU Group 29:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.0 PCI bridge [0604]: I=
ntel Corporation C610/X99 series=20
> chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.3 PCI bridge [0604]: I=
ntel Corporation C610/X99 series=20
> chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.4 PCI bridge [0604]: I=
ntel Corporation C610/X99 series=20
> chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:1c.6 PCI bridge [0604]: I=
ntel Corporation C610/X99 series=20
> chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07:00.0 PCI bridge [0604]: A=
SMedia Technology Inc. Device=20
> [1b21:118f]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:01.0 PCI bridge [0604]: A=
SMedia Technology Inc. Device=20
> [1b21:118f]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:03.0 PCI bridge [0604]: A=
SMedia Technology Inc. Device=20
> [1b21:118f]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 08:04.0 PCI bridge [0604]: A=
SMedia Technology Inc. Device=20
> [1b21:118f]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 09:00.0 Ethernet controller =
[0200]: Intel Corporation I211=20
> Gigabit Network Connection [8086:1539] (rev 03)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0c:00.0 SATA controller [010=
6]: ASMedia Technology Inc.=20
> ASM1062 Serial ATA Controller [1b21:0612] (rev 02)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0d:00.0 USB controller [0c03=
]: ASMedia Technology Inc.=20
> ASM1042A USB 3.0 Host Controller [1b21:1142]
>
>
> This seems to be caused by commit=20
> 52fbf5bdeeef415b28b8e6cdade1e48927927f60.
> commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60
> Author: Rajat Jain <rajatja@google.com>
> Date:=C2=A0=C2=A0 Tue Jul 7 15:46:02 2020 -0700
>
> =C2=A0=C2=A0=C2=A0 PCI: Cache ACS capability offset in device
>
> =C2=A0=C2=A0=C2=A0 Currently the ACS capability is being looked up at a=
 number of=20
> places. Read
> =C2=A0=C2=A0=C2=A0 and store it once at enumeration so that it can be u=
sed by all=20
> later.=C2=A0 No
> =C2=A0=C2=A0=C2=A0 functional change intended.
>
> =C2=A0=C2=A0=C2=A0 Link:=20
> https://lore.kernel.org/r/20200707224604.3737893-2-rajatja@google.com
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Rajat Jain <rajatja@google.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> =C2=A0drivers/pci/p2pdma.c |=C2=A0 2 +-
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++++++----
> =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/pci/probe.c=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/pci/quirks.c |=C2=A0 8 ++++----
> =C2=A0include/linux/pci.h=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 24 insertions(+), 11 deletions(-)
>
>
> If I revert this commit, I get back old groups.
>
> In commit log there is message 'No functional change intended'. But=20
> there is functional change.
>
> This is Intel Core i7-5930K CPU and X99 chipset. But I see the same=20
> thing on other Intel systems (didn't test on AMD).
>
>

Some more info.
Problem seems to be that pci_dev_specific_enable_acs() is not called=20
anymore.
Before, pci_enable_acs() was called from pci_init_capabilities() and in=20
pci_enable_acs(), pci_dev_specific_enable_acs() was called.
I don't know anything about PCI and this stuff, but I'm guessing that=20
this function enable ACS for some Intel devices.
But after this commit, pci_acs_init() is called from=20
pci_init_capabilities() and if pci_find_ext_capability(dev,=20
PCI_EXT_CAP_ID_ACS) returns 0,
pci_enable_acs() and pci_dev_specific_enable_acs() is not called anymore.
If I apply for ex. this patch bellow, groups are right again and=20
everything works as before.

diff -ur linux-5.9.1.orig/drivers/pci/pci.c linux-5.9.1/drivers/pci/pci.c
--- linux-5.9.1.orig/drivers/pci/pci.c=C2=A0 2020-10-17 08:31:22.00000000=
0 +0200
+++ linux-5.9.1/drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 202=
0-10-27 19:01:32.650010803 +0100
@@ -3502,9 +3502,7 @@
 =C2=A0void pci_acs_init(struct pci_dev *dev)
 =C2=A0{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->acs_cap =3D pci_find_ext=
_capability(dev, PCI_EXT_CAP_ID_ACS);
-
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->acs_cap)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pci_enable_acs(dev);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_enable_acs(dev);
 =C2=A0}

 =C2=A0/**


