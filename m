Return-Path: <linux-pci+bounces-14699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009749A1645
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DD21C21B1A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CB1D2710;
	Wed, 16 Oct 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJEl/Ea8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1946282FA
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122759; cv=fail; b=krPKrhaUvJPPf8HjHax7TF0TVZDqoGuItWzBRt6Y4ZZGV6plyikj04KDFzb6GPLtM1QklgCXz+LenfMjEAs1wDt7RSBhgzxWbhkd3u6amhD7MFN7594uY7IlvUPyw2q6O2NPuv/ZLz/nOGBPZ11Acm5v5ufmb2IVm8fre2Se7Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122759; c=relaxed/simple;
	bh=LkfXqd8po5VFWNVd/xXzhylIa3f0fR9945CNffAhd54=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oup4g4GEUJmn9bQhegs8QnvVrmmlRMvONhwvRtV09fAeXGlDypHyB0sjl5BQ1B/lJqZRQDUPfwHhUbIYm6F1BEXdL2qC8BiNPQuVIFjq/nuvC+Da7KgtiQVkggwEMcc9xtCn1EpiMP2xawOddBlH57vSVQgsM4Jm9sMITu/DtqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BJEl/Ea8; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSzBIfzk6waicx9SYQw7i8TzFELXTy+PMqWupmUIEEhL7AvE/LpjaA3Pr25ks2nUrtLslVPR93o5Wsdb9hJ0KSRgtJjTA12MEURPQuMN7P9BWQNRIKjpRUbKKzLeTklOTd1RsDe+RMlEbO4M/tnYfmbba1eluCURFfdoZyPUCOpRM47DgTLIfTrf4zimmdGmZm4egXrpo4Za4uf9KnGJVwqlXEnxkI6LaswhJcqBLM18KzzAMYHv9rF5wD2fmqo0BFgiDE+/qMcic+9q1eHshuZzkBdgVA9jrC6y5cjMt5uUDr4DeXD2HIS3CFJXTTpzvzkl7d0gCKUCSSsV2fo/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvSCKW1BOhBZB9WEk0vv9a9K072sSJ/KNk1Tki33iI0=;
 b=IT1ZQ40Tf+H2hXwLaid/6AnJXZ80+d1cXgR/hJ/nVwEa1PNSWiuggP/5mchr+nIG+sQnDMqwdbDlEzYvvN5rv1OSUfgIBBlJPus43zG1gwLx1m7IYESqWhsdcx+XfAuGh55+Vj0yEBfEKsrquw4PfD5l0+4VwBxVaiFGfTQ5HawPHJQOXWeRoXNQPaiFZ46bouF+VjyqZLNa8UnxGS4MiETn9b12qW1gjN30s2d0MNWRO9gZ6sZpxeyVlefv46P9yP5/0UqtmeQkv7fOt+3hPBgcbrn52sKbceydGEtxT/wG2exhmtMF465YfdbkdSaD3ewh1Ei8dOoa9+zaXfog0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvSCKW1BOhBZB9WEk0vv9a9K072sSJ/KNk1Tki33iI0=;
 b=BJEl/Ea8rNB6FVCyZ3BQ4e47+vARibRn/bGtu5UQnWAxXGqFt75r1aqz3pmXRoYw3FNkAU+bU81ggdhL//Nv384ZJVJQ8pVZoyaEgCQGvCk1Fa5IO3id+AGc6oe/XNShTp6B5T/xk0WHdCUm6l3MOGSmmMosIQcJ8Vq9Naaw0WJ3jrMcQFkxydo3cQJEtiXKgomvIK+kdxWCTXnPPaBVHEOBpG6kG7di9/4YzFkiaEUEJ+aQ1E4WvCJMhqMu62NxzXAwvBumONsHz1DUz1RI/6gwi+zadVFIk+FRL8gIl2me/mxFsOaIo3iMGUmxAX8K+4QZ5XU4fuXTRSgungbDIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 23:52:35 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 23:52:34 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steffen Dirkwinkel <me@steffen.cc>,
	patches@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH rc] PCI: Fix pci_enable_acs() support for the ACS quirks
Date: Wed, 16 Oct 2024 20:52:33 -0300
Message-ID: <0-v1-f96b686c625b+124-pci_acs_quirk_fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::21) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 76084d59-b767-4f1d-cab7-08dcee3d9b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YojpjXu6bjXqdUtIbQQ+9qbT1Y06H3+CBMADg0GVIe0sA90T46bXdZ9E2V2?=
 =?us-ascii?Q?/DBZsrSkkzwQT5Wre8aocpL+qmAs0aOrVEZI5V0IWNIVwV0kMITYw/B8o5nB?=
 =?us-ascii?Q?QBKzeF58efEhKye6sCNsIGUkp86oXiCZfr3LDHJE0sN7QsftqOrEGBEYCj7b?=
 =?us-ascii?Q?Z0OizEKVcThK90bf5LyXPORa2OZKPV2Ng5wXEdM4pAZZ160nkUdkmZGrRbsN?=
 =?us-ascii?Q?pdgWNNFRe7vbjUT9lP5/+4tNaH/xSIT0TAxMNXnIt+IAGth69qPxf6ynXLCr?=
 =?us-ascii?Q?94y1q+quPQae+pswrbKt54A+YFVZfaqn/jXOgRuePgA72JFQGCdWB+P2g6M/?=
 =?us-ascii?Q?EUywDK8ZPf5PkHFaE4V0PHBv5xeMA4zXDsvgv0VFjpbXTxOcZR/mJI8OUXlz?=
 =?us-ascii?Q?BYEzFGRbfi621dLEEPGrfA29+INucaHcnuCr1ICLJQt0lcai3kWcOcgloxRu?=
 =?us-ascii?Q?eVUQFPViEazEzikR0AVIRgXbT+3TxIh6rGcCMxdovzfZd4bV7Tn4hGySqA2y?=
 =?us-ascii?Q?kOsuJQLgotnQjMBzn+XFmf2FowqQNojetOJpEycOCTsrk+9RytdTP0KkAX44?=
 =?us-ascii?Q?ltmVSvB7PBMRoZmiP7wQFjs/+s7H7C5xSfnDnSMGiGxhjO5qhk6EJjXcDu6v?=
 =?us-ascii?Q?wyF14mrwpfH+nfj65lHtWVsqwdQXLuat1DNFIWNhkAxJzFAvjydjld/o3bU7?=
 =?us-ascii?Q?HslT5dnY+XkNbPGtRVR7yNsmMJkjeufKHzcSY8OYJ145yg3JHF/QHc9fifAS?=
 =?us-ascii?Q?XtRi3aRmbyvu4MAqlO7LFup3eUWLMFuKguPLCtWJQTMuHcUj7SNvSB2FYK3c?=
 =?us-ascii?Q?wfC+CzUTOiAoh/5GCcZeDS6qkGsihymYcXB2yA3ULfQ8jV/7p5KXimfcSkTB?=
 =?us-ascii?Q?fTBvs4wFbBKsDzP7la+fxT616vimF7XkJQXk/UjnG7o88kkVVS3vNG8IWukc?=
 =?us-ascii?Q?nuiPW6vab0AJGHZPsRYLoJaAOx6eDEwRhDX5boRY8XEMA6a8gr2Ers3DW0aC?=
 =?us-ascii?Q?7TU/T5/VBP6Fdlu1w3orTTuhuhe7uYRireTj5ClhZQpe3Nz6Awf4yvyCPYWj?=
 =?us-ascii?Q?1PZhvMa7aq5jromZAXUwLobR3Gp68ByetpbHszzhfMCUxvYgHN1ZW3KAqgbd?=
 =?us-ascii?Q?g4/Fa1V4i0/YBPAa7gcP+nErxHoP8r+RK5b5Kw4onjTJyKQkk0gx/a9yRqxq?=
 =?us-ascii?Q?3c95VZB51a9UdWHvOBfWnZqVWBniQrJJxtEjIwBndHFYTIWuHcEzvzRuF7rt?=
 =?us-ascii?Q?onvSAks81YLh1aiBRZmhUrsewL3mTRNuoW5OXxbRZDdbzoUSfhr3CezqO9iE?=
 =?us-ascii?Q?zUZdM3RRem3q93HpWnfu/t+b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMuPyODudC0hCYxwgxUf/LT5rcQ88UhW8wSJGXhQqT1EG/WiIP2LCakyXayp?=
 =?us-ascii?Q?JjcBvzXVxYS6Y2c0TqTsP9XewzxVRij0zCNJ9CDBw1EHu5vQ1EUj6HCFbHOx?=
 =?us-ascii?Q?WSRrVbBYSD8TsLp/3TuDgtXm2m9hkd/UYfMHowte2+6QB+TfY4WqTo9aVbDq?=
 =?us-ascii?Q?FuJat0Ol8KpNXdYtUfXb62QGYeZeB15p7osRCTQNj6FvsFJxna6HTu7dwHbc?=
 =?us-ascii?Q?r2zf0pFv0FWjYzQs3fuHA9KUhCpg2o5HMjGgM+WExPJv6Zex92ghPDJfvLrP?=
 =?us-ascii?Q?OkGf47esSUVwo23asIC5vjIR0mq7Q7uKXguFE5S/tprxFj497tbTTvZ0T+9k?=
 =?us-ascii?Q?28tgTX/bBjK89lXHMjSvdA/eCnx4Ph1KMRz+ZdUTieN5uz8tInnM2f5frXxG?=
 =?us-ascii?Q?5gKQ/QPe+66FZrSuyHx75Nfq/5tmCqSfsyY8vqqpMmeJDoKPev69o8NJ8cSS?=
 =?us-ascii?Q?F82odwVaKI/rkpBDdf6EpvNqSYWPaG/oDhdflqRPtrcDF6A+wkKpkosJd7Pm?=
 =?us-ascii?Q?v9bqh+ERb0vlqYV+iL/kVTJkQbhpnFzZM2EP4NZeesLGAXohxNUsaQz8L6SB?=
 =?us-ascii?Q?MWMZFVPsR7yZqGsTjs5m5LC9CeYbzw1VQhnzoP0ToynEAzVCXwSR4+sBSBbt?=
 =?us-ascii?Q?XwljnFyVgF1jkVsWwXgdK9pGQuzAh8WJ2xpuXYyQ2kj/fA2KmxVE+g9WtBuZ?=
 =?us-ascii?Q?xEAu/AfN805HAvokYBLjYchJ5fwPkwlo7zMF6Ag+yPXYtcLqBb7OJPZe5bJ4?=
 =?us-ascii?Q?p4FhFKWeLMw2REr6kf1ioXyp+9Q4yh3s922mZs26VocVKWBS+/uJBt3tMi+t?=
 =?us-ascii?Q?jhqNlX7wdqx5le/w/rIIharlMxqpWcDey/olJXcYUesaknOv1X8bWAhWTofz?=
 =?us-ascii?Q?OF0MO/lpYwE21ce3v769rVgIhzrDqJtnqOsH2tZ+8+vELy28PRPD+mGW1rrx?=
 =?us-ascii?Q?7lEAV2XPw5Wk5zd46eMJ7pOL7M6B4TS23jUQrioDpi7dxuAhy5ylPZiojQju?=
 =?us-ascii?Q?Y2RcDjaoA/fBobHBjUjbCl17Mff43xsZaTSXKTgOy3K/C8whQ5ONXp4S6Uzs?=
 =?us-ascii?Q?6iKeJreAGR60aTR0aYCp1lPhQ8rn0AsexPJF0fiP4RhDfmsAQBKR5MYMpRZt?=
 =?us-ascii?Q?qxH++u9QYPpSamzJAXFpZ1773OhMNG3nSkNWMmZ0zxfHTvHgUXyvRYV2kHxc?=
 =?us-ascii?Q?9hSY152w37OvtRFYLg3JzxpIQhDEQqFAMXATeY4bBD4rREnHunkb+Dhq+qJz?=
 =?us-ascii?Q?ZAK6z1pyYGiM+S6vnGpiplRslI9vNoyTM3KWuB5Eu/cfWkY+922MwK+QIQQj?=
 =?us-ascii?Q?T1igRsMGlyNHZHZUywmsSWZm8S2hFUJlw9spRGZI4clzqpQIsIXSt3PLRG0u?=
 =?us-ascii?Q?bKrqHCBNAaLJ5l3Hn3apFuq1hp9kkKpQbeyNiP8rJBDmPAjfZiP1QoFTcLxJ?=
 =?us-ascii?Q?mvB7tKxK2lewLv3YYnrCfwu7RlrVrmHmv7T6NEJ1UXwwkEb4S2U0MT+HX4vl?=
 =?us-ascii?Q?Ick1aE/LypMLS6GEyIQ6of69u4JYPER5cG+CrfKO7WicuewUbRyE8O5SIbS0?=
 =?us-ascii?Q?ZHki9A7Eoy97SmWSdv8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76084d59-b767-4f1d-cab7-08dcee3d9b5d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:52:34.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkM/pF577xFPVsiSHPbsyT/K4YoOTe2nOCw0QUYLG1MVDuRK719sXw7zRf+U5agL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

There are ACS quirks that hijack the normal ACS processing and deliver to
to special quirk code. The enable path needs to call
pci_dev_specific_enable_acs() and then pci_dev_specific_acs_enabled() will
report the hidden ACS state controlled by the quirk.

The recent rework got this out of order and we should try to call
pci_dev_specific_enable_acs() regardless of any actual ACS support in the
device.

As before command line parameters that effect standard PCI ACS don't
interact with the quirk versions, including the new config_acs= option.

Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229019
Tested-by: Steffen Dirkwinkel <me@steffen.cc>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2ae..225a6cd2e9ca3b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1067,8 +1067,15 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
+	bool enable_acs = false;
 	int pos;
 
+	/* If an iommu is present we start with kernel default caps */
+	if (pci_acs_enable) {
+		if (pci_dev_specific_enable_acs(dev))
+			enable_acs = true;
+	}
+
 	pos = dev->acs_cap;
 	if (!pos)
 		return;
@@ -1077,11 +1084,8 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
 	caps.fw_ctrl = caps.ctrl;
 
-	/* If an iommu is present we start with kernel default caps */
-	if (pci_acs_enable) {
-		if (pci_dev_specific_enable_acs(dev))
-			pci_std_enable_acs(dev, &caps);
-	}
+	if (enable_acs)
+		pci_std_enable_acs(dev, &caps);
 
 	/*
 	 * Always apply caps from the command line, even if there is no iommu.

base-commit: dc5006cfcf62bea88076a587344ba5e00e66d1c6
-- 
2.46.2


