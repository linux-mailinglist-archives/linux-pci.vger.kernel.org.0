Return-Path: <linux-pci+bounces-37943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F26BD6069
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A520B18A5407
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A12DC79E;
	Mon, 13 Oct 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7Ou5ZpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558882D9EDF;
	Mon, 13 Oct 2025 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385782; cv=none; b=QU7haE2C1sQHBIYxN/XnjIgjs+pqIbAycUJr4SwrW5vq59NKi9anZLKQkAvxI2Kxjh+cjeiQM+qGoTmjc9KauwiSjPLK+KfnU1vN4WNl3BQyFeNDN5oQgOXxyBNngHG8UGbz3BwrbUL9Q+CIj0K1hFr7xlsXrlnICtoF8rji1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385782; c=relaxed/simple;
	bh=OEzmpW8gwiC+PBF+ovOPfuvy/Qf06cEgA6omJZRqpDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SOVjjWvuLuN4jewiWSCDb7pq4YOnTSRgWZjiZta6kGNIeAFH/y3ImAL3mf1y2HkDkhhSM9gr8H/zUj9OyClbV9MvX4nr5107as4Q6SGhKgiYM5Sdck3QO9L1U1X27Rc9Au3IfJwjeNlSGaDQYSgnGuJMFAneezEE9mzgTt0KDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7Ou5ZpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD533C4CEE7;
	Mon, 13 Oct 2025 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760385781;
	bh=OEzmpW8gwiC+PBF+ovOPfuvy/Qf06cEgA6omJZRqpDw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=s7Ou5ZpQzxGFzobcQ8kByjKFNNPFY3c4jXYwjbEdCtvOE0MvY0aWLM5FNool/iPEM
	 TMqvHj//MrvkDZ5U98eUef72i3kuq/O6DDKBTkiNZVpdGiQ8HPpW/M+dVuL6Cqg0iV
	 2W0NtQKHVMylx4lTZ7ylY809J4MUsxGaebo84KjUzfJVWLT6EOga/Z/bbJyC6tWt2F
	 hJKLiPBZjHjmWwAwXpfQFf5LNlvMDGUS50Uug4MX8QprjfTkR3cTrLY1x6hOBTenkO
	 2Anl56g2ysFH8xB/vXXvyVsiwkygbVsBlw5OMVZexKDtaIz+nP7pW2+QMJlC+twdcv
	 JBDoVZjcGuYCg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Oct 2025 22:02:55 +0200
Message-Id: <DDHGOCNZJRND.129VXJYMXMCZW@kernel.org>
Subject: Re: [RFC 0/6] rust: pci: add config space read/write support
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251010080330.183559-1-zhiw@nvidia.com>
 <DDHB2T3G9BUA.18YWV70J82Z01@kernel.org>
 <20251013212518.555a19ad.zhiw@nvidia.com>
In-Reply-To: <20251013212518.555a19ad.zhiw@nvidia.com>

On Mon Oct 13, 2025 at 8:25 PM CEST, Zhi Wang wrote:
> I was considering the same when writing this series. The concern is
> mostly about having to change the drivers' MMIO code to adapt to the
> re-factor.

For this you need to adjust the register macro to take something that
dereferences to `T: Io` instead of something that dereferences to `Io`.

This change should be trivial.

> IMHO, if we are seeing the necessity of this re-factor, we should do it
> before it got more usage. This could be the part 1 of the next spin.

Yes, you can do it in a separete series. But I'd also be fine if you do bot=
h in
a single one. The required code changes shouldn't be crazy.

> and adding pci::Device<Bound>::config_space() could be part 2 and
> register! marco could be part 3.

Part 3 has to happen with part 1 anyways, otherwise it breaks compilation.

> I think the size of standard configuration space falls in "falliable
> accessors", and the extended configuration space falls in "infalliable"
> parts

Both can be infallible. The standard configuration space size is constant, =
hence
all accesses to the standard configuration space with constant offsets can =
be
infallible.

For the extended space it depends what a driver can assert, just like for a=
ny
MMIO space.

However, you seem to talk about whether a physical device is still present.

> But for the "infallible" part in PCI configuration space, the device
> can be disconnected from the PCI bus. E.g. unresponsive device. In that
> case, the current PCI core will mark the device as "disconnected" before
> they causes more problems and any access to the configuration space
> will fail with an error code. This can also happen on access to
> "infalliable" part.
>
> How should we handle this case in "infallible" accessors of PCI
> configuration space? Returning Result<> seems doesn't fit the concept
> of "infallible", but causing a rust panic seems overkill...

Panics are for the "the machine is unrecoverably dead" case, this clearly i=
sn't
one of them. :)

I think we should do the same as with "normal" MMIO and just return the val=
ue,
i.e. all bits set (PCI_ERROR_RESPONSE).

The window between physical unplug and the driver core unbinds the driver s=
hould
be pretty small and drivers have to be able to deal with garbage values rea=
d
from registers anyways.

If we really want to handle it, you can only implement the try_*() methods =
and
for the non-try_*() methods throw a compile time error, but I don't see a r=
eason
for that.

