Return-Path: <linux-pci+bounces-27636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E04AB564C
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2A23B908E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCE28F93E;
	Tue, 13 May 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+jFVjqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB428640E;
	Tue, 13 May 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143580; cv=none; b=McdGFz7D1v55pQlvwuPIkCsRh3twXyNZ1fBWxjmTFC8+IjMPFGAylGu3Q2PZCc3ahafsgSiV8fhK6WmEKfC1BrMCYz3nMttPGKydyAr9f8a7119v4LYkXczGvAUpcO0mOWgHQHLuFCCJmw159aagXijxgFNY1/rLwnC02NZUV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143580; c=relaxed/simple;
	bh=x4d59fbZ6X9rBfTcqBtwPRFZoK7UoseJZVn6GZygBM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f03D56oD6bctRgGTSkgB6K/8f1bRzbYi8y5p3Pexv8klhgConvkLWG8OjH1rA8YRtoFAzR+v18Wn+2ykj6n5FTs431iIWOG1+sfgzJUlqX1yHV3ISlflRqsNK+TBlpGEtN+dgdkhT+lkWMOu77Rd+JbLz5RCaAjnryVvuN+jrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+jFVjqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13C4C4CEE4;
	Tue, 13 May 2025 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747143579;
	bh=x4d59fbZ6X9rBfTcqBtwPRFZoK7UoseJZVn6GZygBM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+jFVjqAP1rX82EQwPK/SLrflccRtQQkVMnGmM0VhfgHMT6K2pcbRWVFIm2AebsWL
	 LG7tnoggsI5C4wA4P9t3mgqWw8AAQAxeAC6saO7t0TGNH+U7L8K/Wk0ktYc+/q0FVR
	 8ByB2oI4bs08AASWF4vN/I90pF1VrvdLFEQpJnBCLbQgN9/L5z59iZ+s1HjH6GwzZF
	 u08UJbitIHUZKH1HwUhz8U8g609eOzYSPVzDCOrzg7rdLKMKc4KVv1VUxhcVKdBF9d
	 o3cU5aRJ/mMktwmvaQp3Xc8m8551J53caq1kj59k0wg+KljavLmKqGi+ArFV4lI+yq
	 oSuTCFUW9mKAw==
Date: Tue, 13 May 2025 15:39:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <aCNLl-Kq0DPwm2Iq@ryzen>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250513102115.GA2003346@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513102115.GA2003346@rocinante>

Hello Krzysztof,

On Tue, May 13, 2025 at 07:21:15PM +0900, Krzysztof Wilczyński wrote:
> > ---
> > Changes for RESEND:
> > - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Resending a patch is not a place to add new tags.

While I realize that:
https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient

states:
"""
"RESEND" only applies to resubmission of a patch or patch series which
have not been modified in any way from the previous submission.
"""

I would assume that this only refers to the commit log and code,
and that picking up tags has to be an acceptable exception.

If I take myself as an example, I would not be happy if I spent time
reviewing a large patch series, but because the maintainers somehow
missed that series, so the patch author has to RESEND it (without
picking up tags), my Reviewed-by tags get lost.


Kind regards,
Niklas

