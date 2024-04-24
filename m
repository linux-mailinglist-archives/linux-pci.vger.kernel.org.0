Return-Path: <linux-pci+bounces-6619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DC8B07EE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74E51C22008
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909715991C;
	Wed, 24 Apr 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="qOfV8VGR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC81598FA
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956444; cv=none; b=elvPVoDmYS39Od+RW4AYknZyaPtX/gm4IfPDceVioKwOySBSwf9ufGg2Nj33z0xqel0HE+o28KpnWy44T08mHd8r7Hul6YVPb+Vf80lvcclq1ZjHoJeh3qDhAEMKy4tvhLjZs51OZZQczfNNYHD3SARFaPVoHyL8bn+0ta55FZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956444; c=relaxed/simple;
	bh=xrj+BsF3R/sU6CJ4lWDL94edEEUWp9h51Ook+sFDQOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWNaqLQEVoP89Mc0RqtDOI5VBjbbnLs9fmR8/tJP/Wzh6J4lXVH8kSv2E+1otId1Y3r17Lhy+WVkmjyFlV0WYcBP4g2vYIPSn0uqo3mii/ztmATTlnblOHW5gwGQQ08w4U6r/ysNjSOc3YoLCqLDXj9uq8nN/r19/5q2R+C9B3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=qOfV8VGR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a68a2b3747so4439788a91.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956442; x=1714561242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7v2jzS11FgSVo8HqrZdhIYDLTe97Dot+RPP6pZ20bU=;
        b=qOfV8VGRhnsSRuLqymRxRvSRF9JBRKKai83ZOWi6yBJkpRX9xxKwThL5T40m2+7QS7
         WgSAONpXZYElx8BZaUvYzZgd3A+tPI/BmVbrLSdLrkJf6Mpdh5AJ/Es/glEOK7UH+hWg
         1tD3lNpWJnYZEaI7g7d9xNo4DIudjc9Z60egvxsbmoM9cL5Cn3y29SUKGALzfpsK/G3u
         6aFoS4DjiEYBTht2KUU39JWolqJ3i+YijtfjOLYm0qhNEMCKV9PkboNlZTNq9EhKxvQF
         W5CgWJbitody8xXKT9KEZKNZmGMB/88CEhNHtOlgb6U35/aJNPWEyPXDjzfvTv3zSdTy
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956442; x=1714561242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7v2jzS11FgSVo8HqrZdhIYDLTe97Dot+RPP6pZ20bU=;
        b=f6h8J8hxJvxpVUuZs6llI1JWWZnONkwvUgCC1RwH5jJM3Wksgj832vA+mCHEDuh1H3
         OyoGwGE99VeIpYCtLj9llymL7Z2ICmme9JEWzmPDJXspoh6qpzbaX/5yURR85ZKDBJpl
         L3gQA0JSAkWkTHOay4vM85s2JZ69fF203Ei/nqZ20goHLjln3AS4wZh4fUsGLCbkRD5M
         T3v2FYweXPX5ECzx4F4AWn5CknOlOA5JmEuwLKdiMVpWomeIBoqzWs9RVSETNUXlkpKU
         gX1vtY3mDqojOIOdNBBwKfeBnZzXUMlbV1Q9kkJ07Qs/WG246cB/sjbO3e0YNQ9ET86j
         SOmw==
X-Forwarded-Encrypted: i=1; AJvYcCXRPF/h4dPUoMh6hEqWXxpW+LgoXwQAdH09qTDwn881hnFJrKyBA/Y5QEBurf+ox0EAizOADzyxkao/icWYCbVIboc2Pya9VZIq
X-Gm-Message-State: AOJu0YxOrGF45zbjxhT1iujboS0bP4ls/GyqcxO/KPaxVVxYYHdcE9K8
	Zwywu/vMH80Ek02Kp3+d5omIrXfwcIQDyD3JAxnJZo9Eu6uXUM/e65m5N+39xaelJABxu9LLalS
	6
X-Google-Smtp-Source: AGHT+IF3QOpQA86HvZTp/W3Psv4CsVXJik+tr2sCT7EyCcIzJbipu2+EoOeiHR34l4PN7lpni/UlSA==
X-Received: by 2002:a17:90b:1e0a:b0:2ae:e1e0:3d8f with SMTP id pg10-20020a17090b1e0a00b002aee1e03d8fmr1746429pjb.2.1713956441679;
        Wed, 24 Apr 2024 04:00:41 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 65-20020a17090a09c700b002a5d20778ebsm13786899pjo.32.2024.04.24.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:00:41 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 2/4] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Wed, 24 Apr 2024 18:59:47 +0800
Message-ID: <20240424105946.21735-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2428d278e015..91a8b35b1ae2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1446,6 +1446,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1462,6 +1465,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.44.0


