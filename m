Return-Path: <linux-pci+bounces-31507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DFBAF89CB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E733B540CCB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C7283FC8;
	Fri,  4 Jul 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqKkNXTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7A27FD4B
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614998; cv=none; b=FR3yj7HlT9VMWDfgW6a2t85DJPFAgJTWlkkR75NKpvQltGq0DrGMmbov+f1vCX/axIO1hK7oaBYO+8ojzQPEC9Z+koLcOyyn4pogBLeovEUBaMhY36AyeW75V9oTaHm2pnwUDimm+rIOqIh6+UrpBMiZRXNw4Cs5EAlyOwtDGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614998; c=relaxed/simple;
	bh=1BRiW96rUpghvx6qICZQHHMHu/XS/upL65W6e5iOCgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RUcv3ckVuSrFxYxTGaLkvFSGbnV0KLq6X+uD1musiMNQZ1DHXkn6DHQhyOqAVR9P1h9Kuyyh6qyAMPCG7ls6i9KS7VzCKYJOPPzOzQAT/S8Ue1gGtN9uiWVUxEx87vAzKuSs8Gy5yn3/ka6QQIJPAqD8DbOAmiZxpS0JAQnZ7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqKkNXTR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d30992bcso4252605e9.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751614995; x=1752219795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Trbkf5L2/nBS7LLO18/vGBZSMaVa1rVVnPz6wCKHNqA=;
        b=QqKkNXTRMqATY85UkFun18dUHYYJbcWiFyHsrStPz6Y5pD7VOHxgNj+99hy2ujjks8
         tx7x54lb6DtGpNNFznkk8EI2WpxiCmELOiRsBj4DraGhI63Tslyo/G9smTuQLlm2kivl
         WHjKGw5cL+Dm8d2uUjhIgWjZrR0BGm+qP+GbVF+U+V4DmxJjwp6wBPP/OxUvRCrgp5tb
         eL+S+rTMNWo0kQPs5YDHfKpuv3+HnazHTBSZXaGet0+QYEFBpsHD6cGhMlfO7eJwKzb1
         +BEtfpmRTH8b82O1g4oVkIqTDcd5iPr3lInrHeZyrsFfTCnzgZfaLhslwpUjiId4X8J5
         EqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751614995; x=1752219795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Trbkf5L2/nBS7LLO18/vGBZSMaVa1rVVnPz6wCKHNqA=;
        b=Oz+j9LsNJrNIyKVJ/Cl5Ph7emsXpsu2Envxx07cOF7c60iCz069AZxK8FAFU/tQmPI
         JAeydhdIDUZhW5wHERtz2r9Okq24TGjYPt3ugR9rNjkBAbsjOuh1JV8jSv7lQBYq+ZwT
         /oeJ9sIv/Rky+/tIj1I0P4eGQvKuIpB0Ic46pKHMB+qcteIIYA9qx6fuVK4AokT/vO9N
         ipNiTyStcB8wqBTEFHtiT8mWbOYJYXUdW7YXDAq6JMpWdXpYPIUypekhD9IvMgHZjrAV
         leYIDt46eB9tOtKxU8zXGKmJqC2UAkmSVAOqS+Kht9Jc+0I3W9ACtcfW6TLhXNUmcorr
         f/9w==
X-Forwarded-Encrypted: i=1; AJvYcCWeRt2JdyPuJ92lwyXM8lMpNIxZRnXc71TEdhOlnMUWZwEFwcFEKG1rXjZoe3mXgE7kWUJg4or1yHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9rGnO+gM8UiRhrgwpmbVARjqmAoEjgGKLgTpfjDSqZwVKcZV
	mKRmwIThb65WHPM/xrYFiwwIWoyiyrmgD37YDX4npT1/zOJ8edO4xd58qoRwtPhZ1jQOtAq7Mrk
	fn5mpPKv+5nIUSBDUOg==
X-Google-Smtp-Source: AGHT+IGvb0vLGZH3H8NELYBKZnOLf+QcL2G3KHfh+CH2+bafytEWalGS+i6LYIUc1+KQFnyWHN2Tzjq3rWi21Gw=
X-Received: from wmbeq7.prod.google.com ([2002:a05:600c:8487:b0:450:dcfd:1870])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45cf:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-454b4e779camr8985075e9.8.1751614995067;
 Fri, 04 Jul 2025 00:43:15 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:43:14 +0000
In-Reply-To: <20250703-topics-tyr-request_irq-v6-1-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-1-74103bdc7c52@collabora.com>
Message-ID: <aGeGEth0mmVNLWwg@google.com>
Subject: Re: [PATCH v6 1/6] rust: irq: add irq module
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

On Thu, Jul 03, 2025 at 04:29:59PM -0300, Daniel Almeida wrote:
> Add the IRQ module. Future patches will then introduce support for IRQ
> registrations and handlers.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

