Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F7234605
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbgGaMnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbgGaMnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:43:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BD5C061574;
        Fri, 31 Jul 2020 05:43:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so16496244ejb.4;
        Fri, 31 Jul 2020 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Ag7HqTEQtYdyspkqndjVsChgoDS9cn0cuUanYprdzE=;
        b=la4y7H95zYX+4CoEy2KWgnwHd0vnmrS28bchsmakne3qS/Vr/Sky6Ev/YjdhUqhr2M
         XV6t+xXPeSq67btafNbmmSQyX6H9Yjj6rqvQ4qQ10ZNZfft55b6Mu1XvNLySCyeIhlo+
         FYjF95d8mEvYs/i4achpXV9/bc03XFcBlPd3IgZ1pmjARJ4NohyI4Ci0XDdgUmxZR6fL
         FiKXofe+k246mlqbVeBqo6MOCPJ9krPxzZ63zpFAoCbdXgJzl4i9pTg+xBnSFRcz8Css
         jdo5DKuyFa+YL0IdzZjS76IB3PCVBEPaTgDrC7DSGknO1gOfOpC1534vpFnEVCQUWdy4
         6Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Ag7HqTEQtYdyspkqndjVsChgoDS9cn0cuUanYprdzE=;
        b=Ci/q+m69qxcdsGJvjMfpAb5TfYUS3KfToYuVDeTwJS09x/acxSp+S/PLPWHInpb6S7
         9NzxR9ql6D4rOIDnfckQ3DUBafMEzOf0HvELmZjBkKMGk9wi5tdnnEAPG0cS1eQPxVRV
         NP0r8OXsSnmpaFBe2fSd/VhL6TYUvwqxLLQy7nA8epIV/LaTyz+Y35nmSXRmUNtX3qZs
         zYXBm4jaFFi0yFn4aMl7zlYRVZCc2bMZ/6+wqku1WJDUSc/F0+/YDQn9P1/gksBcDEgn
         62RoMqmkAx/ceznwVLpeB/RM1br/j1aukh5Vcx3/sn7z4SjTMzKbsXHCKCGB+JBHa9eW
         JBUA==
X-Gm-Message-State: AOAM5331jgCvN1EkiyMjWxB8e7HnjLxuULt3XXSna9aHwLq2oUntU3tw
        975H0osahlvoeGvvbyumNaA=
X-Google-Smtp-Source: ABdhPJxazhT1zvPbkIt354Q4EdFJPin4xMuEu5PAgWug8jOv4Gl1YG1P2lHcWL7ADSCeylA9M/RQ7Q==
X-Received: by 2002:a17:906:7855:: with SMTP id p21mr3869401ejm.492.1596199391572;
        Fri, 31 Jul 2020 05:43:11 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id g23sm8668514ejb.24.2020.07.31.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:43:11 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] PCI/AER: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:43:27 +0200
Message-Id: <20200731114329.100848-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731114329.100848-1-refactormyself@gmail.com>
References: <20200731114329.100848-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_*() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set
to ~0 on failure. This would introduce a bug because
(x & x) == (~0 & x).

Since ~0 is an invalid value in here,

Add extra check for ~0 to the if condition to confirm failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..dbeabc370efc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -829,7 +829,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 
 	/* Check if AER is enabled */
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
-	if (!(reg16 & PCI_EXP_AER_FLAGS))
+	if ((reg16 == (u16)~0) || !(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
 	if (!aer)
-- 
2.18.4

