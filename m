Return-Path: <linux-pci+bounces-32047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCFB0389A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1C0179E72
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213F22FAFD;
	Mon, 14 Jul 2025 08:04:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023102.outbound.protection.outlook.com [40.107.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003B2E370A;
	Mon, 14 Jul 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480244; cv=fail; b=kGa5SZtBYL0kvWpIm5sB+qxTfTAj81SYl/9HiAn7h5yJk7ek2A4glTGn/7+PEMM6Tm9p+dzs4iBEh5Cl/AmY8sQ7GV/x+mGOZpverQ90UeVLQDdz4T3u0EIELkCMcG75LOWHnXPH48rqXvl4whnSDTPp+LrUBYKXucO3Y0zyo6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480244; c=relaxed/simple;
	bh=0LZ3Gxcc4f5XbKKGiv0eCUuBUJxxrFauyHs/cygVm74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLQENK+sgrJlSwQ5pV4ESowFvFaU4Pd0opUJ5wP1t1iH/N8UzsYK77/3lMzfOPQMNLdwxjeU7Negyvma15+VhxPFLSTzllSZNkMxw48e/AVvh03DeQm3GKBEtYdzs9FMp/8BGzxIWqs/4nsMpJx2LLYemZjizp/yH/NInsC9lYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trI6id2jAi7PkS4zPbSTWnDfcCXeI82K72U2hkhEZk8Acnu9jHex2R8HnV+tKXvWENck5yC1gM4ISRzQDE7A2ha6sUCnisDtYIqqJSnreD+Vq7S3nyXYVqtAXLudoyTa71LpeB6TVym/4NgYck9qPm89NP+RN6P+rkHHqtPfyOc2BCrx15SI5NQYFyRbt8zPzOOdXB1EVHf+7F6Ikiw3ufEVDz85wYbJzC9mJA1zsmmoaxGHO1nb3kvp1SiqyHy3BSLtbvaLZk64oRrDPUOFRtMaC5TsrAkaGy1d7BF9b7cBDQ8gFutuBaRK3Gox/2lIwqaY7IL12MvRmG0QggnUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xavPekw5owc4g45UqVCN4YXw14RbljQB6Kr+hnSInoI=;
 b=DDwa+h5U5LnGspChae2tvZzWpYlj8Cupl6m9dMI8vqbLE8YTS6XPKkRjEJDuZnNMuT4er3Yp1jbkY6gpYZHdAzNlJzv6esvc+iLhPLo4IDcJWo7lCSZ4hJJ3S73ztyGnQOBubiayVSqsvu/A/fBIi0qUqvPUcbNqiRiZcUkyKbSSZxoC9jnCFdo8qylTfED5eVkTUBWJcExgGluHf6G5BSOoqjLtId130ZA15QwKJt/isMazgYLRurTblQ9BLBBrz8bSX1QnQeCTcGJtUP5LH2CTK3PFUG8YXsV5IeuJ0tN7scAF103rRgn65BRC+q4uN+WW2I4wzgh8wz2NxDM0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:4:194::7) by
 TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Mon, 14 Jul 2025 08:03:54 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::2f) by SI2PR02CA0012.outlook.office365.com
 (2603:1096:4:194::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 08:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 08:03:53 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D70DD40A5BD6;
	Mon, 14 Jul 2025 16:03:51 +0800 (CST)
Message-ID: <d6083e62-318f-4879-bac3-97ad26615458@cixtech.com>
Date: Mon, 14 Jul 2025 16:03:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
 <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
 <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
 <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
 <a7aac65e-848b-4bb3-bd52-963766410698@kernel.org>
 <50592fad-850c-4dab-92d8-a71cb89daf58@cixtech.com>
 <e3f6da47-25bb-450c-8660-f1406ed590e6@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <e3f6da47-25bb-450c-8660-f1406ed590e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TY0PR06MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9754963b-3fe4-4eaa-0d40-08ddc2acf980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTdZUjBzUnVaeVI2aHZpREYrZXd4Rms1LzU3SFJaU2FVeHhGTjhjS0FqRlEy?=
 =?utf-8?B?R05FbGY5VUpleCtKaFVuTkNLaTdLUXpEYmM1RzU2cXJPRi9oVk56VXo2RXpz?=
 =?utf-8?B?UnR3VHVjMWJtLzVJcldaaE5XZTZkUFhIZ3ZuRlpkUlB3N2Z5ZDdvQWYvSWEr?=
 =?utf-8?B?M2hHSGFPaStwZ1VPbEovWVFTYTAzZ0c3Rjg0QjA5K2NjTmFYcTBFYXdpbHRj?=
 =?utf-8?B?RVhReTU2cEZNRk5HZWxKeTcwTWVrY2w1amYxWFBtaTN3aTZ0M0FwZWUvdUhn?=
 =?utf-8?B?Uyt4K292d1F2UlBITzhWLzZiM1ZiTXhkNlA0RHRyM2Q0TDlnbWhpYWF1T2lM?=
 =?utf-8?B?NVFWK3lKSmNrOGNaK3VaMW9oYWZjK2tNOUx5a1pjUUF1TTlycHNTUjVadFVJ?=
 =?utf-8?B?VnQ0ZmdYVXhENVRjUnhDeHhSc1VTdjlpSVJFZ2NwMUUrcHllV1p4UTJ3TzFI?=
 =?utf-8?B?U015dkNHeE4vNzh1TllRUElSZkxOSmovQ01maWJlZzdoemc2WUxrV2kzMjRm?=
 =?utf-8?B?SHM5Ty9uN3lCQlVzZnFUcllsbVkvMVB5U1B6NWhMUExEblN3RlpIcC9Sc2sr?=
 =?utf-8?B?UHVPUFg5MFZjUGsrREg3ZXJHWUR3N2svbk1HNFdvK1FpUEhnUFp0eS80K3h2?=
 =?utf-8?B?aTVpT1doMEcxNThXTWNlWVhXUXpudDV2MUlEWmhlOTh4a3pFVWZaSG9wZi9n?=
 =?utf-8?B?UFlleGpUa2I1dStHMUhsQi9Cc05DRlBxT3d6TzNhVTdVR3hJZFM5ak5QSjc3?=
 =?utf-8?B?YmJpZTVQbjdpUk5DalNBdnJGTGxSdGlEOUdEaDJwQTJFcUNTckhMRUw3ZW1Q?=
 =?utf-8?B?aUNMdTlBZkk4alpOZHRQMUt5MUVSdmRHbFRqSEp4UTdmQUhzaHcyeldhc3Yw?=
 =?utf-8?B?VnFWNk5UY0JiUUJlcHdwbitjR25JOEEwUFBpczl5aGdoZjRyNkM0NUhnQk1n?=
 =?utf-8?B?V0ZpWkFmSjA3S09CZzRwcThXa2hIZlVDZjk1TmtDTVpLc2hlZ3llZXBwdERy?=
 =?utf-8?B?dFl6MDBzRW9IbUIwTzhiN0dkRmgrcmdPN2xBK3l2NENqQ1FEMys0eDE0M1pi?=
 =?utf-8?B?eUZWQk1zdWtPNnBmNERWSnB3UU5wdXJjVFFGL3MrbFF2UCtTWnUzTnlubDFz?=
 =?utf-8?B?TjdQTUNIMWU2NU9Nd1pZay9lTkpoclE1cnlOYlB5WmVsT2VRclBEU3JaQndT?=
 =?utf-8?B?UFFOSFM3TDRpOE9NUkJxcUlYM3pqb2hJUTZFb0g4Q1hrU0pHaGVrVHZSKzhS?=
 =?utf-8?B?L0s5WXlYaWZNc3lZYXJtTStQSWJkaStLNTJ0dWhNZ3J0emdyVnJhNlVLcnVR?=
 =?utf-8?B?V0tybUowb09ybVZoemhCV1hHQ3RUS0FYVnhoSExTN084MXl6UWQ0R2tycWdl?=
 =?utf-8?B?YllXeWhtWnJva0NXVk1zdE4xUUdZcEpMUEpkd29IY1RJS2FsWG9sY2twOEN0?=
 =?utf-8?B?azBZRUNkeWk3a2xxZW1uQU41TGk2dUtIbWord2toc3I0K2Y3SUFLZHk2RmdH?=
 =?utf-8?B?dVlhdWdyT0lQU1VVdDU5SzM2TG1QWjFTRjh6bzJxSkxZODFDZnVPNjNlQ0p2?=
 =?utf-8?B?VHNsRHllcTRDd2YvaE9LZjg5ZmhNalRwRDJjeG5sMTREVzIzU2I4Y0JaaGlJ?=
 =?utf-8?B?TU9DK0twV0FBUjdHMFRuWDVDeG85bFpsNHlEWjl3MGNJSEhSbUdqMEZuNit3?=
 =?utf-8?B?MkdXVTBObm5ORmJXaWlsL0FGOFFZMXo3amppbWdwUHJvbDZaY0FoL1lKSWJo?=
 =?utf-8?B?MHlNQzVLV00zV1M0b1lOWk9RUDk1QlJ0bXhidkMzdEcwb2t6eS9JTTRjOHRm?=
 =?utf-8?B?cWxuS2FNdmlTUDMrYVk0eFV4ZDN3UmJJTnhMNkh1OXdQS09ReThZWGxsSUUr?=
 =?utf-8?B?cFk0MXI5S1N6M1VNc2U3Mi9MSUFPUTRnajdUUEl5Zk1yV3pzSEJVNUxCK1BB?=
 =?utf-8?B?eDMrbGRIOGRnZitDakJlOTlZNmNCdytDbDUrREUzN2VKdWhIcWduZ1NOb0dV?=
 =?utf-8?B?anE4dlBHbkVjR1Z5MTE3c3cybWErS2V6N2hEVUlpUXZnanpxeU8reXhLamhl?=
 =?utf-8?B?UjFYcE5wb1NCYnNwRVB4d2ZTclpjWWhXVVZOQT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:03:53.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9754963b-3fe4-4eaa-0d40-08ddc2acf980
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5128



On 2025/7/14 15:43, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 03/07/2025 03:47, Hans Zhang wrote:
>>>>
>>>> We initially used the logic of Cadence common driver as follows:
>>>> drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> of_property_read_u32(np, "vendor-id", &rc->vendor_id);
>>>>
>>>> of_property_read_u32(np, "device-id", &rc->device_id);
>>>>
>>>> So, can the code in Cadence be deleted?
>>>
>>> Don't know. If this is ABI, then not.
>>>
>>
>> According to my understanding, this is not ABI.
> 
> Huh? Then what is ABI, by your understanding?
> 

Dear Krzysztof,

I understand kernel ABI primarily refers to the stable binary contract 
between the kernel and userspace (e.g., syscalls, /sys/proc interfaces). 
Device tree properties are part of the boot-time hardware description 
consumed by drivers during initialization. They are not directly exposed 
to userspace as ABI interfaces.

If I understand wrongly, please correct me.


It was about half a year ago when I submitted the patch that could view 
LTSSM link status in dwc that I learned about the ABI. There are not 
many studies on this.

https://lore.kernel.org/linux-pci/20250123164944.GA1223935@bhelgaas/


Best regards,
Hans

