Return-Path: <linux-pci+bounces-15100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E079AC02E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC04B21445
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E381547D5;
	Wed, 23 Oct 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfNYIbtY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B90153BF8;
	Wed, 23 Oct 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668499; cv=none; b=HmFEvEPYDUJY4DoyWTpT5vM1B/+09C7TxbveuTr+5Uz4q8bd+gYP2kNwBebwZ/i3ASQN/LY2WgOkyJhFk5eCVXZUkVM3Q+ERFFo4QEe3UhIfViDtJmSqyrSQODJNkqdCEnRSdgHzrsTdQdANmhF6F7+hTIpdR15orNHEZ4W5JEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668499; c=relaxed/simple;
	bh=L5yLsoBUR0IuLJ1N3QGS6JUyNVDuJDXCUWIy6oU9b78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a54GrtGUy0XnxZyeyzEKAOvR3U+fgOUAGPlu5keW5w6K9o5QVXwhEtJ9WORKN3mYNjkcrhmwWFXYEx197sMI5xy7ixLxcO0wJbDYoKiRSJH9A4x3oqjbYC8VvesOPD2ptlUJWR2bpmxiCex0JGaBFz97W53KU7VyBxcDxXoGMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfNYIbtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601F3C4CEC6;
	Wed, 23 Oct 2024 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729668499;
	bh=L5yLsoBUR0IuLJ1N3QGS6JUyNVDuJDXCUWIy6oU9b78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfNYIbtYFfUadbPENunNtc4OXS8S7g0+icsrnc5y+c1DPfM7VJ8Jg/BqjwlF4fCv0
	 AOq4Ko5KdqQuIEf1bFxav7GJwME49gWkJ5koLSG9GUFNHzY2Bk7cCd75SgPiG+1wZ8
	 BuncKNFMt56EfTzhXLA4+dcE7i3SiICq0IfD6vjahkFIQis8JNdqSnCdFlmYQl8AAL
	 RCUSAosxUWO/qyvCD2LsJxfYF66z7hsQ/pMosLaMAO8RL135EVTAUF/+HVWj5QboGf
	 piCqOM4YfH0o9vDbLqjC56iiJUQgCqJHP4xRHYyc93GrQMZrmxEE4DeTKRTbZCX9yM
	 iN4FSEa9cwoSQ==
Date: Wed, 23 Oct 2024 09:28:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <Zxili5yze1l5p5GN@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <2024102324-giver-scavenger-a295@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102324-giver-scavenger-a295@gregkh>

On Wed, Oct 23, 2024 at 07:13:37AM +0200, Greg KH wrote:
> On Tue, Oct 22, 2024 at 11:31:37PM +0200, Danilo Krummrich wrote:
> > This patch series implements the necessary Rust abstractions to implement
> > device drivers in Rust.
> > 
> > This includes some basic generalizations for driver registration, handling of ID
> > tables, MMIO operations and device resource handling.
> > 
> > Those generalizations are used to implement device driver support for two
> > busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
> > that the generalizations work as intended.
> > 
> > The patch series also includes two patches adding two driver samples, one PCI
> > driver and one platform driver.
> > 
> > The PCI bits are motivated by the Nova driver project [1], but are used by at
> > least one more OOT driver (rnvme [2]).
> > 
> > The platform bits, besides adding some more evidence to the base abstractions,
> > are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> > cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> > 
> > The patches of this series can also be [7], [8] and [9].
> 
> Nice!
> 
> Thanks for redoing this, at first glance it's much better.  It will be a
> few days before I can dive into this, It's conference season and the
> travel is rough, so be patient but I will get to this...

No worries, I'll be also a bit less responsive than usual in the next weeks.

> 
> thanks,
> 
> greg k-h
> 

