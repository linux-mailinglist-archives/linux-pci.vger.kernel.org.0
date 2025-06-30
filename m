Return-Path: <linux-pci+bounces-31051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77AAED420
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A94B16E6EC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57E17C21C;
	Mon, 30 Jun 2025 05:56:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023104.outbound.protection.outlook.com [40.107.44.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C14A23;
	Mon, 30 Jun 2025 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262973; cv=fail; b=oePexjQ8vl5YUe+yCU+4O4T6qyma8O0m3Ibb9Qv4+rp9t0uQduizSkyfiL/cYIQxBrbGxKQpo/1OyEfKQRqq1mMPpnsy9YTB4WEarNdzsbINQ2UTr4PCPyVQNlvbsxINKplnuZLOtmrdSNY2sL1bTKGk7rrvC98qWzWTN84fS2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262973; c=relaxed/simple;
	bh=Z8nHYTPq8BoOvCRSK3wW8+990T3oN2eD1BKPi1Mxsmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojghEch1XV2y818AXlkh042jCFSqWxwJ1Ynyd7Nk2oQbOvF4b4NzoWYZcHPYQlbqIaU8gkAuFDH9/1xknk52IN+GsyamMAs5a4z1IVX/M/lVcjqR7RkLcSc+dCaFo3ll4S2nXZwt/d0k9PrV44do8h5b3O6fWK8KdxYuLRRa4Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXINKt/WFa9jeEkRgob9XzFq1TLIOBTpQwIMA0rBNjB6iSYehsAcEKRtjQHrXpINfZMbsMl/UgnABen+NYA5CB70x3lmg0ai3HJ/oziK9g3LI6BSemXgZutOam/a5vUJskOUz9P69GCoJoNLOH7hYV5qmXvLdYokAKUIf+xBSMHh4WA7OrTEtDc5x3fZ+eLfn5KeSoZvf8qwXa3Xkcu/1uB5N5QijMs1ohs4Tzw9PiyjcfsZsL4a85xlGPHhaq7I+Ksp3rDsEbhDF0pfqVEScTte2Vcod6uWmyASkAWLaXWQDfrA9hSmcw0PQEH/iR5RnoLwHx2qiMCMMlDY9D87Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsDBtlVmV266X8bdnaGfaTL+lt/JqDahPQSJQ2oUqRs=;
 b=cKB9KtW0SXZMWbWcBWTKLk02kRrk2tPzHyiJ9KcWDIvaRYiMCUhitK0GHL36XaXhBUFrV9BaHVrg9I5r0/hPtWRhyw2VPbBG7NoDunN3Iffha2je9Bc1NfI+vKTqUoFbxWFM4YiRtxcj338ZjLpkypxpQK2ie5xp31gskCxCnUbdLvg7hjQBqVwXdLaJzzHbG97LHMnDz3rIiv5+S7+uvleQj4uwQ8SjpBQd/hUD1hL1kp+NUt2rperIPUvN+gr0fiwW6QMZhXFBS76V1ES8725WtAZ59iguKJVO46xvxGXdVMijvm/QwBbETwxTp8rODo77fzjC4i87+R5gqWHYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::18) by
 SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.27; Mon, 30 Jun 2025 05:56:04 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::57) by SI2P153CA0009.outlook.office365.com
 (2603:1096:4:140::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Mon,
 30 Jun 2025 05:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 05:56:02 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 32D9D41604E0;
	Mon, 30 Jun 2025 13:56:01 +0800 (CST)
Message-ID: <27fc6e49-91b5-430a-94b2-eb299d7c3ecf@cixtech.com>
Date: Mon, 30 Jun 2025 13:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, kw@linux.com, mpillai@cadence.com,
 lpieralisi@kernel.org, krzk+dt@kernel.org, fugang.duan@cixtech.com,
 kwilczynski@kernel.org, linux-pci@vger.kernel.org, mani@kernel.org,
 guoyin.chen@cixtech.com, bhelgaas@google.com, devicetree@vger.kernel.org,
 conor+dt@kernel.org, cix-kernel-upstream@cixtech.com, peter.chen@cixtech.com
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <175126181720.1510160.1051786130000478053.robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <175126181720.1510160.1051786130000478053.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEZPR06MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: 42359f70-2407-464c-0b24-08ddb79acbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk9oWXhTamFSNHFZb2FBSEcvWS9UZGUyWVh0RUxiYTA2eXVNZysvd0xRU0Jk?=
 =?utf-8?B?QjE3ZHRQVVFaR3RVbEZBd2REQmVKci81Zk45cDdlZ0dvVUJBQktiTHBJcUJs?=
 =?utf-8?B?Yk5vQ251Zk9ZektZY2hhZEJITU9USE9tOVdwaFVibU5oL25EZDhhOWJnOU5n?=
 =?utf-8?B?MTFGMlpDdW9zUXZRci9GREtrdXMxRVdpYkNER1NHY3hscW9HcnlkNDV4RGNm?=
 =?utf-8?B?blFLSm42VnNZNFRtUFN4ajlDMTRiaGNUNUJhWFZVWmM1Z0haYVZkU0Q1dVQ5?=
 =?utf-8?B?VCtYZUVpaDY1V0lFNXhhYW5RWVdIeFZ3NGVTUWlrZFpPTXplWE1PbXFBenJQ?=
 =?utf-8?B?REdWZTI2aWEvR3lqYklkamZmbGMvUm5pQ2prZlYyWWJ3TFh3N0NKUi9ncTNn?=
 =?utf-8?B?L3FaU3pUSXVvWkM1OFZPZG5tdHZKZjl4MzlFYmhBdGdrOS8rVUdXU1p6NGVB?=
 =?utf-8?B?TEtMK3owQlI0VmRxVXlSMDZQMEkzc3dLbHhlczRrTWtkWTNpUG90TUh4VHdO?=
 =?utf-8?B?eFZNYTRDUnpaU0hPUVRvSFcrWExPazFoWFhmdmJETURyOFRiZThTb0Rncjl0?=
 =?utf-8?B?ZmV0NWpKTnMvVW51NzAyVitXOG95b1hWZWEwL2E0UmdRSDQzZFZ5ckNjMm1C?=
 =?utf-8?B?dGc2bHNuMXhCeWdrc3hGU1UzdndYMXU0eC9aNytHSnlVMXdBZ2V4NEkzeE8w?=
 =?utf-8?B?bHFKajJXL1JSNGtvZFZxdUJNa0N1bFQxeDJaRUF1ZTFQeFEwcUdYdUVnb1RV?=
 =?utf-8?B?cGJoK2pwMnFPNTc0NHFvK2RxSmFaN0NpMmlPcFhuWWlkZ0RLUmFNT1JBbTNp?=
 =?utf-8?B?VUl2RHA1L2V3NlMxdVFuNGN3Wk82N0NsZDhKVjNudjRzSDgwOXZjS3g1NUNG?=
 =?utf-8?B?L0V4NHpnWk9YVEFxdnlUZVNzN0lPSjFtdEJOYWRyQ0JWRVdCblYxSjFJN3c4?=
 =?utf-8?B?TTVlNFRwVkNuOFBDN3Zkb2oxQjBoNWQ3QWs4UGt0M0I5TVh2emUzVGZtSEc5?=
 =?utf-8?B?bWIveDBKVDlYclBralp4d3VzMkNnM2hYbDlMc25PNVo3d25oWXVvV2plTm1z?=
 =?utf-8?B?S2ZqZ3dvNmpEQ0NDQXd0RVVXdDEzOC9Db3V6VTRUek5sM2YzdFFkeklrbW5T?=
 =?utf-8?B?dWRxM2xDVlM0cGVuL0JLMEhOUnJPVHExWmVsbG4wU0plNjJnM1BHY3M0VEF1?=
 =?utf-8?B?RGNyZ09HODlGN24wOVJVcHVKZTFKL1FSQ1doTGc5L2FuNmI5UkxKaXdtV1Jj?=
 =?utf-8?B?K0pyQ1lubkFzN3pncTNOVnd3SFp6enRxQ1JoTy9wdFMrbk1MQ0xiWWY5bVpC?=
 =?utf-8?B?N2N1ZHo3bkdQRWM0dXFhWkNyMmd0YTEyVGpWeVQ5MDhFYllTcld5T3Y3ZnEx?=
 =?utf-8?B?YW5Ba3U0UlZER0ZBNm5TbVdJajJpRyt4ay9mQXE5dVhWazIwK0NEZFdwUTIv?=
 =?utf-8?B?citxdWgvUGZRckFiSTViaW9VaHdYVUpLU1VMMlVkUU5YcUQ2Z0doejNINE4z?=
 =?utf-8?B?VERXOG1HQ0Q2a295M0hyQTZwazlJaVIwaUdCeEwzNitVRnM4N05PZWZOUWhK?=
 =?utf-8?B?V3BtbklyMlR1QUU1OGs0SHFWVUNuVW11d3c0aFlSSEpGZ0pNK1FnNXBZanNB?=
 =?utf-8?B?bVAwYWJaekQwdnlWbU9KOTkrNkNvU09CdFFFeTNtMjBVTTBORmVab01LazhU?=
 =?utf-8?B?OUNHUFZrd1RWTHlibVdqV01MUXhBbmMvdW1YZEtMaEpVbWtsK3pmdkplSnBL?=
 =?utf-8?B?RzlSRVFJZm5qRHM3bXFDV1Ird3RIQWMzTjJkeHZwODd4TnBSQk4yUGk1MXkx?=
 =?utf-8?B?bmw5MEV3ZEluWU8yblFralhDK0FWQ2dVNlZxYTlnV0d0cEo1S2c0NEY4dG9y?=
 =?utf-8?B?dDZzZGdMRlRNWDVZQnBHT0N1L1M0VUl0QlhzVDdsSG9JK2NKbDU2TVg2RlN1?=
 =?utf-8?B?dWhuZ3dacm9ZYmp1RnJGMEZsTWJCNXNDVG5NYVRHUDRYNWxlaU1pNnJPRldO?=
 =?utf-8?B?NkYyVFVCY2dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 05:56:02.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42359f70-2407-464c-0b24-08ddb79acbd6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5576



On 2025/6/30 13:36, Rob Herring (Arm) wrote:
> [Some people who received this message don't often get email from robh@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Mon, 30 Jun 2025 12:15:57 +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Document the bindings for CIX Sky1 PCIe Controller configured in
>> root complex mode with five root port.
>>
>> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
>> ---
>>   .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml: properties:compatible:oneOf: [{'const': 'cix,sky1-pcie-host'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
>          hint: Use 'enum' rather than 'oneOf' + 'const' entries
>          from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> Error: Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts:29.47-48 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250630041601.399921-11-hans.zhang@cixtech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Dear Rob,

Thank you very much for your reply and reminder. The next version will fix.

The modification is as follows: make dt_binding_check. There are no errors.

s/sky1,pcie-ctrl-id/cix,pcie-ctrl-id/

Best regards,
Hans


