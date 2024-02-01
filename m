Return-Path: <linux-pci+bounces-2944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257E845CD9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C381F273A2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108DE163AB4;
	Thu,  1 Feb 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xl8T1MAF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623A163A8D;
	Thu,  1 Feb 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804050; cv=fail; b=eN2ixhdsv+UfLWiX9l98IBO+E5imMRMnh+ST7phwWCO+mR/oz8ZHjWAvc+evlP6Kwrbje2JOId8WbGT+rrJiImyzQfQVMwQErha84PzAqWv1mNQvpablTklsAMXIM7gNHkYPlmpyz98qXQCgFdPi8VHSWZT9GmyNQsilzpbYeek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804050; c=relaxed/simple;
	bh=9vOBvFwLsQFfcUpqiTBHWGAwQEaDEiEalYuERlgzbJg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jAoeZ9dJ1p4J32Cln9ivLvB7eUMx/qb9rPUTHzUC2hRXcoApdbV4zAv+HozoFLA3cwGBilNhiO0W14la0XfnV4aQDezdK/bo8g06bQA1I/ANGDLGSAhQJUZ6J4bsSRqhjD4HCCCZiRBGQvaYXdH9Qs1V6LY0lC1V/7NOln/yJTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xl8T1MAF; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQscprurEfFmBWpMiArN3UILgt1CVRCjNWlNdSahWFjY0pK6yqeYUmWezXf0dq+Ew4RuBGDBBCBDHRRvSyvD6tqKQZOj+eduS8X5ejZ4OXQDlBSDaLAoJPSGdBqg3a4nf8uMbWlbmqwQXUzPLdNjifDt+1s3JVWUuo2Xv+kr3KudrWlJOpJKchyQkHxFP9tHHzsqkX7Rg/983A/Jzj8RXN4Im0is3uyeU8rIGio/m63Ak4rRWNCdIepDcdiTN7rSTMNXnvxYiLtMU90EI+0c6JEtJHEfrj9gP/9aYFmabowVKp/In0AEHLx4DGJ/xvgE8wCOZ/6eiHnTVt/R3k2Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkGPA7ShXT2dMqSftoaGZPxvURuUZhBj1jU23CJyNv0=;
 b=HKxQF/J9lul77coGkEOZ/ZvuK7rflWQUnGkoqTYcgq5akOVydtq8topEagLGAdM2tGH0gOaNxq+VMRbuyAwvvnzYeOOIN2+NshJAr3frfPPxdcoJZmNBXMN4jEhLT3FwmBKsI4YaXmv0Xk6oRrVQ2kAug96vg7fwOBLJ69t0yib9NDvsL6UAIqhNlTL2abcag4PEVqp4A3gzTy4TXukSnEVvmufk+SbIQA6xn8wVBHDfczxcgAlcXto7AmEB+YX6pA6W+xAmY6AuZp1N9VymNaqEsG1xjxdjzrfWRBt1v31gkZM6TExxXoflwuhZ/kWQ7teGxXZr2cZ8cuo9Qp4qyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkGPA7ShXT2dMqSftoaGZPxvURuUZhBj1jU23CJyNv0=;
 b=Xl8T1MAFu9spWA0R2p9D3Rg2mp2lAxG6nslFB4tg/m7CyQgPfe6sObV3IurRbhKYT+akarmWF61kBkudq73yILXOWLDQrncXF6QDwTziQL6UpYAw/STJq2DQpWNz+ShCObft8ab+NUM+u7Y3jLpOazriz7x8A/GunwjXZMsH8lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:14:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:14:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:29 -0500
Subject: [PATCH v2 5/6] dt-bindings: PCI: dwc: Add 'msg" register region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-5-6767052fe6a4@nxp.com>
References: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
In-Reply-To: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=1219;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9vOBvFwLsQFfcUpqiTBHWGAwQEaDEiEalYuERlgzbJg=;
 b=YEAL+LZ6EzxOad+agqt4fr+/qSdbPLTKn71aWkiXrb/K7p3JFDOFJozvSI9unpIFXT23II68V
 PUYDY4QNi9MDg5/RoCgYSNCoKdgtxWsuL9xWpgwEP5sCL+NpLa9AJly
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: f200f10c-dccb-46e0-e1f3-08dc2340ce4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ajh/UnJ+qvAWkDgjfusb2i5iRduQ3FsZLEXRL9UM4azylf2E1ph6giUpTZf98/DAn0Xt33DjtKwg5vimCeLf2spVAIXvTWIkPFlDviuM6ibZ4+jeltHbk7sC68kzREkxbpwpRST6ljbgmM56FjvPqT2uFbemt57+BQxYb1mFZZfC674bxhSP/V8xcKT69r3nCoeOPHQia91gg7QCIEij8X/VLbzuQBI40b9IzOddusY7H/93QuG4bg08OdZiVLyJIUATGZSDBYp7haCx00dlzgrn3Gg2uaEVRM61GsGYQMSyUqmc9Z9O+k4tMWDG6j2q6Pu/YGpnwmdyjv4BReOt8uAedVqvuXk1G5Gs61z+51hqnBDDCuC5lZY58OFr2FB5VRXEN2zvE0GvF5kXPJGq5OlhDMsKt9Bqvja8cy2p4Im7SlC5n41NbXZUKALqT5DvsEMDTE6WE8aYxy9EPfDip/l/5sVdrigcOkAhAlsov53fwRtRIt8TMzFGF/coG+XV4Wk6n/wKaIErDm2pX1DCrfOAYvUFXlgL5YsZr9gocP3ThKuH0y+g3HT7b9efId+zkmwCAHA24KKZFzcMSOgUv7ElukA2e7WP/75yYBbp+GuHxFmD3+gaGwUK0c7vkgao96XeIKbLwOb2LIzkeOSVaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXFMWXN4RHFFYkkxTG9mbDdZZXd6ZHhaU3J4L1pYNUNHMzhrOHNnTlVlZkpk?=
 =?utf-8?B?SEVhOEljbVQ4NkJoUWYyRTZqVDlqRU1FL1JQOUNjZmRKd3pZL3kyRFVxcWZN?=
 =?utf-8?B?MmlKdFNLaDhoZHBaY3RyejRBYjJTRThKeG9JR1luc1dKcUExYlM5M1NONjBk?=
 =?utf-8?B?VUhrSnVvdUtPSHhKZ2VPdW4vODIyL3I4VHd5VVpyVWhZZVYvdTA3bW5uZFN3?=
 =?utf-8?B?ZXBkTnRYSjA1YXhldnFaK1RXU09YZW5wY3FVOWFuejNQOUhVMndIcW56Zmo1?=
 =?utf-8?B?dkNEa0RRaXNZMjEwOVRpR1hKN0E1M29oc3VKenlhdWpLZ25LbnJVTlRyLzRu?=
 =?utf-8?B?ZVRwa21JZjBGcmtLdldkRkVSQU94THVINHArUHJHakc2cThENk90Uk9HZlZC?=
 =?utf-8?B?S1h2djVMR3E4Tm5TNzN3czcxcXN0MkYxaHpGTmMyUmFSdEE5c2t1NW9mNXFN?=
 =?utf-8?B?NSs3Rk1qNjFVb3dLa2FTdytGa0NYN2R3MmcrTndCSWNRUWFIajhKblV2dkJC?=
 =?utf-8?B?OEIxMXE5ZC8vdW5CanhRWGFZTTVrZ0o3WW1YL2lzMEh0MldlY0xVbmFmK05Z?=
 =?utf-8?B?VUNVbE5VWWYxQS85SWtZNDMxTytEb3ZJbGcvRllaS0REMytOS3EwK1lleG5y?=
 =?utf-8?B?UG5OL2d0amsyZnREcnBRbXVFSlF2RlZFKzlTS2xHU2lacEM3dnVNUTBCNzd4?=
 =?utf-8?B?eFkrZC9CRzZQakpKTE9nV2Q0OHRtcDdCdTREM2l6MXNHdzBVcjMxeWFTWkNw?=
 =?utf-8?B?K3U5b2V4clJGODBZYytnV0ZvR0dZN3JWdjhmYTcwbFhQM2ZzeHZ1ZUJ4ZXhZ?=
 =?utf-8?B?Q2RoNm9hN2ttQTRaV1BEQzlpc0FQSDFaazVYdUtGeXFRbVFnY0UrYWVDZEc0?=
 =?utf-8?B?SWx2ZEZrUEdhZlBiRzUzNHdET2ZocGVMYXhadnVQV0xQRUVkTStVWlEyd0h2?=
 =?utf-8?B?L1o1UzcyRzhUSnh0UlIyYnBGY2FiUGh3eWVBNmNVam9scVBoMGFhdlFKUXlW?=
 =?utf-8?B?TGFtRkFLenlzZldVRHF5UHFyazdqdFgyQnp0VlR5SVVjWHMxai9oSUp1YmtB?=
 =?utf-8?B?YU1BNGxGOGVMMjMvTlBURDh1eVBnRVowcmRYWjFDNHhtQ3habU9FYTdJN0Np?=
 =?utf-8?B?Yk9PS1ZTWDBuYmJOUE9XSFBMSkJ0c3JvcXlhOXpKY1h3UTRMbElFUTVLQWJ0?=
 =?utf-8?B?bUt4d3FoeHpzMXVhWnhsVEkxaHVOQWkzTkRuTEMwa0hlV1dvdFQ3Z0NVM3Vw?=
 =?utf-8?B?QXEvTmpZT05LNHNBZkIwa0lZOWFpcGR6eENSeEFmS2txek16WlkyZGtjTGtT?=
 =?utf-8?B?c2FBL1hFTlZGTW8wN3l5dE40RWlnWGQ0VTJYWER4azFhL2szT0hDVmZ2dTRp?=
 =?utf-8?B?eWZmUWxVZVFWZGpnaE1TV1FPZmEyaDE2U1JzdDVONXNtdlErbU1HOEdwbWpq?=
 =?utf-8?B?TkdTRTVmTVBEQlNQaWplaFlhMWlwZytKdGdUQVgvN204S1hmR0pLb3lESm5w?=
 =?utf-8?B?WjlGMmZTWEpoUjdUbHNBZ09VMUxadSthUzFzMFExUHNlejhqd1V5ZkEza2h2?=
 =?utf-8?B?N1BTV01JU1greUZnNjF5d0VvMFhoblVVS05oeGVhS2pWTDVNZktkb09XYXBi?=
 =?utf-8?B?MHFDRVQ0OWhQQkVGeTVCVjZHNWNldUg4UURkT2R5WWIrd1NMU0V0dU5FL2Jh?=
 =?utf-8?B?Kzh5RnU5SGkzZ2Y1Z3BKWlI5OG5nV2hkQ1NPdFVPdElJTm5GYlpmSEN4U0tH?=
 =?utf-8?B?b1JTV2NSdzRrZnJnSTRjdUtNa0ZYRDJ1UlFlOVBnRGZvMjlNTUpZNGN6aFdm?=
 =?utf-8?B?V1cwRkk3ZjY1TVVGZ1A1VmV2UThtUnl6VHpRU3VySHZ6aUpDQzFSVDBCUW5O?=
 =?utf-8?B?Y3JDVksyaVBlWVQrZlpOc2NvTnJ2TENJMzZXZEpGazhkbUU0OG5rTnF4djdO?=
 =?utf-8?B?azFoTTRpNDZZMTloODMrZWJjWjA1ODZVMEswVi9aVnRPN1BReFdLUXllMUxs?=
 =?utf-8?B?RkVuOVFISFkxQzJYanlZdXN2QW9IUFlISlA0enBtb0J0Tkl2ZUZ3MGlIOWNB?=
 =?utf-8?B?RDRxdGt1T2FjVE96bkp0UUdyV1c0Y1A0dkt4RVowV3RBeldrd2xEZW80NHZk?=
 =?utf-8?Q?saCWfRvLOj1GVTbMs7LQOTuGr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f200f10c-dccb-46e0-e1f3-08dc2340ce4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:14:02.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO8WiIinESM/UWuz3dsr5jaEWG4uxJzWPdsfmgTGhUihQlU82CKHQgsBD3mVp2XD8JFFFwQKkpZi9vQdSludKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

Add an outbound iATU-capable memory-region which will be used to send PCIe
message (such as PME_Turn_Off) to peripheral. So all platforms can use
common method to send out PME_Turn_Off message by using one outbound iATU.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 022055edbf9e6..25a5420a9ce1e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -101,6 +101,10 @@ properties:
             Outbound iATU-capable memory-region which will be used to access
             the peripheral PCIe devices configuration space.
           const: config
+        - description:
+            Outbound iATU-capable memory-region which will be used to send
+            PCIe message (such as PME_Turn_Off) to peripheral.
+          const: msg
         - description:
             Vendor-specific CSR names. Consider using the generic names above
             for new bindings.

-- 
2.34.1


