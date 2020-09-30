Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C827F4E0
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgI3WLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:11:17 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:50213 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgI3WLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 18:11:17 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 368A7A5C;
        Wed, 30 Sep 2020 18:03:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 18:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=/xGcW+2xAAEsf
        /UaEloN+2L6gVCe1zrPoKRx2oQPxk8=; b=ffshd02Aa9gP/2kfJSpH+WGaF3mI2
        ix6IvpSlzUNj4wJKAmnwJWtjDE4aPf77hME6rgM1qb6/cqqaDBMjfv36nrSXPLd4
        LkVhkATM20KQlIArc0vLxQIS4ovpXp7ohlYCQdGG/rfJpIXc5ekIgaTDeLBSBeRc
        C+ysJ8mmR/LinEd3/9qVsEqFCDyZtG8SuD+lcCW1dcLszQsoLpBNJrtIsviKKbOy
        xnrtHKSb61heYZYc/3CC/GEFwPORaOdRmvDhmRJNT02dAtde8w42tbetjjFCTLt5
        fnOVPPoUuVLqzm3CawcCxI3Q+2O/7txs4BQFo3VFPWCLoFXywVN8FU5Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/xGcW+2xAAEsf/UaE
        loN+2L6gVCe1zrPoKRx2oQPxk8=; b=jYQRLFnqlHlwFDXL19/5I4psQUSgB2mKf
        yVx37Ou+ODqRs0SNNopMH8QLkspoY61czdTPqA5HFNau9Dm5u7hpRhM1mGFr3hFh
        RVVJRkFHiOJc5K2xUiicukdSIZWv6FMHPsPR5I0k0H2A3ercaW5twzQoh3oRDpa4
        2q3oSmYoHquI5q1xYEjTVyBSmWLuEfHKiv99TqUEd1XVGh3Fasy8ssO/pXC2Wo7d
        PxJCn8jnfD7Rsc7R+KIlJDPOnenE5QOMLKQWHGlbcBNRsOJXQbDy3QfXC0wls/tS
        VEB0/mXgXslAAVOeL762OB8I1ruJ0mRdozWjRL6QPybPXEGiuVdUw==
X-ME-Sender: <xms:rQB1X4SabvPJSvFPNC8HFCzx-v3Q9QUFw0YMcXO9CedvSGg4dEUIww>
    <xme:rQB1X1x-kDa1TODm6lj8oj62U1MXc2Bpfvx0p4psQu4Mc66CKX6OyYUgcia3nB9c9
    fl79B3SYwD9SLAS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgvrghnucggucfm
    vghllhgvhicuoehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhgqe
    enucggtffrrghtthgvrhhnpeffledtueeihfehlefhgeefheejvefgteevhfefheffhfeu
    uddvudfffeekteeiudenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghvseho
    rhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:rQB1X13NPEnR104hDj0BAXDlMRD6P5hbJAxpweuXlZu9GIwCwxJDWQ>
    <xmx:rQB1X8BqBAwwm8B-cfT9Z4exyGaIMq9EEgxqSlRCWm-JoSTSsO8V5Q>
    <xmx:rQB1Xxi4DTvOc96-8lV26ZMK0Gs1-KaN_kmRowqW7bXwZNcNeRnZyg>
    <xmx:rQB1XyXH3Tc8PULt21H9jVgFDtY4nsIs8ja7uj9mr6-a0AxPvkLFLNlppW0>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F7A83064682;
        Wed, 30 Sep 2020 18:03:23 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@google.com>
Subject: [PATCH v7 04/13] PCI/ERR: Rename reset_link() to reset_subordinate_device()
Date:   Wed, 30 Sep 2020 15:03:16 -0700
Message-Id: <20200930220316.1113655-1-seanvk.dev@oregontracks.org>
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

