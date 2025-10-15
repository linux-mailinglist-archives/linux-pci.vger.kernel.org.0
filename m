Return-Path: <linux-pci+bounces-38269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C292BE070B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10D57504F0A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74230FC1B;
	Wed, 15 Oct 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZuJ6Izq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4D30EF6C
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556647; cv=none; b=d9hoNoq53NI+3+j+yBoOz8aNbxc7CHfVdz4V0rtDEG6nYY78Y9MA3mtIR3HZlb061X+33cB83Qf0UXNpl0e8lP3yzJjbCSCQ2Upy8Cd6YgOBLVLMyuvdBvI8hlAIyW2unlFVp+aZWDP5wGw/WbEw7hgzN4rV2h7SKeKKIONypkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556647; c=relaxed/simple;
	bh=jzqQsin1H3Ss/7Kc6VHndGMJg2kFmuyjGGetq8PWm18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4+NzOq+ggXSW/WjVTSJU9pNgICbPDdLcGZVYXrfOlaDf/78SPmfLruxiZZJKGwskCxm03kaiwObkUw5OYT0QZNDEaqG+LBVxUmwI0oG+9aVg2nvKDvUtMvkLzjWCZCyXuJqXSx0CPkh64pDSpoZZGswrLiuVf+x2PXyBnTJZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZuJ6Izq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471005f28d2so4229175e9.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556643; x=1761161443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=CZuJ6Izqoafy+Z3c8IcwuWNDkEvISuUZMjmZWYfvEplp2xJvHbSCSV/XI3TahKzlnn
         2/VSUAuEuifQEPL1yVM0KfUh0k9C9iAWsB4lbp9C+CKgPZiVLIVAk7TfS923BP7qvcM4
         L9P24234xUEN1wYunFdup7vBislGABuirlydlrly/c6v8V/FPefcaD8jRSCERGEyL0i2
         wF/us8aq3okXfYjesPuwlnNAkTU2LsE/MoUvPx6vcCIDR72T6hK/7aIhHH1xyGo5omFI
         u3rWpT8RrLx6jM8VaLgKaersh9nkzIDtc82OCKLSc8wIVbTZsmlQPCLQQV73nu4LEniF
         BOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556643; x=1761161443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=YBcOPsiUJZcvUiuBX35lcxT3imz2YDWsoqEQgtMb+vXv60o0iZF9Cvb++m6yCeaooM
         6qlOMqx9e3J3UkHTUGud1MYGXAT5DvR1eDviosmSB/GPjypEMshoQltkFC4Ad3NQtXyp
         /PmlrPOvVjd0PTX1zQPaw1G++680U1BmFnOFrjCYZFyg6z1Iz1cvoHGVfOkfZv1TSDp1
         fVPpSAQNRM0QQkiq0p+Isz4amUaKScfG9x+GfRFO9TGckCR4PdsUpDFfZUmKdazvTNsy
         80M5qhXy1fthcMihe2SzA8Jb+cj86P6FqBdQ36p8Wb4tqU41wZr2/0aE3sApCZoXMiRb
         0s3A==
X-Forwarded-Encrypted: i=1; AJvYcCW00AJd1YvaLxAQbczKKWUFo+sKUCt22cksqLknXPqkBmE8IMjwzRZ7aT45dYXQvbqnwmflAVP9x0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xVqZY+bxqe+Tfzqd615IP3yxwVy9YLm+rZxV6lQ3TexPWFul
	EmzSKOago5FWD0TXVrkiS3P4OwZ4P30rUUL+sFm0PXl4s3VNHHLXukcUA3YjY8jHhD5Cx5qL/1v
	5/+wJ0y2ZmYKfR9cuRg==
X-Google-Smtp-Source: AGHT+IHUcYtq/jysGTUkDJKvl3MbWL3/M7dZBn/ijA0kzgEJ9Y8E6oSL5awGSBYgdY4Z4z9XH540xUv0k/TvBZo=
X-Received: from wmwn16.prod.google.com ([2002:a05:600d:4350:b0:46e:5611:ee71])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr221043115e9.31.1760556642790;
 Wed, 15 Oct 2025 12:30:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:30:41 +0000
In-Reply-To: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Message-ID: <aO_2YXO7C6Jk3EW-@google.com>
Subject: Re: [PATCH v17 02/11] rust_binder: remove trailing comma
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

On Wed, Oct 15, 2025 at 03:24:32PM -0400, Tamir Duberstein wrote:
> This prepares for a later commit in which we introduce a custom
> formatting macro; that macro doesn't handle trailing commas so just
> remove this one.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

