Return-Path: <linux-pci+bounces-17906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94779E8C4A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD31318863A2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B969E215041;
	Mon,  9 Dec 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cl3mMTZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34B214A9B;
	Mon,  9 Dec 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730015; cv=fail; b=PkTSr1RmcGGdMaQFPvUIao58z/LCjCoW0p0qJZH2Wn0oeo4CuVEKXRuFMNqcGlphdxmhtP/QaTxNre7Vq+ahkJL71bYMZDe+YQ+rHtGDQvzZ5v08h8428Io6wxxc633UipRTsOU8gz2H4SzUoGB6CRNbVJG3A5xcK7ctvWS5jCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730015; c=relaxed/simple;
	bh=qu/mOK8RlXLX615vCFMV8FkJEhV8PaiLQ+BxfIi6XI8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GJJ6Yli8ZA32nZjTpJKqNactZf7m6bgYBBKHo3mf/92VAWiMp5+q62MXVoXkUlDVW1aJSvuDm94Og6QHMMasTsGn0uQQNvsci+iLyEblh8FvlcV/MZNgVHIqQh6l/vJMWIe4aIPb6iAYwdiSuK6nIkRzdtV3QCQmEdq3LsvVmZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cl3mMTZE; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2GvKzGdM7eKXWDXu5fY77uruYnuQ/CX0GmAA1LEvzlRLiPFlHeq3rvrR1RerM0xVy2RzQjffsQMgFyiyid1loAfQ2gbekPWN3pDSszxYfJWzhhDJPZSqMop3M4jAlbQuXe4xSMWlIlMb0OOxqSc68mdIM8LxF3Sucn0LYMrJiP5B57jdLHcIjZXbVqfvCTikYrX4jR/qzfqu5WZyFq0QFs5lI1Q9P2yGu6TmhR0Dqiiv+sPO52RHCKp1cwIiMVKmRAmXrLTD0aVu7Ia6R7ztRvVpd239nDt7ciLyXcR1ZLTQF3dGUSPV1qFYp9ialclL1jCWprh/XIHzu4qLPmIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78qRs6XiPjctbELPN+NX/iUdrFknZC6FXLvj4HNj0yg=;
 b=zIbHOUgmm0DQL8MKJp3bn4pQWDlWm+mMuN+5IxsLWu9gPOv64Ae/2QWPiC9IZgXGg0luNZ2gjx+NURJOvaE4Wi5QjOArGKBiyF9R5oJdbtm4zhAZ+l5buND3xios2BzYUk/hbTgazVNli+vqFzNDljPSA6/BEcklhX7bwsMj6XqfCfDr/jSKG2CAQ7Z+diCZJxqSWM3Hmst86brRalXXS7ztq6+XhQygK6lgln6LtIdUGpDdPAMkrpztbF2fKKm7r60XPgH61EFHXt+nfpAyzudDN4SFUGa110UjqwGKTeHsJws8b+vBOBgkXjWUQ1yAGmI1cpCpJnTEYj/BdCpOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78qRs6XiPjctbELPN+NX/iUdrFknZC6FXLvj4HNj0yg=;
 b=cl3mMTZESunsamk3LFYirx/NgwVE8mt8Lrzyq9JrRvzCm3dlJh7WNbsKuj5tULr8WjfYdvue0bvKrpNW+bEnBVZ/dMPEVf6ngq8KMWHW3e0Dg02bNJrT8dqnplFHE4KEIqwetStpds1HzKs+V5ZjALa3aqgLg60BUUkRsJ2ckdmvuQqOXGF4Lu6y8JqYaSd+RNz9BfoJDoWlH3OCjLBXV8dCj7sI8NlaV2VYExhdFVxgN8WenCMIC3YtFdT5mXIyboPMxz0SxlvqhMvQmDusjDcrHJ2+VRdwnWidAAxoWz1uW8eG2/+Jefs+y9MJxDEUfn4K6aLQeAmZCfMeCcbOqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.28; Mon, 9 Dec
 2024 07:40:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 07:40:09 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Bug fixes when dwc generic suspend/resume callbacks are used
Date: Mon,  9 Dec 2024 15:39:21 +0800
Message-Id: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0082ebd4-db23-47d1-50ba-08dd1824b54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3CLVSrgRJeDVbKwhDJl01mmlGHHpTUotlnBaGFlkxUDJxzJJFUtDckQDxSE?=
 =?us-ascii?Q?40DTa18y77yc3sncQYY4uhKjp2iK9XcMfddqtV4NPk5XsqjuASaUxDHDmvF7?=
 =?us-ascii?Q?VG53sfHYxLHTWiFBrRtbCu7n06Lm7xje3xre0GIyQjCkL+6iMgXkX78hbqZH?=
 =?us-ascii?Q?UeVkXFwyhbjtZFRkZxjXlV4IEJnwHVjSL7KSzUv5qRc9M8pCejtSHAS/tqCJ?=
 =?us-ascii?Q?DPgwVvNG63BqYOiN4PuaxLHa0zbbDgfU7ZZxvlm8FK6en3xYZd8LXYDobypQ?=
 =?us-ascii?Q?RHfD1PpdXxEBdpEqdW6pBtHvaRIsAte9L5v2W1z1Npgo20IFXknmwUokLhNW?=
 =?us-ascii?Q?MD1+DeWnvRmWgMtT9YpX6YOEQHE7rCGVFHEMZN9yiNyn9Qjg/teL2SvhXeaq?=
 =?us-ascii?Q?eWi/ox/GP8ZQwlUApyE+rmw9pp7PQ8qHAgQh+sYCQjP4SwYTt11Bl61ycDRh?=
 =?us-ascii?Q?AgxNegDrZW262OSDKsyOfqwAmaqJMoO2d/unyk3TyIc+tAIdfI2YZmNKymdR?=
 =?us-ascii?Q?TlqGiz87LVbfLFU6tj92BZjoPKBcspmnm3VX39dvrV4wnEPtl4V8XV6WekGM?=
 =?us-ascii?Q?MZQ43EuCupQJek8c9+TOvwRFVpzRNJQNlTKZiiLsKUHcbtbFMuq4bmClnPIq?=
 =?us-ascii?Q?inEnUvsST6zuhrZkH3CqS3MYb6hhQA/DEF/SbSWkS0l9LmBYH/IRUpkWIbqY?=
 =?us-ascii?Q?TyagJtokKfknD3HC3UUMiePhE9tmIRvbAA8R0ZdZqPsCenMVh7BZXTePUOBW?=
 =?us-ascii?Q?sIYp0h7kX+nX0CDmZCLga/tMkFsGpf5uPS2lHXosKiPpW31yQHU8g+OZ3Y9l?=
 =?us-ascii?Q?LSKPwUm54G0F7WV2japvh0kxia0bhPGBiw/thAc5c+y3psZBpkP3BhOyMDRw?=
 =?us-ascii?Q?xOrXESPLDHrUeZwBxCpb4ZU3uRFSCOyhju3UL3U6X6dlmX3IUuacjIngYA1R?=
 =?us-ascii?Q?GcQs88hPGJY8ZaFIQqF2PU9dg5pikd8BbU/asrjsaBSV/xVEDRC0esuRZiLR?=
 =?us-ascii?Q?WY9PkX8z9v3jFHqRCcBWyA65tm9cjcslmgxZ0xUla4tHqUdQHTIege5dhM/t?=
 =?us-ascii?Q?ctUQhE3q2rzYbqBdb+S/0PAlA1JI06eJT3YseWUpvVQXNd2XzWbH8rKisUie?=
 =?us-ascii?Q?wnOMz7sbg1nYj7oKE8fCjtqsrMjSSPao+EujBxCxLXyfBtiA2JMl2Yr3a1nf?=
 =?us-ascii?Q?oUTjbYsLeKZZ8iO9OQaXowUW9+6VjtI/VtIQzCP2fzIRTRpC7avFbbZan070?=
 =?us-ascii?Q?tkT7ldzXzW8aTt/w8UMixLSLRuiE60oRmIXLamtKXHR9G/BuzBh/xJPTrgsp?=
 =?us-ascii?Q?Yh3TeXmkfGPJj/Pj4vCQRkqY3K9D9f2H31tapod1cE76Es6Sz7+oN7WWKL2k?=
 =?us-ascii?Q?2QUouBafNZRAFlcVX9WSNnJc5UJFq4In2Fw6mbrWAeRx7AM+Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DWNBWBTMyzXObKbfNQTSzR14MLfuN3ludKF21T7INu6IfD8ZygnK7p+s7Eg8?=
 =?us-ascii?Q?0R88YqEaUKcXCp7dbnkQ3Vofx52cPqLg8CB9gHDp/FITXLmaDjZufwQ8uP7c?=
 =?us-ascii?Q?buXNRQWHbqN0yDa2K2v3p5GrqQlx92V43LvoRzU90USqBxYDGS+AXgO7M/lv?=
 =?us-ascii?Q?zGdTEQ2YFcdCNfZfXzBDFfqGvRV1GEvOc/vmh+JaqfUB3tYkTk92M91QmhH5?=
 =?us-ascii?Q?jNSotslvUs/MWgYWfSQZKg71kU6w3TepnbvXz2zvssrZOAWANxEnZ+I2D1Wo?=
 =?us-ascii?Q?/Bt93SIlfzBfg5I4zLITR2IBXzWaXh6Pfb1kpTX1qBhpZ5g06/fouBfVLo3l?=
 =?us-ascii?Q?7VoH0OdLyf5x9IXrdA+fxg2hbD6Oj+NHopW+iJ6goZ8KR9GcQ+3NIQZ+SKpE?=
 =?us-ascii?Q?bvm9zHYCub687tmlk2F9few7TLksZwLYWjqNpltqFinbi34Rf0nIM1jCpzJe?=
 =?us-ascii?Q?P9DzPqUcQhActjQio3UxkoiS8FIXmJAV4Dfo1yTzVuNi19PS1ty0g3W1iXk0?=
 =?us-ascii?Q?5wyIcbp2s79/utmvkazmQT4JMfMgGakrKRjjulGhEs18brzzlRI39K3YHNHU?=
 =?us-ascii?Q?Vs6AP+SU3a8Uvi/XoKYgxHd89CoBN3gXpYpw6pJnfMqD1XeFkSmDkhNUrH0U?=
 =?us-ascii?Q?aJobFdtqAB15V1DNQrQaBxl8LCc/EpmeNcyITfSl9uzCU0AHU56DLvkB3U3F?=
 =?us-ascii?Q?zq+81VLsr6zGZT58Tpv9lMJWkwtKUTK5gMIsdrQ7BUIbOA/TJa01FBKva5Db?=
 =?us-ascii?Q?thpuZP5igwuVIrE0aXMWRNCiw81aAOjFPS+jd3/co2KNb7QJ+OvtqbOrLQJF?=
 =?us-ascii?Q?afuuM+LChA1LELYqV1bBdaNBcs2M5RxEVmYXp9pW+xhA6XL99CqIaDaCnIGw?=
 =?us-ascii?Q?rVi6gzTjbbj0csnTzA7i9Sxid4HsisjYytYknvDNrZ1Ktv/lRBSgNHDUUqAl?=
 =?us-ascii?Q?H8btZIVj617yGGfnLxtGys2zjt9A2FT7k7ypYeP8O/zLRCVPPqyGtlo3IVzv?=
 =?us-ascii?Q?UBrGPcjcPq1C5f0JMd/LX0AloNEkk5Q9EPV4rPcPe8o8+VXTb4eeTRzUk4IP?=
 =?us-ascii?Q?itUM5+BqFLPY8qalYfQf0IafMq9weNAp09YmWr+5rgUP9a1mg9p+KemG1O/N?=
 =?us-ascii?Q?77x2sLgo45o94T2XSgcTrmg0m2Q9tCHrf9ZMr33/V5ifAq/S7AJDYgj7ulG4?=
 =?us-ascii?Q?d+tLl0fpmqC92TwHbOlW7Eg4Z3vOgQPjddhu7aIg0UT828Bz0fqwTvBSNJGm?=
 =?us-ascii?Q?kU9AKsDdRXMLr5rAyBYBsv8BgqeyWIlBOPhchex+JuVt7wJgfyIUeEnyFgeF?=
 =?us-ascii?Q?H2PxEZrc9IqXGQTJn98EQWrzirGT02D5mdS38oJfFg3T29HGcEmsbYMJCyDN?=
 =?us-ascii?Q?nOfhVxhbMPiXnKtH3NqwUkBKDlTpuT8E+0MJpz88s41k2Rkb0N/0qUzIoZC+?=
 =?us-ascii?Q?9Do7i8IuA5MFZEaWYsVxGgqirrPH+nC06KyLz3+NhnTyte3FZtecRui3TQ0f?=
 =?us-ascii?Q?ycqrna8XqKpSdESKUO2C0j4/REEXqvvp5DEmXLkIqR5YXwb4jDq2iLVs4O4J?=
 =?us-ascii?Q?MWj/kr2rJdUVmn5rhEyv85eX4GbjApxRZpWktNgD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0082ebd4-db23-47d1-50ba-08dd1824b54c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:40:09.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VptF9o+Gi49RU8rBPtGQPZOMEF467ObphVwWipNSNpDAo7kYTTl3am5zfd6YLZHOwu7y+uykb5OTITTEyJUI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927

The patch #1 is issued before, but it's not applied yet refer to [1].
Combine these two bug fixes into one series and send here.

[1] https://patchwork.kernel.org/project/linux-pci/patch/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com/

Resend this bug fixes patch-set, with one more codes clean up patch.
Here is the discussion [2] and final solution [3] of the codes clean up commit.
[2] https://patchwork.kernel.org/project/linux-pci/patch/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com/
[3] https://patchwork.kernel.org/project/linux-pci/patch/20241126073909.4058733-1-hongxing.zhu@nxp.com/

v3 changes:
Regarding the discussion listed above[2].
Resend the patch-set after adding one more codes clean up patch together.

v2 changes:
Thanks for Manivannan's review.
- Refine the subject of second patch and add
  "Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"
- In first patch, update the commit message and move one comment into
  proper place.
  BTW, Manivannan found another potential issue that suspend is entry but
  the link is in L1SS stat in v1 review. This is a new story. And it's better
  to be verified and fixed by another commit later.
v2: https://patchwork.kernel.org/project/linux-pci/cover/1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com/

[PATCH v3 1/3] PCI: dwc: Fix resume failure if no EP is connected on
[PATCH v3 2/3] PCI: dwc: Always stop link in the
[PATCH v3 3/3] PCI: dwc: Clean up some unnecessary codes in

drivers/pci/controller/dwc/pcie-designware-host.c | 17 ++++++++++++-----
drivers/pci/controller/dwc/pcie-designware.h      |  1 +
2 files changed, 13 insertions(+), 5 deletions(-)



