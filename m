Return-Path: <linux-pci+bounces-41693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C035BC713E4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D68134D704
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEE328632;
	Wed, 19 Nov 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h672HqNi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuHKdonC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F9320CA2
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590769; cv=none; b=uDF/Cu47APJ7eBT7w4B1eC20+sfL1C7oJ0hSOyk7+fEo3B0xo+x83T47vx6aLBZAe3RS5SoGAq1TsbacrMqWrA9FgxNcMEHd/2w4eclCMjy06jcuzEstdSCrBBN0kIjmnuYLazMS1zkV2GGhmjGE2Dky2VUv5FIWefF1819856A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590769; c=relaxed/simple;
	bh=bzTncOXNg0kWII0nt+8w8axDxjNbZrgM9o9apzDdqZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dwc+6rxPv4skdOgDMaT9WCOqnLLCdfiLiOeSIA5fNyRkXTufqG7MbOkbulWpd9sA5m5klVn4XV9Pp/hWu9Jroivp9sJS1uxEAShiN7ClxivQ+WicEifllaNFoXLGsQHB1eorRJ8JHf9vclXkWaw3VPEqwBynUbOxUh8YBIe4oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h672HqNi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuHKdonC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Sa/28IBowGRnEwfZcsKNnT8Zyd6t02o7EkUf+OoZOM=;
	b=h672HqNiO0w3saqW/8fIX5j+sqnZ3od0X3/XD8dnLa6c+yPpnSChp8d/b/HW4LsEKSwXBF
	xopcBr7Yjm57f4XRAsUfOmAQjFhI6RFdwXDwRYBRemFEc+HBOQBnAqrmKqcBprJgHN5/ec
	mlUNr+iFvtPr02z2F4UNNORydE+BW/c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ARnGZzZNPbyrGTcim0NGxQ-1; Wed, 19 Nov 2025 17:19:22 -0500
X-MC-Unique: ARnGZzZNPbyrGTcim0NGxQ-1
X-Mimecast-MFC-AGG-ID: ARnGZzZNPbyrGTcim0NGxQ_1763590762
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0c1c57bcso9074151cf.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590762; x=1764195562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Sa/28IBowGRnEwfZcsKNnT8Zyd6t02o7EkUf+OoZOM=;
        b=AuHKdonCVXl2KHWzP8/PSMJO6DCdyOsIEJFaT0UrVTJwN40bLgHy/jj2V6tZHnR2Cx
         xXsBfvKZzJ6ZCewansAjgRpuBe3ElS5NnfWP379kxh59tiFi30e50TXa1YUrZv/lr6Co
         quqjyhsghtVQJthAwrOdgkQcSUfrGhgxG/KwXPZuvsBsEfB238q9tTcPLnpXCAXX/H/j
         yvNClMfimuZmbju2U7q17iAZd0f16tIPjIkgOgBQkO2HbtaXQ+jtbr2STQYnYRqTqjhr
         VOjm85Ch5S5mOagkV2kp3ITv9mkrtBXx7KNAu7nPve1POg65OQ7+JQdcYbJN2mbXHjJZ
         grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590762; x=1764195562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Sa/28IBowGRnEwfZcsKNnT8Zyd6t02o7EkUf+OoZOM=;
        b=gFKF/fJDl6iVZ8hTq61ZFNY3B5+IPyBmlvwCNJsJF0WyEoCjf3GSEgZks88zdqTvea
         30eOJyO8jojzt1Pte8bmi9FM0gKFSiaV/EQ2UwHt2w/fEOo2/qCKkLLw1NMihxZNXFTM
         O+VTPpf1XWXf/nJlHwjSwxmk6HnI62kSzpovBRBzcedZqApxdE3SIDbGU4rslffiS5kM
         xY+h0BJjHsm+yBYCojjyI0Tt0LvUWCWDzWF7YFDqDPAFycysVjVgrVlnRIekp+T66jV8
         4dxocGnRT8te+YFziLWEgNMkPgJ5POGkatcsixRPUO4AqBPWWLbdIlteyMpjUAIfUL/n
         Bs5g==
X-Gm-Message-State: AOJu0YxLdr4I71yUcp80a8HWDWfB+2OIAJl3QshQc2C0X0zhIfThLiU4
	oAnDcW2Qu+YKv0bOlTIdzeu+Ps7t41WQA8y84kRR3q7rkINFhVduppohLXMRpfxUhZGbiFbp8LL
	KeZtfRFuK6dBoH3o0dusDsUkZHBaEDLqoj7cuisY2zpz72UOAPvT99XnJhRCZxA==
X-Gm-Gg: ASbGnct3tPI3ivGKA1fhNgDoBKKro/rxx/Ht8CupBOLagJUGoPF/cBWKoF83K53Mefw
	EL4Op/FbXB2SvLYo9omyWbDq7ZVk3Vb7hmcgbpwAchA+P7JbODmzwiCPo+E04A/qwXRdLodiF3r
	riMGuFPXT0PfvxRkQp0vwaiE4RkiF4N47gDmLoxLwk8s0hbE2ryBXvvdN1FjQh3kmBgllHRgM4a
	d7gONNHrCCuhTdJMVCm5MK+80kFAQifwV6twBw214DhgtcvWhy/TLMjTxZFprvmQXLu/2EmHiXI
	4XhJQDEaTFhSeBvq+LCd56x4DFmf6HOK0NPmCTFzr29GQLPKFWYOFO+dWgs9PuIn7IJWGaddjvo
	xuwNRgIoDBmHOMg==
X-Received: by 2002:ac8:5d4c:0:b0:4ee:1907:13ed with SMTP id d75a77b69052e-4ee49705856mr10977741cf.51.1763590762154;
        Wed, 19 Nov 2025 14:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvp/HJwXtKnotpgRtr6UAvyPlB/fAc4k6E1PSgQwkx0nIFctwGmjJxEpRk1C5rFdIJc7Go6w==
X-Received: by 2002:ac8:5d4c:0:b0:4ee:1907:13ed with SMTP id d75a77b69052e-4ee49705856mr10977141cf.51.1763590761534;
        Wed, 19 Nov 2025 14:19:21 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:21 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:08 -0500
Subject: [PATCH 4/8] rust: pci: add num_vf(), to return number of VFs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-4-883a94599a97@redhat.com>
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

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 556a01ed9bc3b1300a3340a3d2383e08ceacbfe5..edb2bd41c8a14c8cfc421b26cda4dc84f75b546d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -421,6 +421,13 @@ pub fn is_virtfn(&self) -> bool {
         unsafe { (*self.as_raw()).is_virtfn() != 0 }
     }
 
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn num_vf(&self) -> i32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {

-- 
2.51.1


