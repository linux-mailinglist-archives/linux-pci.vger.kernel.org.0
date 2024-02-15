Return-Path: <linux-pci+bounces-3494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7D8563C5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 13:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F221F21063
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EA12F38B;
	Thu, 15 Feb 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DdU1ANxb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D518EA2;
	Thu, 15 Feb 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001769; cv=fail; b=EJiwCoKHGdSVMH7+5oasiu+bvpkk2E0wBjcrElf9EvwrFaowTnQCJXaPnO1fb03P+Bg/lZXtc7ydCa1znYpKvr8Px+lBkBK3G9d7/80SXgCTOodBOClF/3x86b/bITE5GaL/nLaon9vv+0oD3Yvj2a4azGjLsBBDM0jtE5JLrrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001769; c=relaxed/simple;
	bh=Na+mcWcArG1MnTzo0+JkGbCiZju81Sc9k/ihuTBt5Ig=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=OB25F/2YwB/Ou5Y6Bm++1NSrPG/HDWCe7IrjSNnFF1ZxgDD5OFKC/vhSVhhIOjNGW8yM16hZcFiVAiBnq9GSb3jyxK707oCyrU/XcM+woQbVGAsW63ylteJD4N2zDG3egBT9QA98QUbFL4AAGpwHarIN1JB1MGeC22gqMvq4SQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DdU1ANxb; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z19w7Nb0QtA6kKNyqT83JjNI+SMRgCeAZJR/ahXMa/5UaV6Ntzz5yxzJBMXeHBnoWAFpLGes7Ypet+9s9882c7YPAMBXqs2VxCJ9FxV/K/CWNMRffnCTM+6zbmR8v5rtVSYEJ9MX5DY/FYopnkQiyFqtcjVv0c3bexeMG3sklpq1N1zYA5YU1jR9eQzzFpgfRSuu53Z30FIkTCvFUxNtxcNjSjHl83/CtY2sfwjrV1Nbi6eqhIiv1hSNze/DIdpoNG+Wr+MilE+5ABN82pFdRlq99VbLSb2r3swD+WgW2fBusFOYFR+DxfciY5QZyKHnFSckR+fOeVjN6YxeY1oGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijgKnd1PdObJ7LXbfuL6Ht4LqVhZ8MVqcCNiHi7HNQ0=;
 b=nsZlmPDkCfdPGXUlFOf1IBUIn7eFCQgmepTc2UwlpTSzXM3Wtpg8y1nfaZbE+hZNBVce1NORO9dGQOHlXQabTmuWhZ5vtwisaa/yCRzz18PTrQrmQJ5F1LN4fw+/tmClqooOQvR51cCfzlpmK17KN6omevS222CXgzbpxJzQPzOsHssrn9oGHgRixlGsl3EjtN+Rc9jSdvSDiAOaS0+w5OBpBMUNoVbmSVovcPet+b970MIr6Rs8lh3LXsB+QnkG33nBS+/rdPk7Mi+wx+vcdr16Z3fH45G6p8hvWidT/T4ivbBx+zEAmcWLARbY/aeb4RcaB4N72OIvTOXYMFTpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijgKnd1PdObJ7LXbfuL6Ht4LqVhZ8MVqcCNiHi7HNQ0=;
 b=DdU1ANxbLv8lEOvWRhUn8PKjrfA10TUc95D672pSydgF3AsRcMXnJVFRr08pIGfr7MCfLvNeiExWHMpsg6RMoWZ4KsbxN0CFKR0sm6cycrgO/TFxOCBY5uzzlq9dOjmimNfgGGMmRiiBv/HbqG0vd1bE1K00duf3kdMw+mZe9bMNW0q8GQlP6vU67W9GKLOsba5bL070KdUnQCwH0mG2+RZ5cqKxl3KFQWbvT1M7mvDYlzCI0nT2lgQbBrp6Fu+PRlqFPqS2f9rXytFQnQE8EIY6Tc812ZaQW91uq/2eOl1ZwFnsXHHQuP3g7iwSquqx7WOlPNRcA6BG60r4FaYByg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 12:56:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 12:56:03 +0000
Message-ID: <8032b018-c870-403a-9dd9-63440de1da07@siemens.com>
Date: Thu, 15 Feb 2024 13:55:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] dt-bindings: PCI: ti,am65: Fix remaining binding warnings
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
X-ClientProxiedBy: CH2PR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:610:56::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c911696-2e5e-4da0-80eb-08dc2e25777c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fGEsO6mblAMkdJIXvQsIRuaHkRp9U81B4QRukJqX+yjZRw6x9JNSY2m97l0l+pD8IAdloqDp35J3JT50ovRhYw1Giv0TK4vD3eKQG4nnCtGR0M0F1P5Fyu5lh6wOaw1K7EkfEDZPp+hb1tmTh6qgoYJyo4pf3ITsLir7EDwnwK8TQyBsFvShwZ545iG4YUp24Zk+VsuDF9uz0BbR09hw3pAZKsajLL2+UJqjnh+XH0FeWLZ0K/tTTVs8zOVAKmG8Ivn/kM8UuQqPbgzPNdcwfLg2eSDsyxvkMWo6igcT1vPh8yvEpTwtduQE3rJ8kEAlFg6dioTUKfJfsLuHi2QTUB32pZUxJNefdLi26kRo/6tJ32ffoOIkH1NBytiwGxCGvd8kw8Oun6fgGtjr5Kv5zCYfGlaDMe2ZRQIBCJ0kVwUQzymRLpk5siw1DKSLCNXILQXtcQ7L5bGQcKvtRDHs7TGg7LC97jrOdDJ5BNuDy4+zvaQ8hnJ9OZTOTBhJv4F8CQwK8xhubq/Rv1zDVdXAFMQN1g1R1bcWHcaJb1ASijNBREj2/5EkBrOEry0bbRXG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8936002)(8676002)(2906002)(44832011)(5660300002)(4326008)(7416002)(83380400001)(2616005)(107886003)(38100700002)(26005)(36756003)(86362001)(82960400001)(66556008)(54906003)(6506007)(316002)(66946007)(31696002)(66476007)(110136005)(6512007)(6486002)(478600001)(31686004)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBXeU9oTVFZSkZDblJQcEJKRit0K2dLRkI5MS9CRXBYUEhqNXNYekkxQVdC?=
 =?utf-8?B?UFhNTzNjVzQ3WEtDeWVyUjBxMGJmcDFETTYrc09TdmN1NmFNMXNBd3pFdW44?=
 =?utf-8?B?YjYxK2tDbEU5NEZoNVpuV29hZGRteWh3bmc1MEJRV1hrK21ZU3lzcjk2S0hD?=
 =?utf-8?B?blZibW9QUmxnUjdiUHh4TWptdkdGck5VOTdpVithdjdJeFN4MGJnL1JpN2lj?=
 =?utf-8?B?UjZZOXhiVFZRblUwRmFnWUtQdVBEVVE3MHlQL0kzMmNJVWQyMS9yQjBya2Zm?=
 =?utf-8?B?UVpCMjI0M3BOQlR5NHg3cWxyaFFxYzlsWm5kL20xd3d2bUxlN0RsdmhMVzZw?=
 =?utf-8?B?Wi9SQ2JldzRDVXp5VEZJUlpWOXV6eXQ4NFJjMnJndDQ0NmYwUk93b3NpVDVE?=
 =?utf-8?B?UWtWUkJid3JuK09RTWVjd3R4dUlYcCs5U3JzQ0JpNXdOcHhoSzZjc2xZR0FP?=
 =?utf-8?B?QW5WbEtvcDhDanM5blBUeXdOOW5HbmdCeGQzZHJqamJVbTRiU2FEMkJCL0oz?=
 =?utf-8?B?M2YzVzF3V2s1bUkrT0VYVDZaTWZ2WTlzUStMUDc1WXNxaUVwYmZFaHpqNXJZ?=
 =?utf-8?B?NTlmUVpGc2pqQWg4d1Q3b0tJdkNOTWxIRXBheHYvem9GYjhIRkJKc29kdkNW?=
 =?utf-8?B?d3c4SWVVNEdleVc0anVPUVorK3g2WnZ5YkRmeG56UXdLTTFNSnhqanhydUth?=
 =?utf-8?B?SGdHY0VUVWgybmJpbzJQVFJ3VnpiZmRISDd0WUJoRVZNR1lWdEcvcXUzQzNF?=
 =?utf-8?B?bmNHUXBVQklYdEV4UldmWjV4VjBPWUw3V2FDRVd3ZnV5WGw5UnFhTGh3S2FP?=
 =?utf-8?B?b3lwYVdrYTQ4VGF3Ymg0bHZKY0VzVFFySnArcUZ4ZTBPTDA3eU85TVY0KzNp?=
 =?utf-8?B?V20yZjV0Tml2V0ZLU2s5cVNZbll3c1RsWk9aREpwd0IyNG1VZ3VlNTkwS2FV?=
 =?utf-8?B?My9jVzVKRTJmaFFBcUtUQUNMaWc4cGNUVFYxOTMydjBkWWpUZWc3VXBnZ3A3?=
 =?utf-8?B?bWhXcWxEckN2eEVwYjMwS0xGbjlzMk1EajBFUk1wVzdYbVRQeTVVK1kwNGZo?=
 =?utf-8?B?V2pHOCthZ0cxUFY1eXJ0VnpuVGVPZXJRWnR1MWZONzVrZ3Rpczczc08zL3B4?=
 =?utf-8?B?U3RYbUEwczhodVNzRUgydTZveGhZN2RZWmI0TkVuQjVJckNTcWg3QW56RkhF?=
 =?utf-8?B?RDNrUnpiMVlMYzVaNUM2RnZMVjRua3VCSlZzS2QwVDkxcVpURGtycHlyeVFa?=
 =?utf-8?B?QzA1YmRBRzBDc2JqTHU5eWRIZnVlKzBhZEM5bDJFOFZIYVhYVldSY3lJQzRo?=
 =?utf-8?B?WUNYNFpNcGNMaGVJRUNMVnVqdmdpMG9oT2ZiUCtxREdPUWhFckNsNEV4YmhN?=
 =?utf-8?B?NW9VWXI2YkxMcndFSWpON0tyQUsxZVJxa2xlMXY1MVdZUlRjaUJkeTdUb1Fz?=
 =?utf-8?B?M2xCdmM0ODM0NGFzNnR2clgvbytxbUhRbHFDTk5TRjNRZ0h0cnl0b0p6RmRp?=
 =?utf-8?B?MGZyRStUUnNuQlhoOFBxVnJ0Q20wWlZmWlhJeU8zTzhMRStmVFZ5eWhraVAw?=
 =?utf-8?B?MlZhNFhNL1llRERsN2x0Qy8zaUVUY09JV3dMR2hNNENEbEZJYUE5NEpyV2hO?=
 =?utf-8?B?NEsrRUVoUmxnMmdsak5tRERPZkd1S1F4NCtqSlQ2OVM4amdXcDQydXJTUmYw?=
 =?utf-8?B?Uk1vTmZnMCtnQVZlZWFJWmNiV3UyT1h1R21WcVhBZTlEdXhpUWhzMjNXRjdX?=
 =?utf-8?B?SE9FZUtSMUtaQUZvSzlCbG5UVnJ6M2JsbG5TSTUxbXNnQWZlV0JSN0xqV0Nt?=
 =?utf-8?B?cU9UZ2lNMzVMc2J1ZGNOOG5uMzd5LzNYTDFGeGJRKzhpZHRYVDdmejRXQk9P?=
 =?utf-8?B?dzVkR3dFeTcxejFERmpDTUhsQnkyQ1RwZTVIMHNFODZNaXFoL2NibEZDbU5W?=
 =?utf-8?B?K1h5Vk1ReUFOUGNZNG5MVkxqVHR4ejVyUkNjNXoyZFJrOTUxK3h6VEs3SGVW?=
 =?utf-8?B?WDRobmhaVXNsLzZiYURjRjk4Z0ZMTExzem5UeW9aQkVVZXJDWk1YbWpSNVRO?=
 =?utf-8?B?eHQ5WU02WHhiMUhxV3gvTTRXSWJkcEpSK1FTd3gxL1VhUWFFbzVhbEU1S3Ix?=
 =?utf-8?B?cXM3aXNzL0FVQ2pUZUpJMXFDVUsyVzZMRUw4ZWMwUWtnSC8vbDhUKytVVVdy?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c911696-2e5e-4da0-80eb-08dc2e25777c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:56:03.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70lgspQXDcdFzUUd/WUJZ+oMyBgol5jAx7P5igSTBytNoRWV3o8XsdRecHfzcyJ4ozI80Kz+zpP8VskescwmfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6956

From: Jan Kiszka <jan.kiszka@siemens.com>

This adds the missing num-viewport, phys and phy-name properties to the
schema. Based on driver code, num-viewport is required for the root
complex, phys are optional. Their number corresponds to the number of
lanes. The AM65x supports up to 2 lanes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---
Changes in v2:
 - limit phy-names to pcie-phy[0-1]
 - fix schema-checking of example
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index a20dccbafd94..c54d4e57d089 100644
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
+      pattern: '^pcie-phy[0-1]$'
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
 
@@ -81,6 +96,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     pcie0_rc: pcie@5500000 {
@@ -98,9 +114,13 @@ examples:
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

