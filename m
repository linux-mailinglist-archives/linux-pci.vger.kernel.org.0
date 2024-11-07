Return-Path: <linux-pci+bounces-16230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884A9C040E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1EC1F236EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C95209F32;
	Thu,  7 Nov 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is85sQl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3251208999
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979127; cv=none; b=Tj//FZThDdGOJv6Yow3oiQ8DkvxSerMcIg30ZJGk+EhgwCVd+UdUielFB5IYOPw21vdyLUAvLYGIDVt206ttpea7GacyorNQ7iS5urR1CI54fkuZUqaBfYTb8HMa6rno2NHZ+70e17oN8hsszK9/8/IMANkoCayLvscOmIfQQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979127; c=relaxed/simple;
	bh=++vQ0lzeG3Jrqx6fHr8hPgQgL6xBFVlHG0RR8npbujE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NrO5jchgEy/8rUX0sjcPyfTko9hGlDIAWRvwtCKJAVWVKkDWOCY5KT0jNSoFgM723XTgRwUSwrXXrjrI109nd2eCxRPHAM/HD1WfaYeXAA7sNpF9NX2vKDOm1SWghtaEn9BEsmepVd+1I2eHNpcb0B/SBZnvda5kjX0Iu2IXXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is85sQl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB27C4AF0B;
	Thu,  7 Nov 2024 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979126;
	bh=++vQ0lzeG3Jrqx6fHr8hPgQgL6xBFVlHG0RR8npbujE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Is85sQl8V1y4p9Ke3aIamTV0pXATg8O7UhHBzwsv89xiqctJLHGiSupmRs8KGFf8C
	 pI381yE5fqBFDu1da/97yQCOhTZ1ZbUPOXzbTbemCceEzdCaESotCcbyuAOBV3sMb7
	 6kfbEocu0N/R6j1RDPhT7nSGHXFG9iKMb4Zt8qmEMRyQ8yfbUyxn9fA/qwixiEZy2T
	 sMCUISxOXP9FbjIRci6CnTIDoCqiOC7lAaOCQ7qj086Xdgib422AD73sDPK+J0L1C+
	 Jg1qGaO+3A5TIWs29vpyx3Qvb5Un51KlX0wweYVvZFzuM/yeihAXX+HwZRbjKEsaRV
	 CP5IbA/cxt09Q==
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2804C120006C;
	Thu,  7 Nov 2024 06:32:05 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Thu, 07 Nov 2024 06:32:05 -0500
X-ME-Sender: <xms:NaUsZ5jXCfx1YLBRih7P_dQok3HqV6uj3nBJ563PnIsvB2A-f6RC5g>
    <xme:NaUsZ-B3-f-I-v-ZYKLZIQ2Rtqa7tgYlJKE6pxZIwo7rI5g2nFGJ7S7xeA1IEofoo
    LcJeYuyojvdDaz9KNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrhhnvg
    hlrdhorhhgqeenucggtffrrghtthgvrhhnpeekgfduveffueffveduleefgfejhfevfedu
    ueeiueetleeugeeivdfhfedvgeeuhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhgvohhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeelkeegqddvje
    ejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnhhupdhnsggp
    rhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhhnhi
    gtsegrmhgriihonhdrtghomhdprhgtphhtthhopehmtggrrhhlshhonhessghrohgruggt
    ohhmrdgtohhmpdhrtghpthhtohepkhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitg
    grlhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdp
    rhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohephh
    gvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifsehlihhnuhigrdgt
    ohhmpdhrtghpthhtoheprggvrghsihesmhgrrhhvvghllhdrtghomhdprhgtphhtthhope
    grphhrrggshhhunhgvsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:NaUsZ5Giy9j3ajjZsZkQXlmPsPUX80BWvmsueyxnnsMZFqvsFbDwrA>
    <xmx:NaUsZ-TpUSNntRKiLL8Gt5t8jMk641Y7Jy92DgQUo0sD_ufYIy16Hw>
    <xmx:NaUsZ2wydzRwe6i8PFdfLp003BxLGKg7R_xBpBru2_3vFgzwtVj0Tg>
    <xmx:NaUsZ04chBJT_iS7UfWqrHerXpO1K0p4awauJMsQ2rN0anHpFgh-yQ>
    <xmx:NaUsZ7yyM8K09kwVSKQ2FifmB1-tJhC4-SDYvnG5VdECGo_z0UKH0Z-b>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC77B1C20066; Thu,  7 Nov 2024 06:32:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Nov 2024 13:31:44 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, "Ariel Almog" <ariela@nvidia.com>,
 "Aditya Prabhune" <aprabhune@nvidia.com>, "Hannes Reinecke" <hare@suse.de>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Arun Easi" <aeasi@marvell.com>,
 "Jonathan Chocron" <jonnyc@amazon.com>,
 "Bert Kenward" <bkenward@solarflare.com>,
 "Matt Carlson" <mcarlson@broadcom.com>,
 "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
 "Jean Delvare" <jdelvare@suse.de>,
 "Alex Williamson" <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org
Message-Id: <1d4df22e-3783-4081-b57b-ac03cd894cb5@app.fastmail.com>
In-Reply-To: <20241105162655.GG311159@unreal>
References: <20241105075130.GD311159@unreal>
 <20241105152455.GA1472398@bhelgaas> <20241105162655.GG311159@unreal>
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 5, 2024, at 18:26, Leon Romanovsky wrote:
> On Tue, Nov 05, 2024 at 09:24:55AM -0600, Bjorn Helgaas wrote:
>> On Tue, Nov 05, 2024 at 09:51:30AM +0200, Leon Romanovsky wrote:
>> > On Mon, Nov 04, 2024 at 06:10:27PM -0600, Bjorn Helgaas wrote:
>> > > On Sun, Nov 03, 2024 at 02:33:44PM +0200, Leon Romanovsky wrote:
>> > > > On Fri, Nov 01, 2024 at 11:47:37AM -0500, Bjorn Helgaas wrote:
>> > > > > On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
>> > > > > > On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
>> > > > > > > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
>> > > > > > > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
>> > > > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
>> > > > > > > > > 
>> > > > > > > > > The Virtual Product Data (VPD) attribute is not
>> > > > > > > > > readable by regular user without root permissions.
>> > > > > > > > > Such restriction is not really needed, as data
>> > > > > > > > > presented in that VPD is not sensitive at all.
>> > > > > > > > > 
>> > > > > > > > > This change aligns the permissions of the VPD
>> > > > > > > > > attribute to be accessible for read by all users,
>> > > > > > > > > while write being restricted to root only.
>> > ...
>> 
>> > > What's the use case?  How does an unprivileged user use the VPD
>> > > information?
>> > 
>> > We have to add new field keyword=value in VA section of VPD, which
>> > will indicate very specific sub-model for devices used as a bridge.
>> > 
>> > > I can certainly imagine using VPD for bug reporting, but that
>> > > would typically involve dmesg, dmidecode, lspci -vv, etc, all of
>> > > which already require privilege, so it's not clear to me how
>> > > public VPD info would help in that scenario.
>> > 
>> > I'm targeting other scenario - monitoring tool, which doesn't need
>> > root permissions for reading data. It needs to distinguish between
>> > NIC sub-models.
>> 
>> Maybe the driver could expose something in sysfs?  Maybe the driver
>> needs to know the sub-model as well, and reading VPD once in the
>> driver would make subsequent userspace sysfs reads trivial and fast.
>
> Our PCI driver lays in netdev subsystem and they have long-standing
> position do not allow any custom sysfs files. To be fair, we (RDMA)
> don't allow custom sysfs files too.
>
> Driver doesn't need to know this information as it is extra key=value in
> existing [VA] field, while driver relies on multiple FW capabilities
> to enable/disable functionality.
>
> Current [VA] line:
> "[VA] Vendor specific: 
> MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A"
> Future [VA] line:
> "[VA] Vendor specific: 
> MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A,SMDL=SOMETHING"
>
> Also the idea that we will duplicate existing functionality doesn't
> sound like a good approach to me, and there is no way that it is
> possible to expose as subsystem specific file.
>
> What about to allow existing VPD sysfs file to be readable for everyone 
> for our devices?
> And if this allow list grows to much, we will open it for all devices 
> in the world?

Bjorn,

I don't see this patch in https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next
So what did you decide? How can we enable existing VPD access to regular users?

Thanks

>
> Thanks
>
>> 
>> Bjorn

