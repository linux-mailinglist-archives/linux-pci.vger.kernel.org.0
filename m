Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24EE611691
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJ1P60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJ1P5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:57:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1C215502;
        Fri, 28 Oct 2022 08:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbv7AffqDV9h4/C+RdldzfB4ytMpkR8I/vRPbNRX+ApI6ITs+2lTNnQSxNfjJsWEsunXHOi1KkcZOC+S96QtzruKF8KtAsbfOId3CwvYHsF0A/wLeSrg8b4mLtNh2MOQQn5jwFiRg+zNVDtWXfSkAPa8vxFp0tV212640hgpby8/qIGMcCWvjcsd6S/rIX7/KA2xuGaLPUwLwJf4xKwpmOdKOnCZ8Cq9ajGsBBbVlwa1VpYSASjZf18BIlETIRteHwsb+ACQ38/K/HVIhoc8hiL8ju7lHJfAXt0vsKu4OYogXvqGRIcONSXMRPfCmYALOsIkAtMNvca2Vrb4DAQS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=I+KmCUUUqtcBKKWwxDbwkA4/eyS1KP+SSfo3ctbBnsH7rdnKojmVNZBnpu/qAEGOmoYWMu3tSzRN8HnoRLrgb7ZjsUPGRTGCmOmjeirABXIFQo3xCLx6BmAU46TA9CRoF3qP2rIdSqhAqJJEUFuSIiZjy7DedvrmYzSVA0MwDG5tb9h0iFibVew7lPphFsUWDTNRNTAhtw5R5SSM4O5e+h8jEFeo9iNVG9WN1gvVY1VghYsu+ftklnVIopNaz14U1tV0kSt/2upPOfL/q0pApwfTR8Gqhh6fFfQk1O+KUnJRwHCkO+HpGQtKiIONrz8KC3L94DhEIaUsxlfGCfso1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=eJ3GizfoAH3xOhQCzmXaNzbdo8YG/h0F0r75kFGZudTgciyx5gUqHiTofrkVfmVPeVWXR7jidXcVZ4JKCbt1o9vKrzL0wUqJyT0MGOchJYWkFB0BEaCxFi2b/5Q/4t/AUnd1MUVkAlpNUq4/n8YT8HdevEVUvbvzwa7SEkjhzTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:30 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 1/7] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
Date:   Fri, 28 Oct 2022 11:56:57 -0400
Message-Id: <20221028155703.318928-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028155703.318928-1-Frank.Li@nxp.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: fbacf2cd-6e28-4ac0-9066-08dab8fd1e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1A6nLSHUfYqikVx3keg/WK2rQPlUa5w1Q2Og2jSF24SZKtpT/Tr3LT6AHzwBS6gRzrKA0oDVxrh8tHQuWpvI/LZFI3SnFM/vghssTggHMj9KWCrH4zbYfATQ/NXuG+33bh3xn5iJ75xuSP18aBfuSObrvtlTjLnWrLBCXNZg0+1RY1zqCiHP4kzofKMbhckushvUQShXiDn5zGG18q3jL0jDLsfXJ9vsfOodbuhqsO5WHxTE1cwRDxNl+ENoAxyA3tMJdzEbP6PzOOP9Q7E3Zmdh3Kp1Nu8eihp01YRi8TNbVNyXN294Fa1CMFHz6R3p8IvC1WjkjnQWQlrurrWrLWyaNw6Y/HDoKXssrhuep2KJhjsnDAhMo63h2lh8zN1Piq3UFElIwi8kS1FsQMNrodjxexKOwKT3oL4iH8ZjmVNA4F3cUTkiUWqJP8TXu+jQP9LcR7SaOt1JwzgcV6brTtYQ1zwwgwBDnDL74OxE97SJ4AMlLomc54wSnR1pCBoLo/5MPHHKNIjH/LHGeimzfJ5iniueVRuyRBFCxIWAA/s6OnuiWbHfAMqhinyyKG4drt4XzFF3JzrVcKEoycLe1D4Sc6lnInNRLNOZOWZxXCKGVJPbglqfSUUWg6FXbqIZzFObq84OaagYG/qvelRQ/OqtiNWyebe+/h7Z5s7l8ydvzRLmTp0z//5ofxmME8iz0RLHk8iQZbBSgmv9iQNvh0RtIdtLRZ31ZNGroS8MDmCG88/1i/lvF1XiObxLJpuEObMoEATbfuDpwZ/58HkmVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(30864003)(8676002)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anS3hp6heQzZqwCsfgmPBd6bTcOV1HWpV9K5cWXqLeBZggoC0Y5+zkECK6MT?=
 =?us-ascii?Q?QSOouzVN0WxxN9C9j12IEPKk2N8ILUugQiMv5GJITDdYk+Si0060oV67ofsw?=
 =?us-ascii?Q?f262ODexghLUnJxWJY3ZDsC0rtL6XhlnH14SVhGnfHOVTZoXYwjLqQAavkJX?=
 =?us-ascii?Q?ItBIwuT/gZL5+L1toGnluPy+JqHqoCnFMf9FhN8pBeUsVyMsQ1XSUnlyRE/X?=
 =?us-ascii?Q?bcbuuJOet3Kfv/YeLyVuy8uNArAssHFL/tgG2XxzQ6vUsHPujsa1eyKvfJgX?=
 =?us-ascii?Q?uzXOnVopZmtSiQzJkIsg9GCDsIAFZ2ipLB0dl8pEEG5zTYvukW+9aHfcOQpf?=
 =?us-ascii?Q?A/ZRA9mUDsyUXyVy+AthJDKLLEXE33qa2sXAGxGsF7/af0VZD2BWyYEC6Abn?=
 =?us-ascii?Q?GqrrqWrngoLc5LY40yFcDD4f8cxTR054flt8XDRVBD2+4jsk0CMH1jlghSCH?=
 =?us-ascii?Q?k/Wcv/T9JUvExQ4vco2Nw4HVXgL/odfo4zYwkP/h5B53cp9ka4dW4ly6HRLx?=
 =?us-ascii?Q?S1YJ7TSeo/gCh3fGtZiadvW0KtN+vlec7RHPIObEOCuR99D+tnyM2oxS/YRB?=
 =?us-ascii?Q?apsl1MK3+juGdXieKDK5hl1fuoLRl+jKoQ3uoArUNAd4pGYc4Uxlswz2hpt3?=
 =?us-ascii?Q?8H49QbAiDHoYtUWFbRBTyPb74hZ0qxfk5DJkeYETT7Tm9CsVDa6Mo5Ew8Xkt?=
 =?us-ascii?Q?x53PYF5vaLWzPq/NzbypgStCoYmuLI167xbyu8uFqqXCOOVK9Ih55Z906Kpa?=
 =?us-ascii?Q?tPOs28XmtYVkvnHBPIkLXYnTynWj5VrVOcoQWnX55vVrsrzLvI3zzFtJLqBV?=
 =?us-ascii?Q?wJn58wR0Tf/5ZtQcYOjjQ/gcKss2KadyB/dt6Cab4SgWd8WWCpBvndyX5Nfx?=
 =?us-ascii?Q?FwOoIgBzlseBW/qnx1gJR1dLtiUtU8KLM1Ulao2Ro8ZL4E9kaS7toHbCVLwE?=
 =?us-ascii?Q?ovKavWQ27FyrbPkTg9xuf3xOCI6wMBoOTyZeyG34ksD8oI5QBJfS59yPeIOH?=
 =?us-ascii?Q?QM1Z7zbSPqSQJuOibmbqpC8dbKZv8XrmteqlcahBgz/Bd3JMwHKWvUWFmVVz?=
 =?us-ascii?Q?IHCQpLc6iifU5z3L/7l/1O4sVBaYcj5lIqNbDEKseDBU5Srwf5X6AmwpJ/B6?=
 =?us-ascii?Q?8TvliKsOqXT44Uc2m5kAZacFICz3JuQtioPl33ZLjc7EmV3sSPm8XmR1I2O0?=
 =?us-ascii?Q?oJJ/4UNA+iMfNGfY8Yzs3mAd9MNi/4AEHTBnBbRlvit8gViURXRAP5LUja1k?=
 =?us-ascii?Q?Kopntnh+8r+ku6LTvEMcGHahS/llKX82OopMzWN3xkclNRcyt5YTk9Ekh/6Q?=
 =?us-ascii?Q?SxY0+HYORBl6KTgLrIEqaJ/NQVMzRkD1iXOKMAiilrFbRv0qHHWYItysoUq4?=
 =?us-ascii?Q?r0Y0/PgcSt14pRJJXhK5h9ATOWeobPLwdzZuJEu4G1JWSYEUgDvMh0SlYpot?=
 =?us-ascii?Q?ryddbXczm7jp3jHNxAF+OK6vLgMNOfGK+3HzOwWzWQ+k/MrD6+iI3E3yS5Ic?=
 =?us-ascii?Q?tnR3ltWDAH9VWt2iROQmAmLvEOX6E3D4slVywsDpqbCKuiPNIJ+cNqSLGCrf?=
 =?us-ascii?Q?NlR80l7a8BHRNV0nV5+sWmBLkZicuUYTLzkf7ivX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbacf2cd-6e28-4ac0-9066-08dab8fd1e39
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:30.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh2vZPoTKmKGGWIDXLHnscfuxjvLVKcFQqIhV2V7W2Q+6mFf7vPEf+NEtuJ7Qbt1A46lnm2VHK8rTtbcq0Sqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Cleanup warning found by scripts/kernel-doc
Consolidate term
    host, host1 to HOST
    vhost, vHost, Vhost, VHOST2 to VHOST

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 83 ++++++++++++-------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..c0115bcb3b5e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -11,7 +11,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-/**
+/*
  * +------------+         +---------------------------------------+
  * |            |         |                                       |
  * +------------+         |                        +--------------+
@@ -156,12 +156,14 @@ static struct pci_epf_header epf_ntb_header = {
 };
 
 /**
- * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
+ * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @link_up: true or false indicating Link is UP or Down
  *
  * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to vhost.
+ * this NTB function driver will trigger a link event to VHOST.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 {
@@ -175,9 +177,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 }
 
 /**
- * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
- *   to access the memory window of host
- * @ntb: NTB device that facilitates communication between host and vhost
+ * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
+ *   to access the memory window of HOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  *                          EP Outbound Window
@@ -194,7 +196,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
  * |        |              |           |
  * |        |              |           |
  * +--------+              +-----------+
- *  VHost                   PCI EP
+ *  VHOST                   PCI EP
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 {
@@ -219,7 +223,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 
 /**
  * epf_ntb_teardown_mw() - Teardown the configured OB ATU
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
@@ -234,12 +238,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 }
 
 /**
- * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
+ * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
  * @work: work_struct for the epf_ntb_epc
  *
  * Workqueue function that gets invoked for the two epf_ntb_epc
  * periodically (once every 5ms) to see if it has received any commands
- * from NTB host. The host can send commands to configure doorbell or
+ * from NTB HOST. The HOST can send commands to configure doorbell or
  * configure memory window or to update link status.
  */
 static void epf_ntb_cmd_handler(struct work_struct *work)
@@ -321,8 +325,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 /**
  * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
- * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
- *	     address.
+ * @ntb: EPC associated with one of the HOST which holds peer's outbound
+ *	 address.
  *
  * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
  * self scratchpad region (removes inbound ATU configuration). While BAR0 is
@@ -331,8 +335,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
  * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
  *
  * Please note the self scratchpad region and config region is combined to
- * a single region and mapped using the same BAR. Also note HOST2's peer
- * scratchpad is HOST1's self scratchpad.
+ * a single region and mapped using the same BAR. Also note VHOST's peer
+ * scratchpad is HOST's self scratchpad.
+ *
+ * Returns: void
  */
 static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 {
@@ -347,13 +353,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
  * self scratchpad region.
  *
  * Please note the self scratchpad region and config region is combined to
  * a single region and mapped using the same BAR.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 {
@@ -380,7 +388,7 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
  *   config + scratchpad region
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
@@ -393,11 +401,13 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
  *   region
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
  * is obtained from "spad-count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
@@ -465,11 +475,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 }
 
 /**
- * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Configure MSI/MSI-X capability for each interface with number of
  * interrupts equal to "db_count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
@@ -511,7 +523,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
@@ -566,7 +580,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
@@ -582,8 +596,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
@@ -639,7 +654,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
@@ -662,7 +677,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 /**
  * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
  */
@@ -675,7 +690,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
 /**
  * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
  * constructs (scratchpad region, doorbell, memorywindow)
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 {
@@ -716,11 +733,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to initialize a particular EPC interface and start the workqueue
- * to check for commands from host. This function will write to the
+ * to check for commands from HOST. This function will write to the
  * EP controller HW for configuring it.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_epc_init(struct epf_ntb *ntb)
 {
@@ -787,7 +806,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to cleanup all NTB interfaces.
  */
@@ -951,6 +970,8 @@ static const struct config_item_type ntb_group_type = {
  *
  * Add configfs directory specific to NTB. This directory will hold
  * NTB specific properties like db_count, spad_count, num_mws etc.,
+ *
+ * Returns: Pointer to config_group
  */
 static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 					    struct config_group *group)
@@ -1292,6 +1313,8 @@ static struct pci_driver vntb_pci_driver = {
  * Invoked when a primary interface or secondary interface is bound to EPC
  * device. This function will succeed only when EPC is bound to both the
  * interfaces.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_bind(struct pci_epf *epf)
 {
@@ -1377,6 +1400,8 @@ static struct pci_epf_ops epf_ntb_ops = {
  *
  * Probe NTB function driver when endpoint function bus detects a NTB
  * endpoint function.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_probe(struct pci_epf *epf)
 {
-- 
2.34.1

