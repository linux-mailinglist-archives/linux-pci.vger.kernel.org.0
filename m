Return-Path: <linux-pci+bounces-15436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853999B2A75
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578E9B20B50
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E018FDDA;
	Mon, 28 Oct 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pl+hDZDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BE17CA1B;
	Mon, 28 Oct 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104606; cv=fail; b=JCdm4i8+mYdOisk9lGbPKmJjPSzGOelLT/z3eCLgOpn+tkkvGryFvFl048OMrOFPDmTS4Sb0M1e34VBgzp1Z0xlPxe2qgIY1tmqEb+L0cFTMinRSzC0F1PaK35o0+1hVxa8o8DW0xli7Ccn259OhsteYCs4y073IMfZFYOGz+FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104606; c=relaxed/simple;
	bh=fBQQCL5XgS7jTMq1j/HG3KI+sorivkc5TM6h8thQ2qg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rvBslB/HPNOCKea5dJAs2RvMuIlQmEiJ5KkT5+ckWAX0IGKrVh3l/a7isHLI6oDsTo+EEI3KtSMgVzKElAZY8JZ8aWP/d7GDDlhMqY/ndinZwlqiv4pqBedAYB1cIeXTkqClLYEbNu58IfnU9qXH4VbnecBTzkcgFHlgOsGQxVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pl+hDZDo; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzZxsbc+xTNqYoAqZhwA4ZuOATm85l/vnHbOmqzdy1YEEpKB2s0kNOg4buLdCiVhr34iXCbBWVBKQ+UojLqyiAP/ogEA6/YIFPynHD9w5gX3zl1E2VaPJg4A1AB/TY5KCiK6/hxxY7DDyMCpc5wXZjpweFCFcvoLB6gxixCVssomvb0fIqRBXKK3Vc7Ad0FabYcJf/oPPlc4U2iKwdJamFGTpKSB83WQYqr2HAX6Ar2C24N7gneXxNwKhhWip7EhAxsiYKaoaIx2blDAeFsh8/w//ToreTul/svvftWljCOYrGALdWlI38pb3Ms+8y7FtytQSbcTpldvSJh9u3+pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdKN01otIPtYnUlNZixtRpQ6M8UKXznu+NMlgwDFpnM=;
 b=rrfoppTBK9Mam7IvOG7oGYX56OPMHuU53FMFpDQO6rXpOR7yeRSgHMUxylsYQ6jWhpXXC+aiUr8tSUmIaygwQTSLAWIjHT2to8l+Oy5rTSYR+M+uBdan13iJwIoU+xLXM+ob+Hr0briloeJoiDdHGBABZHvvibe1AG1oEqxNiO2HksvsaiigAs9EDQHeGX9gYSqqzKtjzRmH/U7nbthPl8ntswbDk4vWqYMFFHa9l2AhevvrATVQnl3SW3jYbihb+MPLlICCvxnaUkusYeZ4vUwQfwhMQMKKE+OMMd+JCR3jSPIbF4GOBSaPD84MNSD21UBv7LScj+VIKbAWjPOuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdKN01otIPtYnUlNZixtRpQ6M8UKXznu+NMlgwDFpnM=;
 b=pl+hDZDov9jQyBDyaIFoIbQJPD0NnfyJjQfEuW9zYzLoIAQ6kpufamK2LQerwrw4aFs6Pg40SB4kXdfKM61XTa1SPQQNwLjnLaX5vbJdxejAQHH1bRrlsgEv4xx8CzJmwt4LcoRYF4GWLdH64IYrlp3Hwcr1nFmQ4sEpefhM94+zY6Hqc/LNr8wXmEcvW78DFw+Tq+wStgiM8t5qdm/NHkYTXVMjjhJr7ZKxwYvXnOLd3SibZmudioDSAzRaai/XlY9X4Vy3b+ghf7yoJWhZKJ9tqc2O1rw9v3oextudYcYwLiIKA8wzDkAOjCopxWtYbTmXD4ui5DzPW9AfTd720w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10758.eurprd04.prod.outlook.com (2603:10a6:800:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 08:36:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 08:36:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR GENERIC OF HOSTS),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR GENERIC OF HOSTS),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Date: Mon, 28 Oct 2024 16:46:43 +0800
Message-Id: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b260693-9cca-47de-558e-08dcf72ba4b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SK+KUEoMhIll1rQVg8zc6E5SCxxaGgEDCMWHa7zURmvs8ztFlTgbzAzE/bNn?=
 =?us-ascii?Q?42/mMgr6O9wfXurIX1LixYnpEXA1w4qZ7bI898WLsYAe98dmEtPAI6ne4te4?=
 =?us-ascii?Q?UURHr9R+gXj1CAMDO2MWXNBYGJu3RHOHVy+4cHjc19I8ErQ9HfvMcU/qVUQJ?=
 =?us-ascii?Q?FeQ903lt+0Axj6JgiVZ9gDr5pRrlUx5ux/PNIBg4IsVFgzr978o+0jgy9o+l?=
 =?us-ascii?Q?FFsam6KmHTxAI9v2BeShoHRuEey7+8eMyLdyZv0DRp3X1lwnymswCDTQntc1?=
 =?us-ascii?Q?4QxlVlT/7ftZyQ96MBlQyFcDV79X7neqqVvIcMf/tVhr2x3TQbkZeVJJiixR?=
 =?us-ascii?Q?KAsDLSHJ6HhdAEAS6KwrexcMfFVMakRVLrVBEL/4unOXkHnbnmPf7YGEJBeF?=
 =?us-ascii?Q?I60fTwaxW6WblPcC/R0YjT60DWuuyEu4Q89oATyJAiEYB3s0tcvP/xV1HKow?=
 =?us-ascii?Q?pHz/Kj7bK3A1Cl3C8Vy4VzWOTkn3CEgg+YqQEHUZ370PaQ/fp5EHkNBU0MoE?=
 =?us-ascii?Q?pcnHUvYn9Oxeg0f5lEHheNqQtwpaAQGTWMwA/1JQP/rUS2/lFKtCR5252wC8?=
 =?us-ascii?Q?G53m25LSZ/wE8ReyiOGDfQBO3JkbQflBTU/tmIsRzYo7iaLgavcwL6GNjxk6?=
 =?us-ascii?Q?Nz4+4uz+mEs9UryiUm0xywqiFhiOWPrPW2Ws+jIAu9h5FhSMEtOAouant27a?=
 =?us-ascii?Q?4X6K63xqgGZIvn2Q+6aGhXDLVpD/SnIkbDcGit9nx/EqTRx0EzkbSwZwaNn3?=
 =?us-ascii?Q?zxvhYDEeXXS3Sm/NHrqYyRc8FFrRZp93IOsl3Qhp/AIqW4gQuKCZdFT9MvT6?=
 =?us-ascii?Q?rHmrELSzCSNgus85bMD0yZvWc6751gitBc5QwBlKB4urgU4sf1GM3T+5mAjn?=
 =?us-ascii?Q?xnkLYAy/z4Nq1DlUbGs/SA/SD583Z/5SkRUX0CQNssJ4lbZ+aoxbbReEQXQk?=
 =?us-ascii?Q?40lUoy/xVqmHafkerxJ0ANx+0+k3j41FkMy9NE33p+Xpav2+hZ7c1SYE5tSs?=
 =?us-ascii?Q?dO2pHqsTT3SKaDVlnPzejgIBuFgFGLXlxo0F5JjuffnkqqeRKkS82iUXfIKu?=
 =?us-ascii?Q?iKqDYbYa2yFUsyYBvd4RPhClJ6zZE1FqPQGip0kmqT5DRBKZ3sNQsm56AYP2?=
 =?us-ascii?Q?pGmDYnrXbTr+yi1BVMsbQOe8enLHEXQRZC4yGNfvG7hHrSAd9ZPXxsK5CHng?=
 =?us-ascii?Q?0Ud9G8vcwZrP+X8O0Mncv5I31Rjbo3LuNj7Lko4zD9yAWnlpFRk3uUQ993mX?=
 =?us-ascii?Q?p2hp66L+SF770QXhJVor54etpdjMIqadEeQ38X+UBuDEEWKahUE7SNPxWhX9?=
 =?us-ascii?Q?aaw3W/cNHu5Hdh4SxKYKCTEf4W7S7m8jt0BIxTiONRzakKZpB0x87PSpOe3B?=
 =?us-ascii?Q?h/ZnwOXxoeS83Gmk1ENfOHwLE9WJ5KZP8xSoXNYkQthFjm167Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ADW8Gt8+ZcRP2rIsUfL9dcV8ASo0POK8moZbRyhCx+iKI8oak+nnLqDy3TS?=
 =?us-ascii?Q?FBVjVO8i/hoobIpd46DT+z1OzxKzX4KPtDTNaD8drPqAcOz4xlO5Y7thYkOo?=
 =?us-ascii?Q?FSVBDij8QAgvye0CMNrctTC0FyjFAK0lFZ088kPzuNC8rQS9tHTYcZYx8g2X?=
 =?us-ascii?Q?Fa/MlezBAHULGSwtTRq/CEQlCGYCXw3BDAHhlivi+vpueRZCUXMlrcrUWUpi?=
 =?us-ascii?Q?+w8mZfZLnGIusThR4axqw20ogdotDsAANQgwndi0d23F9KDO2GbuAhC7Lwdp?=
 =?us-ascii?Q?8zsciSq8mvNcXDbAdlyROFBmwvXaJh+Zisos7UzBSIrBHqtyha8IwGPYhKys?=
 =?us-ascii?Q?ZiVwlJdOvOiFG9woCQ6xGA2JwyXhzZIq5lfKtWo5DIx8FfRHx0AA2u1dUfVi?=
 =?us-ascii?Q?4TBJn9oQtcQPudKkP0WaWqEDgQoWh7k1AmDkm+/ri2OZMWlBVojoJXgMd8IA?=
 =?us-ascii?Q?4MBxoFQ48iqDTiPBX4YHBwN87REzHgCIKWZLYe8BoPTe9PfLzE4kxvFd8NCX?=
 =?us-ascii?Q?/3lHWllBbuINRrbdG5cUIVScJ8P/QGmD0DFr9KXKxZAv1mYOrjPvYhFZoc3H?=
 =?us-ascii?Q?hVA/op1CLq0Ud3x/m8XBXi6vk1D/SG5Cq/3FJREVXGKgEaV8Z2i6EodWYEct?=
 =?us-ascii?Q?WODXIlYAKlqH19lqZN1EnhG1y4LenR8B3Tj4wCEsW1YpvmoaUGzyGU+M3dTD?=
 =?us-ascii?Q?dabc4tAxAufHTpoJ2N0o8Q3+jOZovhFUb5et7JPk83jqaFbv77Euir23tmoa?=
 =?us-ascii?Q?AokzYTOep9cT6+svLMUqlJeQm/0SOW2S2RK3TrWcz5Mcszu37b7wgrqh0KMS?=
 =?us-ascii?Q?6R0uQnQ68ObLnCXS1+3+k4SaEuGP5aNZ5HUvMhGCfK9zIdX+6jc4l4Ud4HVV?=
 =?us-ascii?Q?GvYnsyXuvgzVbsmLs1MRdT+4AThZJoPkhHeMvB77fcMBHGjmLWImNTEsO2Ti?=
 =?us-ascii?Q?ty/U6bJXdmeM9da4ofHoEV5ABh0uvYe7xaXcmGgXS0MHjwIM/Mtieemg3wrZ?=
 =?us-ascii?Q?LQzQDjWcum/C9flp6FO5465B+3jVce6V4hJ+yLaU2w3prQPueIWSJn/6ywSU?=
 =?us-ascii?Q?Qtm9gwz/qGvnCtyxTI1h4w+not7S4/KteJc4snUkcXP3ZxRlyjK22MTGMnc7?=
 =?us-ascii?Q?73yV6OKCo+0PrzXj6guAtTCNr/8YHlDrZP+kb46hOsqQ1uLG/nBK0q/2wnJg?=
 =?us-ascii?Q?Am+Z5kINxBIqeFY+qvyIv9yd8IadzdxIEcB0HsqJXBHKwX7VDdIZAL2JJUxr?=
 =?us-ascii?Q?eJd5fITZa03/rDG0q+watmV14kX1TJ5VFxHRkJAh/+660zX59ap23J71B+nq?=
 =?us-ascii?Q?aDz3MYKh08zSXq59u5kdY5c4i9kjKvRkMFFTnM1It6J6u0HzEP5wP1ZLFUHf?=
 =?us-ascii?Q?XpuWO7lGVFfwH1WQI/StWIulHql9VZUOIjQ1XHsuq302uxkob1OduVu7X7h4?=
 =?us-ascii?Q?L1+p3LnYZr9+r6ThJhXiJGMHa/WTHwbr9UajJA9YBWIw1hajQZmKbUDI9bcR?=
 =?us-ascii?Q?RX4n7TBkicuBndpB1PhrTpvrOwbgCMmFmY/bzNmPhL+d1x5OsRlamoZN9+q6?=
 =?us-ascii?Q?nGNfoMeN4/hhYuNt/1h7Mptd3A5vVY5qlnN8RX7C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b260693-9cca-47de-558e-08dcf72ba4b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:36:40.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE6BmlKnws0HJRKoV4+fbaHzsbUNs8+2333ZgRvxhcaDcCBmxxNCBpmntBPrEtSHdKQwskrWBdHCKFAeenbOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10758

From: Peng Fan <peng.fan@nxp.com>

When PCI node was created using an overlay and the overlay is
reverted/destroyed, the "linux,pci-domain" property no longer exists,
so of_get_pci_domain_nr will return failure. Then
of_pci_bus_release_domain_nr will actually use the dynamic IDA, even
if the IDA was allocated in static IDA. So the flow is as below:
A: of_changeset_revert
    pci_host_common_remove
     pci_bus_release_domain_nr
       of_pci_bus_release_domain_nr
         of_get_pci_domain_nr      # fails because overlay is gone
         ida_free(&pci_domain_nr_dynamic_ida)

With driver calls pci_host_common_remove explicity, the flow becomes:
B pci_host_common_remove
   pci_bus_release_domain_nr
    of_pci_bus_release_domain_nr
     of_get_pci_domain_nr      # succeeds in this order
      ida_free(&pci_domain_nr_static_ida)
A of_changeset_revert
   pci_host_common_remove

With updated flow, the pci_host_common_remove will be called twice,
so need to check 'bridge->bus' to avoid accessing invalid pointer.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Not sure to keep the fixes here. I could drop the Fixes tag if it is
 improper.
 This is to revisit the patch [1] which was rejected last year. This
 new flow is using the suggest flow following Bjorn's suggestion.
 But of_changeset_revert will still invoke plaform_remove and then
 pci_host_common_remove. So worked out this patch together with a patch
 to jailhouse driver as below:
 static void destroy_vpci_of_overlay(void)
 {
+       struct device_node *vpci_node = NULL;
+
        if (overlay_applied) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,6,0)
+               vpci_node = of_find_node_by_path("/pci@0");
+               if (vpci_node) {
+                       struct platform_device *pdev = of_find_device_by_node(vpci_node);
+                       if (!pdev)
+                               printk("Not found device for /pci@0\n");
+                       else {
+                               pci_host_common_remove(pdev);
+                               platform_device_put(pdev);
+                       }
+               }
+               of_node_put(vpci_node);
+#endif
+
                of_changeset_revert(&overlay_changeset);

 [1] https://lore.kernel.org/lkml/20230908224858.GA306960@bhelgaas/T/#md12e6097d91a012ede78c997fc5abf460029a569

 drivers/pci/controller/pci-host-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b3..5a9c29fc57cd 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -86,8 +86,10 @@ void pci_host_common_remove(struct platform_device *pdev)
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 
 	pci_lock_rescan_remove();
-	pci_stop_root_bus(bridge->bus);
-	pci_remove_root_bus(bridge->bus);
+	if (bridge->bus) {
+		pci_stop_root_bus(bridge->bus);
+		pci_remove_root_bus(bridge->bus);
+	}
 	pci_unlock_rescan_remove();
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
-- 
2.37.1


