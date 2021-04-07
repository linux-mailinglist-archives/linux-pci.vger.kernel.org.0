Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504693561A3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbhDGDDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:03:46 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:1216
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232839AbhDGDDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0UgG4GW0iM4JZcVnvL62kU9nfCTqd/vXoTQ4XXhHQ3jwv5cqERDBFeSscgFqqjcDR/lIyIvFb3WEpRnQuJGVkJDCumhnENYW/LA0sop6ceAarCULJVrE/cPoU0DD7298hzRl3d30GSEuVzOwkvQh8arrjYpVir9VZ+52z/zH9yDFftT4Zs2vxWmpB1niB6RSDDrb9dWQ3hxxkUU+5cIvUHsutv828hyup+7czM5FcTjAAp+JVSe/42BRv8txihp/g1NSj5mI9F4KIcVDxDm05EAh6wJkPu4deEkulqwaRhdu9717QmNoFEa6GHcHcvOgZUqKDz0TzqYdQmH/rwgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmGwXOt7x6JOVfmZskL+T29VygRihfeYT/BA2pD6rPA=;
 b=LHPkihvUHuTAOyDa0YzmDLa2/5jYNcFoxugtFdfrICebUwHMDpvhxKJdwAylwXKlqBuHDfryUbSEchCSuU1pOb/Xdqb5jHoKNZTinMzOkd/2VfrOwRHpQ15/89cEEpSzrXuoMn7IAB2MPZ4oaSf+G5dx426X2qlVhYrjg4VKQLOzLQkFEmYTl8CzURFBA241oVTgSyXvFVRESo/Mngt5Telx+1gCtz6iRS/vuP+KP/EBpPT9YF5zvDgYCcuqkNw1rVoWh4bMeV7CzTPZPsZcwymLq8y4bnL2CMsgpL9VAWI0nf4Uq5nKUorbRZ9F2e8tyXbLvTqHpoQ7/AHKC7ROmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmGwXOt7x6JOVfmZskL+T29VygRihfeYT/BA2pD6rPA=;
 b=hWUsOdjOymN83UaVwgATs8hsCoRyeLJvAE0/p7L7x29AjYT9Q5WU6tmsdfUXEOx7XuclBCj3Hw4+qj5t0aOxLwwc4DQfjp2yUgDSYD6TdiNPnLsouwivDnPY73HlFH1s++ofYVPX53tlve11WdksqumIn5ksV4RQRGv9D6zBmbE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:03:32 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:03:32 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 0/6] PCI: layerscape: Add power management support
Date:   Wed,  7 Apr 2021 11:09:42 +0800
Message-Id: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f497c16d-b304-40a6-78bc-08d8f971b9e0
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3276CAFC2148B23CA865166E84759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTxchFVDDKPA0i2vPNUc/FsQs4DcpO5YeKPUxy8XMS33NZom8o4aDPW82C+5eQTS1Fwgk9S5qFpJwfh1UTRBR+4oBLdAe4HWkOW5MURPshox9JPr6mQO7ZuIH23Ce3kqns9Wk6etQuA86ipjYNiE4HBa0zQor98ji7moZDKhlKR+afsefzp73fMTk/LrYLPisv0FjybRf9QAdXp2TBfqUnrBhrLTlqYZhwCAMfFSYi0OCcdcz8NvNsNVm8usKyPPCQNO4yHZuLBnYND1lP7+9oaKKU7QGCOMcjP3m9BcwXXQo5KQgVhuqtRYMybqdYk/hg+nPYhSi6NAKzYin66TfImxrH8FaczuDwkiSXk85P3Lhm6kBXfc0JXRmjGLZJDJNq45JfRvsIJeDlSo9HzAWRkw7bI716RJpao4gpuRe/veTDbogn0/LPKMrfWfEEHEcpSnnvTnhZsteXF7JebYb26PRwutgNLg536NsmREiSQzi/R5RJqe5GhDEgGj3zN5yUL9kMOTsbaAKOVV1uZVo6jy1BCi3UUfGHDMX/417gCi0YECaHPzjrS3azQ2a4FxIUTAljkcqFrUTyUZAVFU2LMEWxTUghA3mjKGj/X+rOw1hvSSkOIa2b5WEpt6BFyv9GH4H75lMpafD6amJWa2PTzH4Iv5L42irGtj5/Sorl/XPBMNs+5eOe14ThQZRtnBWCoalYVuqdaZlhWVSFcNQ6yA6svuxeDUAtv2bbq/Vrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(4744005)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?76ZI6cW+of4pUryQX/TE7TOpTcIhluKIMRI03j67oNr4pLMu2+HuTsJOYcn4?=
 =?us-ascii?Q?fS/auJinuB9fg2JJhmMxJtpzsw+zFcG7bLR2X729tdNuueDDZyc7sycazTkq?=
 =?us-ascii?Q?gvQFSoPX1JBB1iJyKvm6osQKudYChJPMiBnbmnr5pg+gDevLYy3bxBw1Lbfy?=
 =?us-ascii?Q?E01fOeXCm7M81DDpev6wvD1gTObfSSkVZbx52szrMAiqiqXZVYvw4uO/o3YV?=
 =?us-ascii?Q?Ai1c+CDSwUR4HDb2A3xpC+NtWHYrnFh1FvOucT8CZJRrdoOpAJbhqk+9q57G?=
 =?us-ascii?Q?9Dhfx1HNWKWSz8YcEAmeBDO5UE4sbCQCSs1Fy757fFOaUhNZdpvXuBi2cZMQ?=
 =?us-ascii?Q?HwKHeno/SU+HiXLbivp6IBae2cQsiCj6wpSmkDgfNVDpJjVs2rmZQtxrGgru?=
 =?us-ascii?Q?EAVYSIi0/0YbQOK7LY+MJ1pcG0rr+qaLUwTNoyhVW9K2aqo4Yy9w2pKygc73?=
 =?us-ascii?Q?upaXQmfKQiP6hunlYVl6HARgvAhSBbW4+reAEXpB8+LLMsiJNk2Td8Ll/rI5?=
 =?us-ascii?Q?TXQkViGPIv45eyMCzXSJkNOWnACpEevvTCLHZ84wEl6Es8GB8jDm/RMSDTXH?=
 =?us-ascii?Q?iQiT94cAQkL6RJhJ7gqLXJcVD2Tk1JRYeI3EV1Ka+uhVTHzebux+oBtLB3ax?=
 =?us-ascii?Q?5e0DgkFEhZE/AD8eGlFyXhCzndbJgf1SnN1eyjZJE3GWk1yKetMfKJiBRVvI?=
 =?us-ascii?Q?YQ35fJZVFh8NoH7/GsvV5xRd6o2zi2Ri/85oy6BVK2rwJs3cghQ/x1njg6GG?=
 =?us-ascii?Q?qhmAXiq5vKQtIeHwse2P+JXispGYRuJVSqspNxTILHlPinFeXLb3cVkKyHuV?=
 =?us-ascii?Q?f/MoCQdm9Kianwp7vZGkN8WU/KyRynIbxltvpUCKqq8l2WvGOMgy3wAY2h/k?=
 =?us-ascii?Q?HS7g8+MWt8KnF7eWcdunv+OtbI07nhnSv3pcrlnugpB5AVnguwtbon4EdOIP?=
 =?us-ascii?Q?AOyGDG4oxzWPUBHBwr8/OZ6qD6ElJxTWxXiObymIwI4KtfN1AMiMvJvNaflv?=
 =?us-ascii?Q?mbKhvNQnpx/I+9VLzgzircwx1NmRUAV02dYSIFF5ln7mnImdG3vWUTM5Vg+p?=
 =?us-ascii?Q?s1LNVcQ+44RC9bTjw6s1gOEG/2ebyxm1FfrFOkBnhu2aI5L6iszNSg+lAx2x?=
 =?us-ascii?Q?ThQNtlwChWG0v2RZCecsnaXiS7uJDKJvZstboOc/yByC1V+skOFDc156OYS4?=
 =?us-ascii?Q?Ns45TqChDrQ+qgKifsGCsc+CLOZSQFalR7SyY6HZKdA67V9VB1FDR/wok/t6?=
 =?us-ascii?Q?flFNjKd/5K5PtT301DXp+djcg2rYpTDxWDab5Xb5SIv+JKBIzdHD0M0KiPWR?=
 =?us-ascii?Q?NOBtBA21f2pgnjQjNJyK4bJ/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f497c16d-b304-40a6-78bc-08d8f971b9e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:03:32.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wesU9TqbckMeyhzZ3z5gLoX1jTdYS3+im52emMAbr6E+yISNeaen/LuHk0d3Y9VZ6cNOdGzQ2/Kzve/w9edZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch series is to add PCIe power management support for NXP
Layerscape platforms.

Hou Zhiqiang (6):
  PCI: layerscape: Change to use the DWC common link-up check function
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  arm64: dts: layerscape: Add big-endian property for PCIe nodes
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property
  arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
  PCI: layerscape: Add power management support

 .../bindings/pci/layerscape-pci.txt           |   6 +-
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
 drivers/pci/controller/dwc/pci-layerscape.c   | 450 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 6 files changed, 370 insertions(+), 97 deletions(-)

-- 
2.17.1

