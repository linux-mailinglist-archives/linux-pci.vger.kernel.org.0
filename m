Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14987604D99
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiJSQju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiJSQji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216F64DF;
        Wed, 19 Oct 2022 09:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gubS8LUL9I5nDeV8s/PrBEhSBT5MAllUUuDO5X6FjN3xrBbT59Vsc9J3u3EmkVpADA42uItVqWUvhTxc6H2FGeMQWv9Q/yFyE883G3XREC5GzBynk7MdxbZeQfZBztxFlkzVvkylEXWOm/yfeBdhsmvBmfMIytmT2NJ1L6401F2p2zMuGSh7MZu9rY5xNgbKLL9T3YkEc4OH2BNNk0O0x1dyncFBaJiw1nxaB+ARJ/urlImDIa39NEjnntBiKxZyiflC8XxJlJoMxO25jEhdv82j+K6K6Kit22xcyiXfeXDIuxXdeSbM9PW1mpQ2yWHoRS8kgNOCJKrPILTdN6GuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=BFNi/jxP/5BAgF3DZLJRqXRo2+1LYBuw8CBI7Lp5AU5NzCtzBTlgWiOqGmIPy4Vi3xy3/gF4fKcULAGzDZ34IQYW4piL2nnixOeqY6x8HF0Rzw+KzHmEjDG7qyOMQE+BvZEvSVy6P/HmEc6KNjo9qsRrTOHQsb1iHstjCnAqUrTydO5gFXKRDDerEbtGY2L9Axgj2yqsOFR9QUYBig+QpPM5cmoePqsCbK2EbXUKMiEwqYlzRy7c2L7KMq/85u0O557N/eJrSCCrGCb71xXhaqNvDTjfsv0UifiTaNLA6WhZSszOiVEj8H3q/ocIICuUMd3f8msO7B05uywRrMuLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=an/Lo6pTgMqakPmrcxXSwoKbcz77vDrQ/HiKq4S0U3ti+s43++UFOQeC7E9ewovUqYedauo2bGrXooVq7CjBxxGegoNsTmsnrEx3Aw/CG6kbeT4M4MXYEb3Hy+nsesK9eSnvIkuQzXtKNYiXopTv1pFw1INDY4/NXffRcrsnz6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:27 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:27 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 3/6] PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err path
Date:   Wed, 19 Oct 2022 12:38:52 -0400
Message-Id: <20221019163855.1267295-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019163855.1267295-1-Frank.Li@nxp.com>
References: <20221019163855.1267295-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e0ecda-74f5-4c4b-8551-08dab1f07c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rG1lKt4VJlAuHWeYFWIXTYkgJKJfWL6KcMAJkCQ/e3PS4FLVgVKI5KTQUmz3DlOhAAztwwCM3ezsHTWW1lmgsiylrhSvvsf+4Cjqgz03KzrZpYaAQ1U9o6KNssrvwgue8l/VwqLL+sFNQEvXyYkNomUald2NCSn4J2a9YfscR8SOYDWiBcg5dU0BLkbcihopoAL7LgQaSzQwWKTuYYT6Hu7miEplmJUAfyKejATtwC16ORr+o3+kO5OCd3Itluu1nPbkTuqIbDsWhc5dpvhitusCSWWn01srdG4ARBcfTzsX6fV4fESi9T/0H0kH8YVJo0FClYfYVJ7tC5qYCwGewdafZqH8DsFiCJmFF0BA93xts9u8z0Us6fbETsbPQ89wunNnHQurxMRxZkB+u8ZTx+ruG+leSscnBrm7ChTae+TNZTVJgh2RMh1ULu4Qnx/v6pjo4y8ONbeCQDDqXYy65exDg8PESaFtbbKXTOn15cHnY33SEyjxoKudxLghmE3cgauPkXd51EArYNSX+uybDsvsKiH4W5LKnqiYOvqCNpOD7TdxSlrXI5gD/t0e5uZMPVTBBfuIbeDrCH98jp5OFbtjJxLSmS4lIA73mZFimFUlAywBvKUeOpeHM/oWo9FTJQVoPB67wL+VRdrkfgVFr/oC5re/o3AbeYXr4a7vavSx5Iz64sFctPFIcjQrHZd4Tma2wuKotuqlFm/lTEKNDcTkQq0pxOanw7ly4SShSgZ+npod4h+kOg5K/6SrchcR39gM3csxdjV2vYhV88S4BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(4744005)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hm9w7F13Za4lL42l6MlVy3ARBS3QYuxaneCg0HLyylqWD933WuPvON8/udVr?=
 =?us-ascii?Q?RV6iO4FcVmoqk14w33CBUy7rrwZg5rawgeBtqlXptd4bvrCBmMU7diUlnUBH?=
 =?us-ascii?Q?WDIWKuJQeKpVqOcxC5HwLL2p0MDxO1wHmtZgZFjFBzrbYgN/oDxxuclY1krC?=
 =?us-ascii?Q?XSclIZFg4NTJralpESEsPYcJNRQKPvtRgQTwp4+oda8d4d/ycZg5f0mH5Us+?=
 =?us-ascii?Q?SO7rZT6H6s+mwjZJFLlByD1fcNTipZf3SdaAS8j6Uc4MyXAxTaLAvwdCZGPZ?=
 =?us-ascii?Q?Nh7OPM0dLDwPf/Zb4VbO+AhGMP2qCxTNMBJyIgumwMEDjHp3aSjDYOu9V/Ax?=
 =?us-ascii?Q?PWuquptv6AlWiDNZBuV+4MNQrmfrKjz9RElxWbUONO5G3j6O6Gu7whKZ8p0A?=
 =?us-ascii?Q?RyQvoLX40c4asrYDOB/g6tznyno7AEiuIhAzvCtKxHEbs63EUST9vCM1d1um?=
 =?us-ascii?Q?tz8XIOmopP7zfD4QmKhMzO7IkN/fxqtZQiOAz7JpCTQ3aaLOanswQJglczIV?=
 =?us-ascii?Q?ZQHwssCFDQr8KqZy5b0F9vpzJsx/IecXqLZz8vngTG3QTmzKMtJi4cnEKJdc?=
 =?us-ascii?Q?4xfYiUsYyBRBrl4uahmWGcDLYlGZdkhqf8k3p7MUkKZs2R2fSFpxQMFBr7Cv?=
 =?us-ascii?Q?LUNoUPGAozuu1q00/AiaSF6Ol9T59bJQl8hC/5htdf4C/D59ZVWtgRG3I4QF?=
 =?us-ascii?Q?TIZspJ/OfnZmnF0MTZwquy8JPPilQPXdRoNdobJD5whPCfV4mWHhqrTUsJOE?=
 =?us-ascii?Q?GZXyXtE9vUkpQznz+12hd4hSAunIu87pDr4mYvd6KyygjCcYMXtp+v/ZMxNo?=
 =?us-ascii?Q?nqqga4cJQRIY1PnIzb0EqaoVm2bOYLwF3GfBFAhDtVO0gDrOhQ/VrkfuWbeC?=
 =?us-ascii?Q?Dj2lHUM2GEWf9ryyxANG0yEd9ekpUiuz8L6kPLzY865mO3xbUhuPO42Hqadt?=
 =?us-ascii?Q?xNcyXJxp37ILL7/VooTSZ5qBAem5LIyQl9b75KmWdTye+s24UuGwfmD3jBuG?=
 =?us-ascii?Q?iWP5f3cZs3oFnN+4+haP/HAd+f6J11S8sTeWRG8hSP8hQKBsitZCsg0g/9Ta?=
 =?us-ascii?Q?KBjH/G8AR3PDXbSxpmUtqIKcho61+MKuosoZjuXWPrcZHmDmzQPmfelST+WX?=
 =?us-ascii?Q?M/ofqm/7JSnoCK8S3pO5UKUcSf+Rijr46hpb0zWIxGiq3OTULMriIGgxfjD4?=
 =?us-ascii?Q?KJLsUhd+3bLJBO8r58ZAOhMGXnGA8W7D3t0j36h9pMJ8uuqgqxgnENtcpn+L?=
 =?us-ascii?Q?onuq1ffbdFgXVfyDZm/0orTHM7cA7enTnGl5pe0molV9h9Msl4zWNaBeGMr7?=
 =?us-ascii?Q?ISDPVab/1MMP29nVNMPbhKszV8mxtJk+wE4qJQPXfC1DVbuN4/APCrlGu37D?=
 =?us-ascii?Q?n0fxxf30pdtfgcQyN8ieuB27fKynPIbtvavyUhWapHaQ5RioOE6vs2sKx+iv?=
 =?us-ascii?Q?iLdsQvRQPMPRTyXvg6CT28k4FOlu3F9Gz1eItMUMU/8lCQhLTSi+U3TVf/3+?=
 =?us-ascii?Q?FgBpYnPGcax/I8lGENDlly0dGW1dXWPWxKNoH2mkmkrwuiBfSVah8flKdyzT?=
 =?us-ascii?Q?UNKDPADXzimlb/1cIWBhNR44RnKmnUY7M5T9gY5x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e0ecda-74f5-4c4b-8551-08dab1f07c90
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:27.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFXM8ce7wHC28td4WU2wIJkCKICJIWLoxBKlDjF4K5aDN6v3Ypo7fzDcE43xq6OzXgcIUWHnAqd1qWdjcsMwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1863006cc36c..191924a83454 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -571,7 +571,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
 	return -1;
 }
 
-- 
2.34.1

