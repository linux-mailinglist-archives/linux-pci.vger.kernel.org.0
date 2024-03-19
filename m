Return-Path: <linux-pci+bounces-4905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E4880175
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F61F21428
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0482887;
	Tue, 19 Mar 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gl9qZfE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878881AA3;
	Tue, 19 Mar 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864457; cv=fail; b=TRSXs3DB87uLmtI1YUqequm1VvgmU4r5I3ZVfpjKomAc3RmsbDRazB2hPSmXme0N+nn1aoIRQFAy/ep/s4IqVMT7eg2aonh+Wt/B/22GlxiTMYuNMHjD3mG9sgNGxizoEIRmrKBkmcoGo6d49UKhaUArM9nLuLMzI02u7W4uYVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864457; c=relaxed/simple;
	bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uGu7bJKKmWuo796NRmVtcQYYiQPxEsM+bwR2T2IiGb2inVcF6fOnoyd9rUnQBu1OYxVGMIxm1gYJoNTeD7LxuxNXvLLgzbuNNwAq6ZN8atlWB87ttGvn5q2T+UnjPqdTBmTkm0m8Q/rW7WS1fgVQEcYiMmZg4IPIk6jlmtIT2cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gl9qZfE5; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm5rFdsfH9kY9QH3zcq4c4FqE8GCAUDhX3S4mKjQdgDe3YDBVsWWx9hzTgizKW6bqCpUuySPHGIZNddk2D2J0A4hAfbEz3X+MpsjSSL/8/6fSui+IfDrH/WAsh/qtB0LEKbjR/fj7oUqTbi7ZysoRMd45c/NtSAbEy/YPEIdtNWSZwoaCBBz0m2YZA6H8He8zIja0LYv1+xOHF+5TbNfVgKBQERYh1Si7Jzz+mNZEt+sZI8h08pOur79yIxYVOMseYDKx5HPUoVFircrWhzXsbqB8crPd4SWsWeYIg4ZKL3wvKrqfMDwAAkQmpa8I+u2RlHIVkbwKGjtcSWkePXHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=hGG/LCqOa2F1rSiAevC0l0BOLGJ83SIIMoWiKedpioZSYFmvLPzsR9DlEgSXy6XTH9TPCY3Lh6lAy8EP0OlPXT09d11D0S+hwDN9+HrJ8u47CCOmvBgvjNcfHW1PXKaBKQUw/ZIU8RZ0wVDTLqhWOLJESLAuHBL2Q6RwmzJ1LGxg+xlQkR+/3dkx5OY1MYMfB7Eu/J2ibsvMivhntFCK/2XbS+qjbnfR8hLCdB/bwOJXDDclSyuP3QmQHbr0nciGIaEmLv4Hi7AJzpbA0BHT6JHlRSUUnOHEALKh7QKW4pD/2mz2L5gKh2E8GxWYlh6v/QDLyxdlnaQp3BBJp7ELdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=Gl9qZfE5Nxt1jX0tdS4OQcNS97quz5sYL9OBU7I/3N1W3vqVDJx6W3N4gwM4SI2KudXxVUY4S05e4R20GZd1gcnTRElmxGmi1SYY3PHehHLmUXrenRwP5GWSkspQ+BEkPXQ8gyFhhhOELVjF284rStPFlOKpgXc4LSiAkX4o4Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Mar 2024 12:07:14 -0400
Subject: [PATCH v5 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-pme_msg-v5-4-af9ffe57f432@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=608;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
 b=v0Oe1wNs9IYAxjmNZF7xccBvtMkRKbU5zDnc/GJcW6Fq9xxLR8OeRUZgi7GQzhtjCAp7KgTop
 uHFmZ2AKGvvCz0bZVb/06FuEq7fHbTCiK8bPpZkcAR/bYg37eyr3vU5
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
X-MS-Office365-Filtering-Correlation-Id: 22c077e8-39ba-4f2b-cf01-08dc482eb035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gv1LK2SdC5m2EITTpg573sN86WlQaLsoFxJCbRw6BIVWr7a3oVcY3ivlbF0+C17Z1gFnawZ2ZvWE6w9Tc3pTlpuQILeYnOiy27IVR4wDyxIiX1ONE273OxDb99OQOJhYTOHRPIXkRecb2N2dUcHYMRu6G95IKwRmQKop6jXbYhaXzmhxFKiNYvo9HITDthm7B9QFGg0Clh1UMr+jddJmiEMooF0bElqiZ8lfR8sPqp8fG8J25ww1N6RbI9D4VlSyDx8yH/scZfB5rhiSwbbq5aiA8Ay2MhuTH7vJAyg95YdjLaqeVUcb/r1DYKLcUZygO5TmKRUKhMWF124PTwhbbKuWRhFahdii5ryNUsrXe0/UyGfPcYty2wIAZLCyNjOmkiea2OXiFxgIqYj8MLOwMI4P99Nihed7g6aulnqSZ9ZucbDsIbABnLL1ermJF8BvVry/EHBKMuTWj9G+dEXVMsusPTWKIfWhjn1y5S0lqzUzMTWiyJ/45ZCeGbEUkbe8/JmP+CAKAvn1stYwQ5+pku6ET+jlFM+eVlF4y4rtRl/ueQ9VSnwVPk7d7vQp+8x3o1b+FsixdE34L6kKaBaXoMv+ooEDLVy0RptlG1RvHanJvv58BNEpxVi0zQIE8+MDfi3hbovYyVzWySggV+hREg0Hm5n68r21HirHTxRzicwQPgP9UzXk6aGJNrXxJIu9W7e+F7FfoODoGSK/kyVbA/N9YS7T7YZMk/EXAWJJTrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZVTWRFemtFM3NOdjk2dGRnc04yUXVjOCtJcVRNc3dnYXdQUUxUQS9FYUhV?=
 =?utf-8?B?WUp1b01uLzVFc3QzYW9EckxIRW5CaVJaalhYWDh0NFNlcS9wTlZQVjlMdXJy?=
 =?utf-8?B?OFRmazduZlNpZmlYNTRmMXh1YUIwNnJuL3RwUWZPNjQybkFGa09ZbWc4eUV2?=
 =?utf-8?B?MEJsdkdnT0hWUStlL1dUVVVwWkhBRXpTMHlUVWV3MWRqZzRnUHpQN3kySEhH?=
 =?utf-8?B?RmdzSnFOYm5IU2JLMFQ3MUhWRzdZWE5GVS9Zc1gvbHl6cXNhU1NXT1gxOXJN?=
 =?utf-8?B?S0lSamNET2xYMEFJY3FhSVlmQXdWMFhrZHU5VXBXUkRqeDIwQjdQVjNrVG9k?=
 =?utf-8?B?UmticDBuSzhZNndPWkYrT1NqR01LdCsvZVVqRHZDWmN0UmxkKzlITmtmOWRT?=
 =?utf-8?B?V2t0ZFN4NzZ4YXhtbE5VUmZIS1lsK3RhV3ZEaHdLSmxoQVg4c3JpU1pqSWZs?=
 =?utf-8?B?RE8xTk1LNUY2NlNjZk95SG9kSXZNUGZ5cTRDRTdrRVBiN3RuY3pjNlpTSWky?=
 =?utf-8?B?RGd1ZmhIWWlWbm1LUGVGYjlSZWNCWUgweExCMGZCRVV6aWZkdUNwOGp0OC9p?=
 =?utf-8?B?WE5XVU13LzhVMS8wcEtjZEJOa3QzZmtmaFBmNDlteGFVZzVYMWZFYWtpcmxL?=
 =?utf-8?B?K3JKV2J4Y1pTM1A0UWl5TzBPQ1NVN3grMk1JSWYyTUNFWFFGZWRuWkhmQlRJ?=
 =?utf-8?B?bHhZYTIzMWZibmJXRjl5WjlmbXlpMHRGR2Z4UHVGcktoZ2MrNW4reEoyYTg5?=
 =?utf-8?B?bFpTUnJYMFlTZHhrVW5YZFBvaGEwbklxQVoyMDdqOUsvbXZ1VVhNYXpUcnhh?=
 =?utf-8?B?YW1QRmswci9BM2tJd2ExbklNZk1sU3lBMWpIc0FNbi9NamxDZlgyTTBBQUU1?=
 =?utf-8?B?NXp4aXJSWU1GNXBwaFRzd3NOa0poTEpqTFdnYzJwbGRkNWVsNUQvVW9saGtY?=
 =?utf-8?B?Vit3eHpEU2lvSnd3dllCR3BEZ3g3NG5PMEZpenYvQUpPZFdVWFlCK2s0cG5S?=
 =?utf-8?B?WFBzalAxWXd0d0Q4QXAyaVNEM25JS2VoRksyalg4bGk4bXI0ZXU3SzcxdUdt?=
 =?utf-8?B?TXhOa1ZLTmZwYUxmM29acXVUMFl0OTloOFlxaEVKTEtaNTkvTENYMWZkd3VX?=
 =?utf-8?B?WElmRjJWVU5GdlJ3MUJKTXFidWFwUEFEMDJ1WHZYU0l2Vk01M1BEVjBJaVVC?=
 =?utf-8?B?eE1NdUZreFk5bHBIc1l0Q0EybUFjeUFZU2YxMGticEtmZkRWcWFDVEtHSHho?=
 =?utf-8?B?cTBZU2E2ODUrVlc5blJHZllLRTdIVDJmdzZTSHlCQUwzRkhNVm5sbHh3b1ZK?=
 =?utf-8?B?NjJRbXhjaDRCUTZxK2R1d0gzSGNrWDhQaFNJYVJyenorSGtJK1lTSVhPVEhW?=
 =?utf-8?B?OVhWeFlJVDVlZThUZUpuWVNYZ2ZrVUxKK3psbWdxaDlES1BTbnJWTHorNEZm?=
 =?utf-8?B?aG5JRVVPRjNGaVRhZkwzSnVITHgrUS9zTlJpU2thbExtblBZYmtLNUphYUtG?=
 =?utf-8?B?WlVnYWMwRXIwd0g4Ky9jRExvalpKTzFxRDl6akcxWXgrTVlxVnZRK2VSNnJP?=
 =?utf-8?B?VUY0Ui91SjRWZjBHUG11eVdFQ3V4UG8wRHVxZUt4Tzkxc3I3YkFHWDNuNDli?=
 =?utf-8?B?a0hkUXhCdWo4TnBSaWxkV1ZLSU0xVEJXbkRnSS94WnpnSGt6L1VLT1VTeGov?=
 =?utf-8?B?Q3VzU0FGSytSZXlWQTJndnNld0prcDBFOG95ejZYaS9yVHZLV3dsdytDMStt?=
 =?utf-8?B?WE91Qy83NndOaTlnd3dhRmpSYnFoL01DcFJJcFl6UFRia2NFZVpOVTN2S0dw?=
 =?utf-8?B?Tk80YW1lMkF5eEtYN3RvblErWVVFZG4yU1FVbStxNkpnMFBseUtzbE5TVFNl?=
 =?utf-8?B?MU1ISElaby9aNStkYmVLVjFmUXp2V21GWHI2dW54TW9HTGFvVDFFVVFjTjRR?=
 =?utf-8?B?KzhRTmlMcjBGbnp4Vms1bVIvSGp1dXRCNXdQOTA0WGpIMGNMY1BJUlpGV2lN?=
 =?utf-8?B?SndqazAwVHhFVkY0MU5oQ3hFZldMY2VyWVNURHNXb1JPSzNRekJxZFZsR3Uy?=
 =?utf-8?B?K2Z6TytWNkhiVHJMZlVYYkxuYjB5MXdBREE0bDJNWVJWeTVXOVk5Uk1QKzk4?=
 =?utf-8?Q?20OoAw9+MvnW8C0HAiZnocsIP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c077e8-39ba-4f2b-cf01-08dc482eb035
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:34.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ricgGTH3YVYezQJP8ah2pob4J3SmbsmHUa2r453yebqPOzDnnLQVxzZpTb7nv5vLV2kZqxwXD0AOklX5JZ8KuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ffd066c15f3bb..989681a0d6057 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -40,6 +40,8 @@
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


