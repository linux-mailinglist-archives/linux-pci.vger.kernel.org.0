Return-Path: <linux-pci+bounces-27968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C0ABBCD2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876973A21D9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E12749FC;
	Mon, 19 May 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VAeO5PhE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE252580D5;
	Mon, 19 May 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654879; cv=none; b=sOMrwD0vllN+H9lq9lnECWt8Lv7R3XD5w1gTxrAQ3pk2VtLjRAU6VgzkMY/DojIn5zbZQBS/YkvnTb/Eirc49omnvmaK8UKOktJS8HZelVhkpHpSglCyzCQ1/32SiyXw92OBBgGNThHcDbrSEqfKDtO5lpOooPic0pNO0GUrX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654879; c=relaxed/simple;
	bh=5Vo96rwwbeqGuD7SKuZQDOxh+cFjL5FGVQRjtEcFIV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajM907H4stf6kJNHZIBwl4mC62FB0oI/KzD3B/qSXB1PkjneVzx26j42vGp8bdF3bZJaFNDv7ahmjr5nG7wpFCPNji9HYECBAYVcXoC23LKExom6bt6gmop5biYZnsVZnVJ37XGZ+79fp+dU9leS4l6utouQ8iJd32Th/Ik5In0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VAeO5PhE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b1G3X3KMnz9t7w;
	Mon, 19 May 2025 13:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747654872; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02qyQguP64ZZwtrSPx68nkmGaO3o+TTS6Su6EUVfz/g=;
	b=VAeO5PhEZg2vHq/WRsS8NwbUWscEsSNq/3UkhAlboXIG+WobMwkLWlizLEyzpznQR/rQTF
	N2/WyCwPeHA7O5gtf8kGx+BYXIWxgjLRAlsu5P8tbYnDx3qsk8Bs4xRHCJ0wYicqeaFTeF
	V9+xmC9Hwbh86yCkoKOZ+F2vjSMQazbdWOmoxn/reWjkFlE8AK2US4C2JM+maW9Il5JLrh
	32D8KkLLDyeq0aNetrk3sWrp6lWWyXjKuNGHJ1RqtHbcxyBaxWPMCfMalI44vY30Bdb2WF
	iJFfgkraTSwS0oKLlNqxkO6zX2GjKdQiCOu1Og4bgBR8q+J12tiWwK/Mwm+fPg==
Message-ID: <6e46fbe01199d420dc2c9f6c5bd564ea45b0a0e9.camel@mailbox.org>
Subject: Re: [PATCH v3 0/6]
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yang Yingliang
 <yangyingliang@huawei.com>,  Zijun Hu <quic_zijuhu@quicinc.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Mon, 19 May 2025 13:41:07 +0200
In-Reply-To: <aCsYMzWrV3bGpMWb@smile.fi.intel.com>
References: <20250519112959.25487-2-phasta@kernel.org>
	 <aCsYMzWrV3bGpMWb@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 407da09aacdcef2975c
X-MBO-RS-META: upjszsqh7sgf4zue37orw8sd49exwkrf

On Mon, 2025-05-19 at 14:38 +0300, Andy Shevchenko wrote:
> On Mon, May 19, 2025 at 01:29:54PM +0200, Philipp Stanner wrote:
>=20
> Just for your info: Subject is clean. Forgot?
>=20

Yup.

checkpatch doesn't detect that, though:

scripts/checkpatch.pl outgoing/pcim/hybrid/pci-rest/v3/v3-000*       (base)=
=20
-----------------------------------------------------------
outgoing/pcim/hybrid/pci-rest/v3/v3-0000-cover-letter.patch
-----------------------------------------------------------
WARNING: 'seperately' may be misspelled - perhaps 'separately'?
#13:=20
    resend seperately. (Andy)
           ^^^^^^^^^^

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit desc=
ription?)
#67:=20
[1] https://lore.kernel.org/all/174657893832.4155013.12131767110464880040.b=
4-ty@kernel.org/

total: 0 errors, 2 warnings, 0 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

outgoing/pcim/hybrid/pci-rest/v3/v3-0000-cover-letter.patch has style probl=
ems, please review.



Maybe someone(tm) should fix that :no_mouth_emoji:

P.

