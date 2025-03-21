Return-Path: <linux-pci+bounces-24298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A67A6B316
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 03:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D21893385
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FA1E25EB;
	Fri, 21 Mar 2025 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dEqML03q"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A71876;
	Fri, 21 Mar 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525909; cv=fail; b=uOhRsLMjKgu72AjXM7X3lTmDbp8JtpxxRnmt0FVQhwctgLbnwsxFAm12JYUbo8m0WHJrazZefNfpiaWCmB/uyy3ei0GbUhNmZ8Svb5YYOFiSoDKoWbT1fOXiAd2CsQjRw1hxjsb+azmQzNal52U6/4T6E5XfuMkFK3wBB4O012g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525909; c=relaxed/simple;
	bh=PAf0yyppvSwmyGZ5SasuLITxQ9R1+KO6FS1EDZcGR4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJNxvgOhSBCJGLdH6FYYRSXorRBJALPTgRI96V1AVi+Nypq8wGGBYqmwv926VxnsSEcJWttLb8eDWfPNU4+YAvj7pTi11iAPY1h26B1J1CdWxoOfwKigBTjj94gQcRiPEIK05dULHC4anBe0y2Ef3lqRkB7vT46CgzTG1fTXiuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dEqML03q; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrxNbr7hw5+mZWwTFFVB2xCutsudvs+Bha7OL/+2ds8LFIeMJNQkxKzRL3mOGGC7l9G2lecGwseSJM9yDuahxhXPQYhtii2FbHfGlhY9EtrBRYAp6UkLFRoCHnTfneW8UnBRf2AecWrP4p9FcOcJGZhLY+TxQSwpXujzRkCNhTRb3Cf55Y1jgwM50HUO1EGUd/UTYVv+Zh3Rd+SAOFkQRbz00qdXmaN0D5ukbvDg7Rxg4f4P1UnZzUZkmI1I3aKKUaLR7kynAqT3fVGVKIoB3MPvZeUmhnJXyj7/xxID/CRe3dFehkkhfjegPTSVafQHPFSs9p4Qg+vE2lyUqmc/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T39/czzcQHenCJlRCG/WEyJypp+F7f6XRld1DP2gGX8=;
 b=vGOuz9Dek2DEmaOra3GLosc/1SbTQd77aH7p/6WRWw0mfKI1G/fnnR/0HfEzyt1zgPfg5/PFrpa2CB/J+7JUmU+mii33igd8jVeziaEwZipqGp2gXKELgh/RZ83CHzQQMzQwzPIRsmN2/hHPkEJ1A8kH2f6D7RBKxJN+TtCeD27yJiU3fureuvtllLUS3MSwa3zTnd/ExuKDZAJ9EdjvOPJEYK0dBsAHOcfY7auY69LZE4frgiAfGd1YEnc18W+jr0FaqdrzdcISe4zCX6YYf7jysLXdmV9ZLZA18c23KRWZTdyutDQn/MVA2/YomdnNFMpGZMWQ2B4of+pOKGoX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T39/czzcQHenCJlRCG/WEyJypp+F7f6XRld1DP2gGX8=;
 b=dEqML03qJzl8yaSFhceqEdSrajHVbKzUFOgyzH6qi0gMepyorD2n3SrxCZTlCbWn/gGKX0oU9lxJLFNO1jyL/bg4OAL9F07SnL/yydqfLZtAD/d48DsvhqL4AaYzERMl9I8SQ07ps5i4rt8gkXv1t0jU/ku1kB07dqbdDeyJAmmUfVYtnshXwVyHZ+xl6BAIyb+wjD1zJNYeTRlYHeKK1L40vEiFSKOwgBru5WivdU8sRsYXfvyzzZu6Y89qFu53RukAFUvFK0FdQWwrWkWgVjjSWULRB4ao5zam3UIUFHl0m0X70n2hGUcbFg/O65I/aGFYTpRN1ahQIORRQLnr1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 02:58:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 02:58:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: devnull+manivannan.sadhasivam.linaro.org@kernel.org
Cc: bartosz.golaszewski@linaro.org,
	bhelgaas@google.com,
	brgl@bgdev.pl,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
Date: Fri, 21 Mar 2025 10:59:40 +0800
Message-Id: <20250321025940.2103854-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5afbee-08cd-4711-49a6-08dd68243eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yl2HkmZeLsl3hmtRNdPva9QQ4MT4AgZ25LolEay9EmmvoK7yE/6sjo9pT03f?=
 =?us-ascii?Q?PFKrLQ86DAZCm85vFtkepM6Pq0y1LwpsM5gkh0RI357CDa9xl1vY5sy8Hhp3?=
 =?us-ascii?Q?p2bwPrKFiqe2hfMfPhsWvFhOmUVmhMlixt5yz/KtkYdANvhfL9ijjwwoWeWb?=
 =?us-ascii?Q?TNabZ8VnEUZblrlNFJ5YkgGGF9MMGitmfyMox1orbE+vc7C/Lshjb89TV7qt?=
 =?us-ascii?Q?SZY4eKTbqBrxX6xuxeB9ZREIqc2GtX23q4cqYHWMySSwHdz/lAFb1888loG2?=
 =?us-ascii?Q?HbOru/s4dr7LwAcJrxdp/6Nu3j7sZGw78/t/pddXGWag8EGZ55TxMaBOzzWF?=
 =?us-ascii?Q?NTiyXVZdaYsmpsfZU3l8xPiVwHS0AatCCnjI7FsyRwd+dpYKQyT29uHSrUyD?=
 =?us-ascii?Q?bsot5cGM4wvK9A11Nt0IS/albOMS9KSSFnYgx1Kwg7qbKGSCMellgy62Bm20?=
 =?us-ascii?Q?i5TvNLKZvTQL6Y8jN/wfP3eL2pzNcYoI/R5bSOXJdyLd7H5ZpaWx7QbxOdHT?=
 =?us-ascii?Q?bHQlBYczIM7R0hiK2/XYnO5SrIrYDFGUqNRsEVqT9KesNvoG6QhSs16BlYM6?=
 =?us-ascii?Q?nj0wg9gY2IGRMN5iKZ8m6I7O4LVOk1PuXUkxAfVze8mL25MH3b1DSOtjkEAj?=
 =?us-ascii?Q?2udAKjhIgNQ/aotH36/Rz/EiFRvMhx2A3XLyuezFDgFq1EcKx65BwQdGitNm?=
 =?us-ascii?Q?Pn3hRYLnkSLRNLT+JEe1NgHnuZz4mf3qulnTEfrn1pJHZoD4ycVO4iWAa3I9?=
 =?us-ascii?Q?tLWUir7/3OUsaOZyak81sAwFWlvkhmgKHQFXyD6B63kkQozSxTvtCkG33cOm?=
 =?us-ascii?Q?6JiC2vaju8GELhDAHqJkd8y+PcIy+wWofG5j2dclwLzAth3ODcb6y7xZRpvE?=
 =?us-ascii?Q?yhPt6vgYzlqECAiFHYScE1dzH4EOUUC2CTFc+707Of/UDHnFFvOVxaUF0PIF?=
 =?us-ascii?Q?XXEuE7/77IkziWjRFK2ED8sWhKspbAQbm97//WY4LvcB5D741W/D/BPa+PW0?=
 =?us-ascii?Q?dtaBSFNc7aYMWmqCWGsPBckrtJOhh4cMYXwJ9KviZkQn9/XwvBn2zvw3ynr7?=
 =?us-ascii?Q?h4GE9rJqO9wjwGBsKCr0buFtZwzX7S7rAgOjAq0qZQs+yYZ5DJvVbo3INyUQ?=
 =?us-ascii?Q?omaxyoXY3DH2kZxpCORmgJBc2Uy6uyvfUWfhsuCXDRCJbRg5BvET55lsY6yD?=
 =?us-ascii?Q?27dDvsTcOuRw3zKGK4+AGvG0tqRTfin3dcLieBDEfL3ozNsf3YxiPuuXpmph?=
 =?us-ascii?Q?iFA1L9LCebronvX733sa6P23vhmDEcy3TxDiF4e4r6c9QaZ4oq9H9HaQusWX?=
 =?us-ascii?Q?L7H0GqyuW/Z8/R7GT/l/jBkMDMJbGh8+1BUyNMUh/koGOVaxS8ernKTK25Cz?=
 =?us-ascii?Q?d93P/0cg3nV+Taw6mxvZt/nXjCTNPCnQGFAta3b1Dej3kBXXRJThrUzjFf5b?=
 =?us-ascii?Q?Ng1NQnlN9u0FaRw3XAbo/9PJwuDtpfIJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?249Doqp4zydXTHee8v2IhqssB6KvRNYrSecZOH5QL/sujaNJiAy24z4oig89?=
 =?us-ascii?Q?Pnn4n76WTqHcDyWaeOv3+8VF0dxyM2q3cTb3FXX9GFBwhi1l4CReD/tT3xGr?=
 =?us-ascii?Q?xwvpj+6mNHKXu0MztBynfEMHa74rSd8AbjSQXV8mkw5SCCWJok54qj1i9XNl?=
 =?us-ascii?Q?b9IaH6Hsk3vdFMvUNP7T62YE8NvRlteXiryZ7WpCIhwhc3rZ4Y1sbw9Txl6a?=
 =?us-ascii?Q?Y37EFS9WnizG9OhnTeWec8OuQD2zX0ZjSTYKg9FFT3uHX2V5jDJaWyzx9MnL?=
 =?us-ascii?Q?ws9a5Ii/oJRvr4n71Hu61NSi4+Yj6Zuns2UDcYRDO9a+EVG3cX/hLXfXWFbp?=
 =?us-ascii?Q?wnFPSRJe9sHfpzXhdnxA2DuHGtJ97se6LPEHk4kmkMlJFwlltL8YFibFkJqB?=
 =?us-ascii?Q?ATGmpJYvKnaQA23YWo1WxEGcnwhwmY9+Sv8vRn51T52Gk1VUCCumdk+IQZYj?=
 =?us-ascii?Q?z/OzbdfaG8cdi6OdTkKooSnr9cnGw1bQQLykKcyMNkAxU8l9zmfB7FV4aB/2?=
 =?us-ascii?Q?OCGrb/FA/XlTsibR2BL/uk0CZaJuqg5JqzjrVw07y8dozjsKSyK463Wu9IvB?=
 =?us-ascii?Q?dfGxtv+F4aipxkHhHxgcYFQsyb62hFjOfMLjT7mbdcMcMr6kXLRiwPBGmctA?=
 =?us-ascii?Q?Cpj9yshGVfTM52m2aAbIU2v/SAbW6cae9Srg8CDLG72H4wxZ7sV65rZj1sZ3?=
 =?us-ascii?Q?43EkiOfgI5Wndk/QZeD+77BN9vEw80x0BdmM2H+uUt4v43tp0ZPjbo5UQtNe?=
 =?us-ascii?Q?fIy0WzZbD00DUKx156xnmBMKtTHaQOl4gVbfM8E7jvypqOEyAGMERDmJ0/Cz?=
 =?us-ascii?Q?e45nJKJYOZqqXGiNf701LYcSJdcAcaHuH19qC2T6w3HmwUxJjcIz4hR/fYcN?=
 =?us-ascii?Q?brzfU0Tm/JjQVDN249lXfv1vxvsODFMEC6jgW7ieP5/wBDYlDiSCIVF0kPtP?=
 =?us-ascii?Q?a/jO5USE6vMcdtsgaplfGFFOz6TTI3NodwEisLrzJIlyEckuxjRo2m1HlbyU?=
 =?us-ascii?Q?lLzPS5zwV5jkD0H3KSpAE19uZbe87sKSPTZKxJzdtkEzXnWcrmxmoV7CzSAg?=
 =?us-ascii?Q?rnQ/cD0RXuSaoJs+cYCHglUHWqzj+m0PHu5Fziu44Vz+cDepU8j10aIYbQ2w?=
 =?us-ascii?Q?s/k7VZfUmdQXRS3mlU2yee81ySnss60iBpVh4GpajeGz2DsMw4sEyJlpx6hk?=
 =?us-ascii?Q?ziEUUWUoAOModkPWRwVJGqTMPtuXzgdPPh+RyEHqVVekGiRq3yGTZNBSl3pA?=
 =?us-ascii?Q?7djrSHFsDZ8Ma52gFGV+xfMuI0gxB8DARzCKY+b2wnrKbC4zXLDTNLjCy/d0?=
 =?us-ascii?Q?0fSpnjtsH4Ng7x/dmseud1Fv40Or8j7NzsUGQs0524EzcMUGahb0HV3Az9pD?=
 =?us-ascii?Q?I9guj46WkhqGcUHnJ0RwlGfFBKmWxO9vQrbXLa5JycxcItb9obYWSGD3Xyxa?=
 =?us-ascii?Q?7f3ZhDY82v3o2N60ZFi3yNsfl4S48DpaZL53MRCpPyV0OmZmPWY0c0VtLtME?=
 =?us-ascii?Q?MfEfG9TzHpA3Ewii0XOhyU/GmleqG+7iXpZ8k8G5FX94obRbNqLWafGAwgmI?=
 =?us-ascii?Q?PT5yvZXm6l9slOfl6LWhXfh9EGNou+NWMtbkH/dv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5afbee-08cd-4711-49a6-08dd68243eed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 02:58:24.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbgasovNqtO2q08FzQJUfO5JfGQ9eI9VagHELo3kijHRAxzvGjCKBpH+rndbsEBwERpbmjiLMFmqle6eL+VTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	pci_pwrctrl_create_device(bus, devfn);
+	/*
+	 * Create pwrctrl device (if required) for the PCI device to handle the
+	 * power state. If the pwrctrl device is created, then skip scanning
+	 * further as the pwrctrl core will rescan the bus after powering on
+	 * the device.
+	 */
+	if (pci_pwrctrl_create_device(bus, devfn))
+		return NULL;

Hi Manivannan,

The current patch logic is that if the pcie device node is found to have
the "xxx-supply" property, the scan will be skipped, and then the pwrctrl
driver will rescan and enable the regulators. However, after merging this
patch, there is a problem on our platform. The .probe() of our device
driver will not be called. The reason is that CONFIG_PCI_PWRCTL_SLOT is
not enabled at all in our configuration file, and the compatible string
of the device is also not added to the pwrctrl driver. I think other
platforms should also have similar problems, which undoubtedly make these
platforms be unstable. This patch has been applied, and I am not familiar
with this. Can you fix this problem? I mean that those platforms that do
not use pwrctrl can avoid skipping the scan.

