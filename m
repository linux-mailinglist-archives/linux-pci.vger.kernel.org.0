Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E91F9190
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgFOIcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgFOIcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 04:32:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35817C061A0E;
        Mon, 15 Jun 2020 01:32:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so4266515wmh.4;
        Mon, 15 Jun 2020 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XDfq5bojR6b05CC1Lwj10IkyAFKBu8BIbutGTPyHRj0=;
        b=GmX+599KgK3+4CQD4ut6Unl0dQe37gJnaQMa7HXIKFLnkM36mjZce93Qnal55lQXme
         DPXNferZ2/2tadOcdmNTCDJ2fFb4JhxDbYnUVRlKL8lwVO9L5c+u+5XKNcLMEK6tfIt0
         QkCoHNi2Owqh2Z1Eob2bkqXIlxe1ufktC98YZwFTXudBA47isWtl0Umv8NBacCLFgSHp
         h8YK5ujbYfa1WKMnCT6t/nA3KdDJ/IpwmYI7Hh4ey8SWAv890eL1ce7gENW5nY6Ca9Aq
         bk3N+kQixJyXij2ldZTm51qFtu5ZtspA8ZS3OfDfwFsBNfO4puqm94RtgR+RhP996L+4
         ehhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XDfq5bojR6b05CC1Lwj10IkyAFKBu8BIbutGTPyHRj0=;
        b=iC+yTTzhATE0b9p7/zNxswf6q6rK0vKY/SRTaLV4u0Ztk3aMXqaCvunp45/BDy4FaY
         Z+h1w4tPnqKNMLioIjeggylQL8KDm7UmhL/DpTjV+ZedKqCskv2WsaPXSxzBSe4/oAUF
         nt/1H0I/HioUuUkpcE7Pd1PmxegjhC89sST+Srh0lK5baM9GGnyAy68Gmr5BvcB+nUz9
         X2c5bndPmp9l0Xncyxfs9wDDmtJS0HGzKU6H6IuidnDxuxkZAsTc8x8j7RXHhmklr3y7
         ds3+WqBfCi0SYY8L6JAmun6C4LrCKwzr6UuBGMZ+0Jaa7Jo/RoOnw9U9gL8XzQzh3nw3
         v2Qw==
X-Gm-Message-State: AOAM533zw9mZD22b2AiwQKzoaCIv1ARQHxfTUFMU/TAnxOZL7um5Xs40
        Qll3m44HCfoMYkFz9pMoSHU=
X-Google-Smtp-Source: ABdhPJzbGIfVEFGGh/6f5AcJQG40GJvG1GbBmlTLY3eBcSJ95HGy+b4zQLrPxNrp05rwJL+y2MMAeg==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr12783227wmg.128.1592209962974;
        Mon, 15 Jun 2020 01:32:42 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:42 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org, Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:24 +0200
Message-Id: <20200615073225.24061-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pci_disable_pcie_error_reporting() returns PCIBIOS_ error code which were
passed down the call heirarchy from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 95d480a52078..53e2ecb64c72 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -365,11 +365,15 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int rc;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
-	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+	rc = pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
+
+	return pcibios_err_to_errno(rc);
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
-- 
2.18.2

