Return-Path: <linux-pci+bounces-20-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C461C7F2654
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 08:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008BB1C20A10
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A021A16;
	Tue, 21 Nov 2023 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVDQYKuX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633921375
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 07:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D6C433C7;
	Tue, 21 Nov 2023 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700551779;
	bh=iN2vy0G2QoY8JrojPMvjhZH+VwMN+5+iL06Cyoh3i6Y=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=iVDQYKuXclKQdB90V4TxdWwdIycVFR+gtxWnS4gYYDNXxikVpoF4DwwhmPpeiu512
	 +MAHvFJmAWGCZ7kyNyDNPUV7K1KbLLU2jyKOmOiuBNz2eAmmG+Ekfy/9Cjbui2lIwB
	 ITQlz6a+EfipNzPTbip8xTVzqjInDQd21HfDyavb0L3xXllG+kd20quz1sCEUViMPq
	 sxlc2rEska56Jub7k9zwWcGfCY6w/xTYDUxqajZrK19ZEMFH58f7ZEWNl8GNZQs0LJ
	 dZdROs7LHxQJO3Qf7krPM8s8kiy2v28VgAAFUxj6ioap4zK5WpC5UfGg2/WZsdwnFk
	 faH3YgLSJnlgA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1AC3F27C0054;
	Tue, 21 Nov 2023 02:29:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 02:29:38 -0500
X-ME-Sender: <xms:YFxcZRKkbcrovPaELtyYV2DX0O8yeUVsy-q4lW8z0WkvLeY2PFn7-w>
    <xme:YFxcZdIjpdZ4bhGRdawrOv8AkBBgpyl7pLIqwQFEBB3vuNa76FsRLhW_0IKuowVeV
    USizgnZw8Bnz0dWhT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:YFxcZZtEd9vAXuXRY06BBC1U3upWjOVv9gjszhJAGq-c4WDxWbC8Iw>
    <xmx:YFxcZSbkMoe4h2Bdu_2qu4oZNrreffNRrCO_u8UFEj0gzSeB_byNbg>
    <xmx:YFxcZYYM8cxkcQUlpKELYJyUlDoivNk--c7tPuY4QxfiwXudR_1E7g>
    <xmx:YlxcZabImKBMu6_1zwp5jOQzd47qdkKWhORusT-kB6C-709OVS9agvOPHvwUFTka>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D5AA1B60089; Tue, 21 Nov 2023 02:29:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
In-Reply-To: <20231120215945.52027-4-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-4-pstanner@redhat.com>
Date: Tue, 21 Nov 2023 08:29:15 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Eric Auger" <eric.auger@redhat.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Neil Brown" <neilb@suse.de>,
 "John Sanpe" <sanpeqf@gmail.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Kees Cook" <keescook@chromium.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "David Gow" <davidgow@google.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>, "Ben Dooks" <ben.dooks@codethink.co.uk>,
 "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] lib: move pci-specific devres code to drivers/pci/
Content-Type: text/plain

On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> CONFIG_PCI and, thus, don't belong to this file. They are only ever used
> for pci and not generic infrastructure.
>
> Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/Makefile |   2 +-
>  drivers/pci/devres.c | 207 ++++++++++++++++++++++++++++++++++++++++++
>  lib/devres.c         | 208 +------------------------------------------

Since you are moving the pci_iomap() code into drivers/pci/ already,
I'd suggest merging this one into the same file and keep the two
halves of this interface together.

     Arnd

