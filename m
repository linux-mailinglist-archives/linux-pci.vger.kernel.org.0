Return-Path: <linux-pci+bounces-40043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D2C2881D
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 22:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FCE3B2E07
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2625A334;
	Sat,  1 Nov 2025 21:47:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674E78F5D
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762033622; cv=none; b=aDGha1P7TlkkvZZSvVHhcug34QLpIR3MyjSnDhPDvIgSF+3uOrLosxyKxkcierI6sw+1pjUQWfI2CjTb7gNfnoFmYDvGS56RF8Uu2nFf7kcepwjxk3//OknT3Kw+iwN1DEIL2o8wlk5TwDkgM3oVjh6ifNcca3SJbhHR5A3PBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762033622; c=relaxed/simple;
	bh=zy4gVDUOf2eKgnJOOt7qgv3PjAeczx3NDERBIxoVyMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TkOX3jlM5cMDo9t9GMqzl7vWOlpOaRTN66MliF2rCRogeCg4/RZKURSVEoXt7X41Uqyv3qZwftWPQfr0e9IjTM41nQWWwyGjaPjcgOiNYgOnPAgFnMpAVgdcfC+e1uuoGUFnkSBVs8CZYytcC0jhJixsqG5e1nMcNffr4l95f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4aed12cea3so619444366b.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 14:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762033618; x=1762638418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMSp0th6bCxP3QA+aJKfwaw3m0ea0N2JmQOxd2MytF8=;
        b=ObZFfcWt9VMopAekBYAzn3JmvHesdx0FAyK1Ho2YTLQtGk7Jg3VeecGSTUGd9iPvBc
         PIHsYtzOh74dPDFLgbigyYP8xDpDAoS4XkRu1kSSBmDTDJWtnOw6zWNNkQzhKaQgqz1t
         OUesO8jtgY8M/GQ9j2zqSXqsk2azZQ+tCEcZ7YxU7bIFyNeTpUkPlLp3vdWtv9vdSSqF
         XXWfr4aLO0wgTgoTpJKAWdVEHyH4KudnXca8K0ajLkCjj2RIutGIxO/itpvgS9AwUElp
         nlw93j646+gvaaXR3dSOfcefxBHd6D7AoWeEpxW8ynhlEHijWxA6NOYCzCRiGv003w1z
         XIlg==
X-Gm-Message-State: AOJu0YyCgDWCJnUoDI4anaMrcU3zIP2aEwBCvDNN0vBYHdyIAuOnDTUk
	r507gi+pNGzM95kMLdWe8o0aVhQy+xLMrYFxU/Meerr4qCrzo5Y+ohi9LWto2Qi98Z0=
X-Gm-Gg: ASbGncvk+7WkLdIwXHhFQXuZu2AB8CtjuNzYxMBi68vJJfH0u/BhACz3CF8+HwN66aY
	WDTwDq4di9bVCrjRVZf+GWRn+vj0C3DDsxjEfsurMM/xpUS5LmyqcADJnX0gW71VcY3a7ryb8g2
	Qo7gqAO96VMK8Iwty9a9Xza8cUCH+w3zYhYBnxD6HR/2WJvuqNu+NdkW3tH4dq7A+yeCJfwGg7A
	ek0ZjRnUy0otwafDQ8yj/BYMNxCP8Qi50wPwMyS5l8QLADVm7cFm4mkfSPAxQ6z+997qZ5qCNDX
	ozLnA+uNzo72uMnTF7uvg8sqHFRUt63QyJdhzynrHmMxG5kLCi99mRnL4mcT1ncixCBAXEwnPlD
	vPGLWLEiHBXHfESsedBcxYfFm2+R+87l97/hx378UooMxLBMd2Uet9SOfsOiWKb0zStFMRLTpbV
	chwwriXwtulKcDj/c76bdpPmdTsPqEaNph+qZw2nXNi8Idi7JPGYw=
X-Google-Smtp-Source: AGHT+IHZgcAnoYBp0Ct2JBYOEtqKXlO7t3pYEblcllzkMJBgqBpPpXdy/sVa6LJHrnC/Uo93PXu/3A==
X-Received: by 2002:a17:907:60cd:b0:b3f:1028:a86a with SMTP id a640c23a62f3a-b70700d39cbmr861322066b.3.1762033617660;
        Sat, 01 Nov 2025 14:46:57 -0700 (PDT)
Received: from vps.markoturk.info (cpe-109-60-36-205.st4.cable.xnet.hr. [109.60.36.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779cff1bsm573428466b.27.2025.11.01.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 14:46:56 -0700 (PDT)
Date: Sat, 1 Nov 2025 22:46:54 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marko Turk <mt@markoturk.info>
Subject: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <20251101214629.10718-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0

QEMU PCI test device specifies all registers as little endian. OFFSET
register is converted properly, but the COUNT register is not.

Apply the same conversion to the COUNT register also.

Signed-off-by: Marko Turk <mt@markoturk.info>
Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
---
 samples/rust/rust_driver_pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 55a683c39ed9..3cbb3139fbcf 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -56,7 +56,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
         // Note that we need `try_write8`, since `offset` can't be checked at compile-time.
         bar.try_write8(data, offset)?;
 
-        Ok(bar.read32(Regs::COUNT))
+        Ok(u32::from_le(bar.read32(Regs::COUNT)))
     }
 }
 
-- 
2.51.0


