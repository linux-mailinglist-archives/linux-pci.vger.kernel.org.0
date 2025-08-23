Return-Path: <linux-pci+bounces-34628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6AB32C45
	for <lists+linux-pci@lfdr.de>; Sun, 24 Aug 2025 00:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B035F58792B
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA501F560B;
	Sat, 23 Aug 2025 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M28z2Dci"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF515C0;
	Sat, 23 Aug 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755986618; cv=none; b=Pr2VNfobtIJe85VagG2JgN5IRA/2/sJamTqLuzPcaz4H19S2DJaic2n9w2zYYjNMWl+2nS19aqTQtCrOmjCLtgmXgti6PHJ7V7Ec3nLLmOJ2tm37A1mHeGAJQyZca+7HvL7G3AQj1kZ7cRawBXujx9/JKcWvTIGDV2weEjW/BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755986618; c=relaxed/simple;
	bh=9gdp7M094EoAHFgmksGn4KjDgeeGaU9nsvDsm1VWUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pmkcbp+Hy5VSDcs9ysOhAsJZZmtAGfJV7rrV4TPd5OUnBBYIxJVRXJ889EONo5xEKTaNgUSot9JJB+O63dC17bVYuOcZGPS335zt8Rm9oCllghdYS/KWAo55T2R22VCRz75jBgx1uGE4gGPgeZBuOI2jlRbtS1TaJqaHot9YoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M28z2Dci; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e87035a7c3so473783585a.0;
        Sat, 23 Aug 2025 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755986615; x=1756591415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOyX3xsmEr0cfR533WjUXZGAthPGKOXZvKXp0vJLWOY=;
        b=M28z2DciYmbHZ3Sj0MJgIXMoMOpx9aIiCoEQ5Ci8WZHMp2jYVxrWxo0YK5ixx9XqsJ
         5yb55Gjae5RMqz/3UaELQJgj6FOuD0EyWfUjC1GcHfdnT+tSnOKn1ZtbL0ATYajkQJ9l
         grOYR0QCvlOyJR0eLPnVTmHDeRENtiXIu8tIRoRhU/rJym9r1FiuXldV5J8iO5Je8dpj
         iyHU0sRx7+3vGzS3hFbvUp29WaiBIUnUE0BQj2zMiA3srg5CZdVSGlQhOYcDv+QoPCwu
         rZeP9CX6MhtZgR6+FTUtxpKR4RneMXqwCB9TznqP+rBA3F5TkDwfiLd6xf+3SDr4WW95
         ZaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755986615; x=1756591415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOyX3xsmEr0cfR533WjUXZGAthPGKOXZvKXp0vJLWOY=;
        b=bNrf27+GxbNOtyEFAlV+gtTgqkpxLmFKRfNELDzppwPFGzBLWDhay7HsUV1hy15ekG
         pT7tt3r1dTXiXCBgphU1DElvQMKmllLahKKisp76TUjMGs7OtRhA02gPYi+xBVIlf5N8
         QoQKGDKTsoE8VLasIS8Fe1U9G9m+L5zDQNLDyMm1T5I2I0bfrkY4Q4uE0kKpEpGbSc9g
         8DaW+JYImUh0jwaTNylOsbVttbJXNRk3kE3lchKGinHv/BprHSXQiOxyPq/0BYFT/tp0
         LxsF3gtZVo33Z64It4OxZr+lZ6EMhFL/PsvoOiJn4/+E7wL2vDe3dHQdQrcKU0qKqF5w
         ta1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcmXxBbAO2wJhhc8k3l8FZuJCt8zjNurqomeuWyIw1U3beLEjuCX7TRUkhx09cgJpHuAiE7BdtZwG7@vger.kernel.org, AJvYcCXaYDpu2JOwcjvsLIcyBoqRb6cSk2abLnU1jhTX4w0i+YOp01EuBRblkumkhIUpytbgkMb+cEARAlnW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf86uAu4zruYhxQeUxLAFK4BzcJAFOTd9m0Ic7kulSFOrqyvH8
	fSu2qFEj2dEjvVe4d04/NKgJKMdS4wg3iBjDhTJqrn2mk3knOG1s6lcv
X-Gm-Gg: ASbGncubsr4491kFBCqOAP7PW/mo7kX6vEF6pr1E1IYOZnrThtmDOH0fdAvtKW0oYAB
	jFyYnnmpb/7RuFDkx4yvMQ1G+knm1Z50Isgi/1X8f1/PkLYvG1T3MI75sxAJxxxQjMcbkYGoRVG
	NWpXv5te6U4m4pxVrqIe1grD0V6Y5C78vnKiPAgwiBW2I2o3JHhkgDeFH75vwoY5v9OXIrE4Zv1
	OR/w20w86iMRveXTlNQ61fOlrQ8RBpsrNgW6PNqUAtdqYcDUEWU78mPAMQg31yX+o1wQdKzxT5t
	kjdWbmJOmtB+Sd8IKz4dOwzWtt4piqqrZFQByXrj2GLOrXB4dwZjDxhf8sqbMfn9eeKjbGBqOVa
	9u8sPV2chYbhQ8/k8ut+d0p5EgZjRc5N0uvzYTzJ3wwPAZ1xaA7DXo16DKQ==
X-Google-Smtp-Source: AGHT+IGhcRLCy7w/nvfoyZtyXVKXhyD54tDcha2AXgxEaPEJiOmejbL1l814zItyeQEFj8+RHUD5Kw==
X-Received: by 2002:a05:620a:d88:b0:7d5:ca37:79a0 with SMTP id af79cd13be357-7ea10fae57cmr820612885a.18.1755986615541;
        Sat, 23 Aug 2025 15:03:35 -0700 (PDT)
Received: from cr-x-redhat96-nsd-2.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf36e7640sm204557285a.59.2025.08.23.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 15:03:34 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: lenb@kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] drivers: acpi: Use str_low_high() helper
Date: Sat, 23 Aug 2025 15:03:11 -0700
Message-ID: <20250823220311.2035533-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove hard-coded strings by using the str_low_high() helper
function.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/acpi/pci_irq.c  | 3 ++-
 drivers/acpi/resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 630fe0a34bc6..ad81aa03fe2f 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/string_choices.h>
 
 struct acpi_prt_entry {
 	struct acpi_pci_id	id;
@@ -468,7 +469,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
 		pin_name(pin), link_desc, gsi,
 		(triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
-		(polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
+		str_low_high(polarity == ACPI_ACTIVE_LOW), dev->irq);
 
 	kfree(entry);
 	return 0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b1ab192d7a08..55b195ad5c7e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/dmi.h>
+#include <linux/string_choices.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -773,7 +774,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
 				t ? "level" : "edge",
 				trig == triggering ? "" : "(!)",
-				p ? "low" : "high",
+				str_low_high(p),
 				pol == polarity ? "" : "(!)");
 			triggering = trig;
 			polarity = pol;
-- 
2.47.3


