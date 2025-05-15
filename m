Return-Path: <linux-pci+bounces-27802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519AAB8839
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B161BC50E3
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F172634;
	Thu, 15 May 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p+83h6oP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B364A98;
	Thu, 15 May 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316242; cv=none; b=h9+dwYnobRgFpTpJ+/aOmU1T7LCyh74bRPhw0xswrjd+kizhPv2sGZssdlP4QESY4WwMXIerh3S4mxbUjYsezPaxh2saKF5k7TEIjFxZg4CHD5D8sEojxOMkbP9mRejNmrvgO5U8efG3yI7ieReFEAXTJHLwA1nlX9QhDIZRnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316242; c=relaxed/simple;
	bh=tRYLw6tBTvAhc6J6URyjrQDPh6UpNCTh6BvndupisvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eiNRzT/rS9ov4iuCfiBZsplWfExpnv3BJXYGMD/nkfSqxxvmO6iZvAzqUx2uDY6tcCe2TJGZLs9Y52SY1xtlOOzCCqwtI+XzonWnCm8dAloB4ENKKXYuyBA1BHI+4inq/ko/QJr4wsEygd3FJ99KouCTSLQh14QrPv+OtT3bnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=p+83h6oP; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZyrqB2szvz9st4;
	Thu, 15 May 2025 15:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747316230; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRYLw6tBTvAhc6J6URyjrQDPh6UpNCTh6BvndupisvQ=;
	b=p+83h6oP8n05gWvIrxLrvf/Vx7c7IO0T6BpuOE6OveQXll7sNsHd6uGiBmT9RNm29JeMz/
	0G2Ozr5ZVmvT/Ad7/GjjtL5PiJwXQUrvYAH7yTr8ZKw4qiX6TpH+vWaJ6h1IhHlkZJybEZ
	UHgmorSamGSBpRIaTX6ap6rJN/MM27pizkMryER1QiF+VW7ytKP0inDoXEyk7ID2Ga5emr
	MmJyzwBvghYadWic137i59KnkWHbrvQswNDXHmesVkT/V8s+Y+eA1BLVgy3NlgFyNjHwqJ
	qlkpn0ut3DtDWovLqVq5cmidkS4q1qTpvbcPm+d6ibbq+T3D1ERuYquiTQcQ8w==
Message-ID: <3f1140397e628cfdf4156f02f5454f844003dc6d.camel@mailbox.org>
Subject: Re: [PATCH 6/7] PCI: Remove unnecessary prototype from pci.h
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
Date: Thu, 15 May 2025 15:37:06 +0200
In-Reply-To: <aCXl-U5Dsv3hdCWa@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
	 <20250515124604.184313-8-phasta@kernel.org>
	 <aCXl-U5Dsv3hdCWa@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 5f02b5a74fc86c15c8d
X-MBO-RS-META: 69d664s196o43ritmth8fyiyacshbjyn

On Thu, 2025-05-15 at 16:02 +0300, Andy Shevchenko wrote:
> On Thu, May 15, 2025 at 02:46:04PM +0200, Philipp Stanner wrote:
> > pcim_intx() once was an internal PCI function, but since then has
> > been
> > published and is used by drivers, and, therefore, available in
> > include/linux/pci.h. The function is not used within PCI anymore.
> >=20
> > Remove pcim_intx()'s prototype from drivers/pci/pci.h
>=20
> Can this be moved up in the series? Or is there other dependencies?
> I.o.w. this
> looks like a leftover from something of the previous work.
>=20

That can be moved to anywhere, including a separate patch. It's an
independent patch, a leftover from last year. But it's related to
devres, because it was also added because of the problem with
pcim_enable_device().

P.

