Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4119F1DE819
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgEVNdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 09:33:10 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17781 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729687AbgEVNdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 09:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590154347; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=XcDdY9Zc9ZmGNHYn8DDKG/qswRbhJf7UbSJ/WkTRc7hkcBHTmVuT1I5KhoRWDFzvtyFAlVocxNzHTsd6urd13pZaBF22/gJCtB8yHK4OM/auxX4woV+nNqhhK/fzVWbYCjD1JEarvK0TFpbKtrwmKxuptkmRfCehvqaojFNpC8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590154347; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=QH/C/5Ek7w4bweX9MpQ6D+9TlcFLdZIHbRzPiOGCnFU=; 
        b=anPQGV0fv2E4kBdQhM02ly6dggpbrDpL8EhN741l+ds2dp4ulhZHsnGkvqrr8HPPQUP6b49jwppfN3xQEdW/LVWUJxGIFntaXnc8uwp/skX5oFr4bJBaPgHTgHRteFru+pvWBL93D2uwmH1xmjJ+rFKLKqt07pg/pUbCjfaxHqc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590154347;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=QH/C/5Ek7w4bweX9MpQ6D+9TlcFLdZIHbRzPiOGCnFU=;
        b=f02BWUr3Nv9d8cWlDdbkuabT/lGVKR9c/cCdZZPLqOgUKEGmdogSkXX4SPWe18rh
        iLWASU03V3THKoSbpJPPMTRWaUdGyazovcG1QHeTc2SgFXSiBpGM6afGwWuxtzmQcvk
        iZvHYtTwNBswG1aQdD44R5S6Q7SUKTzG9x7/2Tso=
Received: from [127.0.0.1] (112.17.236.196 [112.17.236.196]) by mx.zoho.com.cn
        with SMTPS id 1590154343201742.4200289775523; Fri, 22 May 2020 21:32:23 +0800 (CST)
Date:   Fri, 22 May 2020 21:32:10 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 2/5] PCI: Add Loongson PCI Controller support
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <20200522131018.GE11785@e121166-lin.cambridge.arm.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-1-jiaxun.yang@flygoat.com> <20200514131650.3587281-2-jiaxun.yang@flygoat.com> <AC29D474-D846-41AF-9900-759CE430A744@flygoat.com> <20200522131018.GE11785@e121166-lin.cambridge.arm.com>
Message-ID: <7FE3D498-D293-407C-A70C-5E763151477C@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B45=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=889=
:10:18, Lorenzo Pieralisi <lorenzo=2Epieralisi@arm=2Ecom> =E5=86=99=E5=88=
=B0:
>On Wed, May 20, 2020 at 07:57:29PM +0800, Jiaxun Yang wrote:
>>=20
>>=20
>> =E4=BA=8E 2020=E5=B9=B45=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=889:16:38, Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom> =E5=86=99=E5=88=B0:
>> >This controller can be found on Loongson-2K SoC, Loongson-3
>> >systems with RS780E/LS7A PCH=2E
>> >
>> >The RS780E part of code was previously located at
>> >arch/mips/pci/ops-loongson3=2Ec and now it can use generic PCI
>> >driver implementation=2E
>> >
>> >Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> >Reviewed-by: Rob Herring <robh@kernel=2Eorg>
>> >
>>=20
>> Hi there,
>>=20
>> Is it possible to let this series go into next tree soon?
>>=20
>> As LS7A dts patch would depend on this series, and I want to
>> make the whole LS7A basic support as a part of 5=2E8 release=2E
>
>I think you have all necessary tags to take this in the MIPS
>tree, please let me know if that's the way we want this to go
>upstream - I would not pull MIPS/dts changes into the PCI tree
>and I don't think it is needed for this series=2E

Please pull all PCI changes [1~3] into PCI tree=2E

And Thomas,
Could you please apply rest changes into MIPS Tree?

Thanks a lot!

>
>Thanks,
>Lorenzo

--=20
Jiaxun Yang
