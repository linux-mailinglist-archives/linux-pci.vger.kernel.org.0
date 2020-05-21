Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBCB1DD7E5
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgEUUEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 16:04:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35989 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUUEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 16:04:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id b91so7594434edf.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 13:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJDZCN11nW4faaKrKpnSbEKCbIkin/mvv1AMsJiki+E=;
        b=baVD7t2sF/SUr6z+GW3QMjyiVf5HUqAy5fiAgCPZOwV+9wD15W1aIaSmPUcH6Hqqw/
         jm6wLdSK+NCmDoBD0t9wifO4TK5a21TJwUGZxbM5HROSXItQCeFPxetNmDed2TOYPW2L
         h1w9MOAVVq/7ONyjmYJ3Ujf1KG3DdStMzJ20zi6vS3S2iAGY+ZcQk5dxp+nSY50H/Dwe
         SBqCnaUnTTh5d+FuwXFamarJ4kixYQrAaOz+OJPyP4lsAAW9aNTzigujW14A/afEEBFh
         MTs8GW1no+oXM2r1DwL/5pSrJT933j8lg+JMPVGSUvEhiMZ1URCm57J2xucpg8q8E6nj
         v82Q==
X-Gm-Message-State: AOAM533daIoKj7ytVSklOU+kJEUsFGCeu1rd8ONpjHPvc0JyBj5ERLgJ
        4KuGrQbrKEvPFvQ99Osp4E8g8IBEtDI=
X-Google-Smtp-Source: ABdhPJzmd9IWOoXBtjKW1Maictvz4K6n9TUUsZvbPqYBoiE5v1KOcuiQ5VnuQmjQ7tdVjrEJFwELnw==
X-Received: by 2002:a05:6402:348:: with SMTP id r8mr377230edw.130.1590091483013;
        Thu, 21 May 2020 13:04:43 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h25sm5845637ejx.7.2020.05.21.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 13:04:40 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/switchtec: Correct bool variable type assignment
Date:   Thu, 21 May 2020 20:04:39 +0000
Message-Id: <20200521200439.1076672-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use true instead of 1 in the assignment as the variable use_dma_mrpc is
of a bool type.  Also, resolve the following Coccinelle warning:

  drivers/pci/switch/switchtec.c:28:12-24: WARNING: Assignment of 0/1 to
  bool variable

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e69cac84b605..850cfeb74608 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -25,7 +25,7 @@ static int max_devices = 16;
 module_param(max_devices, int, 0644);
 MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
 
-static bool use_dma_mrpc = 1;
+static bool use_dma_mrpc = true;
 module_param(use_dma_mrpc, bool, 0644);
 MODULE_PARM_DESC(use_dma_mrpc,
 		 "Enable the use of the DMA MRPC feature");
-- 
2.26.2

