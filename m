Return-Path: <linux-pci+bounces-38257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A01BE05C0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB1F4F7AE6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384130CD84;
	Wed, 15 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCXrNsQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3353074B2
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556305; cv=none; b=r81mGycfxXcDAvlkktAFMrKWQqGWqTLAFawbL0+7xbui5NYbxC3ovvvka/kBKwnwYR4utXulxq9XO+8OHLxES7I5SevtLsE5UBQ7Wk9UEHssqoFpLWqAAvwiU8cfutLPsvqZx+rxzIc6gmSFO5sbyVKkl8aIHUkYY0apkg9/yDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556305; c=relaxed/simple;
	bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9FlVzaW23G/KC2KUAkApkjwlTweu3gcF0/jpElSdZNChyy2KhE1+s1zeTPoxdcWOajzYeU2XVr9kHgAImvcC9hRFQuT2s1j2gRsj9GPhxuorCIoh9jk0Eu310mFFqebyt0OHv7/UKxB8XHsxOxxl6mn1pzmbsy/Mn7gJ0+xSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCXrNsQg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7ea50f94045so19387286d6.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556301; x=1761161101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=eCXrNsQgdp8f7K3ebgai0Hc+oVtG7Ooih1CjwjDKKEEyyZRL04k1+buVHsLdrDdZFv
         obRzzMetWY20CiOmgFh7z8jJDzH7T+zw5ad6hPUzi20sx6uv2ldeQpYGde6OGOnWOJtp
         DzdooGEYRpumj3IjZjDj5FLmJiQIgw/lO/4Zja9+GSN4nT+5DkaGtfbovJl4LG7Uj+b3
         TspXozl6ahSRXhsy06RgZaVmFezunO2qz+23kqlR9f7/KhkU4nmjfwvir8p4s81peDQG
         DFQHwm9TE+r82eNAPhd1D6oKZey75NeQZMRi6ScRstLl4TZXS7A5VpedXZCDRUJPBnAG
         pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556302; x=1761161102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=SylKgUKuLMy4f+V4TWmqbfNGyvCrRFA/6QuOW4k1RgRWT2XMq+OHvuqyfN9ND3gvwW
         tRUhKcsg3/rBfq6HeC0SwN1BRIetLtuKI4BJlPBmICvAz/hrnrUqOVVUdj29LzNXm2GA
         KxjaNE2bQnNP4ckDtGjc15B5dXs2YFLQKqVGrw3Ly4Siq44/jKmiiwEek7Jfg1v/VWZ7
         /1WBsrFCezlB1C45DxcHk1PPne/Sc/MDQMNjOl2Upo8/tsyQtMRV9RfIe0gpcatacCQ5
         C7mClexPQ5reWLKdD/u/t/tcmEfrkUaTQmek1H643nrIetRfALeZwmkuIBfrgoOUFMNs
         WkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm04GssA+A91LwjZuHrERq0znzfSwJWb5KDh9BKwQfoHaL4VKgtmVU648BjFmXyHdoXLSGz6GWQEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEE6FtiNUSX3YfJUaHKkv5aj3BdgmQrb4oG90jtsAqa2JvpyS
	8Fwbbdj1HwhGolQG1zdQJaMPiaJs7w/i5dC3YO23Q6mlMpuBzO1X0T8V
X-Gm-Gg: ASbGncsr1BlxlQFneUOTyP97qZnQTaRYEB5KHrsKQO0J4q/HT0A9WUrOoOfSE84roNQ
	jf736/gknwacsVunTx+uvdjlFqLHpPj2Ur7ftdRrv2zHFAI8lh75vSqLq+oMIg+2XGjH1/pYsLk
	JzObqLOx1frSIYepP0+eXrtyxUVodojOTPp2KByMkazWsXNAoH7UsfaoCxGvkMReKhjnlJa7bbg
	r9ru4XRMqvFa/muSewd4r8tHYbglz9pvIU7ZpfEPYOPAZ9tcbywrr7ieV+Au1eXx9ycFQLFjQ6A
	za6Ln6Ij4CdXSSSX5Et8s0M4uhijZ1UvoklwQs/bhOG3hcz+9x46f0oQ38Kn0+qh6t1Pif69oGP
	5IcandH6rwa2Ty5uG2RI1B5PCcJh4lPXCCR8xErVr9Lp/zH17pLQClgZx3aB356d4jajJrg67RA
	MsvhA6Fwt84IHPZLzzpr724mdx6oZ3HNpJ63yoqd2a6M+feKUA3jNdA52d2P14UbPIa52/z/IS8
	lnfj5sG2tp/5WRq3Pn7aFt5snbugqom8Y1O5SH8xkzM08rmMn7cA+A0rE8F/TQ=
X-Google-Smtp-Source: AGHT+IE/6/93cmzALh4Jmouh/MLI95PCde1EljHLkZKlJY4iPwz/j8r/4JCLGlbGVcRLXtlHwQc0sw==
X-Received: by 2002:ad4:596f:0:b0:783:f54f:418a with SMTP id 6a1803df08f44-87c0c8131a5mr22292536d6.15.1760556301319;
        Wed, 15 Oct 2025 12:25:01 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:31 -0400
Subject: [PATCH v17 01/11] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-1-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1642;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKJ1BUAmPVQjuKlRlHXyE7o0qpMUW2qdVnOqngFN6VFfXZIKKvKAJg9piKZPdbhI25H2DhoqGoP
 iQgwB+DS24Aw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove them.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6473baf4f120..8a82e251820f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -146,7 +146,7 @@ fn properties_parse(dev: &device::Device) -> Result {
 
         let name = c_str!("test,u32-optional-prop");
         let prop = fwnode.property_read::<u32>(name).or(0x12);
-        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n",);
+        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
@@ -161,7 +161,7 @@ fn properties_parse(dev: &device::Device) -> Result {
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
-        dev_info!(dev, "'{name}' length is {len}\n",);
+        dev_info!(dev, "'{name}' length is {len}\n");
 
         let name = c_str!("test,i16-array");
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;

-- 
2.51.0


