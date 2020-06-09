Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30F01F4120
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgFIQj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF9C05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so16895345edq.4
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4UkRs+ciItBFRCKai6AMkqNzOyLsaBgxRzA9ZJAA16I=;
        b=p2V20UMY6NOmucm4k/mRfRSoMYsdED10Qcd2PJFwlo/CiOHkcwwJKDaXnqI8UDidr9
         1l8UiPYci2ylNhO+QGKdZKVfD6emDrzIl001a8DtskB4Jm2rPdUjjgmZa6kL2G65NSPL
         0EA37r423ANOrvM/kkq+hWJcreewBmzmCRSjI5ZGYukX+lYL9Eh8p64ja6K9LtKkQYQC
         9J19lHEJQXw+HO/3BJABM0X3yRVRo3TesuPCuCBdV9FCl+8lB4yZjWiEs/uG9qYMjdxv
         vvFUaj5pIt0SZUkHDPIQ/VtvIQgLk6z+gTQP2w1D7oKYryEIxKqw9RvgYfwon0Cyw0Kv
         lj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4UkRs+ciItBFRCKai6AMkqNzOyLsaBgxRzA9ZJAA16I=;
        b=j+vrBeAD1vJL7lxjxnL7+Q82UY3LwyUqUgzMP/PnNQNJpDTnln9fcn9i29+vwTWUfG
         1O0PbPHKo+qFSqtvrXsx67dw4++g1v23Ef+D2RUeQA35jhits+Z8S5TatZNu5QT0clIo
         0woThv4UPCnQKTCUfWXVzH/d36ITBPAeI3NU9YVg03lv9Xhi/SpraPqNBfsWFDuG4/k5
         IETEOhhtwozGpq7uGwhf0aX4RGgNoEyxLuOsrsOsaXFU4bkhfD/QUGpPOnFMf7xLtsFc
         P9ibf0BSBlEDBQnMVWYeKVLuwajjClmTp9UbSCQmMn8GqX109o1LRtle2OAnV8/uj/cn
         qZBw==
X-Gm-Message-State: AOAM532iaUXhxTcd5albPWtViobB1ErJ7E6wEqWG5HQMDXzzqkJpV5YP
        NosdOZaccztc3zBAK6BTXU0=
X-Google-Smtp-Source: ABdhPJwdx9SSeoqXr+srw+zSu+YKlt90rRWNR6jqgdhuOHKwZa9L6v6o11Ol7bFnshX6w4uESVy8WA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr27408004eds.248.1591720792705;
        Tue, 09 Jun 2020 09:39:52 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:51 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 4/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:46 +0200
Message-Id: <20200609153950.8346-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Both pcie_set_readrq() and pcie_set_readrq() return PCIBIOS_ error codes
which were passed down the call heirarchy from pcie capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/pci/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..fa49e5f9e4d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5698,6 +5698,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
 int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
+	int ret;
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
 		return -EINVAL;
@@ -5716,8 +5717,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
-	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
+	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
+
+	return pcibios_err_to_errno(ret);
 }
 EXPORT_SYMBOL(pcie_set_readrq);
 
@@ -5748,6 +5751,7 @@ EXPORT_SYMBOL(pcie_get_mps);
 int pcie_set_mps(struct pci_dev *dev, int mps)
 {
 	u16 v;
+	int ret;
 
 	if (mps < 128 || mps > 4096 || !is_power_of_2(mps))
 		return -EINVAL;
@@ -5757,8 +5761,10 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 		return -EINVAL;
 	v <<= 5;
 
-	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
+	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
+
+	return pcibios_err_to_errno(ret);
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-- 
2.18.2

