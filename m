Return-Path: <linux-pci+bounces-21522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC8A36689
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6881718856C1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E41C84C6;
	Fri, 14 Feb 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQvDgFZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD661C84B3
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562896; cv=none; b=OjSvfoEboNZnTvDHauep2dBX4kRzlq7d6MQLB7PQ9b3za6Mg12Qhs4/vDkpy9hcqTKk1G1hadJHa9tuGTyFnk/JyMzyBmJOGWfqPOx46oqUYHwRjRkziI042xhXdxTGLNMPVpQ7xixsSCnTRO9GQLNODnk+IZUROwMB7/BB/HcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562896; c=relaxed/simple;
	bh=fs7xYFFwqQ62Ych3GIExCnntjCg9FP0oNJZ6VXlIsc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZuM+9vJzb7urUO5G0e39WEVlWQ33POqv7SkP2f/SrHWgf5TwA62TrIV6wGeemTrPqgcnoiJoADX+4YC2caLeFkCI3qmgd7JrUwGvEeOGscT4Xr3iLhpW8WL0q7osmwSQDx3nUb5yByhoIbJqLZJaFYj7Xy5OxitBY3wP6CY7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kQvDgFZ8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22104c4de96so1300425ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739562894; x=1740167694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHt9IRZ4IKaZ88n4ZgqoRJKrsyounHUlYV01yRt1N0=;
        b=kQvDgFZ8I+aUqOinllnU++/XWSuKF5FeyhSuClB8D7mh8zp08OmRA2lK/R9w7e5MRY
         lBCNHxK/ye6Q+QtkZvCyas7Zehojaprjn6A49Aogj6WLjfa/DKLOKfSjXbAwpuKp2lv1
         TiiR+NVd6nm0GNqE8knoxvhgjc3WMtJKVtUDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562894; x=1740167694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWHt9IRZ4IKaZ88n4ZgqoRJKrsyounHUlYV01yRt1N0=;
        b=DxSedKx33gbYg45nXoXa11x13dmqjvUkIrsBVOjG9qcl+2CzE1B0cFFMx6nkv45B8e
         QIKxqPY9n70B1kqFOTjL/zRjWXUneU0t6JhcrnDRIJ3gyYOAblzYyGA44JEOEymrjR2W
         UvmuG6xcidtPInwOqwd1hTLuWru3iP1tfhSydKDa7FQGzXRmuIXIbBUdJNs1RjyQQH2O
         JJm+044HpLJfhoV+BydZvQ3HAIWgloCatMxpeh71LQSTfKmVfF5J3wyIxkrwkM/u3CrL
         iFP22ixbD2hm69h7tdxNfTIqjl+umxty0/naBGN3koXWF4R62kxZYXVK7kftPlSEYWFz
         oL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLKOpNLJov5TC7opHYyt6TPDCdOwmA38oPf0sshuyI3YYV5xd3wn7EzU4i7uIzJW1FV1uVS6BbN+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7Kng4jSm9hSv4xWlSvkeVJchmnUH9yOmL2DGGrIqHfW//tYB
	WvvezNtBZiQleBuBk3X50ecYZtb/vQj0nRqNy+W6WBJ4duVnbqZ9SHn2/sL3cw==
X-Gm-Gg: ASbGncupj8yEVf9GsiM7/jCso/ylgRz34RG38Ub51EcVt7UrnowTDWHvnmNtTXyljSQ
	at/OWaOPcHZvCiTUiY35XHajbxG/22JbfaHLX/UotLT9vkjSwzpMCYMkqhUhGq5J72syhPDJVb8
	8tozAZaQD9tVBMKery6F332qoZYxn6sU4UrBREW4vimvRRMZiB53Y8Kae8LPIvfUQB2wtXtBb59
	E1LFw3MUFAVcsmV2HhyTg5Vv8pJQUv0SazVCDp5uGEqiDQ/5fOAzrH3PfM1BZ/i/QxBBwKwfNSy
	d5L1o733C4bdxc0Tq3mgNaIK6U0EFF7OAZdjLMgWKfCaqLGEKOvGSQ==
X-Google-Smtp-Source: AGHT+IFXYtIWlG9Hg6lYvjF543nMuCmfOfrftEZKgk7OREhHMKPxLqd61AVNp74OUw/5VgDSh/IqXg==
X-Received: by 2002:a17:903:32c2:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-221040cf36bmr7475655ad.50.1739562893886;
        Fri, 14 Feb 2025 11:54:53 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:6ff6:65ab:3cb0:990c])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220e0232190sm28832525ad.186.2025.02.14.11.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 11:54:53 -0800 (PST)
Date: Fri, 14 Feb 2025 11:54:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Tsai Sung-Fu <danielsftsai@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <Z6-fjJv3LXTir1Yj@google.com>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
 <20250214071552.l4fufap6q5latcit@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214071552.l4fufap6q5latcit@thinkpad>

On Fri, Feb 14, 2025 at 12:45:52PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> > >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> > >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> > >gets the IRQ, affinity setting is only possible for the MSI parent.
> > 
> > So if we can find the MSI parent by making use of chained
> > relationships (32 MSI vectors muxed to 1 parent),
> > is it possible that we can add that implementation back ?
> > We have another patch that would like to add the
> > dw_pci_msi_set_affinity feature.
> > Would it be a possible try from your perspective ?
> > 
> 
> This question was brought up plenty of times and the concern from the irqchip
> maintainer Marc was that if you change the affinity of the parent when the child
> MSI affinity changes, it tends to break the userspace ABI of the parent.
> 
> See below links:
> 
> https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
> https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/

It's hard to meaningfully talk about a patch that hasn't been posted
yet, but the implementation we have at least attempts to make *some*
kind of resolution to those ABI questions. For one, it rejects affinity
changes that are incompatible (by some definition) with affinities
requested by other virqs shared on the same parent line. It also updates
their effective affinities upon changes.

Those replies seem to over-focus on dynamic, user-space initiated
changes too. But how about for "managed-affinity" interrupts? Those are
requested by drivers internally to the kernel (a la
pci_alloc_irq_vectors_affinity()), and can't be changed by user space
afterward. It seems like there'd be room for supporting that, provided
we don't allow conflicting/non-overlapping configurations.

I do see that Marc sketched out a complex sysfs/hierarchy API in some of
his replies. I'm not sure that would provide too much value to the
managed-affinity cases we're interested in, but I get the appeal for
user-managed affinity.

Brian

