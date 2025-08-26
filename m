Return-Path: <linux-pci+bounces-34762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2494B36DA3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A267A8D6A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830626F46E;
	Tue, 26 Aug 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Cmki5lHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607E2741D1
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221795; cv=none; b=b0eXM/4t+c/WzFWEa11qSqRfwdt7Dd9Bb820SdOhIS6Vs2zc1oxp+sEISre9USx2qKnBwd8kcZNck71cg3SMTlpyOjwN7FCf9JGfX3RwIUNgLC1wrVUeBVaaYmXMeHOo2TDdKCMGm/CJRp5fr0mYQOU3onFT81ilg2c8fz87ocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221795; c=relaxed/simple;
	bh=aZKtwQOmcc2qN/pwCBkZCaBz5G9Qh63XuyUppp9STWo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amMi2Uo3RekXqeM7DU3ipiQwGY0qD3DXDUrFSXlGM9edPgsqu3wglprkwVPwib+ifx4K6glZknwtryuIvj9AEdLdRC0ME74YdBv6ywmR8irQKqRWYMaPQIlVu96zYxsMvcEXD+9oxmyzYie5z/ZPXd5bmm8sxZgc8/bbwNSqzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Cmki5lHO; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail3; t=1756221789; x=1756480989;
	bh=aZKtwQOmcc2qN/pwCBkZCaBz5G9Qh63XuyUppp9STWo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Cmki5lHOGwN2aoLvumRb60R4amX8PPEoATxnRo3mmsLA0fNsbHNQI05VgJ2qB5hjs
	 Uqx/dNibAChyZnbHiQe5DYkXtOuDnuSdVC+MegihJCVemD3DC4qxUk93HOso0iLAeV
	 5NNtnjU1WW7980yCDDDtFuLK7WVGsQ499k5gBChFLyzgSS9l5Jv99sszcPZv6xvRNA
	 cnYNAKVYEzPqv6qcyh6CqMk5SZ0d2Xd85NwKY4GnzjYqCpSSV5kzmePZ0Xr3AqEiRA
	 VBeZnUU+5Gt43FVJLHNVSyXuKLvZpy3XYJKxYqREd1h/6W0CjhaQrNRJIgfHbEUk93
	 ukcqFbIiTs7Mw==
Date: Tue, 26 Aug 2025 15:23:05 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, D Scott Phillips <scott@os.amperecomputing.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Markus Elfring <Markus.Elfring@web.de>, linux-kernel@vger.kernel.org, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 0/3] PCI: Resource fitting algorith fixes
Message-ID: <kkLqpZHhRDV1br6t0vgaBpHfeQ5TW35Cq28vSxIeSn4JoqkRonRLXLzgPm3UJ_OFiNNDA9GK56vir_5UJj97M6kSRGiDn1Meeug_P-vKxG8=@r26.me>
In-Reply-To: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
References: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: afd556c8e8ac7154d6f866b5d30bb33c19f227ba
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Friday, August 22nd, 2025 at AM 8:34, Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:

>=20
> Once Rio has tested the first patch, these should replace the v2
> patches in the pci/resource branch.
>=20

Hello Ilpo,

I've just applied PATCH v3 1/3 on the v6.17-rc1 mainline (commit 8f5ae30d69=
d7543eee0d70083daf4de8fe15d585) and tested it, looks like it still works! T=
hanks again for your work.

Rio

