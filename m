Return-Path: <linux-pci+bounces-31800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27831AFF1DC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1323B5E96
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B906221F31;
	Wed,  9 Jul 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGJwVVYt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E868479;
	Wed,  9 Jul 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089478; cv=none; b=FU8JTVial1U0bob2b24E2gjv74KVeTqUB7dXOghQusWxA52fWIM1s0bq4e5WkAUUoHshq2htblSA3hUo46+1Hara0tNNoTB+8jVGk0pzngfSp9EYzr4uWcPKhyekmcHyT8zrb9yG9sTliaJOtE5fa/atuPKnpY6d5JuYzS+uicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089478; c=relaxed/simple;
	bh=QHOQuys68Eep3AdeqAw3nBv5Wp0vgE8ohEfQSBCs10M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hCntvvvjsylcdkDZM3MBHSV98oEhVQVJeyQDobCmdcFffsDQVWx8k7EopWUXbhtRe+VLJ+Tjfwx5pM86Sq9IqK9cNTaEALPFVVXgvp5/O4kwgjrHk058AvheZp9vKVBshnZKrkVibRVxLqLbG8uGbrNs4Gwuvdl7v5NDin2/SYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGJwVVYt; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fae04a3795so2801396d6.3;
        Wed, 09 Jul 2025 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089476; x=1752694276; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Al5PXuIPn1m6Jc4vWyJYQqbVbsA6WUY9JeCKf9JiRnA=;
        b=UGJwVVYtP/im5iYno3an9DlhVDau2YmnkanhnHFkpdP9Iq1+uNEmlwVDOBxpHUj3ec
         PDgSbyPBHOdBFmc1bQY6vbo+wmFXirC8//K4zYsr8SiqmQqNlDcAuP07qsjB5rsl7pN+
         W6jMjt5r1keOKqADJ0hEy3Fq/o4wkxyeLrJfwThh6XaLK5xa8/zbYeps1siMrLwq9mQT
         ghb1S9qbWQIS7fHfjYQHkJa6VOCZ9drh2KL1JsY/GhvEmNM42dvJF12crIoh8t3oEyTQ
         zO/HWuQo5Prrj4aSJ191s67xUiQqkPOrBOvZZGsb1pT+Tkh0SF6Fd0/2qTg34mah+Fv+
         hwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089476; x=1752694276;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Al5PXuIPn1m6Jc4vWyJYQqbVbsA6WUY9JeCKf9JiRnA=;
        b=Xvod3YANjk6kd4QCntTK3h0azNdC59jwxR2apZLuF0nHiIeRgzct8VQB7Ld9S7p7W5
         0aro3qNjQ6ye6DDmAMUQSZLS6E5P1eQ7UTM4MZoL7mAbEs2PBHYQlVddp1oYuAnIJB5y
         IkkG5Hz08R7hyd+06UYPSYhRYvvygZuGfH1QLGY7ChMslllmBel7Ix5n/9IZS1UkxcbU
         hwZ6L1P95ZeNWUeBwpXnapeEXTHhuQok8GccAQFHrBdlOHe1yocy7UEDYfoseTRE2zXP
         Eor4adZj/+EbgnYLnAcJvZ3hkO4az49uElNfggfUXPAgfumn05MvQ2eXhQsPUMp6eOox
         a6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUjBGSTw58+TOcfXCHFzMvVvpAptcu4od9EbiKGwSwLtl7+nnJlxeyX1jGJHPsUU2qLQVDRpxWArglg@vger.kernel.org, AJvYcCXz2lRn/aruY2kL4HZOeU6rXhLnhue25qIBuOKvq8MXhaozGXWUlxReIQLCaUmdXp34fpY2v9w2k1dTFLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImVRxRHnqpbqjvqiyI8xzi6m7Jf8arA+lDbnR6PKUDJ3EWLAm
	Fwx3JTjqBGqlftV/BXI0WCMO3fdY4fRd6SFzVxLWrD+33HyXPKHNAtmV
X-Gm-Gg: ASbGnctMBekHtb+JpqVbYGZbAE8um5FZ7dxpHQUlTw3s0mOpEqMa1PrdCuVBjlKrl3u
	8CcVLp/7r0Ajrbvo+8HJQGWAyLEvC6SV7NqXKh5g8zYR80thR6tvKc3hMtxb1NSBAZZMIzfESD1
	rSXLAlWq3KgIgyoiwK7aV8M9zd/6j9S+kLLVtOAK0wGXXAKpcDrx5fiEI2HTdRplOl9RCt0fMJW
	petRNl5haqCwJp/3YxG3hpIQEkW8dbhvphS18EPPjj0r0MWOs0YF15XiqKNd697C1t6OzQkgXpn
	mUw/cKeOMjJ8PUkXGxzZizbKk9yP8wAuvJEAJNo8aKxvfHQtGFL3fSgVNFvVOdEklAicQnuCgVi
	KMf+rzfcdU0eqTZe9HkkPoFKY3rfF6DByS2XTyveg2Wc0RmlIvC4vAU81uA==
X-Google-Smtp-Source: AGHT+IFCWLF0gtsaJKl7aGm1cX2g2lLFrsQGcWZoDcjs0UaV6Zq7tpi6v8XOXULZ7eLFd0aFmZWB0g==
X-Received: by 2002:a05:6214:21e3:b0:6fa:d956:243b with SMTP id 6a1803df08f44-7048ba5e7f0mr62551856d6.37.1752089475535;
        Wed, 09 Jul 2025 12:31:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:15 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/6] rust: list: remove HasListLinks::OFFSET
Date: Wed, 09 Jul 2025 15:31:10 -0400
Message-Id: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7DbmgC/3XQTQrCMBAF4KtI1kbiJFXjynuIi/xMbEAbTWpQS
 u9uWgWL4vIN8z2Y6UjC6DGR7awjEbNPPjQliPmMmFo1R6TelkyAQcU4CHryqaVNoMG5hC2VK3S
 rymhQsiIFXSI6fx8L94eS67Ie4mPsz8th+rcqLymjylnQa2eEALU7npU/LUw4k6Eqw4cLJn84F
 M600mvkRjq7+eZ8woH/cF64tMyA3kguGE55/7os4vVWPtS+z+v7J3M9mNM/AQAA
X-Change-ID: 20250324-list-no-offset-96ef65cb2a95
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Christian Schrefl <chrisi.schrefl@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089473; l=1539;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=QHOQuys68Eep3AdeqAw3nBv5Wp0vgE8ohEfQSBCs10M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHbNgebLh8aNEeKSD8syh8a/K9KkWIrNEA4x6sXT2eSyntPn6ytoNBA4Wx4vl2f0VJldwkiDOHs
 LlhF+oD5P4Qw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The bulk of this change occurs in the last commit, please see its commit
messages for details.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v4:
- Pick up Alice's Reviewed-by.
- Rebase on rust-next (minor merge conflicts).
- Link to v3: https://lore.kernel.org/r/20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com

Changes in v3:
- Add a patch to improve macro hygiene.
- Add a patch to include examples for all macros.
- Make it build properly!
- Link to v2: https://lore.kernel.org/r/20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com

Changes in v2:
- Change type parameter delimiter to `{}` for consistency. (Boqun Feng)
- Rebase on v6.15-rc1.
- Extract first commit to its own series as it is shared with other
  series.
- Link to v1: https://lore.kernel.org/r/20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com

---
Tamir Duberstein (6):
      rust: list: simplify macro capture
      rust: list: use consistent type parameter style
      rust: list: use consistent self parameter name
      rust: list: use fully qualified path
      rust: list: add `impl_list_item!` examples
      rust: list: remove OFFSET constants

 rust/kernel/list.rs                    |  23 ++--
 rust/kernel/list/impl_list_item_mod.rs | 233 ++++++++++++++++++++++-----------
 2 files changed, 166 insertions(+), 90 deletions(-)
---
base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
change-id: 20250324-list-no-offset-96ef65cb2a95

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


