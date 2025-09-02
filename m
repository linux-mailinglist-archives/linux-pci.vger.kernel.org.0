Return-Path: <linux-pci+bounces-35315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1767B3F9E4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD8203487
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3432EA482;
	Tue,  2 Sep 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h51pyqSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80912580CF
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804193; cv=none; b=lrKUGzFkt22POkJCvHkpvsL1iBTba4Hp1OYYCp1AfrVYB3CbyVH2/aW1hF3DXKcpO3hqxqyjEZbyVWE+Y8Yqgvq29CU2feCzkx4jaJcJIzaHvlCW0JM9AyYRwscCXcNPq4XHUxpCcNnc9PZDCa3xTfEqZSGfbPNACPZwLeMU4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804193; c=relaxed/simple;
	bh=A8eyEfj3BP3VmKLPbiefQOv3kForpLTfoyzNz1iTBI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN0FWgF6ud7T9BdZlL0enNsW7vVRsPy5tI8GSD1WnEk9jsDoTmZhWUb4DMsi2ejJAMO67epdDKn7JleWqskKuD7rpQugdfMDy4xl56TlMDAp7h7QGV8PFBs1GoRwNrgqRmJtZAYhOwU5SC7k5dAI2U8Pe1E8MqMnGEbzx3wszUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h51pyqSW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3dae49b1293so202220f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Sep 2025 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756804189; x=1757408989; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bw74ZDWYln3R5EhzIwK/dVcSfr5R7Z8FO22rXgIrEXw=;
        b=h51pyqSWiwtgflJSplJzl/iUlW4iDx/e2JTWmW0GolDn/SsBlNWvrEczOHxaLp/cOM
         /MovHLU0mPDro3pzKibG96WNguelkR+yOJ3/T/PtKb2iXsykZkzmSPeY1l6AmAwKiJKc
         OWKRb+lJtdybwXl1ZfkIEBypsYe3IagXV0pMDZcP1d106Tve3JuvhmnmANjYRVEwfQa/
         wrgfoCJ+G+PyWWVfwjhaV+EQPgtBB3DhMtgyHtmlaFuqbs5pr/Lbmhqnn2P2Ddamb100
         AjMHafIcAyZ8NLh7nA2LE4Ahie6/uZKOES1DXS17YT/woUh3rz/FG3sEo5MQ/wBqgFsy
         0qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804189; x=1757408989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bw74ZDWYln3R5EhzIwK/dVcSfr5R7Z8FO22rXgIrEXw=;
        b=j5o5NdONjAbv31f7RNC4DPgepZO/1GY3ZqVhjedTHsvEe8EgNDfZqG2iKyN1Y9JofE
         i+CNp52mOtx86/PIPMu7xInx56IzsjBgb7VkEC7lJndIkTDi7jrlla2oKET8yiQxJb82
         gHo1+B218gkwr9QHgZilVe5OvplexJb4bSx+Rowg4cWHwrCR5jCDVnlN/ql9fmGKWStw
         xuULQclXyajAMhFiLnfY5ZuLsD292cNKprZSahFiOY3eQLWo6VCgXM+RTnccLhW3xpTb
         2rS110K6oSa8fl2iJ7H6d3WW8VUx09kgN1cbXJ6/soij6o4ZXMVsCM6gSoz9Y6i7wqYi
         ZGYA==
X-Forwarded-Encrypted: i=1; AJvYcCVanN2mHEg//DoQvV1yxB0SPWPj5EoalrX58LE9Af2O2YQBalj9QX1UEq2cR0ayvwS2kJaJihjyiiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIh2zbsdGaKwWvGD9HE+er2Ik5YkU5TYrWj6yY8nlsnifXElCT
	lmb1+GWZ4lCHs3X0DofQ5PHj2wjCkCH4ALcb/DizSIVIEO50PcTI/5rs
X-Gm-Gg: ASbGncvCy8RMC0IydIkixzugcEOJYpdrxUpS4uNrVNBMIIGBCYotsB1rr8fa+ofMwNm
	ndGy4JzxUkNxK7ZuFQurHtlqqLLpgnHPRd1zmcTsnxWx72jt0oKQPvQvWUPEyengN+3PtnP/Xas
	dzHHcX5BWMN4aBC+VjNPO6YIReQKvZDEuy9nkD/fbcLgX6VpmLuYDAXfMtf9FGaIM4kzv5T4xDl
	gQDako/o+YhBt4b9heTAzCViUvg/mHoCs1wdG3pzKjEpXmDifCrtZzQ+EH/2u3Q4/f6I7k8D/5y
	DvwECvNxyI1Wcvnkb/T9bt+b0ydJYTWC2kYhI6bRmSWpWAr7zKdY+aukmAW5MwFQRzX+33gjxRa
	iUIbMnwPbHI6qb6KjnOLXSUXCJRQ7rtVt5cVm4PF4+JhcfS4FyH8PmGBsGOsVgZz3OH1jIA==
X-Google-Smtp-Source: AGHT+IHNGi1WlUp37oda1jCD0mIQM+pwLYeo9d0bEci6H/DuqNOy5AfU0gRE95Kv3q/RMJ5wltAJRg==
X-Received: by 2002:a05:6000:2586:b0:3cd:c10d:3b6b with SMTP id ffacd0b85a97d-3d1de4b9891mr7783573f8f.27.1756804188869;
        Tue, 02 Sep 2025 02:09:48 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:3f02:d36b:e22e:74c6? ([2a02:168:6806:0:3f02:d36b:e22e:74c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add294sm20017536f8f.29.2025.09.02.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:09:48 -0700 (PDT)
Message-ID: <1cc6781ea584aa00a8cda23db1fc8cd59f852a3d.camel@gmail.com>
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Jan Palus <jpalus@fastmail.com>, Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, Pali =?ISO-8859-1?Q?Roh=E1r?=
 <pali@kernel.org>, 	linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, 	regressions@lists.linux.dev
Date: Tue, 02 Sep 2025 11:09:47 +0200
In-Reply-To: <42rznc7krv3gdwmdzfz6o5nalnzleiwfg44yleqjet67cu4ijm@pwap3ph2n2u7>
References: <bug-220479-41252@https.bugzilla.kernel.org/>
	 <20250820184603.GA633069@bhelgaas>
	 <42rznc7krv3gdwmdzfz6o5nalnzleiwfg44yleqjet67cu4ijm@pwap3ph2n2u7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+b1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-21 at 02:45 +0200, Jan Palus wrote:
>=20
> Relevant fragment of mvebu_get_tgt_attr() in mentioned commit:
>=20
> +		u32 slot =3D upper_32_bits(range.bus_addr);
> =C2=A0
> -		if (DT_FLAGS_TO_TYPE(flags) =3D=3D DT_TYPE_IO)
> +		if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_IO)
> =C2=A0			rtype =3D IORESOURCE_IO;
> -		else if (DT_FLAGS_TO_TYPE(flags) =3D=3D DT_TYPE_MEM32)
> +		else if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_MEM32)
> =C2=A0			rtype =3D IORESOURCE_MEM;
> =C2=A0		else
> =C2=A0			continue;
> =C2=A0
> =C2=A0		if (slot =3D=3D PCI_SLOT(devfn) && type =3D=3D rtype) {
>=20

As far as I understand the situation, of_pci_range_parser_one() inherently =
uses bus->get_flags()
aka of_bus_pci_get_flags() to determine range.flags (see drivers/of/address=
.c).

And of_bus_pci_get_flags() does essentially the same thing as the code abov=
e in mvebu_get_tgt_attr().
So, now the translation logic is applied twice - which probably was not int=
ended.

To restore the original behaviour, I think the determination of rtype from =
range.flags must be=C2=A0
completely removed, and rtype must be replaced by range.flags.

Something like this on top of mainline - completely untested, but maybe wor=
th a try.

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pc=
i-mvebu.c
index 755651f338..3fce4a2b63 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1168,9 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct =
platform_device *pdev,
        return devm_ioremap_resource(&pdev->dev, &port->regs);
 }
=20
-#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
-#define    DT_TYPE_IO                 0x1
-#define    DT_TYPE_MEM32              0x2
 #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
 #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
=20
@@ -1189,17 +1186,9 @@ static int mvebu_get_tgt_attr(struct device_node *np=
, int devfn,
                return -EINVAL;
=20
        for_each_of_range(&parser, &range) {
-               unsigned long rtype;
                u32 slot =3D upper_32_bits(range.bus_addr);
=20
-               if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_IO)
-                       rtype =3D IORESOURCE_IO;
-               else if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_MEM32=
)
-                       rtype =3D IORESOURCE_MEM;
-               else
-                       continue;
-
-               if (slot =3D=3D PCI_SLOT(devfn) && type =3D=3D rtype) {
+               if (slot =3D=3D PCI_SLOT(devfn) && type =3D=3D range.flags)=
 {
                        *tgt =3D DT_CPUADDR_TO_TARGET(range.cpu_addr);
                        *attr =3D DT_CPUADDR_TO_ATTR(range.cpu_addr);
                        return 0;



