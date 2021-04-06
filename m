Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87091354F41
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbhDFI7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:59:18 -0400
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:58766
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244698AbhDFI7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvZ35wPPkPbtuMkjG8yp6sdywZf1O6Cp6nP4NHJXuMz8GH14Aywl96JzTIZJkD5pLOwNCfoebsupZ6UnANGJUbkzRZcJBBlCRNLZGjLIDcT3+jh5gfkuZHR+SzGm/c/vcIlDe/IXhofAlMttnAsHVV1p7CqD+XoBM50PvFZgJK9b3hdhfGbeKrx1OSmkXwsbMYTHigwrUP62VTGC7janOSqaGNl62PBvf+hKK4Z3NpGFng4d0mMtViDjZujgaWv3zBZmFiC5DR3BXuel+xi9DuUm2fd+Z0AeAZGKumn2UDjNv23XFOy9eLpFBWqq0P2wWLNWD7DHpHAxQh+VoEqI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiZQScdrZSLaXkoPzS0Kv+yNE8qlo9V98zKJ+o6AJ+o=;
 b=DMA5UBn/1h4QrwQskkedzuhi01/XLsHd3UeryBG5TX4rh8+02gG7wPHuyJEV15pRWxzV92yxc5pL8mC3g2BdcrkMFMsROSMFxhZN+/NaXOy0JDGlZnnwYpxIsY/YrDZ74CC/DfIodrCvEgVJH+xZ69D3BV/xNiv7Ikzb8CEfTuITrnlk9OrxrQ9Hd0foUplEoGpJDGXFc72JnImhzSD9kXU0mYqmYsqOUFbYfxycosGOHTSr5ZHGujUqia/xJFGiyeDfAWSbOJ5ZLLmXEQxifDHou9N0gKizAgMJnR8RNN3OO8uL6VqpQCohjyLAEemTz5pyys89WCeeR/MJ1t0ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiZQScdrZSLaXkoPzS0Kv+yNE8qlo9V98zKJ+o6AJ+o=;
 b=BbWjbwFB539ut0taeL1juJ3GdiRHJu+tmqiyAxzcmBtkdQwEUHeBTtSVqBwA9rzT+VYRXEtWiatlYDInnGDwLs0Js56X3xVoeDRFzPofvtNIHWLLiNbrsjT69v4f/ITpfNoMX0ZDXT1FI2UdOLtVJK5lOfm1jrh7PSdyzV1/q18=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3516.eurprd04.prod.outlook.com (2603:10a6:7:86::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:58:46 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:58:46 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 4/6] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
Date:   Tue,  6 Apr 2021 17:04:47 +0800
Message-Id: <20210406090449.36352-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76df81a-1c5d-49b8-564d-08d8f8da2faf
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3516816105712E9A53BBC5F484769@HE1PR0402MB3516.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWqGPh/xZHFQocmVW3owhNKO1OE2+wVtJwxtC+MhrSR13InJJMlN3wAmLm11a4N7xkQyGz0+GNnDBGF4KzHF4WICztzqkAQrbrhCCXQX1w1kmdTt/Jmnoi+PcpG0hlL2trwl582YFjzZgucbnYTsHfSd9th58eZAhb+SmI8eOcdzmPLEw7o8Uzaa3+t2cUmxn3K8RcSu6QMtn+1OVTFV9Y91HcZucKenmd/yeg7zwX7UfGZP2vBI/1NMXAjqPFCwLNIMOvp8TmhVJjwlUw8X8rE/1gKxufFnMCmmulHVe834B/F1VMMz1TroaoBbJOZRF5aVEKzyC8gJ+rjkk87DnlpVCNJ11h+pomi+DocguGoK1O7yIvrjtofQRwjgnRLzk9Ysm7WaBBGLsbi3jWHUO/a2XdWwaII6czzb7nL8Ay/Cs64SSdd3EmCOdK/70JwURWoOJ8fi/UUT9BE0siUBxA9vmmo4h7i4z8Vx4Dc1vhk/b4+kTc7NaL8Rx/0360Jmkd3OuFULFsFgq/M5m+55a0GnNf66CpW6t+hTAZfbh+i18rQZnBj4p3O5GMzspMaH6UKxh8C2ESwXHhjYmj3qdgVmlsh9bb2BVwWcDBytEDM5GbdoKnnC2ouZE7GaOs7u1Qi5iUDIFEklyYmroJmNcBaaEJAokqRy21YOnnNuyy+9je3WS0bgbWNtLpm7NwpA+om+UWfAvle+gloYPOvbgNtaOjeqB0CFlH+OINBv25QaHXBpKnB7rrnyF6oMbhzC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(6506007)(52116002)(83380400001)(8936002)(38100700001)(921005)(6512007)(66946007)(15650500001)(2906002)(2616005)(956004)(5660300002)(86362001)(478600001)(6486002)(26005)(16526019)(186003)(36756003)(1076003)(38350700001)(8676002)(4326008)(66556008)(66476007)(69590400012)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OZPbXzBQC9xZHJSjqJ1dFioTB6y75mSWEu1NtaMpCMu7Ui8ESSzZgPVy/kPy?=
 =?us-ascii?Q?yqjy9pfv9Z3EnHHQrDEW6e22CziD+fabacjEq601RPfkJdj+AY8CD7T+EfcI?=
 =?us-ascii?Q?6jW+CtdQ1gf4nbXLC/erJ4AbS4l2WcZ1vY8pmVpCA4Dc0awC1bfxmBXK3Agy?=
 =?us-ascii?Q?QtXIWmXrn7I8qtHgZj5lUgp/bZbL0HQoSOetQDGKwHMbaYVYMYLqHqaUnOvs?=
 =?us-ascii?Q?l6YRtZ4tPo/rM/QSKesFtyJrw29u+FHJG+54N2qB0oifzB282/lZWeHmRtWZ?=
 =?us-ascii?Q?+SNNrNgaaiXHmZGQfbK8n3bYGarX/tLWh3mq4yLsfxBQfvWADKeG+WRGlJwK?=
 =?us-ascii?Q?k49+veOMSraAycuMbHLh+91ONc5MRV6Tjkx5fkKqSoif7rJgrtswlZZReyK7?=
 =?us-ascii?Q?DX1mxrENxGmS2s+otSomijrA7EHmXpeSpX2cfAS63E4jV2+xmzkQvDrmPa3G?=
 =?us-ascii?Q?FTWEvkDV8Xz85up/6Me/Gk7duCP75KkR19PwnMVJsPmE6p6YSO5bbSpueiGy?=
 =?us-ascii?Q?8IK/UkkU0cqTGLK2iiNxmJD7KHtyyMk0p4hKtJDezfqjJIYv0BhaHNhFH70e?=
 =?us-ascii?Q?TFfWfGlrs5yInpGMYHvlMy2dncQJA6XNaTjYkbAvLFh3QfMioEe1GqTAh+kF?=
 =?us-ascii?Q?b9dgCFcrux7G7v0+2Rc+zMY+cr44+y0KraQDLvLVTY7nHVYvXp7Ot08eKPR7?=
 =?us-ascii?Q?wLjjcj4meVtUH4KnnWbW+BzzwiakmoeDXxBrHGiR9BvOOI6MinStx/cdLkdt?=
 =?us-ascii?Q?0iocDB8rMUXOkagFYOXnpNXUpUMz9Nexi3jK31HDF6cb+/QWGjKA2cnW4Xj0?=
 =?us-ascii?Q?0R9KPNTajsdcn5RQvNCAsYq2XlnfQXqFUGZAmw7bNIbovmz4zIRa1NR5jkib?=
 =?us-ascii?Q?+lrBTh8BXKC9KKOk8ynQcad6BR4jCm6YLtYc1VhpFdLO/bRTTmy/DLAib5jb?=
 =?us-ascii?Q?jKfpxLsSCol6x9WEix+F6q7fOznaudLDSggWgiAQkmpbn3ZM65AakRuWiLi7?=
 =?us-ascii?Q?GFvNfPVnm+KPDzqC2CcARnh9GRBgCa0QuoaNEU6OEWvcQyON56zs6YiljKcV?=
 =?us-ascii?Q?9GVRlU48rX7DlvDTJK2YO2G91oo3ZGL8EFeepJswO/tFRqvLjcOrxEzHDSdg?=
 =?us-ascii?Q?8GTHNedA2Xq6riHWJrT+oQ8C6nr3mn8TUoP93ZeI+DE8sfNUiSg9GPB0+jwV?=
 =?us-ascii?Q?oSdTBT4VH0a0HkoaJhMRGZ+on2eoCiRwn4XuUJo5UW64yN3suEC8VHkFSpUr?=
 =?us-ascii?Q?zPgnx4i7Apq8qTaqeK69EmMu7lERiEH/aoYWGnRd+hdTGbKOfJ9WjCvseCgg?=
 =?us-ascii?Q?iuMMuH0UA+PV3vz/5aDkMtbr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76df81a-1c5d-49b8-564d-08d8f8da2faf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:46.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYO8D3/i0H2kHbxndFintCtR9wPDhljPJZH5B9CZ0cDP+WmkNbUaF/EwB/cU9JjwlwPD1RutEbbll+vETJfBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3516
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Update the description of the second entry of 'fsl,pcie-scfg' property,
as the LS1043A PCIe controller also has some control registers in SCFG
block, while it has 3 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V4:
 - Rebased against the latest code base

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index d633c1fabdb4..8231f6729385 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -34,7 +34,7 @@ Required properties:
   "intr": The interrupt that is asserted for controller interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
-  The second entry must be '0' or '1' based on physical PCIe controller index.
+  The second entry is the physical PCIe controller index starting from '0'.
   This is used to get SCFG PEXN registers
 - dma-coherent: Indicates that the hardware IP block can ensure the coherency
   of the data transferred from/to the IP block. This can avoid the software
-- 
2.17.1

