Return-Path: <linux-pci+bounces-38272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B7BE072F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C871501C2F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCD30FC31;
	Wed, 15 Oct 2025 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZ7notaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732230FC20
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556722; cv=none; b=ncIEsRvSyLziKs/2u6KvEOO+yOYgAYUL5VzHFoNYklTUfw+Z5LOfolOruYLwvHIopNCjlFFPn2EVDBqjbdyI4GWBYjwFfhu2xZx5+N0Yl+NmP7X3nAEjbTvr0FgvdyGp9raoLikM0IqMv3Kw770BfjNJkjf0x7INhB7YEuTV9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556722; c=relaxed/simple;
	bh=vFQ57qEPFFK4a1P47Xt/5YF6jxl+QY81g9//5V0r9E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jpIUO6pkLLxD5FdeWU5TSHwYtdrFCg3KmMOauh4SdG5pezoJMUgtg1q8lm9li8t5WdztAHPy6xWoBz7KBroVgtx8FVfP6ss3YMD3resIqPfjSvqyDOeX4w9mABhbYSlEkziDL6qE6c/s6iW8wBmwBkJQPTTVxaWvmGiCjJvc9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZ7notaD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4710055d00bso6302365e9.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556719; x=1761161519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gjm1LijoOvaR4UmxrMCJ1ivWAHmFdej62IpC3mzcB4=;
        b=yZ7notaDzwDqtmZGUCvVj7xOcE/rI9oB1QEDeIXSWeCUE/m5WxrCAxkyvvZANgPeoI
         Bn8U286xtXxpXFBtGI95o1FFAPP/QrfvQgbqk4TkpkX/OuzrmjJNVdJCZhF3QxmcHRsT
         4TSZbWAJavwowGidrNjAIzoYAw+2F8RlSAzGsKJs0cQ+pGo8l5/HEi1LW2rqDr3Q+wfM
         Gi1M1Clx1iXbN9rSp+TNOvOTml7BlTQ95+VXaWGlRSWumstyTPtNuT5eh2sFmFlrSmcJ
         Htqlbq81b/qBArKaouKnlwR+uCJaXeMh393/RVE9ZkbuGoRxQZ3DPvy4oAHY8cxC0DE0
         DIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556719; x=1761161519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gjm1LijoOvaR4UmxrMCJ1ivWAHmFdej62IpC3mzcB4=;
        b=Kruh0mZnGmFxaKNEAhq8ivqvQid3bF2ecur1jkQy6jVxoJbzOY2BR1oZ7SsFlBceIp
         9r/H0AIvR820wvSEUxZiocuy+P6aiSRy1doZykuGNjPoOAtravAWyahWXBm5DNVYaIQW
         flzpWsYNEFztLNlHknfoC5PaIaugkWA707RUKTWyL6zjlQlHvKDlVU9nA1+MQx7J1vc1
         wdvrQP8/8U1Nx/TB6gtHNpg9ZkZf60Xj9KEO9/UiAFyd8XKv1IYU1LVFAXSTozvXubzq
         wnUu+qV2XJr5KQzOYyu6QUMY0zAV5AhNXSe6rDAG4yMj8x73Lx7ICCLwHYxLHACzQR0H
         jVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXac+2ac3Oy8KcioaTHhlfo8ZNneoRpddrZHbrMYEfGNvbq7A6jE5nQWsBndDvxdyQ71EdhUsK/qJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjxvxZ6kdQeYeS3BMSN/LfRiKhU76DcCXlCAR+TTZ9K0y+ltE
	P2q6b1YCaYooSb+ApHJYGsLiZJqABRqEmRo/QJvuY/zMHNwVX8EfgbFWcjXiDkIlQ/1oxUEwBc/
	CZYjI7wGZZ5Yj1lEvoQ==
X-Google-Smtp-Source: AGHT+IEL/VHOLFHuIoVUiV/D6Bqe6tW62TJ5aBz6rcqOw3p0/Xw8HWgUhNCxtEkFwsrO9XapAOq1uGfyLXGMMfk=
X-Received: from wmbd3.prod.google.com ([2002:a05:600c:58c3:b0:46f:aa50:d6ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138a:b0:46d:7fa2:7579 with SMTP id 5b1f17b1804b1-46fa9a96521mr194128565e9.9.1760556718448;
 Wed, 15 Oct 2025 12:31:58 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:57 +0000
In-Reply-To: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
Message-ID: <aO_2rb29XrSn0qo3@google.com>
Subject: Re: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:36PM -0400, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit 9def0d0a2a1c ("rust: alloc: add
> Vec::push_within_capacity").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


