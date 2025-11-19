Return-Path: <linux-pci+bounces-41694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E185C713D5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27D514E2AEC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD589329375;
	Wed, 19 Nov 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/z0eZp6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bli+iDJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AED326959
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590771; cv=none; b=sP9bHQ9PnXNHTn8TxoBICHnmmRGvQpeBdCH+Dd/x/HZktbxQ5wDoq9X+6fU1jlxkiEPnLYFbhrV0z9KkWBZUr5Vsulkv24YpLasSjsneenjA0Xwe10V1s4ZntYWbZar87ggq6mvbCMS8G7D586cFhTGb4Z0Si9Lwh58LY8mFUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590771; c=relaxed/simple;
	bh=96vzRx7vAI2mBmrVDn/9P0AmXFPaMNtBzGQHfEQkyQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARGf2T+MerxcVm8SWL+eEL0X04ueXbY/PCRLqdMPz7K7XklMr2wCUd7ak4M+BlALrOa+2EywBnkTmmNeDq7fYCQemDD5nEyyek1cSakGr1XO41omiz7B4qpI5sXYLm747FXEIwP4x7RyCuZ63uYtVmhHVvxXNKKVvoVJIoGzNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/z0eZp6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bli+iDJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8tI4EYN4JDf7RLWnoc2eVOO/7lGndZZgrSr2xQc/es=;
	b=U/z0eZp6FNNiBf5EthqMxn14iTL4tvEUhIAPS+soq/REMDXK1zWOhoK8yLg3nKKAOp7fBU
	tVsAUknDWuwX5Yc5RJIQ/PHfsgHhhThoItEvZzyEQ4JUx6d4RyPYeYEknWHTuFtyItOCNk
	KfZlYoR0h3DlHoMi0b46DxuIHQwO6cI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-XSg3JI_LPOSj_PPHiNA4oA-1; Wed, 19 Nov 2025 17:19:24 -0500
X-MC-Unique: XSg3JI_LPOSj_PPHiNA4oA-1
X-Mimecast-MFC-AGG-ID: XSg3JI_LPOSj_PPHiNA4oA_1763590764
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88234e4a694so11047766d6.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590764; x=1764195564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8tI4EYN4JDf7RLWnoc2eVOO/7lGndZZgrSr2xQc/es=;
        b=Bli+iDJgSQoOU8fxk8xpW1Lti52bOhJZuqZJqsEaI9g4YVc6eWCDTlhhOSV7KWUZ6l
         ZvpORWr0qi9aziLXKJ0wi3oX3UIl95islCT2kZ3xZdZPYdu89KPY6OZefdfvtYXXKHR1
         WJPE5/wbE+cIReBz/X6z4mugtBt34gGOw2eR5U55chgsDNp4jp6OOU58T4nLCTb3Edee
         ikwuwlL18qtBsq2q47aGAhNky0xLVehA9fX7y6dapQVo3HAxt25MHBdDIAnh7HXisggh
         UoWN1aE/hUairWASIejlD/UYgtg6rY4l1AMmv3Rqx12V9SxoiL4U/hGJZyOHraoB2lBo
         EcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590764; x=1764195564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8tI4EYN4JDf7RLWnoc2eVOO/7lGndZZgrSr2xQc/es=;
        b=gqe5wkr7lv4tt37nkT1e23x6rVmzMRAjRaqjrSKp6XqL+Vx9oWO55y1Ot9bzGRi12G
         d8r73SFxb4pmeS2N8oRd7R0snSaCTdAnRdbySY7l1ghEsuSlQadO1J1sCYuy531DLEQE
         c/OUdoCuBeEfh5cwMep5yC9QvsrurWs11jiZ5+WkXfHvv/QF5KlI8/kMB9KLTOJo6mQE
         hsh0R3vDes7OPG5HWZ7c45fMkZbf6o3HTBiw5SR33nhC0Wy+6WK/PPMIXEo/LJj8IDeY
         sgCoJ9aZunYmSszfCjOBhGFGxBWryxk6p4sPDIrYYQzF0HykY0R4eMyMLAlAbRcN4r9H
         jgzQ==
X-Gm-Message-State: AOJu0YxM1AMDcj6Zxu09RoDiwLCI53hKZsBnJU4rnMNuKmbOspuaC5f5
	ZW9zabfQ19hmIIFLPeEAgWJcxdsQkbE0vqttxJ6DB44P88SGpglpMD0EqxBtndoju3WSuEyZba3
	N291WHy56oM7GJqvTROIlGqywkUcvooANifHfCfWUwl44sZVtwu1WwMpWqyaQxg==
X-Gm-Gg: ASbGnct5jwRfIfHZHOEH/dzOLzFcrn+lOEJClTDTLX8liShdxGbheL2QfrbVLit5MS0
	CCCXzPUmquUwvDaUoHaRTcr4L4JO+Wnl9otbvqXhYS66bRlLl2qputhVchRWzLxLA6z2iXQTELS
	TnLVUF2G/mLgYgPhFS4ekBKmBC4j4b8FyHqWN5FNz8z6E2hozJl+adjjZS6XkSD41PGTrBYmiAv
	n46BHxX1yfClOgLCcH4PHGG2oP/1HaajzzW2k8vHQs8dYpv7/NSOeu4Frbx9M6A9JaMIJnqMfA3
	OSS+NZtSUpbJDLeYbHpZig4AY/uwBsDpoRz4zDBdzITbM1eI3/XWUOq9yKz659ZAAdCQebR6oas
	wXz6r5NcdoErTog==
X-Received: by 2002:ad4:5aee:0:b0:880:4b32:a0fa with SMTP id 6a1803df08f44-8846e126e0fmr15483606d6.41.1763590763822;
        Wed, 19 Nov 2025 14:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBivjBhOPSe6mET8GARncZ+tJIO6qjaG8DWoG+YM0pRYYJOOFxIiTqJbhAXlSbK26RHnOI+A==
X-Received: by 2002:ad4:5aee:0:b0:880:4b32:a0fa with SMTP id 6a1803df08f44-8846e126e0fmr15483256d6.41.1763590763106;
        Wed, 19 Nov 2025 14:19:23 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:22 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:09 -0500
Subject: [PATCH 5/8] rust: pci: add vtable attribute to pci::Driver trait
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-5-883a94599a97@redhat.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
In-Reply-To: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Peter Colberg <pcolberg@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add the #[vtable] attribute to pci::Driver trait and implementations,
to prepare a subsequent patch that adds an optional bus callback
sriov_configure() to enable or disable the SR-IOV capability.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs                    | 1 +
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index edb2bd41c8a14c8cfc421b26cda4dc84f75b546d..24dda12f6402098a1a323f3b5aae884201b26d89 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -275,6 +275,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index f53bce2a73e3bb619372798c33bc3f13e580fdfc..96aa906984d8a40c5270bb2a7bcf9650a41b7c9e 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -51,6 +51,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 5761ea314f447643b8023b05ab7e92b60e6a1e17..23488fa6179fcc8c7a44df949d5eeeb1b132bd2d 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -64,6 +64,7 @@ struct ParentDriver {
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8ec3e9a38ab3e4941f6c88d70e00b4..400db907e061a6a782b1cfebe9e5744815cc2843 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -60,6 +60,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
     }
 }
 
+#[vtable]
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
 

-- 
2.51.1


