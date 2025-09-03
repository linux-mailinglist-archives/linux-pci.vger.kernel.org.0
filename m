Return-Path: <linux-pci+bounces-35368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86815B41F7B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F37C3A244C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980422FC887;
	Wed,  3 Sep 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IQlDaw1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBLEUrsH"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3C1A9FBE;
	Wed,  3 Sep 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903486; cv=none; b=iM2svxc9DJYYsrXZcyYulgFSCtRszzmzrzRL4qzds0Q8NCLgw8qtLsyc2hjXtyTFxgnPWicAXbnhoW77biG5Ci10FJX9M/h075YPBw/3r7nf/MuLczUQbdi90MIe+w2m+6/XdQSk5w4jiJ5QYpl5E4B5U+t8pUHMgrrOBx2EZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903486; c=relaxed/simple;
	bh=ihv0Y2/7+7DM90UD/p4zgnidKi07dGHR9J3IE5YNTso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No2yf7irnn/ssbxYXIcshBJ9OCGmnkhn6Q8poVuj2UgYl6S5DOdT9Y1bKiNTFeVdVnwEl4eGQLfG6KOtYO5HqGbbg8YEHYG+m3+M/4rBRTwrkP4865a9pnfa2lgn8Av/LCDpb6tfizyzqsRDoQsJT2+o84vmnKLCB4HWpQN9n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IQlDaw1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBLEUrsH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9A5514000D7;
	Wed,  3 Sep 2025 08:44:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 08:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756903483; x=1756989883; bh=bvV8UMNk3q
	WzyPb5Uu+AntAWNc1TzMc/W+vx04AWWMs=; b=IQlDaw1dCwrG0YDmB0LOGOAE9O
	8pQ7HVso/49lcBsyoOeA6PXKgP80I9pTHPTOprK/MTCefJhuJVrjdT7MFd0701ZR
	FkVo7/fNu/RxF9kTjC7UlYpDFDKGp147e5MCNf7qHvxqXK6P7S/YwmtrULxVLTk/
	4QbjFsAXdugBMfGC/qJs2U0Oa0PLzUyc/FmYWjAkRyVl4+qB9bwd3JYNBW8tBxlP
	W8r/+bx9THINV//EZNHzTEdwaymGQ4eX2N3fT2JXehMsBk2vm7n2ivfl+SLdwbTC
	Ccb4QflwjxwaKVgKeiM0jqM/8kAXrx1/G3I0eYGCQTpncteglKf3o9P3VTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756903483; x=1756989883; bh=bvV8UMNk3qWzyPb5Uu+AntAWNc1TzMc/W+v
	x04AWWMs=; b=CBLEUrsHweJyv0TtxHS8jKgWGa95t7HxlT8toO+2bkXj2ZHZwxe
	ZEg9nepo2xXIJCMIbYJ95KfRLl2ILq7MFcOPUW1G87lgOAcbEavvOU/8mwGGhXBu
	ficww50d+AR75+AU+hG5DdG0MAyg7bhCqSrnrvdMRPVCKO361hOi2ME5slSEDacr
	clx9UargA616C4XYvL2VgUdtPjwUEXZhXuwjrOr4okgMaKeKznFwzgVoLI+3EyTY
	ukqSDH40XbCRaVl5cpVWK9117PHMXAmrJl/8UVgV7jC4HtpsRr8eUyfg1f1afJtB
	A1b9Etd7F901Y2LfwWz0oMjL9qvS//NqEvA==
X-ME-Sender: <xms:Ozi4aIsWmrNurFvTks3GX9gNEg8WfV77a1DhG1-QIlSAuqYAj6VGCQ>
    <xme:Ozi4aP6ImQRXyGrs_Q_POXo3X1jTTA5Y9MayIZPoiX-_GaGU-EVSJKilVaqB_UfPl
    -Vuq2LCEeN8UC5LFw>
X-ME-Received: <xmr:Ozi4aLQGBsfGQAft1pmB1drmoLZ_chHUGkT-poPbuboHwEqlyAMHvoUWfMhMnmjCaV0zMHOLmghuebAYgyRksbuZI_V-RAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujggfsehttdfstddtreejnecuhfhrohhmpeflrghnucfrrghl
    uhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epveehvdfhkefhueeitddtgffgfeetjefggfetleduvdeggffhueehgefhkeekkeffnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhlrg
    hushdrkhhuughivghlkhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghs
    rdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgrlhhise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ozi4aCu0duqtBePHFXAVHGbwyPk-OUk3LcNZprjXb3wFbmOu___D5g>
    <xmx:Ozi4aN_3ekEjpLrMLrwqjfDMdunfqS0al7J8HdGjV__wH2H5AbA2Mw>
    <xmx:Ozi4aLzui9h-hbaEDodAV3I7CsdNUohYRg4wXG47kLn5_HpU4HYVjg>
    <xmx:Ozi4aP_ZCxf7LE9FH8njlftvWYKMElFcnq2oul0HdUb_AcDKqe-tPw>
    <xmx:Ozi4aLoWE0_ACk5Zeb1cTK95IEnoZMhCPhOOXlQQRaX2JEUCIZlOH-ON>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:44:43 -0400 (EDT)
Date: Wed, 3 Sep 2025 14:44:40 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range()
 iterator
Message-ID: <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
References: <20250902151543.147439-1-klaus.kudielka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902151543.147439-1-klaus.kudielka@gmail.com>
User-Agent: NeoMutt/20250510

On 02.09.2025 17:13, Klaus Kudielka wrote:
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
> 
> Analysis:
> 
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
> which resolves to of_bus_pci_get_flags(). That function already returns an
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
> 
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
> 
> Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
> to restore the intended behavior.
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
> ---
>  drivers/pci/controller/pci-mvebu.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 755651f338..4e2e1fa197 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1168,9 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
>  	return devm_ioremap_resource(&pdev->dev, &port->regs);
>  }
>  
> -#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> -#define    DT_TYPE_IO                 0x1
> -#define    DT_TYPE_MEM32              0x2
>  #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
>  #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
>  
> @@ -1189,17 +1186,10 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  		return -EINVAL;
>  
>  	for_each_of_range(&parser, &range) {
> -		unsigned long rtype;
>  		u32 slot = upper_32_bits(range.bus_addr);
>  
> -		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
> -			rtype = IORESOURCE_IO;
> -		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
> -			rtype = IORESOURCE_MEM;
> -		else
> -			continue;
> -
> -		if (slot == PCI_SLOT(devfn) && type == rtype) {
> +		if (slot == PCI_SLOT(devfn) &&
> +		    type == (range.flags & IORESOURCE_TYPE_BITS)) {
>  			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
>  			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);

Thanks for the patch Klaus! While it does improve situation we're not
quite there yet. It appears that what used to be stored in `cpuaddr` var
is also very different from `range.cpu_addr` value so the results
in both `*tgt` and `*attr` are both wrong.

Previously `cpuaddr` had a value like ie 0x8e8000000000000 or
0x4d0000000000000. Now `range.cpu_addr` is always 0xffffffffffffffff.
Luckily what used to be stored in `cpuaddr`:

u64 cpuaddr = of_read_number(range + na, pna)

appears to be stored in range.pci_bus_addr now. I can't make any
informed comment about this discrepancy however I can confirm following
change (in addition to your patch) makes mvebu driver work again (or at
least like it used to work in 6.15, it still needs Pali's patches to
have some devices working):

-			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
-			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
+			*tgt = DT_CPUADDR_TO_TARGET(range.parent_bus_addr);
+			*attr = DT_CPUADDR_TO_ATTR(range.parent_bus_addr);

