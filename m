Return-Path: <linux-pci+bounces-24345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BEA6BB79
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DEC189CB73
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0626E227EB6;
	Fri, 21 Mar 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPlzFkeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31911F8F09;
	Fri, 21 Mar 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562626; cv=none; b=VuJ3DMAM67vaMqq7Jk5rGQye8kVzC5dMH3JKSuZUKJeXnVWtJm3hTDIABlgJ+kGU2ZM6ZcP+v49HTbu4q+B/L2ymQz5b74ghHw8H8CPpo0i8Ryvd1It+AlQhn1fCWC9+IY8hBnWH0rHFxpGO1TaFwCVcaBXjXruDbK3nhuBMBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562626; c=relaxed/simple;
	bh=lkJ795Xi3YIfzoTXYBWBB7Bfltn4j1dL37rIVKkwt7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCNqPcVRGVvaQqVjxg3jxYkF9Eh8PxN+rzGVv82Xked8pEccnGMDN3AFr8H4LdB4S85NxR1hBZOeQlIOW/hp76TXLfZtFayKvnC9FygXSdA1cSAHKAfJHpYGl5hJwdyIW4nD+vnsR4eTu1iobYEBB/xm/bo7iI901Rtg9fb631w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPlzFkeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC37C4CEE3;
	Fri, 21 Mar 2025 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742562626;
	bh=lkJ795Xi3YIfzoTXYBWBB7Bfltn4j1dL37rIVKkwt7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPlzFkeq2fOofhZa+osFQRaCQ1shTkGXZ/jV8VPJKhd2ycixksKj2G520II+MS/7E
	 2VC83MnnmcCqQ1tUW+HXmPf3rM6+ftCS2xhHFoBEM62RWoBxLhtr2r0FDevZ1B/8YY
	 lnQbH9am6F5k8GrNrpfe0h5Am+EIieF7PY7Rj/Fg=
Date: Fri, 21 Mar 2025 06:09:06 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <2025032149-erasure-halt-d179@gregkh>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <2025032018-perceive-expectant-5c48@gregkh>
 <Z90rlKC_S5WQzO8P@pollux>
 <Z91joggxxBh3e0d8@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z91joggxxBh3e0d8@pollux>

On Fri, Mar 21, 2025 at 02:03:30PM +0100, Danilo Krummrich wrote:
> So, maybe we should make Device::parent() crate private instead, such that it
> can't be accessed by drivers, but only the core abstractions and instead only
> provide accessors for the parent device for specific bus devices, where this is
> reasonable to be used by drivers, e.g. auxiliary.
> 

That sounds reasonable, thanks!

greg k-h

