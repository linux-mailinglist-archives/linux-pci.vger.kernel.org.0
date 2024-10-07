Return-Path: <linux-pci+bounces-13974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFB99338A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBFF285B9E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A31DBB16;
	Mon,  7 Oct 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="kM1/1/Sl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4101D9321;
	Mon,  7 Oct 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318985; cv=none; b=cnhp9pW9FToX29amlJjh8hLKYjqSe6rU9aylvsUJzQ7D2WSm3vaSIQ3A32n2IlRTCfQlBpT6UxdBONTy4HI2Uv3yhvG+Byl3DTc9rdQPo1CC/DmcIR9nljYEyBZ76AruRAe3tfCaurdhY7QP3c83bdM/diCMeBgwzSlvFJ3Wd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318985; c=relaxed/simple;
	bh=7TOE9NeqioqCUACWEMJrQIzAP0w3FqBCW3WN8nJoU1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TclCenohps3VYYKBsEZcnV9RrLOLCfgJQU7wPEmw5pyMdpTd3HQvPa+LHYikijxiX7wO2AvWaaPY5MUzO0VZFlVanKBYg8pmsNbwCn67hdwqTTwI7eLrjK0tAVpJktIgfsHOiUzlvCMpHG7XzyHM6al4QxFQDC9FXmvQFAHMY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=kM1/1/Sl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XMlCH5KQTz9tGd;
	Mon,  7 Oct 2024 18:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1728318971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgLPv7uERTkbMvbht7gCy9ZDJZFZ/eWPvmA0Pw8Yh+o=;
	b=kM1/1/Slm05feSR/aJjRCd0NidpPBiN4LaEhiYnq01WOgl6yhlRPP8Sitmd1PQkwfw2opi
	PHdsyHsiZsbDeAOTuoIxsld8PGOm2J/rDulF0c7/SNOgflWWfkuIzPtsFZVSHk5HOLzEuA
	KOZnyi4j3ZHZzdGE1UZR2arhcKJaeVP1OxiX41emyb+WAZBeP0+yqCGRUU5xJRJJYF47Vp
	G8LsDSTyi+ZBxM1+9KKauEbhiKO9XPRZV0dXOX2w0QAIMCfpH9/Z5zRzCIVg+cyLZ4c0vi
	w0dZA1aWZ/A1k3Mz64wInZPqFhhV6dP8pCE1WIGUzaR7cBhV1E8N2MJ45nQBLA==
Message-ID: <1224f317cb45fcc5117a7d8dbd19142b0916559a.camel@dirkwinkel.cc>
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
From: Steffen Dirkwinkel <me@steffen.cc>
To: Jason Gunthorpe <jgg@nvidia.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com, 
	galshalom@nvidia.com, leonro@nvidia.com, treding@nvidia.com,
 jonathanh@nvidia.com, 	mmoshrefjava@nvidia.com, shahafs@nvidia.com,
 vsethi@nvidia.com, 	sdonthineni@nvidia.com, jan@nvidia.com,
 tdave@nvidia.com, 	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kthota@nvidia.com, mmaddireddy@nvidia.com, 
	sagar.tv@gmail.com, vliaskovitis@suse.com
Date: Mon, 07 Oct 2024 18:36:03 +0200
In-Reply-To: <20241001193300.GJ1365916@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
	 <20240625153150.159310-1-vidyas@nvidia.com>
	 <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
	 <3cbd6ddb-1984-4055-9d29-297b4633fc41@kernel.org>
	 <b8fa3062-48ec-4de7-b314-2ff959775ecc@kernel.org>
	 <20241001193300.GJ1365916@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 16:33 -0300, Jason Gunthorpe wrote:
> On Wed, Sep 25, 2024 at 07:49:59AM +0200, Jiri Slaby wrote:
> > On 25. 09. 24, 7:29, Jiri Slaby wrote:
> > > On 25. 09. 24, 7:06, Jiri Slaby wrote:
> > > > > @@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct
> > > > > pci_dev *dev)
> > > > > =C2=A0=C2=A0 */
> > > > > =C2=A0 static void pci_enable_acs(struct pci_dev *dev)
> > > > > =C2=A0 {
> > > > > -=C2=A0=C2=A0=C2=A0 if (!pci_acs_enable)
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable_acs_redi=
r;
> > > > > +=C2=A0=C2=A0=C2=A0 struct pci_acs caps;
> > > > > +=C2=A0=C2=A0=C2=A0 int pos;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0 pos =3D dev->acs_cap;
> > > > > +=C2=A0=C2=A0=C2=A0 if (!pos)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > Ignore the previous post.
> >=20
> > The bridge has no ACS (see lspci below). So it used to be enabled
> > by
> > pci_quirk_enable_intel_pch_acs() by another registers.=20
>=20
> Er, Ok, so it overrides the whole thing with
> pci_dev_specific_acs_enabled() too..
>=20
> > I am not sure how to fix this as we cannot have "caps" from these
> > quirks, so
> > that whole idea of __pci_config_acs() is nonworking for these
> > quirks.
>=20
> We just need to allow the quirk to run before we try to do anything
> with the cap, which has probably always been a NOP anyhow.
>=20
> Maybe like this?
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2ae..225a6cd2e9ca3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1067,8 +1067,15 @@ static void pci_std_enable_acs(struct pci_dev
> *dev, struct pci_acs *caps)
> =C2=A0static void pci_enable_acs(struct pci_dev *dev)
> =C2=A0{
> =C2=A0	struct pci_acs caps;
> +	bool enable_acs =3D false;
> =C2=A0	int pos;
> =C2=A0
> +	/* If an iommu is present we start with kernel default caps
> */
> +	if (pci_acs_enable) {
> +		if (pci_dev_specific_enable_acs(dev))
> +			enable_acs =3D true;
> +	}
> +
> =C2=A0	pos =3D dev->acs_cap;
> =C2=A0	if (!pos)
> =C2=A0		return;
> @@ -1077,11 +1084,8 @@ static void pci_enable_acs(struct pci_dev
> *dev)
> =C2=A0	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
> =C2=A0	caps.fw_ctrl =3D caps.ctrl;
> =C2=A0
> -	/* If an iommu is present we start with kernel default caps
> */
> -	if (pci_acs_enable) {
> -		if (pci_dev_specific_enable_acs(dev))
> -			pci_std_enable_acs(dev, &caps);
> -	}
> +	if (enable_acs)
> +		pci_std_enable_acs(dev, &caps);
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Always apply caps from the command line, even if there is
> no iommu.

Hi,

I just ran into this issue (fewer iommu groups starting with 6.11).
Both reverting the original patch or applying your suggestion worked
for me.

Thanks
Steffen



