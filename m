Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0361F9189
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgFOIcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgFOIcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 04:32:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A19CC061A0E;
        Mon, 15 Jun 2020 01:32:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so13549304wmn.1;
        Mon, 15 Jun 2020 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=molslPGG/aVq7Tfl0f7ZnD8L5065Z3YOyyGkcmzBtPg=;
        b=mcFzzO7Pllm4E56KkbBug35zu55xy4h9QMjx4nGIEedTIsThHAkIZxHdXpzMw25o/x
         gmU8d7ik0iCbkoGpssPVodzU2ZARBf/zwQANvWVcZAYRaA5FuNqYlqCoLRVsudaSVRP8
         y9IhiJFF/IeT6/0QgacbophbcKVLQigsSZZWBac/JmDGEhX+367nM36EVtRPwGrc08Qw
         hf/ya4oLDiXmDv9aNX24WLVi+e1eNkp+jJ/KosE87xKBSIVWF3t8LEDZTJhOwcI0SK5z
         y2koNtgG18IDcfHGZdsi+UPJT1GCUdq+3eAwkv5FANQRY7UQxx1lJzl5pr0xbYau3Z2f
         xQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=molslPGG/aVq7Tfl0f7ZnD8L5065Z3YOyyGkcmzBtPg=;
        b=GZo1jq8+toD8VHVVx4vyL+JBYYjzhpKXJk1OAaqRFSecg9k+EJL/wnjnzOqqUCSft6
         b3+xl1v/yCtVsyguK9+QGkKseKfCgDwWwqZ5g60KHsai74rmRy12rRH2CFn+OaKvZB0s
         Hdzmzp/s/9GGxa3o9Ff3evD4HvJFzmyClRBNVQspPoe0LMTGpXfTzH5XrH2Jk6GLeJ+e
         oIrg27RMmtpAJyPdGxyFWL9dyj7gQb2d+5QyKK1mUokvaALWonlmt76ozy/bkS9BOk5P
         UW3JhW7Hta9geHuEy7U1ofsW7oETkboHIKrPkzJoWervZHL64KzXhXwZDQxEoFCLC3lb
         AUWA==
X-Gm-Message-State: AOAM533fH3wvx/sO7J8SrFZ4WgwxYopd400qi8wOTTc0vWG3N94o/Rg6
        nwXPsVKMHD6jTpGDS7nTdFo=
X-Google-Smtp-Source: ABdhPJxFI+cJIQtaQrIgx1Ql/SDePLvWciNxuTw06tHHD+aaiAagUpk2mRdOa+0wrERqwjqlFRpn8w==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr12602543wmi.82.1592209960130;
        Mon, 15 Jun 2020 01:32:40 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:39 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] scsi: smartpqi: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:22 +0200
Message-Id: <20200615073225.24061-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pqi_set_pcie_completion_timeout() return PCIBIOS_ error codes which were
passed on down the call heirarchy from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index cd157f11eb22..bd38c8cea56e 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7423,8 +7423,12 @@ static int pqi_ctrl_init_resume(struct pqi_ctrl_info *ctrl_info)
 static inline int pqi_set_pcie_completion_timeout(struct pci_dev *pci_dev,
 	u16 timeout)
 {
-	return pcie_capability_clear_and_set_word(pci_dev, PCI_EXP_DEVCTL2,
+	int rc;
+
+	rc = pcie_capability_clear_and_set_word(pci_dev, PCI_EXP_DEVCTL2,
 		PCI_EXP_DEVCTL2_COMP_TIMEOUT, timeout);
+
+	return pcibios_err_to_errno(rc);
 }
 
 static int pqi_pci_init(struct pqi_ctrl_info *ctrl_info)
-- 
2.18.2

