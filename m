Return-Path: <linux-pci+bounces-26211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF4A9358C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A4C18908F0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B087209696;
	Fri, 18 Apr 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHCsEGUc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36520299D
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969770; cv=none; b=T/f2qojgsKpIPjEawql+K3yRW5OnEhFx2yw52XscfXc+U4RFkH3S7c0C+k/b8XptyDyyyWBShD0Cu12J/G2INpMaYXuC4+qgZnfYTRepUJVr87MJuX1E3HHZJogzcFpMWvqrDjigQEUmiaCSSfoRAclE7e0DTQVAVDAu9POOcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969770; c=relaxed/simple;
	bh=6Pq3Dbsaw91zeezOZl7rj7E4CkNxDlFOD8bMl2buu2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oF0U3hBdBP33rFWIDxu7XPtIfDerXj3X7uOEfYtmYk3T1Xs0UrvmqXaKkl53l8ZaWBRjZzK+PQraSpJt6pOJmu/qEpCRMvINHC59dWCufMg8u5+8V5/+i2FZiWIABZzPsp4QRP5OpfMXufFOKniii7FlBUqd/4Txy2iCStuZ3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHCsEGUc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so2561916b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744969768; x=1745574568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94mjTCd5D19GYEOOOc42WJyjuO/cBvrP1r4UDcaiP4M=;
        b=aHCsEGUc69XJMZVU6uYS4/HHXA4Lucy1s9aQwdMP1uSDsKlULA1IMnsg21Kvxr4UHM
         xJZ+KGOZugeFXPUDrgx2LqRvz8sq5kniO9nfLy2gH7R8QyWt+uIMU6zaVPACkDZlHMNM
         RNaN7arciUjpjbY+XB0iQP0oggFLlnvF/hNw2TWfOtxkX0E2mlRi5DGzPBpPb00fJabv
         fpv92W4dLiR2tY7HwMbNg8Gzg12x6xuQzSNhG4pJLfiFrkHrmAcyiW3G7S0Oqj4yCQtk
         fvAMBjAgmvlbawBSUHCtRQvUTajE2xkOwb5MxvsQ2UT9vVJur0UbeNOzqDG7ELS/MFYi
         ayfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744969768; x=1745574568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94mjTCd5D19GYEOOOc42WJyjuO/cBvrP1r4UDcaiP4M=;
        b=RA/FFown6GPh+4P2gndeZ1V1/Hi0ruPm/dXXhDmzJ8O5AMw3c/DY8c0I6BoNGnlJyr
         4N8ihCNrzLCs60EVx5befzHUGlVGu825KjaR5F3BkGbuKFqvfwKwsUtqvnUqHlnbKAmW
         QLZVzsEu0qog7T+mBx+rZjGHO73rUJaOTLHAPCmMB9dQ7CTN5qOJcAaUNNSrgzLtwyWA
         CEt+Dt4JbDf+qrI5T0u0TGoh3MuSJiQaz62HCSTGcGV/iOV2DvopQC6CCPE3qI+2vaaH
         84G6Ux+WOlaaJoqixddSmhEapiZJ/i0V06R9WnHusg08+eD51beLJFq53OeS1NTbr+w/
         J39w==
X-Gm-Message-State: AOJu0YzNlk9rvtmu7Oox8vFqO5/FZGMOtQ/TNhYAwpq5s6V6pFIcnGtQ
	RqbvjYKqB9vy2l0xdkeeqD482h0YwGZHgacvZz7z8bpic/lo4zr06IayRYbOBQ==
X-Gm-Gg: ASbGncvEaikQ+1JgQtJHIIQhCzdKSwntRrDAOZU8s1pc6BRtKZoi93KiXt8rxQTIve3
	wqrsfC0gPQEGYIsHFsI2RLKxv4mrYw0NBFGuxMjgCMiMBGIh67h4lNoD0cvSiaA/fbLSmdViY1T
	XJ/rNy+rvNxFaP/EJbKBgidSc3Nb4UqVzmc5Iu6nXOipQBgKEpkMb/xlRfDh8/IL+l6GSYCEuMA
	71sDOiS1ldij/Dp1bJ4TmPS9uen2FdYH8o+BC9yK8aUh0xiNeeSNgjfJMsdT9dd8DGLVYOZB6oa
	HxksP2fh0oMOs8SYjNxvOLsV4eSgrKMd5Yclu8x1C4E5hwYWuGO0
X-Google-Smtp-Source: AGHT+IEco0sKoFDRmf6mUfY5e0OyAEg6+5tFe/Gl6VeKc86avVTKr4g6pIZxHkWblne5PixuG6TsNA==
X-Received: by 2002:a05:6a20:9c9a:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-203cc60880bmr2607193637.10.1744969767905;
        Fri, 18 Apr 2025 02:49:27 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db157c783sm1079830a12.77.2025.04.18.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:49:27 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com,
	kw@linux.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Move Manivannan Sadhasivam as PCI Native host bridge and endpoint maintainer
Date: Fri, 18 Apr 2025 15:19:02 +0530
Message-ID: <20250418094905.9983-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm currently maintaining the PCI endpoint subsystem and reviewing the
native host bridge and endpoint drivers. However, this affects my endpoint
maintainership role since I cannot merge endpoint patches that depend on
the controller drivers (which is more common). Moreover, the controller
driver patches would also benefit from a helping hand in maintaining them.

So I'd like to step up to maintain the native host bridge and endpoint
drivers together with the endpoint subsystem.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce2b64f4568d..ed035c9b3a61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18631,7 +18631,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Krzysztof Wilczyński <kw@linux.com>
-R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.43.0


