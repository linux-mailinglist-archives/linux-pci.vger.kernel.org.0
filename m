Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04C47AA2B8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 23:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjIUVdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjIUVdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 17:33:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2067.outbound.protection.outlook.com [40.92.90.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36044B15F7;
        Thu, 21 Sep 2023 14:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIK/aou300ANbOM+c0HfLH0k/e6VyzXzbUaQJ/Zbn1kD7XrVAzcNknt8fIbq9kmeq8GYQomZ8y4c6gHoXzOwuZD3WVJCFaq1u966Pm4rmgoiBvbVfhx+A1+k8ATrEh2FI2CrrGAURhIqlzN6w4USL222iJUKR0dPo+bgcF/vKfoby9kCjYHeAIL/SIy8k2sOemSnBV/I2CmsZlrLx338e8K/x3Xewldz9y3Rt4FGa/6Eo3SrMHR2TaRAJwDXKAzSw89+AwFjHQ2bWvRfJViaeDkKz1tdSGGNHajy6tf0fwrHCSF1FtFnURiHCEbuqW7vqGogz8HX+hApl3ct2sz8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXRwHGBZPslqxScX8SAhmlZ5qGHbOKg7G2XwmGhIRy4=;
 b=Hhg+oMVa41JUk6GjZIoiHqQbaoWAhl42FDqGWOewduSZo35q5TGfGLP7I/FUZNDjtqHlV++m64HEl1W+WB4TsgvqmeGZGss/rSYqrP+DCwDpic/ozKDifsj9IdcbjwguEPoFAskQ4DaPeJxeGy/ic0AvoKLGU/cHQ0TWkiuYRcMt0qUw5JgxKZVnhc0VklxwnsHnGm2zxYnEtHg1ipnG96wwrMPF/YUbbozQttc5mmT4uN7Beb6O0Z8Q3DegJr+iAQMMjcQW3mLbrOqj5v5Z8gjHTHHbCbW5jbHF9C2LEgA6o2Ms4JIwI8zcUs6vHIL3jYr+J1lZiFfSHLqDtefdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by PA4PR02MB7134.eurprd02.prod.outlook.com (2603:10a6:102:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 21 Sep
 2023 21:09:18 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:09:18 +0000
Date:   Thu, 21 Sep 2023 22:09:16 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org
Subject: [PATCH 1/4] PCI: Add device IDs for Brainboxes/Intashield PX/UC/UP
 cards
Message-ID: <DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [ENOxRf0JsgXwZQaAyKCwWrJE4hv3P/H9]
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQyw_JWDO9akO7YT@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|PA4PR02MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3693ad88-e628-4f7c-6c1c-08dbbae704e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKPcQulvrSt1iZjbPKRTE0hp9UmDNxSEsJcVyCgVO+ZVROfxeuQRIZuI2YcFZU0pZMlB8MtU7HAeInt5NnyBT4r/CjUAsyxhRWgIZ4vzwN0ILThhb/kLprYtkS0GgIsmxnLSBVdpI34T6HOh0pkepLA+Z8jTiOZINy3Z1U4olUxd/WtUJ3ha5uAw3NG9P5g0eoPV0SMNLmSHB3DEmF59qxy93ia8YsaSmEqG2CaS390Ptpmo4deAacgoDg4tBqtlvsA01UEivMRMnrfA4rIcvAFwixgG0qo2G8uBJtqC548DJQGhr/u0ssmAQ/03ADfh+D1BZcnHvB6+dUbt3gT0oJ/TUKCyo266JybJaA5xWv2p33L3+i0ngrRgk3A8IMIIYJ2FyhehOCuRXTYRSTk8VsN5ukxdyL0cmp4ot9hYq37jsKKioqj+68q/0p8HEmAP2uXsxTcMXHXtVqttLBbcWSWJnCmA3U2FtxJ4yVPJHy1jTUhuhgxYGuT2EZeLr5b/FFOt5JrX/swEsKPvEc11+dKG6Zc6i9nnWA3xoBZIsiC2uQugdmI06GNcSxMgNcFY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TA2Jn0SBwPWEYYq/o98SiEkKJlpaB0n/2semwOL/Ev+GHIuAeB+Y96W8zmyY?=
 =?us-ascii?Q?1kd75rtGbqX4FEGZkfBBLOv7rrEddu+ylqBoCw95XCtI3v/O/yokFvXYvVTx?=
 =?us-ascii?Q?aUkO4eJyhi+LeuwbutpQvQ/VhvzpqPGw7F9n9CyNA2zJHNNxW3TQYL9Xu1QR?=
 =?us-ascii?Q?TWN1n3TS6ajZFJdcNlNnugwbj6fKWYi0A3g0v8yHQaS5WOliJ97IH0ra9g38?=
 =?us-ascii?Q?gKTDd6XRKrm0JCMpDFfNlsh0BEVbQgxNNEBvL1IMEl4DFvep8b//X7UhxUam?=
 =?us-ascii?Q?9j4Y6gR4nmFYGr7WRD+cU/p1bits9wF2T2txBv6Lm0D9p1P/obpvn8Hv/NiE?=
 =?us-ascii?Q?f+HHm9nvnaPKEKUvo7FAIYM/lc/Zeses6wd60oq/6o7k+5HbOJu2fPkUVWaI?=
 =?us-ascii?Q?GDxyNk4lxisVaICRN7h7Oev++GIDDLpRostYHCE9BT5jvdM8UcsGPdH5XQ/Y?=
 =?us-ascii?Q?xTP6mtNlZ7vffmYPTOF5IK24yEWSyekfSco8QpS8zcbKoMn8k7U45/X69xDs?=
 =?us-ascii?Q?fhMoUfBEvM6goU6pA0QxxAxv3PyX3rrYWR3HkqvOAXWg+JVTsSKqW51p153T?=
 =?us-ascii?Q?luCTUOGn4ZZhaUdZM3OgiH7j8cvsHauJuArCq4iDAw7Eb4Aho0KNGNBRqisF?=
 =?us-ascii?Q?ox5luicu689fM09P/BmQK+M3r8/x+dOV98wBCMJgmS0Hb7buHcjsnFUtFB8A?=
 =?us-ascii?Q?eszSPKNy4QG55i5rgbwoeB4BEUPMBMG3aoX8o6njj19i1E+XANfRKvEHUtMJ?=
 =?us-ascii?Q?YvH9bfZPDqHtnnxpJA3FwuYoIKIEHyYm+bslNDNyuW5ZP9j2x+oAdWX9wHNA?=
 =?us-ascii?Q?g3tn/eNR1C4XhS9uiA6bTVhQyMw1uzIYUB1nu8NDe9VNMK+CcZJuKA27mFt7?=
 =?us-ascii?Q?Mp00juqr7gMQqmVFmFJGocHpUvIESzsWj5zClfl5HKTnqm9WMGUtd9SbV5sy?=
 =?us-ascii?Q?4y91cHsDX2sZAFn7O21PajWMnfiFYRUfKgkHCkenwCSouXKsRrLpTzIqC7P8?=
 =?us-ascii?Q?yi/GWxZFCzXJ5av5gHabKSS2MgP3rbGx/YOKC42JO8LNSh3EouxK7zXSUiV+?=
 =?us-ascii?Q?BQ75J3jgBrzpYy9JeG8afORLO4QYgnx8xyk/a0xZEndortumUT3StMNrigtP?=
 =?us-ascii?Q?dcnK4/4HLM2wGjmpAvO2nPSb/OnUreeZT4Fh9jU+VWiOLyNslIOb5cUoLhur?=
 =?us-ascii?Q?Cds05LKD98Qnop13KLbNjrhgP/y+o4wYQHgV+w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3693ad88-e628-4f7c-6c1c-08dbbae704e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:09:18.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device IDs for PCI/PCIe serial cards manufactured by
Brainboxes (IS/IX/UC/UP/PX).
Apologies if this file isn't strictly for your tree. All trees
I am sending this patch series to use these PCI IDs, I was unsure
if this was the correct way to go about it, and better safe than
sorry. Thank you for understanding and please disregard if
its not required.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 include/linux/pci_ids.h | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..82a64459c20e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1920,9 +1920,104 @@
 #define PCI_VENDOR_ID_DOMEX		0x134a
 #define PCI_DEVICE_ID_DOMEX_DMX3191D	0x0001
 
+/* Intashield or Brainboxes */
 #define PCI_VENDOR_ID_INTASHIELD	0x135a
+#define PCI_DEVICE_ID_INTASHIELD_UC268	0x0841
+#define PCI_DEVICE_ID_INTASHIELD_UC257	0x0861 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC257R3	0x0862 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC257R4	0x0863 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC279	0x0881
+#define PCI_DEVICE_ID_INTASHIELD_UC313	0x08a1 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC313R3	0x08a2 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC313R4	0x08a3 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC310	0x08c1
+#define PCI_DEVICE_ID_INTASHIELD_UC302	0x08e1 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC302R3	0x08e2 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC302R4	0x08e3 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC431	0x0901
+#define PCI_DEVICE_ID_INTASHIELD_UC420	0x0921
+#define PCI_DEVICE_ID_INTASHIELD_UP400	0x0941
+#define PCI_DEVICE_ID_INTASHIELD_UP376	0x0961
+#define PCI_DEVICE_ID_INTASHIELD_UC475	0x0981 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC475R3	0x0982 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC607	0x09a1 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC607R3	0x09a2 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC607R4	0x09a3 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC324	0x0a61
+#define PCI_DEVICE_ID_INTASHIELD_UC357	0x0a81 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC357R3	0x0a82 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC357R4	0x0a83 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC246	0x0aa1 /* Revision 2*/
+#define PCI_DEVICE_ID_INTASHIELD_UC246R3	0x0aa2	/* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP189	0x0ac1 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UP189R3	0x0ac2 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP189R4	0x0ac3 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC346	0x0b01 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC346R3	0x0b02 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP200	0x0b21 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UP200R3	0x0b22 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP200R4	0x0b23 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC101	0x0ba1
+#define PCI_DEVICE_ID_INTASHIELD_UC203	0x0bc1 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UC203R3	0x0bc2 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UC146	0x0be1 /* Revision 2*/
+#define PCI_DEVICE_ID_INTASHIELD_UC146R3	0x0be2 /* Revision 3*/
+#define PCI_DEVICE_ID_INTASHIELD_UP869	0x0c01 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UP869R3	0x0c02 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP869R4	0x0c03 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UP880	0x0c21 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_UP880R3	0x0c22 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_UP880R4	0x0c23 /* Revision 4 */
+#define PCI_DEVICE_ID_INTASHIELD_UC368	0x0c41
+#define PCI_DEVICE_ID_INTASHIELD_UC253	0x0ca1
+#define PCI_DEVICE_ID_INTASHIELD_UC260	0x0d21
+#define PCI_DEVICE_ID_INTASHIELD_UC836	0x0d41
+#define PCI_DEVICE_ID_INTASHIELD_IS100	0x0d60
 #define PCI_DEVICE_ID_INTASHIELD_IS200	0x0d80
+#define PCI_DEVICE_ID_INTASHIELD_IS300	0x0da0
 #define PCI_DEVICE_ID_INTASHIELD_IS400	0x0dc0
+#define PCI_DEVICE_ID_INTASHIELD_IS500	0x0de0
+#define PCI_DEVICE_ID_INTASHIELD_PX279	0x0e41
+#define PCI_DEVICE_ID_INTASHIELD_UC414	0x0e61
+#define PCI_DEVICE_ID_INTASHIELD_PX420	0x4000 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX431	0x4001 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX820	0x4002 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX831	0x4003 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX235	0x4004 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX101	0x4005 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX257	0x4006 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX257LPT	0x4007 /* Revision 2 LPT port */
+#define PCI_DEVICE_ID_INTASHIELD_PX835	0x4008 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX857	0x4009 /* Revision 2 */
+#define PCI_DEVICE_ID_INTASHIELD_PX260	0x400a
+#define PCI_DEVICE_ID_INTASHIELD_PX320	0x400b
+#define PCI_DEVICE_ID_INTASHIELD_PX313	0x400c
+#define PCI_DEVICE_ID_INTASHIELD_PX310	0x400e
+#define PCI_DEVICE_ID_INTASHIELD_PX346	0x400f
+#define PCI_DEVICE_ID_INTASHIELD_PX368	0x4010
+#define PCI_DEVICE_ID_INTASHIELD_PX420R3	0x4011 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX431R3	0x4012 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX820R3	0x4013 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX257R3	0x4015 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX831R3	0x4014 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX235R3	0x4016 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX835R3	0x4017 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX857R3	0x4018 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX101R3	0x4019 /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX146	0x401c
+#define PCI_DEVICE_ID_INTASHIELD_PX475	0x401d
+#define PCI_DEVICE_ID_INTASHIELD_PX803R3	0x401e /* Revision 3 */
+#define PCI_DEVICE_ID_INTASHIELD_PX475LPT   0x401f /* LPT port */
+#define PCI_DEVICE_ID_INTASHIELD_XC157	0x4020
+#define PCI_DEVICE_ID_INTASHIELD_XC475	0x4021
+#define PCI_DEVICE_ID_INTASHIELD_XC475LPT	0x4022 /* LPT port */
+#define PCI_DEVICE_ID_INTASHIELD_XC235	0x4026
+#define PCI_DEVICE_ID_INTASHIELD_IX100	0x4027
+#define PCI_DEVICE_ID_INTASHIELD_IX200	0x4028
+#define PCI_DEVICE_ID_INTASHIELD_IX400	0x4029
+#define PCI_DEVICE_ID_INTASHIELD_IX500	0x402a
+#define PCI_DEVICE_ID_INTASHIELD_PX263	0x402c
+#define PCI_DEVICE_ID_INTASHIELD_PX272	0x4100
 
 #define PCI_VENDOR_ID_QUATECH		0x135C
 #define PCI_DEVICE_ID_QUATECH_QSC100	0x0010
-- 
2.42.0

