Return-Path: <linux-pci+bounces-26521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02237A98698
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B55169787
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB31A83E2;
	Wed, 23 Apr 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ0gOEqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD71F1534;
	Wed, 23 Apr 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402211; cv=none; b=U9pgdnQzthZrd79xHRU/Q1EJgC5WSXxiJ0HJ9lXRGiD8g5DZyUUmw0m8E+1/vXyOt4d4q6hRAi2hY35+VlPSEha6sP8JR7l6eAw/BzKOd+kupQfyrMSFy5FlbrxNK4lfrkakbEAH3Xs72i0i3RZf9zf0odCt/Ik8F+dzE/84ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402211; c=relaxed/simple;
	bh=5yZBvNuVYmifPJSDr+HNB9Vckbn3EBGqIJPHXQ/LNEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Viq8jcZsXIHJtQdxFlfbwUkOeQuDZ5BcKM2bojB+zujOhEt2gYTsxG5v611CFNc6pd3A42IEgAglH0IDx51EnzkIin4TwDtMoFZkBmNPP1l1RgzaBpb2D7eOY/U13Bin7I8NLtvl/A5TYaycB5uCb1sKFXvaKVMiGdwSvu4ABG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ0gOEqh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ace333d5f7bso230640366b.3;
        Wed, 23 Apr 2025 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402208; x=1746007008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwA18LRT0uq0phnjE2h0pHsa2q7k3j4dQrZL4VXB764=;
        b=DZ0gOEqh2sv8fymphGg+oYyMPr6qXUKndIN01QZS0YJO0olIPPUWcQMiiKPzSFOZAu
         rdZP0TrX6qleq35VlD5LVXU1u/ubXxkueTBv72pmT+8xXlvvS1hoIjcVE9xtd3VTGbEe
         1Ohtp5remuDPW/TuPIeIoMGcJ+hp3slLnBzk1i1tolbjP51p0DPys0jY0tpnhzSM0x2X
         AcC1a2RQp3hmC3m9ybD1UB3kze7XExrHsc+JSvIerRbTA/JrvTrd1V1KcKzg3Um1hcv6
         TB4PHeMHQOQCZkztfD1+m6KbwEimUCQc1VBg9OtJvgRCw6bopy2yXIkeRud/BXkmVLSX
         ju6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402208; x=1746007008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwA18LRT0uq0phnjE2h0pHsa2q7k3j4dQrZL4VXB764=;
        b=TctyH2t2OMMrUvSR1ZBKO4NitDJRDLxx7h+/wPmRXE6ZAUNqKDTWaG6r/9hL7CTM3t
         098mqFc9qSYUvoMTxjOfs1RgAAaAN8BBO1VmzhpjUzXoaGPWT2j3i6a4YIVoh5HUx7P7
         vWhFP/dq0LNzmwdgAsprEAELsVKTkCeGFgaqvQx0QILGuxPHXHtFlIf9aRM2eTeBD80w
         IGx1Hjc9SI5UPnTtNL/aLOV+n0PfylwakGTCHA052CvQzRpYnYscZo8f5h/j4qdRAK/s
         89+AjwZUCBzAHn2EIbKwkR4pKhVfVfAZgh34u3GnY7inNhAIs/yobiDS1OLvybLSqeSz
         ArqA==
X-Forwarded-Encrypted: i=1; AJvYcCUWslcR4rm0VN4kprXvyc/RCr7p2oIM3RUuSufCVUtHzvlaf/9R/wsLM6FNq2RKB0TzvFjdleEGJBMMRUOa@vger.kernel.org, AJvYcCUag+WowCHr5wN8ORy6UgrMQPcXcjSX7G34oNZufMAA/5dGEKuGw4NucXJlP5/azoo1TPcE/X9sjJLl@vger.kernel.org, AJvYcCXaA2aH1f9bXtmSfeSm2kgqfV7TayvRztwfwttgmrQuRVbeCfEHXNcclUioFKyQ2OzjkaF4kHF3zis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHGBcsssw/3w0SCeFFPrmiKoNQ6SlfvOWvVJEQci15CrqnXDY
	y/96OwJzpIgIac8iLieNeoSh2dilNRLejFrYVGjiNkpKLqIqOjmT
X-Gm-Gg: ASbGncsBm+ochraNGbYqPjqdykfF7Krm/mg/1sisBkCoUzsS9MaCiO7R1Z5WLpZ1PyD
	acBjI6snzk8TzgRofa3RzQHSDf9PoMPKPcitO+9gqTXVvuEOsHEokkw2JoTrEjaApEHc9eTDyWn
	K4grsOC1apbDncP4QOQSmQGA9WJwDU3zF4jgLBlA6vkE+HDHMMB1kutIIrGndInSyxNZRb+hKdu
	56aTaLY60EOWura7uz3nRWlAvp20frvwVtWNcEnefFDguerGyvF2wRPjT9Kec6Gre2oZ3HtGtDq
	wER8DrQBgHDFrY5wfa2V6SjML9q8qCwANCD3/Qmt4DITOQk0XsQfLhTkXjLxrCRFI7E=
X-Google-Smtp-Source: AGHT+IEtOoJSaHh13UT19v8/zmlhQZa1pyS18v5YTBOq5/OCSUsJPtlqQbjbpBqmKCino8dWIpCXdA==
X-Received: by 2002:a17:907:9407:b0:ac7:391b:e688 with SMTP id a640c23a62f3a-acb74e6f381mr1506718066b.58.1745402207508;
        Wed, 23 Apr 2025 02:56:47 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc782sm773431066b.87.2025.04.23.02.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 02:56:46 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix path for NVMe PCI endpoint target driver
Date: Wed, 23 Apr 2025 11:56:43 +0200
Message-Id: <20250423095643.490495-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path for the driver points to an non-existant file.
Update path with the correct file: drivers/nvme/target/pci-epf.c

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 Documentation/PCI/endpoint/pci-nvme-function.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
index df57b8e7d066..a68015317f7f 100644
--- a/Documentation/PCI/endpoint/pci-nvme-function.rst
+++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
@@ -8,6 +8,6 @@ PCI NVMe Function
 
 The PCI NVMe endpoint function implements a PCI NVMe controller using the NVMe
 subsystem target core code. The driver for this function resides with the NVMe
-subsystem as drivers/nvme/target/nvmet-pciep.c.
+subsystem as drivers/nvme/target/pci-epf.c.
 
 See Documentation/nvme/nvme-pci-endpoint-target.rst for more details.
-- 
2.25.1


