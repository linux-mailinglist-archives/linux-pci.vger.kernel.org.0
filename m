Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6E455D8F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhKROMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhKROMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3021C061570;
        Thu, 18 Nov 2021 06:09:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x7so5265864pjn.0;
        Thu, 18 Nov 2021 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByrJc6V6pFIbCg9CK06og+Vh8Z2tFbEYzVqTge5gTXU=;
        b=bw9D8T7VGU0U6t3XTDa+/29iZvtjMy3TORIZVvpr7GkFUUyqIWFmi9S6dH5g+nH1O2
         F29jkDXF25KJ3pDd4LEbvXxmGowfCRJmCy7cUadRVXIl7YA+uih+GK1NfybSbnT1NPs4
         ydPuWMolf3cAYXA1YGh29vxlbc/fPeeDQasBG5zKX615DEsIt1G8p1O5JkIqbjVeFm5S
         PXQR5SGfu8r3c3YjLjsQfc6uTHVh1M9veIyq+NxfhdVSx2cpciECR6F3lbASXAsrNdcv
         YHMPvGHzxWcMN/qmOeuehJtfUN7pli0CHdYuu4z3DswVzjLnnFQiEmfyiFF7OsjtBdny
         V72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByrJc6V6pFIbCg9CK06og+Vh8Z2tFbEYzVqTge5gTXU=;
        b=M/1tX1rsLLnrGDXFhCwihIRQBAlZrKlfRb8b79j2tPcJWUuWA1Bkxm2Qfd8wKKa5z0
         XdQDUt09p3wAWaOFLphTC68+zIiCz7QFd/1UboNg5LU1BtujOXqtfg8ahXRjILwk916d
         jMshA3a2bPZ93o7UPujML1druJImxgCoMPUfiPd/KDR0VXrrv4uHm5vflTGUKb5Rra/t
         dEvM/Eqq2grNWSkb//qMJ3OidMVxZWpDxLltIVAOkM/yA998k2cGSPQwF0Cd1ouwA36r
         IUF9FPY0QxpVr51t2WTPbVMunwbQHyiIeTbZxo2imXPSFmhIsBPw9ER0NI5gaq/lp93x
         VmEQ==
X-Gm-Message-State: AOAM532lh+3rTd52iHLa2h5u3ISDYLc4hAoKhdGiINkOmfGSVGnX94x5
        hfAQT7AuK5JOdLss3/bGj00=
X-Google-Smtp-Source: ABdhPJyBMJ8Ar7910Sf+u3fPK0BtqoYWwruzkyCL7U13bQSD88A+4r71N/gTt/BQQpV04BYMPTvgKg==
X-Received: by 2002:a17:902:a717:b0:142:76bc:da69 with SMTP id w23-20020a170902a71700b0014276bcda69mr67440911plq.12.1637244561252;
        Thu, 18 Nov 2021 06:09:21 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:20 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v4 21/25] PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:31 +0530
Message-Id: <b12005c0d57bb9d4c8b486724d078b7bd92f8321.1637243717.git.naveennaidu479@gmail.com>
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

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/hotplug/cpqphp_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index ed7b58eb64d2..93fd2a621822 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2273,7 +2273,7 @@ static u32 configure_new_device(struct controller  *ctrl, struct pci_func  *func
 		while ((function < max_functions) && (!stop_it)) {
 			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(func->device, function), 0x00, &ID);
 
-			if (ID == 0xFFFFFFFF) {
+			if (PCI_POSSIBLE_ERROR(ID)) {
 				function++;
 			} else {
 				/* Setup slot structure. */
@@ -2517,7 +2517,7 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 			pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), 0x00, &ID);
 			pci_bus->number = func->bus;
 
-			if (ID != 0xFFFFFFFF) {	  /*  device present */
+			if (!PCI_POSSIBLE_ERROR(ID)) {	  /*  device present */
 				/* Setup slot structure. */
 				new_slot = cpqhp_slot_create(hold_bus_node->base);
 
-- 
2.25.1

