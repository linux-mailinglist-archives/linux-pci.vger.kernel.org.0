Return-Path: <linux-pci+bounces-43510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D50CD526D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC1930145A8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154F3043D2;
	Mon, 22 Dec 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpxUIYmo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD98287E
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393053; cv=none; b=QpHdpFHqYqGcJ0g4XWooPuBmRV3UrlhcW1oSKwlLE/ZsazF4SnPvnXF/L6J7hMPIfpz/la13u5auFGOipcv71/DmA+rlHVHrtfbCzI9MSgvYUUkz0o4mK1acWWYBkH4Mr7IuVJvJWs39iwsUYZI9aSAe071nDCzoxXtyMM9p2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393053; c=relaxed/simple;
	bh=7JbjUpfRtcJDQTbUr/o8/MBhec59OcUt6gwi4/rdI/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/PNrQ2nIyD5ImdRiYmzewJjtC8a96lQm9DvFy7ACz6U0N6rWdk6MgvSejQ9Cikemppl13LGfrmCCtakXUFso8OVm5bVuh9dOrjpEHni6LgXbnuqK9/l5yC8wHVvf/nbL/Rf2GefQWBiO2i8aHoKqIFxhKHItIgpQawy1jZ1xLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpxUIYmo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79f98adea4so544428066b.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 00:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766393048; x=1766997848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwRJY48dxTPs1oTrj8n5Xyh/tYuVrBXkK07zh9sBwxs=;
        b=lpxUIYmo3hX9iRN9sUK5L0BY+J4d5pY8W5bMc9psX915bUsLh+gGjuoy+p1Y0Fyhga
         f9h50UH/CttvB1B4DGx94pMHVK+vtu50rIJleXxZBIWdBM9DmNcGAuxeqdDzfcPaJW17
         QlwnexsiNA+I/hhE6ezRpHSz5157d2TIrUiRuYWh52Plbzqz5LHqJLgYu/VB7koQSbCS
         YBa1P6UnBCjTFSybR6Rt3+z+bXfEBMkyKhQZMsnFJg+KDLqgGgJwVCHBbj41k3SOEZ2h
         gIkC3pmhpE74o7q3FlL3oQU3SO/+weommNNgLsgwkaI1dMB+n/AZKHzsTQBXWoknZRXC
         urIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766393048; x=1766997848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwRJY48dxTPs1oTrj8n5Xyh/tYuVrBXkK07zh9sBwxs=;
        b=Vo5dUHtYxnuAomAWxQMfVTPylIYlAL25uOWZPmLy1epPiZ9Wt9U5ewvDY4gh68PCIT
         TTgLklA2L2zzddBUdtfDrb0A43ymqvXqvGbBFs0Z8xXzIYBZpZPv9mszS6B60GceSwet
         g0RgBbIqiwkLgye1MHxpRyICuNuR9SfswkXEGz6lBeIl8MJzpEErZ5gKDWSi3IcscGm3
         SBphcAcyLSV0HfOVa88FAljk7csJZqojcnQaD6IMBJOYqSneZEq62o1jbVIGVCS9vumL
         0R9RrvIubM8MgcAh7dX629fqKd/wa+tP97e55tPwBsjYl5VFVYijd5NbJpN3twC43Ruc
         apyg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7KYjqAlTZJOIvI9rFCCnnq91b3mRzMkpPIhLvTjvD2jA+gH2wq3uywAGdRzS5Sv323dCzDCVmvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4xeTziSMObJiTR9SKGEX15sUlmRt4ilIXftkwSQ77VbDqaVC
	RGQ2zJSyvRuu1EnbsUa0Rha/aBRZVVYLUsVHkpxdgiTqGnUd6CdrppDCE8bNPTQI
X-Gm-Gg: AY/fxX5bNzQbb4JhKhl5+VrbDwWX1t6aXnisc4KPavR2SW8SsT+UCUmHsitSes2wbmZ
	L9bBesn2eEBiVf4DntWd4cxVuhKbCpyfsII3VtC9KEPuJjjDRMF4IDbOOpjj3Qcxa2D3USZAwwf
	Ad0oOF+5R7jQjPMFTczZui9p9EafJWX6yTV8/AdmT7O7xkeB09bYWfjOuHA7cI1E0OL8CCduAWj
	ztzrAIMxgGM2N9yzgBie22lLJOpKx9xO8GTNN+eqTk96KtRdEYMUAKg4IG01L+o1fKKvMnPFR2z
	NP3PUd5u0jAi+qLONsPpz3Ei5fDOBMEVVifSNl/7/oNU9IvnA9ZMovGs84uOw771EGp2lXcw48x
	TexRgZ9re02DpW3Y4AKm7RpL4grDJJUL1DA/sAoUiiY9tHf9LPw3l10FgpMSD2Q6+XS1qGkQ2ID
	309lO+1N+zwAkftDYn0/GfIHXajeqf5fOyhogI29A5Nsvq7Vl/jU1Rpgku79raTDg+bNMSpE2WV
	AYAOdyLnOiJF0J6I01S94vlHCHGWJB+Smognp3aGdO10Q==
X-Google-Smtp-Source: AGHT+IF7ALpzL1gY8Ty9xkngtZeIfTvDYqIusKSKXf4paJFRSQtinRQWNbOMeFi5eWxXfYNiL8nLvg==
X-Received: by 2002:a05:600c:3b07:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47d195917d2mr96907475e9.35.1766386967128;
        Sun, 21 Dec 2025 23:02:47 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:c9b3:3e5c:bfa7:af26? (p200300dfbf2de300c9b33e5cbfa7af26.dip0.t-ipconnect.de. [2003:df:bf2d:e300:c9b3:3e5c:bfa7:af26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm20819355f8f.27.2025.12.21.23.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 23:02:46 -0800 (PST)
Message-ID: <5521e98b-e12d-4af1-adcd-2dc56863f90b@gmail.com>
Date: Mon, 22 Dec 2025 08:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: provide pci_free_irq_vectors() stub when CONFIG_PCI
 is disabled
To: Liang Jie <buaajxlj@163.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
Cc: liangjie@lixiang.com, kernel test robot <lkp@intel.com>
References: <20251222034415.1384223-1-buaajxlj@163.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20251222034415.1384223-1-buaajxlj@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.12.25 04:44, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> When building with CONFIG_PCI=n, clang reports:
> 
>   In file included from rust/helpers/helpers.c:40:
>   rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors';
>   ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>           pci_free_irq_vectors(dev);
>           ^
>   rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
>   include/linux/pci.h:2161:1: note: 'pci_alloc_irq_vectors' declared here
>   pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>   ^
>   1 error generated.
> 
> The root cause is that include/linux/pci.h provides inline stubs for
> pci_alloc_irq_vectors() in the CONFIG_PCI=n fallback, but does not provide
> any declaration for pci_free_irq_vectors(). As a result, callers that invoke
> pci_free_irq_vectors() under CONFIG_PCI=n (e.g. Rust PCI helpers) hit an
> implicit function declaration error with clang.
> 
> Fix this by adding a no-op pci_free_irq_vectors() stub to the CONFIG_PCI=n
> fallback section of include/linux/pci.h, keeping the alloc/free API pair
> consistent and avoiding implicit declaration build failures.
> 
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@intel.com/
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..b5cc0c2b9906 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +}
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */

We have this from Boqun already

https://lore.kernel.org/rust-for-linux/20251215025444.65544-1-boqun.feng@gmail.com/

?

Dirk

