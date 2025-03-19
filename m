Return-Path: <linux-pci+bounces-24121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E4FA68DD5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037D8423E49
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BD255224;
	Wed, 19 Mar 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB/X4uRR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789533985;
	Wed, 19 Mar 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391033; cv=none; b=SPsAKOTRq511y7HQlMT9F9u8GZM4CHzEASDRzfBioqn/zVIfPinIKRqmMcJcYSc5hMMvVncdwvw9zkOzixnM1ECG4fSJTT48l1WNvzO/kmexbG+6X1IQkdYrztj0a7IPqdHqM2vxiq9BWA8BWnqTAFrklVTEBdktI3JcZM/j/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391033; c=relaxed/simple;
	bh=CADYdGo34yUI64OXS/Y3O3dbiajQU7zhFhsHUpgpWv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e91L66qJLYk119stpAjjbAL4RXWMiHBJTGki0TKAIFfVKopVvzvrTzh68nU1B51QWpgCk7kebdyrMgzX2YDXSoFN3CVQ5EXhu7RWazBFcrQW6LE1H/YR4OYsXxckBzI7UzV7TibsvpUHzrRC/OlDgEmBOCEGzZdj0Y6oA7wA/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB/X4uRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FFC4CEE9;
	Wed, 19 Mar 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742391031;
	bh=CADYdGo34yUI64OXS/Y3O3dbiajQU7zhFhsHUpgpWv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lB/X4uRRflJ0vnZxL6eCZS9pZl/sIveVLmLCG9ZfFwG88FFWKKwT+ZkQVzf82L9Ic
	 BPzcDGtxoCxPUoYczvGCFO1Vqxn5fsPtt4/bf/oOgdGma6ctd1/VHVKbVLttGO+R1O
	 NbLvDyWb2i3W1ObNVx9oyzfmjbV6OkvtV1m1iLl++Dnck4LUAlroXdVfAFczWXsURb
	 wXZ1bqFoWUvl7nWD+2ttTlWN6nujGj6JtY93/b/qedTgFMQkzevMZ2rJIQoZd6qLIp
	 V5VZIPv+1Qw+NYgpZhQcB0YKFKwqI3BTgnE300WumJlr6x36JbQxbxX3buzu8J+8Z2
	 y7M/hzZ2lz5Ng==
Date: Wed, 19 Mar 2025 14:30:25 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Message-ID: <Z9rG8QFRv_lQlXV4@cassiopeiae>
References: <20250318212940.137577-1-dakr@kernel.org>
 <Z9qy-UNJjazZZnQw@google.com>
 <Z9q8xcsAYhQjIpe4@cassiopeiae>
 <Z9rDxOJ2V2bPjj5i@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rDxOJ2V2bPjj5i@google.com>

On Wed, Mar 19, 2025 at 01:16:52PM +0000, Alice Ryhl wrote:
> On Wed, Mar 19, 2025 at 01:47:01PM +0100, Danilo Krummrich wrote:
> > On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> > > On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > > > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > > > changed the definition of pci::Device and discarded the implicitly
> > > > derived Send and Sync traits.
> > > > 
> > > > This isn't required by upstream code yet, and hence did not cause any
> > > > issues. However, it is relied on by upcoming drivers, hence add it back
> > > > in.
> > > > 
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > 
> > > I have a question related to this ... does the Driver trait need to
> > > require T: Send?
> > 
> > The driver trait does not have a generic, it doesn't need one. But I think I
> > still get what you're asking.

Turns out I did not. :)

> Right I mean, should it be:
> 
> trait Driver: Send + Sync {
>     ...
> }

Yes, you're absolutely right with this, thanks for pointing this out.

> 
> > The driver trait never owns a shared reference of the device, it only ever gives
> > out a reference that the driver core guarantees to be valid.
> > 
> > > The change itself LGTM, so:
> > > 
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > 
> > > Alice

