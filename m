Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E90201CE8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 23:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392005AbgFSVMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbgFSVMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2020 17:12:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB8C06174E;
        Fri, 19 Jun 2020 14:12:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k11so11611844ejr.9;
        Fri, 19 Jun 2020 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jAXB2Xsp63gxSnlS62FMvrJwIMDFQQlRe+IDuUdQLNA=;
        b=LJUlLmyrCY38Ie14pWTsCoOnKkS3KYeJLzwnwoxAo+1wwCZFsn161ttF883Uvy0e83
         D/9synv4uiajMX8KVQxqkerEZSZM2ZNEayk5T0Ud4rBjD52Np9NTRe4KK8dwz5scXm3v
         /vJaPosakihWFNrjwbiuFArhoUWggc1iZX/bB9BIvOp98lasyS2l1qW22ap+axkSAn3H
         Gfa1kyKqL4kPIzI746CIWuLZsw+7HulZw1XNdU5yP7CjBIPu6wHawx3ZIKlyjLgofSFW
         bJ8GpDJdvKI8C8SEDn7YI4Ye2bbWPnPeW5LJu3gwamlpv1UJfzO7pXpiOQyryoGqZ7l1
         XGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jAXB2Xsp63gxSnlS62FMvrJwIMDFQQlRe+IDuUdQLNA=;
        b=W1sT+IhO5ZwdaR164kER04xNWgCMn5F9ExvnRlVGJWIT0lULF6h5auxWSbIbwSnzDL
         1vdEdN2q8xJsD4woqDRqyTFnO9qYE85PEcfHnnhtfAyCMC+TWddDJZyHRshVx1YC/qnV
         lcgi60NRxD5u1VCMTAgclUJoqVZhyBDmxCF0B6SMOmRXlSlZwrZOrnVn9/b9zMrb/oZd
         Sj+L6Mz/ey4KLKDkIpPkipf3XwMCt8T8eP6yqQ+E9HSL0AOWZIc15c6ZwSx4P0Z4hjyO
         KEhZ7eaXf+rNwufb89rnbC4cjkCxqlTgTbSGa0lhhwYUGJoXqgFjpVinVfbS4kfPu/Pq
         0N6Q==
X-Gm-Message-State: AOAM533V24CjYWsrBIw3Y+Ley8xGV92Bkk7+whQHJmnpHk79z2CXcJI/
        mpokdPtmGXqvnTITbSBYvgrzEOjgNIs8VQ==
X-Google-Smtp-Source: ABdhPJycigLNBigDYpmptOX7dWHewhlOXOlZAg4gjbgh43FSAqz03bmaygW9sIlYRuHI53gyWkYHWg==
X-Received: by 2002:a17:907:40c0:: with SMTP id nu24mr5678689ejb.141.1592601123931;
        Fri, 19 Jun 2020 14:12:03 -0700 (PDT)
Received: from net.saheed (54001B7F.dsl.pool.telekom.hu. [84.0.27.127])
        by smtp.gmail.com with ESMTPSA id kt10sm5485833ejb.54.2020.06.19.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:12:03 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/PME: Fix wrong failure check on pcie_capability_read_*()
Date:   Fri, 19 Jun 2020 22:12:18 +0200
Message-Id: <20200619201219.32126-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200619201219.32126-1-refactormyself@gmail.com>
References: <20200619201219.32126-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure, pcie_capabiility_read_*() will set rtsta to 0 and not ~0.
This bug fix checks for the proper value.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 6a32970bb731..1d1d06f06335 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			break;
 
 		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
-		if (rtsta == (u32) ~0)
+		if (rtsta == (u32)0)
 			break;
 
 		if (rtsta & PCI_EXP_RTSTA_PME) {
@@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (rtsta == (u32)0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
2.18.2

