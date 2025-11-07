Return-Path: <linux-pci+bounces-40571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F85FC3F293
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86674188E548
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC12F531F;
	Fri,  7 Nov 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MMhI1e4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB53019D0
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507821; cv=none; b=tBpUcLP7LfKJ87bkwVaj+N2L5DValpk8AiaBQXlEEDVcOmlJyXqcmWAxhlRwvduHLsD2BLvlb8EMmllBFP/v6MUi/fW0hAsSMOZfXXN7OWw491BBbzZcmlT659LFOj9zZ6OADUxUtUESOJ/JPHdP1Vb9IanPnxlLjTle4+fBCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507821; c=relaxed/simple;
	bh=SwJLlE2AkOO378JrL4qmCfg4Qvay8egK8wqxu7zyKro=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX8nt5QGan4SY3RBpYEN3HO/W+u4gbFrX6UKfO9l7tMNtcgHGN/Hr0GvGYCV2aT3EEZfJTFYP/TtSKa1PrOaBlXxnZcEBzzkft9JEBlo1OGfhxWcWWYSploAk8CCnDvw4YEadk4qpGNQyiPOPK8htTnbMzcETPAnTHYNnD4Enfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MMhI1e4T; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b729a941e35so61794866b.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762507817; x=1763112617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gy6h5/T7M3l4IMK+9pDxE4Cljvnhz0/urOMxkuv01vE=;
        b=MMhI1e4Tfr5KgfuODVeOKfzibomy95XxiYUDtJAStTCYe7pwMFMd6YrYoRmlx3/gyC
         I8cjWJV3kvg8h+aOMYBdMLsUyRxNdhqZkNXyplpUPwMROGcc5biNURJcrg/0YRwCcZxG
         pGr33JmOrTj5BOEvubejuVyNQGjjGRh96G5z+Bdk869dDCIKQY4QPNBRLmePkkwJlBxA
         V2juagMHwg2EddZJLJNmqrXJcNL758EIkkPh0N4+mCtRDm0QvCGtklYPZZkvVzDhKW3S
         37Lvk4ahwizJvSoxkfqVaNPqD2A6fYoj6JgF2C2TdsXm4r212CRui+dpPz1guIkX8oh6
         VQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507817; x=1763112617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy6h5/T7M3l4IMK+9pDxE4Cljvnhz0/urOMxkuv01vE=;
        b=FRVY3qYggTuZL6vN3cJxEZdBX3Y6ui3o48ZvXgdubTIJnFVTAFnX3JDTO68K5kyQxO
         XC8xXNuE4Udndy5hVf5LazomwZEjaL4WLq9UbxICK8KYDhTiBVHw1dbrhF3P3MS2EbKP
         M3seAJWmN4TJrs7tkDz6bgPpLLOC1Y48G5h00K+tSYyOqHooQ+8FFB1jDrr3BNlQdL6I
         L4/qhi0MK+kn+b3BdHSAVKBgJiwdwVq7SdpnjH1RY6BNOk4kYf6i36evc/5TCzWEYufb
         eKSzV38+DHnW47novjfNkKqq3KnQPyZF6+7Dgr0GNAjcFvj16oDRDVtuBe5g+jR4mzfK
         MOxw==
X-Forwarded-Encrypted: i=1; AJvYcCW9qU445liIzyG8UmQFqONUrSxDLhR7EV39QlExjYyTmwiKrYIx0QUNsqzq5BNWO+l7WS3ANo4ukUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaH0iSymzuoqCufDasAWJ+qOkuYKB0iZu9QMfqJiU/FS4KIpg
	mzYQectC0aqKWp5kgzlls2nbQMEgvy12++74e9dvf5f6YyuxqVOcnbg02n3dDVUd8Uk=
X-Gm-Gg: ASbGncsqWlJgMbW6Bboc6Xq7rKP2mH7QkbWMHoBBizMqLrkh16hdVIgT3kVNdzFbSlN
	CZuOqzHrXYTJJVXlDPKE41sAdYenqf7DSs1kbvMve0PBt1V7B5GelSbc6giP5hHf59OufgJ3WiT
	zVtCrv2ipr2Brpr3mJs9yfovhgThhN4qHOVGChJS55EdQjwp6Fs0WCQzetICycS1tVdVrPJP+JQ
	Q+ZhTV80kyhYDTaKQsoyQEyOus488hEOClXkvgEblVzc3h+rUg9UK2+Wv+WqdFcOpUAQe3m3UXS
	+EpxHkKKHAIdT+QLIwGIEF12Crvz+IlD66X2GGj2eBW8B2IV7FjY2FymavoG1cJTc/Wssgmufp5
	mjXtcU1CzYfdnteqw9v9GggI5pr5I8uDnlIsGJF5L9DQS4srnMaLhW0R60M2vSSuozHuHXMwWzT
	bEU3VqHMj8h1alaxqs48wsFZv4BmRsXkjtkBhQBRe5AZY1vg==
X-Google-Smtp-Source: AGHT+IHI9DcNoJfkJq9DrDwBnkr3wsYuG0mhZSa7sa5K0gcWfHFJNf1GslBK48VvaOflc7tVk9XiGw==
X-Received: by 2002:a17:907:3d8f:b0:b70:b93c:26cf with SMTP id a640c23a62f3a-b72c0a62ee8mr227241366b.6.1762507817063;
        Fri, 07 Nov 2025 01:30:17 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e54asm192846466b.34.2025.11.07.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:30:16 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 7 Nov 2025 10:32:35 +0100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aQ28s57R0YfrqwdG@apocalypse>
References: <20251106182708.03cfb6c6@bootlin.com>
 <20251106175016.GA1960490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106175016.GA1960490@bhelgaas>

Hi Bjorn,

On 11:50 Thu 06 Nov     , Bjorn Helgaas wrote:
> On Thu, Nov 06, 2025 at 06:27:08PM +0100, Herve Codina wrote:
> > On Thu, 6 Nov 2025 16:21:47 +0100
> > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:  
> > > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:    
> Patch at https://lore.kernel.org/r/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com,
> added back for reference:
> 
>   diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>   index 3579265f1198..872c36b195e3 100644
>   --- a/drivers/pci/of.c
>   +++ b/drivers/pci/of.c
>   @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> 
> 	  /* Check if there is a DT root node to attach the created node */
> 	  if (!of_root) {
>   -               pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
>   +               pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
> 		  return;
> 	  }
> 
> > > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error
> > > > > > > message is generated if no 'of_root' node is defined.
> > > > > > > 
> > > > > > > On DT-based systems, this cannot happen as a root DT node
> > > > > > > is always present. On ACPI-based systems, this is not a
> > > > > > > true error because a DT is not used.
> > > > > > > 
> > > > > > > Downgrade the pr_err() to pr_info() and reword the message
> > > > > > > text to be less context specific.    
> > > > > > 
> > > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > > pci_register_host_bridge() path.  Does that mean every boot
> > > > > > of a kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT
> > > > > > system will see this message?    
> > > > > 
> > > > > This is the case, indeed. That's why downgrading to info seems
> > > > > sensible.
> > > > >   
> > > > > > This message seems like something that will generate user
> > > > > > questions.  Or is this really an error, and we were supposed
> > > > > > to have created of_root somewhere but it failed?  If so, I
> > > > > > would expect a message where the of_root creation failed.    
> 
> I think we should just remove the message completely.  I don't want
> users to enable CONFIG_PCI_DYNAMIC_OF_NODES out of curiosity or
> willingness to test, and then ask about this message.

Agreed. This would be the easy solution, the other being creating the
empty DT so that the message will never be printed. But this require some
careful thought. The latter solution will be needed if we'll ever want to
make drivers like RP1 or lan96xx (which uses the runtime overlay) to work.

> 
> "You can avoid the message by also enabling CONFIG_OF_EARLY_FLATTREE"
> is not a very satisfactory answer.

Unfortunately this would work on x86, but not on arm. And who knows on
other platforms.

> 
> A message at the point of *needing* this, i.e., when loading an
> overlay fails for lack of this dynamic DT, is fine.

It seems fine to me.

Thanks,
Andrea

> 
> > > > > Not really an error per se: on ACPI system we usually don't
> > > > > have DT, so this message just warns you that there will be no
> > > > > pci nodes created on it.  Which, again, should be of no
> > > > > importance on ACPI.  
> > > > 
> > > > I my last understanding, all architecture (even x86) have the DT
> > > > root node set. This node is empty on architectures that don't
> > > > use DT to describe hardware at boot (ACPI for instance).  
> > > 
> > > This does not seem to be the case for all arch, see below.
> > > 
> > > > This DT node is needed for PCI board that will be described by a
> > > > DT overlay.  LAN966x for instance.
> > > > 
> > > > On v6.18-rc1 kernel, I successfully used my LAN966x board on a
> > > > ACPI system.  This means that of_root DT node was present on my
> > > > system.
> > > >   
> > > > > The only scenario in which this message is actually an error
> > > > > would be on ACPI system that use DT as a complement to make
> > > > > runtime overlay work,  
> > > > 
> > > > It is an error also if you use a PCI board that needs PCI DT
> > > > nodes (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.  
> > > 
> > > Yes, I was referring exactly to that.
> > > 
> > > > > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK
> > > > > this fw is more a PoC that something really widespread and
> > > > > currntly the overlay approach is in stand-by anyway (meaning
> > > > > no one will use it unless some major changes will be made to
> > > > > make it work). But there may be other situations in which this
> > > > > scenario could arise, I'm thinking about Bootlin's LAN966x
> > > > > driver which also uses runtime overlay to describe thw hw.  On
> > > > > ACPI system the root DT node is not created because
> > > > > unflatten_device_tree() is not called.  
> > > > 
> > > > I am not so sure.  My LAN966x board is working on a x86 ACPI
> > > > system.  
> > > 
> > > Indeed it depends on the architecture. On x86 an empty DT node is
> > > created, provided you have CONFIG_OF_EARLY_FLATTREE defined (which
> > > I guess you have, even if it's not in default config).
> > 
> > Indeed, I have CONFIG_OF_EARLY_FLATTREE = y.
> > 
> > > On arm64, ACPI and DT are mutually exclusive, unless the DT is
> > > basically empty (i.e. only root node and chosen node). The DT root
> > > node is not automatically created if not provided at boot, though.
> > > This reinforces my idea of providing the only root node DT on arm
> > > as well, but I'm not entirely sure about possible side effects.
> > 
> > Isn't it possible to have the same kind of operations on ARM64 ACPI
> > and on x86?
> > 
> > In order to have CONFIG_PCI_DYNAMIC_OF_NODES working on ACPI, we
> > need a DT node, even empty.
> > 
> > ARM64 ACPI without an empty DT node means that no PCI boards using a
> > DT description will work on this system.

