Return-Path: <linux-pci+bounces-23770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B6A617C1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B722170CD6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC10204C11;
	Fri, 14 Mar 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0qOFIXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301E204C0D;
	Fri, 14 Mar 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973515; cv=none; b=khhhi9EFFnlsOlgt+artCFBDS9DNnHIYN+lQJ8WiIT2eD1dAvI7kkTvxMSjKqmmNaE3Al3b1XJBma6Rt0a0gjz5RpErp+cUHSj1iiHG9TZ9HCo57WU13GzFUsHPqQ7znnZpeVcp+58sncHxOuAbImT6bjyOOQ+zj0jm3v4MZjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973515; c=relaxed/simple;
	bh=og9U6wqzCSAWLnFEe2nPzBgfKbgmyVXzWTGq8RgpJ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk804//F7wjHpORcW2zs9Yud0Dcd2Rw7c0hiWsPh4vumsP0aCsdn3AMeW8EYuD8jpEXuFYcMhP/VfXw4In5PNFymOozj1+wy07DvZ/Q2Nvk4lLez60Yq+51Ft4ukeEuWdwMdLq26krz7/P6KeLpdvcQqxPB59YSkPW3dwKsLI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0qOFIXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED740C4CEE3;
	Fri, 14 Mar 2025 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741973514;
	bh=og9U6wqzCSAWLnFEe2nPzBgfKbgmyVXzWTGq8RgpJ3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0qOFIXUg4JWpcibNwNfoiloucbBlOp2T4yt/hKYOPM+pS750X/psWtyJPGNFuOU6
	 /8nugG9iTLcRDDBU+zmlzD7Gky7yArNZ9bx1Ql55PcP+6nzlAkJXJfovL0kPBEOp8m
	 E4xeWNCHNEkh/QtI3txE8ddIZKcoG6C+Dq+AsVdiwRXp7IDS4+OlDMq8HxAp4QzeTc
	 Riz1I96lBvMXpeseaRg9YwyTW/LnlzF39Z9arD1Gwt9YOapvOVe4vRn2GhKLvlXWHa
	 AQT2UlqEwekfEIXdvjN+Qg/aDe8cF0X81u7GrkqPVbcGmLp7X+vjrWHCXcdMLY3znV
	 Hr1gujy+GhEXQ==
Date: Fri, 14 Mar 2025 18:31:48 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rust: device: implement device context marker
Message-ID: <Z9RoBMXWsrjg6jjg@cassiopeiae>
References: <20250314160932.100165-1-dakr@kernel.org>
 <20250314160932.100165-3-dakr@kernel.org>
 <67d465bb.050a0220.d2e19.8fc9@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d465bb.050a0220.d2e19.8fc9@mx.google.com>

On Fri, Mar 14, 2025 at 10:21:58AM -0700, Boqun Feng wrote:
> On Fri, Mar 14, 2025 at 05:09:05PM +0100, Danilo Krummrich wrote:
> > Some bus device functions should only be called from bus callbacks,
> > such as probe(), remove(), resume(), suspend(), etc.
> > 
> > To ensure this add device context marker structs, that can be used as
> > generics for bus device implementations.
> > 
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> 
> Try chronological order for the tags? It was suggested first and then
> reviewed.

Is that a thing? When I apply patches I usully keep ACKs, RBs and SOBs together
at the bottom.

