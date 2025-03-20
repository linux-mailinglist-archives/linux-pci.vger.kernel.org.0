Return-Path: <linux-pci+bounces-24216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E147AA6A183
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82237464967
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9842063DF;
	Thu, 20 Mar 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9t8kuQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CE20B803
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459800; cv=none; b=Bgcq+mOGlY19CBMWTi65s4GFQk9ELPHJibpplxYidt01uPAVYeM+OSJJqUneukvHXJ5tgLj122EUEfc2dUxzDZw4XXoKCQaBkus3QyFWk8WPE8a6WogSQg2612/3Wh2H/YEzDXkvabXs58N8Ppn7lO6s6ZfXf/A7FnJEqWJ62jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459800; c=relaxed/simple;
	bh=uUdtpvZVON7BlCg8C1bUw4EGV+nvS6TOedE2ZoM7ztE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3RJBRnGFUkWdS+Cd2G+YVnvgCaVd7b5gXEnj/agNhRvt3s/g/v+i6F57n2mkTBbyHmOdfBvfOEFhZqPyi1WxKEgKK3ontI7tuNq5WU73n4AxKtLOd6C2q/W9HIEdjeir80fF9Ffl235BPUoOSQW4o2bYoBOi1TkSY6lTEAhmwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9t8kuQk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso1215065e9.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459797; x=1743064597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFIMGOYH7y3C8PhwT9bCF8sIzwdxvGBAVhS2YrPnTd8=;
        b=n9t8kuQkldPD5aZJBYEi3nljPAqSmMWjMEbPdojFDyw7mJkR3hibQmo13Zf53sHF5M
         mQ6SVLlhy6RaOR8zMh+M6SmukmV/SLF64nJnzvkHcFCe0+esbf0OR1hVLZEi9/a8pY6b
         aMK1VDxcq5hTWXJG2G3jWJsGcX3LELl/8RBdwjzcAtYLKh/MP1koracNSsubPj8ukuMP
         s7D2KFnvmZInzXQ25ieeEh7Z9J/5ZXGCPulDT2pXuloT+e7VDlDRYOfAmZLM0YUcBs26
         Au5QJulgqrSJTFI60ka1OtmsxRTuazY9SygtCS4g3WlmXTKtTSWQ7twSBMFqGsq3kixa
         z6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459797; x=1743064597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFIMGOYH7y3C8PhwT9bCF8sIzwdxvGBAVhS2YrPnTd8=;
        b=BmlYVi6vwJ80Zv1IGMQvAMFTHRdCaPg1t548D+ZkId8gz7Vvs8opqfzOfrHSTtL0Ho
         4H2Sx6CyFGp2vGGVxkuPz5UvY1mdDsjjUeREya6zhr/lZv5Ro12fcInyyaD9JijsOn7c
         81gskXCCWsr3fCKCcfkE0MFtjfAv1dXBb0TYr/9ixoUr3mUcYjXgfMVjTA+twpu/AM4k
         G983WlhmGa1g739pBsvtzj54sAuSp57aNgCRyP9I4CdixoUcLDTH10xAuKTbwWMmNXKs
         ESL6jSvVlVHg44Hs9CtxwgCYNfal4xl94Bw2MZbxvL3nKzUqnG9yVGgpE+QBBj4KG0Qc
         GkPA==
X-Forwarded-Encrypted: i=1; AJvYcCVgvn3Yvl6Or79WkansZyO1uifTwEFGbRG5XSuAQtZcaudJqUDi5HHnhwAb5IWe6kEbNGZ6smqh7hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL+kX1SM8+LO9JEZIXsT36X+SPdWydTzuJ2YUN8Dm4ZqMFj04
	/j3tS1K/BqdtENlm8iO1U0h0hjM4c/mKbQVG2WnAWJ5QILRD1bimAtr+WeHrsiUP0trj1KouH53
	nEti1iP3hzmvKFQ==
X-Google-Smtp-Source: AGHT+IFH1QXeB5i9lept2S6Sa6wweQ1pkpeU06zZ96I7u2P4VrMZC3n7NvYipzi71RDjJd6MGyhA3Ey4WFom9Xw=
X-Received: from wmbgz10.prod.google.com ([2002:a05:600c:888a:b0:43b:c9cc:b9b3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:ccb:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-43d495b084bmr19680055e9.30.1742459797197;
 Thu, 20 Mar 2025 01:36:37 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:36:35 +0000
In-Reply-To: <20250319203112.131959-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-4-dakr@kernel.org>
Message-ID: <Z9vTk5aUB8Y5TASG@google.com>
Subject: Re: [PATCH 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:27PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &pci::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the PCI bus type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

