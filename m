Return-Path: <linux-pci+bounces-2517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE083A560
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181141F22A49
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E12A17BC6;
	Wed, 24 Jan 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErdTiBmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB68817C62
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088367; cv=none; b=j4FllRyH2DIDkPExmDLkyEYu4el526Hh5AJGMLte0NMXZq6hXnyyw/AzsA0zX9vM7FHUylJllCbtldbERDCG3WCoh5KMvgwxZyh0MDzSkYpyN+KkTFjH8RL3jmf9vBAUTiYt478VrqUk8hkqygPf7yy3WEdy5vZs+WASy6jIBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088367; c=relaxed/simple;
	bh=yFNikLmen+a8FyJL+DWGcDRPH56JYeRJ47yOImVxRrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEoHnZHB/Y/H3Ai2rqK8WoML4tInLMmo0HHQSpPazW46pm7I6eqntZo5zPWDVot5PxjdLZZKgYypuEuUYYh9WpT9+Di+eMM3bFWxQYYAxtcWMcS4f1Y6e0sZqKLDg+7rZNei4MPoQX/yiqEbOzFtDLH/bbFdZiP3twtYoSV8a40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErdTiBmt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso7716585276.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706088365; x=1706693165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5F04IP2GzMz61vo2l6voOzlKXJ9JFRvBWtw7JtpAI=;
        b=ErdTiBmtxZK49ikaZJ5c/zC0PBsZXBY8K6GCFOdCbWc6f+ws4qWrSV90q/DEtZ62QG
         4HcLUXCQyjMd74z+DisbeGzw6IbDZ5IT2NZkE53k9nnyi54IR9NLzn2cDNY6AHrY26rQ
         YDbaznG41BGLNzQhfe6B3PiLJNvx0R3jafC5Va46L6epCe5mffL5uTPbD3lce8x8hBJn
         H/KJgi5kLlYn9EOzAuywJwrnYN6k2yJrgDny3fu6v1D+AiWqh/lWRGwrFdtUXYz+7cOo
         V0gVrUUxe4Z3ioDV35kSMP5p/h9pgiatEeYy/N6L1qHdykCLrkVW0wiYUzbEW0fDuZLm
         yjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088365; x=1706693165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5F04IP2GzMz61vo2l6voOzlKXJ9JFRvBWtw7JtpAI=;
        b=XHXxqZSpV864lBjtYOXdxfEtFpT/62kvdgiAjE0JJKvpi568C//5K2SGuMKldH84Db
         bCkj3J5OXTWNENrN0WvuuM5FbWAUBFg2rOEae39Q4pbBHiaCiXxcmNWSmAiT4eoQc0dL
         UXGWUv7dV0jJOuSd13LqeYQJ9fgki86H9HqiQMtp8sfT9q0eLCuNU3bJpD4Pz/HykRej
         5foQlCrFk4zBA0NmoV5JPlOkCgCepzzCgDQ1uvzwluddwgcH0ViESBrv1aTfPXJCCs66
         sGOQFkx6EchNWn1fVCdGHIX+5jGDnCNCxEu+B45bYcj1295slv2eg/XnvVxyPcuT5VxO
         q/5Q==
X-Gm-Message-State: AOJu0Yy5xl5M67W3YqYzv51nperay7/OGEdZUavmlUYinIDlRJNOJXDw
	qD5e6oPQIlHPJ5bRCI1KL2cxbWrRUZN3Y7V/MaK99yMbz9qzRS/LqYri4Wbb2vg7ZEH56wjtucd
	LFB/5fP9VVhmxs5Vu0G8efg==
X-Google-Smtp-Source: AGHT+IGpm5pbUKRaua3G8PxDx1Ii5KdghkY8OgO/jjvezXQyRzb0EBmYxWPiqfQP1GK9R1juO+clB3FjhrvcfTFDYw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:b16:b0:dc2:4469:e9ea with
 SMTP id ch22-20020a0569020b1600b00dc24469e9eamr241996ybb.11.1706088364797;
 Wed, 24 Jan 2024 01:26:04 -0800 (PST)
Date: Wed, 24 Jan 2024 14:55:33 +0530
In-Reply-To: <20240124092533.1267836-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124092533.1267836-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124092533.1267836-3-ajayagarwal@google.com>
Subject: [PATCH v1 2/2] PCI: dwc: Wait for link up only if link is started
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

In dw_pcie_host_init(), regardless of whether the link has been
started or not, the code waits for the link to come up. Even in
cases where .start_link() is not defined the code ends up
spinning in a loop for one second. Since in some systems
dw_pcie_host_init() gets called during probe, this one second
loop for each PCIe interface instance ends up extending the boot
time.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
This is actually patch v6 for [1] which I have made a part of the
patch series.

v4 [2] was applied, but then reverted [3]. The reason being v4 added
a regression on some products which expect the link to not come
up as a part of the probe. Since v4 returned error from
dw_pcie_wait_for_link check, the probe function of these products
started to fail.

[1] https://lore.kernel.org/all/20240112093006.2832105-1-ajayagarwal@google.com/
[2] https://lore.kernel.org/all/20230412093425.3659088-1-ajayagarwal@google.com/
[3] https://lore.kernel.org/all/20230706082610.26584-1-johan+linaro@kernel.org/

 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7991f0e179b2..e53132663d1d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (!dw_pcie_link_up(pci)) {
+	if (dw_pcie_link_up(pci)) {
+		dw_pcie_print_link_status(pci);
+	} else {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_remove_edma;
-	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+		if (pci->ops && pci->ops->start_link) {
+			/* Ignore errors, the link may come up later */
+			dw_pcie_wait_for_link(pci);
+		}
+	}
 
 	bridge->sysdata = pp;
 
-- 
2.43.0.429.g432eaa2c6b-goog


