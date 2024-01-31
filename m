Return-Path: <linux-pci+bounces-2845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BB843229
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A7B288EE2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9D367;
	Wed, 31 Jan 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j4YDtwxK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67D7FA;
	Wed, 31 Jan 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661958; cv=fail; b=kR4FHKVtUdVs2asRrGaH21P/idoJFDKRp4WoT+HO8PpsZski/TL7W90CguL9zNqwCCYUkEZw8YziE4HnbbtPPppmapifyBaLHCRpuXZCWsNDXV2dcGRppbBAEw4H7traiojEuSOeu2Saf8gSZj3LCbfk0AxLONkLB4WphMG+XAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661958; c=relaxed/simple;
	bh=AHWutlXZcF/Gy8qVRgrYSkg3yhugKQyNdaeM8mmlPoA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DOueFJjQDPqD4x2pLAKwh2U8s/kl6YGid4oIfYHIw3FBySeNb0lb+0J07U8B/m09uJXsOXM+o+jrbo/GlOo4ISr+YxV0iuriIIzo51soAnc/oBdVmqyfAoYQ5NEYGCbbzU4GYYS0eYEQEZm9kTjGc2AcIoRh9HJtYRKpUYFonoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j4YDtwxK; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc0wHPPsCPiIx7ODX/oCrIYGTbhQeT7n3xOrDp6N3ghVoukjJaAP3xeFHXSvkR4yjrc1haVyvqJkSdutYcmcjHSmh8IrVCIPKmO/EB52bXnqrsNs3jZOqAVbhcanIVou6SMayQvwrJGydmoO+arDhUwX10kIvKsOwRtEn0ZFI9uhO9emn0XLFDdWNg2VHBd39QNDpsU7yn9y8HCr+G+GU51aNu2l9PhJiEw4DhFata4l30RqfrdJJmIx386ckIpNwRTt8Nub0jZmEuLnIRbgsusXeEo1EHm2b6WYSWaDuxWv4i2fXzLndfcg2pNiNW8Zk3G1usOlTZ7fXOwvNLnX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNbj7BlOQYou1TcmgULX24S1B3SFsfmEBsL6aFWwD0I=;
 b=od+sJ93vsI26RHmMdoBh0ydoDsjUyPwBiK1YI8mQ0WB9T9C4C5+3NpsLEySZRxR7CCsM2pcfSuZIJJB3A6OdC2lbfOSugLJjLSf9nIZj89ZTT8YCcP0slkrhCKgjSc5xD/FOCfQKJQlKEnk/Y3TWdzmoWzNA7J6xAyMsnhj0v8cz2dWHF04soaK8tZS0ngk+ACiaaeE2q1uNtS7kHlG26bnbL46n4foIBGMFbgcVpfr4vlJcvpqIm/fIyG4nCn1O/+JPc2P6tBBvBHTmLjzKf7Fc2Q7tn/7iGuY9J7U/TxPVN7muue6M+rBJOfLWu6Ir9YF5TwfM1AFCTXBR0P7nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNbj7BlOQYou1TcmgULX24S1B3SFsfmEBsL6aFWwD0I=;
 b=j4YDtwxK7VDxW2fB/cADJBw0CQ1KmklYN59irsHA43erQKZORSt1+QrvceSeAo5xhgOIYlaFYy39EDkM9uUmahzfezPsKg1/dB9VmgeQKghYwiMtRW5OxYVd1PMkzOZoRHDb/laJLKcN0hsDY8JbdVC2kys8DShiCGteMQDvz4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:45:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:45:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Tue, 30 Jan 2024 19:45:25 -0500
Message-Id: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWYuWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ2MD3YLc1Pjc4nTdlBSjFAvD1FRLCwszJaDqgqLUtMwKsEnRsbW1AJH
 uh59ZAAAA
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
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=2564;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AHWutlXZcF/Gy8qVRgrYSkg3yhugKQyNdaeM8mmlPoA=;
 b=JIROYiun9gIk+/VwjTUyvL1xS56xcyWqIGA8F5iNIhqxBacjVxWmN7QS/0JZrw1/A3Kxd5xJN
 8AoezePbEL6DBkXz3dHTi1BvVg5lGGSYFfFGwx7hdwMAduPf3AkpfuF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d75580b-7524-46ee-2069-08dc21f5fab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sx1zQxb9ZWLOQiDgEvR3p0ylSt0OnJi1QKFpSe3tOLddPKTdKsKFJFr+BByEXnG35+cG2m/G4Y/Voe0yqT0j9HYwQsFxjjKgZxEtmKu59TcxMaS52zRYQk8QVmoPbJz1lGL3Vlaoey24PmACx7Bj6fjyf7WmdiOLaHnsgb5vLU5qlrr9T5EAFo4eSegM5R7JLLGCVvTLEgOEvkiMG6WKrqKXPzFYnjIbREHNmTbN1le/7T09oq1y3vTQpWBU0YKlFpKb2gTYgWXONRLV4sLKR5lMc5/7KWbAbdWgvZ55ZNlOgvnVAZvAU0YUknNuXR5HcYiVwIMFm2L9qLEDpD3QtKV2Oa9Vvx6FtWO2GZ4nvcnsfpV0/x3Y/LJXsbgi8aaBIe7RQxaMPiHx4XtjVQ0H1aQA/yLwnlg4Sk9hNzxGtGA7eOGG/0Th86hw9bWzpyPSmwZ5Uiz1aQBRDIfRGtavxfCyaMIc6G2gR1Co6qhFUNWAoaKsEdciQ3TZYpKT1PLXl1Pmiud5f9mhGT08RiT9BzAexo7lB0hB9usczTM4dv59I2WUoKV24cHawIrOoq/wF7Lrd8nuE5iKUr61mMNSPN2iwXl51MPPwZUwfX3jO7vi7Kefa+eWix+ny29wcQg5/rlaDR+UIkhpAsSrkmFikQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(54906003)(66946007)(15650500001)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNkbFRRR1djZERkSThTZHZ3czhuZlpTT0xDTlhDTS82dG0zVHFBcWRIa3RY?=
 =?utf-8?B?L1pRcVNITGE5ZEkxNXBnZmsreFB3SjlIUnZtWE96MGtyZ2l1NVZicjNzbC8z?=
 =?utf-8?B?RElqdmpoOHFKU3RvTXZobmRpNm1nUmF0QXlxcUFPOE1kS2hlVGloRW9ZeWJh?=
 =?utf-8?B?d0VvR3czd0kyS0gvckRwYUl5ZlZOeFFkOXBzS3NvbW9qOXRNQmFXekVVeW1s?=
 =?utf-8?B?SFd1TDhEZzZvdFEvK2R3Y2RUakFCNXR0WHJFZy90UTFZNTk1ZjdHNEo1ZFRG?=
 =?utf-8?B?MmJXMUNSZ2FUeDNZakJranBQWHh1bmxRNFZTVWI0R3F6dTVSVE9IV1k5VHp1?=
 =?utf-8?B?VVkwV0pnTHp4STJLSm9hTXVGcExGcEhZWWN4Ui9rWlF1RDJRZW9TM1lBeU5P?=
 =?utf-8?B?SHdkTXJBcVRFWURHalN5SVBiMUpCWS9DckI0RDhCVmNpbFNUWGZWYjBSb0py?=
 =?utf-8?B?MHorZWpOaHE0Y0hkNTVMTmlZeU9LMGgyeEdnSTZzNFgya0UxOHBjdDVNem9L?=
 =?utf-8?B?S2tCaHo1TGhUK1JpWEFzYUpkQmhFaDVRSVdvWDZuOC9KR1M1L1FvSExEdHl1?=
 =?utf-8?B?SXhDeHdycmIycGFFemRTRU53ZEpsblBiSDF6aitqaVRxNGU5aCtwL0w2V1h5?=
 =?utf-8?B?UDZEc0xkZkxNRmtGMiszM3ZMb1Mvekg3Q0hsdG1kR3NtcWFPZVRFNWp2WWQ1?=
 =?utf-8?B?TkpGWnRhNHFCTDZLaERzRDYwZlN4M3V2YlpyL1FTckwxNDcwRWhnU08rclZ2?=
 =?utf-8?B?WCs3cTRSSVVXc3F5Zmx4MUJnQXc3cWRwWUh6VUZEQ0lpY2RhS0VrNGt2YWdZ?=
 =?utf-8?B?dFBEcHFsUzhtckJpUmtML0tZQjFTcWZpYklLTm0vUGVQU0tmQVQwYVE0SjVa?=
 =?utf-8?B?amRkRVNua0s3eHpMQTc4R0xDL0VqQ0FYZXFaS3Q4RlozZ2hEUUM3ZXkrT2Vp?=
 =?utf-8?B?THdhUU1MREdWcm1IRU03ejd5ODlKQjdiV2ZqSk5SaUphOUVtMktlUnBuMFhi?=
 =?utf-8?B?M3RuZEZFbnUyL3VMcmY0MFpEUzk4U0srbnU1T0lvWSszQk53WEZaVEZpZzZn?=
 =?utf-8?B?YnpRdzNqOWhZYnJCcnY0OVBwMjRhZnk4dU4wWEg5QVNTQkJZdkV6czJHdlhM?=
 =?utf-8?B?Zld4amViUDkrdGVtTG1qL3pRVkVuK3BTZTNhVU1hSTUrTWRNVVdFc05ianAv?=
 =?utf-8?B?T2ZtdVpJYVlpSS9QQUZDeDhwUVZQZzE2cnd1QzBRZ25odkd6VDJGUjVTdzlE?=
 =?utf-8?B?Z3NQMEZiQm4zSzhueitUbGNsVER5NW1SMEhoOXBGZlFUTVBlQ2JlT3ZJUzY2?=
 =?utf-8?B?Nkc4QXVtUW1PTGw2TGZnK1JRNmNqSldnOGpheWVLTjNyYW1zR2FJWnl2U1Mr?=
 =?utf-8?B?d1A5U0lMdEI3d0ZmQXplRjMvMlhMSlE4cm9wZVRvWnNINVJORVdEQWJvendO?=
 =?utf-8?B?RDQ0ZGdwemxCTkpQb3JFTm5sRnFrSVcxNUdQWSsrMStJL2FkQ1g1ZkgzNHFE?=
 =?utf-8?B?cEdpcndFVGJrbW1JaTVDL3I1QnZoSXdKSXNJQWFtdkVRaThGS1J1eC81bVpB?=
 =?utf-8?B?VFQzSDcrakpvaFNrZDd4ZTRDdlowWTd5cTBzSG1pZ0UwSEdwSGJNQi9mWUIx?=
 =?utf-8?B?cTJlTDNGTXVCckxFZ29Yd1dHVW1SNDNwSWk4bHE1dGlDVy92dnFya2Zxem5R?=
 =?utf-8?B?S1VMUjY5dnJrdlJaU2J3YXpFV0Y2ZVlpZnlzU0twOWxJT0JBMmZqK3gxSWtn?=
 =?utf-8?B?UmxVU1hkWWZldGxkRm9nTVVhdytRTkRjd01WR1ZOMFg3WGFPTWFIOWhwREVq?=
 =?utf-8?B?VHhWcFBUL3pWbVBmQnhDZE0wdUZoYlprSTVZOHArcTMzY1BlL0FVNkVCL2ZY?=
 =?utf-8?B?TzBVTXAxaXBhcGVKVkNDcmpDd1AvRDdBU050YmwrRkR5YnpaZ1YzUjJnSDli?=
 =?utf-8?B?RkRhL3hyV2l2QmdsUmFYaHNGM2NSVGc4RWlBRWdKWXN4a1ljOXBCcUFkZUNt?=
 =?utf-8?B?M0h4VkFhTGtPQU50bThremhFRHNacmJnc1dUenJqa3NKTTgwVkF1T1RlTzgy?=
 =?utf-8?B?VWVKcUJvS2NWa08wWjVOYStEbkdsT05Ld0lQQmNSS2swZjR3RnRsWlk5dTZI?=
 =?utf-8?Q?tCzQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d75580b-7524-46ee-2069-08dc21f5fab9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:45:53.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmhoG9htcSMtZJQF7ASDJ0ZwLmKh6RnZIVlBRGSiHvkvca2RZae4MnhnB5TF7IQH35a9DkCm6PS7rxA1YGY+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

Involve an new and common mathod to send pme_turn_off() message. Previously
pme_turn_off() implement by platform related special register to trigge    
it.                                                                        
                                                                           
But Yoshihiro give good idea by using iATU to send out message. Previously 
Yoshihiro provide patches to raise INTx message by dummy write to outbound 
iATU.                                                                      
                                                                           
Use similar mathod to send out pme_turn_off message.                       
                                                                           
Previous two patches is picked from Yoshihiro' big patch serialise.        
 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
 PCI: Add INTx Mechanism Messages macros                                   
                                                                           
PCI: Add PME_TURN_OFF message macro                                        
dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
to map PCI msg.                                                            
                                                                           
PCI: dwc: Add common pme_turn_off message method                           
Using common pme_turn_off() message if platform have not define their.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      PCI: Add PME_TURN_OFF message macro
      dt-bindings: PCI: dwc: Add 'msg" register region
      PCI: dwc: Add common send pme_turn_off message method

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
      PCI: dwc: Add outbound MSG TLPs support

 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  21 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 103 +++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c       |  62 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h       |  22 ++++-
 drivers/pci/pci.h                                  |  20 ++++
 6 files changed, 168 insertions(+), 64 deletions(-)
---
base-commit: e08fc59eee9991afa467d406d684d46d543299a9
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


