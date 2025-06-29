Return-Path: <linux-pci+bounces-31029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90318AECE47
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8353C18925DD
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DB230D2B;
	Sun, 29 Jun 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5A31hZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA84437A;
	Sun, 29 Jun 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751209875; cv=none; b=JapIxc52D7u4DqA13+s72FAq0gTmUbFrKddkIIB/QksrTsv/6cBdMPv0B2ED+5txGY7N1/fmLRHMX1ZJr9n5Bsy4KSx6O1AwBoyaNVwqXXYdn0KHRLee6YxhzT9JKH7k5MFN2R3MlcaL7OcbzVDwSlpwJNKHDIpjwpjFFHVoBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751209875; c=relaxed/simple;
	bh=coy5HGnBbVP/fxiCj/IPdXRm3aSQd6Eh72plsuhblG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds5UTtt3hntiAWL6lRqeuShXkbfSZu3uy1JhyJkZ0LIULOkPkmxgyYRytAsKcTbecAmzcy+aSF1dShbPnVbJd9nuN0tV8fvxRw52ixH/qZ2HtaoZGn5IEreee374rnF+Ic8NBX5kgnzP4O+7eVo02/mkZneyx+Ocx8Tyi91Ex88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5A31hZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BEC4CEEB;
	Sun, 29 Jun 2025 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751209874;
	bh=coy5HGnBbVP/fxiCj/IPdXRm3aSQd6Eh72plsuhblG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5A31hZV9wiLrv/TCeohJa7rgZzLJxNU1Ce+p9QVpAZ2dg4IP1TUb5F1QnN9u4pW6
	 AEVlp4mY/PeKNRjEuDcpkJ9znUju+rqpbNRepkttpmVD3fg2W7tsXGaLVDY9m0BOF/
	 7reo8c6oheSx03mzqdAcw3VqAYvRRFKCZ2sXP2S+fmJBbsK9OLKRIE4F22Nyc1Ya+h
	 qAT2HwzgLwzWOdfisY0KSfJC0Nms4igT6D+eE4+xLBxjysINXCPUj/RvRcGHunaMxC
	 9RfsFJPgdqGTEorMI7HvT79giF0PSNzbQtKejOD24EERDt9KxnzdEC7rw4y7zySIXO
	 bBnFH8kbTtfEQ==
Date: Sun, 29 Jun 2025 17:11:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Improvements for Devres
Message-ID: <aGFXjMy4-niXM4WA@pollux>
References: <20250626200054.243480-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200054.243480-1-dakr@kernel.org>

On Thu, Jun 26, 2025 at 10:00:38PM +0200, Danilo Krummrich wrote:
>   rust: revocable: support fallible PinInit types
>   rust: devres: replace Devres::new_foreign_owned()
>   rust: devres: get rid of Devres' inner Arc

Applied to driver-core-testing, thanks!

>   rust: types: ForeignOwnable: Add type Target
>   rust: devres: implement register_release()

Dropped those two for now.

