Return-Path: <linux-pci+bounces-24360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6715A6BCBE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEA9188F253
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A22154426;
	Fri, 21 Mar 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbpPINaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0378F30;
	Fri, 21 Mar 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566624; cv=none; b=YXmld0baVNe3/bgOXtULTAvBC5xW3N9jBkGceMkhe1ppd7N+WSVQ1KZKiCZP66WaiEaIYlTKOpaxlLXm0O/vqRERVzLXuGbqqN5CXFUjy0A9JdWGAjr5ydTGkTjuirkd3zBWB3UA/aGb1ZOKvQ2O9E78FbnVp97nnKAIDIlZ8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566624; c=relaxed/simple;
	bh=PPVA1fNAUhdDaHasRrNPO4YX0KSbv/bRNVmd+tmnrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH//xq6cI9jGaElkD032w2d1yWd2SR7rGDl7OwgpLw+LzrUHCJj4BY2a8hYXgFvnvu79sxhT7ZInko+EAM3K4UA3fxaQivKt4+FemOoeZgL2LOV8tjWaFs34ghdiO0L2XIC5maHdR8bylM+67QJnQ/dgQMA/ra1UnlEzssdrlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbpPINaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E85C4CEE9;
	Fri, 21 Mar 2025 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742566624;
	bh=PPVA1fNAUhdDaHasRrNPO4YX0KSbv/bRNVmd+tmnrbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbpPINaLM2qWYebZ2KO9melSvj5M0Dce+2UJzyhB3rmjUWoYG4LAMBkUQKbTojCtw
	 IYwbFau76BNx7AAMTEBDtehH5+ChpUJd5kWRQYastI44o2n9W7xnd/8yItb2KS1rN8
	 goxhqdGQ+8sipzT41KFOc0iIQFZk75KdjkQ4QqS1+ydo7a7ArWNbxtZr5qS9yzbbnJ
	 FfoQPDvqau9dPNHMrakse3IJn0cv0qyPaqY/rSEhrbKS1eTEsaEwo92r4xrPt1A5zJ
	 q7ZLTlsM4/1NdR6kmrjpGvihmH8wWtYEQ8QdngRFGzetWJIrYJrciwTtdDfbijTRcV
	 NMcGRhpFsyvLw==
Date: Fri, 21 Mar 2025 15:16:58 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z9102vdwS0RTwAP7@pollux>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <2025032018-perceive-expectant-5c48@gregkh>
 <Z90rlKC_S5WQzO8P@pollux>
 <Z91joggxxBh3e0d8@pollux>
 <2025032149-erasure-halt-d179@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032149-erasure-halt-d179@gregkh>

On Fri, Mar 21, 2025 at 06:09:06AM -0700, Greg KH wrote:
> On Fri, Mar 21, 2025 at 02:03:30PM +0100, Danilo Krummrich wrote:
> > So, maybe we should make Device::parent() crate private instead, such that it
> > can't be accessed by drivers, but only the core abstractions and instead only
> > provide accessors for the parent device for specific bus devices, where this is
> > reasonable to be used by drivers, e.g. auxiliary.
> > 
> 
> That sounds reasonable, thanks!

Cool, I will drop the patch from this series then, since when being crate
private it needs an #[expect(unused)] until actually being used. So, I rather
add it to the auxbus series.

