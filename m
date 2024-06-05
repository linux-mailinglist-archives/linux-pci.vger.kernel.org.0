Return-Path: <linux-pci+bounces-8370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D58FD902
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 23:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAFD1C2599D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DB15F3ED;
	Wed,  5 Jun 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klG6AWkd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9619642A;
	Wed,  5 Jun 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622643; cv=none; b=jvs/mLrmoWMCA1eM1Jzat/uYPraM/Pdcmi78n7Mv/oKj0LaawsWWjbUpMJvPs/bR3JMMhLj3lBo34TKti8Zg9ynyZ8QuemQJ05Bm68N1pPtW79syOStO4AtCFMRWegN1QG9Sl3KeDY0IfkRI0GQL36GhgNDKD+GgmtfeT9fMmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622643; c=relaxed/simple;
	bh=k0wEMVV2/kLderbs/W+38MVdsxNr9aKZ33ehYv423y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzrB0Rgd+L6WqfKjw9b+YAUnikNnHq30jWrx/7K8lwbRvwADtPs2RXazm3rRkW4jJzjRMcKeIRt8KLA2B1P4TB9MVKh1/9LIQy6c2WPe2ks6VZJ6VcC5wYoHrzfNEunJA76xQo1h0NgRSg0T7q9zYLbi/ZpQRruiSSc/PXOJLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klG6AWkd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c53a315c6eso189599a12.3;
        Wed, 05 Jun 2024 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717622641; x=1718227441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEnxTETK0rFGl7veDAfyPrBbDGYeHk9u0SUVvr1yaQk=;
        b=klG6AWkdgNg0TZtXd/cVuaKUMaKmOy/qHLs+DF/pEQ1sZ1p73ATbtpLsEvx1mJzx2A
         ymkHqGXXAz7Yd1Qd3edEm3TMF9cYsbKllYZOyEfVXrx+e3zOf0ZdSiJ5Gw8IHKz7k+gP
         V/R5CTx1QudVFY+PpqiJZQprytQSVyTsympDSHhlb+w8NFB7Qiyxh6SWiwyxd/Vx2UrW
         trvcY6UClJrfj7TgUL79X3aq5AS+jgHdy1a4+ph2DeZOUk1ufr68bxMeqMARyf2VqiQH
         1pE3AN5nKiOE2N2JXv538WXRrH1zLVp4WLsbE9BOxvWnOJaHtK6MNBL1h8R20miANkHz
         T20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622641; x=1718227441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEnxTETK0rFGl7veDAfyPrBbDGYeHk9u0SUVvr1yaQk=;
        b=vV0gyMNMuohioFiUukgX0W/q/q/4zMR27CYRctBTL7sM3u86g9q7VcV1gXYWWG9yaM
         nt4R6vZpw3pkZalRF/Y0EawAhb3UL9Yy+3x/a4N2rlPAHcdl5xHm3ErR7c3vwZdYaeLX
         a5dlE3anbGesB8k0VKfcwOP0PzqMVPweO0vzR2eENySINeQkkCeJPg/V7RupPNrsSb52
         6rUxqeQ89vsgyoXS0D2tgpv2NFMbnwM56yuGcu9w0MVP49D5L73jTUUAsfXwZUYzoJkF
         JaQDsjZffIQhVRYwgQaGqJtMpj03sxGT0nKkTc/wScH2uj1vhBpjX7CzWgwwmTfsGdo4
         yLvg==
X-Forwarded-Encrypted: i=1; AJvYcCUeh6x3MnnPAI5H/Ydum76VQIN6wAYHiNAB15heWLemyrDKtXsD9ird6lYo2PFuZmb8SOaD0KCdCPrE6tnYr7MQVu5Z0uu4RepF0n4EHOUKOpM5KX9DLp8PXTAV25skp/faE1fuNs+2
X-Gm-Message-State: AOJu0YxZYx5jNZFt/LjNqaA0djnBJfztAx5VtHyJNs/H8JN6HyztxElH
	MfwIu3I0zH+AG8FBEYsgin7C4tj42upaXvs8gSzRk5j9/AoFTr9C
X-Google-Smtp-Source: AGHT+IGrDuL4Tcy+8N1pC0DV9Wv9hU8i5ICvU98GSp0M8sQB57y48/AYA2i9L35BYMcG2jlrVaDxqQ==
X-Received: by 2002:a17:90b:391:b0:2c1:9e9d:b9b5 with SMTP id 98e67ed59e1d1-2c27db15708mr3898081a91.15.1717622639960;
        Wed, 05 Jun 2024 14:23:59 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c3884f8sm29370a91.37.2024.06.05.14.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:23:59 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: jain.abhinav177@gmail.com
Cc: bhelgaas@google.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] PCI/AER: Print error message as per the TODO
Date: Wed,  5 Jun 2024 21:23:44 +0000
Message-Id: <20240605212344.21808-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415161055.8316-1-jain.abhinav177@gmail.com>
References: <20240415161055.8316-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the add device error in find_device_iter()

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

PATCH v1 link : https://lore.kernel.org/all/20240415161055.8316-1-jain.abhinav177@gmail.com/

Changes since v1:
 - Replaced pr_err() with pr_notice()
 - Removed unncessary whitespaces
---
 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0e1ad2998116..8b820a74dd6b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -885,8 +885,8 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 		/* List this device */
 		if (add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
-			pr_err("find_device_iter: Cannot handle more devices.
-					Stopping iteration");
+			pr_notice("%s: Cannot handle more devices - iteration stopped\n",
+					__func__);
 			return 1;
 		}
 
-- 
2.34.1


