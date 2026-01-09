Return-Path: <linux-pci+bounces-44362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EBD0A319
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 14:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C215330E5EAA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833B32BF21;
	Fri,  9 Jan 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAAxs9Jc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003833A712
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963222; cv=none; b=tuseHb3ByeaoUr963muy+vwDcqR9WlMuVsrcUB8G6eZQ9AhK7wHkUm/LMCQDSJiKEW7A4ngSikwHDaJhkgNhVuxDOoxa8PxgpvQYFR1/KxddX5WWU8DKIJIIKrmUs8UBBSoDwlRFK5F4h2/+CzwhUbq+t7QYwPXmLJAE8YDRzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963222; c=relaxed/simple;
	bh=Hkx66nnLTIVqQAj7XeR6647GQj89uVC446+CkZvcUOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txOLuBi3NYqJ8p8lDoD0l0v+Hyyx2uV5Kd7JOEU+hl0e0SdYsT0WgYCaohUwklNum1TdOq5U3NyK7aiPCqiOOOQJKNDT7uFJcRPBquQx3CT4uWDLGP47cT3BltJhkSkH0FKpOvfgY3x7EQLwKh4/GjuHosp7m+pY+FkN8XsZaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAAxs9Jc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43277900fb4so1372257f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963219; x=1768568019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv775HWI4e0WEPkL5VRzfYERRHkE2h5tBkUZpacsja4=;
        b=BAAxs9Jcco5zbsJWWjIE6l3Pt/sDJAtJEFJb9QFrmL8in/X+5Ye1x7RsC489o2/KQF
         hnnYqCiyHq/yEJZUhnsETg6KnnbCjzwDyWVTNNPN7kR1uvrQmRC7ihxehjxEmDnk03VK
         IfjYnRSjxSs6LPYZj3seKzH0Pq7/xZ9ZTBG8x3ZVs9AfZ6H/uD+vFm6Y4NZXVnvB+GNb
         xgNhyHhtLg/Ba+NLIfSZFhGKo2RN5HXwejw5aGnXG6QiI2qE9/2h0PbeDTFqOXFsATIH
         cjIWCvu9xpRsJ6Wh0VsbbyVZWiiL+nlEgPUI73NkqDBMoqBJizdUEY0HaNJGqSzuNoQw
         v6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963219; x=1768568019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wv775HWI4e0WEPkL5VRzfYERRHkE2h5tBkUZpacsja4=;
        b=gYhkJ7niZxe0pZCQcpiqQOB5vR29GRx2BSPnzmRVXDBxu00mxNVeYZsiIiX3DL8aUn
         ilYFAjDobS13xvxBZKMGlh/J0lBVxkqjbrI0D+5zp6+6qZOiCALNY63mO1wUAj1Jy5Il
         Yki3I5UuT62uO9TyqHWwoH7wsIs/XwdaURuk7P9FRKCZmUqEjMFZ1PDhgj2K/BGC5gkV
         IQa91e6bT/5JI5vW5dciJhhaYFOI9GST9znQ7Y+AZWgHPweKUa6eZqG1TmGiegif+vii
         rZ41iKvoRSX2r5mUu8RCob3sz9wU/Mg9GDBP/gUs33CxQ9plPLu9B2nYKaGKS94c6X4i
         YbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXVe4Hfiy6LkXezNUfuLScfqFOanjTYQ6jBI9Mg5/JW91GYgjKX8nvjILQY+8U7CrX6KtT87aYNsKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQTmdq44B6vai/BVcfxzARJc73KtG50YB9q/kmZdU1psha8Qk
	kX+qJZozTVzRNzvMOccnmnL0R41md1rBimcBhKCrtrUQ3UCwmdi9koxrAuEDHg==
X-Gm-Gg: AY/fxX6tIeNGhxzEtOBIGMagN46AJ15jhHmOUaYB1+CIY3ULcYWjEtlOgUSCynHadTN
	djxgBO30V411ieglUP5vKsvYIs0dyHSubMGIIPO//KHURy1KpRz9PWO9cCCuZmd45sSn3l3wfSi
	Vdq0We+Qpyy6jzWM9Nu/t4iIGBQ9neZ+Wmy2M41x+1domQ2CTY/PahYEajjOGO9wsiPrt2wtfI1
	bdhKf5wfoRv4LsZiXQztR6G/6fh/zTtSKHO8Jr+w8eQ6xnuoPW9+2hCLO4ILJ48Mlv42PO9xQA3
	CZpWkxTgSmwWa4nhAfrKN6NcNpVwciLrQm2c2VSML/FfhVCeeK10AGGEzBpEF6FQObQPO8Vef/x
	ScPx3NZjkOjqpGs/PrxU9fsI8tgKcKBJHzPKQTDAaNhyaNnQAVMu/npnVNjMRhb4d90bDVkVN4d
	2TL328GVhdkb1FjSwPXKijDj2kBvnPp4GTvmdQWlJxbjmfY1+xdIQh
X-Google-Smtp-Source: AGHT+IGGFHPjbIYYQ0RqFL/SGZLHbLGBucxy9rraQ4XSfdkLMvwI3dWLkSR9K/kH4wFQyNNvym6jlg==
X-Received: by 2002:a05:6000:40dd:b0:431:771:a50c with SMTP id ffacd0b85a97d-432bcf99f09mr16155484f8f.1.1767963218992;
        Fri, 09 Jan 2026 04:53:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm24141398f8f.24.2026.01.09.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:53:38 -0800 (PST)
Date: Fri, 9 Jan 2026 12:53:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ziming Du <duziming2@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuyongqiang13@huawei.com
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
Message-ID: <20260109125337.62466956@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2601082358370.30566@angie.orcam.me.uk>
References: <20260108015944.3520719-1-duziming2@huawei.com>
	<20260108015944.3520719-4-duziming2@huawei.com>
	<20260108085611.0f07816d@pumpkin>
	<alpine.DEB.2.21.2601082358370.30566@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 00:38:05 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Thu, 8 Jan 2026, David Laight wrote:
> 
> > I'm not sure it makes any real sense for x86 either.  
> 
>  FWIW I agree.

The interface could have allowed arbitrary transfers and split them into
aligned bus cycles.
That would let you hexdump an io bar (useful for diagnostics, but some
reads end up being destructive - caveat emptor).
But it doesn't....

It is also of limited use because (IIRC) you can't access the device this
way once a driver has mapped the bar.
The driver can, of course, support applications using mmap() to directly
access device memory over PCIe.
(The difficulty is mmap() of kernel memory allocated with dma_alloc_coherent().)

> > IIRC io space is just like memory space, so a 16bit io access looks the
> > same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
> > addresses 0 and 1 so the code could use 16bit io accesses to speed things up).  
> 
>  Huh?  A 16-bit port I/O access will have the byte enables set accordingly 
> on PCI and the target device's data lines are driven accordingly in the 
> data cycle.  Just as with MMIO; it's just a different bus command (or TLP 
> type for PCIe).

I was going back to the historic implementations - like 8086 and 8088.

For pcie I know it is all different and the cpu just generates read/write TLP
with the required byte enables and the tlp type marked 'io'.
(I can't remember whether IO writes end up 'not posted' - failed to find it in
a 5cm thick book on my shelf.) 

>  There's no data FIFO or anything as exotic in normal hardware to drive or 
> collect data for port I/O accesses wider than 8 bits.  Some peripheral 
> hardware may ignore byte enables though to simplify logic and e.g. assume 
> that all port I/O or MMIO accesses are of a certain width, such as 16-bit 
> or 32-bit.

Not to mention an fpga fabric that converted the TLP for an (aligned) 32bit
access into a pair of 32bit accesses - one of which had no byte enables set!
Confused the hw engineers who had ignored the byte enables...

> > The same will have applied to misaligned accesses.  
> 
>  Misaligned accesses may or may not have to be split depending on whether 
> they span the data bus width boundary or not.  E.g. a 16-bit access to 
> port I/O location 1 won't be split on 32-bit PCI as it fits on the bus: 
> byte enables #1 and #2 will be driven active and byte enables #0 and #3 
> will be left inactive.  Conversely such an access to location 3 needs to 
> be split into two cycles, with byte enables #3 and #0 only driven active 
> respectively in the first and the second cycle.

And on PCIe (which is 64bit) a misaligned transfer that crosses a 64bit
boundary generates a single 16 byte TLP (not sure about page boundaries).

>  The x86 BIU will do the split automatically for port I/O instructions as 
> will some other CPU architectures that use memory access instructions to 
> reach the PCI port I/O decoding window in their memory address space (this 
> is a simplified view, as the split may have to be done in the chipset when 
> passing the boundary between data buses of a different width each).

Yes, and I don't understand the HAS_IOPORT option.
Pretty much only x86 has separate instructions, but a lot of others will
have PCI/PCIe interface logic that can convert cpu memory accesses into
'io' accesses - so the pci_map_bar() should be able to transparently map
an io bar into kernel address space.
So x86 should be the outlier because it can't do that!

Even the strongarm system I used years ago has an address window that
generated 'io' cycles on a pcmcia bus.

I think a host PCI/PCIe interface could do io accesses for the bottom
64k of its memory window - but I don't know any that work that way.

> 
>  With other architectures such as MIPS designated instructions need to be 
> used to drive the byte enables by hand for individual partial accesses in 
> a split access, and the remaining architectures cannot drive some of the 
> byte-enable patterns needed for such split accesses at all (and do masking 
> in software instead for unaligned accesses to regular memory).
> 
> > But, in reality, all device registers are aligned.  
> 
>  True, sometimes beyond their width too.

Which means you don't want the multiple cycles that happen when someone
marks a structure as 'packed' even though it is completely aligned.

	David

> 
>   Maciej
> 


