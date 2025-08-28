Return-Path: <linux-pci+bounces-34988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C3B39942
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6327AA4A0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B043081C7;
	Thu, 28 Aug 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6y4PIMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E617307AE8
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375986; cv=none; b=YM2oXi0/H7ZFVCQ7YFjHDKxRXsXaaKSU9jUNaFB1cONvy0V/0ChngW8723qs1n1vk5sAXgbq87F21uQWymVGkZjbKhE5Ov++RENJMWUg+B1i16ZdeqsMQPYarDfXGMuvOFapdyxGx8zIKf9GSL5b5pGlK3s3e9x8wYgpa+f2MTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375986; c=relaxed/simple;
	bh=lZ/IsY6gJYHS7za/fVENGpZ2fJIkgAYtEhtCPQncjiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTRm5FVsSkPrnOhy3gF9quxETCB9Nl+dKSe3Yj6U1k+DlRTSbi+8uv2KdNXrJiD735ZOC8q4yl7pBoX5H81mP85XOYaUeikORh9WrCCmYMc5Fy30lWrvdoZXKsLzGiq7jm/zwQfitJToppup0pbJV4TKB4volkdtORqIXONYzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6y4PIMq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f4834fc49so106626e87.3
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756375982; x=1756980782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdX/N4KLUhkdInwTJSVw73qwe9sck2J+BFjqIgZituU=;
        b=p6y4PIMqSxdR8OmE6XGpL0FPgt+pvxXit3YKVrpwgvFV/Ep+AdMdtJFyvDTYA/+Ee2
         wjZM+hQtqmvk9WUQnh3jvFpJMMLRxvbqvefNwyHVs53LOBfTKaWjzD7yt9J5BO9wqgMH
         EMCe81sHbrdUnFBV7OrYPsSNCBZT6JfZWZj5i0aNF2fsSdNhWH3C1zugpSH4XRsRyL7e
         VbgXqTivD07YISEBLxTG0dFbSjKb0wFsR3E2PUAfuWYBY3uGK1w8YXlfX0BJnbmg/Mr7
         dbE6Mo/3HncZxb5PlRIP6u/fT96EcjYdqfpb6fjFiCTGTKZ0QV0g+tAQfX0+Ncz1H9Gs
         Fwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375982; x=1756980782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdX/N4KLUhkdInwTJSVw73qwe9sck2J+BFjqIgZituU=;
        b=NKIjFhMIgAzNG0Gr6h8vmQT3yErYG54KjQ+Vj1eMj1mqgHwxskzJVOR9SSblmGSs+u
         MMQcAqBoleiSvthv4sesuCHy+K5N8WHUb/q8jstsz7uip8gKR9wC1neM3wHHH9N+mcpj
         ixPTlQHGp5Jn7eHwDEi3LwFvbQJtAZNsKbm+I2+I3ZwfcHD9rzhgUWH8HXu90olkVvn2
         C+1x6cRKCYIQY4UnUndT0Vs7fKmsNvCda8vrOuZM3XQCpdjA/kz4Fi4lqGFQEekJp9Wx
         BDI59ak3UZG0UqBiEv65AO8IcnuURKC24U21KAhgF4CnZ56FUbGUtvm0Miq3PaAJ30cr
         hWsg==
X-Forwarded-Encrypted: i=1; AJvYcCV80Sh9Cenuaqf1nmsxwiCOBL5eyqBqh3yfMztzx60lMMTKmgYjO1hWfLIoEQMvuap19Dxpgp0JKn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxW2IN31xeJPkNwrBxXZiFq31E1YYsx/sWtIFuWGhgGOmB9y38
	41hf9oTP5+s+1atnXLEeiAS5ocsfbVYjb9s1Pvj8YsWtU9Cmkhv2TXSngj2dVqHM5Fs=
X-Gm-Gg: ASbGnctb6Z3tQzPFG9xNPg4YlElCAMaKUQ83t64hKyVxUQqQFW7+VyLrshEZft8rYqB
	5aL7ace+G6Vnr0lVT2Ks9F/31FBt1PLs4Wnq/L/A92U17bfFCITK+vqPZvMvD1yfvc9kp8v4fFt
	yVKgwd/6CxB3lFduyGlUdcNYCflb8UXj5Jlend7ZcDTSqOcMrIREoUvfIieIl6bmqtOKMhEITy6
	v58DniZwDP5tTi1OqUSMaGOKCrLqFf7DLiQHAw/r3zIloiZR3w7lyHyCf/w/j5x6bhaFYDlEAzK
	lImdF7dDq2UuXuJzh9NZDCSxaxp1MS4OhW2sfHtvFMRrvCyYj9TEZTVvgItY37svPbwvkqca4MW
	IovghA4s457Rk4luIVxnEeC++c56tpuofV3XxH4WgvwmJMWhPp9D1wpWLodKtkzI/jVx6
X-Google-Smtp-Source: AGHT+IGl6v236hNxm+75u9MOYwiKwehhXE74Vrhd0hXoFMFVftfHWVJ+Asu5Xu7WnVHT3u/LWnOAPQ==
X-Received: by 2002:a05:6512:3c8f:b0:55f:4953:ae8b with SMTP id 2adb3069b0e04-55f4953b1d7mr2005264e87.6.1756375982348;
        Thu, 28 Aug 2025 03:13:02 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55f35bffac0sm3211494e87.11.2025.08.28.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:13:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: bhelgaas@google.com
Cc: kees@kernel.org,
	ojeda@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	benjamin.copeland@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] drivers/pci: Fix FIELD_PREP compilation error with gcc-8
Date: Thu, 28 Aug 2025 12:12:37 +0200
Message-ID: <20250828101237.1359212-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
ffs()-family implementations") causes a compilation failure on ARM
footbridge_defconfig with gcc-8:

  FIELD_PREP: value too large for the field

The error occurs in pcie_set_readrq() at:
  v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);

With __attribute_const__, gcc-8 now performs wrong compile-time
validation in FIELD_PREP and cannot guarantee that ffs(rq) - 8 will
always produce values that fit in the 3-bit PCI_EXP_DEVCTL_READRQ field.

Avoid FIELD_PREP entirely by using direct bit manipulation. Replace
FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8) with the equivalent
manual bit operations: ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ.

This bypasses the compile-time validation while maintaining identical
runtime behavior and functionality.

Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/T/#u
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e698278229f2..9f9607bd9f51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5893,7 +5893,8 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
+	/* Ideally we would used FIELD_PREP() but this is a work around for gcc-8 */
+	v = ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ;
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
-- 
2.50.1


