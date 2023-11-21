Return-Path: <linux-pci+bounces-28-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C87F2A23
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA22B210D3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C413D397;
	Tue, 21 Nov 2023 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WilkxKr1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEF3D394
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 10:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D461C433CC;
	Tue, 21 Nov 2023 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700561897;
	bh=x6Eqbz8ebjzAvuYM7IREObhQffM7Tdw0BiU0JcMcJaM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=WilkxKr1YsGr3NJe8afmUfGnZevm3G/59J5yCJoMTLk+GoCH517WI+iY6DuwPW4jD
	 Htki7HWMpbxY/oRzFLgMma6JVEqY7ma07B3eMkoMW81RLYGzDoUkPhkv/yGEedM8K9
	 Kf0KFd1XYlMAARg0GRyfu8JZ9YxYlNMwE2fmHuCv9PROA34SMhrLxlqWy+AWnc54fT
	 nJxLTZcOYaDC2Xyy96CPKs4PBWw4ohAIg93kQAznThFEGodRL2a/z1C8kcFtCZFGeH
	 4NQmgFIuM5hlRhHxLMvCzXZkcc1t4kDzD4ApWghtCR0x9O/3gOhNMXJ7mdRRXr2+v+
	 9EzOClQJPwUUg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 3F0F727C0054;
	Tue, 21 Nov 2023 05:18:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 05:18:15 -0500
X-ME-Sender: <xms:5oNcZcSO38KFYbW9qpw93qmsgssYpHs6CGyxg6FkUSPN_ADaNr6BcQ>
    <xme:5oNcZZz9GbApy_U-yAwMI6tfkpI7zsvS7Lq95XIY06BbURzI8g3fV6_GkxXWsMrr2
    j5f21nisDNEQsTlv3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:5oNcZZ17G2DTgqs1fAa9v8wjRdFawzMY7kI8ouLbPqHZiKzfXcKu8w>
    <xmx:5oNcZQAcYvzvL4rXpbUIdjtcsVpnOkO2VVaIlg0ObKXHVUlBSIcB3Q>
    <xmx:5oNcZViwMaeUUdbHcDsRa0gY-9GgD5_R5VN7kKjSVeS0pbgP8uXERg>
    <xmx:54NcZYiM6cVzxTPUA7CF_Mu4aHlt8_TWzVNRhXWYuoUbpM8LM9_8qp6cA4ng-bjs>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 48412B60089; Tue, 21 Nov 2023 05:18:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3bc69019-7867-4f51-806d-02bf85a3cbf9@app.fastmail.com>
In-Reply-To: <20231120215945.52027-5-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-5-pstanner@redhat.com>
Date: Tue, 21 Nov 2023 11:17:52 +0100
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
Subject: Re: [PATCH 3/4] pci: move devres code from pci.c to devres.c
Content-Type: text/plain

On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> The file pci.c is very large and contains a number of devres-functions.
> These functions should now reside in devres.c
>
> There are a few callers left in pci.c that do devres operations. These
> should be ported in the future. Corresponding TODOs are added by this
> commit.
>
> The reason they are not moved right now in this commit is that pci's
> devres currently implements a sort of "hybrid-mode":
> pci_request_region(), for instance, does not have a corresponding pcim_
> equivalent, yet. Instead, the function can be made managed by previously
> calling pcim_enable_device() (instead of pci_enable_device()). This
> makes it unreasonable to move pci_request_region() to devres.c
> Moving the functions would require changes to pci's API and is,
> therefore, left for future work.
>
> Move as much devres-specific code from pci.c to devres.c as possible.
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 243 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    | 249 -------------------------------------------
>  drivers/pci/pci.h    |  24 +++++
>  3 files changed, 267 insertions(+), 249 deletions(-)

I had just commented in the other mail that you'd have to move
these functions to devres.c for the file to make sense, but that
I think the existing state is better.

Just to clarify again here: this patch does not seem to improve
anything to me, I'd much prefer leaving it the way it is, and
moving the pcim_iomap family to corresponding drivers/pci/iomap.c. 

     Arnd

