Return-Path: <linux-pci+bounces-27837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D3AB96FA
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE4F5016AB
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023E22A4EF;
	Fri, 16 May 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fv2zWKYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316B22ACD3;
	Fri, 16 May 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382288; cv=none; b=pLNDoESj9s11ezXyOus7uF2dDOyD9533N9H7iD4sPjrd94ZLbg3Mqs8gXIpHB7+a5AXB2VWy51gLsz3CxCamoMBJRb/Up8ZJ/u6gcjK9wCKxD0AveCSW3r3I69qV/+UD2M1tQaW/J8P2zDn96mpfAUQcFdDzWXrTDQQ5BBPxFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382288; c=relaxed/simple;
	bh=KQzgvdfnxhFmKbgaGYV4sNqWFHEH1innGGJwJp7KDIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYPVDWUqJMA8aXu6AtrgVzHHP55vFBovJCzq+zayBnq6LrA1BZ+TyqVAXUfab2PGHJwOOrWhPbLouwZvcvz+sNDDuw+qc8W8e5ryG1TlHHQPYnE/kW6XVVJYAYPin2CEOC3XgjkZcp98ItiFrXZ1serM3LATzjQO98jwHBb2Nak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fv2zWKYn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZzK2l34QKz9sq3;
	Fri, 16 May 2025 09:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747381727; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNKQroZcyCu5Hf7yNgyeFiNusKguz3mFzcsyXu/Esv8=;
	b=fv2zWKYnimboxIx7CSjtJkLgAYLzafYZQdAGoeB0Y7E4YhI7oN5gylgLCCKI8EhFG9DDuC
	SwLivhT/bAUGLTCfTn+GatbiycJjUImNpuQ+m2nPKneRZEcRqhxHWBMDeUag1FpLb/Bv20
	G8u6qs9H6xeTwozzmrc1AR/ODRqIxVaZZ8OmGl8q2c5lsJ8JQi5h3wbzCDykjDwreOTkLP
	MijZXrgvapDnlTpmgyYkd84hJmgGItWQiXY76mm17J1FKoY9oqYYdRTZLz84aXzvm818Q6
	6x5E9lJQnmiZ4WOPczxFVUOuZTcAOaEEF3lcOlmX2m9dStkRPLlaEOe/fNIaBw==
Message-ID: <4592c50fd3168eb3319f4b24cb072e8d8357562d.camel@mailbox.org>
Subject: Re: [PATCH 4/7] PCI: Remove request_flags relict from devres
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>,  Yang Yingliang
 <yangyingliang@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Fri, 16 May 2025 09:48:42 +0200
In-Reply-To: <aCXlWoPm2XVA5m7M@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
	 <20250515124604.184313-6-phasta@kernel.org>
	 <aCXlWoPm2XVA5m7M@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 1fftmgenrs6wkrfi1wuig4pbwnnuxmua
X-MBO-RS-ID: aabbcd1ec9dfca90bf6

On Thu, 2025-05-15 at 16:00 +0300, Andy Shevchenko wrote:
> On Thu, May 15, 2025 at 02:46:02PM +0200, Philipp Stanner wrote:
> > pcim_request_region_exclusive(), the only user in PCI devres that
> > needed
> > exclusive region requests, has been removed.
> >=20
> > All features related to exclusive requests can, therefore, be
> > removed,
> > too. Remove them.
>=20
> ...
>=20
> > =C2=A0int pcim_request_region(struct pci_dev *pdev, int bar, const char
> > *name)
> > =C2=A0{
> > -	return _pcim_request_region(pdev, bar, name, 0);
> > +	int ret;
> > +	struct pcim_addr_devres *res;
> > +
> > +	if (!pci_bar_index_is_valid(bar))
> > +		return -EINVAL;
> > +
> > +	res =3D pcim_addr_devres_alloc(pdev);
> > +	if (!res)
> > +		return -ENOMEM;
> > +	res->type =3D PCIM_ADDR_DEVRES_TYPE_REGION;
> > +	res->bar =3D bar;
> > +
> > +	ret =3D __pcim_request_region(pdev, bar, name, 0);
>=20
> > +	if (ret !=3D 0) {
>=20
> While at it, drop the=C2=A0 ' !=3D 0' part?

I want it to be clear to be just a pure code move. It's a shame that
the git-diff can't just handle that through the function head,
resulting in a +/-2 diff

Style adjustments, which might also be necessary in pci.c in many
places, could be done through dedicated commits.

P.

>=20
> > +		pcim_addr_devres_free(res);
> > +		return ret;
> > +	}
> > +
> > +	devres_add(&pdev->dev, res);
> > +	return 0;
> > =C2=A0}
>=20


