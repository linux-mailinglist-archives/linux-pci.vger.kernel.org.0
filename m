Return-Path: <linux-pci+bounces-38853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB267BF4D70
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D4464F73C9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726127381C;
	Tue, 21 Oct 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZ46bR3t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A827466A;
	Tue, 21 Oct 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030523; cv=none; b=RLYXOIddI/lh62c0YIgx0qGgY6+oTJbjjLE/CeFMmQ4BjvPEgLN/LoTQYWGLrNGwFBLSwtvhgFV+3fY3THnE+59s9dXsBLNYLxGHFCnt7vTkEQRAs0zAK44kWcgySfjEnrR1TOdX4GI4ufzDwvFaM1DQJaSfAu5xCfz8IpKNLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030523; c=relaxed/simple;
	bh=AlYnsYydAWPMUtRG9rMiMoSf2ckt22knitCS1hNP/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTZ7preS5oFgb9cv4uVlWbR0uh8SxEDebw/NKlRKWImA9nuMGOmz9Gf7NsUhM4DoHpLg0NUwIaBFquOTWganLVyBVEddiHgYdRoBC1fAd/aPk3EJ81898XuO6mH85+X6P7mOxwQytUrIIyNU8GLVw5e4Vl6c2HiFF2hgO/Rdqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZ46bR3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B43C4CEF1;
	Tue, 21 Oct 2025 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761030522;
	bh=AlYnsYydAWPMUtRG9rMiMoSf2ckt22knitCS1hNP/Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZ46bR3tyoG9B7ocuiTXq+XbHIOm6yzHBjgbLDs9oEuE+qIAhHD2FkS81f9wBVpIp
	 aaeNDNQZ070vVm2I50pUDySVX4SxT4sjK3zOKVvl0vXATSES/r5by7IrKfr0NasAiK
	 89knbz42T1zx6AyRV8/RBrBvwWF/ChKo9XVO5ZHU=
Date: Tue, 21 Oct 2025 09:08:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, pcolberg@redhat.com,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Device::drvdata() and driver/driver interaction
 (auxiliary)
Message-ID: <2025102110-marital-print-8a1b@gregkh>
References: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>

On Tue, Oct 21, 2025 at 12:34:22AM +0200, Danilo Krummrich wrote:
> tl;dr:
> 
> Implement a safe Device<Bound>::drvdata() accessor (used for driver to
> driver interactions) based on the auxiliary bus.
> 
> This provides a way to derive a driver's device private data when
> serving as a parent in a driver hierarchy, such as a driver utilizing
> the auxiliary bus.
> 
> Please have a look at patch 8 ("samples: rust: auxiliary: illustrate
> driver interaction") to see how it turns out.

It turned out much nicer than I expected, nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


