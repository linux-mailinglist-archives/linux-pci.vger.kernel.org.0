Return-Path: <linux-pci+bounces-10272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3C931924
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB251C21689
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D163FE4A;
	Mon, 15 Jul 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti+72qJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B544D5BD;
	Mon, 15 Jul 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064109; cv=none; b=qzPqEnQDSsuYxQmME/Bv5yOj28oC+6gRV76QDfeg7CMhnx3kKlZs9yVDI9fRENPfSwW8mIPv9k/69FHKKmKkfAAUtHk1hjoLeJZcoXBG7Dw9WDkEI3SxN7XcsHNiYns6E/uYAZAizTaPc9JYQb262UFNb9+DgIXXDOjaekLmMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064109; c=relaxed/simple;
	bh=M4qDMU3Hq3kx+y4SC+whQpJUYyfwWTVo+aynzafuUHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVdO9TNfCXBsWGKXLfx/zULaL+QUyYzLamrbScdeNbfuEQwOJZNl6jJdjhaATNC0QAI6ZyBJaD/hY/2wetWGRfbVMmrNmXInKvUpnU5rPJbcZ05C2ZmV1+pt10NJveyj/jc13+XI9Q0FUJ5zmsgpfLHJJlIxHntv1Vn6DE54VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti+72qJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65CC32782;
	Mon, 15 Jul 2024 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064109;
	bh=M4qDMU3Hq3kx+y4SC+whQpJUYyfwWTVo+aynzafuUHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti+72qJAmoeHrwIXCoFgfFRT+GueF1MvYq0ladD08zsp6iD7ujiP8iqWRW+9Lmyez
	 /rhYrrau2gfBtC5wP3Skg1HlscbJSBuoh+mhi/w+f+CEcT06cMXdAwA4JDFaAucVsC
	 HtSDcO1EVSiGYVQRf3aTo9jvNzA6MtUJLsHabspDW76+wlnuxyOUKG38EyeJS5oRe/
	 HGlyZK1++TBstxocf+Cl5jaW8sDxqRC+I1XOZpqHfgcPkRyF6lzPnMzeC9GPYz4dsi
	 TKPYv/U3gCIXKEOGL04YJwdQSJOB6WmgC/lL6cLbGw6SZx59tcrHCDqNXziUV87dgq
	 /w+rT5POzzPBw==
Date: Mon, 15 Jul 2024 10:21:48 -0700
From: Kees Cook <kees@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <202407151005.15C1D4C5E8@keescook>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpOPgcXU6eNqEB7M@wunner.de>

On Sun, Jul 14, 2024 at 10:42:41AM +0200, Lukas Wunner wrote:
> It's probably too early to decide which actions to take if a device fails
> authentication, whether to offer a variety of actions (only prevent driver
> binding) or just stick to the harshest one (firewall off the device),
> when to perform those actions and which knobs to offer to users for
> controlling policy and overriding actions.  We may need more real-world
> experience before we can make those decisions and we may need to ask
> security folks such as Kees Cook and Jann Horn for their perspective.

I don't know PCI internals well enough to have any actionable opinion on
many of the aspects of this thread, but I can try to give my perspective
on the mitigation behavior at least.

My main observation is that the CC threat model of "we can't trust what
is attached to the bus" is an extremely high bar, and is not the common
threat model for most deployments.

As such, it seems like any associated behaviors need to defer to common
deployments. It may just be as simple as making it a Kconfig option. That
said, the best practice for such specialized behaviors is actually best
put behind a static branch so that distros can able a given feature
without making it on by default. (e.g. see the randomize_kstack_offset
boot param[1].) Given the "module or builtin" question, I would expect
this will end up being strictly a Kconfig, though.

Anyway, following the threat model, it doesn't seem like half measures
make any sense. If the threat model is "we cannot trust bus members" and
authentication is being used to establish trust, then anything else must
be explicitly excluded. If this can only be done via the described
firewalling, then that really does seem to be the right choice.

Now given what a high bar it is to not trust the bus, there are a lot of
attack methodologies that likely need to be examined. For example, the
bus has a different lifetime than the kernel, so it may be possible that
members are attacking each other/the CPU/DMA etc, before Linux has even
started running. If that can't be mitigated, then it doesn't matter what
Linux is doing.

This is why I've kind of tried to stay out of CC discussions: the threat
models can be extremely hard to wrangle, and much of it depends on
hardware design. :) I have enough to worry about just trying to protect
the kernel from userspace. ;)

-Kees

[1] https://docs.kernel.org/admin-guide/kernel-parameters.html?highlight=randomize_kstack_offset

-- 
Kees Cook

