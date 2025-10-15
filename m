Return-Path: <linux-pci+bounces-38271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14746BE071A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422EF5849EF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87630F951;
	Wed, 15 Oct 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmI27w5x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F4306D3E
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556691; cv=none; b=GOMV+8BolN/kzIc8YOJg+C7Z++bQdtjOLvNuY8KXo67qFwxC2AH0CsF92AiKcsYhCCaepgsyO9YEC59q/HgQOOHAowbPNOH6ohTHQumDZo09vbxNYMgmGPHM1/VEpgG/OJjLJV29BlZYqB6/FITilix5EUOcD1nSIFK0A7ghrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556691; c=relaxed/simple;
	bh=kNflbdkxnSak8W84DQ9chfjwf1iwPVGgDeWnudi49IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GvxxliKb3U3Zw3dXaUuVrKk0obYsX+98i7EnRll6fqL2rKU99PGyN+V5FDsnV+Fv6Ko9j9ryp7mGwzwTOaCDG6czmhndCDXFfjDCB+J2huh9xbe1zPdCbKSO2Lz+7eDMSZIwJqZPAYu+wZUjwmuxi6BzlSD17mSCtbexVF06lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmI27w5x; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471001b980eso6701245e9.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556688; x=1761161488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=XmI27w5xlSKnfxgSInyYaWeOIFLoYxyVbK1nfeR85kygPzMmThaIuBowCqgYOJ0Rad
         g5HBqy+tccEtFAfG+OoopcoNG0RvjCJUreF9jam6sNl2+gp3dpMdZZCMtfw9PEG9u+Tu
         PDO9errvqX4ws2qc1YlT2rPDVFYmevwWeN3JyMa5DL0GQhXFGay1cpppj5E+gOUUFFl4
         E8RhiEnCcRduX9qlUPvrWGVpUQUCyNeBRaUp62YcKnlZWWh4t2Wgp8npYisR3YkBue6r
         jGDZdhm7qb/SSPRac/oZrEsHqyr8TuwY5FDUPWPBprUXJWYowMCU4cY+8HepX5th914A
         YA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556688; x=1761161488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=mM9tbbDXa3c0ROkiYqQhWt+NWfIHUx1yw92UKAFpFFzQbnV5ht4Y2kClhZgPj1R3Sj
         2boylBgcHFmod0v/AyTbc2YkgMtlno9UuvNIiSlc+rGU9CtDfx53yTsjucMaw8cz6Y6O
         FepUh1kY3NqzuFTWcP7MmmeHye5J1gn//rIMACCa9y/CMQN9sOpvGWIBieyD+C9L9Tfj
         uGrEY9ZvDK3QLymsVQP1EW8PQQFK5xlPYO9Jdr9uIPFahU2AzLy7d7Gd5udR0LrLrdFq
         c/lg8fZ5eBvg0D2J2F0yJnbXsz+sQdEwVrnulN2+2YDxx4jOCe3kTlNrJ1L+Hj/B2ClE
         KWvA==
X-Forwarded-Encrypted: i=1; AJvYcCVedHU1xrtHe1a3hvPj+OrG5N4g4JYX+yRdXe9Xy9g25AHdOQBttc08tEBJUrfop8zMiVfmpcJ9C/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIemzrWvjJzgnH4Bs6aM8AcCmmOJgAm+IXZpLBn56ls+uayXo+
	FLJkKdazpyBNDEYaju1DenAw4e86LwVp4QKv3ZcWpy7NiCTb0/lT2kOAXLOp+CmDFkpeo5XJh+b
	Su815O+0a+1RSgjoltA==
X-Google-Smtp-Source: AGHT+IHkXgCUD/Xg8mwfvq5rsw1NsD7V33g7iy9bartydYztNdh4V9vcMXz0z1HOSr9X/M95RapHcDYXFrnCOyo=
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529a:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46fa9af31d9mr184569055e9.24.1760556688057;
 Wed, 15 Oct 2025 12:31:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:27 +0000
In-Reply-To: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Message-ID: <aO_2j7uQGLbXmZVS@google.com>
Subject: Re: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
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

On Wed, Oct 15, 2025 at 03:24:34PM -0400, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoiding methods that only exist on the latter.
> 
> This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
> driver").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

