Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF142F606
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhJOOsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhJOOsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBAC061570;
        Fri, 15 Oct 2021 07:46:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l6so6526298plh.9;
        Fri, 15 Oct 2021 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZJX9CbLMezPavdAEsrkOsiHPTmHr09QIspE6IFIFVc=;
        b=iXTG7MgruvfoISzQMeRGbBt2ad6/7BSmR4i1c1wy+VVD8k+y+QFQjDpVRGodJJARaB
         rDa5mBuKvLkuaNAjwKzsRKp/jZ9BQCX3vfmu9UO49PwTu4nE3j4cv9boiPNIZnNf4FM5
         JcLFF7SwagmeuTdanyYGIqRaR5J9yFyDF8fwB7mDdZ+lR8jk08ccNse8poo8n/XK5kvH
         Sa7wc7IhrlhwJhRdzMn6SvMGIAwfg27LrzHpI49DK2knMHVg0AMavrixa5bAsmrGNK4+
         4DVqk+mlk721j7YqlN/+l94CASLZG3nsHLorK+dwEOjBIMBiQjsge9pJxrpovAzXUhdM
         Az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZJX9CbLMezPavdAEsrkOsiHPTmHr09QIspE6IFIFVc=;
        b=67iIKZIKHNUycfYWKtwdsZyi1JtCOBE9hQne2F1THNH+sDb6AFoi/NpRtwPffyGEGR
         XzMbhgYHka+KTr03uVpCLgameHn+vkgiWRtMaLJIFutYz5EWurkS9InjZRlUQCdEJHFw
         eXTWAAE4DQ4RtjR2CBGHPfH69tOBTxVEz7m6HjblsXAI6PG9BVqpp9qcqB/4WfkUqRTh
         lFSlK69pGyjNP4mzb4NE2yOeK9fNFUppptdnU/kzWZUi+sd1MHojDPEpPR2TT2dh4Fmx
         GUzm3dKDsTZFLb93J6V2nMNyFAW3PcfoCVxQwWvCVBtt3MF9iCAG806311m3CjSz0qFK
         InNw==
X-Gm-Message-State: AOAM530VMeWZ3rTAJlNn7QBYoSEn6REo833gnSQBDYM+lX0Y9XusKhcN
        0x357Z1aSwZuIgS2VEqLdVw=
X-Google-Smtp-Source: ABdhPJzd2mU9TMFIg5GGMN/W6stxEp3fblwUqADMrcyM6e2uYsbW/4c/MWtkdNzq2Zv0qomNn3Tv0A==
X-Received: by 2002:a17:902:6544:b0:13e:dd16:bd5b with SMTP id d4-20020a170902654400b0013edd16bd5bmr11591581pln.61.1634309160465;
        Fri, 15 Oct 2021 07:46:00 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:00 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 17/24] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:08:58 +0530
Message-Id: <0da4dfe7642bf89d954c7062a40566bf28d94da1.1634306198.git.naveennaidu479@gmail.com>
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

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a5987e52700e..db81bc4cfe8c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 		int ret;
 
 		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
-		if (ret || vmlock == ~0)
+		if (ret || RESPONSE_IS_PCI_ERROR(&vmlock))
 			return -ENODEV;
 
 		if (MB2_SHADOW_EN(vmlock)) {
-- 
2.25.1

