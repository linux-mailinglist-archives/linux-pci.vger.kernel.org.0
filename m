Return-Path: <linux-pci+bounces-27865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5051AB9DCD
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A62EA25B68
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8E136347;
	Fri, 16 May 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="js0vpAik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF986359;
	Fri, 16 May 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402910; cv=none; b=VDmZQoWuPQGv/Z7ZezKuIuRd9dilTjzCNVwGRJTlvtEw8uXXNNLX5XXnAIqSfMRryMeyKNb7BzEBr2CcScuKZ69BqwIJkzUZcPzE2I+YzmQIOIdyksTevpUGNTMFs6gFqT72558ffGtSKarGX0SVQm9oJEJp4Xlzpq7ZAkMeu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402910; c=relaxed/simple;
	bh=wboZxG+BLzGR4A3/GecZNi3TVm5ivbtMYnHakmMe2Ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ec+l86qFCk00VhZmRrzL0REMZSXVU0znccC0quwbGSn9ZavRF2A3K0JhLOQe2zFkS5jnO05ooEld+dZT26Sf7HrqO0HGSyiZrD+VKrgOQHDroxZ1jz+gOAI0fHwps8Wzi6pCWyyILC6sVV1znA5NdQ2VvW7lY6PdwbsfUJ4IRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=js0vpAik; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZzSss1H1Dz9sdZ;
	Fri, 16 May 2025 15:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747402897; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ia2Eegf3qOnKudIjBxBxyA+vlPkM/9TKw5w6lDNIqB0=;
	b=js0vpAik6mTG8mOLxEV97pHsQdDe6ANbg9iZwifYwGNUFuKDriBXFPA/HpdTQDYwebNWxt
	N2C4aCKyJxlDCLKQN4Dya/+HDrQjT2UIVoxHfXXzxBc+9b6pbhdy+9LTZ+0mkILm1NJAjO
	BsPQtxTtjFLE4Pa4pGnT2dwMRyBH4VMqzTyLsN14VNLPpiJ851GrPGRKX8NwURzuYUyxVM
	OQUax4xNiHyNSCLPqflEv39aik5lQdfyDfmrymfqiJkWsG6a903TRO02pcU3LFQnFpOrQ8
	gTR9/Jh71Q1WBrWOpQimvJ84J4v+p4evwe2aMCIJYlBVL/pJ9XBgjbHZkg3yEg==
Message-ID: <2e80298be4bcb6b17f5b38302d6945306928c6b0.camel@mailbox.org>
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, phasta@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown
 <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Zijun Hu
 <quic_zijuhu@quicinc.com>, Yang Yingliang <yangyingliang@huawei.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Fri, 16 May 2025 15:41:31 +0200
In-Reply-To: <20250516132811.GB2390647@rocinante>
References: <20250515124604.184313-2-phasta@kernel.org>
	 <20250515124604.184313-4-phasta@kernel.org>
	 <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
	 <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>
	 <20250516132811.GB2390647@rocinante>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: jy1y4isir3bzyi94j7jfw1swzmd487ah
X-MBO-RS-ID: 9e8546bf8c66fab53ff

On Fri, 2025-05-16 at 22:28 +0900, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
> [...]
> > > > pcim_enable_device() is not related anymore to switching the
> > > > mode
> > > > of
> > > > operation of any functions. It merely sets up a devres callback
> > > > for
> > > > automatically disabling the PCI device on driver detach.
> > > >=20
> > > > Adjust the function's documentation.
> > >=20
> > > Is the "Docu" prefix in thew Subject aligned with the git history
> > > of
> > > this file?
> > >=20
> >=20
> > Seems its "Documentation: ". Can fix.
>=20
> Has Andy been sending his review off-list?=C2=A0 Or something is broken o=
n
> my
> side...

Nope, it's on-list. Andy's a veteran ;-)

https://lore.kernel.org/linux-pci/aCXnPHy5heHCKVd_@smile.fi.intel.com/


>=20
> Philipp, if you have a v2 ready, then I would love to pull it, while
> we
> await for more reviews, just to get enough soak time and allow for
> the
> 0-day and KernelCI to run their usual tests, etc.
>=20
> Thank you!

I don't have it ready, but should be trivial to do, since it's not
fundamental critcism. I'll do my best.

P.

>=20
> 	Krzysztof


