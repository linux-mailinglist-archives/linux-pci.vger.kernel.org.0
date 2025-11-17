Return-Path: <linux-pci+bounces-41390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A782FC63DB6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11A12343166
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE02D6E5C;
	Mon, 17 Nov 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z8ywHJMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="syD3jK3r"
X-Original-To: linux-pci@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7828640B;
	Mon, 17 Nov 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379267; cv=none; b=O0SKurZaNknvpnZnNHQECBRf9t19Kg3/0AA2jBOQEqZyMGemXQ5azgoBs5brhcytXoh3rarcAbOVdDtSqPmc3v/Vz2BsUEieGeV5FYzCrIYz+OF5E5MDnQPRfzVPKfLdOqNHyRilpYdaHL1mzV6DIQcvP2DxKVecw1rL9MUg/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379267; c=relaxed/simple;
	bh=JktO8F5K8/AbbvqeJKCLi379h7FRs3fzEUHk/0VFZ88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qCYf1s5uPeG0DWye6KGx+7f9Du+DrUMnXBStznZaMLv61upRFN+Mp5q1wwfMPn9dqVoTn3pjXYJaGJxnWH5guXEHPV+ZhYDnTTchoZk0vVhIOHYaGVuI+oUCQ65DNkU7xpFBMYmy6Bz4E0qljN0DR5SDsHHYqxxTWP5Icm9zbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z8ywHJMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=syD3jK3r; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id F097A13801C1;
	Mon, 17 Nov 2025 06:34:23 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 17 Nov 2025 06:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763379263;
	 x=1763386463; bh=Fd2jDBS6TczwyfapWowGCLfJ2ZDyiWW2nSxP/Qc1jTw=; b=
	Z8ywHJMH6RJztItXyxhnCdMdrpCnuulEfpshTedUx8fNsXHEt4EuNWlfudMcER9/
	YpdnfwkgNKR7h2UJN1sPVzYzRw7v21vLO9pk55T7rcJMaljpVviGONhEmmZgbiK8
	M7O7eQNMFqOANmFmbtenJnuDfHKEsVukkoB405Ci+2MJ8Ezs0tt6wzqmc77g4BCO
	nXnOXxw2ULDztWr8/w+8EvicEkSj+foP5MpnSlTLfcPdehLwtlv8989/wZjas9p0
	OMekgTgN8lkm39pWSPu7PLP00HOIIwrWcQe6K9qb5OGVKT6QKDh/ml2xZ1Jn/aud
	Teah4O9SbocFkiPdIZyiZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763379263; x=
	1763386463; bh=Fd2jDBS6TczwyfapWowGCLfJ2ZDyiWW2nSxP/Qc1jTw=; b=s
	yD3jK3rNfTS2oDa8ZUhjkAPKYvrSDSH3QepIrxzqgCnOKdlGwmBqb4af47TtRcCH
	dmVieIMQA9uLuPwKU/EPgRQo1oaCIPVR7bniWdqNVk9kyQD1atG2XL6lwQzYRHi4
	6aTa4bVJ25lIvBJRjIVR+Z3r7n8YAYe/LYelS3ZywFRqaxsvXQC43j4WyCFysTr0
	jZi1yBqQDN9kvCK15SqBhj/QHUFhAAnPTqfsju6werXAZ2C41pNo4ruaRDJjgivJ
	k2iGScGhfL3v8RbOeCiORVNJQHcVXztpv9D3x6JecYInZ28PLW4EyMvxlh38IbNI
	UfK//XaFe8rOvvyqlnVTg==
X-ME-Sender: <xms:Pwgbafudna6Sko-cwJ0ae9YtsZ60_dPgSxhFe61mt25fHmyV6vrrUw>
    <xme:PwgbabSZ_h0Srl5kkbHZBMCI_n_AuqCdEP_3X01fZS0JAVAIsrLWklVqBEbZwqWs5
    -DWPXlZy23mC_ojMgu1fOf5BppG7sWvOndZBRuQeHDj55HPlX9kFiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffh
    iefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggp
    rhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlgh
    grrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrghniheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsqdhvrggurghprghllhhisehtih
    drtghomhdprhgtphhtthhopehsrhhksehtihdrtghomh
X-ME-Proxy: <xmx:PwgbaTpFJreT2VJHNLbYE7Whh4s9XfYb_hQQ1SZhEOUv5CR1396G3Q>
    <xmx:PwgbadG5XJb_LDl5dZcgcMRSkvcm3QSc4MXaorMnLdb0ea5r1ml3og>
    <xmx:PwgbaRTpQ3Oon1-T8cqdutDb3ek9gVcremSSU8NL-xtuPzgfL-qndw>
    <xmx:PwgbabOobIF4ndC1xXGnLwC7cuUqVi49wehJ5zsGINBnCGpvvwotRw>
    <xmx:PwgbaYUo0c5N5lyHxB6cAJOcPj63TJR56AKKr-ClAk4QCkoCUv9avjEX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A75EE700054; Mon, 17 Nov 2025 06:34:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARY7ZiTdmDAg
Date: Mon, 17 Nov 2025 12:34:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com
Cc: "Kishon Vijay Abraham I" <kishon@kernel.org>, stable@vger.kernel.org,
 Linux-OMAP <linux-omap@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
Message-Id: <965a2836-050a-4958-af95-ca3b5f9a57ed@app.fastmail.com>
In-Reply-To: <20251117113246.1460644-1-s-vadapalli@ti.com>
References: <20251117113246.1460644-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Add config guards for Cadence Host and Endpoint
 library APIs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 17, 2025, at 12:32, Siddharth Vadapalli wrote:
> Commit under Fixes enabled loadable module support for the driver under
> the assumption that it shall be the sole user of the Cadence Host and
> Endpoint library APIs. This assumption guarantees that we won't end up
> in a case where the driver is built-in and the library support is built
> as a loadable module.
>
> With the introduction of [1], this assumption is no longer valid. The
> SG2042 driver could be built as a loadable module, implying that the
> Cadence Host library is also selected as a loadable module. However, the
> pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
> due to which the Cadence Endpoint library is built-in. Despite the
> library drivers being built as specified by their respective consumers,
> since the 'pci-j721e.c' driver has references to the Cadence Host
> library APIs as well, we run into a build error as reported at [0].
>
> Fix this by adding config guards as a temporary workaround. The proper
> fix is to split the 'pci-j721e.c' driver into independent Host and
> Endpoint drivers as aligned at [2].
>
> Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable 
> module")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> Cc: <stable@vger.kernel.org>
> [0]: https://lore.kernel.org/r/202511111705.MZ7ls8Hm-lkp@intel.com/
> [1]: commit 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> [2]: 
> https://lore.kernel.org/r/37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

