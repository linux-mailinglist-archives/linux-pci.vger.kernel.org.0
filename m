Return-Path: <linux-pci+bounces-34373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E10B2DA67
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8335C726A7D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589802E2DF7;
	Wed, 20 Aug 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="Pt60TgNB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F02E2DF2
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687503; cv=none; b=NbXyFBG2D8bSSTBkYml88rKLllkcydG26cG8I/CmLP9ZQsuQf1RCIQU5J75/gDnQ+PAIct6KalD+eXJcshQtlYGO2HYtwSebcbd+cVlpz7k5BvNETUSBHhouiGvqDuoYkkpt3dfkEsrVG8aF6fr/aR7SNZg6FRzeZoTjJDuWiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687503; c=relaxed/simple;
	bh=mtlpc6Oc+bVnprxHO+2QT0a74MUtF4l1ORTauJCNdSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dj04pwlp3BDxTkAvHkvhUCuSXqR4nGEd3p+0Bv8ndw/DTHde8GRQHJlqc/lf+Kt6Y/puch/DYVeLc70Ao/5KkH1WzIupFNuVMpczu4Z2yGx0ax/w+oC39TFpREdy1h3ZGAp4QMId2fZjXb4wz+QDRcVvBk/RcT53JwE3U0aAxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=Pt60TgNB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24458272c00so63687935ad.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755687501; x=1756292301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIY9o+m++demIvDBObElDKuuFPYxQeni8PVpK/3jLZU=;
        b=Pt60TgNBs4Zb/fJqrI3XuwXKPY5f83eedsdPLNt0qfTth0owgN0EmZNIRK34UO9rD0
         KEusiXfAPrEN1IT9Bo5iDnEcuigPb49ndhBvuIzvabnJiEz2vUHfyVcSx5s+JbrlBomw
         r8ol7QJokS0bBzd0/i0WOkIEu8H3u6ZiBfC8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755687501; x=1756292301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIY9o+m++demIvDBObElDKuuFPYxQeni8PVpK/3jLZU=;
        b=N2Iul9VBB1ahkcfoE8xx4VNLGyCAa7MJ0BssoZbNqSTAfr2NbS/9SLCsi/w9w68++D
         6k0V1blzxt+65p5hO0iCH7lIVbuPrViz4oBHuiOm/kXvfR4X5+CL8iyvOLE+hxUYE59Q
         UcbxA3BxoWX0rAYk1lgXlGURrByom0P+BeSB39hLZu4ZfE4wuc6gEYDZCIG19Zb7PW5S
         Ji7nMY9p2Qo2lfLr5Zbz9smMXk6xOfDovZ+Df4qUYkXMm1LZZvdLU+Ea6+79ZLgdgxrm
         y5KAb3wYdqm2EOXX/oIwqD8wSoat7d3R91Ow6OwiW1KDrL8t89Mn2BKWQX4m0o15saRB
         igfw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEsP+B+ovL0SjGclih8/MxNwxWBB9X1YpG0iyct9NBC9WC5d94/+wQwPtLHUobcVTHeeIHhE5M9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNKj3xez6a642zRrzxn88vbzphfsL8raECG+X4eHCH67ltKCY
	F7TcGNQMOMG/KdwG1ZrqOqnmp+qapem+R2oreujCpGeHdpODPX9NVN9iQEa8yz2IbVs=
X-Gm-Gg: ASbGncu7wBB/hZVxs8fL1aYhJ80J4lspQazWxLVU6mT/UORrGexnuVL+VZaiaOSjIqa
	YNi9mHoPqt5LrRLqb/4mv0MUHENumetEgU5Zy8uiCaJ8bjyOqOxhD5pGzXh3Tg+nTcY6X47gEdb
	dDtZyIv6M1mKnnGTqZ2rkXmxuq2xWu7YiPP7x6OjxBIffEtegtdPSDoNIYLzIwcYuttmTcS25k2
	WbqiSFUEk9oIeS3WwkLLEd4iXcPSccamAe3nnMFnHOLV57zGpL6RqpkX9eIbHMpRB/4SPw1C/Mb
	Qx0+GxmpXcb+Qq200XeBivuSqMe001K+e+/oefaoN7kyXMggujIoCH0q64tKizfJi8jWb0Qnd37
	Gzpy0A2hV3gVyyiW1LiEZXNM7POP3VTsuiCkxvNKGHSa7ZNK5nk2nvOz1uX4Z8OSWu2hi
X-Google-Smtp-Source: AGHT+IEQsLcQ+eFDszAlGFwsAowRxUaCxUv86qiKlXCfj7VzA6LxtPPB0hvfbvTQ1V8Am1CNcEPsjg==
X-Received: by 2002:a17:903:1b07:b0:240:38f8:ed05 with SMTP id d9443c01a7336-245ef226760mr31487095ad.36.1755687500953;
        Wed, 20 Aug 2025 03:58:20 -0700 (PDT)
Received: from furiosa-sungho.sungho.kim.office.furiosa.vpn ([221.149.27.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f6a84sm23212435ad.118.2025.08.20.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:58:19 -0700 (PDT)
From: Sungho Kim <sungho.kim@furiosa.ai>
To: bhelgaas@google.com
Cc: logang@deltatee.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sungho Kim <sungho.kim@furiosa.ai>
Subject: [PATCH] PCI: p2pdma: Fix incorrect pointer usage in devm_kfree() call
Date: Wed, 20 Aug 2025 19:57:14 +0900
Message-ID: <20250820105714.2939896-1-sungho.kim@furiosa.ai>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling path in the P2P DMA resource setup function contains
a bug in its `pgmap_free` label.

Memory is allocated for the `p2p_pgmap` struct, and the pointer is stored
in the `p2p_pgmap` variable. However, the error path attempts to call
devm_kfree() using the `pgmap` variable, which is a pointer to a member
field within the `p2p_pgmap` struct, not the base pointer of the allocation.

This patch corrects the bug by passing the correct base pointer,
`p2p_pgmap`, to the devm_kfree() function.

Signed-off-by: Sungho Kim <sungho.kim@furiosa.ai>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index da5657a02..1cb5e423e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -360,7 +360,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 pages_free:
 	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:
-	devm_kfree(&pdev->dev, pgmap);
+	devm_kfree(&pdev->dev, p2p_pgmap);
 	return error;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
-- 
2.48.1


