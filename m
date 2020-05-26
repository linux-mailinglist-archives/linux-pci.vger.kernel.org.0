Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103EE1E1E23
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgEZJOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 05:14:52 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17784 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbgEZJOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 05:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590484452; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=p+bHMkpoDzy8rVvOVRDAY6f1/rkxsWY4XxS7TtPnauLroe5uboR9c2NqtY5TLVkrprqmPRX41M051Rnq5B4GdWMOzeyznsUuNzm19HnnoQ/fRLniADZ4gq/BIDgft2Cu/KIGtQDKq+swtgIMssnjneTvJIjJB0kA+UNmzZXAH14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590484452; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=l4moJOlQVVIDnfso1+Ob8m0SP4jAI2KzASeT40hYua4=; 
        b=IggjK/MCNS+fnqyy6ezlJpC2C60OA650junskEmPQp/+aqWjy7OXpuq+QPgLBhfmlIz8jXqPZRiNcgg4sau+yrdN5M2NS/u+C4q2XOYCErtrG10bBPZXUeIN8lWSbqj3JUsbp5yPlNUhpwrHx59veK4OB93/lqOicDKHNd7VP2c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590484452;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=l4moJOlQVVIDnfso1+Ob8m0SP4jAI2KzASeT40hYua4=;
        b=PiI13PitE8Rag1CU/S6DAXhmGYjcNY2ji6SC35VRnx9sEzF7D8oPz8M7wxy/8+yz
        +JDywI7yS8b7PRGobKgEqkT+GBeFSIjo/f+XCSNVW2rtDCupawa+VTrob8B60dKZuV0
        jHP9scCtw4BTKmGvXKHWwyVao5uWJNE8A44X6cfQ=
Received: from [127.0.0.1] (60.177.188.90 [60.177.188.90]) by mx.zoho.com.cn
        with SMTPS id 1590484449917835.4876354517163; Tue, 26 May 2020 17:14:09 +0800 (CST)
Date:   Tue, 26 May 2020 17:14:08 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 5/5] MIPS: Loongson64: Switch to generic PCI driver
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <20200526091227.GB19547@e121166-lin.cambridge.arm.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-5-jiaxun.yang@flygoat.com> <20200522142550.GB15261@alpha.franken.de> <20200522152210.GA15567@e121166-lin.cambridge.arm.com> <20200522223656.GA22313@alpha.franken.de> <20200526091227.GB19547@e121166-lin.cambridge.arm.com>
Message-ID: <0E1938E0-933D-4E04-993F-1E225B5BE0EA@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B45=E6=9C=8826=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:12:27, Lorenzo Pieralisi <lorenzo=2Epieralisi@arm=2Ecom> =E5=86=99=E5=88=
=B0:
>On Sat, May 23, 2020 at 12:36:56AM +0200, Thomas Bogendoerfer wrote:
>> On Fri, May 22, 2020 at 04:22:11PM +0100, Lorenzo Pieralisi wrote:
>> > On Fri, May 22, 2020 at 04:25:50PM +0200, Thomas Bogendoerfer wrote:
>> > > On Thu, May 14, 2020 at 09:16:41PM +0800, Jiaxun Yang wrote:
>> > > > We can now enable generic PCI driver in Kconfig, and remove legac=
y
>> > > > PCI driver code=2E
>> > > >=20
>> > > > Radeon vbios quirk is moved to the platform folder to fit the
>> > > > new structure=2E
>> > > >=20
>> > > > Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> > > > --
>> > > > v9: Fix licenses tag
>> > > > ---
>> > > >  arch/mips/Kconfig                  |   1 +
>> > > >  arch/mips/loongson64/Makefile      |   2 +-
>> > > >  arch/mips/loongson64/vbios_quirk=2Ec |  29 ++++++++
>> > > >  arch/mips/pci/Makefile             |   1 -
>> > > >  arch/mips/pci/fixup-loongson3=2Ec    |  71 ------------------
>> > > >  arch/mips/pci/ops-loongson3=2Ec      | 116 ---------------------=
--------
>> > > >  6 files changed, 31 insertions(+), 189 deletions(-)
>> > > >  create mode 100644 arch/mips/loongson64/vbios_quirk=2Ec
>> > > >  delete mode 100644 arch/mips/pci/fixup-loongson3=2Ec
>> > > >  delete mode 100644 arch/mips/pci/ops-loongson3=2Ec
>> > >=20
>> > > Acked-by: Thomas Bogendoerfer <tsbogend@alpha=2Efranken=2Ede>
>> >=20
>> > This patch (so the series) does not apply to v5=2E7-rc1 which is our
>> > baseline=2E I reiterate the point, isn't it better to take the whole
>> > series through the MIPS tree ?
>>=20
>> sounds better then
>>=20
>> > Failing that, the series has to
>> > be rebased (or split differently so that it can be taken through
>> > different trees), just let me know=2E
>>=20
>> so let's take via mips-next=2E So can I add your Acked-by to the
>> first three patches ?
>
>I have acked patch 2, you have all required ACKs to get this series via
>the MIPS tree now, apologies for the delay=2E

I had received a regression report from test robot=2E

Will send v11 very soon=2E

Please take v11 into MIPS tree=2E

Thanks=2E


>
>Thanks,
>Lorenzo

--=20
Jiaxun Yang
