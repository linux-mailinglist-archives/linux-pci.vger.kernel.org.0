Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6FD27F4CC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgI3WGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:06:11 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54099 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730470AbgI3WGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 18:06:11 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 18:06:10 EDT
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 6332CFA8;
        Wed, 30 Sep 2020 17:58:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=/xGcW+2xAAEsf/UaEloN+2L6gVCe1zrPoKRx2oQPxk8=; b=obg8P
        sTD4cEaJF/WeqYFoFH5ceVw1F2SukZeG1AtgtaB29wUUzG84cqyG8wU7eagagsD2
        uQ0UL2XohXn4LnLIhMdvpQkbhQR9ux992wLeDmhNmTi1aPCp7nk669BwYiQvz6su
        SpB9uwLZqJ4W1Few4MupkzvJDm6SONjotSXyWgm17VIySDsUt0o0yfh2YRTMWVrB
        TT320xRSZYJUk4mXR5P0wsW9BnZZ8tZYBkpTU9mW0H+T19xT2HXXdpo1quY7cKFD
        +MEfyvA+AOxcTafDutl5Om06FEqgVxFKP9mrKw4wZj1vi+ekElhVW8a31Ec++y3d
        UmUF5Vv/ySXCaBg4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/xGcW+2xAAEsf/UaEloN+2L6gVCe1zrPoKRx2oQPxk8=; b=t5/QPJIi
        eWPAhsxdFoMd178j9GIjuhsnF5IHegtY3EEiYf6SYjq/tlasZ+gvod/Lw5/91fVF
        pBEMjmEH/eZdUWaJqsHNn0qazwBvBWukWYmep46aoJ8bp+dY7RqL4PiBT6rMOEnV
        U/eD5y5ZY97F5mZlxMijyNaT6v4yToxO1WmDETEO8SQ76sZXn3dW3aut9+JKBJX2
        jAsn5A+eQdosxaq39zv8Xzba0K6AnKVJ06sAMPp8/B2wmO2R1RaZzpIOc5wkFmRX
        B3e3hkvxaMf4C34dEy1pOoqazdQJXp47m5cCQOqEX8NS5EJSvxSPBRs+lGVi/DM/
        dcu6fOQzXsdYLw==
X-ME-Sender: <xms:jP90X6HhbIHIxWoLLYEitb9qoTjiFt7oVI6xouProFFjqBoIm6axGA>
    <xme:jP90X7XTdNT5XmweJKIswdTWRLlGjjeFDlQ1eoostjJkBlfqZLO7CPdDpdpYt_eUG
    xaaYaDMJjvngCUx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrghnucgg
    ucfmvghllhgvhicuoehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorh
    hgqeenucggtffrrghtthgvrhhnpeehkeffteeiudeiffelkeelvefftdelhfeitdeigeff
    leeufedvgfegvdefvedtteenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:jP90X0IaL4SSnS3BB7RqlwfwgeNFHj-MCnfY9a2mZEcafgVW0JAnoA>
    <xmx:jP90X0HmYE_0zM-VNdBClVy8lr0DtA03m9xBwNmEjvN-cQV2NgXdcw>
    <xmx:jP90XwU0ULk2pHo0zpdJ4sB6yB1Rkr15izmbu-fn8CuEyhAsrgAxqw>
    <xmx:jf90X0oXwcu4y8JrV53hSFUKLUnslfTgczV-rXRne3twEy3AH5IZ-vWj_RE>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B4B13280059;
        Wed, 30 Sep 2020 17:58:35 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@google.com>
Subject: [PATCH v7 04/13] PCI/ERR: Rename reset_link() to reset_subordinate_device()
Date:   Wed, 30 Sep 2020 14:58:11 -0700
Message-Id: <20200930215820.1113353-5-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

reset_link() appears to be misnamed. The point is to really
reset any devices below a given bridge. So rename it to
reset_subordinate_devices() to make it clear that we are
passing a bridge with the intent to reset the devices below it.

Suggested-by: Bjorn Helgaas <helgaas@google.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pci.h      | 2 +-
 drivers/pci/pcie/err.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 88e27a98def5..efea170805fa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -574,7 +574,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..950612342f1c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,7 +148,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -165,9 +165,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
+		status = reset_subordinate_device(dev);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
+			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-- 
2.28.0

