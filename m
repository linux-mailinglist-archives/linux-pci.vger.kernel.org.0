Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E522131824
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFTDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:42 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54792 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFTDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:41 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m6-NR; Mon, 06 Jan 2020 12:03:40 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eD-Ar; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:28 -0700
Message-Id: <20200106190337.2428-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 03/12] PCI/switchtec: Add support for new events
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The intercomm notify  event was added for PAX variants of switchtec
hardware and the UEC Port was added for the MR1 release of GEN3 firmware.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c       | 3 +++
 include/linux/switchtec.h            | 7 +++++--
 include/uapi/linux/switchtec_ioctl.h | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 9c3ad09d3022..218e67428cf9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -751,10 +751,13 @@ static const struct event_reg {
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP, mrpc_comp_hdr),
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC, mrpc_comp_async_hdr),
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_DYN_PART_BIND_COMP, dyn_binding_hdr),
+	EV_PAR(SWITCHTEC_IOCTL_EVENT_INTERCOMM_REQ_NOTIFY,
+	       intercomm_notify_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_AER_IN_P2P, aer_in_p2p_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_AER_IN_VEP, aer_in_vep_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_DPC, dpc_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_CTS, cts_hdr),
+	EV_PFF(SWITCHTEC_IOCTL_EVENT_UEC, uec_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_HOTPLUG, hotplug_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_IER, ier_hdr),
 	EV_PFF(SWITCHTEC_IOCTL_EVENT_THRESH, threshold_hdr),
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index e295515bc3f3..b4ba3a38f30f 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -196,7 +196,9 @@ struct part_cfg_regs {
 	u32 mrpc_comp_async_data[5];
 	u32 dyn_binding_hdr;
 	u32 dyn_binding_data[5];
-	u32 reserved4[159];
+	u32 intercomm_notify_hdr;
+	u32 intercomm_notify_data[5];
+	u32 reserved4[153];
 } __packed;
 
 enum {
@@ -320,7 +322,8 @@ struct pff_csr_regs {
 	u32 dpc_data[5];
 	u32 cts_hdr;
 	u32 cts_data[5];
-	u32 reserved3[6];
+	u32 uec_hdr;
+	u32 uec_data[5];
 	u32 hotplug_hdr;
 	u32 hotplug_data[5];
 	u32 ier_hdr;
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index c912b5a678e4..e8db938985ca 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -98,7 +98,9 @@ struct switchtec_ioctl_event_summary {
 #define SWITCHTEC_IOCTL_EVENT_CREDIT_TIMEOUT		27
 #define SWITCHTEC_IOCTL_EVENT_LINK_STATE		28
 #define SWITCHTEC_IOCTL_EVENT_GFMS			29
-#define SWITCHTEC_IOCTL_MAX_EVENTS			30
+#define SWITCHTEC_IOCTL_EVENT_INTERCOMM_REQ_NOTIFY	30
+#define SWITCHTEC_IOCTL_EVENT_UEC			31
+#define SWITCHTEC_IOCTL_MAX_EVENTS			32
 
 #define SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX -1
 #define SWITCHTEC_IOCTL_EVENT_IDX_ALL -2
-- 
2.20.1

