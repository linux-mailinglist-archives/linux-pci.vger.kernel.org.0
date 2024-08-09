Return-Path: <linux-pci+bounces-11527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665D94CB80
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5924E2844DE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AF175D36;
	Fri,  9 Aug 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ/DwBjn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3016D315;
	Fri,  9 Aug 2024 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189002; cv=none; b=APN0+gTv1lx33C4W2pLhiz//7enbbYMpSEDHwCTL0AcDpaZlxPVA7jmgwRSUqxOUeS6ec3ePuTGMauBnO5WLeUQH/yND6sJODmb7qU9XmEHIOuFUCID+u3N6PuY8bbeI85bSoS956q4rD4LbtlmnXJzr3puqfTFXhGXp1SeYmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189002; c=relaxed/simple;
	bh=XZa+83SijQnBCpLMBFwNEPjA1kDA4UXyTv6Yv898LyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P42pu1s7ZT3+EU5Xh0PJN2o8nefFi3v6jkJxEsIMM/uwfit/ttrRgAnT5nqyZ/qJD2O2SHZr3f30f03XtNR5vfzEPw4eWLwTpjB+ssPPs1eVH3BvydVusOXhz02umqPtzGvs0rVj+1Tb/HO0aEtE6LCVV/A3t+1u1la6cCYQMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ/DwBjn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc611a0f8cso16290815ad.2;
        Fri, 09 Aug 2024 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723189000; x=1723793800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCcf6BLa+YFbQdbVYELqdFtAuzitYv4+8HazgULACT0=;
        b=WZ/DwBjnVr04DSUk0clN+Dha046rqw3GW8S+sQBo6CGZMoTVrbgqTtDlr/Yu3zem8B
         xqtQpfJyAFOa6GEXMYlq2oDjNCHZwcInBPqMM0iOHX1CyUIbGBI04FJ8Qu8Vq6K6RttF
         fUwIGnqKC5Y7YbBLqqMKchQEg09QNOT3FaKMmaE92Xku2hNpPCvBX0sduzL/FN3pX5Ki
         p7CXPlXXg+8YA56zW9XJZNno6Z8FlzmIQoR2CmCbf0qLMJpt0Y99BFQdw/T1Ac0yEncF
         lmoDn+5WstQH/KOdTJmnIMWpdeb1uFpnmAWeItVFVp49xfZ1j6bO8hO1UBzCJEWXT1gz
         K9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723189000; x=1723793800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCcf6BLa+YFbQdbVYELqdFtAuzitYv4+8HazgULACT0=;
        b=qJZxZNURDVlfUnn4MRZfb8U0M/VUp36kYadmqphAW7M63gJyXMZXv8QPmhZ2jijy1T
         VelNuOz0SM1Dicd5v/QP8qxoVlaAuycY4vYZra648sQsWO8Z2+1cOV336Z3jyeLuhf00
         wZCBA0CwKWix69XnQ1tINhqs2B+AojdNlCI9uKg208JFSeNm1j96zF2xKVsc0uzolypX
         mWHdd+5jbBfOoaqLE30Olzw0BaDcIuMFi2PMLmIODU6dyWxK6S0H0UBnzqFwWMCX86CF
         g3gmMWhuQRiYCB4ErincgerFdMOBOJ+mHmhtcehgH9Jq9k9d8/uHAOughsqnK714pbt8
         cl0g==
X-Forwarded-Encrypted: i=1; AJvYcCUkNn2qClOgUbqjEGGxdIgZnO3jd3AQ5f5unqk7wFCQCDm+pVUtJY9v1cgWFC9GTGVS2mjb6+OIkRU240go8ot9eabGoU46AmQ8RTV1asNkDdBQ5yapKkrMJlvkmu4JTZDXmzYnPz+w
X-Gm-Message-State: AOJu0Yxcd6cx4pvhCHkVjCH/pBICBe4wtFx0oZgzcklZzModrv8jTpsz
	qQOLJ5ZV4nGxu+0syFSurKpHxHRJBX0zIfrkcMgQtDERpzEzvC4K
X-Google-Smtp-Source: AGHT+IFqgjG/ZrWb/Pbr+iWfuP6MYtfTQEA9uAjaJ7m+O7kUCxqIuJ0GXMYR7yQXBdrAQ/yTcfLGTA==
X-Received: by 2002:a17:902:ce8f:b0:1fb:a38b:c5a0 with SMTP id d9443c01a7336-200ae597aa7mr6144245ad.31.1723189000278;
        Fri, 09 Aug 2024 00:36:40 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5b349sm136588855ad.108.2024.08.09.00.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:36:39 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Date: Fri,  9 Aug 2024 13:06:09 +0530
Message-ID: <20240809073610.2517-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip DWC PCIe driver currently waits for the combo PHY link
(PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established link training
during boot, it also waits for the link to be up, which could consume
several milliseconds during boot.

To optimize boot time, this commit allows asynchronous probing.
This change enables the PCIe link establishment to occur in the
background while other devices are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: update the commit message to describe the changs.
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1170e1107508..7a895b66e4e4 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -616,6 +616,7 @@ static struct platform_driver rockchip_pcie_driver = {
 		.name	= "rockchip-dw-pcie",
 		.of_match_table = rockchip_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rockchip_pcie_probe,
 };

base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
-- 
2.44.0


