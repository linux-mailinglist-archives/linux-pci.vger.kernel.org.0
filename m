Return-Path: <linux-pci+bounces-4881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F287F0BF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 21:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87AF284309
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1986B56B6E;
	Mon, 18 Mar 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MAeA5Eat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fI2Jfaza"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84757872
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792167; cv=none; b=PxnlztXk7TDWY9iMszc+UyYcUYKNRBn5gDcAC8pm0Na2pU5lbj6QGJStVc0cRRu8SSp7ZU8e1PlMLlXPIrJq4KbiKQRVqygjA2F+tjFapoqyTolwfhJ5OLcqrHwRd1Cd3yqLpoQqwP0tj5nqXwAhR1N5XYbBCtCX99Eo5xxiJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792167; c=relaxed/simple;
	bh=KB0z+MB36pKhw98PUj1Sy6kLbaGHdQsG1P7s8Zqk9UU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cvckiwMyGG6W6I/kSTIqaHiUlDnQHIbxS8bxA8TB/xHq37rAI5QpqGUpkwPq7kxaJRhMr/oylyQW0y0QJ9xc+kH2gJ7ikzLqJyb2CNJQQ2XxAvupD4BWnMlEt0l29s2H8TtNusfO7nAG0ihyCrhHgcszZsAbabbr6DaMDykj9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MAeA5Eat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fI2Jfaza; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4CCF618000F5;
	Mon, 18 Mar 2024 16:02:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 16:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710792162; x=1710878562; bh=7MZ5OI9z3E
	Rgcq3ZmgPoCCuCu8EdJ05tOEH5pugSFM0=; b=MAeA5Eata4cAd+iv2qTLV0Cr8i
	ak1BybMMUmXsJmy8AYDh49EmyrNLWXvsETAExJYNUTIJDHsqKtKEDQhe+Pj9J2Fn
	n1LicvIjp+YT0+V/IG9lBbW0yKV693h0pknlpqNAUdXfT+1cL2R1WN+gdLFzIRjq
	vZ+gfCpdbpX8BTrbF01l5FkNEa1JMd5LOhaii/MN5tLGcuGHwcRlbLC+PnE0teMj
	dfT+xdCm9BmMnsemlHPylkpbZp+2KwbYehMTqGAYzBAcewMHNmjQIunoW4/Ux7Gb
	dgekm8oN9IO9oYIEWqsrz09iIK7rRlaPyU6DVhRHna7ZHlB4PNZ/Cyx92BUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710792162; x=1710878562; bh=7MZ5OI9z3ERgcq3ZmgPoCCuCu8Ed
	J05tOEH5pugSFM0=; b=fI2JfazaRa9iQFccCcvzBIJeoi2xp9NJ8G4f/KY+OZr9
	hC45L7pmTqrAkCdjHTgdm1UwYJN+b0fdZHXzokS2/oKdPV0BuyNShx7voy7+DLIq
	nilN4Lmu/ktMGtxtsdk489LKmqchEhZDzkLBXv42s0IgEa7SVOtvchWUkp9UmcK8
	QkdAVsMQjMu/MyBcvHao7dmjnTTbqQw6s1mbLW+NtNHdPB3v8uOcgI6m7ResEAqV
	nUNw5tZyOjfZeKFiwJLreApPwGs4bCtTbDUnhyL7zQ6wbZry+Q8SXNkaGfeOKpTV
	Qn7FTblPExV+RP6cAk8rlmU2Vrobt5c3NK6Ki7L7ng==
X-ME-Sender: <xms:4p34ZZzYZykYGIL3VPz1YQMQFXqvfrwpSTf8q9fCX6B5Mk1XTEdPRg>
    <xme:4p34ZZR-mS3ulw60IpydKJW7lrUVXDYFrO5m1FBSoBqWWC11CT3KyoBeJIggprVOd
    yhVDZQeacw6RzIoyvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4p34ZTU15FFmYNXpGCD6-1voqXZep-61wRSolbjTdST2yCv8LsOE3A>
    <xmx:4p34Zbixty3eASGxtN2Fu5HCHT4wuGKttF87YC9-H-S2J-lcQW-Sqw>
    <xmx:4p34ZbC_xSLU_GGUgBuYwXkS79ryrZlpq-zBvWfqF4f-7WGBFw4y0Q>
    <xmx:4p34ZUJakU-wJm5jgSrp5er9etD7pGJj_3RbwJeXKl4RvCVI9h0zoQ>
    <xmx:4p34ZdDVb5QKaPwvh4hCaqp_ewAesiTiKuVVoDUXZRrN99zQKQ9JQxQcENc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3133DB6008F; Mon, 18 Mar 2024 16:02:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
In-Reply-To: <20240318193019.123795-1-cassel@kernel.org>
References: <20240318193019.123795-1-cassel@kernel.org>
Date: Mon, 18 Mar 2024 21:02:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR
 tests
Content-Type: text/plain

On Mon, Mar 18, 2024, at 20:30, Niklas Cassel wrote:
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..cb6c9ccf3a5f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
>  	0xA5A5A5A5,
>  };
> 
> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> +					enum pci_barno barno, int offset,
> +					void *write_buf, void *read_buf,
> +					int size)
> +{
> +	memset(write_buf, bar_test_pattern[barno], size);
> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> +
> +	/* Make sure that reads are performed after writes. */
> +	mb();
> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);

Did you see actual bugs without the barrier? On normal PCI
semantics, a read will always force a write to be flushed first.

     Arnd

