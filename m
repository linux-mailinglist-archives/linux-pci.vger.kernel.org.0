Return-Path: <linux-pci+bounces-17377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE9A9D9F82
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE81282887
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC451CCEE2;
	Tue, 26 Nov 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2PrvhjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B701DFE31
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663047; cv=none; b=g6H5liNxH8mCliPbXMzrA4wwbqc94XVq9pWs1zFUgchK1MFizN6U1rEJqILehhdr+luwij4XTRHhMo7vmJrgaN10wPWvYe6uNwAdZbkbaPd/cOuhjaeDTPIzkm7j5XznWgpTzkktuTEVCAK1Zxm6SMN+Qfl8Q+Q8zKO5pD11q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663047; c=relaxed/simple;
	bh=QNbYR62kxSihfmWFMFWaLTedOh3rb9Jygh9RH/srjeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlqSdhLZ2UajAI1BdY6fFqUYbM0F83J8G3RGKGFNkwvI3g9IHr2O7GEvHpsgMTl8XDh92ydX4AaVQJzMqRXYrMCnY4N+IrpnMKGVRjvyEPTGfjmyrg17SnYndBsRcuwtsdLUGmwEFBMCThkzoUCqwQL8lyuGeg1vvxH8cB1VBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m2PrvhjS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so1452747b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732663045; x=1733267845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgCywYrQljSdmItAV6QYlktlpASShyLs3PqDhCmMUsc=;
        b=m2PrvhjSoByxMiBRVShFI+V1jlKlo9c6pwHm8HB+W28cT1qFskemlNTJIpRwknpxDe
         nnpDLipU2fJJVPcBQcia5xEuNb+u+oOfHjt35SLtUIBfg1TWXThkz6x35FiQCDrERt8i
         CZooR1ASBhqsRm4LsSeopFQHTia8njbm2tdpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732663045; x=1733267845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgCywYrQljSdmItAV6QYlktlpASShyLs3PqDhCmMUsc=;
        b=MOQ3P2yyBWmraWT7/CpuiwPVtzM1QxR0hSY1cvTIJFFxX7JL3wk6Szqwlc9qNYRyz8
         uVSAStsTqQeTGLf5CIMMTQakairUUVkcNxa7q2o+rxs61BvMUzDMB9qxDTfV+B58iJ9W
         91W/6OlONDyLjCQ5XtkdpnrjZNRHct8xKvqsoWEWwfvPX8ipuo5EESv28iLcs4F1qjvU
         x6cihcuMotHOdfROC25cxg9t/L73JMvzTeRUWb7rwsLvcEKQ2CPWsm8IfksSUroiQi7z
         s3N7ZrzyQpHUMhH3qYO4rDUEy123X/D5cu6jH8E/T+fQPbe2moQURjl8r3XFVb42BNC1
         ugFw==
X-Forwarded-Encrypted: i=1; AJvYcCUnAAiQmzF5M4Edvbrn64UJtT4kfQuFA+KmTbmPXPJmjl5jPNU/AomkHTRREnj9wq31+POIDA8AsgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjtor9BT8a7dEEJdrh058t5aSRP/P/pYo+cAKs2RlrodoLA0O
	GRQ7DuKa501Xg0DN4QqoP+0uUBDkyk63+q8A5/v8izKwBeI6VVpaNmuFJ1uSIQ==
X-Gm-Gg: ASbGnct3j5JBEf6UW1qL3P/0SgbUhhMzWGv3VYnnSY4lx0r6re/B8pxG6t+P4Uh4AAb
	pAKIAXE7Iz3avgq9+xsvTlP5c7b6zNO0nRIITaeYJIpUgNym3vWKA9CtVGiVjDU1wYi8j0z9HUq
	kB0PrWqKhqZr/xTmPjj2pyyJFZx/BfEUMg1XNXktS7en0XbQSiTKTwzgjoxqTUJNbdawzNuUfjj
	8ty4yDZUld4qHyIMcN7JpQ3E7+ztbhZ7EaJEdRZ6HpOp4B0YvKjfSOMdD8xoVfYfmuj6TGMz+Ej
	U00uh+odOf0=
X-Google-Smtp-Source: AGHT+IFrllr2WVrew7Crqeczu1EEMEaxU7u5juTJ2m/FXo18xyEAoy25l2UGzRWh1AwvTk9GJ4EBUw==
X-Received: by 2002:a17:90b:38cd:b0:2ea:853a:99f7 with SMTP id 98e67ed59e1d1-2ee08e9d4f9mr1396473a91.2.1732663044988;
        Tue, 26 Nov 2024 15:17:24 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:c93f:3da4:a2a:71ec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ee0fad041csm96130a91.34.2024.11.26.15.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 15:17:24 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
Date: Tue, 26 Nov 2024 15:17:11 -0800
Message-ID: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Unlike ACPI based platforms, there are no known issues with D3Hot for
the PCI bridges in Device Tree based platforms. Past discussions (Link
[1]) determined the restrictions around D3 should be relaxed for all
Device Tree systems. So let's allow the PCI bridges to go to D3Hot
during runtime.

To match devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init(), we
look at the host bridge's parent when determining whether this is a
Device Tree based platform. Not all bridges have their own node, but the
parent (controller) should.

Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[Brian: look at host bridge's parent, not bridge node; rewrite
description]
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Based on prior work by Manivannan Sadhasivam that was part of a bigger
series that stalled:

[PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/

I'm resubmitting this single patch, since it's useful and seemingly had
agreement. I massaged it a bit to relax some restrictions on how the
Device Tree should look.

Changes in v5:
- Pulled out of the larger series, as there were more controversial
  changes in there, while this one had agreement (Link [2]).
- Rewritten with a relaxed set of rules, because the above patch
  required us to modify many device trees to add bridge nodes.

 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e278861684bc..5d898f5ea155 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3018,6 +3018,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
+	struct pci_host_bridge *host_bridge;
+
 	if (!pci_is_pcie(bridge))
 		return false;
 
@@ -3038,6 +3040,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/*
+		 * Allow D3 for all Device Tree based systems. We assume a host
+		 * bridge's parent will have a device node, even if this bridge
+		 * may not have its own.
+		 */
+		host_bridge = pci_find_host_bridge(bridge->bus);
+		if (dev_of_node(host_bridge->dev.parent))
+			return true;
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
-- 
2.47.0.338


