Return-Path: <linux-pci+bounces-38780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E2BF296D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB5F24E5241
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7682BEC22;
	Mon, 20 Oct 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4KYG/2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D260221F0C
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979759; cv=none; b=DSoGVXgPkFXfpgwVUOPDrnhuTmq2btqZ98wS7O1PBLF1brqYggKSF8o/Fd07pYmme0H1KLe1uphkUCZnAjXLCNXaxMcrK6c49TwA1axuy77eOwscZja4VrSF0P+eEGRA4pQ4ymI/UJEke6nAMey0YIYe6Dwoc19JZg5s95JDfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979759; c=relaxed/simple;
	bh=v0g3ebAkGtWaaXXSBYZkhOaLL8t5bHd21ygK4QtLRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHU7DAJLsEOB91S0m6M541X24KG7mdXxLBCdVOTyPFnP6Bw741atznFOxkkXlwuT+b5dV4X/CapAoPUKDB2hjBcu9JS5muJGFbhxNhupPoUkIreNaSooJRdTM+KHSQp1V/ajYHy1Fwvh4A/KQrPBs35lr0RTWvi13h217Cl4GzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4KYG/2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/rLXs19LjWdxvoKTER+8Z+MHCSpaGRowtI4SJ2kq6A=;
	b=T4KYG/2LCM84k93YR8b8nvJWoUvSjsH1SKWAjqh0bbw+sQvnc0hj+enxypQk6l4wo560DI
	F7QuqG3rvemBUk0bW0M5fwSV+UayjakuR190epTwW8BVpg6q7EIjtH0HvxVDc69L59MCrc
	S5O9Ve3t9o7aXPKm8KD106o28SkUSu4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-2C8Msp-0Nza-knAubzs87A-1; Mon, 20 Oct 2025 13:02:34 -0400
X-MC-Unique: 2C8Msp-0Nza-knAubzs87A-1
X-Mimecast-MFC-AGG-ID: 2C8Msp-0Nza-knAubzs87A_1760979754
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-891215d399dso1005264885a.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 10:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979754; x=1761584554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/rLXs19LjWdxvoKTER+8Z+MHCSpaGRowtI4SJ2kq6A=;
        b=Sy2HVRqhnuWLG0qYcqQ31/3pt/sY+swWCIKbtt4bYvjNEhUr/ICYO0rBY6k6lJLl44
         d57mLfea74qwHHEh/OGpQH7PO5F+ftXM7FpFntQE0j9Se3tC5W6bGcl+gjmoVhPQzS+Y
         sNCuamvQAaHx03wf0h9/NhTddjMNaTze62iTXiEkRFWnnI63372vVXmUGm2gGEr6YGjH
         pWBZQi2goq7VKRCxNw4nbRXQLugYbqDoB4jFBm1EMKCSF2aZIkhiLJDdEfTAjpmjx7xt
         rTeXCTv/w0FIMVd+oCSaQnE6W0TI5F3m5//plMC3jRqkMc0FKZF5csw3fAYgDY3VlEcc
         CJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlVPDCj829XQX5oOC9Y/bydavezqYLvGugavcstku9vjUqEMaKENdWq0zQcXdNDtBv27K6UPTIsYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCY4swAt8T5q1wAQCoHuK8mHB0PVNlb/fT/j4W8SCs+PY37Qo
	R7EzBAtkfO5u4RlORtAU4Ehu8bb0+36uHuGAOw0X/K8vE+hqyPSkp8Oum9/wocBgdFM8yN1TI5V
	r/5Fbv/+Ry8AVL0zUNcNQXHN2amuJ47CU+63PXwjSu19doC9lTO39sCDkl8EjIw==
X-Gm-Gg: ASbGncvDlQ85ByLbw3tLx5tOO2PYKmQHPOTs9RQeod5lWwuw34OEEYb9H10+iNcbCPA
	WjBzP+BKlKX1NjQlPyel2Lely5ky2h408rtKOoEhb4OQ3kaeOfIyhkfQS2SS6DhAb0aDpfOuX48
	ETvNoGVE+jWEkZ5LImuvLe0ryFiAIVdNx4nerq+n9IxGn2hoY4UZmqmJfF0pvLudPwbMYaPHuZ7
	j/NkTrecwaUQKt8jHmAqc2aQLHxz7R4juNHfKFaN2Qbay/zqHbLqcy7QMdDIW7TcInZw/cteNZR
	SN74p4YAKxm5qdLYQAv0UlWYG4fcT/xFFhE6+h9Xt3WIPcNVj5bqXtYEpq9LtvdkfoYMh9IxCU0
	cpcWttNG1F1oR
X-Received: by 2002:a05:620a:258c:b0:7e8:46ff:baac with SMTP id af79cd13be357-8906e4ba3d0mr1771875885a.1.1760979754297;
        Mon, 20 Oct 2025 10:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXXKot6xR6N+YJ5vl0QrsU4HJDgE4R1Ck46voAMrZRdvKXcRoOYSOIO7z8IOJqZtMhnHWzA==
X-Received: by 2002:a05:620a:258c:b0:7e8:46ff:baac with SMTP id af79cd13be357-8906e4ba3d0mr1771869685a.1.1760979753864;
        Mon, 20 Oct 2025 10:02:33 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eecbsm589945985a.49.2025.10.20.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:02:33 -0700 (PDT)
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Colberg <pcolberg@redhat.com>
Subject: [PATCH v2 0/2] rust: pci: consistently use INTx and PCI BAR in comments
Date: Mon, 20 Oct 2025 17:02:21 +0000
Message-ID: <20251020170223.573769-1-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series normalises the comments of the Rust PCI abstractions
to consistently refer to legacy as INTx interrupts and use the spelling
PCI BAR, as a way to familiarise myself with the Rust for Linux project.

Link: https://lore.kernel.org/rust-for-linux/20251019045620.2080-1-pcolberg@redhat.com/
Link: https://lore.kernel.org/rust-for-linux/20251015182118.106604-1-dakr@kernel.org/

v2:
- Rebase onto driver-core-testing to follow "Rust PCI housekeeping"
  patches, which move I/O and IRQ specific code into sub-modules.

Peter Colberg (2):
  rust: pci: refer to legacy as INTx interrupts
  rust: pci: normalise spelling of PCI BAR

 rust/kernel/pci.rs     |  4 ++--
 rust/kernel/pci/io.rs  |  8 ++++----
 rust/kernel/pci/irq.rs | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.51.0


