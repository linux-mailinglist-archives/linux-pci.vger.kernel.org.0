Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E33377506
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 05:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhEIDDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 May 2021 23:03:44 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33344 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhEIDDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 May 2021 23:03:43 -0400
Received: by mail-ej1-f43.google.com with SMTP id t4so19553572ejo.0
        for <linux-pci@vger.kernel.org>; Sat, 08 May 2021 20:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJOjijgk4IIde4x2cOOwzYi7D7pxj+XF0cy1ZctLDUg=;
        b=Y50uQnGOE1SRcalzHK+3AaUzavkyGLdI+Z1OqDjNOqDyALPm2EhY99POF1tYSV9X0R
         Df7CS8GlO1qVo2zgDUa9R8maG0IlQ2Dkk959aRr0Wih6oBLQW+THEjuJDDsmR+JKQk45
         bBiVDV2Y7GMYpCzPyPVhULgBikiqcB1t0IyiQlpaKWpF8SsnG9P+JfMWYXu7dClcUz7m
         RcPrKo4LEA57L6eXS42V5dCvjEjQ2bjPXk8xLhQI7DRPCkZeEK7+JzkqoXQZKcc5+Bfv
         4GaLdFq9WZ09OXHcpl0rGEfq7Faeeb+mldOV6GJ2OL2vy3zG2YRA3YqtXd23YEpGYVWx
         IrDw==
X-Gm-Message-State: AOAM5334aAlMRvxAXoHkB3WMYj7OY6qq4VdqUqax8V7TbYKxGg1bP75J
        ARBvrsq4DUemkMQ4jzx5BdXUR020clE=
X-Google-Smtp-Source: ABdhPJyrzOZwSeq+Kc7fjW/GMQ54KZVTiLbFbu514HhLjwxgWROu9SLwKdeKgFDc7e1xKGk7IQCDgg==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr18435784ejc.185.1620529359637;
        Sat, 08 May 2021 20:02:39 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d15sm6157252ejj.42.2021.05.08.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 20:02:39 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: xgene: Fix a non-compliant kernel-doc
Date:   Sun,  9 May 2021 03:02:37 +0000
Message-Id: <20210509030237.368540-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct a non-compliant kernel-doc at the top of the pci-xgene.c file,
and resolve build time warning related to kernel-doc:

  drivers/pci/controller/pci-xgene.c:27: warning: expecting prototype for APM X(). Prototype was for PCIECORE_CTLANDSTATUS() instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 7f503dd4ff81..8dc5140dd80d 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * APM X-Gene PCIe Driver
  *
  * Copyright (c) 2014 Applied Micro Circuits Corporation.
-- 
2.31.1

