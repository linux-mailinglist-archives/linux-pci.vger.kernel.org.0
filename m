Return-Path: <linux-pci+bounces-19530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13337A058A9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990E418847E2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E11F8924;
	Wed,  8 Jan 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaKSFZuW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32F1A0BF8;
	Wed,  8 Jan 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333460; cv=none; b=PocCFNh/XBWagiMLXbnYh++g1+RDJ3CrlzTvpqxXUZWrmN7mD5KcFTUoyrSRKK236Gzcltc9jjqHM4zu/EhtqboVJc8WrELyBlltUJTsCbBGp3ES+40/sPnCio7QHY3GVw9Hcoc+IeG2ty12di27TvMxDlUxhsrJrUcpzeEcjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333460; c=relaxed/simple;
	bh=DGsI5H6wNCpaAh8zutxrF8hocNuLnPGZjf5Kxt1y83s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2hFE9GfPOggSTKpsh6MVJJW/ie7MSLBC66jc2cWPN79YGGBSTt4ORWigSWs+Mvkvpl66IHJ+i1ymIa8KF506hqUxIGQfOQtkRQkLVFznzhGoUATfv1PVDqbr1RwwODhzyPPZgmkX20Qe6xJFBkV2xLSShho3HVKmAgRp+HI2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaKSFZuW; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51619b06a1cso9187282e0c.3;
        Wed, 08 Jan 2025 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736333457; x=1736938257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4TMyI5r8pZ1tAS9fCahIh+s4gh/PJrR8j5HELFZAIY=;
        b=jaKSFZuWuEYKJlHJkztsQiBnzgOYtpt2votXLK0jvwccjZ9PNEax5ruIvWfhu+KHui
         jZfY+UWhfVfN9DcjfT0XVyfF7LOwLXsOVK6YHVyVUEkoDnjisd7KT75IJ+zZe6puvh27
         9+TxoNkOCNqIqmdrBZciSxZlKKQajinEeeffA5jpdNitzTc2Cx9O9UhgsQc0xNImAdSU
         64C56abEX25qWdXLyrn24/4W9Av8dUB1hsdXewRG3GqGjdPH5itGNU7WoqGnKTgXCOxV
         QkJXvaY84OL96E78uJ3AmkaRHr6PB33Fqou7rGALj9zb2SDmDVcNbhuBht5hYvzrTijz
         gR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333457; x=1736938257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4TMyI5r8pZ1tAS9fCahIh+s4gh/PJrR8j5HELFZAIY=;
        b=pvDg7dVzgTIxFWf7sydkiDFy907aF5f9TOtT5HP1je0BzhoSVluixxGjpa+g5TeA0U
         rLxOPnpxBjQDAsjxxyrDhgzj/+xirGOzjZGdCsArxRPkLcWXJNKnVjC8mmwInMonqp4M
         tM/n4CKIG9FKkOZoOWAKxPqZB1L03A2IiHNxIyy2htPYqHUw+nF0Au7pi/tchY7E4T2l
         KAg/JAsU+0EokHvib3gFNJD+q2uORsSMTDVpYhaIVSVa1l9NYVFiD+7V8rC8f7H6tUWX
         wjSkLOurz7Z4j8C9fH0kiTTxgANbMR8fsjwiLMEq4vLY9eng06blK0/kc0O0io18Tltj
         Egug==
X-Forwarded-Encrypted: i=1; AJvYcCU/rwolGgHL7z76nf6G532ki2SrFnmVuPv1svScVydM2R6E5+t9WN5IwiAJ0DBJQMJ2eMpNvKEXpI7jCYov3FB8RZM=@vger.kernel.org, AJvYcCVKcVnbeBdLe8trWCgfnuKB2uSSHOqD8Y6XNV3So5BdxsjP2FoKePAhpVn2i385U4Q7dGdc8+uUHJDl@vger.kernel.org, AJvYcCXAvD2hSZ4MyM9ku8HFWVcVqrntE+2jhU4MfqGTKyWbSY4pvrAmtiX4DqhiqK4CPlX60+SsOFsBmxVx8/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EWrMafamDGer7bIhrwH4/RVRXYKs0FOtz869U/i3RJsn1pza
	uTPuDZNyGaN4NRxo1WxAflrvrY3T+NOsqJ8Qxc6jOz028XSrIAWMibUFr06X+7ezUzDsppKn2c5
	Nli9o46/cQSU1ySPboCjPHBUF+lU=
X-Gm-Gg: ASbGncv9JXx1P0uo1LVrzPoiv5NmJyQCdNyNKDgDtwDKCOiieChhp2OUpRyxE7+m65p
	btgTHJjDySTsxv/DyF59zlB7PJQ1A0AK74epsLV4=
X-Google-Smtp-Source: AGHT+IEFNc7v51CDsERN/bu01C/6SIdUGISVC0cXTHybmd/WgAQDJJq/0OFwb6K7AKz0TAaxrZ0YJgH6u0CtmeunF+c=
X-Received: by 2002:a05:6122:1796:b0:518:79f2:9345 with SMTP id
 71dfb90a1353d-51c6c244d5dmr1468392e0c.4.1736333457555; Wed, 08 Jan 2025
 02:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107225653.GA189000@bhelgaas> <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
 <TY3PR01MB1134694A42FADD885D9D7596C86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134694A42FADD885D9D7596C86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 8 Jan 2025 10:50:31 +0000
X-Gm-Features: AbW1kvZGOxQd_oYf9pnwFLvGvmylE36UEJohxvcnmAfB2CWcDMStB_nMjL9efw8
Message-ID: <CA+V-a8u--RC2Snmpm2QZxFfT382GrrD1Mse-JW-JJ_KWA-M_Lg@mail.gmail.com>
Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "kingdix10@qq.com" <kingdix10@qq.com>, "helgaas@kernel.org" <helgaas@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"robh@kernel.org" <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:45=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: kingdix10@qq.com <kingdix10@qq.com>
> > Sent: 08 January 2025 04:59
> > Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name par=
ameter when calling
> > devm_request_mem_region
> >
> > On Tue, 2025-01-07 at 16:56 -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 07, 2025 at 09:51:23PM +0800, kingdix10@qq.com wrote:
> > > > From: King Dix <kingdix10@qq.com>
> > > >
> > > > When using devm_request_mem_region to request a resource, if the
> > > > passed variable is a stack string variable, it will lead to an oops
> > > > issue when executing the command cat /proc/iomem.
> > > >
> > > > Fix this by replacing outbound_name with the name of the previously
> > > > requested resource.
> > >
> > > Thanks a lot for doing this work!
> > >
> > > Add "()" after function names in subject and commit log.
> > >
> >
> > Thanks for your review. I will fix the issue right now.
> >
> > > Please include a couple lines of the oops message to help people
> > > connect the problem with the fix.
>
> Maybe Prabhakar should be able to provide Oops log, as it is tested on re=
al platform??
>
It doesn't Oops out, it just prints a null string. Below are the logs
from RZ/G2M:

$  cat /proc/iomem
30000000-37ffffff : =EF=BF=BD=EF=BF=BD
38000000-3fffffff : =EF=BF=BD=EF=BF=BD
48000000-bfffffff : System RAM
  48210000-496affff : Kernel code
  496b0000-4987ffff : reserved
  49880000-49a8ffff : Kernel data
  b9eca000-b9ed8fff : reserved
  ba000000-bfffffff : reserved
e6020000-e602000b : e6020000.watchdog watchdog@e6020000
e6050000-e605004f : e6050000.gpio gpio@e6050000
e6051000-e605104f : e6051000.gpio gpio@e6051000
e6052000-e605204f : e6052000.gpio gpio@e6052000
e6053000-e605304f : e6053000.gpio gpio@e6053000
e6054000-e605404f : e6054000.gpio gpio@e6054000
e6055000-e605504f : e6055000.gpio gpio@e6055000
e6055400-e605544f : e6055400.gpio gpio@e6055400
e6055800-e605584f : e6055800.gpio gpio@e6055800
e6060000-e606050b : e6060000.pinctrl pinctrl@e6060000
e6198000-e61980ff : e6198000.thermal thermal@e6198000
e61a0000-e61a00ff : e6198000.thermal thermal@e6198000
e61a8000-e61a80ff : e6198000.thermal thermal@e6198000
e61c0000-e61c01ff : e61c0000.interrupt-controller interrupt-controller@e61c=
0000
e6510000-e651003f : e6510000.i2c i2c@e6510000
e6540000-e654005f : e6540000.serial
e6590000-e65901ff : e6590000.usb usb@e6590000
e65a0000-e65a00ff : e65a0000.dma-controller dma-controller@e65a0000
e65b0000-e65b00ff : e65b0000.dma-controller dma-controller@e65b0000
e65ee000-e65ee08f : e65ee000.usb-phy usb-phy@e65ee000
e66d8000-e66d803f : e66d8000.i2c i2c@e66d8000
e6700000-e670ffff : e6700000.dma-controller dma-controller@e6700000
e6800000-e68007ff : e6800000.ethernet ethernet@e6800000
e6c30000-e6c30fff : e6c30000.can can@e6c30000
e6c38000-e6c38fff : e6c38000.can can@e6c38000
e6e30000-e6e30007 : e6e30000.pwm pwm@e6e30000
e6e88000-e6e8803f : e6e88000.serial
e7300000-e730ffff : e7300000.dma-controller dma-controller@e7300000
e7310000-e731ffff : e7310000.dma-controller dma-controller@e7310000
ec500000-ec500fff : ec500000.sound scu
ec540000-ec540fff : ec500000.sound ssiu
ec541000-ec54127f : ec500000.sound ssi
ec5a0000-ec5a00ff : ec500000.sound adg
ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
ec760000-ec7601ff : ec500000.sound audmapp
ee020000-ee0203ff : ee020000.usb usb@ee020000
ee080000-ee0800ff : ee080000.usb usb@ee080000
ee080100-ee0801ff : ee080100.usb usb@ee080100
ee080200-ee0808ff : ee080200.usb-phy usb-phy@ee080200
ee0a0000-ee0a00ff : ee0a0000.usb usb@ee0a0000
ee0a0100-ee0a01ff : ee0a0100.usb usb@ee0a0100
ee0a0200-ee0a08ff : ee0a0200.usb-phy usb-phy@ee0a0200
ee100000-ee101fff : ee100000.mmc mmc@ee100000
ee140000-ee141fff : ee140000.mmc mmc@ee140000
ee160000-ee161fff : ee160000.mmc mmc@ee160000
fe000000-fe07ffff : fe000000.pcie-ep apb-base
fe100000-fe1fffff : =EF=BF=BD=EF=BF=BD
fe200000-fe3fffff : =EF=BF=BD=EF=BF=BD
fe940000-fe9423ff : fe940000.fdp1 fdp1@fe940000
fe960000-fe967fff : fe960000.vsp vsp@fe960000
fe9a0000-fe9a7fff : fe9a0000.vsp vsp@fe9a0000
fea20000-fea24fff : fea20000.vsp vsp@fea20000
fea28000-fea2cfff : fea28000.vsp vsp@fea28000
fea30000-fea34fff : fea30000.vsp vsp@fea30000
fead0000-feadffff : fead0000.hdmi hdmi@fead0000
feb00000-feb6ffff : feb00000.display display@feb00000
600000000-67fffffff : System RAM
  67b140000-67f5fffff : reserved
  67f64d000-67f64dfff : reserved
  67f64e000-67f6ddfff : reserved
  67f6df000-67f6e2fff : reserved
  67f6e3000-67f7e6fff : reserved
  67f7e7000-67f843fff : reserved
  67f844000-67fffffff : reserved

With the patch applied:

$ cat /proc/iomem
30000000-37ffffff : memory2
38000000-3fffffff : memory3
48000000-bfffffff : System RAM
  48210000-496affff : Kernel code
  496b0000-4987ffff : reserved
  49880000-49a8ffff : Kernel data
  b9eca000-b9ed8fff : reserved
  ba000000-bfffffff : reserved
e6020000-e602000b : e6020000.watchdog watchdog@e6020000
e6050000-e605004f : e6050000.gpio gpio@e6050000
e6051000-e605104f : e6051000.gpio gpio@e6051000
e6052000-e605204f : e6052000.gpio gpio@e6052000
e6053000-e605304f : e6053000.gpio gpio@e6053000
e6054000-e605404f : e6054000.gpio gpio@e6054000
e6055000-e605504f : e6055000.gpio gpio@e6055000
e6055400-e605544f : e6055400.gpio gpio@e6055400
e6055800-e605584f : e6055800.gpio gpio@e6055800
e6060000-e606050b : e6060000.pinctrl pinctrl@e6060000
e6198000-e61980ff : e6198000.thermal thermal@e6198000
e61a0000-e61a00ff : e6198000.thermal thermal@e6198000
e61a8000-e61a80ff : e6198000.thermal thermal@e6198000
e61c0000-e61c01ff : e61c0000.interrupt-controller interrupt-controller@e61c=
0000
e6510000-e651003f : e6510000.i2c i2c@e6510000
e6540000-e654005f : e6540000.serial
e6590000-e65901ff : e6590000.usb usb@e6590000
e65a0000-e65a00ff : e65a0000.dma-controller dma-controller@e65a0000
e65b0000-e65b00ff : e65b0000.dma-controller dma-controller@e65b0000
e65ee000-e65ee08f : e65ee000.usb-phy usb-phy@e65ee000
e66d8000-e66d803f : e66d8000.i2c i2c@e66d8000
e6700000-e670ffff : e6700000.dma-controller dma-controller@e6700000
e6800000-e68007ff : e6800000.ethernet ethernet@e6800000
e6c30000-e6c30fff : e6c30000.can can@e6c30000
e6c38000-e6c38fff : e6c38000.can can@e6c38000
e6e30000-e6e30007 : e6e30000.pwm pwm@e6e30000
e6e88000-e6e8803f : e6e88000.serial
e7300000-e730ffff : e7300000.dma-controller dma-controller@e7300000
e7310000-e731ffff : e7310000.dma-controller dma-controller@e7310000
ec500000-ec500fff : ec500000.sound scu
ec540000-ec540fff : ec500000.sound ssiu
ec541000-ec54127f : ec500000.sound ssi
ec5a0000-ec5a00ff : ec500000.sound adg
ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
ec760000-ec7601ff : ec500000.sound audmapp
ee020000-ee0203ff : ee020000.usb usb@ee020000
ee080000-ee0800ff : ee080000.usb usb@ee080000
ee080100-ee0801ff : ee080100.usb usb@ee080100
ee080200-ee0808ff : ee080200.usb-phy usb-phy@ee080200
ee0a0000-ee0a00ff : ee0a0000.usb usb@ee0a0000
ee0a0100-ee0a01ff : ee0a0100.usb usb@ee0a0100
ee0a0200-ee0a08ff : ee0a0200.usb-phy usb-phy@ee0a0200
ee100000-ee101fff : ee100000.mmc mmc@ee100000
ee140000-ee141fff : ee140000.mmc mmc@ee140000
ee160000-ee161fff : ee160000.mmc mmc@ee160000
fe000000-fe07ffff : fe000000.pcie-ep apb-base
fe100000-fe1fffff : memory0
fe200000-fe3fffff : memory1
fe940000-fe9423ff : fe940000.fdp1 fdp1@fe940000
fe960000-fe967fff : fe960000.vsp vsp@fe960000
fe9a0000-fe9a7fff : fe9a0000.vsp vsp@fe9a0000
fea20000-fea24fff : fea20000.vsp vsp@fea20000
fea28000-fea2cfff : fea28000.vsp vsp@fea28000
fea30000-fea34fff : fea30000.vsp vsp@fea30000
fead0000-feadffff : fead0000.hdmi hdmi@fead0000
feb00000-feb6ffff : feb00000.display display@feb00000
600000000-67fffffff : System RAM
  67b140000-67f5fffff : reserved
  67f64d000-67f64dfff : reserved
  67f64e000-67f6ddfff : reserved
  67f6df000-67f6e2fff : reserved
  67f6e3000-67f7e6fff : reserved
  67f7e7000-67f843fff : reserved
  67f844000-67fffffff : reserved

Cheers,
Prabhakar

