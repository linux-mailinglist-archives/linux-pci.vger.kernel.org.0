Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEE7B3D30
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjI3AUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 20:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3AUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 20:20:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFEAC;
        Fri, 29 Sep 2023 17:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw373Gk0Gy/cCTlUJELlrzE0kBmRZYUEwMIfCLWDNh4/J1pKvpmJDCmkaLJWh5DhLkeSeVWPM3v0gjhbuT/NvSAD9ByfXaVFwFYm6sLjMiYstrBCT7J8S0imti7nP20HqwjR+vXhaMobkflBbd+1ynhHTJQCSFT+3SYHSVEuzgV87D2d/Uc1BIFECrju/41sRTIZPIrO3S+CpwpHHKUoWLAbHlaF74A8CUagDQWFp1HIcP0hs374zCVOMs5cs+HoLN5Lb2x/ugl5THdrl4o6okpETHYFmiJGPhD++VSzkTbYpKBh2YJFK25OoOL5vmLgqVC3F/pD/VysKsY8WzYxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdGWO4d3/s+VhAuyuxMvjTgCFwfBQAiVr7XS2hAQhis=;
 b=RJnRq/b0VsBGQw9gFIVcXw51Bw3OFSNzHDw0aEmyG/rq1x5ri5GdhTAe8znUZnJjsVTN1Nc5pcUDRd+IoT5WXeYr5neAz/rbjS3a30MAuWLE97RKchcrMvEwMH5qujfgyMqkkjHEx4qJMgRB66484ewzikWN+6PQGy5hrABqAPIZl6bEIcIqBK8BXOu4Q1NcZjs8xYlmZNOCSyJsWvhsIj6Br1tRJXHP8HOg1wKOFSEph36M6lXVWjDjoVIcjulgn9ou2niRPHFk7aWzRjqiKgbmZKMChjWMtMMxDLGifm+NjteE1kcjEeSR5Qf4O4NFNvpQ01lmVQf080m0YhvMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdGWO4d3/s+VhAuyuxMvjTgCFwfBQAiVr7XS2hAQhis=;
 b=odZ6AhINbBaqewsGVFNQyJo7K+xxrxlRQSOAbAXgBRmaEy1+P/jay+y6POWupA9F3LPDdGAFf8p8sqAhsKx2ej0Rie4otTS4eJMxQmFMBb8ZRQhPoqbWD15lEhgVenVyW6uCwtyJFDN5WWbB95OHJw9WdtskGJgGQuBD7pcd7Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL1PR01MB7553.prod.exchangelabs.com (2603:10b6:208:384::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Sat, 30 Sep 2023 00:20:40 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 00:20:40 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH v2 1/2] PCI: acpiphp: Allow built-in attention drivers
Date:   Fri, 29 Sep 2023 17:20:35 -0700
Message-ID: <20230930002036.6491-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:52::12) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL1PR01MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3b86ef-1511-4106-f3bf-08dbc14b13c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aB7epv4Ew0Z4r48XXYxmwULgeoqgnT/wvAFUidFpPx0FGuzk8sjlzLJTgY1FWy2oF/fXdJLWYp2L/ALCWFLYm6S/SVPlIz7KXnaI0Gg3w8A4GSJchvO5SONH9DmBDFpsfAVZhygmM9USGYj/6jhCDLLW8GmpB5Hbo2G04e0jrI8ezaFfb3SK7kyUjlHF+s1NWN3e7H2WA1Xby/8TDGXYAeQr1qL4Ms5aHkGKngu1TBxO1EG/5zVN25zsqiy0INo2LNPrDzjkaSHqCcUuVqwjQXLKKbOyZBEpQib9nbgSYD0CpDEEMYK/DFX6VEvSLs7DoD4UwtGVzvNuOPmXFr+lAfqB0cxL+hoye8joQcyTDAeMPLivkC4sxghBrxBUBLTbn6CvaovXeJtkigxGAGzI6GlVbjIsP3Ahq3cRILL+iHrj4sFAXPpNcRtfpEJI1BEvl3+zVrl04wiNx23EKYfJ0qMUo7BCKqc5D4RNamdfYyTEYm025jsey+fBm7CmbJPvdzyosIp4/T0HelSiZ08bZaq8+NEIOZHyf/RuYD8PtYpMwA/zt8UAgThY5NEwr1p+ViIwTyxnfShNYJeVh/8uYXz70VXmKr7J6iJ6t/vKgPhOFE8NILbzyYcgNdP276yf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(38100700002)(38350700002)(86362001)(110136005)(66946007)(6486002)(2616005)(66556008)(4326008)(41300700001)(478600001)(66476007)(54906003)(52116002)(8676002)(6666004)(5660300002)(316002)(83380400001)(6506007)(6512007)(8936002)(107886003)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxXA6rdtVzza6CX3NsRZhsq+HQeucyNQ24+U//TSzo0PFAXAXRyaSO3Tygu6?=
 =?us-ascii?Q?8p4KSuSKMfaS0DDAx7LtHZ8pSIn3OqoD7GLsE1k1RMArOnR0uowG2d9zhxP0?=
 =?us-ascii?Q?YUO+69MKHKI9Q9aeE/jCiCl49cid8CDX7qfo5p2JIQUQrzCrV77D88CXxKly?=
 =?us-ascii?Q?rJQwmiVHoDXu0Dpg2NlJpNDlpRP1sVEkFhUBelatbyPyFCavWZWdaGmM98td?=
 =?us-ascii?Q?gmIzujTMpFLqb85sxqZQXxBNmZrYeJ0hmTV9EFGqUtPSPZIvnk0UCBH5upgq?=
 =?us-ascii?Q?upfQcXfIydFFIX5t/Ta9stXRTYS1WW6lVB2Y9tc8wxh/VfLBLa1DMr0YQq7m?=
 =?us-ascii?Q?BJQ81pZWr8A6/jF9m/gUeIsRJkqup7jDyrxutTR0m3ImH5M2G9JpHYHYHkL8?=
 =?us-ascii?Q?3H93Stss73q6+/7h528H80rbG9T8MGgetUsA/UM40ntI7iail70BtULDW/pC?=
 =?us-ascii?Q?e1NqlkP5DcMvQ8PV+2/cWqUzjje1vkus8/UL4j/PG9PD3CT6hpXwhtiec0On?=
 =?us-ascii?Q?X+HIUKhHo3WErfwRbT+hGVSVEeaVM88SiqRxd1rh9WYaJtXC+oKM9K2R/ng/?=
 =?us-ascii?Q?ZOQ4umD67tQXZSvUankgEOjlBVjdpAc1UwUmwftZ/RCieDlOBjQ+bB/siUp4?=
 =?us-ascii?Q?05QaAKw8M4WVOmxk+cZKGa+YycWIUfnHbAC9YB1Z93aJbr0uXkdHufGNfAlg?=
 =?us-ascii?Q?RL7M/RRUjUYPnViOK7MVPd66Gcmw1YkqIrw+oBC5YSPTsBmZuH433Z2O73vm?=
 =?us-ascii?Q?R8AzusHdVi0h0VEBDFNDcw/L7OHghV97+cdF0NJWWSTJ977tFq6B68YEqqMM?=
 =?us-ascii?Q?zk3iaM3bW3HLciUYANi05SNVtriAN5njF47NMvrP2vUeDnxidrNFI2Iw2S4S?=
 =?us-ascii?Q?kgL7Fex91Y9D3y9oJpkBcitSGziT6IBQKRNtwia5EWxuGHdQlz6Nr8Nmw5i1?=
 =?us-ascii?Q?AYsN8TmXLqOBS+Stri7lMmSg0jjuxgZrzwgGZcFiSD5Cb64V3DgIHlkxIYc+?=
 =?us-ascii?Q?wrk4X0hhpw2/66HZBLKT7H8BVMP5krl5XU6sYmGQOg4XJPMCdD3Zn47q7Tsa?=
 =?us-ascii?Q?4AzLHznDKHLQFJO7nLCIuA3M0uDkWvdM8Z0Vc1EWsdf5MALRmR+ktG85V6AN?=
 =?us-ascii?Q?1FWvbF2R2MLtVaZPy/emW6iQ3sJerFmiuAGDr0nO3ccu7bXuMup9JNVa2lgt?=
 =?us-ascii?Q?W/aPirhkoOg6ydhFbKsjvN5aLxhT+sBZcNHMmw6RtEb7iyMjpSmlj51+xJ1+?=
 =?us-ascii?Q?ZlJezDFy46QVnzAC6canePGBV31w8xL4OYfgVaT9Sscr4EAdUejah8VJB2vM?=
 =?us-ascii?Q?1p50+JmcPo4/FHuyqesk87z9x37RC+DJYLA+M4pnY6k3wTrlf7+2L2BTI1Rp?=
 =?us-ascii?Q?L6zlhDTjCnLoklLAlFOppFgDiMZKBRN9jfxTRjM7dIq9aWM6XJfrtkBaq/q7?=
 =?us-ascii?Q?WsvuTL7epuzlsec7eth88zdT9OwL+lBlVn6awQFkvjWw6TE7Rz3gUJhTn4Ar?=
 =?us-ascii?Q?CfgiqvHT3NCLxshCNpUxAPndJTcQ+e1LTeTGD5xaLKNleNKZXCLSp/hwR/zA?=
 =?us-ascii?Q?bf0F0ULTbjkNKBryBIPtfFLuXlu1bdqo1LA+GkZYw+vAQ3LeqC3Z+vGCQyyw?=
 =?us-ascii?Q?yw0i1/aUusSF9UfI7CNT+C0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3b86ef-1511-4106-f3bf-08dbc14b13c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 00:20:40.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBVUcF+exLBrJ+Q8Q9stLjpABHb+A9mIdfoZDapwrpdeD/B7j5CQNvg+pXRd9ohs9eij4/Ytvvvp2PO1S4Owxi/5DzvT3f8Vo7TLMemfaJEMbHTdsSclFLnqhPljFga7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7553
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Starting from the introduction of the attention callback in acpiphp, a
non-zero struct module *owner field has been required in
acpiphp_register_attention(). Then intent seemed to be that the core code
could then hold a refcount on the module while invoking a callback.

This check accidentally precludes the possiblity of attention callbacks to
drivers which are built-in.

Remove the check on `struct module *owner` in acpiphp_register_attention()
so that attention callbacks can also be registered from built-in drivers.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
Changes since v1:
- new patch in the series

 drivers/pci/hotplug/acpiphp_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index c02257f4b61c4..9dad14e80bcf2 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -78,8 +78,7 @@ int acpiphp_register_attention(struct acpiphp_attention_info *info)
 {
 	int retval = -EINVAL;
 
-	if (info && info->owner && info->set_attn &&
-			info->get_attn && !attention_info) {
+	if (info && info->set_attn && info->get_attn && !attention_info) {
 		retval = 0;
 		attention_info = info;
 	}
-- 
2.41.0

