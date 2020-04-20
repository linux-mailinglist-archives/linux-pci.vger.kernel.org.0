Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF491B0AF6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDTMwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728862AbgDTMwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 08:52:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A5FC061A0C
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 05:52:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so4996803pgc.8
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MAn7hGAHod1EC34/XC7X7Tj9BVqJ/NY2c4VQxrVpxx4=;
        b=daZG3iGdMhlZvCUWmVEiIQPAN6UZg2Qus2SFPnwoIfmc+BBFV+I59x3aN+XR7ZiuyC
         uVXuH2J9d+6o0kUUSx8a9Fdfu9mELZ1pGfqiIvWfctQ+k5DHIayt/Hd80VX4oncWf0bi
         7OaYA5rsFeBrcH6cYzSoDQ6FF/+spn5pBNcl4jIiNGjKfg7m3Ff0uD+C5jJ6OLan+EOz
         B2SqolzEi0REFw2DdkMkTWW5ehMOY7IrcX6L4V0TUI4K0EWQsB0RST5N65TFiGKS709h
         /5e05xO/i659emkH97AbLRoYSf2/P9AjtfM8ZgTzmVMmgE4nyasT6XiPHuz/nQ9rml6k
         cWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MAn7hGAHod1EC34/XC7X7Tj9BVqJ/NY2c4VQxrVpxx4=;
        b=aUNpOS1xBZnCs4xGvsbC9Tt4zu8IkwxivjFd/dJgT1UnvTrFci0IGAHm+ImpZt6Fh8
         Lhux32nb0lRQlhz0XUavDIvrqhYZ0qcGv4pbOqTlstAy8X9jZzf7VjJROZbIt2+eMUYv
         UuRZbePAfWY7ejDnpc1G9g2x5joW2DPDrvW3ygU08F6iwEPmDp231lJRkMDTrjrnu6zr
         48Rpu+VsJjhW9BYxJ7Zr/52x5beimj7uTD9/JYEFrTp1vUD6s5WjcseE5/3msCWhC8dX
         UDmWt+aUJm75mMyFho5kKN1jbspnH39dVnXLRY44OJ7H0OZyaGytQOJB2ChsWLKOu4Qq
         vFvQ==
X-Gm-Message-State: AGi0PuZPzUb4xOV8TElArFW05KIu88Of0E954G71N2RUyXhAnH8RbpRM
        etC3pB23hnMiGd85Pv1PS4xc1A==
X-Google-Smtp-Source: APiQypKjGYhisQKGfpwiryIzO08I2KAUmHs+YFxoaLHHjdOFdkb5X2HMDeQGuuuJMPwGpaWq1ouRpA==
X-Received: by 2002:a62:83c3:: with SMTP id h186mr5992058pfe.192.1587387136218;
        Mon, 20 Apr 2020 05:52:16 -0700 (PDT)
Received: from localhost.localdomain ([203.163.233.7])
        by smtp.gmail.com with ESMTPSA id z7sm1052038pff.47.2020.04.20.05.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 05:52:15 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     ani@anirban.org, Ani Sinha <ani@anisinha.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: remove unused EMI() macro
Date:   Mon, 20 Apr 2020 18:21:41 +0530
Message-Id: <1587387114-38475-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

EMI() macro seems to be unused. So removing it. Thanks
Mika Westerberg <mika.westerberg@linux.intel.com> for
pointing it out.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 drivers/pci/hotplug/pciehp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 5747967..4fd200d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -148,7 +148,6 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
-- 
2.7.4

