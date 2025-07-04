Return-Path: <linux-pci+bounces-31512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7415AF8A0B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398334A82CD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1F285C87;
	Fri,  4 Jul 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2A+4JAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A022857F2
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615612; cv=none; b=dWZ3dHqrY9oFQC/GaO51Ma9r7olmaLLUCwBqWmPYw3kPPWOEpxLm2aFQ4HNZtULN/ZIBji8bAQuoYbz/SpQYLrEzCDxMyy1mG8a3SMcjLVfyducbza8PpHxNjhkybZMvi8WWoSiTqOiIPjzWo8UlgnEVuCqTPzHrnLbPPYETfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615612; c=relaxed/simple;
	bh=KykIkmM9eLteMUVLTsm/o94BJ8e9CpiqfyoLjbdjFXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=utcRopCsyKvx+n2k4dDYf8gUpr61CHkEKYLEbGoSs2hH6iM8Y2LbhgaZAipzr2oc40gqfCK5ZYrCX3MNE+bCT1raz0ElMXOwFQGcCviDnbeQV8J+xMKNZhff02X8ONbSSd4IRAZ6SM5Zvgguj8UKJo5se291r1sfz5mfKYaiTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2A+4JAL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso3144925e9.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751615609; x=1752220409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWV6N46YCWcyFKoNN7ytQeutwvqMPF1aOuLppT9L42M=;
        b=j2A+4JAL/m4PA27zELaw7cVrAH5L0fSLqQk6Wmbvez1uHwdzHyVG//deDlkyRYHOGA
         Ef4dx+5vsTcylzAAHI8hy3YEFO9s099bLru0Et/EXGl7bRxgHzEBF+I6VEr+whiHrYOY
         0LksqWqitChwetPVQNcUJc9S7ioj8hhVRbji6A9SmRVsaMFmXhTMG+ZNSdn5qJqFRFQJ
         IsB/NpxrMu9ZLOjW+/NMWZcI12mGkLORs0OLCeLGkqNjscKkGYeAad+RDzpmZU5tP/+i
         8+ULIwD40FhvuHEp06JAQ6JSuBvgNcBe8ymr/fZ8maZrdFbUDPRBJ2aSpieACsP+hTeG
         JZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751615609; x=1752220409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWV6N46YCWcyFKoNN7ytQeutwvqMPF1aOuLppT9L42M=;
        b=N8yKFrAuWYJD19dHpATi1H7ZRXo0wy2Msooa3PF5PV4idV39fJhEW/eawTeykhKuQo
         sFgTm64SxXHVkmb4YntQ9SPLcBbnP+z/qh24En6qVxg4QDip33p3qw1Z1FKjwIIfy8Qc
         DN9WB5Ba2GUYR+KybtBvCMB/iMzHRpcXUmUzM20+PlfmD+gw4favLfJVsqogqgZlUQYY
         7VWA99bO1y9qqN1sibvFubs9n+o12VAKyZTwAQjR6OUXqn8cNKbKcC4aYe4vjE/xZYcn
         G4zOCk+VBWVl/0J4wOI/7vbo8eYNe23V6hhNAThEf1suqcCpys6OUOy4M4Myv1E9Ac3T
         8beQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjEKzOkJwgMKYDfdG1+mCrxOhMabLkYcRFGQ5QxTx17Q2VNdflOwDvfr9EGZEU8Bh7ij8+QywKrqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9S5ZsrsaZKcL5wfyTODv2jFKnQsnlKpSXENAX4KftDhG4Meso
	riZ0pEZbodcLFIiQP2rEXGKaW7wCkqhU7VzXDPVi7+gOuxe88fpp2tl1OOw9CTvZ19/OUHrlS4K
	atOABjUwfDg3HWxgz0A==
X-Google-Smtp-Source: AGHT+IE0bh3U7cJQpUshyJ2zCxCWKYVhS/atQp5WI6Mvd4s8SgWIQ7QsV49DdQFGizF5VkFqrdrBYInDOCz1+0g=
X-Received: from wmtg7.prod.google.com ([2002:a05:600c:8b57:b0:453:65ee:17c9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c3:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-454b31085e7mr14720135e9.6.1751615609724;
 Fri, 04 Jul 2025 00:53:29 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:53:28 +0000
In-Reply-To: <20250703-topics-tyr-request_irq-v6-4-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-4-74103bdc7c52@collabora.com>
Message-ID: <aGeIeJ8_Wj_QvEf5@google.com>
Subject: Re: [PATCH v6 4/6] rust: irq: add support for threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 03, 2025 at 04:30:02PM -0300, Daniel Almeida wrote:
> This patch adds support for threaded IRQs and handlers through
> irq::ThreadedRegistration and the irq::ThreadedHandler trait.
> 
> Threaded interrupts are more permissive in the sense that further
> processing is possible in a kthread. This means that said execution takes
> place outside of interrupt context, which is rather restrictive in many
> ways.
> 
> Registering a threaded irq is dependent upon having an IrqRequest that
> was previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Same comments as patch 3, otherwise LGTM.

Alice

