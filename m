Return-Path: <linux-pci+bounces-30372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DCAE3E9A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4E3B20D5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62972417C6;
	Mon, 23 Jun 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQ5dw8or"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC97241122
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679615; cv=none; b=ObTbdtmrZwkB/0C7/ru8vvma2ntzFLkDZeU2nbDCBBxrelXSjIE4BFB5Rwhd/hzbTpvkrP1FupuoOFnPfdIhCeAUVp5070APCjY3VT6MHxZntWOk5m/PJjqyNJqk7c4PZTqRNHeYUHv4yis9/pZxZLWqy/qQXgCpXFYvNGj+mPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679615; c=relaxed/simple;
	bh=meSSaiClcTR3xytadiOo1QSIp8vuhc8I1Sqto7MpMa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ukj0EpBEaOgxi9CmR0rQnytM1AqUBTLF3K/MDGWvCjmqJroENj1SdaBDlmlwd9HMBaIiWILX/UgEoSNFYuwIAP7lOoOnnRnLzf3s5RmelxMidAn0J3kYnzTJMcPtZ0BFScN+cnZvNe1K74otfL/zcAd4OoZyQBdeg8tswj9OxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQ5dw8or; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d5600a54so32414475e9.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750679613; x=1751284413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq26HgMplW+iBe5gfE+wjImdYQOdVkOYsdy0RjL36+Q=;
        b=jQ5dw8orN6Erhft8TxahKnXGsVsye9kiLwF3zAS5DHMoRA5CJ6bdvAUfkBrAMSvZB5
         Lht+m68SeQuXbw4h8QrlVvnuNm5zBaILZIy4itYnHAhQCStVCZJoxPb+xnP7l9j6+w+s
         Pk1aJptnq2wZBB/EpJ4BuP9YzosMI+FP3mCF1JQlH+PXVpSfpu+otjKZ+/I+4mjQ0Fyf
         47XI76QC0vevUdubhXg7HuyB1kEKqCwLsdQXHjjCBAQcwdTYDWL68+7tqzQE/eXVL970
         hEGLf3leVvNZr1Vc/XcPQdBauLkuF2V75ZwW3IAE/tzJe/8H18WoBVrX51b6ENrotKGy
         bodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679613; x=1751284413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq26HgMplW+iBe5gfE+wjImdYQOdVkOYsdy0RjL36+Q=;
        b=oI7cDz8ctmixeDdPvLVCCRzlLpHqjKHF5i0aqxbOrJX2Aoxw8cMpt5OC57dbhALFPF
         +si7SsAcdNHhShRhsKUQMQ1R4mqWhaxHs0aW0ytD3FHac1fTfdrmBkJAW7yKmkmzE65i
         zjazl/09CIBR/eIRdfwRkbO5bXtNKAyxrcxWm6J0EsAMsmcsCe6izkUYQaB26g7gBUT6
         BGn0R1TP+XOK/EdBchTYjKsOSSD5581v/GDeUrON3fr7MOxdmCQQeT6q4KAErYHW+hDM
         208gle5KMvchLMYrbr/qG4nz/xslz2gYSJ1DoWN+iHJ8kqkP7IgyNBSNk9BszQkQHsoA
         m7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnliLuNZlh8O3v7LhpSzViw01co+nigK71HnnC3Q9/RHKvuOGJyPGTjZh9zrOIFKt0djXRyX1l7mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ac3RKi3UgbuN65KwMvwyefLmuVpch5I7ZlUf7ktErTzHneLj
	LrbJC02jn0p1YxGxXVfFUYmI9+41H92/TEwTEvl3HN/FLyMl7QdPgCRB9dfaAfpSVaiabuIdg02
	8xeK80lRe3thLoVxjAw==
X-Google-Smtp-Source: AGHT+IG/PACjb/8clKrij6qBHXLOrCj3ALdLB87G4GVhJuXUp6vBh37RSN00Zx41EePm95+3dS/PoIBnOrlgusY=
X-Received: from wmtf5.prod.google.com ([2002:a05:600c:8b45:b0:450:da87:cebb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5490:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-453655c30e4mr133788405e9.15.1750679612832;
 Mon, 23 Jun 2025 04:53:32 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:53:30 +0000
In-Reply-To: <20250622164050.20358-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250622164050.20358-1-dakr@kernel.org> <20250622164050.20358-2-dakr@kernel.org>
Message-ID: <aFlAOr8eutB1o-WF@google.com>
Subject: Re: [PATCH v2 1/4] rust: revocable: support fallible PinInit types
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Jun 22, 2025 at 06:40:38PM +0200, Danilo Krummrich wrote:
> Currently, Revocable::new() only supports infallible PinInit
> implementations, i.e. impl PinInit<T, Infallible>.
> 
> This has been sufficient so far, since users such as Devres do not
> support fallibility.
> 
> Since this is about to change, make Revocable::new() generic over the
> error type E.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

