Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408706350A6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 07:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiKWGpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 01:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiKWGpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 01:45:30 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75EBF60B5;
        Tue, 22 Nov 2022 22:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnfWLjX0abhW4yetRWTXtXktUrASVkbYKpm0igmobUD/hofD/dLjp6uogsGpPGCcF6MXxk6L2CXzBI3CnzK6qwkokdHvXXnJuLwe3MvXOQxKteI/z3rosuqWB21EVCofxR+DwT5qaLGO0lspLiJB0ZPbSvyZsrbXmgN8dnEI6BqYQKNhi6Tz0XZ0HBvF6cMKlhE/FPKmbKDsFGoISHAuKELnkDWYbK4Etlz9kBNbOxOvHV404OKu1ksDJXhqOW+4QXhT/rHVnmBvAZMdMOC1OSVXBgROmJokGYJgPbzHfTLvIQlSpI6FAU24AkrmQuV80QqCXTjgLPIu+hcA1BbTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2arYZU2ZHRES2ZqQw8TmGnHItgfYQYqrc6T/YUHHkY=;
 b=JOYxy5YuxAK5WjFs1C5nFFhLZozeZq/DY1YDf5hhxY5sgNGATKWbzk7vGy2uBKDvxPZ4ivGtQD41VeoFMlP/tEOU/lCrPZUuichKkPiG0dDcLsgkKON3EYN3dqfKx4Y2L8efAtRUJRtOICc0Yz23FTz34Vn81F9TF7JacXJ7t5SQPg0OQ0e6BjknMTLgwSxguqah2W5qO/FTd65Db3J3913ZH5CiA2KUNumdEDsUmvU87Z0sdLVYjsxco4OYm5DTYfclec9TjU+q7+KNILnOXKko4/LFijDpzWPWnPb8AnTFcwoggJ2McRg9XMpE1+a1QGYPWm/jsAgnps0ByhzKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2arYZU2ZHRES2ZqQw8TmGnHItgfYQYqrc6T/YUHHkY=;
 b=P/U79OnhrTC3uNbeI9Wp3z3pvNumxKtvsII7c4szu5k8x+zsRXJI9jYDtUeHZJs4sSAo1yO/tOk8+UYbKIQhnZQiZTZ3XzMp4n6HEYIpCjAnyUFM9lwvyhXDdThjT73/cNnsrXRDtTr4ck9jlbxLrcQuHCCM2sIIVfIrvZBLVpfN/UAML3ETH4XEVdFI0AW1d/Ek41pyzzq6D6my/q5yC4J2eIVx6n61WAC37O1HplN8URwqat9+iFieTexXfvSHXN0nLbLwOQup66pf1ApUHIgDEOrIgtFB4fet4DquOxTO2k2Dcyv6G9gf9LFj15T7jt+bu2WNSY1iCHwIQGE90g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 06:45:23 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 06:45:23 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     bhelgaas@google.com, sr@denx.de, pali@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] PCI/portdrv: Use ENOSPC instead of EIO
Date:   Wed, 23 Nov 2022 14:45:02 +0800
Message-Id: <20221123064502.2061-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|PSAPR06MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b10cc71-74d8-4aee-c31a-08dacd1e4c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TdWoH5TqBJhBc1QoflIe69HrZdykh1XMFyBp7w5N2GITfR+hq0Gqt4cnpUDTb0qHL/YfbHMSeFntEV6pWclYTthI5qo2yJ9R2akQeSoHld23VHV+6Dt3fF5+oeSa5nEgo2ZQ74ObeLRZ/ZwWdUsvWf4cLirz/yfmjeVB1ZUDcrFxv35ddNkk00mBQ0uipCL7B5o1xEgRW7Fii+gKS3GQy4J7gOIpPMJY/ZNSPCg6tphC7zxZ7m4qTZ+FY4cnIBT30X8LWIHc/UDCK5+720vXyxuMXmqt1HMfK+Sp3mF4tv6NWAYSecpiEqhSiQLR5tirdgArxngCh2DdFBQ3YkNljiN14cEgHIXpwOi+KQn0DoirCoJyBTpGd84T+fRWyCmsSDaMaFEjZRb09XN60JX6znBIYZXanhFn2BrmgUGH4oP7nvZZgZV4r8yM4Sy4+WcjeX+9vQUPuyZIwg+bermWFgwGahpqxk0X38EzRIqa7iNBbH1lNDF+FWNucpGIQ8IiugqkC2urrhyNmlfUKB1QUuyvCg/gSaKkzc6Fah8qcC3KSxkFkQhqoqCjbd3zcTw/1gmkoR9nVtwrczRtDm1J+9fXMFWd+ZJZF2LnFwmwDsHI38w/96v/ycyEcCmf84fu9ZYT/VafWgdEX6rNcNMZalsuWNw0lKrzfuimcDYhhlyfZT1iWTdEaXF3Hxnppx/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(36756003)(86362001)(52116002)(4744005)(44832011)(26005)(5660300002)(2906002)(186003)(83380400001)(2616005)(6512007)(1076003)(38350700002)(38100700002)(6486002)(66556008)(66476007)(6506007)(107886003)(4326008)(478600001)(41300700001)(8936002)(8676002)(66946007)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfrlefG34CPsdEVAcD6S+Lh44LsXUP+9Uz42T93gax1bsSEgnN98rXIcm/0J?=
 =?us-ascii?Q?ey1i8lXmB5MOrijojQbLssCRbzAePkwEQ/I/MTf6LyQl96m6TaFaRfATbHtz?=
 =?us-ascii?Q?DYl82nlRIPDEdZMKntdoe5yxW07GFrApl3swXOgnIQnkrxIMxpdmqEg3Bddx?=
 =?us-ascii?Q?M5RYcukDDyHI9gBPnvfSar9G3W3HHkeNxvdP+3OQAPUbfhC/NexnCBlKP/jA?=
 =?us-ascii?Q?nDQ+AlUcOi3rvCR34e8QZOTB7o9PtDjv32QdGc759AK8OMTWZ9qDs2caWB2g?=
 =?us-ascii?Q?lCVEWx134DkSKi6ghGUv7hi5nXHMGYG8Uk4mKFP8q/qOl8ddcbPwjCUWiNPi?=
 =?us-ascii?Q?yCvPQilnpx+Npo1M8dqGFL7Kn1TCt1leu/s5sYGE/P4tbmJdLBL+pHoZ2Mxq?=
 =?us-ascii?Q?MsSKeqhzNbc6zFyhRwvvazoWFrpqtfxp7413TtHvUbt+wlSEaywqNbt/XhiX?=
 =?us-ascii?Q?vXxxZMNLeIk28wEmGI62m/bTgRCCEWvMajpl7+PsdiaVU9AtZDhzEp3cvKM7?=
 =?us-ascii?Q?/Dv8sfYq4TLZ+XquoBTCdwpNx0cGWukMSIc2K3n8Qpz71NgEyU3tDiyLerS5?=
 =?us-ascii?Q?6lrNqJ0hunvz9pCu70f6QXZQgTxG3zqIGfY676JJzs8rgxL3sQM26wG5q5C1?=
 =?us-ascii?Q?XQyjpDPB+wM9E36cW+GF6ExYorkmDHqN7duoq3QVtZ2lOppFtIsfryLdfClL?=
 =?us-ascii?Q?XJr0FNeZt2bAzYSGTfHwVLCmhHjocOM9FDVPYC/UIGO3jZ91xP6YKlnjXuIm?=
 =?us-ascii?Q?I6m0HR5dCZgmkBiIX/9A1ieTBMJZRHBzN0DOOqrEnI/QzY4oV00dIv9o0PTT?=
 =?us-ascii?Q?LNBKFS/JNxJKjJueKqHrCBy1PmCfc3bPVmePV9nYeD6pvNozLe4r5vj7QkDe?=
 =?us-ascii?Q?9xiw2IxQAHcQtY06jrsBptjqBQHkuM5oqwJ/h/YB/5OprsH+3LktciYqjRdj?=
 =?us-ascii?Q?uJxFhfuvYZOgWZpFg1+JPt0YZzfWHJK+MSEYOM1tLHuz5XbuR4N+BOBzVx1E?=
 =?us-ascii?Q?urpsJTRkzvPyDUVK1WsJeilZYdfLw9KzKvXDv9f7qMUamH/W7n4kZqLWyOZB?=
 =?us-ascii?Q?yyLGcLYHlTzn02Z/Eho3c9lISCJd+5Esqg0H2pzMU2w6MuNCQg+Y2X+HAozz?=
 =?us-ascii?Q?h5Mu6xkS3sL92py7t7qFGj8foBPWpa/t003QtbmCmVkxoQgszfYWvmrYh9xX?=
 =?us-ascii?Q?maL9AF0bj9pdXMLEP+YAaF8LoYG7YIX/yZqJ2x0+6boboMKyCVIp4UzDzms8?=
 =?us-ascii?Q?K0ORaUr+3Ixrwjk0cao8J32ccbHHDCLGFNelDftpVm0D9bIWMCUjItcId+Bz?=
 =?us-ascii?Q?eJFmQuTkbQe6dd49y5nwdkboVBibv0kS6MQOe9TiWDkLMBZQXavvmoYdcCma?=
 =?us-ascii?Q?hpUuKs48a4nOBB7iRoI3s1WlxhTcubPRF//0YD6t4I8SWjJ1BbnOdOOpV71+?=
 =?us-ascii?Q?ZCX5kZGtRi++NqXTJdRjYnBkxJn2BRsKM3EWFKhj4t4uWSxqOYBQLwp8PlQN?=
 =?us-ascii?Q?XvY44Kh+ccWiTXUXtQQfx7JCoZVewg10IZbxNaCgKVCmI3Qm8WRbpuuBhmg8?=
 =?us-ascii?Q?l8MFPVxDx1UMFFOKbxxOqTdQt1e4sncLbRQCCE7Fes/AKxrmkIU13Vt5XkJ9?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b10cc71-74d8-4aee-c31a-08dacd1e4c11
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 06:45:23.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkqU4DP2e+bEiV067qppRaZGDr+lgIuNmMi/NyEQtFnbGNCdFpa9VABlogHevLxocuiNc3zXT3U7zxJQDCrKyaUxwbJBHiGTzXX52p11Xfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If pcie_message_numbers can't provide the vector cap
which pme&aer&dpc requested,it should be return ENOSPC for better.

No functional change intended.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/pci/pcie/portdrv_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1ac7fec47d6f..473a70210313 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -113,7 +113,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
 	if (nvec > nr_entries) {
 		pci_free_irq_vectors(dev);
-		return -EIO;
+		return -ENOSPC;
 	}
 
 	/*
-- 
2.25.1

