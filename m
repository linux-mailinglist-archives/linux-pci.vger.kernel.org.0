Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F448455D86
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhKROL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhKROL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:11:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6BC061764;
        Thu, 18 Nov 2021 06:08:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y8so5353891plg.1;
        Thu, 18 Nov 2021 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0wzxd9WltV+kgpmgehfeEa35+HeAAqxQYv7He1qYUFw=;
        b=Vtge5Jzv3Q+gqha8QfyzXjXdN7qKuArxFBnAJRdzO9mfBwXwoVtuG/ZQD13QTse5J/
         rYOYd4DUndtFj+rDNHyjsYdJ4K9M1RKx6MSMRqYAugJWJki8o9nZPQre09so5YQ+9Xuu
         9hyBBZlXB2etwNVlsHZoZ7K4HmlF2rA8n8wLTr1g6fqkzttPV2rPt+X5+o6aDktNKwdJ
         5c7AfRmuou01iz6q5uNdTgefcCQLkmPzuGDY56Naz2Y09FOwg6L4S9DF6w0WQe5Xn3Km
         PkU4wKjMbkmca2bn8N2NvQ7yNgKFm8TwOUPpB7co65xNXsk4EmPSW1ANfCfFCLisX6vI
         TQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0wzxd9WltV+kgpmgehfeEa35+HeAAqxQYv7He1qYUFw=;
        b=m3HsmsEE5SeDsbfFEU41X8dZA0cPtphcUHRL9tUXD9poAwwTVV4IbADhZ4sAWaEd5z
         wjzEVQJCdphDjT6dkqAVpMqtNkJ36whp0qTQ3rPypDlird2JTR+6MAV/rrzwBOTvvuT8
         0Hc736rlj/rbFgiDXUJMawqhjvXT7MxDk8V2zT92sO7HDrA4cXIpED4AAzn/u8Wkgs8S
         CjXF6S3vqWXKfw/lGhxcYKCOrG5i6kHFv9apbq40fTaRul+MJf4eKiAaL+PP4c7J/3OP
         8GSBd2+/2TItd6HK5E4AUr0D/xbNyEeH8Glog2I/O3MK3OdUj5ZETbUIvwllASr6Jo+q
         g+qA==
X-Gm-Message-State: AOAM530vSj8Y1EH/1Qt9zgIAJl0p8islTvbPCTx4LuN2hJAzJt67PUaI
        XP7KOvwyceJyLGz+xkR4wqM=
X-Google-Smtp-Source: ABdhPJxf4xirjTfa6NfIeW2moya1k5DpgGZPxhSfUAKHoEymIOn99zlGld0PMa8NpD4v08nzP0clfg==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr10603930pji.95.1637244535782;
        Thu, 18 Nov 2021 06:08:55 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:08:55 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v4 17/25] PCI: vmd: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:27 +0530
Message-Id: <ed01cad87a2e35f3865275b5fb34290817a1ebf8.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_POSSIBLE_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d4..515d05605204 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -541,7 +541,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 		int ret;
 
 		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
-		if (ret || vmlock == ~0)
+		if (ret || PCI_POSSIBLE_ERROR(vmlock))
 			return -ENODEV;
 
 		if (MB2_SHADOW_EN(vmlock)) {
-- 
2.25.1

