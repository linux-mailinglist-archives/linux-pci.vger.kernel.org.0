Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888FC15C89F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBMQwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBMQwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so7037840wmb.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLm+diZ2LcHfr0394F1s+yyfGk9eSuidgj94VOIGVJw=;
        b=tiYr7b92oPJK9Rk1Gz7ISnXadjy99eXjJlui5eg7HZk45BvGVN6A61GX0Yu4eKyStX
         vhGv6Ez24Yg8/5hgZtdcD8ly8JxoQmsj0N1Hf7SxEEKVARO5mx5sNNeS0YhSS6e9kq4f
         XotYFn8IB3W5V8rHY+OhK/PWIlMGxUeihlB+8viY5iKvXJKxzAdyjBip2SSKi5kNQJGJ
         C+m9VaqteGLe1AfCrDlGJmNJ9C88TEjEQ9jgLuT5HHgxutbNec16wTRjA7llxO2X0qJH
         mC/avBLY0qWSbS1xsDS5ZHOB8LrkXHdkPiQYRp+vm6UF2MK72kWfz6Rpj2lx/ChK8Sq8
         FOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLm+diZ2LcHfr0394F1s+yyfGk9eSuidgj94VOIGVJw=;
        b=YHoTIgTafzHV+C0H54YHhtXkb5z0aFnkNrvvkq0t6H1v2czyzVydX1Lyn9JN+iEy0V
         Oamyh4ZhVw8ca2Lj3eMw0b6GbVNl20UMjxrUcswdO0jwOPJskJTnXaQk2M7VUL0IM3n1
         3KFrpiNdPBbFTQCJLlbHIPNDjkqwemR+zEWQDDJWsbM32ZE8pPQNKG4TDCYLMMnJID9E
         zfH3bAC4dyk+SS58+Qfoh6VnQeusV05Nj0RkBJTllxlHTmJ91KQ4//rC9PX0YIWi/mmt
         bpq+7iBhmYUwnHc/jwCIM/8dJKq05fBTS/I4glm07+h4pcXY5n87RNmzk+P2q9EdSUEE
         BzDA==
X-Gm-Message-State: APjAAAWzIB7U1yRFzoZTG2yh8xTWCGDvbpUC/7KAnEGzFVR9b67akhnl
        Iub+JtQQ5PzaSm1oIcgo6SqTaA==
X-Google-Smtp-Source: APXvYqywhPBCuc7YV+pVDcQ5dsIQRL3jciqAiBWcZ6RYHFYVHZcjIZ/wRvt2G4McAzl+fiVmWPpNkw==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr6948649wmb.118.1581612726195;
        Thu, 13 Feb 2020 08:52:06 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:05 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 02/11] PCI: Add ats_supported host bridge flag
Date:   Thu, 13 Feb 2020 17:50:40 +0100
Message-Id: <20200213165049.508908-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each vendor has their own way of describing whether a host bridge
supports ATS.  The Intel and AMD ACPI tables selectively enable or
disable ATS per device or sub-tree, while Arm has a single bit for each
host bridge.  For those that need it, add an ats_supported bit to the
host bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/probe.c | 7 +++++++
 include/linux/pci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..75c0a25af44e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,13 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+
+	/*
+	 * Some systems may disable ATS at the host bridge (ACPI IORT,
+	 * device-tree), other filter it with a smaller granularity (ACPI DMAR
+	 * and IVRS).
+	 */
+	bridge->ats_supported = 1;
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..9fe2e84d74d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
+	unsigned int	ats_supported:1;
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.0

