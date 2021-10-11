Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A942963A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJKSCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhJKSC3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:02:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB14C061570;
        Mon, 11 Oct 2021 11:00:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa4so13126182pjb.2;
        Mon, 11 Oct 2021 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06w4bvyU3F5XYJfjaevgNf8iCsWjF2RGPbd38EHlRsE=;
        b=ewhaVOVE3Ut21et20HX9bpL1dBjGMy3f7hQ3DwpDRkqgOicXp9ZoVxk63UAjCISdVW
         uINmSYUK71oj9tD88th+1BNaOBErxbqvn5DP/5bAqBzvn3VWHBc+MKR3O5UiFcLJdCu0
         DU1VAnPejnU7bKuvSjzVXqnFJ6IMlao+lMvDCQjNNeI/6SXeKq1q4ZEAeOwSfCH+ROtQ
         YmrDcj6Yrmf6VbDXgVIK8X1m0UW4IShYFugP69VsnQCseLJbF47XzeFw60v74kjRYyow
         Xs46ZyAezSIRbYtUQX/OqWuxzXQaE0aE7UTivfDSFVg/83QmMLk65cgoVWopJsZfN1BG
         DnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06w4bvyU3F5XYJfjaevgNf8iCsWjF2RGPbd38EHlRsE=;
        b=4KT0uFbQw4aYzsA2Xya4xrtLuxqXQrbeyA2fTUe7cRpMBEc819eK9N6LbaLYQ8f7Cc
         aEXxPSZNep/hnEUCjuFyvEgNN2sAVGYnMAx6niSNd27UsONSyS678y8VcsYlaQFg7zC7
         5JRazkf/djgQrP0IkudeuFPv8q+yWd+MR8vyLWSSvOJvJ0Mz5+U+JfCGUjXX2lEynIfZ
         1pIFSkN6HQKk2FAnDVnDxSEnWQgxMh0tSZqchWT9DFqyOQ7tXiEdayOobrbQ+TE4jCKG
         7baDd6sBjOXI8widGXpPdCXCzk6RfH2hy4eceMHBwZb65LihdF9HUPEVPwkPmBT+jbzQ
         Ck6Q==
X-Gm-Message-State: AOAM530obtSGznEpWbyKco+2wu1Z/Zrin47omMKHSI1vfBkHvG3VQM+E
        kuDOqvWCZplTHCYhe4+/tgfGOLV30qIILpNt
X-Google-Smtp-Source: ABdhPJybbROwc8U2D4nQvCa26A3RsTPnBtm/nbkH8KGQfx9cS7rugKMW4c3owdWnQGYvQo+LoFV9ew==
X-Received: by 2002:a17:90a:5894:: with SMTP id j20mr527868pji.82.1633975228856;
        Mon, 11 Oct 2021 11:00:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id z9sm116702pji.42.2021.10.11.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:00:28 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/22] PCI: mvebu: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:30:00 +0530
Message-Id: <147d72149c4863be53b6044e8db6772c1b450bc0.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..51d61194a31a 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -654,7 +654,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -664,7 +664,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 						 size, val);
 
 	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

