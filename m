Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C283DD633
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhHBM67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 08:58:59 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:2048
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233752AbhHBM66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr4oSHVA3SC9dTtt3GsR27uwNztID/mGFgrqu+P+f4oYUWDfiGRO/mO3VRTQnnI90GCYJoGh+MRHVGoPFMCfS9sZRaAOGAdflaBPGJhBVKEVvGDauT6JCyZBpesbajvwxoBQfKH3wVrXiPO/LEsxoh+wVLM8HBO4jX+vDNYanvXFzxFvyUEW8Omso+nT0uWkjK2w9VilF+O94Jp6/XMI8DzNAv6UigX8RXYHzOr5RBNIG4a5AavpVRS4BSVyFkmXm8oO8SrqjEa0uuSv4UI3ByM1VdpCi0xvt17JfbWQln7bHxNdiClu7hM4pIvnTCp73Xr+b18+Ol9+ZzIvcVNHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d+P+4nhytX/RzEd38Eq7qJPxrQkjnAZsyP2P6O/idI=;
 b=oWrYwAChIrsO3MBLp3f3w3tsHxapXVPRR9qqqosgKpIjXz+lJfUkSg53F+A13kZ1U7iJtyrCyqnbCndGoa1qN81nl9XG+6phOrpE2U+zpc9d/YiC68DBMgKT1h/phXatFJ/fq+XR5Qmrlu9UEmhg15+aRRq79PYBSY9LHEymI5OV9f491Ln5Mr2pQAB2WMI0+y525EzyDVlMQjru0QPricP5cJTJNPzSKXjuvigLYD1VDXXxTaIAZ/znlm+8kX5XHWFHm2Xz2txC+KR0VW8cdQUdMQhFzo3U7dzx0K4wR69kzobS07YsLXoQCFurxDjqMHM9jlznfWrfqVWPAptO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d+P+4nhytX/RzEd38Eq7qJPxrQkjnAZsyP2P6O/idI=;
 b=YcQaqoECLtESu71F5xV8Xoc60SH7PAtkGgBn+IbG6Zo6OGPINRN74jbkGj+somt5WpW9yoE7V4opn0dfIjBzKwnLd9yJoU6lbGGkjxvL2oUFMhdQj/+alc1/QvkBl63CC0r8l76oPl5Z3d0T1BnRTPkwj1heiBHzu/dveowqN9I=
Received: from MW4PR04CA0288.namprd04.prod.outlook.com (2603:10b6:303:89::23)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 12:58:46 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::4f) by MW4PR04CA0288.outlook.office365.com
 (2603:10b6:303:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Mon, 2 Aug 2021 12:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:58:45 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 07:58:42 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <mika.westerberg@linux.intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <bhelgaas@google.com>,
        <YehezkelShB@gmail.com>
CC:     <Basavaraj.Natikar@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 2/4] thunderbolt: Handle INTR when Disable ISR auto clear bit set
Date:   Mon, 2 Aug 2021 07:58:18 -0500
Message-ID: <1627909100-83338-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2403fd50-9f82-415e-73e7-08d955b54397
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1398E5DA0053DDC291E28E3FE5EF9@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JRRub2Jm09fZaJRNrTKKhS52z3mLr/8mVOOIPTaaGGiY5pHsEDJDMFQIKYYC4J+Z+/WMcaPiPT86CI6rlfYDo1uUj3QDsMpfdyzbdPr9wZij8rkTo0POT9PcaATW/jevISQ85UUN0GUNw5ZAyX20mc/ZL6U4QA1AWKjB3i4pnKXWaXRVRAiBQJfsSMPlsqLA146w7MWtbVkttBBI8GsW5NScokfbQNhWiXdeas+oRPRsb3r0OXcWpAih0YosfnD6ujdQ4KQkwhH9+avnYDsPMyab2boqlhCTnCyj9PzuDFhPYsCp5I5QZlrBupd4sHMQl7AhXJbZGdqCC5LVkCHrzWdBL8LEms2HSCXFzvxFlRC2ba5E7y8OxVz2InZ5gqE0r9r1RFh8+0KlXWyD3W4Ojz9IBgYQenrM1measutVyhd/AsCe4TBU+ucRoJCdUEyZPjqJbws3GSUNCvt501hkgxSoyY6O/tJ9Y7Mfi29KixRpkctlFOtLReroMuYSN09DUI7yqVidh5XlzkbZZJo9mTMaXiSy5G8LEOxRqc7DpECSpXqepaneeBfMMalJEGQYVb4/60OE1lq3xCErwFFTHxUwmn1iwkSykvo8BQUw1nsnhejzpvoxROKGIczgqhlLzl2ntteloNgtqQ/zDdTjMxaXfd0GBOHoNFIGlO6dgIZ4PwuBuFkPejcahK8CbL/ezJSxmb+dgHkLTpP2ddtVzfsHO0pekSAistO+0QdC3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(86362001)(47076005)(336012)(70206006)(8936002)(36860700001)(8676002)(16526019)(186003)(70586007)(26005)(6666004)(83380400001)(36756003)(82310400003)(2906002)(316002)(426003)(2616005)(82740400003)(4326008)(356005)(5660300002)(81166007)(54906003)(478600001)(110136005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:58:45.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2403fd50-9f82-415e-73e7-08d955b54397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

when the "Disable ISR Auto-Clear" bit is set, the Tx/Rx ring
interrupt status is not cleared. Hence handling it by setting
the "Interrupt status clear" register to clear the
corresponding Tx/Rx ring interrupt.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/thunderbolt/nhi.c   | 26 +++++++++++++++++++++++++-
 include/linux/thunderbolt.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index d7d9c4b..63bbabf 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -74,7 +74,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 		if (!(misc & REG_DMA_MISC_INT_AUTO_CLEAR)) {
 			misc |= REG_DMA_MISC_INT_AUTO_CLEAR;
 			iowrite32(misc, ring->nhi->iobase + REG_DMA_MISC);
-		}
+			misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
+			if (misc & REG_DMA_MISC_INT_AUTO_CLEAR)
+				ring->nhi->is_intr_autoclr = true;
+		} else
+			ring->nhi->is_intr_autoclr = true;
 
 		ivr_base = ring->nhi->iobase + REG_INT_VEC_ALLOC_BASE;
 		step = index / REG_INT_VEC_ALLOC_REGS * REG_INT_VEC_ALLOC_BITS;
@@ -377,11 +381,31 @@ void tb_ring_poll_complete(struct tb_ring *ring)
 }
 EXPORT_SYMBOL_GPL(tb_ring_poll_complete);
 
+static void check_and_clear_intr_status(struct tb_ring *ring, int int_pos)
+{
+	u32 value;
+
+	if (!ring->nhi->is_intr_autoclr) {
+		value = ioread32(ring->nhi->iobase
+					 + REG_RING_NOTIFY_BASE
+					 + 4 * (int_pos / 32));
+		iowrite32(value, ring->nhi->iobase
+			  + (REG_RING_NOTIFY_BASE + 8)
+			  + 4 * (int_pos / 32));
+	}
+}
+
 static irqreturn_t ring_msix(int irq, void *data)
 {
 	struct tb_ring *ring = data;
 
 	spin_lock(&ring->nhi->lock);
+
+	if (ring->is_tx)
+		check_and_clear_intr_status(ring, 0);
+	else
+		check_and_clear_intr_status(ring, ring->nhi->hop_count);
+
 	spin_lock(&ring->lock);
 	__ring_interrupt(ring);
 	spin_unlock(&ring->lock);
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index e7c96c3..bbe7c7e 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -478,6 +478,7 @@ struct tb_nhi {
 	struct tb_ring **rx_rings;
 	struct ida msix_ida;
 	bool going_away;
+	bool is_intr_autoclr;
 	struct work_struct interrupt_work;
 	u32 hop_count;
 };
-- 
2.7.4

