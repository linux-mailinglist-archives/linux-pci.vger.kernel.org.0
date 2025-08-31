Return-Path: <linux-pci+bounces-35200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCBB3D4CA
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA503BC6AB
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1618275AF3;
	Sun, 31 Aug 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvgQsMyg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C1274652;
	Sun, 31 Aug 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756666878; cv=none; b=Lee57FWnW3QHLiG7dCV590JvQ6i75Ax+4jWDYAWfMxn5K0GejLvbQ3oSGdcduOHpv0dcS7l9FNsYx59JHlLM1XjtBT6wQyDwv4/kCM2Cxg+gL5wpX0EjOBB0kOPJQDyfZvtIqB/7rbFhb/bpRB8Jxr7btRrfs6VttALBopVJV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756666878; c=relaxed/simple;
	bh=+hYQm6qhhJN1abspVwfr4istSqBSVzJMCvKbPgtQCg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeF4WXf1E2HN/mQxqNK97gzasbdKF79Nj3Z+RMuWNALyRR/ifAb0Z/TYFHPGL5GCgwVQuDd5I3gGYuBDyMOXvK4o/0OoOlnMEmCjlqdycYrXiSXbHproAU8n9qeowVJZswgNg7S9wxYXgF/oM/Vvribdo6TvyOpNgNQMPa5cQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvgQsMyg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso2347508a12.2;
        Sun, 31 Aug 2025 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756666876; x=1757271676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXIAAzvJiU7fqZtLJa5keqTVU78K6mocDNuR/R0O6LU=;
        b=EvgQsMygE+ZEqkA/uV++K+IxQ4pBvcLccU/h4Ykt7rT9gceLhs9u59+Tsm8yDNAvZy
         VT59KvNEoC+CzkNfChHJm5raeo8kBtc5AXxKz4ZuA1s/ftNkMZycGM9MRMghul7VrgrG
         8wApB7WiEVoq5wNnxrnCCVdq0PqZY1QDi7/K8VCinT3atJyOx9Hlza4sbPw0BVqMdlc3
         RECyIJlJBT0v9kzApMyrJ+zuWHSdLPsHBaov079b2vEFPb5cYcIQPsDjLKW7/WoYfHdL
         WQJmcohg5kg9Co7NlsiR5uI5SEOBsEidiJklDP6zCsKwXXnECp8ATP0fCQsaCNtix+SQ
         l9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756666876; x=1757271676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXIAAzvJiU7fqZtLJa5keqTVU78K6mocDNuR/R0O6LU=;
        b=ZKAr191Vd4fTI2CaFmc4LtDexRmaNG2Pn346XR1msAPa9rKJSbLpZmQqD7cwyDoLEx
         gGWEYySb3Af5uwdk3DsV5vmQzpKoTMDzAuuomeNaJ8wpWXNzjVlSDpvgSMbeSoaFrA+o
         s8oSISQYmY6u/UinW0vuv5Yo/H2FUFJ3DXf+0a3P20LWdIQDflYJdzeHNUXrxpaGOoqk
         Ag5DXB5W92LIQU0KRx+SYPcqoJNCzv4Sp57lqF7NzmgPTTc0zAJy8hnlEzbSp/8t/GDR
         1qlv6rfNeMSLvJ9x3vK8755YCVGxw1+g2VdNsMdAltdIn63wdDGO5BAKJnL6cBzgEmN9
         6Bzw==
X-Forwarded-Encrypted: i=1; AJvYcCW3QLN38Xo7DJoinMHMm9teFbW65XFMTAImRTxglxxkMIasK2bpRF1bimzkvXu1+Y/u3P1JttH8OAAVNEI=@vger.kernel.org, AJvYcCWpYwOwQRNQ9VJyIYq/AcmkCWHXxc1sn9/kyYP1ZF5UvBVbi4NRBwANclcNA0CxpYpIhbw8fXjKe1HP@vger.kernel.org, AJvYcCXQ5BK2BYG8pftUtcZPVOb+F9qZk9dBAG8mqYK/KXLUb7xjoRhuhH3MX7ic0RUmuCS/CM1TS14bPWb04hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgF6CprX7HrijOGqUw6N87Q4QFwSppsios5KkSyr0zjBaFgbV
	N+3fzccIOmxV1M2FATgcrDK1T6zpu3JiyCLfsjM667pwizNyNIsetWmW
X-Gm-Gg: ASbGnctK2yUSuGnPIb0fNIOFaRxHf8FzvoHnOJ5EDYRTdml1BjJ1CxGI7zmOGzsz4q6
	GcjLhA9FZk4n8hr1q0+ehg0RJs1brLSmHSe2nFezwvwP5EuQaXbHuKL5DkjSM51dVpiEbQ/U0Ve
	buSY/dVat5Ik4h0lIPANensnFsxwdjhqz1vNbHmzl8O/8gyUcAW/jqOihPpcQbXYD+6Ebb096nt
	0DCSN8HCCDoWtj6Wseu5vDnUl9tYAKMWTqAxz4mD0Xd9m2x0Fi6zBPyEBm9l7ePn6gQgNIpsygD
	JHGszmhK4QdDplY44lE7vjN3xcPgmH6HxCxjXWJyLfTxdbpf3Ao2IhGhrWughwvD0qx+3epg6oz
	qQuR0FtIPDsQNgfUpmnQH1nDIIOJBHUs=
X-Google-Smtp-Source: AGHT+IE9ZML2xB5sNonsurStZvpqBItLvlpqWDmiFAi0CMc/OivHPsJOavlpXyN+CiXdX7RcptLAqw==
X-Received: by 2002:a17:903:198b:b0:248:e716:9892 with SMTP id d9443c01a7336-24944b22091mr68456025ad.59.1756666876216;
        Sun, 31 Aug 2025 12:01:16 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372723fsm81118355ad.39.2025.08.31.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:01:15 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
Date: Mon,  1 Sep 2025 00:30:51 +0530
Message-ID: <20250831190055.7952-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250831190055.7952-1-linux.amoon@gmail.com>
References: <20250831190055.7952-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual `do-while` polling loops with the readl_poll_timeout()
helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
during link bring-up. This simplifies the code by removing the open-coded
timeout logic in favor of the standard, more robust iopoll framework.
The change improves readability and reduces code duplication.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 38 ++++++++++++------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 3841489198b64..8e850f7c84e40 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 	value |= RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
 	writel(value, port->base + RP_PRIV_MISC);
 
-	do {
-		unsigned int timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
-
-		do {
-			value = readl(port->base + RP_VEND_XP);
-
-			if (value & RP_VEND_XP_DL_UP)
-				break;
-
-			usleep_range(1000, 2000);
-		} while (--timeout);
+	while (retries--) {
+		int err;
 
-		if (!timeout) {
+		err = readl_poll_timeout(port->base + RP_VEND_XP, value,
+					 value & RP_VEND_XP_DL_UP,
+					 1000,
+					 TEGRA_PCIE_LINKUP_TIMEOUT * 1000);
+		if (err) {
 			dev_dbg(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
-		timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
-
-		do {
-			value = readl(port->base + RP_LINK_CONTROL_STATUS);
-
-			if (value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE)
-				return true;
-
-			usleep_range(1000, 2000);
-		} while (--timeout);
+		err = readl_poll_timeout(port->base + RP_LINK_CONTROL_STATUS,
+					 value,
+					 value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE,
+					 1000, TEGRA_PCIE_LINKUP_TIMEOUT * 1000);
+		if (!err)
+			return true;
 
 retry:
 		tegra_pcie_port_reset(port);
-	} while (--retries);
+	}
 
 	return false;
 }
-- 
2.50.1


