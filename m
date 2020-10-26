Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5429865C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 06:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768410AbgJZFY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 01:24:26 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:12993
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1768390AbgJZFY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 01:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxOC74vtoQ+rgL3ajMuDM6dhiZXr8PIqb/Z4bkxZKZhGaiIqNi0SVNpNAdCPbVlkIsKEmctx5J/wQLWIrke1IL6IV3cGGcUq86sc/7KFaLiZ23tbI4Arn7WRBrwC7aj+XOQ+4wRS0SVbikDKG6G5msq1eHdoG46zbbbiYAjlUROa4RpmQsiTqH3qIg8CgLj6OUKuRXQdpQZZrun4CAMaZt1hIf6zQAB5pQV+TrX8yTdPxsYXPSqzQpcSImD42SMwA7EgNSw5L7/jizS7EqRotGZyz23vh4I6dMX1uuJwQOevS3Xz4on89x3RfACI7pqSp/YqUlCmP4S3PVFdWknH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAZkndDt+JkZPT3CuvWwtuxcmbtBYO9B84lt6BCIMTA=;
 b=DSjTna5SNZ3JM76PwK3mkKmpsiSAvpZ4Kl/k1jp88F9qJ4A4h6B5r6crGoDpVHziVGkgcylisvMh3uqNvR1V+ldFSsKtfTQWM+dkrTBHhDjFjiTVUPULmG7UWU2OGrOBI7XbeEQ+LKPAAcXnJeMVgRsTUiQdEEHXRIu8WxdWXv3WzOWnoKalNWko3ZFLxoXHbRYGN1Mt1DKky27jmW8QJwkiB/Vy/eXDiUpOC8YUS28ZgLhcCLeVrsEaCrMmGfHJEqZEF5ogg4DN5d5nxAvgV55Rljt2ya8FrfrtbQA/i5rnw8/2Ej8WskIL6PKuL6dvwvYKsgbT+7NG56+yxBe0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAZkndDt+JkZPT3CuvWwtuxcmbtBYO9B84lt6BCIMTA=;
 b=VVzphWhCGEIRF6egbz6XIyZnyF1iJ0QXDw+iJDTGpEjWNkc/QZ/UQFU+8o8Mc5OL8gPjTRbGOlqFPAP7wherg8gRjT3k4NRN0s+YXcdVLPFBA/OZQaUzg83LJgJHJR/aqlQGM0TUX7xSpVKWq8oJWf5zemXixvlEMiTZGoG9MAA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2299.eurprd04.prod.outlook.com (2603:10a6:3:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 05:24:22 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 05:24:22 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/2] PCI: layerscape: Add EP mode support for LX2160A rev2
Date:   Mon, 26 Oct 2020 13:14:48 +0800
Message-Id: <20201026051448.1913-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
References: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:3:2::28) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:3:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Mon, 26 Oct 2020 05:24:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b55db57-acac-4bd5-96c4-08d8796f6547
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB229932025A1EFA7681611A3584190@HE1PR0401MB2299.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHRFE3xcgteH0b8e1XulsNW11U+ahknvvlSPzyZ2LyyvwEC6/EKm4oyrzLXfdd0MDV3U0xytEGXCcKC2KXpiVmoq5vg/elJCA1D+o1PyjS7+rWQ8V+MgwM+QYEj+P8Svu1P589ty14f1bJSMsmjhbsHsb3sKvcjXtFIsmysp+lbxndMPoOSj7Hzcpw8HRsXZzL6Uo8fW/zop8A3vazhW77Pb9gSqPRUgrl6KtR7zdFVH/IuKveQBtNvaEBqF/SqvadvKpqxcIPFgCIRrprf1e4sJtF7DQjHyx7moGhis+TNCyGlXYkDJSSHlgSDFjboKD9a8ooQbwlH49YJVRwfCuzJG0vRL493+tVbucSKhpNEhM8+Sr2wdpQ8K3S19Ax3I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(26005)(86362001)(6666004)(66946007)(66556008)(16526019)(5660300002)(4326008)(6506007)(36756003)(316002)(52116002)(2906002)(478600001)(186003)(69590400008)(66476007)(6512007)(956004)(8676002)(8936002)(1076003)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xqALQkxPiOjAj/XUSPUbw4O/4jECzwpYazdV/wk8lE5Bq5paWny3OCnDm1hCDmj5JT2kRf6wwn3WxsnRgdlSCu1QxnRt3holc2VHoZSVnJgHJMs6Vc0b6BPD0w4aDW0fp0OugBtP9+lh5gFIfyiXcHYMdcTIO5ZwbvyfSy8OVOmB0ERHkWZ7tU74yvLH44Sv/3iHmmVtSXZ3mUe3pz9jZLtPolgPHjb6iFiHlZW6JT1dLLZ6jRVaCR2yirEorooe6dB3koA5x/vN+emFS/BT1x19iMJeGVDwmwlWAyOV2tBR62R4rGa0DKNxRxu2oBASAgIZqozVV+TrY0GGiD6tHSU4Rg9BKmuJpV1Eyh9L4pX2osoZ36yKCVe1HjRFzs0ET6krwZxobcwc92qB4jlRiTDnQoNpbdJsvZH3S/os9opfiugltiEKkwyTym2oUZ2kK1BwkHKOsukxkHEOjEV1Lxo55X5R2r9RFetiAsnDiPwZNeU4BBeVMXn6yru9khmuYRzi/P6UKrnmuCgOn4QWentLIw5uCEktHi5/5UMmf5RYmtK2YMUtDZbewdGR6dnXzequMub/7DdWgIgri61VDxCUxfs02JPje9nTgF/qoC96KcKpROX6GoJ3yjqa+Wv96bGYrS7273xwbgSh2P2SsQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55db57-acac-4bd5-96c4-08d8796f6547
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 05:24:22.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H9Um7xKy5k/k7ZqjHLzJn3H7vuDRwpJuoTjXHFy8YaUrG5374iORWIKLRYyF2FAai6P+ETczhJAn3leYy70Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2299
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A rev2 uses the same PCIe IP as LS2088A, but LX2160A rev2
PCIe controller is integrated with different stride between PFs'
register address.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 84206f265e54..b125fa1519c8 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -117,10 +117,17 @@ static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
+static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
+	.func_offset = 0x8000,
+	.ops = &ls_pcie_ep_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
+};
+
 static const struct of_device_id ls_pcie_ep_of_match[] = {
 	{ .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
 	{ .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
 	{ .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ .compatible = "fsl,lx2160ar2-pcie-ep", .data = &lx2_ep_drvdata },
 	{ },
 };
 
-- 
2.17.1

