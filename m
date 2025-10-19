Return-Path: <linux-pci+bounces-38646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85EBEDE2F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 06:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6E63E2558
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A5212B31;
	Sun, 19 Oct 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyRbaPc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1661FBCA1
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760849976; cv=none; b=XRJGjI6U2XTQSB23LFVgXWw6dh1VfutlWtcnKzTEbB0Cu4u8Bv+ac3AmNXdmn2G1XFAoDiYiok1WyCYTmyuSgvt1rU/pw8R4E54UmUFKDdv5t3RQusqcMMsjCW52PqqTTlRH5pr4YAd3lpKBDeLXGOatDBXQXXpDg0LFIwJlfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760849976; c=relaxed/simple;
	bh=Ji9lq+aNwm6hbpBt5h92c/WN0f79IQ5SjMVzwETCTD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ee87MIYCejZ+jZjc/x4KMXKGd6SQpSjo4v5GR00/9RCB1Owv49jgDyZnc+BE8DKB6qbkIU5cIHL27dZ0Ld9xUiGl69tuaP7E85xAaoqUhHweDJ7BDdUvFTu6GCtbc3QsmlOgtN1Eqrxxipevv02BvOLKrhZrN5cBkBEEp2lBR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyRbaPc7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760849973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Rg5wTZhyWXAF3O1WtCbMwsNNr56nuunOEL5hac1nco=;
	b=VyRbaPc7aR6A7o0O9YgP+nNOA89Hpd1eXSQMissz/G/xb/HGwqk8sEEw9jEny4ti3mMVT8
	Wi3eStxytEePDLD+C0uJAuopAxUTWTmgyOF6/cfFAFLJ+lRpmCslK6j5C70R0TbblMD54v
	EKM9iuVdEPhjY1/XogG3J4hmHAoWXG8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-eC8TgdE2Oq6Fx7rEmCIrtw-1; Sun, 19 Oct 2025 00:59:31 -0400
X-MC-Unique: eC8TgdE2Oq6Fx7rEmCIrtw-1
X-Mimecast-MFC-AGG-ID: eC8TgdE2Oq6Fx7rEmCIrtw_1760849971
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8787a94467cso118248726d6.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 21:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760849971; x=1761454771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Rg5wTZhyWXAF3O1WtCbMwsNNr56nuunOEL5hac1nco=;
        b=cQiPjaOMast7SWni/YGeVO+9aHEMgCS0cmRQU6RDi4O5QFGm+aEgKWyl8lAKgEtstV
         BfVfc00OhOvDF1nHlvsLD/3S+Xvu6JOavYyLra7Tta+mHeiqD8eByNvRio+xkK5Vk2g6
         gXb8f11gBk6gasiwbIWGubFk3NmX1wWrslTmvinilzJ+lKDIMayZf3wAeilXsCDL3cZO
         JcGht+WAvtb1UuUi7dzL4892x7KAZ1ubdK/afadytkrPy87oJJ29bY8ly7rX//IXcSIq
         EXaZ6LudUK+Evl2nNCZbbHeXccJUF3+4O23+aSKojJsrmCrCZrjF2Rs7dkmxStEJYAK5
         qCfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/6bmuvz2rzuUh7/zK54IbOVruI3tPHskGd/xt/eUPbGmsS3rpEH5Nf0AMejQyRp8VNpmwQg+8Vxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0P3UY42UHj1tCUG3EyzWRaqxd2vOKZ0HiQRqws7be/ktYjMP7
	gPUnVSi+dNVPfaHbL7YnUbH46KbD2d01q5C1gviEFAiN5kpEEGspzHWSeCU1Dr1Eml1EOTKmBDF
	LkLadiDFIQYRyCG0xAIKF8+yWw9wmO3O8CxgZqcfw/l7GbKzvzWivR/OneB5tdg==
X-Gm-Gg: ASbGnct4UF0bzjaU73gAabGulpA3WMAF7quIJOnboDUTtZHX4iOW0GBvQSe+3knTOUK
	LgiwBCP2hlXBQ29IXjdPgZLTwA4XWehxlXH6dzqcCkjXJWNgskP3F8HmewuA3yMdpGJO0wdIX49
	0Pt9cPW8acXas4aAQQeaQJLSOV6l6UVBxHAqq20GMxNDIExCYzyk2iz8jzMbHFHKvCPWd/xHFxF
	n1lgANDFDmySx7qRojeW/+oWI1CVbsSIyqA1N+fDwilBpYUO+mOTVlRRAx3zCGP6c655a1z/1nx
	QwQjHtyvN5I3olYcwa6V5sEB8ffKncaniGbcGp9+ktu/SN29dR/XbxOh61rQNIHEQaCIZ1SW4pJ
	JJdfuEijC+BOG
X-Received: by 2002:a05:6214:246a:b0:87d:cb55:823b with SMTP id 6a1803df08f44-87dcb558259mr36428406d6.51.1760849971356;
        Sat, 18 Oct 2025 21:59:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0WYFs94koeYN9P9Lx60CmnPlOsYnsSjjwW8eWntBAW+OKyfBWDFQcDFBfZw6XpdAUPZJUw==
X-Received: by 2002:a05:6214:246a:b0:87d:cb55:823b with SMTP id 6a1803df08f44-87dcb558259mr36428246d6.51.1760849970966;
        Sat, 18 Oct 2025 21:59:30 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 21:59:30 -0700 (PDT)
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
Subject: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in comments
Date: Sun, 19 Oct 2025 04:56:18 +0000
Message-ID: <20251019045620.2080-1-pcolberg@redhat.com>
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

Peter Colberg (2):
  rust: pci: refer to legacy as INTx interrupts
  rust: pci: normalise spelling of PCI BAR

 rust/kernel/pci.rs | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.51.0


