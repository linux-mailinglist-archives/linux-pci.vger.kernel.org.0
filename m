Return-Path: <linux-pci+bounces-31749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE9AFDE92
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AAD3BC245
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E318DB03;
	Wed,  9 Jul 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="c2WhWLj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from epicurean-pwyll.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77AD517;
	Wed,  9 Jul 2025 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.217.159.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032946; cv=none; b=dSiCw6THFSyQp3IABuL7Cwr0v1rZegfJzi4qLA0sNcePBiLxKz8YkN+cMYGsX0KRnVAc9NNXIWZVC4t4+OvgmbAeMcNTk363fRFrWgkEP/J0NAJVscuh7rfN+wS0wn+BntszsWsGCKMlJ5maWokFLMktUrXr1Wp4RYTxdP6S46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032946; c=relaxed/simple;
	bh=zjvjUcwS5qfI9jHWRzf+0fkXmbuLjmAbMYytraR6Tao=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NhJZS7D6Anq9ooTwUr3B1njh/XUOEYgoG9N5sClGWlKjNDn0THsfA065UOyaXBG3vyryPdYY1OP0K0+TUM7OqQLAgkIYlgnQSGi7J3C6T7mkRQOYDm3Becp8jhOqXSh1HEqh0viS1Aw5vslbN1jbIPCh4jDgGdl9DwOtlqJNJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=c2WhWLj2; arc=none smtp.client-ip=18.217.159.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from advisable-myrddin.jail.a.mail.umich.edu (ip-10-0-73-63.us-east-2.compute.internal [10.0.73.63])
	by epicurean-pwyll.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DE6AD.359AA137.4E5FB9A4.222246;
	Tue, 08 Jul 2025 23:49:01 -0400
Received: from inspiring-wechuge.authn-relay.a.mail.umich.edu (ip-10-0-74-32.us-east-2.compute.internal [10.0.74.32])
	by advisable-myrddin.jail.a.mail.umich.edu with ESMTPS
	id 686DE47B.1ED842D5.6149EC18.933264;
	Tue, 08 Jul 2025 23:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752032375;
	bh=zjvjUcwS5qfI9jHWRzf+0fkXmbuLjmAbMYytraR6Tao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2WhWLj2RRdNo3XYLXv5lxWvlmKbu/Bul0xOA1Tw6gXVdnZCqwEgoUPCMH5W86YMm
	 ffM1Toa2+jAj+9FeLpxlKQlZvXt761mFqXIehtfh2rRY/UiNk4t16hiw1fJCCAJ3YO
	 axsAaSDygz4JOXhtGagWeCgl8yJbecaMrwjNVPva3HAbvNA6wJcTSqVXHp6uOhTx1m
	 accbNpYlhCvMkura/1cobgjggz44qOLJPIPEcrAR1GBTGqr92oLODzXAKf6inK8MJ0
	 H9xzrATJuaOOEene4+oFC5TzJC3HxaiVqTsMHEwi7xPnwT3YbkEK8WjmNIlr3SXmgJ
	 nSjjJvQeEwa8w==
Authentication-Results: inspiring-wechuge.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by inspiring-wechuge.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DE474.2AFF1CF8.852C2E6.1056699;
	Tue, 08 Jul 2025 23:39:35 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 23:39:30 -0400
Message-Id: <DB77N3PDLA0W.26YMMAHG8LIVF@umich.edu>
From: "Trevor Gross" <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <alex.gaynor@gmail.com>,
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <ojeda@kernel.org>,
 <rafael@kernel.org>, <robh@kernel.org>, <saravanak@google.com>
Cc: <a.hindborg@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <david.m.ertman@intel.com>, <devicetree@vger.kernel.org>,
 <gary@garyguo.net>, <ira.weiny@intel.com>, <kwilczynski@kernel.org>,
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] rust: net::phy Change module_phy_driver macro to
 use module_device_table macro
X-Mailer: aerc 0.20.1
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250704041003.734033-4-fujita.tomonori@gmail.com>
In-Reply-To: <20250704041003.734033-4-fujita.tomonori@gmail.com>

On Fri Jul 4, 2025 at 12:10 AM EDT, FUJITA Tomonori wrote:
> Change module_phy_driver macro to build device tables which are
> exported to userspace by using module_device_table macro.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

