Return-Path: <linux-pci+bounces-20001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2756A140C7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6966A3AB966
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787122F387;
	Thu, 16 Jan 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgx8FnVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240E22C9F6;
	Thu, 16 Jan 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048026; cv=none; b=E3e8xo3eWVuJRj3lKZQb8G4GHTD2ov/eRkIxBJjHoZ53H6JU+U8Cf2/1SkDo9jH+Ca6Q92Fk3NQp5tnBAbY6UDiqJiVJqa5WX05wEFaoN8V0NTu5XQPnRZjnqGsu0fM0YnrU3iXDwMfQujhSejUAqsYuOBZ/bPrWaoQ0uep3r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048026; c=relaxed/simple;
	bh=RIBw3okMjZ2OZXKTW5wOtVvyIBb6zyHQ4G0PDnyqNI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WcVkroVdjyepC6zW3mCfEjh17d/JORi5m6arKkpCudn6G0N9BlOwF2O1dVJyJZLXPMcBcPWGkCjUadbxf6eRThYgK8H7J/ivGTkcUu5erP13AZkMQsUjBwpg3HARD9jpRUhmmrZQ40PYYAbtQiNkeZd8OmoB4booQ/YMvivQ3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgx8FnVS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d161947so686782f8f.3;
        Thu, 16 Jan 2025 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737048023; x=1737652823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQTtZHORNcDqQcdHQDi2gw/Jqi6ul7TH0rswJJiARjE=;
        b=fgx8FnVSVOcBkotGx4nX8u2MDgUGmegvYNEM4pp0m3+4n5g5yKvkuyOH09pM2d0xpO
         stVDMHJzXjB6d5VkFlDPXga9JVi6ppvdOC601UqhGqM0JULxKGw5uHi7LmluFuXNPOrc
         A3G79cmJViVXPWfCxfhYtroa3qMwWN201wWny7TUIrqFVoQGick0aPE26JpQsZftVz9x
         fOjPYA208+pxKazI0G5D3Rpq1ZuzxytxGSObP6v1aRq8r1eJ2OW6+Q/+/pFlBvqt5Y/m
         SzywwPDP24DHpzMyHS7T9HVhH/ceDAXRzb17RWja9ijzlSyYiqjTzpA+mTJqaEKVPB5O
         ExeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737048023; x=1737652823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQTtZHORNcDqQcdHQDi2gw/Jqi6ul7TH0rswJJiARjE=;
        b=kxl4m8+0oPqbopXoZzNuqgk9U/XVw0t1Xz3p9As98LOqg1WQhccycU2jy4yUReiTtI
         4iVZoaQxLOxet6yoLJpCKhvLW9w9uMB5OXLnfJ7IkzXHtu8W457ZjRQIlyLzGGACAab3
         DNQxF4yyMcwhoQRs2pW0yDuGBl9TWYewYeAcs9uxyyXMD/s3G+FkInpDPnb7ru7p/k4r
         BDQQMDZElHOISUbkHYUBIKIrDGEcdhqZfBsML8NmdLB3HzivJoxfC6lmftkK1Gt9Ek5A
         hfM7zlQseoR5Bidqo42Vv8BIrTfA9oXzBhpozsHMjwu5E2J6XpKCqTdo+cz1X07dno0b
         3YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYCg1y6fqQCvXNmkuJOF35IjLPi51qHc9LfxgRzD9A6eE1z2wE3oWaoGaaXbFnVVFd08Mze6NGUnXk@vger.kernel.org, AJvYcCWNiLCG8muNaszoTVc9dAw6/W/6XC2l7RnG7TTBJ0bJqIf4KklByRdbMec2cyd7+prDvABr1LiZKrU6xGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0eXNTv+mALkzP6xJvfmlgUOWomEhs+PDnxrBo2IhjE0pmxGr
	2ql3O9PXstpL/XTccmwfI1jyaI5Qe/tXIWDdVlDpIr0bvKWw6GH9
X-Gm-Gg: ASbGncva1vqsDrgFyyX/Guj1mnjHQV6em8Cz+5HSlH0IO5Cs8VuVy/ieqCVVb4Vpf6c
	aVSUow445TPgNrxFVPFDaGmIjbPxPxICCkVnEdnFQ6xjc8JcreLnXnqY8PCdY8LkI2g5o02rg/8
	Uv5LlmJGu4b2L7YGdUg1V0uLpy/16GAr45+DuB3OWRThhRv6HLeSyx7tYQ9Cl46PzMZvlW/2IoO
	7qNburwiX0qmGyLoqh8+n5ayW9ikHnsodaOzsgqcf9vAJMfOwMizWJsVQ==
X-Google-Smtp-Source: AGHT+IGl5iPKG/eHH9fRqhK6YgzwXRIXwynjsToCIBC+NL+X1QFWodpH8A/0ZqaK+jF0oxdGRcSaeQ==
X-Received: by 2002:a05:6000:712:b0:385:e8dd:b143 with SMTP id ffacd0b85a97d-38a87306a79mr27244124f8f.19.1737048023207;
        Thu, 16 Jan 2025 09:20:23 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215bf2sm387384f8f.18.2025.01.16.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:20:22 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: Fix ternary operator that never returns 0
Date: Thu, 16 Jan 2025 17:20:19 +0000
Message-ID: <20250116172019.88116-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The left hand size of the ? operator is always true because of the addition
of PCIE_STD_NUM_TLP_HEADERLOG and so dev->eetlp_prefix_max is always being
returned and the 0 is never returned (dead code). Fix this by adding the
required parentheses around the ternary operator.

Fixes: 00048c2d5f11 ("PCI: Add TLP Prefix reading to pcie_read_tlp_log()")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/pcie/tlp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 9b9e348fb1a0..0860b5da837f 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -22,8 +22,8 @@
 unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
 {
 	return PCIE_STD_NUM_TLP_HEADERLOG +
-	       (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
-	       dev->eetlp_prefix_max : 0;
+	       ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
+		dev->eetlp_prefix_max : 0);
 }
 
 #ifdef CONFIG_PCIE_DPC
-- 
2.47.1


