Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C66371E7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 06:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKXFvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 00:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXFvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 00:51:12 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29077C6896;
        Wed, 23 Nov 2022 21:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YssmKPDNrdIZAX4uTTrX5V09sDh1YFDCHKw8aQ680pHq4lJQoJfNQoQHf6x3KLx03OUThxsL30eGpvhKzADxRX2m8k8VoklaZMzCc7li5DLzcwXYz1wtpYn/4BbA4ZgoGr8hqg1ezyZrGL4a999Fz+0Ztmmc57Zp/CrLiIYRq7fh4mDeILCJcEg6UXMzjVvnEyd8frm8VnNPRUS4c01f/+IrpfGypY9s4kT0tmZF5dxUQjG4ura6gOG4evqjtlFiB8SwZY6bDT7p3INm6narAtZTy2vWxbWrJ2bltg3T9E1rtpRWG6Powf34t2HSm6224rH7/sdF/k/Z9DQaM3LftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqk0haMkUELkhka90hz7fNXOseyw1Mx6qLdspYNQTZg=;
 b=Y7Y0L/OYjDOq0w/0ZgEHMCbSfWrOj3y3yIo+e3vAoKTslvlAxjUn8bYEhJVLgQjp8w4u+ULmD9Uu6j4XPYpzNazLWf1K7qvLLfXsOqfPGN5FDAUy7/i5Nnv03HjCpY8vXpA8Mcahbxaw5fQILfgxtF71Zf67aeeCmtXtmlu8xIgqdfNCPGvCu9arQk87ZqAZMluRpu6xW9fFhzaeLeqcXnR74HJ8xZxSm8WksRu8RnXI3D5R3Jh5r8uZFtoUeEgSRKsprWlLed4hgFliyYBM09UIGMqOeUH3Y5zfJJPJBJKbyj+yhkYQEZr+yhXZczAwGwsHg1NxFqhqEPlnHNDVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqk0haMkUELkhka90hz7fNXOseyw1Mx6qLdspYNQTZg=;
 b=s8F4cLN5mXHPyJyqcWzA4invpGg2FYOmWrDzlvlmMGMPW5JH8kbo5wsa9DYVk7FlMz0dhDnovFGQC8wm36cl2pXAakaCKshLCZk9WG4n45hkF17lCEVa4ffHZyMVRSW9b++IcBWf6xw/7Pnf+jneIsyJ1XGbOQ0rANUr+J3I1Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 05:51:09 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Thu, 24 Nov
 2022 05:51:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lznuaa@gmail.com,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change doorbell register offset calc mathod
Date:   Thu, 24 Nov 2022 00:50:35 -0500
Message-Id: <20221124055036.1630573-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124055036.1630573-1-Frank.Li@nxp.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: a6870bdd-d50f-4c25-66f1-08dacddfe2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eis+NDbEcKvz2Y/QIhXqPi2reNgsEufe75/jGIQk/8djQJdOB8DgqQX/vpKwNG+uf8eWO22axbiwm23sgZSV2cb6JP75PdoPAzPvC33ekyE+UKPHVWVb6LuJIY3QyOwEBpugrxiP3vactcsSnZ3BAn750tkQ+lZKN/nuon0rE9w5rFZOWaYmK3VsKsGxuXSNSpU/N/acFpCfWiZvRl8wmFcUGnJ/fm8Pcs0bJqFZTuRFagzgPe0z6BvqtcRwbqfCDgIwtNe8hoRVHWFE16Ms7+2HU7kOx4mQ9hvG9/LAoIiq+shz50/pWL2bo91+Y+0FY+moUQlg8lIRg5GRV2y2ffiywJ/cUN+u3/UMqIKjYUN28EWqbSpF6ZPqFvWHvlWuYXbbQv2FHee6ZyouWhv+EaaLQeVfZIdaKIo+1yPQyyyeKdav2CU6063VZaKSCDmgz3xnUgya5ABv7Tk3ctvMsaasIrfJHu3CQ2dtC2jkKXWZEs15eNFmqG9ZVenBlRuZkmKMwTbladZDHxIBlcdyRyAkT/3HY01TgbTCbYY3ddnFvCI65MocGNMJ0H9qPzEgl1DNRNWhLzx3Rov94Win42SZgjBOYPpgmg5WmDKZB8uvFi3TaMVMEJugVfSJjqo/l6NVQDFJSLOi7rnb5WKGMlnLKoy7ENh4RCUv38uYcvRR8l6HbjRMRuR2VOfKZEn7dz6vyzfJdGDt3ZQnUp4/4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(7416002)(86362001)(38350700002)(4326008)(2906002)(83380400001)(38100700002)(316002)(8936002)(8676002)(66476007)(1076003)(6916009)(2616005)(6486002)(36756003)(478600001)(186003)(6506007)(66946007)(6512007)(5660300002)(66556008)(26005)(6666004)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysYt8I2t18Se0iXW1UuuoHNHrc/y96l68rqLY+xtIjrYbgKVNlCES/xgPmgP?=
 =?us-ascii?Q?QdaqVzqlf/S3yDSnUCzs5u2Gu2kgDtOERo+tYoJwcUlSiRmCjXitXlZn4nwf?=
 =?us-ascii?Q?Z0qkNuWI9Uo6yHaKTAhawpWzmhF5VzFfS+aHAX6kFwZOvpLCTUcqo662uzPF?=
 =?us-ascii?Q?4YnGJifszOb8wo4mQDxqv7TRyhg1A6LUwCeLZU6KLQkwBq+1p7Lc1GPuVGw3?=
 =?us-ascii?Q?5p/AqTyVvFIVK8nVRc91zArq3PLWCARsV6WzrdAm+x9cDKAFz+3YVsBagkAa?=
 =?us-ascii?Q?Lo0K+hjnREJXb5RXfS0H0bzAQRzOQCrtZXK1GCw3A/Bipvovh4Xp4Q4b2Lfa?=
 =?us-ascii?Q?cVKALXRb0X6ifXMYRERxlQk1oIYD2U1IWe2W9ZYlzZeaC5F4BYGQ48X4Z49U?=
 =?us-ascii?Q?UlK6P/U20G+LF/goI+bNBpqV33GtYO4kuzRc0h1PZltrrhy1WL5gNux7dDnK?=
 =?us-ascii?Q?17baCGoa26tzGeRfd+VhyBP/mARJ1r4XcufiCqCLjbJdW6u7xgLbnK/4+EyW?=
 =?us-ascii?Q?4es/z1ilDWWYXFziBwu+NquplRXb6CHgC57y7TtyLZivfUL1TuloohQnZzYF?=
 =?us-ascii?Q?8lsM/MBxe8alWPJDMkHBaPGJ7p7QF9ldQWRQ/jvs7m6MLAADcoHfWoZKfMXC?=
 =?us-ascii?Q?G8nTJ8vmdo/P3C/KQ4P16orrz0kgIX0xmPK7jwbSra+H1oukocVHm+hUydeB?=
 =?us-ascii?Q?R+3gFCv7RF9qGhE3GeIayItfgyM9uz1xoU0DiS7Uw/XluiZfaE7SLZMtcz8m?=
 =?us-ascii?Q?uGUypArTN2yoDuDWkP7hwhwyM0RwktMl0MAIDQAZ6gZY9/hP9ZPfECyUj9OI?=
 =?us-ascii?Q?2m6voBLU8vDGD86sri5gRJqRMqftS7MUvAoKjMWyPy9EkAPv42mV7ZozLQ+t?=
 =?us-ascii?Q?10DMXKeElUwMrx2MjoMicjEelW1lqveJQHHuZQ62iDq8YEsXqtFEYThK4VNP?=
 =?us-ascii?Q?3hDn1Yqi3dyqpk2Wm6oBv0RSb+LduGueYbDARql+J8ka2QhjHX128ya7wwfZ?=
 =?us-ascii?Q?yJPjckzgczDzks+U6+idXsSfBeqC0CCRTrjWjs+BKWZeKPffR64F9ihqyCNw?=
 =?us-ascii?Q?nkMcLU9E5P/Wz0XDKshRpvnQOWmlc119RaIFtXvrSN0TKFBfpM6weH4aph6h?=
 =?us-ascii?Q?XuMhpXKWswUWbvdTnos/QfOFM/shwpxnheQyF8XkKCnZyEYFK5sWYFQAG8nH?=
 =?us-ascii?Q?bTQTSEHzpvdDs4peiYEMW+k0LzbpeiBLl/16uX7vKkCUL82wz50tLMXpsRkS?=
 =?us-ascii?Q?eZUEQ89dTYDxdwNQiPWIKgAttNo4e+Gdp6ANzlongoLwVkor2jP6voC6Ms3i?=
 =?us-ascii?Q?Z/w3mNkYnQyD1LgYnjejzUl9Za+M1obcK7iQLda8VcWCkV1TmDj0LN+WGHNF?=
 =?us-ascii?Q?vTobDO70N9VcOWK4VbdXsEoIOUqLXOka4pdjPJ7u3FBotI0vUYboG78vPTsG?=
 =?us-ascii?Q?fRuno7p+QnEPR7Obqravhcprf48oxvEN3Xz+Z/xPEp122CC2/cxVS9ZjAWaT?=
 =?us-ascii?Q?FPrF2T3K3mjZ6uNnv3OIILZeEd6nQll9tK8b7lQiYh3t8lAWphIB8Ra+bQBU?=
 =?us-ascii?Q?vWBReDMiJiKly27qfVGNcFxVM+pkukvAocNWzSbw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6870bdd-d50f-4c25-66f1-08dacddfe2a6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:51:09.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rBREURmx04wx4Dn+qQS1uVD/ib6dFI9zj4Vi1lJk/ZVRzN+pJtp2W7izOzSOP+Ee9Zc3PCitSK4G6zSx9g9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In drivers/ntb/hw/epf/ntb_hw_epf.c
ntb_epf_peer_db_set()
{
   ...
   db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
   writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
               db_offset);
   ...
}

The door register offset's formular is
	offset = db_entry_size * interrupt_num + db_offset[interrupt_number]

Previous db_entry_size is 4, all db_offset is 0.
	irq | offset
       --------------
         0     0
         1     4
         2     8
        ...

Change to db_entry_size is 0 and db_offset is 0, 4, 8, ...
So we can get the same map value between irq and offset. This will be
convenience for hardware doorbell register memory map.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 04698e7995a5..0d744975f815 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -461,11 +461,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = sizeof(u32);
+	ctrl->db_entry_size = 0;
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = sizeof(u32) * i;
 	}
 
 	return 0;
-- 
2.34.1

