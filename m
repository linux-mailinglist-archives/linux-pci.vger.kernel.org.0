Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF29F42968E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhJKSNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhJKSNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:13:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA8AC061745;
        Mon, 11 Oct 2021 11:11:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t11so11829247plq.11;
        Mon, 11 Oct 2021 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F90TVLLbkkjlFTZkt/NbI81qyTfS7mybpJeR5bN32UQ=;
        b=qB2VJ/H/xD7afUDeAVvAmQ8dpaVRwqBxT4tgjGdsz6jeAMyR8/klf2Ma2/uiMlha+I
         nwsVUpss+uaV/dGwK1/QCRO0J6MZ6xBoX3AgnXKocT/lEJMovkagO+n6WcFtCn6emFQI
         LhJ3Fdm4yuNTxWTcm2hiLqv3SjbeqlLFMLO3kAsiv/C7RuXnv5R0j9DsrxrPk44dxsjT
         gBiCbOQkAA58fXp80XIyB5K0TK2iXLnB8eVACd5Xo5OlkirRNB0OWK1kHIps7+zxAxGP
         qvTSxcwtEqKZCVSrgVG0px0H5G0hl8SS1b7NGW1uU14sZ7i4c33GSCdaJyeXr9gzDszK
         36qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F90TVLLbkkjlFTZkt/NbI81qyTfS7mybpJeR5bN32UQ=;
        b=GnRCfdJOse14QdqJ5+9SzCRYMgrW5yjVYljQcwQPj6TNDBILJQobuY1H41XHoo2Wcj
         ymEi+ZmbYmwxGrw5ZSryZqkvbmkVwNxzx1+S+16vS5T61UdFIM98NUreZN6i0rwvd+0N
         OnVjZ5UFzlboQpwjTm5kJ7LbIIYKA0ns3j03q1kiwsHob3KCH84D0HZF9KKTRX9/qbbZ
         8ZO+OB7CcgpgvoVTrWK+iug7C1+MJffw7dTUkwOg/LFYuUSgNd+JP0hTvj4jXBXWzQx/
         UTzHTyWJqNsLJiT3MfzJND1w46MT4dv53OBzxuzwICA1mxvT5T+/hRwCxJoBCr40QGgR
         RQmA==
X-Gm-Message-State: AOAM533njVaEKhRIZ57/h3rCe2nS8YYIEefrB+X0FQHozJkVa6O/mzxw
        8EIBIj5KfH8UTsMWhWfnNbFIS4nwRrUov5VU
X-Google-Smtp-Source: ABdhPJyDy1ammFivUjxkoM8cy+Vqu1CBcafx8j5nzYCWL94+TsGdVIgZMcqOppi+HdAi0Uh6WMQBFQ==
X-Received: by 2002:a17:90b:4f46:: with SMTP id pj6mr544585pjb.63.1633975881620;
        Mon, 11 Oct 2021 11:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id p3sm8398824pfb.205.2021.10.11.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:11:21 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 19/22] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:41:09 +0530
Message-Id: <e330cad6bdc0fc932a72d33b221f1b51ab55fcfe.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
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
index 1b26ca0b3701..d5274b9b06a5 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2273,7 +2273,7 @@ static u32 configure_new_device(struct controller  *ctrl, struct pci_func  *func
 		while ((function < max_functions) && (!stop_it)) {
 			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(func->device, function), 0x00, &ID);
 
-			if (ID == 0xFFFFFFFF) {
+			if (RESPONSE_IS_PCI_ERROR(&ID)) {
 				function++;
 			} else {
 				/* Setup slot structure. */
@@ -2517,7 +2517,7 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 			pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), 0x00, &ID);
 			pci_bus->number = func->bus;
 
-			if (ID != 0xFFFFFFFF) {	  /*  device present */
+			if (!RESPONSE_IS_PCI_ERROR(&ID)) {	  /*  device present */
 				/* Setup slot structure. */
 				new_slot = cpqhp_slot_create(hold_bus_node->base);
 
-- 
2.25.1

