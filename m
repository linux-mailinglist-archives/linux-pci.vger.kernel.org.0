Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAF4365A9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhJUPR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhJUPRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2010C0432C2;
        Thu, 21 Oct 2021 08:14:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s61-20020a17090a69c300b0019f663cfcd1so3398993pjj.1;
        Thu, 21 Oct 2021 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uAmo/+Cbfp5AcJgSKVevbtx0v6w8vA6EhRcrgSx5fg=;
        b=LXZvn3RqW16A3IoLUcDA/nCRjcSAPnabN2YD19JMpKVdRKs/9sY+8HO3d2IwFGtxo2
         9QSHJxf3EZ0xPuNHxrVPABkzUrVfCSdbsPtwpm8x34998mo/hpykSAYF47t1bjsgkCc4
         CJZpjudjuTHW94t6dsRQcOf+iN5ub7bkXdfqYpZ81EXyF/c+hyFhE86D64vmxepPYlqm
         oWu2TBeeNN9yBzw+mb01r3d3YUZAIbp8giEBbfQLEN47tRsn8c07whMLMpdi34cOq1ha
         GDA9ljLKc7xWt/2XJhQ44kMQjYWieT7gm0OV24H7quxrkzsHHW2UzMmwJLZjUTr+2kxC
         6E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uAmo/+Cbfp5AcJgSKVevbtx0v6w8vA6EhRcrgSx5fg=;
        b=LQ0wHGRNf/pf2bFsBj/zJLQbgY2Wc1c3H+Idt6F3lYOIjlIJAA9rKE0aZMExPd2+w/
         NRFxxeBYhnpvrK0tP8DiO9T/blBNg4LqWCSjvQsi+0rYyZnW0Orms+vrlZnS7Q5bO277
         rlny+vlStb23hr9YNSEBeSYvsx0fTeLk3B1YYPc0oZjkXrn6ZNmikCfoN1fsymT0jeSs
         jdZENJgtPPrn82QGmA2XRpD7i6J6xo7G07dciMRdu3kFSGJSj6Joa6ovJ8ubMVcW4MEr
         7fmJZ8er3uUx5k6yE/S18Kcr+wSF8cG8uPSAYGtG1KpeqedGP0hvj6R0WFucJ10zBVZS
         A5Fg==
X-Gm-Message-State: AOAM532nG9GNBPvhGPlMtPNfyszdDy0m9B84XxYFFf/DVLkJO6uW2z4b
        IBmxqfo2N3hcVtK0E3ELgso=
X-Google-Smtp-Source: ABdhPJwUspOjoseSTR2C72aM7leLQ4TG95PO4XKpJq1XHYr9Sl/grpaaahcxlWsZRGq5lqx424d8lA==
X-Received: by 2002:a17:902:6808:b0:13e:a85b:52bd with SMTP id h8-20020a170902680800b0013ea85b52bdmr5649513plk.76.1634829261404;
        Thu, 21 Oct 2021 08:14:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:14:20 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v3 21/25] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:46 +0530
Message-Id: <20dd8fb823cdb1df4a6313fd5872d78d8f0860c0.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/hotplug/cpqphp_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 1b26ca0b3701..bf14391c005f 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2273,7 +2273,7 @@ static u32 configure_new_device(struct controller  *ctrl, struct pci_func  *func
 		while ((function < max_functions) && (!stop_it)) {
 			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(func->device, function), 0x00, &ID);
 
-			if (ID == 0xFFFFFFFF) {
+			if (RESPONSE_IS_PCI_ERROR(ID)) {
 				function++;
 			} else {
 				/* Setup slot structure. */
@@ -2517,7 +2517,7 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 			pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), 0x00, &ID);
 			pci_bus->number = func->bus;
 
-			if (ID != 0xFFFFFFFF) {	  /*  device present */
+			if (!RESPONSE_IS_PCI_ERROR(ID)) {	  /*  device present */
 				/* Setup slot structure. */
 				new_slot = cpqhp_slot_create(hold_bus_node->base);
 
-- 
2.25.1

