Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD821DDF2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgGMQzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgGMQzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 12:55:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9AC061755;
        Mon, 13 Jul 2020 09:55:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so14273825edr.9;
        Mon, 13 Jul 2020 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vg5seoeyahxUOJ1a2of2OSXbNHc8+N6IhRiLy4XR8Ps=;
        b=QThq7T/NhE4spupA48w9flKBPIUZMsJ+uy1wChEjqmd9cLUhJNeozt9BNv1EslTKul
         9FzUYVh1psv92TVnmY05kmXxx7YOjo4zsDzZUATn9e4zIhaa/IU/l64wBzjWvrwDbAdT
         yMVtRLi35HfG89vS3VWmX51PcL78Kumuk1a4Y+mb2X5zojZOcrMRGnHmOxMBpNMDphyn
         WM6skKGt7eauq9PMF4fMY/WlqUw991iJ1Ytz1rk4085GlJxA7KXFCo39uIxgjXQ9fuJN
         3z5H1aRueRaa67gizAbiKT/8yQ6CvE9P5qTMm1ibl2NWyp9eZcuTPcv+4+0VHPs7z+dy
         9v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vg5seoeyahxUOJ1a2of2OSXbNHc8+N6IhRiLy4XR8Ps=;
        b=p9vjV2MKRvlqajgS93jCup4a4AxeGVHwFFW7YNsz3qfg6oMFr8TqULjK49VgeYZIeV
         3zVorZouWzQyOnQbSOmxf5I2j0IcMwU6RUmToHdmkmfxBNb0K1e5qu2HJVj4ncagDN6Y
         NUn5MP72QBQ1NxMHk2p4qNLHmun/H/liXRM6WJR+VxUV/8SkS4kha7gmalUtcqIzXvyl
         pwn9oRMz0QpojhV1/zFU3M0Wz+wA9jbgom4P7FGMdTLdpSwKDCK/eICWV2+YXtdSkkhW
         ak4iOEPN8B9Pqvw7d+dNXZhGd5erxl9R3yaiPF+rmGQiuIm0zfPERr+x7zxrzA7WinL7
         5RzQ==
X-Gm-Message-State: AOAM532YEcQPprq+ll+v4y50QS9T7QBXFhDLJd7CT3QNAG960gK5QsFh
        YHT3HZcMG2dzaOCpOGn0izM=
X-Google-Smtp-Source: ABdhPJwiuJGYBhFGQzVTlihXWfzHv/j6TtpsUC2ukWbQvIDZs82x6qtdrhI4g0KTxQkpdk5UBwbo4Q==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr365600edq.160.1594659316271;
        Mon, 13 Jul 2020 09:55:16 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id w3sm11838938edq.65.2020.07.13.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:55:15 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Subject: [PATCH 12/14 v3] PCI/AER: Check the return value of pcie_capability_read_*()
Date:   Mon, 13 Jul 2020 19:55:29 +0200
Message-Id: <20200713175529.29715-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713175529.29715-1-refactormyself@gmail.com>
References: <20200713175529.29715-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..f4beb47c622c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -800,6 +800,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	int aer = dev->aer_cap;
 	u32 status, mask;
 	u16 reg16;
+	int ret;
 
 	/*
 	 * When bus id is equal to 0, it might be a bad id
@@ -828,8 +829,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 		return false;
 
 	/* Check if AER is enabled */
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
-	if (!(reg16 & PCI_EXP_AER_FLAGS))
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
+	if (ret || !(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
 	if (!aer)
-- 
2.18.2

