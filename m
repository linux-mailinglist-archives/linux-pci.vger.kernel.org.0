Return-Path: <linux-pci+bounces-3197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069084C97E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824301C257D0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A4179AF;
	Wed,  7 Feb 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="qENNfVFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5B1B7E4
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304727; cv=none; b=tSTpqnUy2Av9gQcBWNGoI4lKl14iulsbGe6jbQ9/L0CF8lQr6b0Rerz0MFGczzxRLnFWjxKcup+tFeJI856OOZ1IDRrC0PXcZuS4CcV0dpG01H+A3N6LUDBmGV8OF+k/AjXG6+bt0hg5/R636UsoyrBOJwQNfXOq9z68c9LajIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304727; c=relaxed/simple;
	bh=s3WTcI1IzbnotT+6dXJtqKdBOVBRXYxNAwhJyvsJF28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvL7mamvB/IJWgjUX/KbAGPtXc3nqOR74n4xHWamiWGb62a4Igoh5edi7+S+CYH9CFWE5hFwDV9xM+fR/EqmzD/cl05nHz8Ad8RawCAXJns2BDUU6RN/1aGIcnWJFhndfNZNFoO2KV0swmXFJzLHITjVu61Sj3gASzpOmCRSElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=qENNfVFe; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-219108b8e9cso339538fac.2
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707304725; x=1707909525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIqTMBlwECCoaCjtSPu7GBMR63K3xYDhekgHdgyJ3Uw=;
        b=qENNfVFesUHYbzwpT3BDEyzFcoz58qmGVjjApob/E5LXmPDwTyLepmi8F0ZP77Uyeb
         eB3GbtMpSQ1lAXVaxk/WooOE1Ww8vWuYeq5jje0gZnZckC9pFldSQm2x6LNq85Ilxj0E
         Q3MyfcTBl8ZPPDAw/5+x9mbZxvcew8kRtfdi4dY/WEBehMKMaELhCa8AXtqWbvFDhdAO
         qaahOIWZ7ejMZYNNB8i0mHmUH7nCT6EmSr072XDgBLiSM6+e7cjlQ5ClM9vlqtZmZDth
         q/kuyikDjA1MwstO2kJ/OluVWIKKsyDm1PV/INU7ZfN2DiS9cj6GulCdgB8yKDW2Sufq
         B9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304725; x=1707909525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIqTMBlwECCoaCjtSPu7GBMR63K3xYDhekgHdgyJ3Uw=;
        b=B51xEsV/+raV22qhd6R/N64HZN2b5uq2ly03LyiEv1IOKTP5U2NAVmkyiXymx1QyL7
         fZn1sNaE5Q0+A3dIN0qIP8McEPXqUSFmzDH0tYLPMx/fifcZAgD30qK0M/dvWUzhzLE1
         bwiXFSYlRVMV9viW03LpFb4iB5fZZAkhM5duu0QBT6WpqUJBWhNlsmgygq1RffJDIKci
         NjOJvvZvTI+295NHOGzJnPYc3GOZP7U9M7YnNg2+2DTQiXY4fFnP+stnwMm3nhGin/W/
         YYc9CZlDCMacNy5lda8EahrErYcvVdZ7+OvbzuxpTIMvHRJ/XH9zz2EMxZaQQHAfHGol
         Ulbw==
X-Gm-Message-State: AOJu0YyOPdmIduiflio7hikh7CC8HFPVRIPg1BkqvyE1Ljcjlk1nuxYQ
	4E//dYFGSKZaOw2pPUor/fBYsun23bRNXCD0jcIecoMtUX6icMlzGsQ/6i4K8kw=
X-Google-Smtp-Source: AGHT+IGtmyjS7XyMK6mPlTBruiGOzta/vYcZqzFVH8gx2GKAR4MUHNsG7nk/o48FxHTKfeX8I5r7zQ==
X-Received: by 2002:a05:6358:a1e:b0:176:5d73:34ef with SMTP id 30-20020a0563580a1e00b001765d7334efmr2300769rwa.24.1707304724801;
        Wed, 07 Feb 2024 03:18:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDBZCqcU/ecjQFFfP1Fws3n8TlrjNFryuwLPxlTqdCVYrMnCBBXxfUkyHK/WGAHh7R821tL1nBH0Krw1wdwFkcxI1TcgsdG0qVVMep+k4mNLwoC+1Rnuh5Nvc6N9B4Epa4BrMW7/qxCg2Xk9zXVp4+ruO8p9V9Rr2bez48P9wSQgfJ/xOCO51cgF6uYzt0FMMAGTurzzygILHrwjN960mB9/ca05xbqCGSlC/r8lIwq0JZMiGtMWhYybPCCvcOBIYDNecQM2QcYmz8Sx5DM9aozAcsQa8anjRJL2Q5SkDdOSCEr03LHMEyhbfJQ7VvJkgqOVBwdkp7EhXg+ZHD1GyhRp2KQMoTqOsosogCheDiR5XmXosLoKE=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id z6-20020a17090a468600b002961ccd55e4sm3492799pjf.31.2024.02.07.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:18:44 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Wed,  7 Feb 2024 19:14:04 +0800
Message-ID: <20240207111402.576152-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCI Express Base Specification Revision 6.0, Section 5.5.4:
"If setting either or both of the enable bits for PCI-PM L1 PM Substates,
both ports must be configured as described in this section while in D0."

Add notes into pci_enable_link_state(_locked) for kernel-doc. Hope these
notify callers ensuring the devices in D0, if PCI-PM L1 PM Substates are
going to be enabled.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v3:
- Fix as readable comments

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7f1d674ff171..a39d2ee744cb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1416,6 +1416,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1432,6 +1435,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
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
2.43.0


