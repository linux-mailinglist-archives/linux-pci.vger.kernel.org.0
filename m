Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB04827F4D1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgI3WGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:06:41 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57963 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730269AbgI3WGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 18:06:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 408A0E02;
        Wed, 30 Sep 2020 18:06:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 18:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=Dl0bQCDDUwenL
        KwYEIseGLFy/a/7FZofVNps7JlV2rY=; b=MkTqjLthiqAvW2AGDy0meBMsvLUMa
        HZphneUUA+8UoyiyKSw9TUtmQfjwO1ApxjqgRcVlc+6I/NlooWYocB1O+Y5W3ua2
        rbmnhYsaY0Ad/bf/lhtiPIxk2UrCCxwUk0kmvbiOKyOX78YLU2XSyzGvqWcIhY7F
        FhFX0q5J6HdY+dJ7M4NF/z3jTv1qeiSeqpqaX1kIc2yYN6Ffno765UI3sjxpKOuq
        FU447eQ2jzchi+XUwloVKEDgMMvDuNRSIB8cQey1vNhyRWZo7+G3z0L4wdHi4Lq7
        nFk0CWBqM56Js1ShUbrUjMKpDJmFWbwf5ETZSNsr6JkpiXqSnBKyzErOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Dl0bQCDDUwenLKwYE
        IseGLFy/a/7FZofVNps7JlV2rY=; b=bJ1czuR/Vyo7fTAR+QEa7o9b8Nh7U2T8L
        CEheC2/e6airAy1X/6w+REp8vQ5/uLrtfXkCEuEns1w9dBkPqNg6k2qz8kjew8Fp
        qn8ZKz8slwH//fObH9scKASgDBRvcUeIw/22WdB3RhzJK0UEeau1aOUdBn/rWQ7a
        rafQCNwWdqEm7R8hE7NxkksUfgYDY/txIWk9qt1VAxEBBjxFF7FJiZs+epNP5SaC
        BIpySbRjRsVg4EiB7Ej6L3woG1x1VBCE5+He3XsYEuMk0YUmdJggvi30saSV9q6s
        gVeTPvgz+L4JghBrdh15hVuvj6eozWQ5bhEtbY35/35tedM05kUcw==
X-ME-Sender: <xms:bwF1X9qtjbvnBZcjBnqhrMH0-ugRSTIx_3DnMzCi8Ad2xhO5FWPVYQ>
    <xme:bwF1X_r9cr60rrElurgLDpPDp8rQHnhGm13sPvNl-DMVsJezIGHl9BWqtMvRELUV9
    WfFbGFOUOdZZZlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghvseho
    rhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepffeltdeuiefhhe
    elhfegfeehjeevgfetvefhfeehfffhueduvdduffefkeetiedunecukfhppedvgedrvddt
    rddugeekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:bwF1X6MX_UxI96efPmRj6WjZozTTkVZiqsuOyDTALDQ53mH-OLxD4g>
    <xmx:bwF1X47uJpT3zkbtGw6O6q3KJhAoLvQM4OBzauRb6sy8KiATYrBlog>
    <xmx:bwF1X87qEloXwmA9XnXOJd0x0I9U0wbVTPL7EStL5zR8YePv-pxYWA>
    <xmx:bwF1X7b63wiIakqi2lyiMDEUE005mWHWQyvXMvOSNCUlp_gVk0eUVA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 138973280059;
        Wed, 30 Sep 2020 18:06:36 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 04/13] PCI/ERR: Rename reset_link() to reset_subordinate_device()
Date:   Wed, 30 Sep 2020 15:06:30 -0700
Message-Id: <20200930220630.1113939-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
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

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
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

