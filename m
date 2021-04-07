Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032153561AF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbhDGDEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:04:16 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:24289
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348242AbhDGDEJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMZ9LLlvRMUsLxedR4lDCZ1eaRmqmDZhpje48a9uPiT37IKQ4tOD38wxVplCBtAO6xJTrkbC231lfw60RiFQCAKIY6xHlB0yCdChkNiGaMkG9tTUft5dU/C42FRpEmLjlu8CpDj7WOAMfdPK9v3swJu/sas+WjoyHbJ1riXAGnbHucCHWE0b4BLxbt5v9FeBTw4mQbpikX3umkTBpSIyED2hylUsJanqgj2oJGiuZO/wfRGTSXgg6g1lHkaa00OsqeNWTUMFG/3Z03w9DrjEOATav6QF4BAM1rVwx3H9RURu2jURSkYIXxp8V8gvrCR5gzi9UvQJjBbn4aubEqClSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzv1Cgjir5RKDEfup/QVU5uhiZAlb/vI5ETZ03SKVW4=;
 b=OW/+wQxRSHLgyqF3eHfYDKiiEUbxWpGQILRCI0tCdUgBumXw5iB3H4Lj79ubkyD4S27OsOJ5HLSQMWvxW8mJDn8mZj5jFrfjBcTNUvJcFU2zPh38oNyIIqS/9aIW4pP47Ev6LntBxyNvGpF891BvrUB0MwWOOh5oGYZ44iEfnd8Q5Beqg2pbzW9rGvTcACz2NkK6H0rTHRL/di7nhgjh3JlfO6xCnlMl51z0K2rvPbnEScJk8y815Zc5yW/foSKwRj61tFvdkxBmJAcp4eVKAoMkTeyDUcQMPO+fgzT2rCIg2NI0rYqdlA4rkn9CkQEqEMgfJFpjXyO/zZh3Eb8/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzv1Cgjir5RKDEfup/QVU5uhiZAlb/vI5ETZ03SKVW4=;
 b=KvPw1RzTB2LusElas7/qATNrnUCRA7gfN1J7wf0hcVGWbbf6Od0moKvAGlSL1hboNTq19boGnyU1SD2k+ahDpaoJ5F3pcde2QzWrtQf5Qu+ugHIHGIagOsuiXJOZkYWNWv1Jwfby/6hl9PlDjL9YFPcVIoXdEQmH2zIEJS2GBos=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:03:57 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:03:57 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 4/6] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
Date:   Wed,  7 Apr 2021 11:09:46 +0800
Message-Id: <20210407030948.3845-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2410e1e-3f10-4570-afc0-08d8f971c8b9
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB32763DB9E032CA483B294B7884759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrFHjxlRs57od5Mx8ogCLICw1B6wIfCs/7Mr8tb2GgK58gJUJx150XNup2PAD1RMEeos+LSYrvKLMDLgxs2Ehe3egkfMBHgmytxLCmbg4e+dfzDPagQwfq1FRXLUD+K2CniepUy+u36ESACr74RtSBSuU9NUwadHFE8sskUzplLrxxGE/61QOl7y5WYXHGxwWk4RsdblBCM6jrI4FGY1d+tGZq8iYW3Kjh/U3drPqVKFUFqloXN1TqFdpLaQK5w0ykExeftbWQ5SciMlGt/nDVk94b41MWg1Qc8uHeP7vHoa9MfVFik7i9+gPOF1hEv3q4Yk6jNb2Dd7fSFB4fS80aaDjUbfCreVDfM0nFqhjjlMTeIs93pOCILKrSpj208Hy32CxQPrBdfXDxNrb4x1723P7p14qdDr8/tfdmgerkJDAgUTID9Avr2QK20HCb2V8qw+lerxvNH2UZFivGJ5ODGxpK9QlVE6ryu9r9ghLWVg6nxyJDpnuKuiMpldBwv95oRYNu55y+8Rmb2kAK9P/jI5eRC6gFkrbdlqK5FMV+rLVBYuxAvoTveZ7CKmOaMASZjB3S0TAVarXzowcqC6xRPtXsIQlLl+Anr5+A07kpRniJQ/iIWFRJIh1kO1A9DVWOE7v2moU6mQsnmvX8wCl+Cmrz/6OCbomplGYsk6qhxrPorw21IlMZrOMf3tuWwFAXD1tSF1LLMcAwblFfhq2TZhSFz5DRvpfNNfWKPPxfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(15650500001)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XGVyigjO29flqhrDdugI+qI1UbohvOamrjOrcZQGxebcEbJkE0DGE/r0uM02?=
 =?us-ascii?Q?m6R22EgfZouFvAKkBIqMs8IWS3jcEXNiaO23qdwlnqd8X9MW0WVOycm5h/XH?=
 =?us-ascii?Q?A6ZuoffED654Q9/nQFYLhL9UL2fQoEh9Th7CfI675SEuoztUaQrjjFTu8nhT?=
 =?us-ascii?Q?CiY5zcthJLWEghRJmREg5yXzmacwRHejUcTKbAzwDnEYZtBOKIdgiK6dEIMH?=
 =?us-ascii?Q?1Sv1IWIb+T78mP/z2cyeWbwnFNMnwk3keabJkKtKlGPmyCG8kE3myYlyH2JL?=
 =?us-ascii?Q?C/wvN9H1m8PTppMbYJpgCe4MG3qOi4RcdI0TJIGAVAnaxysKfr9gM9VhbZ2b?=
 =?us-ascii?Q?JYZZ73PvC6lmihUEqXiN6Mu+T2GTNcC8DSNxRQZdCqQEGh5ao/9h2pYr9TNU?=
 =?us-ascii?Q?HdsgOCHDFroM8fNxCPcYJWPtM/BjkiTxAx8NvMUyo7L7zSx41GxShOyfBNMB?=
 =?us-ascii?Q?I2UtxBYNFzdOKW8Tl0ntL30+Zq7hNb1LaTcJHww8Zs4G3U+jY8Pq8ePmgVlO?=
 =?us-ascii?Q?fMULcTDvvtIKNGQc3RFt4hgv3N6BmrcqAZzbj3sx6YQycjjFhS7guXDFgWLE?=
 =?us-ascii?Q?EwLedS5wartENW7jx83BKiU0CLmlAnhKn9q/t27NIWSI3ZBHx26gOiBSvd1N?=
 =?us-ascii?Q?CqsYZ5ALYdx95wrMOv7TpXc7tdS4ZBnVrUhy2xab3LEZTUmNvuyS/XXg79hO?=
 =?us-ascii?Q?IF4r4CvVHPnDjrm4H2gndzMPZy2nEuf9HWWIZTHxBKReU5fd/YD9j9ENTlMw?=
 =?us-ascii?Q?CTz7mwKpP/+zyFh8zmtkKb2SznJ/7DUV6bMFXVhqXE7eClc89eyCGPF6V2Sl?=
 =?us-ascii?Q?8ZbDPFxBVhcEqRmkWyd2eBQ5ScX3tPyy8V9Km7juYaXGFBn8fzWAy0c5FZPp?=
 =?us-ascii?Q?wfOa0XcFmYHCykLdJdJhNznD2+5f4W0ko1Q49jr6lDSsamNdF0AajQ97Bn6W?=
 =?us-ascii?Q?gFkxCspTNBC/4PPhS5vltED+YPdv6jC52uHGcom7Cvg2QC1Ii50gC7MMhL7O?=
 =?us-ascii?Q?B5F3UnCq6QC6cWdOSTOmpJm9E2x9qDIAD/CzUzyOlWC/j84/0fTAd4UYvBW+?=
 =?us-ascii?Q?aOjuP1OAkINfTt1nWtYpl4/dH/JFjlgSl78f5mRZdEAqF52lZOxr9JboNVM8?=
 =?us-ascii?Q?SgKMkvwQkwtCjm2qZ0t2BO4qdG3kdVUwmUzzaFyiOAyrqJk/bKtmQfGKH1Nx?=
 =?us-ascii?Q?XMT9ahWGBMp1DxPvK6WESguIUzhcOiLmsNwsQdDFrTWZLNIl1+tN719WbJMO?=
 =?us-ascii?Q?pb9TdYu7w50KER5n3Ts3o9ihh2MxpYX4rfAFhII+YU4VyDw5irZIc9LpZDB3?=
 =?us-ascii?Q?kxzbrllg6t9cNf50R/yQlQ/S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2410e1e-3f10-4570-afc0-08d8f971c8b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:03:57.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ4n5N8FT6SdwNnFaY0LrXWyQX0BdjDShu6kw7DGqgQiLf2w5yHLA3Gkkp3VDGadL4DW4ed2v9vhZmkZBGdI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
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
V5:
 - No change

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

