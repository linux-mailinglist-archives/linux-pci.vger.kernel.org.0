Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89421D6AF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgGMNWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbgGMNWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F3C061755;
        Mon, 13 Jul 2020 06:22:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so17135306ejq.6;
        Mon, 13 Jul 2020 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbRPI5T6+CQlcjE3Ve13l43uBQozAmlKN702iYI4+CA=;
        b=oDiXLMMy3B0TEHpeLRAA8vNGcLzfduiAQ+QAJdNsEevV2wQyULi7h1rsVLBU0QBd8y
         4LjXS26jKI0uEsMZ3UdV/cg+efVFpxA8EO0JRJtvjwrfx9wDZNmSEAkJedi2rmcmkC6H
         IrZ0p9UJ3D8udE+6aKJUN/HcHK/A5s+unm9YnDwz/kgjWAY0+6+vxGd4t9UQUf2g0TmK
         gP/D4CB0DB+UwLz0Pn0O0iHxIM6U8KNLOmW6Kt5dW5DyPHBZqcrUWBZRRCIMAcxoUPBb
         CaIinXEHJ1jIAy4Z+NwSNDbb1xsx4djmFhPfF2P68dm1y6syHOuz+H/xwyqAifzy/izP
         Q7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pbRPI5T6+CQlcjE3Ve13l43uBQozAmlKN702iYI4+CA=;
        b=iWVEICT2IPrayVtBvTqdIzLZ0WWle67cp2IjvypAsbzDt6GGq+9p5A8vH6pe1KgICt
         2hMMrMUvZMEmNn07OtWWY9paIxUsZgHpd6UX3st6pIk2o4GVADkEZo07bZiWHf+tLjgh
         9jRWtSeaMSKKsMCNcZHIqLStcjzl9m/Ink5/UuCLvDoxku9uF0z7uaW/hhR76eBTNCXD
         oKKBb+H9Jil7F3J9XpYLgnKS/9Msy1nTf9qyBm9yVvN4REBT6EgSJn3OvpJ5fzn6tNoN
         TUnRzT2sHyLgzB+vEqmt79ED8RWHhvwUmKJhNaT/O1DarcvwTBrxh76FnEkwD2FXQTFn
         kRMg==
X-Gm-Message-State: AOAM533V15iEqe275HrRuFymWZzIyb6BZ3yzNnO/AkCD98vXimDWXIW6
        fmhkAboFWcVg+wdHK5vzVjc=
X-Google-Smtp-Source: ABdhPJzLFoiuIquHARFKdvDNBo7G8zRr4UNzS9o5abkca8STc4RB8fWWh2+zFSwtRcAtOf/6bGWDbA==
X-Received: by 2002:a17:906:cd19:: with SMTP id oz25mr72103030ejb.36.1594646570989;
        Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC PATCH 10/35] nvme-pci: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:22 +0200
Message-Id: <20200713122247.10985-11-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 09/35

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d426efb53f44..a04f2d0375de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
-	if (result == 0)
+	if (!result)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
 			 csts, pci_status);
-- 
2.18.2

