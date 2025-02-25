Return-Path: <linux-pci+bounces-22382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60070A44BFC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E6519C34E0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5720F060;
	Tue, 25 Feb 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI26HtwV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38E20E71E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513987; cv=none; b=TdvWcDGX0KScUahseljQKE/NB0ohhToJSTUPx21DqLYSaZ+qc/d32kLXYS3lwWPBf0K6I1ol9rg0SuYcSNlI2ONEriodKlw0gdxdjy4QMsd34ob7ei1l+o7Sd/+2cm+dwaDXfJ54w8Zgrps1x5AzwHUDGU/lXoCCHW0FLI9iTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513987; c=relaxed/simple;
	bh=VcfsQnksfk8sQcSSfz9I+EZRxSG+pl7g2bXtmhd8gKM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Pj6NWKaf05+AivEb/9wu3FPwut8KcLBJjC35ZgqMTX7zIwvgTyPVd9s2JF3hJJZTbfaVnvIRskM01/chnxqAGOsJvrjcMW0+cvxXBG8oUMBQeYqwGIOtFWGv3Oqnk0DIfdZnaXkpPHbA63gIoN8/f6I0GTWvoMDwf8tDZ+1Yh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI26HtwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F94C4CEDD;
	Tue, 25 Feb 2025 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740513986;
	bh=VcfsQnksfk8sQcSSfz9I+EZRxSG+pl7g2bXtmhd8gKM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BI26HtwV0ZnB+n1682vmk38Bc4TsnziQdggDVVbFlWHE9osAlwRmXxCdhA5Dcl4DC
	 5xm9ZaIHYVKI8JzOuX/L8EupB6OerJWncDiCG3KArEDSuxDCRTa8S5RBnmyNBWkgcx
	 ZyLH7OtK5GJWQF2SwQPFYB0tTOI7tUtsQnBlR+G1q3jtKDyMLh3u0oel1O4cTrtEmm
	 u6tZNeFv6UoKnRt/uLsNW7ORmCuuOhjVbgA9hgINz2IWRK4bksmJmyj8rFk/HP/Xc9
	 kcsLhFHsC9f/YCFTOjj6YiTjwYd7BNtW9DwqnDcDtsBuDHNwCVTYWFxhM/7+9aI2cg
	 ma8roWk2Lg+Qg==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D0188120006B;
	Tue, 25 Feb 2025 15:06:24 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 15:06:24 -0500
X-ME-Sender: <xms:wCK-Z7x28LZOrtFKJNGwvcSbbHGKoZQkNKPKd4ydXxiQcL8IdVLwfg>
    <xme:wCK-ZzSSVbTKY4vig0DaWTTMYF2BDAODDzdfrgyKvewU_RIUp7s3d9YH7-Yu4OGFP
    ZfmY9YcHOlzNp2URrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdeivdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:wCK-Z1VQGoGLOyQ8gY_diAs7mCfx6Mey9x85h2uIGCuD9zDdEuwcQg>
    <xmx:wCK-Z1j-n6VDEmk30t-cXQCYUvEMe9jVW8CdDYWV7cQrCoR3kTUZ1w>
    <xmx:wCK-Z9AfBklA7ncfglEUSt675IEjgYuuGszQ6eEG179WKVoJk_KwXQ>
    <xmx:wCK-Z-IH18xsZW_EOY-6dONU_T5ahdR_eVX9Cu8Za4cW7VlKDDJoEQ>
    <xmx:wCK-Z8D4mBsutqmYSnLnGXh7QpL5Qi7PqxaHOs34vYFX5L9YCshsrs_I>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A40981C20066; Tue, 25 Feb 2025 15:06:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 22:05:49 +0200
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
Message-Id: <e9943382-8d53-4e28-b600-066ef470f889@app.fastmail.com>
In-Reply-To: <87c90b88-ea56-4b72-92f9-704cca28ae98@lunn.ch>
References: 
 <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
 <20250225160542.GA507421@bhelgaas> <20250225165746.GH53094@unreal>
 <7ff54e42-a76c-42b1-b95c-1dd2ee47fe93@lunn.ch>
 <354ce060-fc42-4c15-a851-51976aa653ad@app.fastmail.com>
 <87c90b88-ea56-4b72-92f9-704cca28ae98@lunn.ch>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Feb 25, 2025, at 20:59, Andrew Lunn wrote:
>> Chmod solution is something that I thought, but for now I'm looking
>> for the out of the box solution. Chmod still require from
>> administrator to run scripts with root permissions.
>
> It is more likely to be a udev rule. 

Udev rule is one of the ways to run such script.

systemd already has lots of
> examples:
>
> /lib/udev/rules.d/50-udev-default.rules:KERNEL=="rfkill", MODE="0664"
>
> 	Andrew

