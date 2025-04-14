Return-Path: <linux-pci+bounces-25763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E65A874FB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 02:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA87A1175
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1467464;
	Mon, 14 Apr 2025 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIQk1p80"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01614C9F;
	Mon, 14 Apr 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589728; cv=none; b=NajJb6ZamryW0ddFo0LvTbDqwBn8sd0PkGKfm8WXbEOo7rmoW6xkYxU/OaUgbsy0etCq+tykKQ3cm6PHoSHm7o8Nz5tacrywz+x6tvt+PbcKZ7oFeDqc1eHM5/vCiewyB4qmxitrZmXB0PGA/7/Ml5fZP0s/SCWTx841xod1YZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589728; c=relaxed/simple;
	bh=pGUdpc774oKS+pds0PTNhEoofSzIkEd9QqQqmNiCTKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dpie9WTDqS+TCxpJKQdBZM8KI+DcFpFagaf4ufsnmmtp5imTRUZOHtFBxKrHP7Ezw0Ua8NZJ7q6uEBNHo/L3m9CGKk5JMTtGR4a+OZr1awFGo6MhcbbC87XiiwHMAu/RfYhGw7OukOLB4DGPWgS4biFFrajFe4RxA+kKGBC82UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIQk1p80; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2279915e06eso37301165ad.1;
        Sun, 13 Apr 2025 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744589726; x=1745194526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DspOzwqAQ3U2U2O2TlCMYkKPc8tNxrgBZWn4/MMKtJw=;
        b=PIQk1p80vyjO5g62t4bU7nODKbzLVMBY2mXCXgzx0qjdU5ArPdcZs90mWQrFW+KsPd
         9sQR0Lzkszzuk9OusXproRJatGCKeH6LXQ6IUlGC5P518mlxw+PmzIXnvXqCFgLARNjZ
         5P3FprRsFkEGPP5ryISeoYnX8TVIxdsDIBLShyPhUBJYBdJ1P7Pfjbs+nI0AUnr63P6G
         qP/X8FWVyfdyDQ7wkIeoTHcYD3ZS2O1g3x9uLkWAPl6hdIt0Lnuk+UZgijeWhDL3cJdO
         WiTSVRfv33b9NG7WQdsT6H/3/fP1E6hRa+2763GeVwpjNeVccsCFTW0o35CspDmuWwG/
         nfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744589726; x=1745194526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DspOzwqAQ3U2U2O2TlCMYkKPc8tNxrgBZWn4/MMKtJw=;
        b=c7ThpiYpdOa6itnN/f+AMGHku2L9eO0LfMhxOP7F9rpJJ2YRRIAKHFkyhT+Kv7PbSR
         qTIZZM8KHAba6hCiQNvNsrdG5DI0ySr7gnuzcPn7WTWAHbRMtIJ1wLI5zJSeqmX5thlm
         sPvtcGgiHyKCJfvq3uzJn187TRVa8/oO+goi/f5JhZ/cOwD+Xh+YSa49yrF53zUQv8UK
         hgLdGYsWR9cySIPPH5kiVU3w3+L4NC+xTVHNAnR+BMY81MXfd6T8aDaq0mnuvbiroCU8
         1VCz3z12pf0kbdIVVUxfb7zd+iRxrfRVKPMCr+4/WHvLfgXXDEPxo0ZzFwJZXerbR/sL
         Sp4w==
X-Forwarded-Encrypted: i=1; AJvYcCW+HfxVTDuUzJtGpNrwe9tDiLthfBldsqjmgGZNZ/ZRT5c1nYoNmWjCXfHOQ9J66JmGVoJQOd4LHrP3Wuk=@vger.kernel.org, AJvYcCXOUesZkqoYYFu7UGa/rCN99VP2iLk+QNU0QZqf4b71kCkiOlMcdBvF9o/n3HIA+CaZqCQvRexE0JnB@vger.kernel.org
X-Gm-Message-State: AOJu0YyBinWeudmsjbrqJjvb681kw/bZd5jQdp9PKVsXrOkwclKKlUA7
	PeqKlggfv4aJ95J2AkCg+dmEglRhpcZVyMbmoRxUemqMrEMB4oRd
X-Gm-Gg: ASbGncsunkMX0INYOnluIhgAACbvYeCavo2TjORrOgcadFoQaHdymv6bj4x/FqZ9VGp
	1E/o7N6bLBpAILfbmWYoJGeMPdEnn7Wc+oESsrbSWZrAYOnu/ZDqcRzGs0RTZJjJo/qsEif2SzO
	5OoRr3ExEIrZNCIrvHri84YofzcOR8XZjBY8N0HoO3e+ATjdMZ4sPVAeCbQj8+1jrEXnLz28rzO
	vw6ajFzMqBzVkdeFgnJmL1alWNFkhyYPZpfcKDNBXfdhMeUyUSWqs8pqzBE5R7glxgwv3u++zW6
	iHTnEdyJQc2KF0oDncoxo4FpylpTBnfN1pReA/Yda3kfOQc=
X-Google-Smtp-Source: AGHT+IHIj68kD5hR3cj5OEaOvggtPuwDL2ui3+LMQSSH0QGnqHSd+uewOup79dXxOeuSx0d6pSZqkA==
X-Received: by 2002:a17:902:fc4b:b0:21f:85d0:828 with SMTP id d9443c01a7336-22bea4f183bmr177955005ad.41.1744589725886;
        Sun, 13 Apr 2025 17:15:25 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8a8b9sm87987585ad.57.2025.04.13.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 17:15:24 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alistair.francis@wdc.com,
	wilfred.mallawa@wdc.com,
	dlemoal@kernel.org,
	cassel@kernel.org
Subject: [PATCH v2] PCI: fix the printed delay amount in info print
Date: Mon, 14 Apr 2025 10:15:06 +1000
Message-ID: <20250414001505.21243-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Print the delay amount that pcie_wait_for_link_delay() is invoked with
instead of the hardcoded 1000ms value in the debug info print.

Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links")
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..8139b70cafa9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		delay);
 	if (!pcie_wait_for_link_delay(dev, true, delay)) {
 		/* Did not train, no need to wait any further */
-		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
 		return -ENOTTY;
 	}
 
-- 
2.49.0


