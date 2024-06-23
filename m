Return-Path: <linux-pci+bounces-9156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256C913C4D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C740B22BEA
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21013181BBE;
	Sun, 23 Jun 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ban/izBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFF144317;
	Sun, 23 Jun 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156376; cv=none; b=qmQcPlR70QNnEwqXLab3DjCCAVuU/JQ/lQAeVspjoXK6KbPTln0QFu3pJpDb89PTkLn59eejFBP15KEPM0jciH1JkCD3sQDx1GMLazZgjkj+npCex+dMH78J3OS22fmsgmmYDvPr8VN+ciID7PxhKdmQ3EdiL4bOQ9qVizYpPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156376; c=relaxed/simple;
	bh=DY6uM7OX57kgmjD4vL9DUxcQqMOpVRETNce3hEurQL0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e/27yQawWcQSY7vYTHG8W7fC9f8MiDZpCcitGMCWw7TamsZfG/SJZrHpWK8cQb2D/wcNhUX4tT/4xsOobfPMHTeANvs+2nWu1UBN46Q4eAKTWhCsZm0X0aqwX4cU4yGKxaY7uSAK3VwSekqytUbjfZWq3IkDbRze3D+nDU2TOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ban/izBq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719156374; x=1750692374;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DY6uM7OX57kgmjD4vL9DUxcQqMOpVRETNce3hEurQL0=;
  b=ban/izBqU1WGlUVv5OKEDh3IUlLJUY6PeDYQCD1l/sLvkJdY6RUVN1oX
   d9uwNgyfCRvmYtsxSb8ok2i3RF69zOff5GX3sUKukkSkH+Ierh04i5jTe
   SE+TNU0DgOEUr72pYNOIv6J1Nt7+wPyEFPIihs8mng6dEz9X22gBFXNdh
   n6KSg2+fYBiae75GxPwGzkUeLILjCneih1V+GruCjwLxFLlnJ/CZm1YPJ
   MROkDyOuC4qZQFkiR9vOTwXmXhWmwFiqvj06QisoWj3coEcBXUErizV+U
   QIogFMT990s3wQnwOjAdQyqzlxZqEJ9ZXFlBX7jT/W823NqWcYE1cgKRu
   Q==;
X-CSE-ConnectionGUID: 9hNzcwkySmGnoTkX1MS/Dw==
X-CSE-MsgGUID: VNNNzUW/Snm/qAcdENwsSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="19905324"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="19905324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 08:26:14 -0700
X-CSE-ConnectionGUID: VkPUhKB7RnCb+xtzdVVDkQ==
X-CSE-MsgGUID: PIsxdQ11TdirC6xbtvNH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="80588234"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 08:26:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 23 Jun 2024 18:26:03 +0300 (EEST)
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
cc: Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org, 
    bmasney@redhat.com, djakov@kernel.org, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, vireshk@kernel.org, quic_vbadigan@quicinc.com, 
    quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, 
    quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v14 3/4] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
In-Reply-To: <3ed39bb0-f1bb-6973-21e5-aaa34db8013e@quicinc.com>
Message-ID: <e501971f-e9e1-d87a-ca44-b2be61f79f3e@linux.intel.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com> <20240609-opp_support-v14-3-801cff862b5a@quicinc.com> <c76624fa-1c07-1bb4-dff0-e35fe072f176@linux.intel.com> <3ed39bb0-f1bb-6973-21e5-aaa34db8013e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-556282923-1719156363=:1423"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-556282923-1719156363=:1423
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Jun 2024, Krishna Chaitanya Chundru wrote:

>=20
>=20
> On 6/14/2024 6:02 PM, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:
> >=20
> > > Bring the switch case in pcie_link_speed_mbps() to new function to
> > > the header file so that it can be used in other places like
> > > in controller driver.
> > >=20
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >   drivers/pci/pci.c | 19 +------------------
> > >   drivers/pci/pci.h | 22 ++++++++++++++++++++++
> > >   2 files changed, 23 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index d2c388761ba9..6e50fa89b913 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6027,24 +6027,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
> > >   =09if (err)
> > >   =09=09return err;
> > >   -=09switch (to_pcie_link_speed(lnksta)) {
> > > -=09case PCIE_SPEED_2_5GT:
> > > -=09=09return 2500;
> > > -=09case PCIE_SPEED_5_0GT:
> > > -=09=09return 5000;
> > > -=09case PCIE_SPEED_8_0GT:
> > > -=09=09return 8000;
> > > -=09case PCIE_SPEED_16_0GT:
> > > -=09=09return 16000;
> > > -=09case PCIE_SPEED_32_0GT:
> > > -=09=09return 32000;
> > > -=09case PCIE_SPEED_64_0GT:
> > > -=09=09return 64000;
> > > -=09default:
> > > -=09=09break;
> > > -=09}
> > > -
> > > -=09return -EINVAL;
> > > +=09return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));
> >=20
> > pcie_link_speed_mbps() calls pcie_link_speed_to_mbps(), seems quite
> > confusing to me. Perhaps renaming one to pcie_dev_speed_mbps() would he=
lp
> > against the almost identical naming.
> >=20
> > In general, I don't like moving that code into a header file, did you
> > check how large footprint the new function is (when it's not inlined)?
> >=20
> if we remove this patch we see difference of 8, I think it should be fine=
=2E
> with change
> aarch64-linux-gnu-size ../drivers/pci/pci.o
>    text    data     bss     dec     hex filename
>   41440    1334      64   42838    a756 ../kobj/drivers/pci/pci.o
> without the change
> text    data     bss     dec     hex filename
>   41432    1334      64   42830    a74e ../kobj/drivers/pci/pci.o

Thanks for checking it out, seems the inline here was a non-problem.

--=20
 i.

> > Unrelated to this patch, it would be nice if LNKSTA register read would
> > not be needed at all here but since cur_bus_speed is what it is current=
ly,
> > it's just wishful thinking.
> >=20
> > >   }
> > >   EXPORT_SYMBOL(pcie_link_speed_mbps);
> > >   diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 1b021579f26a..391a5cd388bd 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -333,6 +333,28 @@ void pci_bus_put(struct pci_bus *bus);
> > >   =09 (speed) =3D=3D PCIE_SPEED_2_5GT  ?  2500*8/10 : \
> > >   =09 0)
> > >   +static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed=
)
> > > +{
> > > +=09switch (speed) {
> > > +=09case PCIE_SPEED_2_5GT:
> > > +=09=09return 2500;
> > > +=09case PCIE_SPEED_5_0GT:
> > > +=09=09return 5000;
> > > +=09case PCIE_SPEED_8_0GT:
> > > +=09=09return 8000;
> > > +=09case PCIE_SPEED_16_0GT:
> > > +=09=09return 16000;
> > > +=09case PCIE_SPEED_32_0GT:
> > > +=09=09return 32000;
> > > +=09case PCIE_SPEED_64_0GT:
> > > +=09=09return 64000;
> > > +=09default:
> > > +=09=09break;
> > > +=09}
> > > +
> > > +=09return -EINVAL;
> > > +}
> >=20
> >=20
> >=20
>=20
--8323328-556282923-1719156363=:1423--

