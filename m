Return-Path: <linux-pci+bounces-42553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6AC9E54E
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 982553466F9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACD2D5A14;
	Wed,  3 Dec 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/JDQYTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A772C21F2
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752395; cv=none; b=fg3ebFvxGzQOSppvWu8tOLUS3SP4YsCJACE6aamaO/V5PQ+UEUniqKVJp67Hrc238oBnu0BpRwb/uqfASWz3UnBHpG+HVgzDPkcvwbvdfx+OB98VC1b5/RLFGnYaF/IGxPCSK2yZv1IVj6lSzhFEEYMKD0blfZOzDYPQH0MMtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752395; c=relaxed/simple;
	bh=sIrdKwmuLsmQjOxxEb+3ByaAez5EbfKfFuGxE+SxYFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b+z7r7A8SlQebkmBdc1gYZ0TfFVT/TPjkUx0yBd1b902oRgnIK84W63nmhQ+4+mCpp7L4HvVWmZxS0rbwl7LIzANxkHCDMlR6FP6TiAjdLLe0mKCwc9wo75qeMjyIzp/alag5u7G4F5KmVsNfOek8qPJu8oPLiALfzNVzVYM6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/JDQYTk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47777158a85so56666785e9.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 00:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764752392; x=1765357192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2qjCfneRPNdybFJOwazXOzp6EzGQSTlHFm7BKrgpwc=;
        b=L/JDQYTkKh9RTxqvLiYpqq3GChlw6HsY5fLdZsZpE7CyPnmoU2Kvotqba/er9FjBBZ
         wCsKkuV3PTXlMMXDpslpciAs6LamkerlUVuItOoyadcXx+3a2uwYFsfa9QrYFKaYmdxp
         0HWmL/kZZd6vWq1N9S8jUcYZ1BUDR3mJUcuKPpbrNzuVvsgepD3Ww0lT3E96WOSi5e9l
         ZqfInpCe23csBwDU4EWuRRGL4rUfTZnByjEhuIQ7Y75TexqTGIGBk8RX3kKD9k+axR2R
         QfFmjl9H4AaB2bb99KAWZB6XFrDDmLQqRuUfLKwwnSJAB8LMKsJnJu7bbLuQ/MKiHreE
         1D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752392; x=1765357192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2qjCfneRPNdybFJOwazXOzp6EzGQSTlHFm7BKrgpwc=;
        b=eWAv92FDkNAXP1kSo21Yec++ob49b0GsF8BMiIMrcb35OPRyI4uaxFCOfcWfhELCv9
         r58RYV8lLB1r6GJUhpwbP7LBYmIoDSuXfmDrm4A462ZElPN7p6bfLypEue7AIm6IR8qv
         uspTVlfyjFg/0qQnsMR0ysNl4CXQIOwWXeImgnVkrMWLUAL7xe64bkpp6K3kL9QIvUYG
         1yShQWjE8fbtCjWMFnJh5lSgTg44p6HbHQ+8hULbR7ZpzW192WZQNsLg6bUlx351cKI4
         737FZfZxY2gusHTfPN+VM7OmLDii+oydZGLexBQHnCNxYIiQBj7xFm6WlUD46MLcwVm/
         MwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+QoKWxpg8Yeo2z2FQXhSXytMBk91gAWjprBTwj1j87msgZb63RwhDQ5ukNuBFs+5UiscWzZ2x7Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxINeVL6fKcH9KgSA5+A9Om6GNcSWzLfyXggsRa768xHigp/a
	Y4cn5gQcidJPphk1S+n9EqFamsWm3gYqDZMbTEDpBP+H+tvGCv8E7G22++fhhiK4QZigsddZAxl
	60b1adV6CXxDc6Zkqjw==
X-Google-Smtp-Source: AGHT+IH9vtv/i7CYP6tyRnwISXY4up53232P5t1z3PTIcbi/+llzPz0PUwcQpxLmhPW/Y4uS/xDQRvqIm91HMDU=
X-Received: from wmlm26.prod.google.com ([2002:a7b:ca5a:0:b0:477:7ad9:2aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c87:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4792af48eb2mr14624205e9.35.1764752392654;
 Wed, 03 Dec 2025 00:59:52 -0800 (PST)
Date: Wed, 3 Dec 2025 08:59:51 +0000
In-Reply-To: <20251202210501.40998-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202210501.40998-1-dakr@kernel.org>
Message-ID: <aS_8ByHdEDZHj1F-@google.com>
Subject: Re: [PATCH] rust: pci: fix build failure when CONFIG_PCI_MSI is disabled
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, joelagnelf@nvidia.com, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, Dec 03, 2025 at 10:01:50AM +1300, Danilo Krummrich wrote:
> When CONFIG_PCI_MSI is disabled pci_alloc_irq_vectors() and
> pci_free_irq_vectors() are defined as inline functions and hence require
> a Rust helper.
> 
> 	error[E0425]: cannot find function `pci_alloc_irq_vectors` in crate `bindings`
> 	    --> rust/kernel/pci/irq.rs:144:23
> 	     |
> 	 144 | ...s::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
> 	     |       ^^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
> 	     |
> 	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
> 	     |
> 	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
> 	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here
> 
> 	error[E0425]: cannot find function `pci_free_irq_vectors` in crate `bindings`
> 	    --> rust/kernel/pci/irq.rs:170:28
> 	     |
> 	 170 |         unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
> 	     |                            ^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
> 	     |
> 	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
> 	     |
> 	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
> 	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here
> 
> 	error: aborting due to 2 previous errors
> 
> Fix this by adding the corresponding helpers.
> 
> Fixes: 340ccc973544 ("rust: pci: Allocate and manage PCI interrupt vectors")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512012238.YgVvRRUx-lkp@intel.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

It may make sense to add __rust_helper to these helpers right away.

otherwise:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

For context:
https://lore.kernel.org/all/20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com/


