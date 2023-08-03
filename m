Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70A76ED87
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbjHCPEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjHCPEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:04:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37330D7;
        Thu,  3 Aug 2023 08:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlsX/KeernljT2nobDIb5Q5Fh5doOhjQAlWxoIRGm2myPoCuOfzWVZDcBgS4H2radw2Hti2QkXXeiTYQWzS/cRTcYrLoMoKZf5Z140a72WfTadEVqMYSi5FxYF5KU0Vv7kaRGwgx6AxmRk1W8fn4olXv32Y0LC5YPrAonBVueVoCadi7Xz4m5Dv4R5UdAy/ikVOvkNMeQMEk8xNfhn6iRvv0HR8k8B8qMfv15ldz2NCFEmZXPu2gULztQ9uVEI6kx9Vhha3dpNetld1TafgHTA3zj3149khgJsRyoOhx11QuVXmZQnXi4X3Ga7xmO5DeYiYmElLWCOetHKHxrXgMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD/znj39K7OopIjlMAM1QWmL7+eY1yePDeR4tqNfJ1s=;
 b=JCZyYK3MEs/9wisk2y4gwsxKM0OfPcGeQn9hGV4Tf1lGQj7kWxyHl43nuhnLNCHf3TSuauTuX3klrkoGlGRdds87vNFm9S0mN9K0I1IWRCbG0xigRiv1aLUOmbLuA601S7QLMSlf1Z1Grb8uwhWz5WsM6zddmKWsk5lSB1dJJ2kRj8HeNqspDDXR6c3IRhb0iru+qRcqMx/HKk18lFxTB7q05fw3cdBeFGbBkoOAL6q0Y+Fn/EiXM2nCzNN73IMcl2n8lqTwADk2a103ykY9Yhh6YJnTD2Mm3YPFliF+kv0G8sXdTOqTrvPW46QAMjd3cq2AtHcJzCD4I2BDfZOEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD/znj39K7OopIjlMAM1QWmL7+eY1yePDeR4tqNfJ1s=;
 b=iHHl+zrCET4DCReWQfs3tmXGiHCn4tt/VkkumSFP4HloUkFgEuO4fd9S0CU+Q0ezadCgp+Smxh+pDbxKsTpklNykL6vIlfdHt2cYwpsoCE9awlBhd+0s3Hdh9Q5Fo9Yn1QzmuPl16ExQWeES63qD7qX8CTOhRBfEp/luzK8o8ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:04:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:04:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v8 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Thu,  3 Aug 2023 11:04:07 -0400
Message-Id: <20230803150409.271155-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803150409.271155-1-Frank.Li@nxp.com>
References: <20230803150409.271155-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7e64b7-4aaf-434b-86c2-08db9432f405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un8k+01l+6bLlB2n2RaM7ZLQYhygJ/AjTXUMH5H9hjxoBaOvhClAHu7Skn5zLUe5RNxNu80uBrPcA56hgjP7ew0ua6B1ofhA8uQeF+tVt+9Qz31VdFTKWRtn5C+WNroTMs7Atxnv0WvQQh+PhNm1QRFKFdM3cui/jBEmEf0Ing5BYYk8j4lPJnbrSXJw9ryLVm9Q+UkQBYhtCYi85fQ8MiHiWbP6MiHMgBi9tv6cjJMwdiM/E3nQ0dGI9MY2zffcWLL91n/8LxpE1+kxhmrlqN66g7/f1l3tBrmOFxZntcbAUHu0fDuDmEYzUxxtVzxiJp7SZG8CL3iLCTVwL8mvc8WV0j35cos0gjLHZspOJJRhAtyF6M4ozfQcq6iucu5/NMyGJ/D3CkYrS6kCQZGvlH7lebB3UWfQGSJ1fj9BYr6e4ajEyS+RrtE1Clgqx0eiMBz2IHBVczzS86mmrGzhDu6feapdBbSnBw1Vf1dCJJEjABERDN/CvhOLW6StPAboenhy+3gqkc3OFVRuNzvoUhXQcm6YFhemFmzh5Ac7xgS6aPo3ovYcyp9jDj0McSx2ZgAyg8urmxhz68xFNMd1ENTqwlZGn4JUCMaEDqIsppsBJr8HiHQUhajwuRC1v8qm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52116002)(1076003)(2616005)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(4744005)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(316002)(66476007)(7416002)(6666004)(6486002)(6512007)(478600001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mbh7VLUyjaOR/e2/h9F0rU09MRe/Ao3lrIqvDEaVLGEjJNpz6YMnx4+Ppay?=
 =?us-ascii?Q?E6cZqbAnPT/iKvpk0EvIQlimPy8wjVgwPgJAwiBBddGAox1iWZEE1oC4KZ6T?=
 =?us-ascii?Q?YcVJLM0DHp4CGUL5q2xr0Hh7swCas9IceUDhrmDynVb5ROQZ5t+A4RQv5LLF?=
 =?us-ascii?Q?zdtcbHmtkXuC2uDhGucepdggPzGkQU0v1hjqqJ9suRrKGSixsUWT986Nyut/?=
 =?us-ascii?Q?F3+B9c8Tilqh5q0/NixNYmquoZOQpXvI2tcfVwUR8Zqew9uHK1kO+Era2Jt0?=
 =?us-ascii?Q?TQQDRtPJM6Y9kKDq6iKl+VkP5VmtU+i8eCbqRIFqayoseE37YzVAES3m/FWo?=
 =?us-ascii?Q?tkAqessGdw2doStjhE5+kkbbR5a+5ldvtlsEBpd8Gcqyih3BTx28dAn2RQWM?=
 =?us-ascii?Q?YsEodhEzPH++NvCkdj+6XqP/c5n9GS/ITujYfnSN2ODzd3G+SKvTlYtWJx4Q?=
 =?us-ascii?Q?+ecoLTh4ZLl0QYZwRCRD884Gh45fSdHuxw1B4COSkZKkzrnvSARQ+TptTq7a?=
 =?us-ascii?Q?U5O0uJo5J70eL3olKgkIupsH7Q8HxrzlALWa5GrS9CaW8QEoo8Qk+aueswYk?=
 =?us-ascii?Q?2hAPyXyYFRm6BW6xzXhDby5t6YO6KYPMPNyy7zwjxAFi3XOQTEe48v2McVF5?=
 =?us-ascii?Q?xoZjUqK3VrkOpyd7pPzM0MO4djvNiYOctZxm+76ug2yySca2RIqk2j/mans9?=
 =?us-ascii?Q?u1B6j4TZix7TXINvmG8wl57fRl3hHX74zflHwlpojdtnb4T2ElmwFIUSzF9w?=
 =?us-ascii?Q?GSB/OU75/hQXbY/idwBqUexgr6X0JfDq3hKr36lxxkN7/wV6Kf9ZGPWoAzfD?=
 =?us-ascii?Q?a5MgVGF9b/W4ZlX9tyY4t8eIZitixaBrWstXIfVRNqlPIBuB2/wxB4G3J9n9?=
 =?us-ascii?Q?00ghh6lB9uhMD2aGq5HaFbSkgZGCTHhdJx+MtCB8kq4cYpsUwwvFbz6r94X+?=
 =?us-ascii?Q?vhKuPCOkBiMCP1+8YQD0qTGECBF+raHLYpyIHN3r4YyX9KhWN7QpMcrHM43d?=
 =?us-ascii?Q?aOUO1uZP/vvRej5KZzYI++AQ+oh/EFGZcBiqfVU4eIhsVPF6+00HqP6uGi0n?=
 =?us-ascii?Q?HNaidDqQX2YR64ERHpo+1p+Fpe+omI2LwBDdlii3vCQcmH4ficXFzgO7xCVo?=
 =?us-ascii?Q?pqp0uWP56orNkZ/csk2rBOnjmYSUXpJ+oYu++ShSZMUH9ppvCzbgm5Bcvvgj?=
 =?us-ascii?Q?4j2sn0h8xaWwuInSdKBuXqUSW8v0XnD9RmV9t+TXiw/W8B4FMWJBdWvxbqyD?=
 =?us-ascii?Q?22V2GvJsp3+nH5ZeXtJY5yGNOQ3Hst1JuqxyHaYmRvyUR7+6m6rRaUBhpr9Q?=
 =?us-ascii?Q?u7roJ2QcO5Rph5GHzq2KaJJSAQM3wbxCR0yC/aVA6AUxzA/5HNNtRgB+SBZU?=
 =?us-ascii?Q?rOM5vBLvTgLdMnfd+Ojup4pbIQ+sgn3HuLCMBXxiY4se1uo8kysqwL2MuFOO?=
 =?us-ascii?Q?6FqxLRXktStdvktoXX0vDPiEo3NrUYwHVB6FIGvxFZECeqUo9lsF+N3Pe277?=
 =?us-ascii?Q?/o10dwxTircKcWQPuLsgeJh/LWjWF3rjAMW6hA7mSIO+zHleVzVCwqUyYp9e?=
 =?us-ascii?Q?EGOQXdCPqyvrs1iqoIzEqjSYZbMQA+ooKs+FRPMw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7e64b7-4aaf-434b-86c2-08db9432f405
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:04:36.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAQzbmHvXVdUPp6FCDyQX/97udVYufFjDRy+98XL61QfiGtkGnuTIb38/SHbgJftDS7DeVMr1nWTAJnVErpI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduces the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
PME (Power Management Event) timeout in the PCI subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..da8156663c825 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,12 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/*
+ * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
+ * Recommends 1ms to 10ms timeout to check L2 ready.
+ */
+#define PCIE_PME_TO_L2_TIMEOUT_US	10000
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1

