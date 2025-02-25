Return-Path: <linux-pci+bounces-22377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA1A449F3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39CD3AD210
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2C1991D2;
	Tue, 25 Feb 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV0JxqUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD14194A59;
	Tue, 25 Feb 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506933; cv=none; b=hOn7w22B3pK4a72GcOF7tYsauqHqLYyc+yAjyn10eEpPnCMR3TiXuIfq0L2LeyyXwXtxc4SuC4O0EbORn4zzzFgyUKK6jR1wCBCafzUvKqbYbK/B8O1BN4jr0jLMP4SNRDLEaxVPe7nXYlogegxxo2hJOFJTCnqDKWG0b+AOfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506933; c=relaxed/simple;
	bh=bq2qsdPe4LGuWItQe5cE+6dmynkmRrOR0hWrrdjWRAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rYgrFlXHLDkoBcptVMmF5WAjxCtKk4HVn8Izq+JJosqNtJVYKCIkY4KEct6oqOI8fnI9T7oYmOvczXJ8GbEHVYn2qhe/zWECkfwMeGVrfMOBbdDdc1q4moPu5M2B0QHwVWquiRo5Jxgz2LRYwrjbpwF0gspPvlfr0mlf0CpFGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV0JxqUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F2CC4CEE2;
	Tue, 25 Feb 2025 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506933;
	bh=bq2qsdPe4LGuWItQe5cE+6dmynkmRrOR0hWrrdjWRAo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dV0JxqUBtf/F1yClSGdbE7OOolhrNZU8Wu+c5/YcGH9Kn82SrCMS7tlYCWq55TwWZ
	 FVEbvTs3j1Suap/aS0d++cfEICTM7O+PTt8JjPvFWnp1IHl+YJK/9DTzZr3PrUQDM+
	 eFW8dLEDyvVBe/1FR+izUeD/Ymb7opbh4jXN5KlVOf5XMOfEXxd8A1rzqUz2XqvVYD
	 qqcSCAAC7DvdOpAnMFtvCOXtmjvJtWlMwK3WeQlrm1zMuiAHSwGNhvFFo6ns4k2lW6
	 ++ToAW8FiAYXTOKOh04KWTxBV2NETHvwdUKwC7weofRZDIvqBRxgKsJCZnZaLoHL25
	 8S4/61iBNwuDQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45AC6120007A;
	Tue, 25 Feb 2025 13:08:51 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 13:08:51 -0500
X-ME-Sender: <xms:Mwe-Zz6vx6mRR190CkwMuUl2O9mT2iqe1DDgKB-ydt--DPUuR_LEcg>
    <xme:Mwe-Z45tlUoSpZxGKKoogc9JCBMoOMSHrUs6AL_mS9aZXnrrVXMcH84M2QDW8OO8g
    2XN55Hbgm_83QtYMj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrh
    hnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeejvefflefgledvgfevvdetleehhfdv
    ffehgeffkeevleeiveefjeetieelueeuvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonheppehkvghrnh
    gvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhnnhihtgesrghmrgiiohhnrdgtohhmpdhrtghpth
    htohepmhgtrghrlhhsohhnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehkrghi
    rdhhvghnghdrfhgvnhhgsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohephhhkrg
    hllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkfieslhhinhhugidrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhn
    rdgthhdprhgtphhtthhopegrvggrshhisehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:Mwe-Z6eRVRwb92v3xwiBRoCfoU0BORcIuI5pBoWRiwArPQGtCgPYzg>
    <xmx:Mwe-Z0J6Ik74tuQs9Mz5hywsL3_3znIDGsJbsvmfzDbn7XWvyp7XXw>
    <xmx:Mwe-Z3IeoWtKp9OK6SQzwxeMKmc605ZxLRoljnlrjyFcvZa9xGVQAQ>
    <xmx:Mwe-Z9z-8gKVgagYVKNcKARCpzK-Pnn9nMUAwlsdwauhARFyBLdXQA>
    <xmx:Mwe-ZzK93b_6RGbKiEZVp7H-nuum2kxMJCPcHO4uTC1XVqJ4QxMNJIOE>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 158D51C20069; Tue, 25 Feb 2025 13:08:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 20:08:31 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, "Ariel Almog" <ariela@nvidia.com>,
 "Aditya Prabhune" <aprabhune@nvidia.com>, "Hannes Reinecke" <hare@suse.de>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Arun Easi" <aeasi@marvell.com>,
 "Jonathan Chocron" <jonnyc@amazon.com>,
 "Bert Kenward" <bkenward@solarflare.com>,
 "Matt Carlson" <mcarlson@broadcom.com>,
 "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
 "Jean Delvare" <jdelvare@suse.de>,
 "Alex Williamson" <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Message-Id: <354ce060-fc42-4c15-a851-51976aa653ad@app.fastmail.com>
In-Reply-To: <7ff54e42-a76c-42b1-b95c-1dd2ee47fe93@lunn.ch>
References: 
 <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
 <20250225160542.GA507421@bhelgaas> <20250225165746.GH53094@unreal>
 <7ff54e42-a76c-42b1-b95c-1dd2ee47fe93@lunn.ch>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Feb 25, 2025, at 19:30, Andrew Lunn wrote:
>> We always read VPD by using "sudo ..." command, until one of our customers
>> requested to provide a way to run monitoring library without any root access.
>> It runs on hypervisor and being non-root there is super important for them.
>
> You can chmod files in sys. So the administrator can change the
> permissions, and then non-root users can access it.
>
> This seems a more scalable solution that adding a special case in the
> kernel.

Special case is an outcome of discussion in previous versions. My initial patch which I believe is the right approach is to allow non-root read access to VPD for everyone.

Chmod solution is something that I thought, but for now I'm looking for the out of the box solution. Chmod still require from administrator to run   scripts with root permissions.

Thanks 

>
> 	Andrew

