Return-Path: <linux-pci+bounces-38365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A21BE45C1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8816487836
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67634F46B;
	Thu, 16 Oct 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMO1c/of"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8934AB18;
	Thu, 16 Oct 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629937; cv=none; b=dFGGYFKkTvW6+Ja3gSFIkhCER59ob3729XgvHd3+Eqe0yyEELKz8vMmUmmH9FZHgPPizMa2PYtz9JT86TjxgMggC+Cq+EuLHv4F2JsBAf/IrzkGMETeFdVr+AudXEsxdklC033He7sa6pX5hgendE68Z8fP4GjOGF1CBTkqpR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629937; c=relaxed/simple;
	bh=bepnBXO8JvKsGWq7jovaFV4LZeWsgfJog+L80AOLmnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=thP9+LhgpDJ5pN7t3CS4F0npfaGuS1nAbUw47SeCYGe2P25wX1RPLaRCieM1bHFdqpKc9QDYs0CHOx0mMoFeqx8Q1ppJU/SXQsvKbpzwtrEoObwE9CW7A2Vmv9caWFdzl1EndqroSM5+MLnPN+eu44VHueMPL3izoQ55XbSJd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMO1c/of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F15C4CEF1;
	Thu, 16 Oct 2025 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629937;
	bh=bepnBXO8JvKsGWq7jovaFV4LZeWsgfJog+L80AOLmnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OMO1c/ofC6D1lpyOtXkc1zXyyQlt8C2YbYhndokvucKB/wzHw/ARZVQTEEx0wMPL7
	 Tm7NHxianAP4rnSm392QtMjleWejAKZbSPP7zIQYjfDRkV4x2I6ogx0Kz7+We3F+UZ
	 3BZ2E4E1nOdAQ/ic5P39f4vvo/hB9dx3wIvlsPhNA0+p8SMGQnaDRDQasEfPSVmVSP
	 QgaUWbBS2YagKAOpRR6YOggnzOKyoGF/gaCVtkfWP0sBPphpF/5jWT0547N/EV/Usd
	 XB4TmEAGN/Jd8+VcbihR595fkTmQKVdS9TSN1B4dX7A2cRy/aaCX7CPUzBDGGMwRzB
	 r3HoPDhFTYDGA==
Date: Thu, 16 Oct 2025 10:52:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
Message-ID: <20251016155215.GA985778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>

On Thu, Oct 16, 2025 at 02:34:57PM +0200, Danilo Krummrich wrote:
> On Thu Oct 16, 2025 at 12:58 AM CEST, Bjorn Helgaas wrote:
> > On Wed, Oct 15, 2025 at 08:14:30PM +0200, Danilo Krummrich wrote:
> >> Move the PCI I/O infrastructure to a separate sub-module in order to
> >> keep things organized.
> >
> >> +++ b/rust/kernel/pci/io.rs
> >
> >> +/// A PCI BAR to perform I/O-Operations on.
> >> ...
> >> +/// memory mapped PCI bar and its size.
> >> ...
> >> +    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
> >
> > I know this is just a move, but "BAR" vs "bar" usage is inconsistent.
> > I think "BAR" is clearer in comments.
> 
> Yes, I agree.
> 
> >> +    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
> >> ...
> >> +    /// Mapps an entire PCI-BAR after performing a region-request on it.
> >
> > Similarly, s/Mapps/Maps/ and s/PCI-BAR/PCI BAR/
> 
> Thanks for catching those!
> 
> I think we should fix those in a follow-up patch. Even for trivial things, I
> prefer not to fix them with a code move.

Makes sense, thanks!

