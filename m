Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5BF1F411E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgFIQju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005CC05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so23095408ejd.8
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oSb5aBU9dyl4makhOuJApH6Ld5RMddMm66x6daHRsXU=;
        b=rxMbyhfrJzR4NSTKb2nQBdf8TAnhEJETYndTBI9kHQt+uSHwyhrsCt13jC43q7xENJ
         B8AkkyuN1Twn8NY4K/iSU1vUVvgJk4HTX/XYBKteJRbDgGylsLBzjT6UDLr64+uCJs17
         Wet8mypGGNBijToY9wOONC2DHVCqgP5UylCet5qtR/n6my+a6KpBlDTCUg5+l9/1r5oL
         RyPPhZ3Q7RSu318+jR1pOnspVLqTnTHrOJww9Y3cDpPLODEd/RPBwYEN8z7feK+seoqN
         6Mlno6FmPddT26Ox6T1Pwn5XkDpa8vFR1VLAr+ut/sbODsd5Bc12nzVd3dhmZeWux1nU
         XpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oSb5aBU9dyl4makhOuJApH6Ld5RMddMm66x6daHRsXU=;
        b=o5VOISmNo5wPDY2YH08DGWaWVcw2ggs1HlAJUc5vS2fpDfUQzSprn7HhIaNvNKkzEJ
         2O0EY8C68OaGObyM7ds3RbX3s81ERnZa+U1KRV5GPB7x+WN+D57T933Z1MV8ebCADwHt
         sm2VXqk78QauHVg1JshT/uxUR9pQnN8IPOpTBQr7NHYP6f1ZVDMRhYGcOhIskUbhQbL1
         i9/cTRdGofw3QS27YO9O1VLBn6PBTZzHOLTYykZZJprdoGFsTFWJFY1MWicszfUtLNeS
         kLNdnX0Bm46EAq9x4/dw0sNDVzPvP9Vgi5nW8u26qlu8akzoOvIuAD49co/bVBsHGpf3
         QmTQ==
X-Gm-Message-State: AOAM531nY3f+aADPupZ9QNjHXqCywJsqIgJ7VaFOruI+Pz1ramqAhs7p
        lUpqq/q6KUZ/xmpVJRjjH8M=
X-Google-Smtp-Source: ABdhPJxNrvN+qG5yWUVAVIIZze7pVvUUa8enDwmuHxuPDgrkfDj7je0MF8cVY76uEeWIwrVS8GjYOg==
X-Received: by 2002:a17:906:e247:: with SMTP id gq7mr25682979ejb.107.1591720788144;
        Tue, 09 Jun 2020 09:39:48 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:46 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 2/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:44 +0200
Message-Id: <20200609153950.8346-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pcie_speeds() returns PCIBIOS_ error codes from pcie capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 1a6268d61977..eb53781d0c6a 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -306,7 +306,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
 	ret = pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &linkcap);
 	if (ret) {
 		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB) {
-- 
2.18.2

