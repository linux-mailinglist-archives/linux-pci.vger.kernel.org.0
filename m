Return-Path: <linux-pci+bounces-40476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCDC39D01
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E6B189E011
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CB30BF52;
	Thu,  6 Nov 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiEMrqW6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04B29898B;
	Thu,  6 Nov 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421248; cv=none; b=MM6Znd2RqZISOMysEPTitRBiVgFJG1S2HnWsRztCvheBq6lqCo0IasbT6hDUKpQ6xlgT9j2OmXmplF4cFfgieaNf8bMb7BdGMozOxCL2u2zl7wjjSqSFfGIAInuCK/s+YJ3SvsTgCyLt1inTR8vd+sKDhHK1PCo6J/RC55cS9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421248; c=relaxed/simple;
	bh=SodqO5o+MfH1inq/SQ+EsTztxwibl5c6EiQj5ZiKCB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCRhLZx22fktT9TdB/5wljdp/SQjvXsEIgEeLyP9BoKzcCjyLzs4jV/wAfQZR74b4CQwcgGlEH+C/OQWbjo44rJ+MdfYI8kesvxC3+j3h285XarZyLuQBc61UoO788bsjVU+3ybUy3IeeeCIpys2PCKLTktA3EqaR0/fQcSk+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiEMrqW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38718C4CEFB;
	Thu,  6 Nov 2025 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762421248;
	bh=SodqO5o+MfH1inq/SQ+EsTztxwibl5c6EiQj5ZiKCB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GiEMrqW6+8KxnFGfX21rU4d8e0PsSXWeKkO8Ae7PZFTTFj8nmZri/hH9xK2TpUogS
	 tlzD548GMskUMEfbrBx07dJYUVsT1z4r+r3pCnZ6srnikaas0cRYtVkrz6Se/QUDdQ
	 cJiRlGQ5DRnnaOYyxknlrNj04cz8g0BLktiYhHwX5fM9QAutpBFqoY5yqVZRy62cbp
	 q2TSfwoQofAZaIfRqnaKeIBwR/c0OCkEX2rUiWovzd4B0AdB+sOS9LTT5jgUNpnAQ/
	 Npq7jJgeprPGpitZAxkNA5qBKxPW+RXBRHK+Qmn+PYpZKBz2QNPM4u+vFWC+Q5Yluj
	 s8vW8P4ZAC8Ww==
Message-ID: <e0697f46-20c6-440b-b278-0b4a36d1de2e@kernel.org>
Date: Thu, 6 Nov 2025 10:27:23 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: pci: get rid of redundant Result in IRQ methods
To: bhelgaas@google.com
Cc: kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20251103203053.2348783-1-dakr@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251103203053.2348783-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 9:30 PM, Danilo Krummrich wrote:
> Currently request_irq() returns
> 
> 	Result<impl PinInit<irq::Registration<T>, Error> + 'a>
> 
> which may carry an error in the Result or the initializer; the same is
> true for request_threaded_irq().
> 
> Use pin_init::pin_init_scope() to get rid of this redundancy.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

