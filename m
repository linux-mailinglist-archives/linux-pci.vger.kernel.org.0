Return-Path: <linux-pci+bounces-5427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFB7892640
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910A728512D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956A1E535;
	Fri, 29 Mar 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYEtEXWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0E79DF
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748553; cv=none; b=HyHaw64zcDeTDNNNOUZbL3I4VHLr8UIj/N0ql5DUheGd3HPu+UXqCZ703Ht7K71hkLThonKlNlIAh9fzfdTCyUhF6eUbyrx4fhSz1ZwQFaJzCCo8zLGJtBiKqYMdXZLiZWd/haXdI9/sFJvFvwMmY0fTnT+jaVl4v+p+ZSOAp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748553; c=relaxed/simple;
	bh=TX0MgZ2nt0PMqCZM/jLnhoJfB2IrOcywfddLVJq5SqY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZ3oH550SpGBZ2jV/5NuvMpLuFQ8n7CY5B+svqOjmJVANu2tmIjoR45364ReQd6N+voTddXxUWyQbhbw/0ngeOa2lgqNUbLmX6ScR1PtKz1GVgrYOpdjaZh6MdoF0FbhqE+KLfj8tmkqIPLxbkpiJrVcX+NkcQ3euhsare0IbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYEtEXWH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so3172916a12.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711748550; x=1712353350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+fFiYiJUB42fIkmPGo0QB+aOTupfQTVE65kdPiMa/c=;
        b=hYEtEXWHVdCmmkOh2Sc6UjztfoOXpApmLw/UDp7/XcWnRUlsXgWmtBiLgWEu+gpj3h
         n3xTm2qGHihsP7R4369ZufBiYNnwM4vA09Y4xpOHLry3cjpuqRKMYO+VheCG4iPmFRVR
         kkW0sy2mEtMsH8CRbA7dLq6tZ+YefxVR44DVBGu221al+qHvHu9iU2ziAmFM98KDu18k
         uYT5cHGcfWggwUaoRHwz1Sk8gsJZZUf7q9HEKvV9bkLiwF2kYlrkLBqAC3oU0M5csvry
         F8/FOZOzbjU/FjHTHag99F8GILGexjBjgDJ76sI98js6c4W7x/pjGhWs+COElsIROjsk
         TOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748550; x=1712353350;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+fFiYiJUB42fIkmPGo0QB+aOTupfQTVE65kdPiMa/c=;
        b=C9B+bF1g+HrJ3GrpKpyZkpXvJueDpxWb1xmRcac2F9RDIlFwA4DEuXgRSdm3agsts7
         ONL9UOMoY5UtirwKkaNq+vRLgms9UW7dVSzDLFKxCwEHMl1oAQNHeHQbXICMXGMU6RMw
         REhN3aq0qvFULxdEhDPKBYDVeqo/BI6M4jFz3g8GM0zlCRlZyWbx/7C+q6BL5s9x5Eei
         dO/6MnT7VjYwFu1u04hyKcUsQztNq5rIfn18eC8B1gBmQobh1st04/rYJis6fMj2sY9J
         Plg/SnI46rG0t3UCxk+VtXMtRHwKTrymXJ3ToTzqbrA+NLw42Zr1nsuG3O4C+u5YlOH3
         trzg==
X-Gm-Message-State: AOJu0Yxt04H5xcgdVgmX0Xf7a767rHDMqJ5gpumMVYUWjxVhtTvhUqQS
	F+ke5kzieZFr0pbot8xZlTT7efKVmNqIbA97jIXl2fRDF9Pi5UgK
X-Google-Smtp-Source: AGHT+IGfOy5mHY3Ypci6IBNXiEHYCIlCNynxiHHVlFXW+gxolHzKUl8u2vAva8R/zVGagQIc+y6qEA==
X-Received: by 2002:a50:9b14:0:b0:56b:b698:accd with SMTP id o20-20020a509b14000000b0056bb698accdmr2087333edi.25.1711748550186;
        Fri, 29 Mar 2024 14:42:30 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7bbd:b600:50f7:b974:760:86c8? (dynamic-2a01-0c22-7bbd-b600-50f7-b974-0760-86c8.c22.pool.telefonica.de. [2a01:c22:7bbd:b600:50f7:b974:760:86c8])
        by smtp.googlemail.com with ESMTPSA id 11-20020a0564021f4b00b0056c36b2f6f4sm2455565edz.59.2024.03.29.14.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 14:42:29 -0700 (PDT)
Message-ID: <abc8adf3-32e2-4d43-87bc-a835c01a900d@gmail.com>
Date: Fri, 29 Mar 2024 22:42:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 2/2] PCI: Remove MWI and INTX related members from struct
 pci_devres
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cb48fd68-9bfa-45b7-ac4f-d1c2b9b1f207@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cb48fd68-9bfa-45b7-ac4f-d1c2b9b1f207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After patch 1 of the series the original value of register PCI_COMMAND
is restored in pcim_release. Therefore the code removed here isn't
needed any longer.

In a follow-up step pcim_set_mwi() could be removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/devres.c |  7 -------
 drivers/pci/pci.c    | 11 +----------
 drivers/pci/pci.h    |  3 ---
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 7766f4df4..2661f7775 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -150,13 +150,6 @@ EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
  */
 int pcim_set_mwi(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
-
-	dr->mwi = 1;
 	return pci_set_mwi(dev);
 }
 EXPORT_SYMBOL(pcim_set_mwi);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4..2007edaaa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4408,17 +4408,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		struct pci_devres *dr;
-
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, new);
-
-		dr = find_pci_dr(pdev);
-		if (dr && !dr->restore_intx) {
-			dr->restore_intx = 1;
-			dr->orig_intx = !enable;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846..a1bb8191c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,9 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int enabled:1;
 	unsigned int pinned:1;
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 	u32 region_mask;
 };
 
-- 
2.44.0



