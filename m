Return-Path: <linux-pci+bounces-3477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CA855C12
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1002834BC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853211713;
	Thu, 15 Feb 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NyUs0L0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10637BA37;
	Thu, 15 Feb 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984900; cv=fail; b=MaRoZ5JILokHD9HGHI92U4LVUcGakXCxwIawaZvEjUwRZ74ZWEhDiz5EqYAaaESpVvge30kZxPw5uwpuVH2MPIPDiIMzS7ZjeZ3ZFbwDHX+x+sT1ZOSCgItSsNguqIRt5fvIscpnZdW/FpxwCmsqT47LuzId2xZkUom8xsDIj1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984900; c=relaxed/simple;
	bh=huL5drPbesMQVJucbPWT/F6ITW/YxKpvn6mAHASkw08=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=hu4Gq9kYqDIGXrw4X2s5Ma9kdxSVlIllxF7XPsHb5cUqfRHhsd5diqYJvxAw4mvH6Hsxj42YpWcvaE+iKC+xfC2eC3nWTYyIXnKuz/mMrzjOSrud5Xl0kLWHCjl3lozK8W5FT3DIe/MvsTQfp3o/pC/M88lvwvL73aXvsbH2SKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NyUs0L0e; arc=fail smtp.client-ip=40.107.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC/84vVQhoeufMXGk0KmSFuq9VTBYcKWCnFNoOcmCfynvM5Gw2n2/XN0r8lcTw/jHccL0eRfhNGQNlTCJFUnI4sFamZ2WsUmZZnKDRKzqt//rcZ28hqzj96dKKS0QfaERrA4UKgqRJgqWjwvdK+hdwPcsVYa9MROp4+rN4uCO9rFp2zjfHHOzNMFtxEtkizfXgG4bz6/S6yEkQQg3zSSOpxN3mg2rmi3yxy+kuknS0dBN5MqmXzSzTJ+30CJDIyHY0GSwIw3lSP5PfE2yf4Y8fQ2yck2Q3vpiquW+mNDQEGWHUcUUADmlvJhizP+SpYXqMIou9QiOl7lQZdTq0Y3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9olswqHog7yCh50kxU1XeRhx6fHq8ViiC33RyQUWQeM=;
 b=RSKhbEfpzyCWzGfeqLEcl4G77v1BAF2lhtobQ2Wtyh0A2WSw/c76jckpvQKt/iBvbewv8BuHM220SQUa4/LgOaWVdljJhTfb/KPx53cYXc0BlbAeq9pHsBaRlJJg427Pvlv0wwUrQG0DMk1oVaRHhydShvUqCKJ5czCf8mmXN291wPpeutERlxhXzgi7neSysg4n2ll23sNE4Bgl9OHZNmSPVpx0nTioP/C8Y9L3owp2x+98/girV7Et9IRnC3q4VYn4rN/gWz4tCKluMwpiu2gWEn2z69nYEuaOxvyQyUaiXxMKQU7kJ5jJOE7DJZ7GCOlj67eUzucBokXEWFzpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9olswqHog7yCh50kxU1XeRhx6fHq8ViiC33RyQUWQeM=;
 b=NyUs0L0ezu8yr5v83uiM+WYzSq65e4nWVEMaUO0VgjDnDw2s7Z3tEGWMLLVs5/oiC+Wh3XAx3LD5CRPaiRovR9qGs7iw1BDOeuUOjAqxBZuKMI2OH/3OQ71Hw7aqImAI5kYIPP922E+A7Anw+XSdY/RFgfF8/Mx2WtSDhhky7QLsjRUJgigkeXEsUnHlzktoYq7AGg/xjUtKoMScNgZQlBtlKjmOl54daCsUKQA2siVHRC2nlzyIU6pYlrX5DFFCA27FH8+uitzvMlVu/3P1FEVpw64c1JTb59QCZ8LSDRSmk62Q6pZ3kDO2Ti7E7g/x8d4EGhLE6CLpvRUgo7DrLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 08:14:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 08:14:51 +0000
Message-ID: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>
Date: Thu, 15 Feb 2024 09:14:47 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dt-bindings: PCI: ti,am65: Fix remaining binding warnings
Content-Language: en-US
To: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, Nishanth Menon <nm@ti.com>, "Andrew F. Davis"
 <afd@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 85193e05-41f2-4419-f752-08dc2dfe2efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Kjt01ysEFDmXTHGpixmFFlmAcz69EqGOnl+EqfeqC+Qj4cRW2XtNpjaNFubkwdoGnSUKYlKjH+8gSat24Veqts1VtCbQeVjcDzyyqSfaKcYBtpGAY9BvKaB+KdtEj7gruhqNytyJQ2hKUEA9K8AIc0qU9LG/ZAFSp+WKDUbVeb9/LtIQBoIpA0hcRuxYApXq/aPonw9sZbQApyXfVaSKoSbSEAiRTkNcsqjp3H1akfLqigWYewX+jHuzLrMT/25NsEzBHcYTDYZMRtPtreITM2555ISu2zOhZiqo930EsN6byuiHfhe+H8t3NP0ga7Ml/Jr9fvgvArubr8/6HT5VUcmVCwp3NMlaz222etx4eGmP1WoE3TWSK3x62D606JVmmsJ5Cfmbhk8pAOtlYHER4fDew3LK5iEAHksJPXZMJE6i2eIHt1KRcO0g3JfAD8AGyVUDbKK7ce6z8bKYtyJ64wWESdRUXU6/va0dyt4T+WLOfFYOiPIEVZ7Ktnl0CiOkIDsk9rFqhx9Cl36qpJ+hScymdGcrljbGxSmv1S9OhiEGw8DFHLaRr2GBpQzmjGP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8936002)(4326008)(8676002)(7416002)(66946007)(66476007)(66556008)(2906002)(5660300002)(26005)(82960400001)(36756003)(38100700002)(31696002)(86362001)(110136005)(6666004)(54906003)(316002)(107886003)(2616005)(41300700001)(6512007)(478600001)(6506007)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHFUYVRraUdvTVdIYndwVU1oQUJtVWlHRjFkKzNNalM2Q0ZWOU9LeU4wSGFp?=
 =?utf-8?B?MEVjSW1CRy9nNXAxS1RjSzNWaXcyWG9vSmtXalhBWGYzOTVJaUFsaEMvcndp?=
 =?utf-8?B?U0dBWlBUMzNjaEx3dE5mSWs0VHorbmF0em0zV2N5S3VwQ1U1YWNBWXRTYjdw?=
 =?utf-8?B?TXpJM25YVGRJQy9xeGpXVHA3Rytaem1HNHVGalI1Wm9JQ1NkVlRMeFJaR29H?=
 =?utf-8?B?UHo2SjhXY1pQVjROaTIxeXlrWG9jY1huN3NGa2xRYW9MRlRvdHkxVFVPSVpx?=
 =?utf-8?B?Y2g0MzNDUDR1YjZGTlovdG5sd3FtTjFoODcwNGJjN0lmeThVMWpLeUp5eUxC?=
 =?utf-8?B?R0EyUEE3OXVhT2Zvb1ZrVHZ0bFdodUlReElhQW9PZ041NTdtOVJUMEY0RFZM?=
 =?utf-8?B?QW9pcUlrZmMxaGpzbTZDVTQ1dWhTTi9tT0M0Ry8zdEk1WWNvQlZod01sUVA0?=
 =?utf-8?B?bWR0emZYV1lxTU1TVVB1ZUtxQ0paRk9WUnNpNWpMRWE1T2FOd3FyN3RFdktv?=
 =?utf-8?B?eWMybjRPaW0yVjJQc0Y3enN5ZmVvVmtYSHF4enQ1ZE1oRkJZN3p2NGsvSVlS?=
 =?utf-8?B?azd0Zmthak11bnBXMWxnSG44dXl3RzZxb3R2YzJkdk8wNHlvS3ZLYmw2LytG?=
 =?utf-8?B?TnIxdEZmTUJhNE9xdDVEN1N6eDdCQWdhTDVDVFZ4Q1VWaXZiMU0vMmhtOUM1?=
 =?utf-8?B?dGIyR0o0eFdVYUZmbndVcE54Rzl1V1lBZ1Nld3VZM0JHQkQzTGhReFdzZHRi?=
 =?utf-8?B?MVRpeUZGZGplZTlUd1VnUFRwYjQ0aGtPMFArb05sWE4vNTlTSTd2QWRZZENG?=
 =?utf-8?B?U3RQWGVxb1ZtTnI2RlJodXdkdkR3b0p4SlZnMFlZOW44eC85aW13QmxhbVgw?=
 =?utf-8?B?SCthQTNZa0RPS2o1WEFkaU5JTUVUemtrQUx3NXlJMXhpMU5MR0VuMzB1ZVc4?=
 =?utf-8?B?dE1HWWdWa1g5RXRUTU1PbUZwaEhtVDJVbGJkNXpDTXRFYjE0TmVoaGt1R2ti?=
 =?utf-8?B?SnJieVRXVENZY1lvQVhYaXdGUWJPeU80Yy91U0c2NzdwUkgrSzJHcUNPRXVP?=
 =?utf-8?B?MEZzbXIzTjFvaFpwTzZ3MC8yNmoyU1VTa2QxaWZoK2tOakt0V1FmL1RHcVJC?=
 =?utf-8?B?eU5MSVdMSEEzVmZYMWVjM29JWDIrRDBIRWZvNVE1dXRpVm12bjdONWMvdnpv?=
 =?utf-8?B?ek1BZkdWOVlGOGQ0UFpYdnFUSXBOaU13TmNmNm50UWFPT0lrZ1lJdnB1TzBH?=
 =?utf-8?B?TnhiZUtjbTFUcG9IaHU0NXVBajV5N200UG1vaThIdjZxcVpoQlFWeUF5eGdx?=
 =?utf-8?B?NVNHbENLMjUvY21kNEtDblA5amU5cnNKZGdRYWFrd2RwVXdPcGRjRjZvRGF1?=
 =?utf-8?B?bDdyb0RkWS9WQlJ6dWhkbkIwdnorN1Z4Q2lYMmtWZmlOMzc1N3c5TDcwVGlo?=
 =?utf-8?B?SDN2RlRqSHZGRUZQVHdMVU05bDdvZ3doZ0tKbnJiWnhPNUIwcWI5cmYyZFMx?=
 =?utf-8?B?dEpyY3pEWE05R3RjNXZXZFAvRTNwMTFBZE54RmJnd0RMdDVlb3Q1T2RsTThV?=
 =?utf-8?B?YnhudlBOQTF2QjlQR25sd2xuZnpicWFVeTFjTUZMTjc5MVRuQnRLWVZnZzk3?=
 =?utf-8?B?anFRZUhBaXI1WjNXcVJkY2haZlFvendzOUJORjJJVUpIaWl4M1Q0N3hMbExz?=
 =?utf-8?B?Sk5zYkRhc0gxYXBxamFBZ1JjR1hOMGdxQWRXQ09UNTJibFdVcTlDVkIrL3ZR?=
 =?utf-8?B?NzNMTzVZa0pQdVROenQreGUyMG5HeWx2QXRkTVlSTzFsVDloVW9DVVdRSUhE?=
 =?utf-8?B?T3F6cDZyY3c3Tk5XU2tkKzhOMmR1eGduMU9teVFMM3NHemtqTXVQYktxS1oy?=
 =?utf-8?B?Z3F6UStMaWpxc0dHNTlVc2tZQWxjTlY5TFoydkJzVWNlZWtuVm5QU2FRMHAy?=
 =?utf-8?B?WWFqd2RiTmhtemlhTjh2bmE2RnpxQzJXTDVXVjREelJTclYvNnhwZXdlRFJL?=
 =?utf-8?B?ZUNqV21nY1gzRUJ3eGU4MlprSWhnMEN4WXFHV1pIT2VldHJWUGVOY1ppSzJP?=
 =?utf-8?B?VXVJR0NEVWlLSmxiaVVpMVkvOU5PZExqQ3N4NW1MMG93WEpvRXJqWCtZMklO?=
 =?utf-8?B?bmZpZldYT1BUZ3N5NkV5c0JPNDVHVE9vQTVWVS9LZGRNTVdjNkUzanZCRGFn?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85193e05-41f2-4419-f752-08dc2dfe2efe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 08:14:51.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la/oeF+Ud9bepwDxfdrLl/Bc/51BsuF8rqlaSe1qbbM+bYylHPn6NS2KRp6lkJbWMMqzjI0iHfTuFqiIaoaU7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7619

From: Jan Kiszka <jan.kiszka@siemens.com>

This adds the missing num-viewport, phys and phy-name properties to the
schema. Based on driver code, num-viewport is required for the root
complex, phys are optional. Their number corresponds to the number of
lanes. The AM65x supports up to 2 lanes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index a20dccbafd94..cdd6834f6a6f 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -55,6 +55,20 @@ properties:
 
   dma-coherent: true
 
+  num-viewport:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  phys:
+    description: per-lane PHYs
+    minItems: 1
+    maxItems: 2
+
+  phy-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      pattern: '^pcie-phy[0-9]+$'
+
 required:
   - compatible
   - reg
@@ -74,6 +88,7 @@ then:
     - dma-coherent
     - power-domains
     - msi-map
+    - num-viewport
 
 unevaluatedProperties: false
 
@@ -98,9 +113,13 @@ examples:
         ti,syscon-pcie-id = <&scm_conf 0x0210>;
         ti,syscon-pcie-mode = <&scm_conf 0x4060>;
         bus-range = <0x0 0xff>;
+        num-viewport = <16>;
         max-link-speed = <2>;
         dma-coherent;
         interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
         msi-map = <0x0 &gic_its 0x0 0x10000>;
         device_type = "pci";
+        num-lanes = <1>;
+        phys = <&serdes0 PHY_TYPE_PCIE 0>;
+        phy-names = "pcie-phy0";
     };
-- 
2.35.3

