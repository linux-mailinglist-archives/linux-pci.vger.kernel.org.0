Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E342EEFA6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbhAHJ3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:29:00 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:11339
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727696AbhAHJ27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0aXx7DoVLSMSWvm5TpVXD8UupxpD95zja7FJ5+FsRO2l97CHiC5/zAldY24yjBgh34XerNfDiXkz4hKfx1AM2PBqpdvLaok9eyjbiGrnDjF6Qa2pW5+W3+5c5C3RVqGBc75FHKoAUaCIZsobGUEJWBqCqAijLHil5VslJLOVMsVG0rHxWWap/D3/W4aAfqgNa4HIDBIyUKq4vSgsRO4Qit+NnzvBGbFt5JmP+v0qxdnrM8KAZ0Zmiq5HYhn29lQMnd6Zo1kA0yUhxdaaBwfOVaWeIeF/59lMD+ZUKDVjA1xgTEHm/in2ERhTjRt2VepGd1AWelqdt20SEaokxExyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoF2K5beURAwXd7gbFyaHtuB1I+97xMeg1eQUsac0wo=;
 b=i2KE7i7qoRnYstxHXxoUhP0O5+k5/R24y4sha9tTvajnBu31nmXOPFVdaakqyNeImcJs7HhG6iIrtGR2OujL0E+DQ0HNQASwTEQ7KkEhDbaWQ9KT8JpRMhXjjRY+VnBQRay9YNM3PS5JV49x3aAQkO1tG2G4/0n4f8zzVaAX/OtyFXV9oUKiRmNV3FP3YhW3v+ELUrL4p5Omjl8CrgKMSrqLYMeQ1lFXwSgtcKnKfZo0yzFgBsX+rguAUFTQH8hR73yho1igeFNR/929vcEOVxLDO2WwXtg0uNqaFRLk96+FSxiWLiwLfdgT/E+bGiwhb6YACPmgBa2N3dTDbg8MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoF2K5beURAwXd7gbFyaHtuB1I+97xMeg1eQUsac0wo=;
 b=Dj4ifjd5xJSY3bZzIz37/0Uoa/MrLS9H9mjIK70x91Jy0R9PwB4mk/s1J/arc+klVselXqucvk7KGqmoF3jeOqEGzXBlzcDt3KC1bkj2Ri64yaEQONW0W07+nR63hBTIfvxlGDZXNjesXFSKrKMVLFXZy79v6EZ1HwJFtUBkV7s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Fri, 8 Jan
 2021 09:27:57 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:57 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 6/7] arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Fri,  8 Jan 2021 17:36:09 +0800
Message-Id: <20210108093610.28595-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c20af00d-c204-4cd3-83b9-08d8b3b7af3a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB337149D93D01E892B26B92CD84AE0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0KKj4NqKPOTlmkvDT0Pk51eNBbnOrh/fzIkcF3wCBEJLinhglk77AM+Jb+4RnswJygxcha9IWauSpWafUE5y4uYKvaVnNs3cA7Nq/JsLSXRWhkWPovDQP0W76BIXGIiK1HA88ZbiosLRHjjjS1MWETJtBmWw5uiVmOvFL3IgnsujWCKp/g70crMfVzkJuqRAqF7LzVyw/RnG0hNYQQH66gSKxSBfVr1lKEoI9mcS2lOTfWAeT0wMBIBwhq/So+7ZOmc1jHcz+dzwu4DevuvpxC8vyNaTi8MZU+4aF+BO0J50iSqbOj7Hjvg0K+OcAhXOpGIL4puJKpn6TgfK0/Nv2Aj+Fid+vXiMbiGaog1Xh900SZPy7d3DsZsptl18WT3CJFeNvASS3Pago2DnaKyfDTBQegihKKpvjXtFBdEP5T0ww9NwxqAICHJfGbuIFD1+9fGz5YFTsPJ2oEMN8BMOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(6512007)(16526019)(26005)(6506007)(36756003)(6666004)(66556008)(69590400011)(8676002)(6486002)(478600001)(66946007)(52116002)(2616005)(956004)(66476007)(86362001)(4326008)(2906002)(1076003)(921005)(5660300002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PImwEpgxEdvDenxUV+4weo/O41ZRJUKlYRfLRAcdRHe5IYTRhEBnbOG1ufXe?=
 =?us-ascii?Q?gaIJeJuZ7hbXLxqlKHWNHDHBcM8b8RuuRGOf2U1ueT0bEwAhMb5660bgMndM?=
 =?us-ascii?Q?8y2AgCxayrUONXFmSB0dIG3HXdaT7jePysnT/eVVvisRfmuaAN5lOmlY6Bkq?=
 =?us-ascii?Q?LfKfjXFeBHruX+0U5ExjSyv5OSxqk/+N8ia0qmHKapDa59nF1dZq7hty9oiv?=
 =?us-ascii?Q?BqMoxzJZb1ZVsqzcp/9Wuc/hsI/QHd0XBM+DytkC/Mw34/QlPS437gqDBUsM?=
 =?us-ascii?Q?GRKu2Z7pEDPnHTa1T2r4Gb3vFKFcDfOWLhHKURwwBjrpPYcx8nzGuPVQKsI3?=
 =?us-ascii?Q?YApV8iHd6pYawEMiWoF4jH8JKv9YOgHOMiyjf3BXf8183TudnvT1YTy957p2?=
 =?us-ascii?Q?YPJAFDnMvlnAwSCaWV5VEZVAhmY5/YlHclCLLFET6S4jdDbmn5zH4hLghvrT?=
 =?us-ascii?Q?2YaIDgKLDh9wORe/GHRMVOMIW5J2InB7jSwQNzdCtx07b8XqwWqLwOAkbOFv?=
 =?us-ascii?Q?03zObrb8/BWSMFN3o0OBtx880LQNRg5GXpg36omKicCb5rCCejLjpKKOcVJk?=
 =?us-ascii?Q?0SHHSGeQdM7csi/dy0s0nZYqZXspmINivjhoMGfOforSZIs0/1I47pNbplju?=
 =?us-ascii?Q?+7etOZ7sLI/BcKCHS9x54qq7SOTWRU2gbudzVDUxwHEc4g/zg8LkTLg/Fgy/?=
 =?us-ascii?Q?UMLraBniYbgG/bb3u1ISkittuJeSxKT2SCicJOUIizykaeL1HjLkbBWH4eeL?=
 =?us-ascii?Q?QmjCIcw6Nsq+jB6xlfr2mDBLZZJAu/kbFJGhlIwXfZR/Mq1X2nKnzm8mhru6?=
 =?us-ascii?Q?WUeEKz3/KYPbmq779Nr9DRZzBk5ZkK2/eN/0EPanBN7k1tfuQyFzDLs6tHHe?=
 =?us-ascii?Q?8a5/oNXz0vbVIg71hyDPwC3y3PypylNuWl9amruPqYf4GDCtdjhid0H8Une8?=
 =?us-ascii?Q?7VIoprIXmJOb7P0tmrSpt2Bw1LmkfGjA8Ov86zdM2PafTWq5lV4KpBugcLo1?=
 =?us-ascii?Q?bWIr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:57.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: c20af00d-c204-4cd3-83b9-08d8b3b7af3a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDz6BETBtDDRxwyztg45n/Po8h0XDwecAkbJbiQ7YAARGvMHByo50muC+w8LdIpI1EycyOGuTx3jXKLagHw5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller DT node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Rebased against the latest code base

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index aca45bf348b4..862c6ac0df83 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -826,6 +826,7 @@
 			interrupts = <0 118 0x4>, /* controller interrupt */
 				     <0 117 0x4>; /* PME interrupt */
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -853,6 +854,7 @@
 			interrupts = <0 128 0x4>,
 				     <0 127 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -880,6 +882,7 @@
 			interrupts = <0 162 0x4>,
 				     <0 161 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.17.1

