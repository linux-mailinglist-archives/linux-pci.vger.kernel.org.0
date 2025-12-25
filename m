Return-Path: <linux-pci+bounces-43714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A36CDDA36
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 11:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993B3304B20E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB2318140;
	Thu, 25 Dec 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJvTB0Nw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1B3093D3
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657219; cv=none; b=JV9Du1v9ju+eJyb0EfL3DIVAChvGAWN0zNsCg5HmwAqAn9hyYgWAdY7oNKsejwX2q3t6kByiyHNTJWWXQjQq2td7rFD31CFXvYM3bj/+9sM1TIumaRqqnVXJcdxwMGwW3tEPFDjzre/nX1cg2BBnXGGQGxMPlZaD79jetwEa0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657219; c=relaxed/simple;
	bh=RUbXW9vxhpq3S+asWdyZH1trJX5AyYZUr98nW0A94X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTaIuCUOE27E/L3KbyIpFNUo+QdaqgXOPtAaD2RDnQu6gp7ORAU1WvezlyapntBs/zkxqDQoALy72uQlVTdu3kHMjgnumM2TMwNAlq1LotaLfojp0q+4ORh2/Os4JSXibp0yQjDzn0/fX2L9RWw/0QYH7hK5Mo1HUzKU94HiJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJvTB0Nw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29efd139227so87418825ad.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657217; x=1767262017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCxzUaHmQMEgNdIPADAEGtBFeTbBCSEQEw5xyBBxWtM=;
        b=PJvTB0NwgESgYzElD4RBEC2z9NW49yf6Lcmt7p+Ddqu4f3Qw09p2gVSkDng/VnGuTK
         sOi9nz0A4/MGvwxqfU3YLvrLMO39lhr3PUf1PrHwr+ZM1i4P4ZYSY0fRwYEtgXyf/PF7
         hr4rtY4+M8CX2cONjD9ds7RA2Hhne6O1lrcqlukruYnkjzfAbiuzsLA298bK/gDs7XGg
         vTQxcExNTbxt3OOYOaWPCfG4th6evxqHxHls+2vERHJFQkPJUDqtpp1zYXzFoy3KxCjZ
         3z4Mo4GP032BvpqDgFn0Gk26sHP4wlgQLdGKBNTVj+pjeOU+e9Czm+TgUnc7XY6tXRO6
         KYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657217; x=1767262017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCxzUaHmQMEgNdIPADAEGtBFeTbBCSEQEw5xyBBxWtM=;
        b=qibKgpvLyvMRbV+G2/Jkmo6KedrhE1rd8p/Xn875LHATZ3d+8hA+CokvOgaIJ8PdTg
         RGp18YH7eeQ7Oqe811o8kkqMTsJxr4emUH63x6fLvaPicIqmViLVlBJjTIPpKNEe0QYC
         P+TukgUrie9rwhkAYv3J07K22cF41aKWWOaE79IbxH526eo2JxM94hn+4SAbaT3hg4Tg
         0PegI2fJO3iCwJ+vaf4U71RimS/OHRKG8Ic9aqeDd8MzdQTnj4wldx9WsFiq3Y//+9Yg
         vyBZW0/p292iqAFLNoiB/G9TrnfUM1yVB62+zZ8PJV16o9hWHr7OSoIk+polZLoiuhRD
         es/g==
X-Gm-Message-State: AOJu0YwFHQuOcYOsjiYphXaOujrSMr5qKiPv75KPbipmv9SBBo140jlx
	giRzO8I5MgQ7CKdtrV47LRbBDZRvyBRKO4M7KaVpYuspNgybSeiAXE8V
X-Gm-Gg: AY/fxX6rRWlEyvxodJGSTrW7mHMu/g7bHiGBdfOO4p+IGbRJtcnhV/r+f8B/bPJdpLG
	xbL27CfoJktxG+1soJYzNXg0NnKvVCXtTMQjvpSqxl24wwJRIq8LQ3LyvQ/HiaFp77bPUw1S+pI
	4jbcKa9S9qGuuaN4SSdmgi+3unerySMU8yQlSeP/E9Xpi//d3alAXp4+lqgYDGAQsOFe3DnX8Y3
	vGDvE5JrJ0Ibyq8wqDvzY+SbxDwpenitzlvj24ZDFNbGCYLpOWXDZiMqBgw6Xnqo8zWu/MZ4p2N
	aZxtvfvNDl1z7zJZSYQMKVK2yFKnXqiv+BQryDj4yYOJoAkQX2DPY7y9cgQsVlGqasIyTCrE5o2
	E4reHMW43v3eWCw6WGOEGL3nI4M1Csuy97HTK3udUerh/VjTbpjj27kPgYITfEOrx/Q/Jec1wBt
	MOBY3lqBj5XQ==
X-Google-Smtp-Source: AGHT+IHxULa3Kgo/D1IPJDm0Fh1aND7FwuD3MXVKqvYlgcgpDQHDIdGBa2yeukfLEwbJNSRSUARBjA==
X-Received: by 2002:a05:7022:b903:b0:119:e569:f268 with SMTP id a92af1059eb24-121722ac40fmr15690018c88.17.1766657216512;
        Thu, 25 Dec 2025 02:06:56 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfc0esm76131090c88.2.2025.12.25.02.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:06:56 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
Date: Thu, 25 Dec 2025 18:05:29 +0800
Message-ID: <20251225100530.1301625-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225100530.1301625-1-inochiama@gmail.com>
References: <20251225100530.1301625-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2044 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Override the L0s and L1 Support advertised in Link Capabilities by the
SG2044 Root Ports ([1f1c:2044]), so we don't try to enable those states.

Fixes: 3309df45e6b5 ("riscv: dts: sophgo: sg2044: add PCIe device support for SG2044")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d775ff567d1b..855e74203ca9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2527,6 +2527,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOPHGO, 0x2042, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOPHGO, 0x2044, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
-- 
2.52.0


