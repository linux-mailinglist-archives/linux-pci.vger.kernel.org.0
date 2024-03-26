Return-Path: <linux-pci+bounces-5188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D915E88C760
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DF11F67D6F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4813CF92;
	Tue, 26 Mar 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FFvn4P5i"
X-Original-To: linux-pci@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357513CC79;
	Tue, 26 Mar 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467346; cv=none; b=lj1NjNFTwp/rl3h56yQPzoq/wLOVJaQajz56cEWo7H55sGz1zgmxlG5DncP1KHZgb855TwPdnmfq2kzz+Tak6Txv+bYEb18IIH4x/iCKSArvTbQbNvVhz3gyvcFlH0Q7T8nXm7kPdPr7jxPuJUoLYKhkoDmXydv4C3JAX+m9Prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467346; c=relaxed/simple;
	bh=cpbePfHGBKTWOTvvus/3XrPd8U/PqtNlq98UXTNxgtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gehvnzHc4+1qTVJV6wuqwzyjonQabq7jTaDii8oRNZF7ACvUNaTYbZR2LozeQt8pcD7KAQmxGbiRIggJ9qlG1Ks55FJjbcLiWRBNGViDZmLf+ZTT1qo8JVkdKQYot+TH6WHmpZOvXAyUDOQ/boofeao4Hw7qUUYrl9vjqBHXlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FFvn4P5i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B44047AA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1711467336; bh=cpbePfHGBKTWOTvvus/3XrPd8U/PqtNlq98UXTNxgtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FFvn4P5iUGFV/C84IYrDeszQ3l4X72UHM7BHMKC4XcgtG2N2QFnXn6xdz0VAqxRNV
	 Emf24AR4aL0OrPrXsmrgJ6afMPpl3nOT6W+g4eCOIq1Zb49xxCQfd0ZPOR7F+HeUsB
	 cszy1ZEszzufBkmfeD58hXM6Y1PQwAVM8L/JbuH3uljqBmQG1i/t4fu4czw9AASV1+
	 tP3xaIaLK7HMDBQYt7UYjixP6/QkqTyb1P82r4FZdhCFrnxysGhznSXe++ZIzncHOp
	 HhyJBHmAYmO5JH6rjBTuz2Y8F0E14H4E6waBB9ouTuV6DyZbC4z0RnJ11jbDgu4k23
	 9uOORglGwpt9w==
Received: from localhost (unknown [205.220.129.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3B44047AA3;
	Tue, 26 Mar 2024 15:35:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dan Williams <dan.j.williams@intel.com>, peterz@infradead.org,
 torvalds@linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
Date: Tue, 26 Mar 2024 09:35:28 -0600
Message-ID: <8734sd0zwf.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

One little nit...

Dan Williams <dan.j.williams@intel.com> writes:

> + * The DEFINE_FREE() macro can arrange for PCI device references to be
> + * dropped when the associated variable goes out of scope:
> + *
> + * ::
> + *

This can be written a bit more concisely as:

 ...goes out of scope::

without the separate "::" line, reducing the markup noise a bit more.

Thanks,

jon

