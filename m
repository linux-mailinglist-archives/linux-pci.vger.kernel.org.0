Return-Path: <linux-pci+bounces-3565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88B8575C5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 06:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E27B1C2272C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 05:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1913ADA;
	Fri, 16 Feb 2024 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FIk2/7ny"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD4134A4
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062873; cv=none; b=oi0maZ1fnYjP0TScO/Kw4GOUwixWkalOovryIfEeDRsSO9Iio2VgHWF/BxIZACttdavMXyyyhER8kKgW7IH/ho4Oj1//dcQmIlCTBvIjW3Dey+jnb6EANtHgmxupgmOurjsIMV0YSGDd8VMNUqSiVfzzIV2j3slGvDG1OL842X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062873; c=relaxed/simple;
	bh=q1gtVAj3lvEe8b98I0528UWfo/5v+mmHvNmP7iA02S0=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=qagfdlOUL6fSTnK4zsf2mT8ynAiKH3kiwKiN+38lPA1td8kPuOYhkfIRAbD4omKfcblPZ77tf4hOX9WQ+eXnRKlbDnLxpnt2O3MzW0Gudm3RwNUsQNVIhLU9gSNo2SAXqzf5VUMWKYbP43k3kAVkVJVVN+X9/uT9sOpOYEp7wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FIk2/7ny; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240216055428epoutp03e84016e89e1e20bad5ba2b9f6eba90e3~0QiEL-DfE2251322513epoutp03T
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 05:54:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240216055428epoutp03e84016e89e1e20bad5ba2b9f6eba90e3~0QiEL-DfE2251322513epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708062868;
	bh=q1gtVAj3lvEe8b98I0528UWfo/5v+mmHvNmP7iA02S0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=FIk2/7nyuWDMu3XQTesMOFOnCujZ5BveQZ5JTKA5lvjijnPI1i1au2OmHTqGrWORV
	 fc0+Kr5gqsKMgG+paStP78XKRs8qMtikRo0AK47f0zYA4maf5WCXp58/TBi9OYhQ36
	 ohNZEvynIRpZOBQWosfRr6lziRKUKmdLdhRcWNq8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240216055427epcas5p34f65ef318a454c13df99df12149e1aa7~0QiDdT30g0434004340epcas5p3V;
	Fri, 16 Feb 2024 05:54:27 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-38-65cef89375a1
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.F9.09672.398FEC56; Fri, 16 Feb 2024 14:54:27 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/2] ACPI: use %pe for better readability of errors
 while printing
Reply-To: onkarnath.1@samsung.com
Sender: Onkarnath <onkarnath.1@samsung.com>
From: Onkarnath <onkarnath.1@samsung.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "bristot@redhat.com"
	<bristot@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Rohit Thapliyal
	<r.thapliyal@samsung.com>, Maninder Singh <maninder1.s@samsung.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAJZ5v0gBrc0FctEswQj_JMcZRqoswRgXvBRzT++tseUWBgYJWA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240216054540epcms5p3b0b3f97fe4ec4a8126549a579e596910@epcms5p3>
Date: Fri, 16 Feb 2024 11:15:40 +0530
X-CMS-MailID: 20240216054540epcms5p3b0b3f97fe4ec4a8126549a579e596910
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmhu7kH+dSDVr3SlssacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJ4njvASaLjfeyLeZ+mcpssa/jAZPFxz0bGC06jnxjttj41cNi69Hv7A5iHmvm
	rWH0aNl3i91jwaZSj80rtDw2repk87hzbQ+bx7yTgR7v911l8+jbsorRY/Ppao/Pm+QCuKO4
	bFJSczLLUov07RK4Mra9ky+Yy10xu2caewPjR64uRk4OCQETiX/9C1m7GLk4hAR2M0qc7NjI
	1MXIwcErICjxd4cwSI2wQLTEtAuHmEFsIQFFif2LJ7JDxLUlDk64DRZnE9CU+LP8KVhcBCi+
	ZNFVsDizwDQOiebvZhC7eCVmtD9lgbClJbYv38oIYnMKBEp8m9cNFReVuLn6LTuM/f7YfEYI
	W0Si9d5ZZghbUOLBz92MMHPmfFjHCmEXS8w8cgqqpkbi/t25TBC2ucT6JavAZvIK+Eo83H2H
	HeRFFgFViQt/nCFKXCQeLj7CBHGytsSyha+ZQUqYgd5av0sfokRWYuqpdVAlfBK9v58wwXy1
	Yx6MrSrxa8pUuA/v/57LBmF7SHw4vpUdEspnGSVeXVvMOIFRYRYioGch2TwLYfMCRuZVjJKp
	BcW56anFpgXGeanlesWJucWleel6yfm5mxjBaVLLewfjowcf9A4xMnEwHmKU4GBWEuGd1Hsm
	VYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv69a5KUIC6YklqdmpqQWpRTBZJg5OqQYmQ8Pzn99e
	ebtc9MLOmD+/dpzzlbo+r888hpUhniln8SF7d96H3oa6O2d8WcfWdTKhJ2DJ1djJdgUHK765
	zFlz8edb45sZT55fdhC9cftHNFd/wm7H9Uw6Ns+Yn644FCZ9hd9Aa18j1zmhH886t0+aMzXR
	0eu4V9LTwyd8f3j6OKwxCd0sJd2m94uVefHNBKmZf8Qcas34hZy3b68Je+/9hK1vWsp7t/0/
	HwZ85bPj5rG+Z5e0Z9K2PYtnazGL33M96Z6/RnvtGaHbcx+xbWL1m9r6dopB4DRhzv0sVR0z
	jnHeW2N1e8ftmSUBipNj+Sce7V2isjC/tS3QTFH3drer++MlU5Xba5OlDpce4feuV2Ipzkg0
	1GIuKk4EAC5E5x4CBAAA
X-CMS-RootMailID: 20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8
References: <CAJZ5v0gBrc0FctEswQj_JMcZRqoswRgXvBRzT++tseUWBgYJWA@mail.gmail.com>
	<20240213074416.2169929-1-onkarnath.1@samsung.com>
	<CGME20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8@epcms5p3>

>On Tue, Feb 13, 2024 at 9:20=E2=80=AFAM=20Onkarnarth=20<onkarnath.1=40sams=
ung.com>=20wrote:=0D=0A>>=0D=0A>>=20From:=20Onkarnath=20<onkarnath.1=40sams=
ung.com>=0D=0A>>=0D=0A>>=20As=20%pe=20is=20already=20introduced,=20it's=20b=
etter=20to=20use=20it=20in=20place=20of=20(%ld)=20for=0D=0A>>=20printing=20=
errors=20in=20logs.=20It=20would=20enhance=20readability=20of=20logs.=0D=0A=
>>=0D=0A>>=20Signed-off-by:=20Maninder=20Singh=20<maninder1.s=40samsung.com=
>=0D=0A>=0D=0A>What=20exactly=20is=20the=20role=20of=20this=20S-o-b?=20=20H=
as=20the=20person=20helped=20you=20to=0D=0A>develop=20the=20patch=20or=20so=
mething=20else?=0D=0A>=0D=0A=0D=0AYes=20It=20was=20meant=20for=20Co-develop=
ed=20tag,=20Because=20We=20are=20working=20collectively=20for=20making=20er=
rors=20more=20readable=20for=20our=20product=20kernel.(5.4)=0D=0AAnd=20some=
=20part=20of=20this=20patch=20was=20made=20by=20him.=0D=0A=0D=0AThen=20we=
=20checked=20that=20it=20is=20also=20suggested=20by=20open=20source=20to=20=
have=20%pe=20for=20printing=20errors:=0D=0Ahttps://lore.kernel.org/all/9297=
2476-0b1f-4d0a-9951-af3fc8bc6e65=40suswa.mountain/=0D=0A=0D=0ASo=20I=20prep=
ared=20same=20changes=20for=20open=20source=20kernel,=20and=20because=20of=
=20smaller=20patch=20I=20kept=20it=20as=20normal=20signed-off=20tag=20only.=
=0D=0AIf=20it=20is=20needed=20I=20can=20resend=20with=20Co-developed=20tag.=
=0D=0A=0D=0AThanks,=0D=0AOnkarnath

