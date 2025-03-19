Return-Path: <linux-pci+bounces-24131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A04A68F09
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6533B8FBE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B1E1C3BE8;
	Wed, 19 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcjEQRe0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D51C5F2C;
	Wed, 19 Mar 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394332; cv=none; b=TeLpeJYIUTOzmx7rtdJyNLIAufFAuoTN5bXd85PwmhXnGaxoNNUdIzyGToAbknnYL0VUaKrAUqxEdrcQetLouE2hujkl5ctYceQqBcjYtpgjlBscjC1lcxx1t9yNZoePR5fJAFWBEzQGC0zINppWtD5H9GYCYjO8io+FP/gJPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394332; c=relaxed/simple;
	bh=a2iWg/O67JIEPXhrX1uo9DdqqHAnP4v9NGHzDu33uhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhQ7h7QtXwy8KiLECjDn8WL/tjJAMzCunDOBrnrYHggKS/Jim3+QJ4xu+fPg6bA1NRN8HG87hPqoqVOPLCmqfkTsrYzULUVq1J6GsgahUt03kPkxWShCHMrvGFwLTJbWY16ug5dh+5MUYh0a0FBINKgBqCiNIbegHZhHvZoR2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcjEQRe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F56C4CEE8;
	Wed, 19 Mar 2025 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742394332;
	bh=a2iWg/O67JIEPXhrX1uo9DdqqHAnP4v9NGHzDu33uhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcjEQRe06Veu1SYlHZjFHNTjM3KsNymwigy8U6ZUERiOqz9UBgKGxC3ALrkpohILS
	 nLI+MBZ4aQjqoNPrdWuvquQvevrd1bb0Za+BYunNb2rFSUvltlE89dWpQwqBZskQN2
	 VZLdHku1cSYiNXUC+DAXOfCDHfpgHt+Gz5q+91SKTins3oOXsCEYGhlqseG08aw/Nw
	 9pwDw83p6pJ87EiOphPiRmoJJ8C5eUPU78xblx5u2pY2f25xNdSuZ6OLpB7DbOsikp
	 LRk9WllhiIHXMEue6tRCUJMiwct/Ua7WbWoxdBXp1umfO99SJhMipjdmtEUj/sUZoX
	 va9gd0d06GnaA==
Date: Wed, 19 Mar 2025 15:25:26 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] samples: rust: convert PCI rust sample driver to
 use try_access_with()
Message-ID: <Z9rT1tfR_fAm5vKm@cassiopeiae>
References: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
 <20250319-try_with-v2-2-822ec63c05fb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-try_with-v2-2-822ec63c05fb@nvidia.com>

On Wed, Mar 19, 2025 at 11:18:56PM +0900, Alexandre Courbot wrote:
> This method limits the scope of the revocable guard and is considered
> safer to use for most cases, so let's showcase it here.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

