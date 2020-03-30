Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8E198025
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgC3Ptb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 11:49:31 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17840 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728594AbgC3Ptb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 11:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585583265;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:To:CC:From:Message-ID;
        bh=fKY1wcYZ+Cm3/0t0E+sucQoBEZCO55f18FQxrRV8tbU=;
        b=Ft6YaDQksZwXu9aWisZaNWPg1STNzyBBqVK6U82BAG/PpOniQXG1fupGENDI66jg
        9KPkxqwfRHK/qcPngRUpyAVy0uN4KW+ftQ848pOkFSee3p2GORUtcXvdVrRjG3ATG2C
        kGMde+FJBhfqMB9TxLu9yhO0y9txS8/uSecWr5pY=
Received: from [10.233.233.252] (183.156.33.130 [183.156.33.130]) by mx.zoho.com.cn
        with SMTPS id 1585583262424928.8644851457047; Mon, 30 Mar 2020 23:47:42 +0800 (CST)
Date:   Mon, 30 Mar 2020 23:47:32 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <68446094-263d-d0d9-df00-bc1e81c1dffe@cogentembedded.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com> <20200330114239.1112759-5-jiaxun.yang@flygoat.com> <68446094-263d-d0d9-df00-bc1e81c1dffe@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@vger.kernel.org
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <90CFB680-D6DA-45E5-9E19-08F577672BA8@flygoat.com>
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=881=
1:37:21, Sergei Shtylyov <sergei=2Eshtylyov@cogentembedded=2Ecom> =E5=86=99=
=E5=88=B0:
>Hello!
>
>On 03/30/2020 02:42 PM, Jiaxun Yang wrote:
>
>> Add PCI Host controller node for Loongson64 with RS780E PCH dts=2E
>> Note that PCI interrupts are probed via legacy way, as different
>> machine have different interrupt arrangement, we can't cover all
>> of them in dt=2E
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> ---
>>  arch/mips/boot/dts/loongson/rs780e-pch=2Edtsi | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/boot/dts/loongson/rs780e-pch=2Edtsi
>b/arch/mips/boot/dts/loongson/rs780e-pch=2Edtsi
>> index 45c54d555fa4=2E=2Ef09599a4b9d7 100644
>> --- a/arch/mips/boot/dts/loongson/rs780e-pch=2Edtsi
>> +++ b/arch/mips/boot/dts/loongson/rs780e-pch=2Edtsi
>> @@ -5,10 +5,25 @@ bus@10000000 {
>>  		compatible =3D "simple-bus";
>>  		#address-cells =3D <2>;
>>  		#size-cells =3D <2>;
>> -		ranges =3D <0 0x10000000 0 0x10000000 0 0x10000000
>> +		ranges =3D <0 0x00000000 0 0x00000000 0 0x00010000 /* ioports */
>> +				0 0x10000000 0 0x10000000 0 0x10000000
>>  				0 0x40000000 0 0x40000000 0 0x40000000
>>  				0xfd 0xfe000000 0xfd 0xfe000000  0 0x2000000 /* PCI Config Space
>*/>;
>> =20
>> +		pci@1a000000 {
>> +			compatible =3D "loongson,rs780e-pci";
>> +			device_type =3D "pci";
>> +			#address-cells =3D <3>;
>> +			#size-cells =3D <2>;
>> +			#interrupt-cells =3D <0x1>;
>
>   No need for 0x=2E
>
>> +
>> +			reg =3D <0 0x1a000000 0 0x02000000>;
>> +
>> +			ranges =3D <0x01000000 0x0 0x00004000 0x0 0x00004000  0x0
>0x00004000>,
>> +				<0x02000000 0x0 0x40000000 0x0 0x40000000  0x0 0x40000000>;
>
>   No need for 0x before 0 here either=2E And why double spaces?
=20
Thanks=2E Will fix in next version=2E

The space was intent to split address and size but it seems unnecessary=2E

>
>> +
>> +		};
>> +
>>  		isa {
>>  			compatible =3D "isa";
>>  			#address-cells =3D <2>;
>>=20
>
>MBR, Sergei

--=20
Jiaxun Yang
