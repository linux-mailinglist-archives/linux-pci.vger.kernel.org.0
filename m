Return-Path: <linux-pci+bounces-24286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3BA6B2B1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68F717BD75
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD381DEFF5;
	Fri, 21 Mar 2025 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/CvSF1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045741DED40;
	Fri, 21 Mar 2025 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521338; cv=none; b=a3AJkSNIPHPMyDx22qHFSZn2gQUU/rYugdQenzrzg4/NfFJRnFjXZR92BMdZGG0Md3v+qNhoNaOg7Q9JnSdHSrvcjqa8eXNlDbxKoSBFqMxltRiQyYEN1gMifKjQSE5FpLwgFLbwFERllvpscz1b7v8aEzICeHOMZSDIR/FEgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521338; c=relaxed/simple;
	bh=PKIFXkU9dIe6Z2MC09sE1rh52+sss3Nm9eYgOLmZw4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i59aNsuhBc6xdToY08B0ULQ0rq5ENhIdCQLrFfxkjMU9n8+UVypiMo7pWzA18MP71tv4eOZrn2XPu1iG7dgo9h25wpKXFAhUlnbcDh8MNHbSeW1FbcVLIBz54bCPRZ2A+bSBxIZkSDbbSBii7VvlS9BveA3SsGqCRpDPaODAYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/CvSF1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45587C4CEDD;
	Fri, 21 Mar 2025 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742521336;
	bh=PKIFXkU9dIe6Z2MC09sE1rh52+sss3Nm9eYgOLmZw4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/CvSF1m+3OMbxeU5Y8/cwhrqY+35H4D0Wo9/CKc13zYzgrRNeIKsNXS5SQNTqi7S
	 NE//RL2elf0ZYsR5h179FolvtnP+nQts00bNHy4FYZbpWiL2sx3t/OgS0dMhNGRPug
	 afcsuqS/q1erQNjjxwWvZUw+7d0ujJ7mrqae4mAI=
Date: Thu, 20 Mar 2025 18:40:56 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <2025032018-perceive-expectant-5c48@gregkh>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320222823.16509-2-dakr@kernel.org>

On Thu, Mar 20, 2025 at 11:27:43PM +0100, Danilo Krummrich wrote:
> Device::parent() returns a reference to the device' parent device, if
> any.

Ok, but why?  You don't use it in this series, or did I miss it?

A driver shouldn't care about the parent of a device, as it shouldn't
really know what it is.  So what is this needed for?

thanks,

greg k-h

