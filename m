Return-Path: <linux-pci+bounces-26284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE91A9437F
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD323A6649
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96887185E7F;
	Sat, 19 Apr 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6qYShQc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB42AD0C;
	Sat, 19 Apr 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745067473; cv=none; b=ji4B8nj/QKUUsnF5aJ+3D520o7BsoFaA58+ZhZ2rzAauXb6w8TS3hnQWo2ZqO4MchRazdYANOFubQSpRVxVrCAJnO4lZSWjW/A3bRZKSrOxH9uHyrl4IvgtjW8qxRRwKeQofytXT7WG0TyfRzVIkop3ovQm2l40Ihmyrdo7Y/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745067473; c=relaxed/simple;
	bh=Ww5QipkZahala/LObwRqFjdUqfx1t+6o23DPXOZf1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usXzExqvYyyHeHHXgsNUh3tenJEcHFzNLGl5xG6wJkj8ccuS8Nyu3RAFfHlB+4/ESReeLplU2Am7DhCwaoyxUwmUgRgLB7HOUyimyiAEq8qdSGffC68cuE2FvqVMvo4ULkM1XytkFlFcP0qcXL0fRb3O80iuPGmlDkj2TIErJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6qYShQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E716FC4CEE7;
	Sat, 19 Apr 2025 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745067472;
	bh=Ww5QipkZahala/LObwRqFjdUqfx1t+6o23DPXOZf1Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6qYShQcJGZCMqUIi24LWVuFNEQjPvARxmGG0QXKt2RedXvmA7mNcn5bRJH2xir5j
	 8+XgsJbzKpDIo8KCx+rVsmOaW2/Gkv30OPMnf7LTmCz/fIJmAYCzo+NqegD9IZPQQI
	 nl9JX4nY6/rkmjJRzD6lRw5xCMqG4e/jWx55QY0e3oZlcy11SstunZUDR6hekjLRNC
	 SPuTgFIET6XStteRn9OX6F+3kuQDaKPdYU2l7pzK945mMUHeJZpo5w8FkDEMRaTGxs
	 QNopUDOFdB7ttOXUNaG2gXmNEYPfKgDClLl6COH7e3HGr41QtgCFjLVpIVGS9ulX5C
	 xzpXFFjdgp2mw==
Date: Sat, 19 Apr 2025 14:57:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Implement TryFrom<&Device> for bus specific
 devices
Message-ID: <aAOdyzjHlCYYyOto@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321214826.140946-1-dakr@kernel.org>

On Fri, Mar 21, 2025 at 10:47:52PM +0100, Danilo Krummrich wrote:
> This series provides a mechanism to safely convert a struct device into its
> corresponding bus specific device instance, if any.

With the following changes, applied to nova-next, thanks.

  * rebase onto [1], i.e. make TryFrom impl generic over device::DeviceContext
  * drop Device::bus_type_raw(); use dev_is_platform(), devi_is_pci() Rust
    helper instead

- Danilo

[1] https://lore.kernel.org/lkml/20250413173758.12068-1-dakr@kernel.org/

