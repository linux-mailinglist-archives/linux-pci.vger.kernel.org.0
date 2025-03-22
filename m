Return-Path: <linux-pci+bounces-24431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF86A6C759
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C321B6029A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE551757F3;
	Sat, 22 Mar 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQwfddbw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E045948;
	Sat, 22 Mar 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742613138; cv=none; b=K/gmlKvT0f/bifr0TfvcsmQIAabjTk4KrBgxs0g6tGQbUMw4e/+QN8HfyVoRFysODl953140KQQLi8AavsKZtwShyyOLEcVQ2zjLGsx1a7BfYQnoy/ut45HPfFdPZFTYTAWqtKz/ayo3oz4cFTGkbZhui8QwwJTas6r3Lq2ALlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742613138; c=relaxed/simple;
	bh=orPYceWxiHgkYJwbJVPCl3phtsDWG98+sHSKgf0KnDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI0CdlHpOc9QO9P2gJm1jkLg8xoPGomZdF89ZFdGlYnWa+JYQASC+trjt16siJyw1G8h5DO34l38YAdudy12AufxwtsWUIA73eDWMKeKtwbLwyNe9f0VLqQX/I079RHKvfees0X9vRyc1W30m/kf1rpg4IdWfkuIQRDmNAesx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQwfddbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88549C4CEE3;
	Sat, 22 Mar 2025 03:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742613138;
	bh=orPYceWxiHgkYJwbJVPCl3phtsDWG98+sHSKgf0KnDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQwfddbwKgw5+RZTphYdSUmpF7XqPi8gNuzUyhz9/DHfbnyeAuQuD+FH95BAtafU3
	 WgwOGzQumxuwJj2tc8XJQmIZ4wan2jcPLXbKHCqWk0T3Ngjk9Dj5Eb9yXVwL98wUvD
	 2o1nj8dwRpCRZN/vzTV0mrNMZZZjV9RfPxrTfrDA=
Date: Fri, 21 Mar 2025 20:10:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] rust: device: implement bus_type_raw()
Message-ID: <2025032146-cubicle-fringe-8078@gregkh>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321214826.140946-2-dakr@kernel.org>

On Fri, Mar 21, 2025 at 10:47:53PM +0100, Danilo Krummrich wrote:
> Implement bus_type_raw(), which returns a raw pointer to the device'
> struct bus_type.
> 
> This is useful for bus devices, to implement the following trait.
> 
> 	impl TryFrom<&Device> for &pci::Device
> 
> With this a caller can try to get the bus specific device from a generic
> device in a safe way. try_from() will only succeed if the generic
> device' bus type pointer matches the pointer of the bus' type.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

