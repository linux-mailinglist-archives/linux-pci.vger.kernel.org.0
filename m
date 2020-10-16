Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344DD28FBFB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbgJPAMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:25 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45165 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733122AbgJPAMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 36462B5D;
        Thu, 15 Oct 2020 20:12:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=cAxnkEsWgBoF+PYkFLDf0x/HkFDrF6YQd5lkuvCVn6s=; b=j3ebV
        1BiG5mIVyB+e16KHkodMxjmj7RASvsLaioyMZHMihyY1mHP9ku0q00i9mY2633vC
        Mq35fKLOoGKZ4Bxpom1kS+AJw9fZeWKbWHd49BvzIaHhxDeyqD0QWzIWcyYyf/P3
        RFXKJAQdOnOiaakC4AsA574KVfbElvbxPhJ9mqDnI4Oneljp83mVmavDtirYTES5
        d2HLxSngwWdi0bKdT0YBXm78g7XP+Dq2oLQtcb1tv6kZ2HgTqrC47BqT83lrQAMR
        Y1OG/0A8SjrkCA2/+nmO/Sw0B6Ap2Pgi2S5XNSgdZ2cjUTBWbyCNr2bUpuMgMEm3
        Klurh6BD+Prh9XawA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cAxnkEsWgBoF+PYkFLDf0x/HkFDrF6YQd5lkuvCVn6s=; b=EK7eC0ks
        nwcOMt9Q4xOQp0aY3d3oYVULoWLifO8HL70sser5SNUp5pMZGVXk5myQKMGkWMLT
        UnsBcKjAPzDxk3fzKIhqiZWLNSdUi3DPpqgyMIhl6lGtzBTIl0k++S0gKQDi5Akm
        RupwZhj0nH+7ZWADtE45WfE3/R+upO6jCg8zvzEv9C4IHUPD3kv4xkQwveOkFUl7
        a2/nxKkN4cvxH0rpgpN7fZik3OU/hy1bBqMkKtySz1wIHWrZ5oIi9gQVI/gv6ARM
        ARnHpbK2meFVBtElvRLct8Tm9273rVeCOJAg5i2HLyLkfbzNJk9U3YLLmT99n/74
        1TRVipALo3LuWw==
X-ME-Sender: <xms:ZOWIX88UNZlItB8oeljat1LKUZnMkFl_SsXDIbA2XS6gULY0PPHsYA>
    <xme:ZOWIX0vyFeUDOOS7IIaLig8cvseo3xNQLOL40amr_i4mg23wU7ZMiOoIhNYgTh_85
    FXSmfKHVz0QQGBr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:ZOWIXyDki6AE5_7Z00P686TYC_53zeMK3P00AP8r0CuGs12ZspqITw>
    <xmx:ZOWIX8dN6FxvGhU0DiEyW8jGXPXyBvt0bO6QZUAVxxIpVe9fycf57Q>
    <xmx:ZOWIXxOsgcbKSRsj6Wc9v69lgLntXqmV_LrR0S0RicwsY019edJH5Q>
    <xmx:ZOWIX0el3DICLJSHJNpYsfXW1aE1Fl1Ip7B-it_NfcDJEz72fsSONQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80708306467E;
        Thu, 15 Oct 2020 20:12:19 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 04/15] PCI/ERR: Rename reset_link() to reset_subordinates()
Date:   Thu, 15 Oct 2020 17:11:02 -0700
Message-Id: <20201016001113.2301761-5-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

reset_link() appears to be misnamed.  The point is to reset any devices
below a given bridge, so rename it to reset_subordinates() to make it clear
that we are passing a bridge with the intent to reset the devices below it.

[bhelgaas: fix reset_subordinate_device() typo, shorten name]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-5-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h      | 4 ++--
 drivers/pci/pcie/err.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index af98b7d2134b..bc2340971a50 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -573,8 +573,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+		pci_channel_state_t state,
+		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..db149c6ce4fb 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -147,8 +147,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+		pci_channel_state_t state,
+		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -165,9 +165,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
+		status = reset_subordinates(dev);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
+			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-- 
2.28.0

