Return-Path: <linux-pci+bounces-38913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE009BF764E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB50119A3853
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85B346767;
	Tue, 21 Oct 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ocn3sV5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4730346763
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060615; cv=none; b=VfyGBGl0gR0MKc1tbuXDz456qJdeAeTvnAMNIZVgPn7TfI7//57FykHoN2BF86GGoZ1WoVlQcYJXU7bjVofTdn+cQd6fFwTjSbnO4eXLRfxHbvd9lhCHjlcIJs9VNYJdIpAmuXgRLLLP9fz7JY7gey6/7E4MxRE+nAmOQmZovw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060615; c=relaxed/simple;
	bh=+f7O9lqmMO/tX/w1zN7bxbzuN13C7uTtt+VLYmK6kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObQkRQQ7Vv8ULw+WrB8/9jBBmtGYr1hoTgkSlVPocpJ3EIdXFmNFqYnSItXA1JvJW1xa4Fcd6xDYQIJypob3I/nLUcm/Qd3upuayu+I0bk5IWCJ+JvcT9rxDXLTTQCOoy75CcfC/7/Y12dfks06EDzKG60HzjTmqT/lMMku0Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ocn3sV5D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4736e043f9so969971566b.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761060610; x=1761665410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUzpv3BxCmCZXTEwvzep7NMMR9W5hvjdg/xN1LZUEgc=;
        b=Ocn3sV5DbZS5/W+SYO0slQsc054Z6+Ycz0Tv8L44nRhhGdh5pMPgLc8maxEu+VDmJQ
         6c9BaLBJjI8kfQFm1U1TMc7SocYxbdwaUxmNSKvKZ9YOGB5dtRGjPrJ0Hinr/WpQanw/
         Xfa1EnoR2B8N3bOlQv/eU4lSO6fM8rvFTM3c1BdSStQfVKwgbHoo6qReTs/87iEd9Hu7
         nPVgOj/RoefFg8ieiXdZAyRP+g3Q7TvBBB9ITBCRYSa+nxYn+BROVXFpoeTA+OJ583YC
         Vo1OFxCyt9JBmFBl2V2ilXn5kApJFVCYONiY0PVZvzEqPTZbr/zy54KG+dOrIg22L5NQ
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060610; x=1761665410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUzpv3BxCmCZXTEwvzep7NMMR9W5hvjdg/xN1LZUEgc=;
        b=NdJbBQ9Tb6MJNfypshqX+LlDqf5P5uuyN0UC9V61S8Tg6Za9IN7K95bGuSHVUOQr1T
         1a+cLHMlTN54XpgUOzSGdYzE3t8rUdqtRB+TPwTKdS824uvSQo2JEliIJJYACIQ36sjX
         Kfs2C2Z6He+WgcaofqEBJr+4Kv+8vyi+iDGfRfp7AhP2exNEtavmwEt6fF4We2azwpBR
         XZ06S55JHxDNMX3iDjVJphKau3xzEY1JjPOqAs5j6PrJpLrbHeH0oHYgKlb7d289hgsW
         AlRz+l0btnpqYSFlqA+/dc/cpKJz6m8cfqlWHJxu/Zs7VrgBUeo5eJ2F1dx7yr9da4dT
         9wqg==
X-Forwarded-Encrypted: i=1; AJvYcCXKx4hbdat1KDG3ForjYg2fNsfD/99xLckZRmNhs55+9SdjaxjfWxTdYnROmC1DmRbP65P2ZRUz9ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWia+02HhYuTYNRLf4U088rM9mzAAXRdGYhUcwi5Bl4az3GbzT
	zNEU63mzxB1LQqDuBZM9FnHqDjWi9FkTLZR7h2EshT1BxT5Yz09jind7hdG9uVFRu+fMoDDDj9V
	YyKzq
X-Gm-Gg: ASbGncvHa1xVfSOCVPWDKKx3ppSey5EhtPlJNj6w7Mvh4cxtDQH1u2Y3HkizDgi9YnZ
	tLxkp50d40C54arFZN7jxjGJvF7zSvQyMaWNr13Qb+fbgGzZkSHOjTbumiTy/sRX8JVxDRYuMNI
	32bWihdqVJenuay3ZWQxTC/cKxfG8Pbr5Ukm40pfVSxvYvtFQ08MY43aAakFGid5MpwGIWCZXCe
	8iKvtkoJ8P9XmPTuSS0Fq5Q2JXP3KV+UppZbhgiUfX6rlrdUm7O48iLHElvSX6UhuOmmAODpf5M
	V/6FV9y0iKqhWfwGPeLByKaSYoetL4fB9ahQ1pKj66GxjpQ3JhZsiv/JR0FLakbEOB++9nJ2hWL
	SvlNFXh4aEX/eF+l1WqNTsuF100OBF9COJWealeZ5VOjILUv8HpM+RV8btV8+EcNiEtDRlWfA35
	Itu9uSabLecc98SbbHx+c6UX1xr/1qnf1JZSfoibgHAyXmNSVcAyelpuRaQV/ykg==
X-Google-Smtp-Source: AGHT+IEim2CjHliqYoMEOMTWDO0It2YWhRo5Hd6rRP9ZaNHU+yYpEMyFy+mtqvif/6C2qsaOD7Nwjg==
X-Received: by 2002:a17:907:94c1:b0:b50:a389:7ab0 with SMTP id a640c23a62f3a-b6471d45a81mr2179399666b.4.1761060609920;
        Tue, 21 Oct 2025 08:30:09 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab54desm9802102a12.13.2025.10.21.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:30:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] PCI: of: Downgrade error message on missing of_root node
Date: Tue, 21 Oct 2025 17:32:19 +0200
Message-ID: <20251021153219.9665-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
is generated if no 'of_root' node is defined.

On DT-based systems, this cannot happen as a root DT node is
always present. On ACPI-based systems, this is not a true error
because a DT is not used.

Downgrade the pr_err() to pr_info().

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..034486593210 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		pr_info("of_root node is NULL, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


