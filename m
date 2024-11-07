Return-Path: <linux-pci+bounces-16261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748989C0B67
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B721C2074E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB6216E1E;
	Thu,  7 Nov 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puP4CLiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44E216E1D
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996144; cv=none; b=XQNKFQ5UfvpNTQr2Gi05FREkO3xKEAda1/Ac+a5vUAsWRXeDUIxPoltISVg4WT5htgXZxdfun0PVJf5J8dUMhLJ2pth+OvJU0rjXy/i6Yd+mHT0mAgiJhjGSV0EcdGNYU8SS8G1gVshQw/BcN9ua3sU3IKkXoRkHRvjzotZqLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996144; c=relaxed/simple;
	bh=/JHbrVBz2Bo2uwzJibGD3yQrJO7xpQxhyq0XORPDEeg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=csHGCuckPnhrsQu4vaXM6pOBt3oSmPTIeEIfVFJroVnLCTwGRmEw7RYgjtwWv1z4GNWy7Ny4MrGs1kKnHcfrn9HAVIFeOYD/4fr15naLcHrJnYB3lneCphZdOYZ0WC1QqbijRF5bIo2KbXC6oD3i0g9GPjopjmbmBbMr4s8ON+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puP4CLiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C45C4CECC;
	Thu,  7 Nov 2024 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996144;
	bh=/JHbrVBz2Bo2uwzJibGD3yQrJO7xpQxhyq0XORPDEeg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=puP4CLiX/e4MecRjAuSVaSWWW7nZu+8pJoibFMTZQykgv9iIBQZgamRntJxHF6Vyq
	 PuCTA1zkdlOHf+wN041F13ru1J37+jVlzMcmOTBCdbTo3gxksjRwpQCRMCIqI/GWCa
	 2exiS1aETENvLkLzkgj8zb+MJyxEwnGYpuOUZwUlCYyfbbNLuQSeF9fLZRvGAXK0E6
	 bizQXinuKQia4jr2CL36sI1cVUNPV2UY5Z1TwF58FXJdcLffvOEyKGdnXDDojto4iV
	 L/wRzrS0n6rrCP3Cmt6y4PcRUqIBPQ8lMW0kzGsCHWkdJCd9C4++DwqKaAVX2xFJBL
	 AoCaMI5MUYeVQ==
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id D35E41200043;
	Thu,  7 Nov 2024 11:15:42 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Thu, 07 Nov 2024 11:15:42 -0500
X-ME-Sender: <xms:rucsZwBtICAjNcYVMsVhPYQYFduaIoQl9v1pYNldWotQ8wEN2LjMdg>
    <xme:rucsZyiFspNLK8cwk74ZaOzrmEJS-shtoEedYq7QeLQBgVETlIJD8-KFTqS5Yz13-
    YEfU680Vzo-nfJS5bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdekhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:rucsZzn65K58BLlUjkqLeLKc2YUo8W8Y_T1aLbKdg2qgVrkdRLV2VA>
    <xmx:rucsZ2wsvY_eluDBM1LhU6kFHIzVBJZEZuL2qZRKqPhraSZDYuM__A>
    <xmx:rucsZ1S2SAG54bJm-eRvw6WsBIdmg0_8NWlk8iC3bW9_ltr0Lwy8_w>
    <xmx:rucsZxa2G06vXOsgY5mFAuLfXpgriEEPg2XAy71a_zIFUSOletuCFA>
    <xmx:rucsZ-TcSYqZ1mGOm3owX9RkcnMZ_VHxhcuHdm0nG-Mdf75eHQjJ0mQs>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8C031C20066; Thu,  7 Nov 2024 11:15:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Nov 2024 18:15:22 +0200
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
Message-Id: <e786be1c-c368-4731-a495-b562c87e9f67@app.fastmail.com>
In-Reply-To: <20241107145941.GA1613712@bhelgaas>
References: <20241107145941.GA1613712@bhelgaas>
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 7, 2024, at 16:59, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 01:31:44PM +0200, Leon Romanovsky wrote:
>> On Tue, Nov 5, 2024, at 18:26, Leon Romanovsky wrote:
>> > On Tue, Nov 05, 2024 at 09:24:55AM -0600, Bjorn Helgaas wrote:
>> >> On Tue, Nov 05, 2024 at 09:51:30AM +0200, Leon Romanovsky wrote:
>> >> > On Mon, Nov 04, 2024 at 06:10:27PM -0600, Bjorn Helgaas wrote:
>> >> > > On Sun, Nov 03, 2024 at 02:33:44PM +0200, Leon Romanovsky wrote:
>> >> > > > On Fri, Nov 01, 2024 at 11:47:37AM -0500, Bjorn Helgaas wrote:
>> >> > > > > On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
>> >> > > > > > On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
>> >> > > > > > > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
>> >> > > > > > > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
>> >> > > > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
>> >> > > > > > > > > 
>> >> > > > > > > > > The Virtual Product Data (VPD) attribute is not
>> >> > > > > > > > > readable by regular user without root permissions.
>> >> > > > > > > > > Such restriction is not really needed, as data
>> >> > > > > > > > > presented in that VPD is not sensitive at all.
>> >> > > > > > > > > 
>> >> > > > > > > > > This change aligns the permissions of the VPD
>> >> > > > > > > > > attribute to be accessible for read by all users,
>> >> > > > > > > > > while write being restricted to root only.
>> >> > ...
>> >> 
>> >> > > What's the use case?  How does an unprivileged user use the VPD
>> >> > > information?
>> >> > 
>> >> > We have to add new field keyword=value in VA section of VPD, which
>> >> > will indicate very specific sub-model for devices used as a bridge.
>> >> > 
>> >> > > I can certainly imagine using VPD for bug reporting, but that
>> >> > > would typically involve dmesg, dmidecode, lspci -vv, etc, all of
>> >> > > which already require privilege, so it's not clear to me how
>> >> > > public VPD info would help in that scenario.
>> >> > 
>> >> > I'm targeting other scenario - monitoring tool, which doesn't need
>> >> > root permissions for reading data. It needs to distinguish between
>> >> > NIC sub-models.
>> >> 
>> >> Maybe the driver could expose something in sysfs?  Maybe the driver
>> >> needs to know the sub-model as well, and reading VPD once in the
>> >> driver would make subsequent userspace sysfs reads trivial and fast.
>> >
>> > Our PCI driver lays in netdev subsystem and they have long-standing
>> > position do not allow any custom sysfs files. To be fair, we (RDMA)
>> > don't allow custom sysfs files too.
>> >
>> > Driver doesn't need to know this information as it is extra key=value in
>> > existing [VA] field, while driver relies on multiple FW capabilities
>> > to enable/disable functionality.
>> >
>> > Current [VA] line:
>> > "[VA] Vendor specific: 
>> > MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A"
>> > Future [VA] line:
>> > "[VA] Vendor specific: 
>> > MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A,SMDL=SOMETHING"
>> >
>> > Also the idea that we will duplicate existing functionality doesn't
>> > sound like a good approach to me, and there is no way that it is
>> > possible to expose as subsystem specific file.
>> >
>> > What about to allow existing VPD sysfs file to be readable for everyone 
>> > for our devices?
>> > And if this allow list grows to much, we will open it for all devices 
>> > in the world?
>> 
>> Bjorn,
>> 
>> I don't see this patch in
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next
>> So what did you decide? How can we enable existing VPD access to
>> regular users?
>
> I think it's too risky to enable VPD to be readable by all users.

So what about to enable it for mlx5 devices?

Thanks

>
> Bjorn

