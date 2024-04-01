Return-Path: <linux-pci+bounces-5480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C6893AE4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1721D1C20D80
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F066374C1;
	Mon,  1 Apr 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rl2RMh4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxP+MJdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDC28DC0;
	Mon,  1 Apr 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974231; cv=none; b=G2ijHxDC1dIcI/q+gl+RfLJ1afiByy95jSm/baK3lSyGv05RL8zknUP2hA2imVh/HTFU4iwy2RH31tZxDsiwKyVLluT07HG7n96W5uZgEQFcWiGCi3VILNjnFVtnTxa5N1oP6YKEOsY+IoMWxMUvg46K/SDJqGnsoZXeuli/a1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974231; c=relaxed/simple;
	bh=Ctk+OcrQMy0WEsINafpIB36IvEh5Ty5xoUSlRO6DGX0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oPKH+vO+TNAXoQCVoNHa5OSd2YheCNW8zqQkCnLmkb144Tqc0LMcf3B1FnLKtZsDi/OXSn1oZCwCiQrt3C8btBD0d3eeGbr9kpJEJtOJtyDpfdjcuv6LoJQVkvH7wWyUY4wtfWMlwLM5SG+qIHCMUpHEYNDlVEHzi/EuYOYDA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rl2RMh4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxP+MJdk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BD8FE13800F8;
	Mon,  1 Apr 2024 08:23:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 08:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711974227;
	 x=1712060627; bh=pSPgq3MDMweO7K1xhEXouVQ1IntwTQOhMwkmFmSqtxU=; b=
	Rl2RMh4GwIezTTlJMLIqUxfkdOTeqYvd5QgkMJn6/qYo7dOd2Pxrp3AAy2MKHpF4
	5Axyz0ZdoFMtNFI3i3qgTIyzauDqottXNFIYhTzkK4+vsKV3rCQvPDcseJ/OZuGj
	TQzQfO7AERqH4jXTtSRrqu2diieRONwU8d9WRpuABh3094JUBy8fWQV9ANoc5ift
	DOkhz1ztrJfzE+9CeE4KZPvEMuhak7sG6KxRyaUZQfKp184GMFD4l4dzTvZMGG8Q
	nCNFsMOyAT/oBH+mmgwM8O6GmqRsbQMTr23+Y2/ejZFv6iAuG59EjrrSDIJCdYzv
	13S8SXz1N0h3SE3TWaVx7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711974227; x=
	1712060627; bh=pSPgq3MDMweO7K1xhEXouVQ1IntwTQOhMwkmFmSqtxU=; b=W
	xP+MJdkptIQeq6Uoh2XAn9VsaZpq3fq8iZg+GrgYd7KMsxFcIagLh+RiRehwEL/H
	EJ3u4r/bP5kyvBc5/n6+aEX4xrK085VNZcawJxMHU58ej05DwlQf3YwArSACBq9C
	cVZR4G9pR/D9s+O96IKWjbEFaWg23rGAt36Fk/+dI7F3dPsFVZAIBBPTTpqJFVWi
	RLG3qkDFfOXcCKIKYT8eagvqV8ier8PDR9CJKemcXmrT+6ZzNDOibpewWOZoHmjX
	W12zgGhv9YJO/CkRBgkshLrn3DH7D51RK2It22/7xJ/EpQrudjJbXio9vUwvwR0B
	6AKYlQPdbOhKmVCBinCPg==
X-ME-Sender: <xms:U6cKZtOkNnfr-p2t8Y3JisW2OZyIgu2QMK7v5oJbzSuQ0-jbS85M_Q>
    <xme:U6cKZv_b0w5UzDbYw5cBt4eTDg5Z84gb0T9pUcd9_P7zCX6fwb4bmmwd-7XNnmsF_
    FmOP8E_wbUicQKkkHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:U6cKZsQdUJBD_iaPuNLF9MLSEglk7ADvzKiHlr43Doy3l1aAJs4hnw>
    <xmx:U6cKZpswbhqexB69ssoXyzgsEuk4qN4At_JZw9mbmxRQuSXpyCy_ow>
    <xmx:U6cKZle4vbWcxtFO8nh_DaUy7xjAtuZvoZZD5PdWQy6K4HWTUG-lrA>
    <xmx:U6cKZl1DgLgmXHVHvoONTKWaNPJ9QmJnw0pXwHlw4MvcVyGjQ6kdJQ>
    <xmx:U6cKZvtjeK0P40cx_fW20__g8lARXrREbxAFhAk1MUPDwu-3qSD7sQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 787D3B6008D; Mon,  1 Apr 2024 08:23:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c9523b7-9bba-4fe2-97a1-893e8505e054@app.fastmail.com>
In-Reply-To: <20240401121933.600977-1-maz@kernel.org>
References: <20240401121933.600977-1-maz@kernel.org>
Date: Mon, 01 Apr 2024 14:23:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Fix dependency on 16kB pages
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024, at 14:19, Marc Zyngier wrote:
> While d3e5bab923d3 consolidated the various definitions for page sizes,
> it ended up breaking the Apple PCIe driver, which still depends on
> ARM64_PAGE_SHIFT. Switch over to HAVE_PAGE_SIZE_16KB to make the driver
> selectable again.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Fixes: d3e5bab923d3 ("arch: simplify architecture specific page size=20
> configuration")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

The dependency only exists in the asahi kernel with commit
db5709e83c11 ("PCI: apple: Add depends on ARM64_PAGE_SHIFT =3D 14")
and is not present upstream.

   Arnd

