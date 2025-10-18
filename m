Return-Path: <linux-pci+bounces-38556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A47BEC8ED
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225E419A4304
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099C277023;
	Sat, 18 Oct 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1gSFXXM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669111F5437
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770948; cv=none; b=AhMsi5s4SjHE3/OmcV68iqRkxJZfFB2WJt3vTW0/ZHZdYvOHimc226/D+D8NNv/OyohTRJY4fMMlDKDDHfPpvRmMrvq3sXLCPv6VvvrYBByHnINZK/I+AVNzYsDS9Rod7AVM57ZyEgHQFP2Tsv6ZzpMige2iXWgczUf+3AmlF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770948; c=relaxed/simple;
	bh=adsfjwfge00OgO5pYEgu3ctiyYWEhEAosl3dDNxgFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxeyXu5nYQnWVnNfIY6W1XCJfpUuxxVTe5163aMLyJkijOyIdt0aktL4OQcJ/ywS5qugOzNlV3/DFNY1wK3oXXmzWPJZpMYLLh52rwiWDeasiKl3JdbIQQVB9JT7pDVhr+wLNEGthkmhzG09y3hi+AMdm+g6PTnfann9dy/gC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1gSFXXM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339d53f4960so2730523a91.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760770947; x=1761375747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LZqO2zxUNbyHA1CZzbuw1ZMVz75gsE69oTnbFGskfI=;
        b=m1gSFXXMa2ZO+qmbPYGSN+XNKoWO7WR8S6b16NbWrMrXy8hjb+Aw9uI02Z/y5EhZfd
         HU14q4ElySq/N2YkpZgvKBQPO1tAcXHNgocv84BJO6nN5Nlh22fIoHielhiHmOXQCCOY
         y5RwX/L9C7kMp8+kJY+etxvbcEQ9re4zKs4Hgyx7l1HtT6gvxewy1TsZluwzE0Nl+8SJ
         vBsRNzYDkQ+ZsmdP8d6k7v0G0ctA4Gt4NxrpHvjIz8xuMI70XWceQHjy1Kk+vcUrn3cS
         zQOEcrk8k+pA+zEhi8zgXKO9DraBgrrwVAmZv0HRIFHDnRf08/4BtNbtFhI2cWWc36wo
         oFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760770947; x=1761375747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LZqO2zxUNbyHA1CZzbuw1ZMVz75gsE69oTnbFGskfI=;
        b=gF9hsVz3sA9MVAUvdanukF7tSLt5bDmnUZqKzI0QcPMFICDNIgMrxHyUaLCTfOrMEu
         sNCINhNLtd0b+AdZk5Lp4fgTgqxq6ps7JCgZaJbfUNkywaBTAcAQINEkfebz+6ir6Wgt
         qzWZ+5L+XdMyTTU0YrvewppWAtRpTPcyCQs+bKO/jXXnd+kOKZVnsdRbNob6uFFratTc
         uVHwMzcT/7jbd2YnYaeXQE+VWmHGxAymlOIgpJntFPaqVvs9T1D6MfxDPy2rLM7QCEbv
         QbxDS/UZZegkVyEvkHalAe/actywfucSAFuKVbaTranN+7hgjpqg9Sp2sR5QcgrSsWqZ
         e27A==
X-Forwarded-Encrypted: i=1; AJvYcCVSnwSL8p5b3TZiLWTpK7UFnHNxsy51PKYC2D1cIZQhYFdRSBlYXO010EVlqWw2Jy9hm09Ktyq+lFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmSyhxVZJC+AVvwUFtMMH+MYdItmsCEugFLXo8rPgUhlpBy3s
	G6sNJsS+oXO4r7OhINGrddJIoV2tdxDZkgciaXwVsm6/BGNf/twQFp8h
X-Gm-Gg: ASbGnctdBP9HeUuB54oCcwf61jDUNTlETeFOB5STmmYIZwuUva90e4gflBFc0ScuYs0
	x3rWK0qFZ5+XIjP79Y644ghslFueVC0Qt0M2L4ZzS+YEp+UQWzH5T3KKnlWoaEGvERnr2mDxMDD
	+aMe2sgx6lilnccAXLCk7JipS9+r7GsFugxZKa6Bo7nit55cz1BJ93di5/lY3yzmIKvN5yt9XJY
	EGFSPXCPxfNXUCE5Nk4OeNVOaWNBBo+r9SXsf2j5NmV694ch8Tq8SyoFnrfJff98Zk8yEc2FUcC
	ohccn3aNy0BsgQIktXBSffoB6gVi9G4WBzDIbg/JMPXkXVET+lFXbM4qKJVaauRTJHCx9YuBfUO
	0ze5PH+wcDhmpWQ0ACHPytlX6fnLWKRvLj5OE4E8LuAJy+FeRRsfbc2y3owldY0OcVk/gZ073iQ
	==
X-Google-Smtp-Source: AGHT+IFwixJTBiwvERMXNptxWD/m5Ky/B2d3/2ezqQWItjp9Qrm8XCx+MEnhwBI6yvzKsYHMdLBI3Q==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr7248569a91.32.1760770946587;
        Sat, 18 Oct 2025 00:02:26 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc12f82sm2186633a91.12.2025.10.18.00.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 00:02:25 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI POWER CONTROL),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI/pwrctrl: Propagate dev_err_probe return value
Date: Sat, 18 Oct 2025 12:32:18 +0530
Message-ID: <20251018070221.7872-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within pci_pwrctrl_slot_probe()
function. This ensures the original error code are propagation for
debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/pwrctrl/slot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d89..36a6282fd222d 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -41,14 +41,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
 	}
 
 	slot->num_supplies = ret;
 	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
+		ret = dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
 		regulator_bulk_free(slot->num_supplies, slot->supplies);
 		return ret;
 	}

base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
-- 
2.50.1


