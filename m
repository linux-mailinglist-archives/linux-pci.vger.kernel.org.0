Return-Path: <linux-pci+bounces-27105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C302AA79B5
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9687A88CE
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00D1EE031;
	Fri,  2 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWtQ38pH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885512CDAE;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212445; cv=none; b=jD7RdEJWSNYccAlYUBcklvVfFL2htOv1cY7TzI5fYtgRMDJYNfQFdV+M5dbWoUds6U1q3nxKmEkxapMaV7aMsqxzlpJTBDZdkFLdeGEFjtAOhV8EXDXb0vg5H/o72u8NrC/B9sE5iFQ3jVBM9Zwb31HqPcDoqIExSHwZR+Q/K5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212445; c=relaxed/simple;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tkyxr94VSin21pSIo92BbQY1XHzClTGv5au5c8Dl2JDanmffsvNkUHRFCDa8VpEXtzeh5ZmMiezUPwXFQB253G2eoV7t0QxoiNq/QlYzIrr8dE7m+zZxtuSzfnfmQ92Mn9Co+TMTdsGLAmzMzVpN+QKs3Lifs8l4uO8y1YGjO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWtQ38pH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A02CEC4CEED;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212444;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LWtQ38pHo/Yrv8BQE28Ry2jM8EPgFF1ojO+brYE244/p5eNOGlyJhFQvbZgIudlLk
	 SL+j/AKe/TtTzF0qbA5AGNBZoivreYwDtIyiPXe2AZzWI0EcgWxejHiAC4qmzw2Rcq
	 aQu0b7MBgz1fl22MsHTqRmaVZMIyeIvwE3de5vRoIiDBaWXoJzXUYLVnGoSqTqjx6x
	 orcfqpZFnvwI1nmg/WqM3pI/hZiXXnTwsRvZMaMmN6mhSzgdnNc1T2AFDT2BkGkw1s
	 lYlyuBdqDsPlWRBL3vHjfoPAGU3qdImYMlIHBt8HvNbgvmOxHMFFrrNnHf3gBq8eGD
	 Ic7kL4WMcCdeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C049C3ABB0;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 02 May 2025 14:00:29 -0500
Subject: [PATCH v3 1/4] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pci-tegra-module-v3-1-556a49732d70@gmail.com>
References: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
In-Reply-To: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746212443; l=788;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=WmKEd3TO9tPKzFNggls+Iy5PtWJNMd2mTPJMCu0pPuI=;
 b=5j2exqFnp877XdJQRSpPH1+pl+krTkOiipDlqB1XtSl0j/ACPysLiY9RIWoW1Ior+5VwHyQWD
 fkDQkbov+V3B3j8ZePdrczxtPlJqWbji8Hjns5IP/C56zBrmuRIJUfY
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add export for irq_domain_free_irqs() so that we can allow drivers like
the pci-tegra driver to be loadable as a module.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e72d980f604ded2bfa2143420e0e0095920..36cd79a8a2ce960b07b03c40067343ec8f632452 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1890,6 +1890,7 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	irq_domain_free_irq_data(virq, nr_irqs);
 	irq_free_descs(virq, nr_irqs);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_irqs);
 
 static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
 {

-- 
2.48.1



