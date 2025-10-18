Return-Path: <linux-pci+bounces-38643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FEBEDCD5
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 01:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FAB427AAA
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D1262FCD;
	Sat, 18 Oct 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BZ6S2Xs4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895C25C6F1
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760829090; cv=none; b=TWbDCYq5cODya8w18a0QbhBXQAkTxJLgAoSFDr3xPFPdhRLXll5f2dtISsW5PngoGGCC4DM8PpVsHD62hehueeJhQyoSTdMDThTnVMmgaWyuaisVQwg7KQh1I03bdyR8OA0MllXhhA+10R8Iuq1rFJW071VKPuDYgiTS9F7I5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760829090; c=relaxed/simple;
	bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGTUrXMo0T/0XWv2AAyZGP1aQnb7wb/HCcYpzxuAoYntKR8olYKCm0QoR7+tUqxomBWWP424lVoCOQkPgNVHA4EjhAPPitbWjcw3D/nDQB9Jc5P/FAZplYDjBfRJDXU0PmtQa92AZXM9d2HDeN6rPc3bx2EOt0ut9N3IXEGle9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BZ6S2Xs4; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4433456f043so1581479b6e.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760829088; x=1761433888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=BZ6S2Xs40U9WQeq7NwydR9GbhQbdvOjDSv4Qbr9KKeCYizlk6xi5vEFooSbU8ymvLl
         WSBq5lAT1yCWnNc6H16VrjD0JeAdPqqNvYBxmG52hVSP/t1bdV0YhO0yBVZQ+S0wsrpY
         /QPFLN0zDpppP7ApdEaqJsD1GF7o5OP+bYGjdmMJOGm/Kt6tuFeThxoQFTLzXKtqoWHh
         CteSEOebSSDXqi99VukwnkUrG/AMT9Obl/oLUprKxkOT9lYdjoQ17DHql8pZX8V6Y37P
         TrqnH3iTSdnsI1yr9Uoy+JIq0ccrtZoBfQcv+rDIlNoL4H0lhLQyB623WY2d67VJJy9j
         0TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760829088; x=1761433888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=DjCc/pTsuuPUScFp6R1pz90IAo3+APCVST9G/52Rp8SkbMDv2xs/MY6U6L4aTWpj5R
         GOxj+ZOPg59Z3KF/+TiBazLF3PL/HnjdlNtWSU7pZBfDoYcx592lAPYRZonZ1UMFjSQd
         7S5HWLzw+PFUqPcL+8L/Wo7ou9blNAaV0e3AHaoqxyTASVs7gJ7GyNvjCGXig2p8haAp
         LBnD4iprUVK8pnKUZmJi6OeYAlTnc+6puDHra5HYMzmyzcxIOJbY9NTWZLnSx1djKJEG
         ynVHIEL1/p8Pq4l4CyJNGuky8tmhy0Ig1F9mr5/54Q7u8TRNBgElxrKvzyNquzvPNFeV
         Ha1g==
X-Forwarded-Encrypted: i=1; AJvYcCXXkwySC3JTDWDX58hDv1MLHNk3z3f/3IUQjBQI5lrh+pKLwAh0FLOhTQ+yMMmCY9qL7incs7TH8fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXm+QwegnLARAPKwDTTYwZkVT29P5dc8JVBeoPY3VO6r9wx0n
	/l4/oINtswVLsvxsTjS20mAjxFYHhdEL9KSleXy6RUAdXKAtsvRheAuD2aT+K7FXp00=
X-Gm-Gg: ASbGncvUPfJlXSf4Ia1b8MyXfeYVC5W0NzyBrfTozZNdyofqCDGLATA+NuWC6wAbbmm
	IWAbZ+6QIydkCLpJfBfiwWwQCD+0b8Ps9/hCcQYgW/T74k6tSUzAHY8JpeZ6IJMU3f/E/tQLs/r
	JjBspUz3pYplRS8EcniSYZtYu9eRi3t5dk+FaOKcmJsNGqc4vutk6RNvdfm43JMfq2jdIyrzFcg
	KmFu37XOdPvOXFapgqeGboWIg6qZhb+Fjf4D7Zlhl2QhwV2KETon1nmBrTSLFfA34fvxF8C43C0
	v2xBVrVjiYzaoPKYM8I4qVAhOSnmiydAi8ws9LHnfiUlPWvdCmo1n5IwMI6ZJ7dZR1SZikJQjYd
	hxKDRxJKpyL5S1OPrDosQ5nGvuNTbak6/9TuiMpu+9IVOUhGcBDaTNkF3OLN9
X-Google-Smtp-Source: AGHT+IGjutQW9FOpunwPbl54R4lmphJmatLWLrvDMN3YzWlbvrTlVJ+kuMrXHSfrl8ye5jNWMdw9aw==
X-Received: by 2002:a05:6808:2388:b0:43f:5fc5:e04a with SMTP id 5614622812f47-443a30af9cfmr3465468b6e.31.1760829088069;
        Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651d3f8d640sm899440eaf.20.2025.10.18.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 16:11:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAG58-00000001dfK-14RB;
	Sat, 18 Oct 2025 20:11:26 -0300
Date: Sat, 18 Oct 2025 20:11:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251018231126.GS3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018223620.GD1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:

> Having __packed in my version of struct, I can build validation like
> hardcoded offset of members. I can add version number (not added in this
> series) for checking compatbility in the struct for serialization and
> deserialization. Overall, it is providing some freedom to how to pass
> data to next kernel without changing or modifying the PCI state
> structs.

I keep saying this, and this series really strongly shows why, we need
to have a dedicated header directroy for LUO "ABI" structs. Putting
this random struct in some random header and then declaring it is part
of the luo ABI is really bad.

All the information in the abi headers needs to have detailed comments
explaining what it is and so on so people can evaluate if it is
suitable or not.

But, it is also not clear why pci serialization structs should leak
out of the PCI layer.

The design of luo was to allow each layer to contribute its own
tags/etc to the serialization so there is no reason to have vfio
piggback on pci structs or something.

Jason

