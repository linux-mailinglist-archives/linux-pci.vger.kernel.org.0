Return-Path: <linux-pci+bounces-22532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54871A47B08
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C8D1885144
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D622A7E8;
	Thu, 27 Feb 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bulPCjMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE122A7E7;
	Thu, 27 Feb 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653963; cv=none; b=cS1BjdGG3XrmDSGyPP3Miuw9ctDzkwbPDjRS3Ss8g6hoN5mAiuRHTAM2ygzCyZhNIDVCsPrUzrTBI4CT0ySWckKRcS1gj3jnPMneOTGVWmE+1MMP1Aw/ZF8HJTNOoRZEU+yiP4e+y1DgqvOVAubNXUm9o42NWS8PH0jqUC9yRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653963; c=relaxed/simple;
	bh=CI2P6Tf/yB/4U7aj/M/QOvyZZzKNKnf/I88mQbIM298=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MroSHTRnsK+gAIpQSrNz2BG8NkatbYcrCYVwzjUsp/94knwhku/JidcrwLQVPGvi0xODWp8xwy6cYBCrVyqhSF/TNRYuy6QmIuC7N+RG4nSQmr8ri0M/4OlZ3Gwa3ijSgbcN4qmBaTVGnKba0eKvr7yb2B0qake9IOFdy1lvxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bulPCjMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4DBC4CEDD;
	Thu, 27 Feb 2025 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740653963;
	bh=CI2P6Tf/yB/4U7aj/M/QOvyZZzKNKnf/I88mQbIM298=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bulPCjMXrFMSKc1hPy5GDQ+TOeBMTiyyYOmFIgEmMGBi/YaHDH3uWKaYiHdo8QIu6
	 xQWUpKaZBP7OpDEHKomyOhps+DeaeHfsQGWtX/Oz29cv8D9Hbrv9tjQTH6B9/DHDAK
	 WbQAHnKA6MlXTCAM6X27eUghfRdHwKIqKlkbjB7A=
Date: Thu, 27 Feb 2025 02:58:13 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, ojeda@kernel.org, alistair23@gmail.com,
	a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net,
	alex.gaynor@gmail.com, benno.lossin@proton.me
Subject: Re: [RFC v2 14/20] lib: rspdm: Support SPDM get_certificate
Message-ID: <2025022730-clever-finance-0b49@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-15-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227030952.2319050-15-alistair@alistair23.me>

On Thu, Feb 27, 2025 at 01:09:46PM +1000, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  lib/rspdm/consts.rs    |   2 +
>  lib/rspdm/lib.rs       |  11 ++++
>  lib/rspdm/state.rs     | 123 ++++++++++++++++++++++++++++++++++++++++-
>  lib/rspdm/validator.rs |  64 ++++++++++++++++++++-
>  4 files changed, 196 insertions(+), 4 deletions(-)

Nit, I know I can't take patches without any changelog text, so that's
probably the same for most other maintainers, so you might want to fix
that for ths change on your next submission :)

thanks,

greg k-h

