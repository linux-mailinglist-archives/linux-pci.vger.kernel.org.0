Return-Path: <linux-pci+bounces-21275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBCA31E52
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E51B7A3B72
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EE1FBCB4;
	Wed, 12 Feb 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DJAzyyRh"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05801FBC94;
	Wed, 12 Feb 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339669; cv=fail; b=H7Ikarv6WDEC5qjo3giEVxTDsEJXnmFgCzXko8EMWKl939HIlqqVaNvHKkPlX4KV4sld53FxH6VifKWYOGQ8u9qB3CjFrOang1Yny+3BHeh4VUSCB13U0Y/djEROXeQGLNTP7RyRN5PeLqWUdcx+o3BUO9AkJOiE4dknnTieVCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339669; c=relaxed/simple;
	bh=4d6ned34ycE07ze5TOmTobfU67sQpvnEqDrR/X5KtH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jEjeQOPk9QybeZanyilNlPBjC/di/WhqstD2EQtKnPzSkwZ4qSQ+zCwHtBtjY0HttfKdS7xl/OK/LeVqjw2F32oxyY44GXbI0MielhS0bpmXrV/J63apKl91h5Mzs7/2tHQ1nOYxYwN1sWRVTLLkjwdh8Q4vXF6Tns5IBR3TRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DJAzyyRh; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMT69ry56UMJ8bn6sI0W6HJ8s+Tig6DgHOCprFHLpFJ/knSjzpZjSLdCzgBHHBdWobuwQduaVImqRtUlo2zU0+lTnMrFI5nJ8xeI9Ynip6Rf1m0bLCQmtGUm7IYVgbDzan4ZrX56wPfA43Pst6ySyRm2oPSiu2sbeB+DQYzjSQ9OIS0kvFhoExI1mCLWf6DueZm8W3WgP50SP1z9NAc9N99gyJxHJOzgPWXDvhQBYiczG3nhaxasf1fGOmuEzdC1jRUnaEXoKL8UDYNhHoezg0EyQna0fvlj7sYH9rhg+DNXl/+60Ha2I7Z35t1ECuLeptK183j9j3fMGT5JJF/3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps75ikOrF+j1RR672/viPA+tTyxs/RTA+k0jeHet0WQ=;
 b=EZFMvGhDVoWWp6mMgYbOZyC+pc8rYjw6bfs1NByp3chmKHqDwPkBGdNzt2Pc5IB6EyS0t6P8g6COhxUmHBPB/A+vHFF/8lGk7T2sl9f/X06R4fLIm3eoMuUSMOtNtQhQ1W+VvPS6igzlwg5V3WS6QCJMQd4xp18wz2pS/E9BtSXzmXllLwxgdu2twOEJxRPAOZV9+TAjiYxA88bFkc2lsKzafoRbIn5/Emi6mmXWRikRnQkzXnRUh7ZVBG8S6jqUDCQZ1D9x8gGm4gj4JhERramiPMm6C4gFZrJ4Z66/6q/LrlQE0IgDXCQlybnXgmxDR83xMJqo35yiWEa51jgOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps75ikOrF+j1RR672/viPA+tTyxs/RTA+k0jeHet0WQ=;
 b=DJAzyyRhRo4WStqR4zrA8r5eMPRW0K/y17+Gk5c/c4T7DW7H+p4VyON3A5DPvfFXOTzqeOAN1F8bosYSrkrWEJauOJvsPxf2Dpf5FPsZHKFgZ2z9C1LkUwJ7WKsv+Aq9STHG5jpO4dR6K1rO7USUcl2YLIzIGe3yxzDyGzmT+79i/2WNVfBToxVKRbS12daYqsIZSH5YE4IY1kK3aeELrmyHZJpSA4ubaWSAsfW2oX6QlgG/KUF7EzeVPRh8FRFreK459iGUXiIRSCVwpffBAr+4Qk1KNCt9dWsj8mzgLKwDkXi/cwW1qCH1NdIzsmkOeCL7ITXEti57lTM8a3x6RQ==
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
 by MA0PR01MB8745.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 05:54:16 +0000
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71]) by BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 05:54:16 +0000
Message-ID:
 <BMXPR01MB24403F8CD6BF5D4D2DDC57A4FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Feb 2025 13:54:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250212042504.GA66848@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250212042504.GA66848@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
X-Microsoft-Original-Message-ID:
 <9aaf1ecd-0e84-470d-834d-06ed0e25e6d8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2440:EE_|MA0PR01MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: c25195a4-10fc-46e9-63ad-08dd4b29af0a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|5072599009|8060799006|7092599003|15080799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VExMbXMrT2dob3lnNkJNRk9ZTWYrSW5CTXZkOFh1WHBDSjlsdHhIT21TazQr?=
 =?utf-8?B?cDEraDh5VWNhdXRWdkllUENFUktIWFVNK3dUSUJKMmhMTmJZeG1Pa25HdHBz?=
 =?utf-8?B?QjlqaVJKSFF0VFgvbE56eXRiamRiZkFIU0x0ekVjSHBabUI0TlJIVkZlYklF?=
 =?utf-8?B?cE5NWWtJRjlFb2xIeGVMYnJFcHVDUTRlRzNQY0JzSkVSRzJFSDVaaENndzZp?=
 =?utf-8?B?eDZ6M0o2ZGZSRVdwaEJzcm5kWXU4TldoT1F4ZENyQzRacG1ySGZ5RHdFRDQv?=
 =?utf-8?B?NDRNdHY3YmpWM3lMdkVKeUVVaXpoamJXU0k3dmtqQm1PV0ZmN0RNTUhIeGIr?=
 =?utf-8?B?eFdxeTh2K2hQNFluOXZSR21FSkJiU0pZbzltbjE1SnlZUnRqRmgzMzhHYnZ0?=
 =?utf-8?B?eElzdURUTDEycGx3Qm95b09FcExNb205Qk84Y0NtVkY5RXFsTHNDWXVJRnpi?=
 =?utf-8?B?YWhVSmd5aytNaU9leVpnSDRSKytEMkVsMGt2NDZpazc3T01YaHdzd3J4aXpt?=
 =?utf-8?B?UlBnTVY3OGdvcTR3Y3VIVEtlRS9JR1NDYmJOTVNPSUJDendOd05LaUV0bUZi?=
 =?utf-8?B?Y3lVZkFRQ2NrbHBtSWxPZFlXZzBWd29NQ0dtRFhPT0IvckU3TUFXR3c4MEQ1?=
 =?utf-8?B?ZUUxUThmLzcxeEwwbVM5S3Z0bFIzbFBvM3dLZGo3Y01SNCtOb2hPUDRXRDJh?=
 =?utf-8?B?ZWxLU0NYZ05ORGxCdTZDODVxaWhNZGQ1NkR4QTFzb3pNMjdIZGZhVWVwQm0v?=
 =?utf-8?B?TWViRGl6K3pFTzF3U0RteU9yNmFuWkQ1TmFWMlZBZ2s2VjBBVk4vQXo0T0p1?=
 =?utf-8?B?SE9VS1prWTMyQUxGR2YzbFVTKzhGck93cjAvOGxYY3FNQnYzb3ptbmpzRkpF?=
 =?utf-8?B?UGlFamtlU0wyMTFVZ3BsS2pTbWQyMytPd1ZpZ0NqYmJnWEFUcE1OQzRCL2Na?=
 =?utf-8?B?VnEvUFdpSXR6aERpUUkrRXJHUGlNQU9CSTVmS1d0OGltN0d6N3Y4NEdIeDVu?=
 =?utf-8?B?NVVWeCtmbkttSnJiRG51eUFNOHJGN0RDM1FYc0ZiZHJOS1hIekFuSDQ2VjJk?=
 =?utf-8?B?RVp5WG9SeXRiNDdTMFptZzFLMWl2T28vdTNPYXUrTUFQbVdiSHkwRGljYWsw?=
 =?utf-8?B?dTJVK0s3RjJWNkhZSExSVlo0RDVrTkFwKzZETThoZWI3MDZJOVBGUGhSWGtr?=
 =?utf-8?B?OS9DZ3Q4REcvajc2SGVVdzNIUlZOZjV3SnAvTWlqaXZBeUtJa0JsY3g1eWVM?=
 =?utf-8?B?cWlNV0NFaDlLTkRVeXJYYzhZOUE5Y0VNR1oxZEk4ZGQ4NTdxRkVsTGdEdTVT?=
 =?utf-8?B?dnZvdXE5bTNZZ1UwLzFwWlViOFdrK0dvTFdzeXloeWV1Q1hoY1I0UzYyKy94?=
 =?utf-8?B?UVV1WGpWbFluV0hnenZsc3l3M05PeEx5N2lmMStWVjhFMUtqT1NhQmtWQVZE?=
 =?utf-8?B?VGRJQ1JtbHA0NVBSMHVYUEFZUVZZdEEvOVgzMGhSWXh4Q0d3bzg4bWIrTUhT?=
 =?utf-8?Q?sSMp2g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEV2VlVGODh0WUxEZ0ZTelJaVnpsWGxMYkFFTlA1Mk1VZHNyZFFlRFFPcEdI?=
 =?utf-8?B?VXlLRUVxclpHWFlSdjN2U2w3NFd4SHM1N1ZHRmJyeUFvQ0hpUkU2Tk43dE1C?=
 =?utf-8?B?MExiZjBTb2JXZkwyQzRwajdGeTJ3bEg2aWdNQ0dyUFJFMWsvK04waStXNHli?=
 =?utf-8?B?ZE1GdkdmTlcxTWF6cGJmQ0tJM1NaZ3Q4MkwwWXhOY2o4VFVCUzVha0pMSTBv?=
 =?utf-8?B?NW5iOFFrTEliQ1hYU1FOcGw2UzErS0dCQVVWL1VlYTlhN1VHempSaG9TVDVZ?=
 =?utf-8?B?cVJqdHlpcGh6dkRsdGZxMExpY3ZsdElJSUZJN2drS3BJU0M4VjFldzgweUhi?=
 =?utf-8?B?NHJ2N2d3MFdPcEl1Mm9wanljLytZVnBDVmJYcDcrNUhBOSttTWtCZktTekR5?=
 =?utf-8?B?VDYxNmVzRjAwTDdoWEZDaHBxSGlTamZVVG83WU4xZEhVcXE3c1liSUdzZktp?=
 =?utf-8?B?VS9UU1d6cWRhK0Y4b0NTQ2ZiM1lQM2RxdWVyUkZERVA2SGVoWmhndUU1TC84?=
 =?utf-8?B?K1NDNlZUV3Fla1VJR1lNaFd6Y2s3d3YzMHBGRUFlSHFHWGJSQ2ovWjRLc0hF?=
 =?utf-8?B?bk9lYU9KYldlL2Q0V1Q4am1SeW05VWwwdHc4UWhKR1dTYUZZQmVQTnFYVDhj?=
 =?utf-8?B?Vk5MdE1ieEFEYjRvWXpicUdSUkF6aDEzcXB1eHoybk5NR1V4cVhlVWF6NUwv?=
 =?utf-8?B?aWtubHdhNWd0cnJFWVR0VVY2ajhQQTFEMWEreE5DcUhCUFhwL2o3ckd0QnF4?=
 =?utf-8?B?Tjd1Nkl5WWxrakNlVW9wUUg5bkp1RlBMWEsyOEhYV240RlAzdHZXSFUxQ3hH?=
 =?utf-8?B?eVlqYmtPV3U2SE1BNS9uVnB6SUpSTk1lNEFPcHNnQ25XL2JEb1VMQlVJYko5?=
 =?utf-8?B?NGN3Vng5UzJiM0drdGxPL1FXb3hUbkZVVG9oMWoyNFhjck5iV3FrUWVYWDBJ?=
 =?utf-8?B?UVRPTjllSjZCb2lhc1RpUm1uWmxtd2hlMWNtcTBTeXpCUkE0YW5VUE5YcmVa?=
 =?utf-8?B?a1FzRFZPQmFEUnJWK1hkMkN5WDNpQ21pYklNaXBPYkhONGkzMXNINUFRTTlY?=
 =?utf-8?B?anZINVhiWWtWUGpPc0Z0TnFySExmeDBYUHpXMi8wVWlyemhtRDdYL3JTZzlP?=
 =?utf-8?B?RkliSS9XZU9BYnpWR0FSUDY5TnRrdEdpSWRqME9iK2xPRm5vRXNuRUN2R3oz?=
 =?utf-8?B?U3dpeW5yays4cDBDOHVGMVZCRWJmUzdMbmJHNS9JZXpzVFZxUmY2bERRK3M2?=
 =?utf-8?B?RXY4VUlQR2YrM1RwM29ORitCN0VyeE9FeG5DK1dmNWFTcHREVUQ2TFpyc0lM?=
 =?utf-8?B?ZHE0ZTg5Z3U2eE56aXRGM09kUGdBSzJRajZGMk1MbkY4S0lqSkphWlVCMUFm?=
 =?utf-8?B?WGFpeUhHTytqaVQ3WkNNemxmMDVQalA1L0VHNkFTV3lNK2M5ejJHZjZNeUo2?=
 =?utf-8?B?NEd4Yi9tdmJ1cFBFMHVWQkYrWEp5WHhPR01kZ09GU2VCTkdaaHRiMnhzSTVR?=
 =?utf-8?B?L2dBYjBkZUZkdEFSRlVZMGN5WlFTSUZ5TWcybHEwTW10WFdSa0NBUTVSbjhP?=
 =?utf-8?B?TU9KYk0rUS95WWlVU2tLcHVkdElkUkd1T0pPRWFCRkdNU1RYdmtSVEc1bUJV?=
 =?utf-8?B?dE9ZTG9YTGxMZCtUcmpnbG9CQ001NVZja09RMWw2YXo5V0lhaHFUWW52M0o0?=
 =?utf-8?B?Zm5hNURrYUpwYUpMU0NtcWpvYlhCcHluaXo5ekE0allac2l1aGs5Zm4wWkty?=
 =?utf-8?Q?hrKjjT/SQLx0aLfcM6DWVF5djULDC9e8Z7jX6gq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25195a4-10fc-46e9-63ad-08dd4b29af0a
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:54:16.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8745


On 2025/2/12 12:25, Bjorn Helgaas wrote:
[......]
>> pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
>> different "sophgo,core-id" values, they can distinguish and access
>> the registers they need in cdns_pcie1_ctrl.
> Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
> both pcie_rc1 and pcie_rc2?

cdns_pcie1_ctrl is defined as a syscon node,  which contains registers 
shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a 
diagram to describe the relationship between them, copy here for your 
quick reference:

+                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
+                     |                                |                 |
+      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
+                     |                                |                 |
+                     +-- Core (Link1) <---> pcie_rc2  +-----------------+

The following is an example with cdns_pcie1_ctrl added. For simplicity, 
I deleted pcie_rc0.

pcie_rc1: pcie@7062000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     linux,pci-domain = <1>;
     sophgo,core-id = <0>;
     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     };
};

pcie_rc2: pcie@7062800000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     linux,pci-domain = <2>;
     sophgo,core-id = <1>;
     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     }

};

cdns_pcie1_ctrl: syscon@7063800000 {
     compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
     reg = <0x70 0x63800000 0x0 0x800000>;
};


