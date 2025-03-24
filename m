Return-Path: <linux-pci+bounces-24549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F3A6E08D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC89188DE10
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2A26460D;
	Mon, 24 Mar 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg6logt6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5324264607;
	Mon, 24 Mar 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835932; cv=none; b=twyGg9tWYKgOE/BkcB2aXG7JUx+pWGvm5SEVlrXFbQobuwdQzC1OUljUeTgHseRN/K3lsfH7DA7eW4eQoiQCiQBdQ6uzi7Z+HCi2IhsiKahRvkXuFf/5CLtxVaek5pMTGqoxoI3mdTlaYkG9wMAz8xmo/vZLFuU5dex2kf00i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835932; c=relaxed/simple;
	bh=6TuJgDwAnlJf1BXNV9Eh5XON1xFBMYMniID/jcyT6y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNmbCN8fQNk3Ru180J9i+fMzO5XdTUjE0ejMTFATT5NxIiRHaMjvq2n+YatCkiBkEGDNnSqpVBz/6JNvTwa2C/dTWhoYK8Q+TGQFtVFLOAd6UmENPQDecoss3j88BE/Ukc9aKpxPttdo/kImdbMzPIDSmnbqICcmiIz0lcG8swM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg6logt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47620C4CEEA;
	Mon, 24 Mar 2025 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835931;
	bh=6TuJgDwAnlJf1BXNV9Eh5XON1xFBMYMniID/jcyT6y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg6logt6N7OhzGuFQJb4ClhS0z2TLQSMhKf5jNeiwstWpuJ572kmRUWB23fkkcxTa
	 UqtzZSHVjxHMur6i99oh0Lb0wgh3JEI8cii2BZ8UcyfZw/D6bw/Jrp3WcKyDDUqVqG
	 zWfLW2LAEocyJL4uLLRgOvV7//9SSTcU0aB93UKmVhtKlzBDA9ws+Ubdipt+olBgoT
	 nQJXMuGO26Gpc1tYQfz1WjEfJt3MJ3dD8brgcqFpRMsGLcA3gEofVY5LbLwSylgqB1
	 +rhpFnOFAe6r3Uwv9l1VdVp6y/vWnUIaIqC/zqjWMMdDQsmKlry1jy2i9RvxynRCqE
	 ca4La/ngS/hdQ==
Date: Mon, 24 Mar 2025 18:05:25 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z-GQ1fWBQFaT1tEq@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-3-dakr@kernel.org>
 <2025032158-embezzle-life-8810@gregkh>
 <Z96MrGQvpVrFqWYJ@pollux>
 <Z-CG01QzSJjp46ad@pollux>
 <2025032455-elk-whoops-3439@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032455-elk-whoops-3439@gregkh>

On Mon, Mar 24, 2025 at 06:54:47AM -0700, Greg KH wrote:
> 
> Thanks for the long writeup, that makes more sense.
> 
> Ok, I'll not object to this change at all, so if you need them to go
> through a different tree, feel free to take them.  But as I think it's
> the merge window now, it will have to wait till -rc1 is out.

Yes, I'll have to figure out what's the best approach of merging things.
Considering subsequent work, I want to make sure to create as few merge
conflicts as possible.

