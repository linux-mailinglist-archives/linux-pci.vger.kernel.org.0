Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0F42F621
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhJOOst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbhJOOso (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7282C061767;
        Fri, 15 Oct 2021 07:46:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so8814972pgc.6;
        Fri, 15 Oct 2021 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F90TVLLbkkjlFTZkt/NbI81qyTfS7mybpJeR5bN32UQ=;
        b=l5ELkb75e7o0WqRg7nGZ9P1QoeNbxsEGVGFrefZQ/ppVbqiJYC1+5+OpX+KkPqFvDw
         aLGb7yL88woVFnJUuNdXLXM7/DxVZSEr3pByuWd9EGz3SqrwAmcg4h7rmKL/gbbcU0zp
         uoZZHfztxBoQquCz1RWFxPrkPirdb0uzbp761KgtQfLB2JNySaD7mQrZb/q63HLuptZQ
         JhXsY4Ao8rLTq8UORVBZmUs3ULDA+EZXHAvFjKbAho7UaV76oaiIW+HqibjGA/wtr5hc
         xcrfviYyAtIJbjobyVBkN/6OhUP05e6UwqOO42UDz+MHh8hLguqcHg/lLcyMMeEG6cOM
         LZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F90TVLLbkkjlFTZkt/NbI81qyTfS7mybpJeR5bN32UQ=;
        b=LmG/tLotS1IuNunINvyYBV7b3/ep14HjjpCHhh9qdS/jFejKHFJrwSXuX2Xmh2zRF3
         gxqCCekKSXOsygopBeMvGYWcqeraeEiasTeG5eYFxXmwUnvH26CnZG5jwI0hUJzs5Q1c
         MwUe3ksaJ/asucthZYbp9eq4iGSmIuxQ8r67Vm2urnh5BZ3IoRtSQDoX7ThvWB/VUrad
         ZYJ0EXh/QAyeK+9IEbQyFt3tN6gKFWKql8GcxY1gTY94eb5/E3N6Ld95Vjsa5p+QSOoZ
         4dAPOKpHXleEG3NR5/3U+UVE0Ds7rstH0BCzcg9Wfn5XVPonnEtxzMnwrkVNRoWymx+F
         sEig==
X-Gm-Message-State: AOAM533SojuL0VHg8E5V0oGFyCdfT6OlCPlJQ1whyVLDazEAXogj8yZp
        fIPHRULUa9W842phI8m1dXA=
X-Google-Smtp-Source: ABdhPJz6U9ZR5U059i2Q3FPT+1FmSwYKHMAJz8o9+XAViweLN28SbAcTm8y742+h3/UXopkv6XeChw==
X-Received: by 2002:a63:590e:: with SMTP id n14mr9425002pgb.434.1634309197420;
        Fri, 15 Oct 2021 07:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:37 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 21/24] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:09:02 +0530
Message-Id: <dca18849c7f51d9e7944abe910548e07d9ddaced.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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

