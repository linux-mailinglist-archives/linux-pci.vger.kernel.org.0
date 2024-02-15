Return-Path: <linux-pci+bounces-3493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C5856305
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 13:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782941F24A95
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C112C804;
	Thu, 15 Feb 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bgODWlNQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DF12B147;
	Thu, 15 Feb 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999757; cv=fail; b=jIqzA9CIHVZ3/ZA08uOFyPxqA5qhxwN5YpAiv391J8V/Cq9sS7u4ZOkT6W2C5r2XCTI19c1PqJmdD/l94cgJlQF4EqzaeH3+ApOQ3v1YWCUGDWr0IgY5e8AdGhkZ4VAWYO6QTmA2NbMh01YfdB17BgyeVCRFIy9quMI9VjsUi1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999757; c=relaxed/simple;
	bh=lWjslCXTvmHGDootdVxvW32NTlwv+y8qTBmleeA0Qiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uSpqhWFq130dfRxmZl27bCBc+k/sbfI/QiyX1Aax4lEOHVPimhupIJVSy5mKvzfuy+BbG/Xf7fGJZrUg+VKGAscXaM0LhZt/+G0mAUMIweVnIeevJc+WTUZelRmRyNatHxhkNbP3+wDqW2S3YB5KOTXdhtypuAl+PQGl3/0Iu50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bgODWlNQ; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWsNodBTgow3O4/A2fbClNEC8tZDzyDbFe8hNhor1whY4etc2rmH2VC4aUpoYf+G2RzoUDXO22+iICMR7YUBQL6o7PmmkNUoUfp5UT8sA/RBp89nPWLNDerSyF/HxzmVfQo+tTvBu2KnIH1yaXbjpxa9OYopKArzT4cQ7IfFTFE3Vqtn+vmH4R77NkDij1iM30+Gt79ARyiWH8qqeZzunYzBpLSxAErsS4NjO5DYvBRMiavV8XZlGN9aU90TKTXm/hkRVg60p73zcNn46SahOal1PxSEk28KlcEzcBBlcms2GvLiEtPpRJsVEZA60qRo3Wo1sNmmIt2XN/Okgr6/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKKI3oNbB+zfiT3SVM5BT+bfceziGxXjfIMyOE++5aA=;
 b=TnopOXFojE/kYyg0Fd+YJ+AH/DID0WV5N6fXYbjDnlPEt3JeJfhws0uKZqL7cbmhpMdnyKTw6E8at3Oz1KjDM+kP4kQnqg8H8iraPh8pA9eq1zqGMiX6mhwfmAnrphBjWS33fZOaF4MI8eXdfOCYQZ2gTF9Kt70FaG3QZsoI/ZHxR9hGL5z+eHRZXrkoYacQZN94p0XbrOxrciYdemN6WUvSYmfNq8Q4mDcUc5e61loZ8qw3LDnsWg1U8/DcEHhECoBJ0g7gz+kF08GIve5WB8nUILqk/9NXCKk9HdDtZUZX2MDQ9/FYAOK5a8w2yz0vmppydCeTAYrUWdBzK2iNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKKI3oNbB+zfiT3SVM5BT+bfceziGxXjfIMyOE++5aA=;
 b=bgODWlNQXhAClV+qLAmd6ZhPl1QCvncD6bWZZ48ezk76lsgT63e7H7RJ5SmfseN0nESTWfXX2gMe/1ov7hZMcG3ogwCIhzKhpdrAk8g+wBDupql5SAXuOiqtO6CZUuMNKnEGhzHKGbIWhm8GnhAvTP3T/tP66c9PtM+2EG1KFXY1vTWzyG4t/wEn1kHLAGVPjE0kFGm+4w0+yaMusUK/5G6Bm7/kKwLVpXzGmlNU6VK+nWbHv0Bxd6Ffs0RJWCmNV3tPlE7x003SZpAtFKi1nOZqCpnRqAzgH1gAnIDay/Fs3o4Gv5259/28umVnO2LU448I2YrbFzBW8xTk3glcoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 12:22:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 12:22:31 +0000
Message-ID: <22539630-2bc6-4eed-a494-b97bbc114062@siemens.com>
Date: Thu, 15 Feb 2024 13:22:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Fix remaining binding warnings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nishanth Menon <nm@ti.com>,
 "Andrew F. Davis" <afd@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
References: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>
 <20240215121031.GA3671826-robh@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240215121031.GA3671826-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b676667-cd05-475f-83b8-08dc2e20c81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dbqsp0DHL4r9ncU/1hnZleMCstVpsw7WSXGa/s6QJ1VbNGc6Uj+EsIZDOFm/0EYThHrKK32fB497v3RKjvQBPXAfl2bRRRnfrA4Cigf32+U0FUMOC0Zwi2LbcrE1Ri590lHnKpsS7+YwEAJUO6t7QxzM6ic8FBsYWlOn8+t9r1smcPR2ji3NIJy7yUiHI8GFKyt6Pg6LTWbVzuJgbMvQZCJFoKb6oOqNzdyGTk1w6rShk2Z27DukF51YLhrhelVCNwXQHPwP/A4dwXrbgVXXRVfxkjK3tukwNQ9wdeH70WekfafONZXkTKL92UmUZT909sbWyegFLhUxv6SvVeaKJVjLdLdB0KvdNNvaAzmK4RVHw/VaSY0nHDO2H9gethBc6+Pc7w9IyG/xriHnCJ7y5G2j5Ars0KytpKHRVgIOl/eaMVyHazqCrLooBFZrFHiRtW6NOFH3GySwimpFg5ouEUKBvSk/h9JfXXsIR6quZ/cAh3KWXo63ehrfBi29cREgzhKoLhdqVW7kBYTdx8PYauIAsTgwJO60sJAm/GLRvkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(86362001)(83380400001)(82960400001)(38100700002)(31696002)(36756003)(7416002)(2906002)(5660300002)(44832011)(66476007)(66556008)(54906003)(53546011)(6916009)(41300700001)(8936002)(4326008)(66946007)(8676002)(316002)(6666004)(6486002)(6506007)(6512007)(26005)(966005)(478600001)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmRBT3M3Y2ZCREdDWHlOQ3UyVGdudVBlWFNBdVZzbkk1WkJ2RW9aZ2p2Z2Nu?=
 =?utf-8?B?NE9CMG02T2pIR3NqZTd6aUpCa05JMTlybGhhMG5za2hYdFY2L2JhR3lQRi9S?=
 =?utf-8?B?QTN2NUpnK1IvSG5hM2F3dG1JU2pZZ3NCWmxKOTc4TTF5MTJPaUFMRGsyM013?=
 =?utf-8?B?Z3RzMXRqbElEMlBCWVgrR3F5aTRuSHN3VFp6eGJTZ3lTcmU4Zm5kWWRTT0du?=
 =?utf-8?B?dTJMVTVGRnVmUFdXYVlqM1hsWEgzalI2ZmtHekpjYlFhWmpFZXRlaEcrMGxp?=
 =?utf-8?B?S3c2MlVzb0N1eWF2YWEwSllVRVRxNExObVBTSGpqbEM0eFNBSk5GUmowWVMw?=
 =?utf-8?B?c2FKY2JiOElVTzB0QklncXVuMlpkRW1Ta0J4WXoxbHVKVzNpdUdtem82bWtu?=
 =?utf-8?B?bGo2WGcvRlBocTdsMkkrTjgyUDY0SzdYa3B3MG9aMjN5WlBzQnM0Q3FkZnl4?=
 =?utf-8?B?bms2ektIWkN3bGM2Wlg2R0I4NnpYbDYyQ2xYRFR2YUVxeitnb0l5RWltYWNj?=
 =?utf-8?B?aTkvM3IzWWgwVFNPbTZtODFMTUd5cmhNU0VMOVhEMFIzL09Pbk5Ja0E1UEpN?=
 =?utf-8?B?aGpEN2NUb0dXWStaMEFEQmtYTVd5Mms5clhlRGlDNDUrV3pEKzBXQjdnV05u?=
 =?utf-8?B?d255aFdXZnRKRG1kVWIzYjNuZnB3OU04ZkxsTSs4VktzNGdyWXJBMGFyUFhM?=
 =?utf-8?B?R056Smk3SlVTV0xYNDdKVGxpY2diQ3BpTWxQVlRXQzY2ZnNCenkzMUI4TzhF?=
 =?utf-8?B?ZWVnditId0JRRVpqYVVLMEQwb2k3cmFwVzNSclBZZlZ0Qnlva29VckZyd3A2?=
 =?utf-8?B?bldGYUpNa0FSc2Z0NVJ2RTVVRlVUVjdhVlZjT1ZRalZjMUZIQVRlTHpRSFhS?=
 =?utf-8?B?akZYK0VtVHpsU1Y4S2ZQQmNUbWduak1SUnFkSTJVNmFKQ0JLZXVsN09KUENt?=
 =?utf-8?B?Z1ZTRVUrdyt2aVg2R0FOUC8zVlFhc2VwTmYxdWFPak9ib1ZBNlBLMjFKbFVF?=
 =?utf-8?B?Ni9lVmZ0KzA5MEJ1ZVFueis1NUllMEZ4Q3pGUHAvNW96cU5COEpGK3d1Nlpu?=
 =?utf-8?B?VGNRNTBPalVKQ3hRZWw1dFplY01hOElXd0V1dU4wNnFiSkNKR1Y1bU45aTVy?=
 =?utf-8?B?TzhHY2dXcGwrUHluVVRLaEdjYzY3dzNpRU1lZDlvdXdpcEVFV29yWkNFWVJa?=
 =?utf-8?B?NVB5K05zRTQzUE5OM1p4R250ekdvZkpQa1E4STlXWWVoN2xHbGhPdVF2TVE3?=
 =?utf-8?B?SlZlR0VrZitZRk1uVzI3ZGx0VTBCTEZ5U2k5Q1FOdW9HYTY3SVpHOThDNWpo?=
 =?utf-8?B?bDV4b1QvaEJ6S1RpcVgwdnhxNitubGdGU0JWcFNqbkc1OXo0dVNEcDExRCsr?=
 =?utf-8?B?ZUVRNElUVUZpYnZJSHFrU2F2V3lQTENtbWNSWlpobU9VZXI4VUtlSWtvNVd4?=
 =?utf-8?B?bVVjcVhHckdWbG9XNTN1VFFZR244UG1lWkltdGZVcFNXckdXaUliK04wVWN4?=
 =?utf-8?B?bE1zOS8vSHBaT0tLQXJ6NDNORlBiZ3dFRXZRWnBBSHgyZXU2czFoRUIzKzNS?=
 =?utf-8?B?eXFVKzc3MmJXTHMyQ3MwbzNrNHN2OUZ5aXBGK01uVE1FTUU1UUI3aWkyTnM5?=
 =?utf-8?B?V0JZZDF4d3g3cVBDRXhTeGNUWTI5VmFYU0lJUllENG9zbUgvUVgvb3Y1NVdy?=
 =?utf-8?B?NnRuQzhTVEo4ZDV6QnRSYWF5aVBQUS9sZGJDNVpWeEtYTWQxTk1jeHdDY3Ju?=
 =?utf-8?B?bVFQcWliT3Y1YmtVLzZJcG5yNHhOTVBvZ2FlaE9xRTk0ZS85K2trcytodUR2?=
 =?utf-8?B?czMvWG1KU2F2NkJ2MVhrWllIWTBxd0pLcWRVUUxKZHNtRHo5YThEZUN2aU0w?=
 =?utf-8?B?ZVNuV2dyOFI5ZEV1MktTbGRkMjBTR0hhSThGVW52YWtSUDBERlBpSmdGYjdp?=
 =?utf-8?B?SWc0d1ROQnNUZURIa0c5UHNjWWcvQWk2M0hGNGMxVVBxSmNwam05ZmQ5aysx?=
 =?utf-8?B?RVFZMGNSUGFWSGE1b3NRS2p1VnNXbUNRNWNKME91RmRuZ0UzMk5qVXdsckJQ?=
 =?utf-8?B?ZlR2YjVQeWJwSHBLRC9aVjlIMkpCeHFQeVBVcHdQWnh3V1NOK3FXalVFeGxv?=
 =?utf-8?B?YTVEeUZRVTUyQmcwWFZZZnBwMWFlVitUSC92MzRUcml6NlRONjdKdVo0eTNs?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b676667-cd05-475f-83b8-08dc2e20c81f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:22:31.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XplW28o4aHY4TbpjVw6At+n7ZaYa9wUVphlA6vNI1pDZJj8jN45A5uc1XBSWkgXY266kpuuUHsRNdEVpxtHPTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6129

On 15.02.24 13:10, Rob Herring wrote:
> On Thu, Feb 15, 2024 at 09:14:47AM +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This adds the missing num-viewport, phys and phy-name properties to the
>> schema. Based on driver code, num-viewport is required for the root
>> complex, phys are optional. Their number corresponds to the number of
>> lanes. The AM65x supports up to 2 lanes.
> 
> This is DW controller, right? num-viewport shouldn't be required. The 
> number of iATU entries is determined at runtime now. If it stays, it 
> should be deprecated.
> 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=fcde397422ef621e52dac509e253d5e8a8f43b23

You likely better understand than I what the state of all that is, but
that is how it looks like today and how the DTS are written, have to be
written.

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index a20dccbafd94..cdd6834f6a6f 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -55,6 +55,20 @@ properties:
>>  
>>    dma-coherent: true
>>  
>> +  num-viewport:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  phys:
>> +    description: per-lane PHYs
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      pattern: '^pcie-phy[0-9]+$'
> 
> 0-1 only
> 

Good point, fixing up, just like the example build failure.

Thanks,
Jan

>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -74,6 +88,7 @@ then:
>>      - dma-coherent
>>      - power-domains
>>      - msi-map
>> +    - num-viewport
>>  
>>  unevaluatedProperties: false
>>  
>> @@ -98,9 +113,13 @@ examples:
>>          ti,syscon-pcie-id = <&scm_conf 0x0210>;
>>          ti,syscon-pcie-mode = <&scm_conf 0x4060>;
>>          bus-range = <0x0 0xff>;
>> +        num-viewport = <16>;
>>          max-link-speed = <2>;
>>          dma-coherent;
>>          interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
>>          msi-map = <0x0 &gic_its 0x0 0x10000>;
>>          device_type = "pci";
>> +        num-lanes = <1>;
>> +        phys = <&serdes0 PHY_TYPE_PCIE 0>;
>> +        phy-names = "pcie-phy0";
>>      };
>> -- 
>> 2.35.3

-- 
Siemens AG, Technology
Linux Expert Center


