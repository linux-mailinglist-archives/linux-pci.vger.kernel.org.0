Return-Path: <linux-pci+bounces-22361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE88A447BE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4C18874FB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC420E32A;
	Tue, 25 Feb 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4y/yAJs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203B20D4E0
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503579; cv=none; b=GaCKpg0Pvfr7eZ4vywOfS/EQiZGSxZM9az7fdcOcyJg3a+6LWRJeOdGUZhMk7ONiMu8r9sQmu7hLCp7eyPwS1p3iCSsZIgFVak+jT9Cblmrvg3yuV9+wquSFQ9YRWEY7XqhVMf6dqcHAtRSFTrxHahfV4Ylp68vvlGRxSXZOhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503579; c=relaxed/simple;
	bh=+tGGIMv06lp+ks8XnH860+Gw5Lwd/dSbE8h71qHq7Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DE6qiz6W8aW82Gbd6MGVMdKL4kbJBtBYGyVzbsl7nkG4YOd8EL/yuWrl5I84g2dD/Hd1z4LJO3H0PDMCNHWvZCDKjB9jQTjeQnCHt3Lfqnq0UiwyQPtvQoVczgwX9QD2wFxuFf7dA1hLH7U6twiZABSKdCKIl45QGLMcvIznais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4y/yAJs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8cf98bbso39474985ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503575; x=1741108375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2A4Pw1OXG2cGpbo5o64UmI83DrJNfZOQBEMUYC4MwM=;
        b=W4y/yAJs8GoxR5cax841iWfWeGUr5x+eZgtcIdQXKDJ/RsyKbNnlRJAaIZjd9DT66O
         M0r9CU0QbDNJYVP8YqVIh2phMb0pkOXEPXQ7WyjgpX1VHEaKFFa7gkf4K3XcW2hl9AKd
         dafJr/X3wBWdfkl8XxGGIXGhBbjCvmT2UfLIDrIz/cNgFumyiTMIWcKBg2qDKBSjA+qJ
         OaNnaw5vDDAPcD26CndOHe/ksYdWXbJpGNdB+3FG1Q3gs5aIlVRmBPrgLxuKHJBBUwtc
         7dtxGT+wQiumYMTzxjNQ9qNf3/0nf662ekf4WQdlO8WTYoqCWfVgP0vTei5sUP34r7WO
         OtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503575; x=1741108375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2A4Pw1OXG2cGpbo5o64UmI83DrJNfZOQBEMUYC4MwM=;
        b=lQvWGzAPxd3bsEuDcTcDbpPDlITwzZNLOWbl/8SRRPWHnlaJB1H1J2wPbATEqTpMVm
         9RkR36wLytXsQFO4TFX85vDpLBmzg/Wp68sJEToNNhcDN1G6SiXwsUkvW5vOb4ruZR1A
         afQdPMwmWA416p3accHe4XbUaQI1vJ0vK1MKjXpKBOrGENW93oJUMoZs7xLP7tBw3Dbe
         N/giTQ3V6yNdpwoZgGVjmqyZkyodlQ8SB15vmhAMMM4lK1OfNGIc/bLREs5b6drQ3hKw
         sAhJHzxfvShT8GdUsqJ5xcbzN6AMgjFux8kaKDE432AOf6I8i1W3NOYNy+v+vJFOxWW7
         CbdA==
X-Forwarded-Encrypted: i=1; AJvYcCUDdbfSD0et4jADYOOGV/4b3l3l5WSlt6DD1sFyL9lurwSE9lf/NZPpGoWhpZBTL6cT+TUoN3InxgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIaFQhjRPdHTpwHFdyeH7teCB0oy1HHOkfDZC2O9XwSzbk0zE
	0r7GkIPlv6wc7iI6Pe1jkMynao0GlTA83ZVXywUqxuvXbAaKbDN6+wz0DDjb4g==
X-Gm-Gg: ASbGncuR92kWPJ1QX2crMWICsu9Qvg1dB8IOFmOIZInivRElFAtT7d6EUvS7sCUmok8
	eIglxp3KCK7f68u0GAqdAfNJGGUrUFGHsVtydY2oo11ey2ugmxUhR58XnOMbr0aLZWyG+VZ2acf
	pNRyjIMqCi9x4sfgZBDxn/cLymPgzbVx2bh4k3I2qHqWmDjNu6mhmIoV1P1017jjCT2m+jBMYbH
	YRZhbAEzEv7ii6LoX1dXSRSc9J2JWGy4LVaVLhlJicgPoReogw/KFCrtEC5oFafHTaMeqvu3g5P
	8Jz/ymtvMTZce7uB5NGDSjgLz8G8MOVzElvjr6SQClaxMafWDlQIgw==
X-Google-Smtp-Source: AGHT+IF0H7ee+2m65dVm/sTEhXmntHs5M4Jmtg3yLBFmQYpcVS+0owZYZL1XMbzJ3AMwJRYXJcklRQ==
X-Received: by 2002:a17:902:e54e:b0:220:f1db:d96b with SMTP id d9443c01a7336-221a1148be7mr311401165ad.41.1740503575534;
        Tue, 25 Feb 2025 09:12:55 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shradha.t@samsung.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] PCI: dwc-debugfs: Return -EOPNOTSUPP if an event counter is not supported
Date: Tue, 25 Feb 2025 22:42:39 +0530
Message-Id: <20250225171239.19574-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the platform doesn't support an event counter, enabling it using the
'counter_enable' debugfs attribute currently will succeed. But reading the
debugfs attribute back will return 'Counter Disabled'.

This could cause confusion to the users. So while enabling an event
counter in counter_enable_write(), always read back the status to check if
the counter is enabled or not. If not, return -EOPNOTSUPP to let the users
know that the event counter is not supported.

Fixes: 9f99c304c467 ("PCI: dwc: Add debugfs based Statistical Counter support for DWC")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 9ff4d45e80f1..1f1bd9888327 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -352,6 +352,21 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
 
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+
+	/*
+	 * While enabling the counter, always read back the status to check if
+	 * it is enabled or not. Return error if it is not enabled to let the
+	 * users know that the counter is not supported on the platform.
+	 */
+	if (enable) {
+		val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CTRL_REG);
+		if (!FIELD_GET(EVENT_COUNTER_STATUS, val)) {
+			mutex_unlock(&rinfo->reg_event_lock);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
-- 
2.25.1


