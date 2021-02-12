Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8708319C5E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLKKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 05:10:08 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:23998
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229904AbhBLKKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 05:10:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHmTLGrGWs3Jb009pLLLO+ToSVxjKUSw1sHxnE37n2t6wu56Y7hH6a+LiGodUnS/Mvm7QCtOYeqEPcBK2hooGMuwtKkBwveoBWCpCId3pfeZJ49NZOYOZhBnCsQblZc5tErg8M7/Fr1dm8PLb9cC2wcP8f6tB1rPwpHOlVlqHIX0t1j680ZYDsW2uI8/By24gzfG0R1lSeNEnbacN+OdMVGnrThsB1DTQ4ANB7oO9TrjwgD+fz6IcEtOiCd/Fl+0Tb0QvrzGfj33eM2++bo1eKh1yTTMTJzN4WQp8uY0azcU7sDFZFDJlvOUChWfloiG4F2062KYpc9YZPew7akmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CDYJ7fEy+M4Wi6GR+rdRFSZUWWw3lOAkB1zM+ah6UA=;
 b=TgnPcHb+s1RiSVRbMfXc033kyqMd7d3ms6APdEOIgXhSh0xoJlilhDH+YfN1BNSx4E9c+tm/FlZCF3zGcu/yzN2KLHgQ/4wl+GWc/B4Z+tT0CRTEoqpGuTxdlpuXvEA7ApEPJhv7vSPIKAUvqPRmLzJZaRDGAm+7L1+fAIuDZ6YdYLzclpo0fAMnmLW1AqkZyhSoNkmmz6+dyuqEsV0Ui+U8wRUAgUNDU/QZhaIvLuvGNFHjB0bkx2Lw5yWiEj07Mu9bmVZxYSVqUMKRpg1P0U5fqhgqJxmxBt6LeV5DKayeyYUgKqwaGzZ1RKJUgPSPrfGGriCTwi3qzhKJdK+9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CDYJ7fEy+M4Wi6GR+rdRFSZUWWw3lOAkB1zM+ah6UA=;
 b=DEpjvYJQT+KPtZOWHQpSWTCj72pAZAn7LXALz+roezfp4oSYw4XQk4EEZAVPSjSQOq+79kLLfces8EkD6OLPtJgFh3u593kIKdljjmHhBIjhhNz1K2udREEUTk727cFx5jvMIryQ36nBdjYiN0qd3wEq/dHWZYamsck9ucxjIzc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 12 Feb
 2021 10:09:10 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::8da8:ad8f:e241:457b]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::8da8:ad8f:e241:457b%3]) with mapi id 15.20.3846.026; Fri, 12 Feb 2021
 10:09:10 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH] PCI : check if type 0 devices have all BARs of size zero
Date:   Fri, 12 Feb 2021 11:08:56 +0100
Message-Id: <20210212100856.473415-1-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [92.121.36.4]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv05369.swis.nl-cdc01.nxp.com (92.121.36.4) by FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Fri, 12 Feb 2021 10:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41f29bd8-21e4-4120-f5cf-08d8cf3e3d7a
X-MS-TrafficTypeDiagnostic: VI1PR04MB4688:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB468868AF45B68ECA1F9E0B58D18B9@VI1PR04MB4688.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yczFfXeB6AySviU3ECyfbH9BioPEtNmjzwADNRvYywzfqjRJmSMjehWizzdAWi8fXZEUe5n8s3fdNPRNojyJ9JIYmq72igjGy5Vt10Il2+ezKxuTR4IUrzwf6IG0WuvdE1WfIkW/Xp91+R5he4x/kjHs4nJAd3EbhPAQTs1bcyYDw87FNjSm4TE2dna8jPs8ovM1KbFhPYvQFpLopBUbKlNTLBOPo4sxPOBoelhQ8P9UIKuFOWXB/bQGPsTooqxoHj+6vkNpxyWLFS1V71hwG91d4dvPChMz05d1hTLTP0XkjIX8rmJNCEe3ertO5dOTiXlLFHHl06PbPUH5ojP/EHKiRcvLksiGqxnz4kUo/70RDYo9dQrgLgV30gI+U9pLtlkYXYts/HlDXt6CcVumb7etzDrC0cQmBLkH61st35QxUNxFFDkewP3GoPzxJTSfCiiQ8Z4NiEgqLcJ8HJHDHvVNW7Vh92WGstfN1wLJ1jXk1MMYUNbqS7o+M4Gb14EPN+clLO9oOKFR8W3YQtG1ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(316002)(6506007)(2616005)(86362001)(66556008)(26005)(956004)(5660300002)(186003)(6916009)(44832011)(66476007)(2906002)(8676002)(83380400001)(52116002)(6666004)(6512007)(6486002)(66946007)(1076003)(4326008)(8936002)(16526019)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aU6ejeX3vozAnC7FZW6g1EY+DdJ7QjNUcrl10c8cxYIkFe0oAD9KW9OAwlDS?=
 =?us-ascii?Q?dwVWBBWLEjLmoKZ9xRw+iuiLvDNr/rGSu8FNBrr0mK+pE0FXh1YBh8Nqsptc?=
 =?us-ascii?Q?FZxqsIarQHF2jepWhCgoM9EoLs6Oi/n9pBGOm4AWKZpMrUXqspU0slUuKMei?=
 =?us-ascii?Q?UKXJrGQzqSdRFSWs0QfjKZdLux1oZGkyZISo2PSY9NC0X17RkRCIVauV41FV?=
 =?us-ascii?Q?cyLgTt3lHd669wmtBpyHKzW6+YEXFps1m+ipj2Ryk/h2kCw2a0Cua0Ta3+dn?=
 =?us-ascii?Q?4evOMAcPWoCmkiWzCEP7twfcRHB2Sb7oF1pGtPtJlJ9rPRcn1AITgShbY9dU?=
 =?us-ascii?Q?7w+SE4PpNTtdGVs1vIZB36x0B6Fx22mlk18bTaGbDs8sSn2wsR/BqiEnms9i?=
 =?us-ascii?Q?Zffo7tf8kUTc1gZLYgaIBCw/zsKoCLg9x2SEpiMsTPz3ekWNUeFROHSFGWyx?=
 =?us-ascii?Q?P4kbmC2PLWyEBkdpWZd4wIbMJc5c95brYGItGa99B10J4YXxGuvSUwpmjPB2?=
 =?us-ascii?Q?UPKhEpjwv48v+1F5EvoQZi2VGVk4vuAwuDvyKX/GvVAtK15Y/kGcFtgmFKfP?=
 =?us-ascii?Q?Rvgj5f6mQNHsDOnZIUW/Ic5fhOa5DRRvs0Z4iKcqMEYXZ+KnPGIC7oiGwSZQ?=
 =?us-ascii?Q?xD3zR1NtLmDHI3AtCr0noAbbw9Pi6DyTzTqIGuVYhM35qg+kon2dwlJ8KGLb?=
 =?us-ascii?Q?YxsWo3vrWd5MLk/VU+PeEmo97NoMz4UqeB+q6xsT6mBxAOOeTUhF1FRiBRb9?=
 =?us-ascii?Q?BLWc1ZqM7ZZoaegkWMZxpv4kA4wFS05n9CpPM32W78K5rlWzpVAW+repFfKw?=
 =?us-ascii?Q?b3kSIuKzTBNyUGNZGX636YaHSnWYiuF/LqRldce08nA4YI2Rnfham7A9ItIG?=
 =?us-ascii?Q?Nz0liicGjTX6uaEYQFpWaTUsyqOwHyVdXfn4Wm/6pOif9HD3Ii1NyigOyliZ?=
 =?us-ascii?Q?Mp77JoBQzYEBv1oSWmitO/EUG1DAYonguyEvCze6LfL7npOItf98G2u7C0do?=
 =?us-ascii?Q?CIfvxH+OeiW8f62+5jLAFGQAVCPKwY5YQ6s8/hHJ+i9S7XhOiNNG+/7+F4rU?=
 =?us-ascii?Q?YRuImRNC7NlENix+zlzBLtKFax7pAagyfLzgjEQPdgSGzThwRI9E+YFRfCyL?=
 =?us-ascii?Q?PWAa8NGLZXFKCInbKBIxwJXLKnvdGRFlGY6kWImgT+3FiIIsSGwBE4eOcNuo?=
 =?us-ascii?Q?JrbmvENVD2GaUZWunxX2LDJeM17vu6I0eOO6qvnIFZNbo1C1eKMliDnHj5+P?=
 =?us-ascii?Q?t31WOVRpNa7LYQFeJJ4OWEg9lIN3IjGIpeG7Pe93jbkZgQYLl2/iwfzZV1pq?=
 =?us-ascii?Q?rHgHHEme+vs05KJGEJSM+H0v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f29bd8-21e4-4120-f5cf-08d8cf3e3d7a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:09:10.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28oF+vnGN5uBQgwKYb3fA45ZFMNRGYfWZqe+Y6eB7bcG0uGZW68woO7/nu9TD7MjVqruPy7/HAmga1UPwKs3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4688
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Log a message if all BARs of type 0 devices are of
size zero. This can help detecting type 0 devices
not reporting BAR size correctly.

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 drivers/pci/probe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..6438d6d56777 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -321,6 +321,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg;
+	bool found = false;
 
 	if (dev->non_compliant_bars)
 		return;
@@ -333,8 +334,12 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
+		found |= res->flags ? 1 : 0;
 	}
 
+	if (!dev->hdr_type && !found)
+		pci_info(dev, "BAR size is 0 for BAR[0..%d]\n", howmany - 1);
+
 	if (rom) {
 		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
 		dev->rom_base_reg = rom;
-- 
2.25.1

