Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2B231281
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 21:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbgG1TYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 15:24:41 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37918 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgG1TYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 15:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HBU/yajmJTUr7b5CjuR1Ew6UpYj43svK56Zc/b1nrgE=; b=Wujqx8gqtDTMQ2QRYEbLKQNs1C
        pecvlvTR8U6QtGsqyZfZXRpOi8qBR3pYwuUcUrOmfywOE+MuB7/1ge1XcuGxZkGqEvWSzAATVyls9
        SbO3Dub1EGLKIkUGe6KWYhy336nNhMcR9iJmG/tpzaNqNcEWwqrz1aDvJ9600O7J3KwjHyM7OY9o5
        Ke9USSNkBG9SpQTexHxlzhPFdh3jtVb24oxZKVUPtIARgu/brX5gtgW8XWRp6hhPYWdx2zqtBwAJT
        l076kuyDRdzKprOQ1/XnPWs024NWkCuXkWQfUUQ4EsKK4L76XsrvKImxXieE+Icwru2m1BjkDWJXC
        cB0pScKg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0VDK-00017D-K5; Tue, 28 Jul 2020 13:24:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0VDI-0004x5-Pb; Tue, 28 Jul 2020 13:24:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 28 Jul 2020 13:24:33 -0600
Message-Id: <20200728192434.18993-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 1/2] PCI/switechtec: Add missing __iomem and __user tags to fix sparse warnings
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a number of missing __iomem and __user tags in the ioctl functions of
the switchtec driver. This fixes a number of sparse warnings of the form:

  sparse: sparse: incorrect type in ... (different address spaces)

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

---

Here are a couple quick patches to fix some sparse warnings I was
notified about a couple weeks ago.

I've split them into two patches based on Fixes tag, but they could be
squashed depending on the preference.

Thanks!

drivers/pci/switch/switchtec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 850cfeb74608..3d5da7f44378 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -940,7 +940,7 @@ static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
 	size_t off;

 	if (event_id < 0 || event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
-		return ERR_PTR(-EINVAL);
+		return (u32 __iomem *)ERR_PTR(-EINVAL);

 	off = event_regs[event_id].offset;

@@ -948,10 +948,10 @@ static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
 		if (index == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
 			index = stdev->partition;
 		else if (index < 0 || index >= stdev->partition_count)
-			return ERR_PTR(-EINVAL);
+			return (u32 __iomem *)ERR_PTR(-EINVAL);
 	} else if (event_regs[event_id].map_reg == pff_ev_reg) {
 		if (index < 0 || index >= stdev->pff_csr_count)
-			return ERR_PTR(-EINVAL);
+			return (u32 __iomem *)ERR_PTR(-EINVAL);
 	}

 	return event_regs[event_id].map_reg(stdev, off, index);
@@ -1057,11 +1057,11 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 }

 static int ioctl_pff_to_port(struct switchtec_dev *stdev,
-			     struct switchtec_ioctl_pff_port *up)
+			     struct switchtec_ioctl_pff_port __user *up)
 {
 	int i, part;
 	u32 reg;
-	struct part_cfg_regs *pcfg;
+	struct part_cfg_regs __iomem *pcfg;
 	struct switchtec_ioctl_pff_port p;

 	if (copy_from_user(&p, up, sizeof(p)))
@@ -1104,10 +1104,10 @@ static int ioctl_pff_to_port(struct switchtec_dev *stdev,
 }

 static int ioctl_port_to_pff(struct switchtec_dev *stdev,
-			     struct switchtec_ioctl_pff_port *up)
+			     struct switchtec_ioctl_pff_port __user *up)
 {
 	struct switchtec_ioctl_pff_port p;
-	struct part_cfg_regs *pcfg;
+	struct part_cfg_regs __iomem *pcfg;

 	if (copy_from_user(&p, up, sizeof(p)))
 		return -EFAULT;

base-commit: 92ed301919932f777713b9172e525674157e983d
--
2.20.1
