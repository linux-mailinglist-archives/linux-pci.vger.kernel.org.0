Return-Path: <linux-pci+bounces-4904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61A880173
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E411F212FB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41782862;
	Tue, 19 Mar 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDMHYYRW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6680618;
	Tue, 19 Mar 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864455; cv=fail; b=QTaMh5fmI0keF5F/chKxNCUlifMtVokPInWQPh0uzemKkJw7JqhMagSC/DF7KsCUjhGt9IVmxZYs+1uzB+9pqDBecr91Hwskp6z/jPtDnazDdIAC/eX0z4KcBxjzp2cnEL4+i8a5IPNZVTaXrCAap5cjfaKrOGdwHkoSYTA77Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864455; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fkycJApHelVfS25KMbCf4yB4234+K7CZ+zxBI5dAVS7g/ToJriP1gX5d8/KD3paHNzFDAqKqNaEZKApHTop8rBjj707mQfbsLacV5yFuJrKi0AVkFQmhekG6dM+WY02lPSUn26WF5luFekXtGySEKvL2Rrl+Bcqc6lMLAnZSIQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DDMHYYRW; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3bTlkRXHTcbxVHiLdBbUQFiMlWQfVcTUBbAdh0l6IUdhQU+AY3HDaH9+mRDlcYKQKelubkSnkRFGlwH30ZYEEiq/IX+SwzWK4tbYXuznj4cl0jCPV1Fwxm0kVpZuXVYTOV24UPB3/n9FYPlumkeE9FA4WHO4VBEouFVpTi9hP9Q3LegjHfsuwG7x0eY+/Fcl/3kZ0cFkRRx+2tcLmqpf3G6+aus6NEv1xR67E/mO1Y+hxKvgko0TFC0w2BXuFpqAMg39wRz35QEcTeVpiXm9ZYcjjCAI+yglfA3AOsmzhNmAXD6QxiXlOR0t4Kjw2aAxRr5UstQ6ZiMACXWVNMfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=iaetgCAYyxwcO3suo/+fKR4KCiAWKxPqkFUKsBbOc0GAwSGqP9uyg6ysQ6+yaVVfL90i7Ci1PQ0062B2acF4bwQ4D3qh9eSaknAO/3bS1koF8RQAsotU8di9ziNeq1+SmZAKRa59xOdO5PRI2oGIHl7IwWShKnlfGWBNX4Uxec4Y3mXg3RnQhxLwIMgZlEZglkGJHf4L1wrIXa16mbr2PfzuapnLjTooGDBp3nNqW6d62K9nG7d8KYdJuIrcYh0RiXlUEEuUBm/KrEoJIMeG+wX8FlhE3Gl7A/f9o7ShuMeTsu8BHgx+saOJx3BL5TZnzHiWah2ZUZWCGYQguVrYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=DDMHYYRWzSsF5x/lG8ZPj5ZgZx3E4m0rF8vikVXVUQWZy0mzewfHE8/DCGOqi1AENhM5+3eCuEcc1DqiTTmNpi2e6DHBJTzb8PwWwsK0Ra+ZUNiriNx4Hw0k7DbfnyCrfIp4jko86EwBMN+uuCqmXR9IlgoxyzkpwP+cfYSWXBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Mar 2024 12:07:13 -0400
Subject: [PATCH v5 3/5] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-pme_msg-v5-3-af9ffe57f432@nxp.com>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
In-Reply-To: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=j2SQMTUWx8vap6et+1knqpQcLJ8Y0lAC0MCg7FCGJEcmjp5roEi6wyicb6+2Hi5OT3LMqG6MS
 AtuMrkSgWP1BDCeOzsTXMBvt3Nf98Jzrlk83IMxF18QNDTNVGAmdgMS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8465c673-5a75-43ce-9f7b-08dc482eae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+ddwlEpbUaQ3T3+gpjlikVyrjA8MdXwYBPXwqWxXY4Bsw0VQWPs6CryBNkLVaz/a95iuNquCZvZsQXgny4sAli/Fj4ex+my7+SrmQ+EHl5cQF6kiSBCr0RdNON2P2eVtwwPjrCfGgXVGtHI5IcjxWrJ/zmXhTLsTEUIJDv33TBpRNOvfIpvsluZ/99DEeL/xgveOLMScwsjlL4h+Swn8QxSCuIwH7muhsA3G34U8Ol4gWAGF31WM68sKAvNVXp/yYuHYp4FOPI2Ug0DyVJKv0nnrPIfVgGD5in8KOzPYfLlTLxE0FLxCVMX98944Mu5STojBoAUEOqY6RvX4VtkVUnKV2KApTgux00XjTZiPSCFb9Y/VruhAa40X4HSgs2lQbiDKjrS2BuB2lohCAniZoRhNWUyOPGW02ZSdpWZtKNQYozvLhmkvnFUBdsfgShf3kbqwvJZfZ3oqDTOMbc+kez3smg+eVK0IEuJKYS33CZO1mlmGe8sMrf7Su4HEtd8wUWDogtaguoOY/pOzRiEtIpPC3SZD6EJ9t82M8s7iVolWSqilDZnGtJWjDh8WV1JdB0raUFPQHm1vGAq6gzpG2fapSyYBiU3W2ZTAcXY0ozAdtNwT+T8yX94hHqdxL0DOUCyUeVOSRsObzIlKsGu0n4DS1lmgQWMCa3j6SU64PAR4+uLJYR+nf+AovzNb6fnLl6AsXpxjJqDVF+k9TC9YBqoogL9WJl1VKtDVQpE95I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlGeDhlNE1OWjJDeW1HMTN1eVB4UXlMSUwyeSt2QXFQemF1ZXhuTThpM2VF?=
 =?utf-8?B?OG1LMlB6K3FZZWlyU0sxOVQ3NU5iVnB4emgvR2tQNks4TXN1L0lyNHg1Ly9P?=
 =?utf-8?B?KzJmQU4zWVFwSWZ6VVJSSHd0OVo4ZURUcjJuSjd4b04wZ0JzaDZYcm42Uy9J?=
 =?utf-8?B?RmM2VkZva21sT3prVW5LRkdsRXlzN0Ixblo5dHdFSGpRQWZISVVNS1l4elIy?=
 =?utf-8?B?UThrMHJmZFN5NTF0QUlMb3ZvWUowWjN4dkd5V2toVUZ1cHBIS01oNm9tNW9l?=
 =?utf-8?B?NE1HOGJ3T21nQ0FRU3ZlQkJtTk9jVHdsTVpPMzVueTRadmlqRG5YbEZ2RHQx?=
 =?utf-8?B?alJoNUZkcENITTRRRGd0TmxqdXViNVZ0N1BxRHBsSURqRFBuNmJMblgvbTdw?=
 =?utf-8?B?akdqK3prUlFEQzlOTVhFaVJmZTF2WVdUcUdhZi9QSzhqVUtySnB3MU9sVVJS?=
 =?utf-8?B?Skx2SzJlcWdPQ2JUUFdwNEpXeVZpSVJ5Rkt3SU5sak5ycXovdTVna21ZUTRV?=
 =?utf-8?B?QlJ4ekUzeHR2WHFvdDVxNGd1WCtZdnpPZmtZZkpJWGF1K2tQa1lBQ0hEL2dY?=
 =?utf-8?B?TzBzZzUxZ2NkUlRaSnBUMkVaS1hnNlB5S3VPb0JXZENpS1F6NmFKb2ZFU2wz?=
 =?utf-8?B?QW92bEQ0cGRublNqWVRMNDZYcGM2bTVjbWxzVUpnR0tSZXNxV1E4bE02anJB?=
 =?utf-8?B?VWV2RGtBL0ZGNWdrQ01pOVVLZXhyNG9NZWNudndZNjFzampoV1RVTk14RFhL?=
 =?utf-8?B?eTVzZnpMUHJvWlh6dit6OUlYUFNGWm9BaHlLQUo3cjZlMlNUM1BNYUpiNVpx?=
 =?utf-8?B?RjhXMDJpTldONTFuSlhqbEIxc0dRTG5QOTFCTVR1OUczenVzUmxHZE5TQ0Nu?=
 =?utf-8?B?ek5mdi9HSVRhSVM0VHc5YnQ3akVqdWJxWUxadzJBQjlUZWlnTHhzRUFhc1pp?=
 =?utf-8?B?cEVxb2t3Zno0NWNrdVRlNzgrRGUvcVpidXowbER2L0x1ajhTWmVOeVdBRzdq?=
 =?utf-8?B?Z1dZT0FTWlowKzY1VzEwWlRobFdnTWloYTdCVldXYm10bndNYzdublN3d0Zo?=
 =?utf-8?B?MkJ6ZlJNRUhVR2pVTnlSakN3amh0dkhLTlZra2Rxc2d1Y1gwS0JvekVMYlh3?=
 =?utf-8?B?a3ROSGdCZXU0ZktseW41V05ua1dpSEVBNTRtVW85Tk9CZmRDdWhENXBVbGhH?=
 =?utf-8?B?d1A2ajZIanU2YWNGM3R1cW1IeGwzLzV5c2ZzOVR2NFA3aGk1WGVReXRZT2V6?=
 =?utf-8?B?d2N4YUxEWW5sYklLVUJ4SlRTVlg2MXY4bjNxdnJUeVZOZnRBenZjNzdIUDRK?=
 =?utf-8?B?ZUFlOHpQamhWYUVvMzNSb0NJUisxK2JocFNLejZGNnNKMXJYS29hTHgySkt0?=
 =?utf-8?B?MmFyQ0Z2ZGlSN3piS3JXYTdPUk5jQ0pCV2QreTg4N1ozL1ZuL2JWQ0d4K3R5?=
 =?utf-8?B?TVgwTmFXNGltRXdGTnVRdHZPdkJJakREbVh4TG51ZnVKUjdocWpvL1JlcVFE?=
 =?utf-8?B?WWxjaVhPV0VOcnJNazZmN01LY0dPVmV4Y2VwSnViTXZPbWsyTlU1WHg4VjZ4?=
 =?utf-8?B?cXpNMUVjYWxPYkNHUjUzUGE0b1RLaklBVS9Gb2dycmdwRjh2cFlsU3lzbTdX?=
 =?utf-8?B?M2Y2SUI5MDJjWG0vNXZkWUp1UFUydTgwMWdyRmtsOWI4ZGpEVXVGQ3NkQ1FX?=
 =?utf-8?B?SHVzeXhzbXVDYStRd2VTV0xBcFdlV3g3anVnaUg1dHVwQlhURW1yRVhHNnpr?=
 =?utf-8?B?YUE0QUdIODd3YUFFS0ZLNzJXWG5HN2FEVzVubUFsVlUrQlFrUkU3Z2VjdU9G?=
 =?utf-8?B?azhpbi9lTE5rdzFuSXFRWnF3b3V6T1lMZzl2TU9uRTFkeVFBaWc2eEU2bm5u?=
 =?utf-8?B?ZCtjaVBuTHp6eDNaaXFVN1NUa255eFpwZjBWMG15LzlMNnh1ZElkK3lqV2tn?=
 =?utf-8?B?UHNRMjFVYmNxZGhYQy83VWtyUzd5SDJQZGlIVXFVcThsc2MwaWtIbWFMRGZk?=
 =?utf-8?B?Y1JLSm9xYyt3TUxjNGdPM1pUOUJ0ZGhQOHFGTVluUDV4eWdNc2xabkRMVGhz?=
 =?utf-8?B?QnVtQ1RRM291L3I0cTllK3h6TmxJUXFyaDlYamM5KzR5QXdiRFhYaGNMRFlQ?=
 =?utf-8?Q?YZYiuj0sMa6ylACr2iXDjoZxK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8465c673-5a75-43ce-9f7b-08dc482eae38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:30.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfiJWMtI13vPRDWkicPnaX7X0/Ezge53fKv9ncmr/05+9ADw3TsHe6Y4oSzbcb4njjcCofYEaPUNkcE7nUOMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


