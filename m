Return-Path: <linux-pci+bounces-26589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC2A99701
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B23F4A1205
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CD28CF43;
	Wed, 23 Apr 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJRcWaEY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0D1E2606
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430619; cv=none; b=sYdf2Fx277AHpeC1u9+yepSvDp8jSKHge7PoWKEi6uKz/gAIO9KEXxJ/GvqGx/RZ0Go6o7Z/tyQmMWMmO1gSmGGRsGlfQ5MgNdEjvrfu1qKcw6gOpjL59EmRROnaVrJ3xd7FYUj0SjW0EQpTunSiKse0disNA0o91VHMoEhwdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430619; c=relaxed/simple;
	bh=QKLzY5f3t4EqQuvNvZUJMhe8wGcsETDFaBVHKn2S1ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mvg9xUcgGJfcMbWzA9H+sVcXjZ6UA3SQqbgZQ16+eyH1/zbsq8bUzQMS4O6nBF5ZrxscnC4ewu2cH5EQYxXMYlsr3I13skOE0874INGSxAlCSt0xZ0PBVjbkMzrQW7pno8ZETt9SF1qpO7hucf69oWQAXfM9jovvLueLx8AeQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJRcWaEY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ea256f039so774555e9.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745430616; x=1746035416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkyJVJvayedppw3sWI0GPM8RDyFc8O66hqcaSSD9G1g=;
        b=qJRcWaEYBikXP19+uYElvGZq6TzXtAKOvh+Z8knRkVw7pYvoNy7GCvE9gDi0FTxn8a
         zt/ai7O2d448J+Zl03Xaxj5LgwJaJAda/qi95APCI9VpUnJH/L54wavzRTyot1WGWZJN
         GqApr1uuuAVxBOXX8FWaaSnB+YwZxsnidF3NTb1/OP3vVr4tGcCTIwySuqxi/avbMM8H
         UkicHH0Cj08LBjgxZW8Tsw5Ep7e61caW6Ua6CTzO5RXIkb8O88G5vB6l0LKkX3MEe6fm
         lAklLTNpCd2exi2Bk+YTXP6NOBew+6OlYon6MkuNkbWONg7US7PpsGhDQ4SBOccDqbkZ
         z4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430616; x=1746035416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkyJVJvayedppw3sWI0GPM8RDyFc8O66hqcaSSD9G1g=;
        b=Twwe0aXI7ATVcuJNBMPkadhY5u/ojh4zayHzohsMvVjEG8aNJJdvpB+JhmtlBqUBeJ
         fIuq9wuhFwv7SqG+AtXATy3OthTfpofzB878t9Ew7hVZmqr+/1AhC6WPCa3xG4E22xUo
         8vvXfXUX5eVvKKeefxJV10unwcaYjuXQfetqc5G66KEa1YDWFosCFecZL/TYXTCAv798
         uAFtW66FXEf0cgsnZ5tJiIIMCOYJuCASF7/6lWhxZmc8JxiSw/IIYTZAtWTcjavKRdHS
         Vl+c1GMjyOeSlISpBBmk2LPYcZssXnS2ikcQ0QC8bAtha6xapn3i4+O8pTml/VrBgVTl
         dstQ==
X-Forwarded-Encrypted: i=1; AJvYcCWskCSu0uOKZhqOhgWSoa9VUe6t163p+mBWQeqOQzPX39pK1i8hgnjjpq19bu9+jxt+4PrZkuqhyVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOexV8kjdLsEwNB14LHSzsACFgsDkzfEE1xbSpLGoFOOOv2dO
	ENa4IOlZ/XwvLrL1i0Qk3j32Hs+NB9vE0GguRS6747Pusm02umNSRUzNX6HJz8Zx+XyJCSi6Jjm
	TTHyyJcBLIkjl2A==
X-Google-Smtp-Source: AGHT+IGG7oMigeybpqlDwQJK15daVwyXJWLa97UKCcbNBzHZq/BAg+CdNCG/eCJ9V70GXVK9Jn1nxqxkOah8wwQ=
X-Received: from wmhu12.prod.google.com ([2002:a05:600c:a36c:b0:43c:ef7b:ffac])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3107:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-4406ac163bemr144465395e9.29.1745430615921;
 Wed, 23 Apr 2025 10:50:15 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:50:13 +0000
In-Reply-To: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
Message-ID: <aAkoVfiZDAXdYxrr@google.com>
Subject: Re: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Apr 23, 2025 at 12:30:01PM -0400, Tamir Duberstein wrote:
> The bulk of this change occurs in the last commit, please its commit
> messages for details.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

This works with Rust Binder and Ashmem.

Tested-by: Alice Ryhl <aliceryhl@google.com>

