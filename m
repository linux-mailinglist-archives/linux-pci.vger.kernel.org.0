Return-Path: <linux-pci+bounces-43983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF13CF24CA
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AEF2301C3DE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031692DBF75;
	Mon,  5 Jan 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rUTqtHfH"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021121.outbound.protection.outlook.com [40.107.74.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829D267B90;
	Mon,  5 Jan 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600182; cv=fail; b=q7DkusYsHgH/vEE6irDDp00B4BhHretdZSC28MOE+TLo+UgLxtqYPUp66/k7BdBQ8trYmgW36F7QwseYkn2hxbIaoKvqZykXbCzvBmrNxQt84QPAmwKCQmoaBBvcKkpYMYw7NKrSPEcnDZ0ndAz3xF/BH4JPp/BGYbdGgiJO0tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600182; c=relaxed/simple;
	bh=xcOgOeJcft++pxZ4hOUCTRmQxBOJz5dwOw0UE6R0zAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mT1BCyG1ANRwyVHTPoWmtPSEcQm/GyhsOqKGqfca3AR0HcoXinQ/JTli1r+jik1WgkgYpuOQoiTSonhjtSgutg5MudCn+MJ0aKvZDn/XRaEjGTFI/uBBvMO3G6+yoGkNeOikqn6hktZ0f3xJmACZ04uM25dYew95sIph0z+TGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rUTqtHfH; arc=fail smtp.client-ip=40.107.74.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWV1tYFWrRMT3M8LgSvEgSb52yiG3fCnT6/PaG8JIPEDXExrrZWrwEhIlDEk2TLRcLy7iqq0yaPgB9P0EiDhmXNxOgyhe1akxa9Ua7d/o7SIChME6MkaL6H0subFQt28lyhG+bPOYwdoAUC9HQkqySEtYLJ2E+GJ+89LomwqNHaFh4GKWkrxah6HN3w9UoNmHu69CEUB53R9K7hTK6Za1qQN/EpGarUCHioJnVcHaSi+d/NVHg2UcXKaZAap1a0+xXo+ncBQ+Lli1NIe3mqUfc6kfBJsRSjgmR/MGipEdivsAmd+GB1u+rniPXx3GvnlKCc8YYDijJP33R/t4zBFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+gklWCeQJTXh7YKFvLKwMnzqMfhQyPK2Zhe5BXZsOQ=;
 b=bBMKLHIFHAVBGvtn38d7rnW++aCFFZZ1cLMfVf90HMM88jdXmg6/cS9n3km+D3bjluPfNzMJZ7g5m6skZhmgvzTLhhzEarmd6E9PpUxcAfBqWdoDnFqpgbvpfm3UJ/RujJ/71GjikWmj/izQwHNb1CFPKVDHSA9kc0ftMMMx424E+F9RBmBp5tFdt3QVcQJf9xzoS51KqDzJXDdysjH2ZesbG06U3o1rlL1dMjryvSEvnkhjoA2QtyYBh8yrQdL+mz0HJRA3tyNnf0Dq3hvGxNYGp1yo8rTp5wGKDmkIKJOz1MEwhYJTYg0U0WG/aB268R6Hpo3jF5hOsnGTiDmQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+gklWCeQJTXh7YKFvLKwMnzqMfhQyPK2Zhe5BXZsOQ=;
 b=rUTqtHfHgYIjupgDpIiemh18KwWElDy0KDHLIxIBCbiT1BWryU9OVXRm3fVCmWCCuSQ/0JiqtgIZlYLlSpFxdh7Ag+u+hVcOc83KF969jHI1fk0MA6RNAhmf/K54MkOXkrxC8+HktCwWxxHUXC4NW6G8wnUbFvRvOFOrECYZowA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1826.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:56 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Date: Mon,  5 Jan 2026 17:02:12 +0900
Message-ID: <20260105080214.1254325-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:405::31)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1826:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4b3ca6-a369-42f1-2972-08de4c30d5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0zx22iRHviTNcCsGjUgFdNSoHlb+Lc0Iar9DqDYH+UNeZoCGpQYus8rRrsyv?=
 =?us-ascii?Q?ylBYuqSaSTuAoOmLy/lYMPkfY0EB7UCZ2+s6NSeVOGOsIX7MtEMwsHqpEqLQ?=
 =?us-ascii?Q?mvNmzRqQY+j+twTcrqjUVBiLAZ/kX5DmgKZA0t7qFcQ7hXdtg8b0eHOQJ6GF?=
 =?us-ascii?Q?VnyFH3ECN5PNyuk9kLJX2WHom5ljf/gqWpVr+Q4TI22f9J0D0T4ovJGJHBUx?=
 =?us-ascii?Q?0FzNI1RTRY+6dCOCPgPzPSxXdPsJo9xNfUGSPxz/gslEOVBBXIHjs/AljbiY?=
 =?us-ascii?Q?6EhOj+XRZ4h0g2Cwx1XwkRenXrQTYpLCqlPkPj3SoNG03OTV6iTiVrj/PMMn?=
 =?us-ascii?Q?Nu4+S+FtN7YpmKTf3N7vzezoOYrDzLDSPMdcNrUylBuDFCMb3O4aod5bUvp8?=
 =?us-ascii?Q?E7NC/8/CY5spne/J6emmBCYSyP7g71iTY0F5VFcsdUFmSOp7ijffH7fWLDDO?=
 =?us-ascii?Q?ZLx6Yfj1+40jWoU1rZgx1hHTT702hqpQvXKxtSK5zOKVu1rpRN1aF1NiEXSa?=
 =?us-ascii?Q?ThInxJMoiAVpdSMe+V2ncumxFKs+C1r9XK9i4arAWbKzF7nKcFIQfh88Mh7m?=
 =?us-ascii?Q?1DHMggWotbVSODDe8Q0el/VJSI75AI0E2xSRLftJnBz+WgNr4sRHGngQZwuz?=
 =?us-ascii?Q?17e3Jd/n+xOo8+lD15wb9qaZoTBOQdcH7j3c5NFRO/Wsko5QML3xFHN0bcVe?=
 =?us-ascii?Q?1vJxCsi8p+thSolYzeMQHrVsYw8aiKWZg8gKS6uWDqVNrviotDMGyNlQvFzw?=
 =?us-ascii?Q?5DJpoIJ3WCjtADHJkoA0dbbYD9/fay5erSS1Uxr/5KAxEFFpEElaIRH/cYqm?=
 =?us-ascii?Q?wHoqahYRARyC6extOKSGw/V4WYX643zbtGt74Qz2i4XHgJpQfPzbxak851iN?=
 =?us-ascii?Q?MOeByLe2M1PGKW7f42nnmTvKqeMaMfHk9LJVpmxjtqUlTIFAjM6/Jm1HZlT3?=
 =?us-ascii?Q?RRN8vTATYOEqaqzDd5FQWNZOi5H1564hedxmgrt1gFR3X4CHU7OSlrnlA7eU?=
 =?us-ascii?Q?aoTJCVJPPQNU50mcwjh77DCpSmuD90qNV2BUhNmnSfbN5gjBm/8+EZstcdI4?=
 =?us-ascii?Q?VFKEviGziJeqEMq48+sVCwtd/u1OUxQ7qQtfgLHFaatuCk+N6rBPfHUM1enJ?=
 =?us-ascii?Q?RT15BTqgaP7ksLW9MtLE/wQUvUNp6bE+ulQBWv5mJvGyAkQyB3z5+edflVOW?=
 =?us-ascii?Q?C+zttXIYeVp8ZhbW0p8N5Gm4RuI29w++KHxt3PkFJAVMkG6iNtS/eax+Q6OK?=
 =?us-ascii?Q?kdIIgGRvh9F03r0umtkEsPINA/gZZFHn4G5aWc153chcS4Fx9D065iVveWaT?=
 =?us-ascii?Q?2B8nWL3VlpzHDxwMnMXLqLjuqKMuzaxqOaSMxQkQYQb0Uz3ZT0q1yBhLLnrm?=
 =?us-ascii?Q?+4MW07Q9A1O00VCUEusepGXLum/A+ieH43tHQNWsNuhGh7qRbD5HXWpknm1f?=
 =?us-ascii?Q?t3xkDQKOyMR1B7YCNs30wCxuAmGB1k5yf5mrUBzHkEFymnABpmvVuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5kQSxkCNBI9GH49Dg/e4xJvyMGQDWm+otZ+my415DY2HVhrdwttOViFFlAG?=
 =?us-ascii?Q?8dsBPhbJiLOAFzXQwG6VhC6Pmlm17WP4wTuew4UOHCl4MS2f/RhZ1wptXZ42?=
 =?us-ascii?Q?x9yOmcD+eM44GdDjyP8ly6YkJqKKJ+ifxFuffEOjbFNvTDxmDxTe9VLZHINT?=
 =?us-ascii?Q?Nt9Njh5Y4DfGKpzq2AQjbI7h4rBclN41wei+oW3eUq4Poe+Ap0hssU0EbWbz?=
 =?us-ascii?Q?YZ9b4FTj9JsB2DmfKp/nGuLWQKfow8GmmMUtb7qo9qB5koDp+gBvOY0Pj4e+?=
 =?us-ascii?Q?7qziERL2kJbxT/3gql5Cbri+FyZpp4NtcIrjOXQLAh78Y0zXFu65sE/alrl0?=
 =?us-ascii?Q?CV9cfogaJA7e8P7DxLTGfPXoQGbOm0WSxZxFFzm3lx4j4kv3wEDTnPtuyhnc?=
 =?us-ascii?Q?HEx9M0Yzina6Th2y9d9ZpQeu6iIw/KtIr1AjDzdE9/9GH2SPOWvasD7vKWq8?=
 =?us-ascii?Q?ZJuXTlgWGXkl+BPWK6tb8MQNCZxh7WWJ5j7pxCMQJq8c0Pn6XDNBcnpj5o6B?=
 =?us-ascii?Q?VYbVuppcvMID66cSJBoioRIDgQsDw2Kz4gE/AE+kutJUsqQltVWb5Qz8zx1I?=
 =?us-ascii?Q?hli+ilKNVC9vXYSU5rbLl9srfSPtRZ1gOCr2tR2COz5gglD+RfcvR8hZg89X?=
 =?us-ascii?Q?BrekMeZqRN0K7hg2ELDV3KDnYD8dksV1uxnOnwu8vjuMEVvbi6k9tT7VqpjH?=
 =?us-ascii?Q?v61bOc2UKd8CWtpv34n7tMDY2cLtk2Vftp90rbgQhQa1vstk4SdyLg2bpOzV?=
 =?us-ascii?Q?9oJNTdXiDwZ/sOc50qzoGLqHI+UetAoHPGq+cM+wB7c69Z6vs8SgfcbOqopv?=
 =?us-ascii?Q?Pv5nZnoCthotn7tcZnDu+OTZigMW/qZB6l0wlWFRZAxlIb+0cc2u5kP7OHXO?=
 =?us-ascii?Q?pu05WYqXeaLdvW2kv4cQNNJgAq9BEYx6vx6UC0enDykAiN/k492EsC70hd5L?=
 =?us-ascii?Q?sV+iqVZ4F9nL1HSy5V82S9VSn0IYaLQwHz85G+VkUweBb9UeFqRk4kITIntC?=
 =?us-ascii?Q?5atUlDYajHlxpyZLodew2LCwpm6SNdW6/KMA0TYv3uAaTtiKpJLlLBNLIksY?=
 =?us-ascii?Q?vUG+YkbKptSpMRylRZiZDqAdxyP3CB87eVHoPR3ZGBS4VQ9bn1Utq1XNqBui?=
 =?us-ascii?Q?Pa8rlpIksQjJwLcZ08oiW2z3lLdSy65N1OZfM9b4qgy0SH9f8JFVtmTDXpXE?=
 =?us-ascii?Q?GyD8VPLQfgXtAZVlnuyVmGdUmZl260/tIBo26ZzbK/26BcXtlVtXAwMLtFH2?=
 =?us-ascii?Q?ZchHXnbPVv/ttbtALFX0hEPG9o1zviEFdsuJgQ1gZeStaabhdGWroO9QgsYM?=
 =?us-ascii?Q?Q5+idJqBnAT9Kfp0ulrnANl0sCRUzPg8BV6c18C5G7Q/AWSPPrBiAzri9KS/?=
 =?us-ascii?Q?pYpIR/KbEJ3Rw2rUdrxuEuoYtvjIF+StNJyCnx8kJdmWkSa8BCrvNPxJ2EtO?=
 =?us-ascii?Q?y3vbkzIj69XYX7dqIvaFmrQ9uerNokJI+MwKx4mCpXAT666v084mj3tHbE0j?=
 =?us-ascii?Q?z/IDl0xC2rcqwUq8zPafyLkBn5pQERDTqWw1/gr5K81raYUVW5G2WFXah/JU?=
 =?us-ascii?Q?8YWPOJIIecWL/caL0J6xm8Ug3d81vPUp5YBEpG6+c0Ctwwd8fpA/YMEq7AFb?=
 =?us-ascii?Q?crsOLzhq2+FpwiADMrZ/SRnMjE15CzVW2f2taAjVr0ahqUnJPPDrpi9Uj/yC?=
 =?us-ascii?Q?5oJgZD072TFIPSd61PuoI+BGjrT5hxhejqiUJpgHv9lZDOGCPLgiYMArUdJS?=
 =?us-ascii?Q?bSE3S/BsnHchL9hrenaHn9EzAjSp6E6wx6kH/o/OSRkbpLTLBAIY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4b3ca6-a369-42f1-2972-08de4c30d5bc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:56.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSo31YpZzxP7zGKDoW5ZaM9qKBoYN177ee0S4Dnfyh8rJq0MGwwdGskGB9lkXiiM/dvOkDP4bJ2eVLSGYOK/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1826

This series proposes support for mapping subranges within a PCIe endpoint
BAR and enables controllers to program inbound address translation for
those subranges.

The first patch introduces generic BAR subrange mapping support in the
PCI endpoint core. The second patch adds an implementation for the
DesignWare PCIe endpoint controller using Address Match Mode IB iATU.

This series is a spin-off from a larger RFC series posted earlier:
https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/

Base:
  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
  branch: controller/dwc
  commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
                         to support 32-bit MSI devices")

Thank you for reviewing,

Koichiro Den (2):
  PCI: endpoint: Add BAR subrange mapping support
  PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
    iATU

 .../pci/controller/dwc/pcie-designware-ep.c   | 198 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 include/linux/pci-epf.h                       |  26 +++
 3 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.51.0


