Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388621D700
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgGMNZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbgGMNWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAAFC061755;
        Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so13645166edb.11;
        Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3p7ZQxDsqAw6bxRKCsTTKpFTwnHOWTrmwbcNce8gSD0=;
        b=kC1a/6Y3ti+3Edy+d+cQbMBh/qldnRPwLHoSl2H23Cjje6H3rWM5692t38HrMqgY5A
         p1s+PqqNo+5RJ1dsUaLO/o5atjQ5iwPsNylHtq4N71vpa7Ravr+SjTHFmCGF2RNGVtz1
         8grrGtS5fONExEzjvRwgkpnWiQSkXOqP+gu6uFJCY9CpTcNWRqKPPF4WQFX33thviMtu
         ZgQF1sl7N4Ol14HkF07patZboGe159hLEnRA8+C4BSQbknyJ9Wvo1B5TgHzQwmrrY4ka
         Ykaw7YcDuIa/pxfpmu3FfVjiWooxaEDWeaIztQdb2ec4JMk0kXnxi/RG1NJQ7mTJx21I
         a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3p7ZQxDsqAw6bxRKCsTTKpFTwnHOWTrmwbcNce8gSD0=;
        b=e75KQmWWzHc597ZaNYtmqaZzM0r6IpAwVs0rvLm/6oQtUFNh17CGBV+mtenl+7uaT+
         FU42+MuXd94xWutmsV6RFV8cN3VhQ4YeLTlIe8OvOIX+YxPcpZQdJpUxifi5BG3cp0DO
         xwN991GEZzLI6kWThtiZGLD4DTE4jQilYSjXrkSYYjZRAmcp3sOyCnLkWwttTK3/M7AU
         7ED+rB37kwgyOS/8H2tM8yrAGA+H8s+JsWNWQKM2Tt/UHWe5o7vptW6CRP/5vmIvIz6o
         +P8wBZdoqSP8Zm/nSPqZyIcP+HQMsRa+5eSDB3RqZ946unEVFctbrEoZAIUlk5Wbm+xO
         yW8w==
X-Gm-Message-State: AOAM530PVx0TG9OZQb9ZesiMNrP1qGWv1QrVZB4zk1ZyYnxYm9wveYTQ
        bIvaTxc8EYne9m0mK0Hdadw=
X-Google-Smtp-Source: ABdhPJwmht5srHkaTBLjOCr2Ce2Xe22jTAEZQo7y4UlcZf5gkxKXM5zk7Ce/DGTX6LLjYHYrZk6MDw==
X-Received: by 2002:a50:ee87:: with SMTP id f7mr93706702edr.355.1594646569663;
        Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:21 +0200
Message-Id: <20200713122247.10985-10-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..d426efb53f44 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
-	if (result == PCIBIOS_SUCCESSFUL)
+	if (result == 0)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
 			 csts, pci_status);
-- 
2.18.2

