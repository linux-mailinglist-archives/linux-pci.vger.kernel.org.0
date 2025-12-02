Return-Path: <linux-pci+bounces-42525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CAC9CCF7
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BA58349B0C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB72F90C5;
	Tue,  2 Dec 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/bS1AM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEA2F745D
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704304; cv=none; b=Nc96sApzEAwlrK5FlI1NIAX8LVi0R3RcwWgU62X6KmGRLMTkV7l4fUsFqITOSwLvjtJ3SjV45RAUhb41EAVSMbycWyUz2r5Q73C9wnQPD05MkKTkDOmZxMCETT9uMLZSnDNkt6seN4674ikOurXjEeKb0nv5sNQfBriPfZMPtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704304; c=relaxed/simple;
	bh=AzRC3WFBY/Q3vLjVIVgCByxiHwFCvi8tNmj1QH3Ve94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ANYKfQZYVNKq1Cf7PitY/G0ERBdQ0Yi+gd+UusZoce46zRQ1NdtO+t8YRFR9KG3BPqJ2NGxcZHwcDqGlUx1doe23en6xSSgFJg+iy2pNtW5i3UKhi1MfVOUX6mcHywc4GBhNWdA0eW5KB2V6QAmkCDM6YD9LxgG2HU+SgOq7gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/bS1AM0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779393221aso33921785e9.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704301; x=1765309101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MF56K4WpNFP2ISNOdvB3Pju7fwJyMMOEICtLWYnRTgE=;
        b=b/bS1AM03VqZjdiniPuAiOrEdQDe2QbUL0oYtWBGtVd93l1si54R0mQG3/OCjc6iQt
         YL61vLAkoo1GrUWTs6LTrDW6G2avMVqTvOwRIephKJ6c2R3f3oV216vJ7Hsc+f15QvFM
         li42PyGullRpW8BT4sBZqFExFUukRKJyIX3Y1JNAa3rXi8yu7+F5644pEMZLg7PM0qIn
         U/YMICHuYtzZ1Jk02furC6eLWDkzx94jLpZ7rT9YWAh8Jvkbs4PG00EQfHsNeXa1uLoP
         C2v6L4FQg5GnFWkbVEruMFHOlt+iDQqAw7ahcaphjr47c270nzlZKIp8yfUfcpwWngb0
         pVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704301; x=1765309101;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MF56K4WpNFP2ISNOdvB3Pju7fwJyMMOEICtLWYnRTgE=;
        b=IqXLQnagwV+BexLjOY4nmz5LSg1WgMK5tunBmP+ulf3KrtEo9JDuXQWKPLoDumVGgC
         X6TjJaCJeWFkyjsSb3M2nzX9EFoMrRFm6X49tq5R7zmosYenF279J5jhafGz+kAsQjYi
         aL+0vGRUxOerRe2NRRgGpSfxtyyy2ka+aqqg1RMxO236OKOwZY0cyaKIR/Oxeelyyt5d
         9urhV6/vdaT/N9dsS5erv49F2FPNYDb7s7jKtEHXSHRFDLSG4ijHrOSuYGd45bJAWhqM
         n0vKUFPl7CDEq8b4QBS/AlCKv+A0A2F6MCNdWhbumMY6FC87HBzXF9FXxNtDPxRh548R
         dMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VMdxCE+ko8mWB4CQtpLRsAreUCZqDQKl33yf7s5nH2YT2vVIvEDikoI4wR04aUH7JKq+bJ5wYMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLDpxpZtmDCbYJvCFSZUjhIG9X9l2TsDkWzUBsXQuV18mPsdX
	BucHD76LsVgNQPgKfEs95X5TNdJhvqF/MG6bphsqnarUETLRBcgim7tB62U0wJOWb7dC33q1249
	LlCLtcb/jdeA1YU2fwg==
X-Google-Smtp-Source: AGHT+IGC2Xs5AK/JfmohwCUN7H0jYiJPC4Ii32MVyNUiqk+dlsh3u368LVs5ZKQG1ZHWB2EcR35c0HxHzASIcw4=
X-Received: from wrum3.prod.google.com ([2002:a5d:6a03:0:b0:42c:c2d6:2a7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a08:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-477c0162e8emr438081995e9.3.1764704301228;
 Tue, 02 Dec 2025 11:38:21 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:50 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NYp7OoK3bsOUfj2xNaPJNGSbqoufrekebFMpKGVqrnw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AJgBfYjjiPMvcYRbacTMtv98Ax3QQDfLyu8
 heBSOm/P6uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACQAKCRAEWL7uWMY5
 RqE3D/0dDs4lvJD2hUZYTIYzBMOVBNIcrNF7203Wn7ujOfokUTt/v/lvfMMZOf3OlQeF27ASf3/
 jR8L5iqzQFErye2TI/6lUGAAAlI7e3AA3qi842V4PmlZ8pT9uY0dGCtpUeFLC1FEBIGYUMSIo+b
 1LObKA5Cemde77+2sAb1Q2GaZXxfyaJJEuEDOJOlc8nhmDvNYsWVlCAuN0jQrzD9+zErlUuA/Mh
 Oynr8zlWjxTmYx5gjWu4UIMsZxB9E+qGu4oo2fZ/EaNAP+smHqRiFBv2rKEa+98dxaQr0SPIvC2
 zndQyJpqIB7GwVl4ciPORcn11AXrkIuMSzLqpGr4lpLhTn7KzUqnZzHU8ZwApSxjG6Q7JIC0gJr
 NbZcIKSgNC2GBReUuk2Kk09FT91NBmVDpD5mP/pLjLXgicnt9VlxGaV0G3k2domy0ZLVXn/N0OJ
 W+W1qxKSlz+sVoad1hRaqIpgSpVp4DQnUmGeinayeeAl0cFKe2SG/kpPfV2+bYGBG0MWTipCR7O
 IVVD+A80CXVNjmW2CcCImAJMcb0yHPW+BodBKwrtcsPD9SFHN4mWQwYMqWq4p+2RihzxCDVwku2
 v3J9D1p8+tyGKzjteX8PDhvOE790rBnsGcoSLPvnZxIMaa+KM8qtfK1Q8bbkGuTfIS2zeRrty/r VXFH84OhZmpClcQ==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-26-a2e13cbc17a6@google.com>
Subject: [PATCH 26/46] rust: pci: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
---
 rust/helpers/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index fb814572b23631c255eadeebccca353ab0dd3076..4b77a73ecda1ab71a7fba8b56a7=
a133d8c77c690 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -2,28 +2,31 @@
=20
 #include <linux/pci.h>
=20
-u16 rust_helper_pci_dev_id(struct pci_dev *dev)
+__rust_helper u16 rust_helper_pci_dev_id(struct pci_dev *dev)
 {
 	return PCI_DEVID(dev->bus->number, dev->devfn);
 }
=20
-resource_size_t rust_helper_pci_resource_start(struct pci_dev *pdev, int b=
ar)
+__rust_helper resource_size_t
+rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
 {
 	return pci_resource_start(pdev, bar);
 }
=20
-resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar=
)
+__rust_helper resource_size_t rust_helper_pci_resource_len(struct pci_dev =
*pdev,
+							   int bar)
 {
 	return pci_resource_len(pdev, bar);
 }
=20
-bool rust_helper_dev_is_pci(const struct device *dev)
+__rust_helper bool rust_helper_dev_is_pci(const struct device *dev)
 {
 	return dev_is_pci(dev);
 }
=20
 #ifndef CONFIG_PCI_MSI
-int rust_helper_pci_irq_vector(struct pci_dev *pdev, unsigned int nvec)
+__rust_helper int rust_helper_pci_irq_vector(struct pci_dev *pdev,
+					     unsigned int nvec)
 {
 	return pci_irq_vector(pdev, nvec);
 }

--=20
2.52.0.158.g65b55ccf14-goog


