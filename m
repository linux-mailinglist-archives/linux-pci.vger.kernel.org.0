Return-Path: <linux-pci+bounces-3588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C9857BA4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C51B23158
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7F77649;
	Fri, 16 Feb 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4DUqBs5z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFD7763A
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082977; cv=fail; b=NYuMeFsaEhNgcj85yuzL9TxSO878d8MHJLjYc+lR7hqdEwKt9SXl3QywffbGL+wTHUkSYp4W8enoFPyCGTToOBdSQBSGH/BrtQuUaSnPLL3P6A6F5TsqpAY016HnFMZ3d5/8MLbhmMoo7qZrJbu5v9gUjeS/MscHOYaEv4qkkRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082977; c=relaxed/simple;
	bh=L5nmPi/HEWxQsNVF4+OzZzBcYoL5p8Stt24wTRiWSpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aEIAQSgpZEuwTcYrTkaj5ObQWP+OUGfBgWHaM+G9HVECsoROdXOjNUmOC6HN1JCxLxSgmFjjGyRoyM/s4GXzeL8KYFs3T8mIDHoFqz2IQq+AUfEssQ62wicq7tjn0W9MvrsEpW0fhwPWl2s8LOPf+rB3DdbPC40EHeazn47PrI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4DUqBs5z; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak310YagS0NP+a4YmfuQLwHUHyJ/6F7qphJLRWa4RrJ76j9EAxSc7y2v1/LdFx/tu6/T19hewwVhrFHgnfgegbCk94IzsN5LI+80hf6JbWeDbXpRUfGzbca2FNUTMBFKXMHE3fiuDL8u12uD/dhJss+eFw0kwyX1LcagE7GoqhN4xGxH0Qk+i+l111+GUbD08JSbfkHSIO0RVsJMHONSfQf6BaKgSXVz4qZ58FVDlqJZwAZAd8NxMZ8oMPGFQJ61MzKZoyMUeMsuK3+b75PHTCd9zsS4jT14aB56ou5B4S0ExPgiFXpot85KyoCTqikrzGogBj76cU8lC9ZcxeE49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wny8Ww2mvLI8pMM0zhnCnftWbwnM5fcCcET4sCvtiqc=;
 b=g548MJd1PTvEnxi7MPbRjFRe3SklGgTB6jvzUlFs1cBNsick/Bpe1WTUMZkOd/B0eLZCTI8/JU5vUO4VhCilQdE/sFrnas4dQFuEHcPKsmH4/kL1zAFMHhVNHJgnF/FUJvuV2qhhiTqE5mo5XVFH90wKEqi5vwMvlzkLsRED1YYY1GUtMrKLij3JTOwYS0R4JwFZOY3HI7d11VDvQdvGVP9d980pe8k0W4cfsjVHLLWmFmBCQ5WEOf1aQVS0UrG2mstPpJddPvIIkH49pl2xVG8RQe+pI8JYwWv1lAFcYVI0glPh12e4QChrPyRz8Mjr4kI5DOWU3Q2pIVPcat/FDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wny8Ww2mvLI8pMM0zhnCnftWbwnM5fcCcET4sCvtiqc=;
 b=4DUqBs5zMmNBCZm4suIPlQDW/zNIoBMjxLOolgO6B7b5y8kjUjQRDPSE+Pj8tfCKNCjN+huooDLwQv5mJSwlJYR5rYkqecRR2CBEW5tx+v+vGoSU/AxUGgoPjD1+KxPpOm6h/KMDtSwO5LbMRYzqqOKV7oc8zEyBHY5jz+tiKY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 11:29:33 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638%7]) with mapi id 15.20.7316.010; Fri, 16 Feb 2024
 11:29:33 +0000
Message-ID: <63f8e848-2fe5-40df-bb97-c628b83b1b06@amd.com>
Date: Fri, 16 Feb 2024 22:29:22 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/5] coco/tsm: Introduce a shared class device for
 TSMs
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Wu Hao <hao.wu@intel.com>,
 Yilun Xu <yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eaf44c-6e99-4f1f-c784-08dc2ee28c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mdEzbp25MbrFWQgT7Td8E1Wn+NmPAkq3tk55OkD0S7PrC1hnz+p7ly1eivmt/GLjZmmZhSHSUkP7Xc1/FAv1qDdQVB20mWiQOPlqpQPaaK2p4qFUIA04vlB0Zs+vsMgVfFIevbEL9RD1Nm/Fq2zV37TEi7H3n6l7SUboGcxVlumDCHFcElorhQ+8FB9B6xpIUNAcfxEq6T4csUX865XaZRIKkimxTmvz9vo63IjIfxfOZNEZbecEW2OGDH/I8waW0gUaur9+XEucG25/+MVx9WR8lnzshTr36uKuiBZrw4+IwknL3hOQyMTJy8Syx5UlvwmiZx2S3PoV5SAyyne2NRKbFCQNYyzpKA1AxQb2aCP+m3UmJGAvmNRr4QlPup54zz2TIB7Xn7NpFhWGCJmcd82I1FUTxsIcozw9H1OkMzi7f6d2kyQVju1QI1MWAGMTN9EEADGU8JNsMv7jVwMB+9TrLkLsveQBBpZu31YxAd6WYEpM5YmWRfA5LpO5qXwUBf86KO0UGfmrHxGeDm5poBlF2byL7oy7CBFw4NzvNUNyTXx2/gKhQd2GsObmEQmR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(31686004)(2906002)(26005)(41300700001)(83380400001)(4326008)(8676002)(2616005)(8936002)(478600001)(6666004)(66476007)(316002)(66946007)(66556008)(53546011)(54906003)(6486002)(6506007)(6512007)(31696002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmVGZTFEYURtdEhRaWNhdlV2Yys5MjkxcDNML0t2ZmdHSGZWNURFN1dIa0Vw?=
 =?utf-8?B?TkJldnpGZEhCM1BNZ2VQbEM4VTlPTUY5QkEwMGhhcHNoek8wMzgydzZaa2s5?=
 =?utf-8?B?c01maDgxb2pQNnZEU1VINnpqUXo2UjVsWnh6REFuTWw5OXdOU1NEcDdCdDlB?=
 =?utf-8?B?OFpyaW5sUVo5TUhVWEtNOUdWbTRGTFNXNHRsV3E1cjVEbjBJclBoWTNocVlM?=
 =?utf-8?B?S3NrdHdEVzZYWHhkc2RwVUFlRGRjWHlmR2JqTzFsbkFsNS94RmJrNmZkaDhr?=
 =?utf-8?B?Qy82aVJmK1duMk1KM0RCVUswSDZUMHNDcE5hdEVlMmtVUlU2Tm9LVWdhMXpS?=
 =?utf-8?B?ZWhxcGtBRy9pTllBMFlGV3Z4SUhQYWM5czZ5L0Jua2FHL0MrU1pIdlhBM1lt?=
 =?utf-8?B?bUpwRGFDL001cmtHWmNicno5aVlHcXM3SUFlcFUrQkZRVUI0cFk2RVJUZnBI?=
 =?utf-8?B?OTRvOGN1Z1d5czczME9JMTBYSjhzL29zbU10M2lOWkpHRmZtNzBGVDZvNkZu?=
 =?utf-8?B?SGEzQlZLNm1IM1NTNHQvMDhXdlZFNjFhZU9wdVdLdlcxVCtGclBoSm1TMzJp?=
 =?utf-8?B?VG55WFh0a1hGcXFtVTlFTHlLUXRCS1FTQ2p3UDdMMzByU3RYS0k5QktlYURv?=
 =?utf-8?B?QkZhMTd1UkxLUXRlNUNLNDdBUkVuUDFQbXdGb3NTOXkybGhKQ1RIQkJpZ3Jl?=
 =?utf-8?B?QVRkMHV3dGJiSTBVSUVYd1JFNklpM3p6bEhzVlpRaVZTaDNlZXBWdjZuNmcw?=
 =?utf-8?B?OTk1SGtOcy8zRStZMVNVdEl3T1BSZ1BhbTNNZExhcnRDN2ZsNFdMZjNrL0xh?=
 =?utf-8?B?VTBzSmZrQWg0VzhJL09iS2gxZW9MTmpwWFlPa1pHckRKTm5HQ29vb0xIMXF4?=
 =?utf-8?B?RzE0Z0prZ09obGhiZmpwL3daR2hyWkFBbWZlM2dtdSs1VE5XUkhqa2Q3UEox?=
 =?utf-8?B?MkloMEhJeFAzaDQ4Nmt2aWYwb21hdnh5bnA3aEEwcnVyVXVuTkVYYjJZdTR1?=
 =?utf-8?B?WW1wRXg4OG9xa3NQbFRzNmxjY3U4RWRJbDZNSEgxYUJic2hJdjdoei9JclZJ?=
 =?utf-8?B?UFF4NWozK0FpMXF5M3ZRbU1weVExTEgyK21jVXkwbjBtZTBzaUVNWTNuNUdO?=
 =?utf-8?B?SHE3K2JoTU9nQnBBaUpCeDR2eEVmSzI0RUk4RVV1QUQ2dXJQS3V1ZHI5ZnZ3?=
 =?utf-8?B?RHM2QkdGODJKaTRCNzlBVFMzNWFIS1dlcUcvb0dXQ2M0Y1pOL1NDZUducHZQ?=
 =?utf-8?B?MHpiQXovVE8xRU40V3oxbXhLZ2xOaVgxbTZuSEc3RitjS2hhS0FPQi9qU3Qz?=
 =?utf-8?B?OER1cEN0bk51VTNZNGM5eVNWdGVLaUJHbGhTaURDYWlOOGxJemk0cHRHVHhq?=
 =?utf-8?B?Y25DUUl2TmJDWU9vT3p5TTlPbkFoWTkwQ0RnSHVtK21oSlRBRkJFS2dqR2Fw?=
 =?utf-8?B?ZkJTb2pyOXJQMU1yN1Rab3BFeXRVcVFiTXBCbkRWUStXZitWSmd2QmxocmJ2?=
 =?utf-8?B?Z0pFaDBxSnpVV2dJR3RsNE8zd0NiK2Z1NGUxbllMRk1ZUHBPbzJkRTlDZWgy?=
 =?utf-8?B?dUxMUFo4SHZ1TGgzWjZtek9EaGdRL3dCNi9tZUw1Nytib1hYczlHdi95Lys5?=
 =?utf-8?B?WVZ1Qnl0U0JtODk0dHVER2FvY05sYzdWYUF5ZUtZTDBucFlPWHhrbXV0Wmth?=
 =?utf-8?B?MzZTWGhZV25sTXpldVNWMkZMMVZjNTBHQjRyRGNrOGs3WTNZaG1IMVhaTUl0?=
 =?utf-8?B?YXIvK0FYM2RIUjNkR2JQN094TitEengzUGtueE1pamhJMVN2MmNuRlJxcE9H?=
 =?utf-8?B?SlRicXUyajZkWHpXSExQTEhQd0NvK3VmeWpCWXZ1VXZXRkd2N0U4S1VuZElw?=
 =?utf-8?B?TlJYRVEwckVKV1RIYTl3cU5NSlNORXhXU09NZCtidjJ2ZU5KUHlxZ3Z1djBF?=
 =?utf-8?B?a2x4MmlaN292ZVhnNUhnQ2IxK3FyLzVtUVkxdUQrdkk1aUxXNTlJRzJ5YUtI?=
 =?utf-8?B?YllYQldmd3VvQ2Vlako4QnJKY2ptNE9qM0x2c0RvemNLOGdaaCsvRHd2TXYv?=
 =?utf-8?B?UDd5cVIrSkxhWWw5ejluVFJsVHNQU1JVM1Zta0lMMS9LOWp2YjdqNUh2VWdW?=
 =?utf-8?Q?9xHzVt099Wn012akvptUmmcOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eaf44c-6e99-4f1f-c784-08dc2ee28c09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 11:29:32.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxMYkNzd+QDibFuYZ46/uPf+Z7+CeMLI9Se2STE6+R4FDsL4j349Mlgip6sPk1cfdevfUW5tETDWcLquZo+tLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

On 30/1/24 20:24, Dan Williams wrote:
> A "tsm" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. "TSM"
> also happens to be the acronym the PCI specification uses to define the
> platform agent that carries out device-security operations. That
> platform capability is commonly called TEE I/O. It is this arrival of
> TEE I/O platforms that requires the "tsm" concept to grow from a
> low-level arch-specific detail of TVM instantiation, to a frontend
> interface to mediate device setup and interact with general purpose
> kernel subsystems outside of arch/ like the PCI core.
> 
> Provide a virtual (as in /sys/devices/virtual) class device interface to
> front all of the aspects of a TSM and TEE I/O that are
> cross-architecture common. This includes mechanisms like enumerating
> available platform TEE I/O capabilities and provisioning connections
> between the platform TSM and device DSMs.
> 
> It is expected to handle hardware TSMs, like AMD SEV-SNP and ARM CCA
> where there is a physical TEE coprocessor device running firmware, as
> well as software TSMs like Intel TDX and RISC-V COVE, where there is a
> privileged software module loaded at runtime.
> 
> For now this is just the scaffolding for registering a TSM device and/or
> TSM-specific attribute groups.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: John Allen <john.allen@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-class-tsm |   12 +++
>   drivers/virt/coco/tsm/Kconfig             |    7 ++
>   drivers/virt/coco/tsm/Makefile            |    3 +
>   drivers/virt/coco/tsm/class.c             |  100 +++++++++++++++++++++++++++++
>   include/linux/tsm.h                       |    8 ++
>   5 files changed, 130 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>   create mode 100644 drivers/virt/coco/tsm/class.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> new file mode 100644
> index 000000000000..304b50b53e65
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -0,0 +1,12 @@
> +What:		/sys/class/tsm/tsm0/host
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) For hardware TSMs represented by a device in /sys/devices,
> +		@host is a link to that device.
> +		Links to hardware TSM sysfs ABIs:
> +		- Documentation/ABI/testing/sysfs-driver-ccp
> +
> +		For software TSMs instantiated by a software module, @host is a
> +		directory with attributes for that TSM, and those attributes are
> +		documented below.
> diff --git a/drivers/virt/coco/tsm/Kconfig b/drivers/virt/coco/tsm/Kconfig
> index 69f04461c83e..595d86917462 100644
> --- a/drivers/virt/coco/tsm/Kconfig
> +++ b/drivers/virt/coco/tsm/Kconfig
> @@ -5,3 +5,10 @@
>   config TSM_REPORTS
>   	select CONFIGFS_FS
>   	tristate
> +
> +config ARCH_HAS_TSM
> +	bool
> +
> +config TSM
> +	depends on ARCH_HAS_TSM && SYSFS
> +	tristate
> diff --git a/drivers/virt/coco/tsm/Makefile b/drivers/virt/coco/tsm/Makefile
> index b48504a3ccfd..f7561169faed 100644
> --- a/drivers/virt/coco/tsm/Makefile
> +++ b/drivers/virt/coco/tsm/Makefile
> @@ -4,3 +4,6 @@
>   
>   obj-$(CONFIG_TSM_REPORTS) += tsm_reports.o
>   tsm_reports-y := reports.o
> +
> +obj-$(CONFIG_TSM) += tsm.o
> +tsm-y := class.o
> diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> new file mode 100644
> index 000000000000..a569fa6b09eb
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/class.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/rwsem.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +
> +static DECLARE_RWSEM(tsm_core_rwsem);
> +struct class *tsm_class;
> +struct tsm_subsys {
> +	struct device dev;
> +	const struct tsm_info *info;
> +} *tsm_subsys;
> +
> +int tsm_register(const struct tsm_info *info)
> +{
> +	struct device *dev __free(put_device) = NULL;
> +	struct tsm_subsys *subsys;
> +	int rc;
> +
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (tsm_subsys) {
> +		pr_warn("failed to register: \"%s\", \"%s\" already registered\n",
> +			info->name, tsm_subsys->info->name);
> +		return -EBUSY;
> +	}
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +
> +	subsys->info = info;
> +	dev = &subsys->dev;
> +	dev->class = tsm_class;
> +	dev->groups = info->groups;
> +	dev_set_name(dev, "tsm0");
> +	rc = device_register(dev);
> +	if (rc)
> +		return rc;


no kfree(subsys) ? Thanks,

> +
> +	if (info->host) {
> +		rc = sysfs_create_link(&dev->kobj, &info->host->kobj, "host");
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/* don't auto-free @dev */
> +	dev = NULL;
> +	tsm_subsys = subsys;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_register);
> +
> +void tsm_unregister(const struct tsm_info *info)
> +{
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (!tsm_subsys || info != tsm_subsys->info) {
> +		pr_warn("failed to unregister: \"%s\", not currently registered\n",
> +			info->name);
> +		return;
> +	}
> +
> +	if (info->host)
> +		sysfs_remove_link(&tsm_subsys->dev.kobj, "host");
> +	device_unregister(&tsm_subsys->dev);
> +	tsm_subsys = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister);
> +
> +static void tsm_release(struct device *dev)
> +{
> +	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
> +
> +	kfree(subsys);
> +}
> +
> +static int __init tsm_init(void)
> +{
> +	tsm_class = class_create("tsm");
> +	if (IS_ERR(tsm_class))
> +		return PTR_ERR(tsm_class);
> +
> +	tsm_class->dev_release = tsm_release;
> +	return 0;
> +}
> +module_init(tsm_init)
> +
> +static void __exit tsm_exit(void)
> +{
> +	class_destroy(tsm_class);
> +}
> +module_exit(tsm_exit)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Trusted Security Module core device model");
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 28753608fcf5..8cb8a661ba41 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -5,6 +5,12 @@
>   #include <linux/sizes.h>
>   #include <linux/types.h>
>   
> +struct tsm_info {
> +	const char *name;
> +	struct device *host;
> +	const struct attribute_group **groups;
> +};
> +
>   #define TSM_REPORT_INBLOB_MAX 64
>   #define TSM_REPORT_OUTBLOB_MAX SZ_32K
>   
> @@ -66,4 +72,6 @@ extern const struct config_item_type tsm_report_extra_type;
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
>   			const struct config_item_type *type);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
> +int tsm_register(const struct tsm_info *info);
> +void tsm_unregister(const struct tsm_info *info);
>   #endif /* __TSM_H */
> 

-- 
Alexey


