Return-Path: <linux-pci+bounces-13208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB9978FD9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A426B1C21D2E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891791CDFCE;
	Sat, 14 Sep 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8psIfeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F71CDFCB;
	Sat, 14 Sep 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308669; cv=fail; b=Yv7oHCmmMfCVgTDXL3uLKHSdjzPWCynHfMjR0M2WviXNe6tF6h8xbbDz9MdHSQXN2PtAJNqP2GqzkfYfDZfAiV+70Pdn/Tg+Ye/V+WHTHmDnsppoScDLM3EkgVTkgb3pzi/Kchqn6sxO+QAbOwBOHHdRlKsngbE9mcw5oHzCHsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308669; c=relaxed/simple;
	bh=N1vak//NxJ/oE4IZytsQ50RmBlIfVmV+5aFnaU+gEQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XW49+OARYaVEoh8P/Y+K5neoS+HVTd8k7xk4uK6lSMGHQrX8Kwwe/BApWf6yhDSifBJmL3l01HCdNCi/6UrHs8AYKiDBf3noFMRcgW9V038wBbvbNm2jAi4xwHbpoON9PH1iv03ZLDtM0OnnlrR2t0np+YtSId8tIUFCxZLwhkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8psIfeu; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss8TDiLdZee24q21ioG1YxXZk+lhSr/iPdPJzGxl+fzuxqZhdigIwfN+pkZmC1qwb3wCZ9Pt7XUKeXRAHgpQBb4WF+oMIbVn4goZDTW/d64ZoB6AqrpZ+5u1lsVQeM7E2OhwwWape4IsC1o73Ii3vomu9axv66ubFAus8C4rGH6iGlAjhJ6HHhLKekDxOCphYCGueIuORWsugc95mCc2frxIuPTsQHvM0Ew+8nZT2sdNQew/IxzFJTkG679i+sit8V1B2E5VRT3zBPKiEwaAttZpE7e4ttbkmoYY16LlbUUsEdX9m9RKE/T5PAebktP5xSsDbTOx0WTDu7+KzbHxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGnGEHnhQL0CHzRAvla2QvzmK4FIz/tdTr40XsDumpU=;
 b=nP5eLTEByLT/KD+t+ROMGCrcpc+7V4O1fa5bOSlC5H3Hiv7HRac1bfWuwi5T44RsRdT2uID2zCbUMf6Yx5F51xdumhSZ/2HlhXLZwvLpUkLNC+BkjNsf0ZdAY8NZdHf73N3lKpigUn+PQXseYdF5fkbtgv5YRwk1ome+S5vBXjR0trkIIbffZUKaemSabv2hp1H8dFUTbIbax2Ua8BdJWW+7AJA5YzMycClgExuGWASzqgdEkmRErNzwyJGDguMXt39o8QhpwUPnTYfGX2KbFtsk6tvnYdBKsJnEusBFF0xLCK8ducqb6UGmZJAvFXyu9RYfE8b0NRb3uLuLSWd8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGnGEHnhQL0CHzRAvla2QvzmK4FIz/tdTr40XsDumpU=;
 b=H8psIfeu0Fr1XJYjXbYf3PivEA6zAW8eoUorGKfT5NpyclKvMnzzbyFoOgPh+ZVe3FhuSy/lOzp0Pl7b0NsunWVafM4ctUfFGILF0mCiEc9l5ECdQPbmmJZyeyHqdK0Tgoza71wG6T2BFKNA/ICHBKOtDvQOxbCHtifzUY165fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 10:11:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 10:11:02 +0000
Message-ID: <41d2719f-c5d7-e432-756b-3e39fe49fc8c@amd.com>
Date: Sat, 14 Sep 2024 11:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 08/12] PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-9-wei.huang2@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240822204120.3634-9-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7640b4-6f1a-49ec-74b5-08dcd4a58949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUwreGY5bGgzMHFoM1M2Ty9HRE1SVTZBU1kzZWZKeUFIcWRuTTh1L3FCSU1a?=
 =?utf-8?B?VThwRGdFRG56SytJSTExTkVCZnAxOHVtTXozZURxWmIzc2dJUy9HSHpaSEs2?=
 =?utf-8?B?NHBaM3F1MUQrMGIxTGdiaFR2by94MkpnbWZKUk5zeXcrLzI5SHlMY2xiZXBh?=
 =?utf-8?B?TVFVWlBHNkNDOGVsNloyZzZPN2orcjdxOEdsZlRBWjNrSUxucVZSZE9ZMktp?=
 =?utf-8?B?Smswcm1QQkNHc3c3dkpFbUNyTGpLRTBtNlA4amEwWWw1L1UvLys5Y04xTVNL?=
 =?utf-8?B?ZXdMK3k0cUxicjdTbVRHVWMrSzVReXVhWWd3K1lCMkdjcE5uRHdKVC9IeHZy?=
 =?utf-8?B?YWMyUHNIVzRRM0d6QUJvcUV4YnV3MUszazF5Sk5Qak5hQUFhYkw5NnR2czVU?=
 =?utf-8?B?QWxHRDVlbEdLMjRabUNIQjVybnJlVUM0cWN1Rmk5cUVLWFFPcGw4RXFTQTI3?=
 =?utf-8?B?RVFNRU9uU0d0VWorbmpKYUs3K0RaRy9VdnBDU0FpSDV0Q25lZThRV3FBRnBK?=
 =?utf-8?B?TDFaRzJudi8rZEkwS0xIbWlsczM4SkRvUXV5aFBYY1lieXcrdGcvOEEzMTNI?=
 =?utf-8?B?TVdJNGdGOExEQ3gzU2NINng1VG54ejcxNHhzVGw0cFFyV3dQNUdqb1kvUDE5?=
 =?utf-8?B?RWE3MnBwbmN3eEhDN0o1anNxSDkwU0FQZnFUSnJOYXY2TkhEYmZqbEREU1RB?=
 =?utf-8?B?RXRIdUd1SzBNa1k2WjlJbnc5dGJkbFpMaFNQQlZPL2wzZUJnU1QvTTY2NlBY?=
 =?utf-8?B?U2pFMkxQZHZ3WnRKdVdLR0Zid3R5bWVVNktVR01mbFd5RnlGZzgvakNTOU0r?=
 =?utf-8?B?OVU4WUlzNmg2WlZkMnhrcEp3NmJ0Qko3eGxmak5MY3ZRYXpWUzcrd1F5VEdC?=
 =?utf-8?B?OC92YnhSVy85czBVTzA4RmNPdCtTdTJvWUpiakpSUnRsS1UyclRPdngxRHdW?=
 =?utf-8?B?Q0F0WkdtZ2YvOWJ1MkZNM25Md3p1eWZnbXI5eFVFYlpBVjVDTk5rTWdRY00v?=
 =?utf-8?B?WElCS2lyODNNK2I2L0czaHM0bEg1UE1HcVdjOE50WFFVSDcvVjFsT1ZQZGh3?=
 =?utf-8?B?K1pwekh0VFpMSkxLNTU4WVVWNlVmMW8xYytKUGFrQU9yQkIyZ1VGbE8xaUVG?=
 =?utf-8?B?eGtBZlgyYUhDcVVaZHVGaHk1WlMzTGZMOWlpR1orZzVxajJRREtkZldoeFlY?=
 =?utf-8?B?M0NOelJDU29pcDZOR3dyNmRxSUl4UG9LemlnSjFYTVIxblZYN1NuZW5XQU0x?=
 =?utf-8?B?bTBFekRCQnNKeE1VTVh3azB6RFBOYzJOcXoyOTVkR21EeU1NUHhVTUNXakQz?=
 =?utf-8?B?NFBha0xsdXpPMG9ESitKKzBMOTZrNGx4b29Fa2NOVGNHbGRydXN4eERyZDd1?=
 =?utf-8?B?YmM4Vk9wOUZBRjdvbkpVSHJGREh1dW9ONG10OUZWWWE3MGNDNk9mMVFaNzVP?=
 =?utf-8?B?SzYzWStxQXpNZzJHUVRFbVprN3VWeXdpLzYrMFhoQytmQnRvWVhUZ3ZUU05Z?=
 =?utf-8?B?TXpCUkJvT2E5TlVqd2J2elA0ZWpTUDFvRy8xN2dhTUFLTkUrSXVKVGpYU0Ix?=
 =?utf-8?B?d3FmNXlWM0FuQ0l2cU5kS211MTlNaW1NTDVZZk12NUczNWRYRHJtbkF5dWc4?=
 =?utf-8?B?TThzVGN0SWp4aXRsc0xla3hPM0M1OTUwZGxTT0xMbkNUMTRuWjJJYjRZSVMw?=
 =?utf-8?B?bWxhMVN3eDh5VG8zU2lseUVHNkNoTmNoQ2RHaGZQa1QrQ0kvdytGSzhPYlFB?=
 =?utf-8?B?MUJNYW9CZWplRW1lOHJVUksrb242MHdlbzJUVFRjWlNwRlVxUm1iSlUwR2M0?=
 =?utf-8?B?bCsya1psSFRmc3ZEYUF0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cldSN0Zmem80a3FqQkU4RDJySjdTRXhpYkI0eGY2K24yekJFYW5QVjhsd2ZW?=
 =?utf-8?B?b085MjR3Z3FBNk16d0RXTzhDM3RkdThkMEZMRmZ2TzlzamNmaklNSVJSSGps?=
 =?utf-8?B?TmJVb0I3MHgwRWlJQ2tYbjJFbDBuOWQyelc1Y2FmVDdhL2l0MHZrUWlwRDRp?=
 =?utf-8?B?OFZwK0thRGZVbTFJdzNJcWlQWE5nQUpIVm1ET0l4WHd1bVRjdzNQbHFQSFZh?=
 =?utf-8?B?LzJJVHVJaXhPc1hXOExORCtmQzFEMi9FOFhNRUhkd1MxeHFaY1hpd2ZhM00x?=
 =?utf-8?B?MDJaU1kwTDZKbmVRd3pyUER3VHBXSUVNTnVaSW9GWUJJVDJhakVQRmRITSt2?=
 =?utf-8?B?TlV2YnNzemdaNFU4RTZrSjVQbW9XMCtSdHBQWUdkZDRWSFYwR2tQR0FGRVRl?=
 =?utf-8?B?SmttWVdpYVJzVEExcnl2TXNlQ0JEWml1cHQvU0x0U3JteUdSUVloalJITnFV?=
 =?utf-8?B?TDR1WSttVW5MY2VhSnJkM25pVnRmRnNpZEU0MVRMSGRLVlY2azBoTmlHQnFJ?=
 =?utf-8?B?aWR3RHQyV3hiYVZHUGMydlFoRWxpcElFSFFuakxNcVk5TC9ZYWVQNVRuTm5F?=
 =?utf-8?B?UUlsbi9JY2dqdGo0TnRNK3h1ZkloODBSRzZkRmNSNFFEeDl0a3VtV01pTmph?=
 =?utf-8?B?cTJFOVJLWDkzM201dDFvVnZkcFFWNHd1dkZvSWJ3bUxvUzllVFpXeVEzd1Fq?=
 =?utf-8?B?d1N5VnRubXJ2V05sNUdjYk55cXpUL292WEJ4QVpScm5KMXNad245Q0lONzVK?=
 =?utf-8?B?bWNaOVV5dWlYT0pWZk1USEVRZzQvQ2lYMFZnNTg0MExZRm9EVERFYzhrWkoy?=
 =?utf-8?B?TG9TLzF3eDIrNDVmUVJXZE54bjM3cTJOY0J4YWloNTRqbFlHcWxXY2h1enpP?=
 =?utf-8?B?NGdQdlJBSFhQcytVVTgyWkpmdWxVNU1QUVlTam8vczljNmJuV25RdmFGNnow?=
 =?utf-8?B?VmdNdytGNDJHVm9WczgzckFuQytxNjhQOXA5Q3cyY2tuTUw0NDh3dzBJRHJ5?=
 =?utf-8?B?L201QzRpdjRyNU1GTW9aMGZMblZpanR4OTg0YmlUQkZMS0ZPY1djSDcxajNu?=
 =?utf-8?B?dHhncEJpaHJaOXcvNkFNbHducXgzNzAzQ1YyaVVMVVZLZU5DZnpZYjlVTVoy?=
 =?utf-8?B?QnVXaDVZRTd3eWd6ZEwyY21FOExRYTBZa05mUmpqZklxME42SFNIZ2RYR25h?=
 =?utf-8?B?VnJsTG5OcmtHV1BYZXh1NGN4T1pGTXNFNyt4cmNHRGRuc3dhaStUdVR6Z2xo?=
 =?utf-8?B?bll2eWI5QjZSRUNOQ3FZT3ZXR3FGWFNXTmRCcWhBa3hrSXZ0SmVRVTZxL0t5?=
 =?utf-8?B?L2xycXUvdGttcGplNjhSNEZvL0xnYkQ0V2lTRnhwL3YyV0RYZ2tDbkp0RzMw?=
 =?utf-8?B?a2o5dDVPY0d4WGxSUDNqNjl1YUdjZDNsWHkyNUY0YmI3SlNWa3IwbDdZenRp?=
 =?utf-8?B?OVp3aXNaQmNLTHNGbThPVEtYaEM0VGNTOCtNc3d1dkFlNitiNERaRURETkJj?=
 =?utf-8?B?ekcveUhFWW42dWVFVGsyeDFNZUUxSkFJdWduU3Q2T1grSlNYeDhZekpLUExy?=
 =?utf-8?B?RGVmbldTWitDR3Q0amZsZnNJc3ZCM2VJSlBxM2hwRWVWS2NiZUZyWmxHTmVI?=
 =?utf-8?B?a2xhVlF5YUZTQ0VvZ0IrQTQwc2xubWhockgvb0xvaUdFdzFFZWIrcnZRSWJT?=
 =?utf-8?B?OGVLZE1ZaVJjWUxFUUpXQy9FbkFlOGdOa2xQRGhWd293SHFlTG9WYVFiOThX?=
 =?utf-8?B?cmZlQUtXQ1NPaUJ1SDd0ZTk5QlJEWDM2VDVBbjlwREtmOU14Nm82MTZXYmpx?=
 =?utf-8?B?bWZRRFhudlZYU1NaeU42L00vb0lKTSsvQWtQZ0xtODJWU3hvZXlhSW5vTDBh?=
 =?utf-8?B?bEZYdHBqMFRRQitQdVBHbWw2SDR1NSszOTJVb2p4TXZkUHR2QlpybmVNMElJ?=
 =?utf-8?B?bnlJK2dOcnNGTzZMSWs0aVJDQmdRajMxczlNdHBoSmdpWXdFTU91b3FvcGhL?=
 =?utf-8?B?SzVVbEZRaUEwV1k0V2h0OXk2RVRaZWFNSVBZTTR5SmVWTXdEOUlxTW04Y2Ns?=
 =?utf-8?B?eHJQOHJMM05laUozbDlYTnhRT1VYUGZhbWNzSE9FTDI0YllFRGJlVmlJd3g5?=
 =?utf-8?Q?T9hqSmj3BTlGsFNat1lV19d2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7640b4-6f1a-49ec-74b5-08dcd4a58949
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 10:11:02.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDHfEbSSz3j6MxMqakaBrW0HqY5OeZgBETl1NPVM/CrL5A8GCIHfSZkj5ynO1HbwJvqBPQCN9Fp1vOdM44UCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784


On 8/22/24 21:41, Wei Huang wrote:
> Allow a caller to retrieve Steering Tags for a target memory that is
> associated with a specific CPU. The caller must provided two parameters,
> memory type and CPU UID, when calling this function. The tag is
> retrieved by invoking ACPI _DSM of the device's Root Port device.
>
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>   drivers/pci/pcie/tph.c  | 154 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-tph.h |  18 +++++
>   2 files changed, 172 insertions(+)
>
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index 82189361a2ee..5bd194fb425e 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -7,12 +7,125 @@
>    *     Wei Huang <wei.huang2@amd.com>
>    */
>   #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
>   #include <linux/bitfield.h>
>   #include <linux/msi.h>
>   #include <linux/pci-tph.h>
>   
>   #include "../pci.h"
>   
> +/*
> + * The st_info struct defines the Steering Tag (ST) info returned by the
> + * firmware _DSM method defined in the approved ECN for PCI Firmware Spec,
> + * available at https://members.pcisig.com/wg/PCI-SIG/document/15470.
> + *
> + * @vm_st_valid:  8-bit ST for volatile memory is valid
> + * @vm_xst_valid: 16-bit extended ST for volatile memory is valid
> + * @vm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
> + * @vm_st:        8-bit ST for volatile mem
> + * @vm_xst:       16-bit extended ST for volatile mem
> + * @pm_st_valid:  8-bit ST for persistent memory is valid
> + * @pm_xst_valid: 16-bit extended ST for persistent memory is valid
> + * @pm_ph_ignore: 1 => PH was and will be ignored, 0 => PH should be supplied
> + * @pm_st:        8-bit ST for persistent mem
> + * @pm_xst:       16-bit extended ST for persistent mem
> + */
> +union st_info {
> +	struct {
> +		u64 vm_st_valid : 1;
> +		u64 vm_xst_valid : 1;
> +		u64 vm_ph_ignore : 1;
> +		u64 rsvd1 : 5;
> +		u64 vm_st : 8;
> +		u64 vm_xst : 16;
> +		u64 pm_st_valid : 1;
> +		u64 pm_xst_valid : 1;
> +		u64 pm_ph_ignore : 1;
> +		u64 rsvd2 : 5;
> +		u64 pm_st : 8;
> +		u64 pm_xst : 16;
> +	};
> +	u64 value;
> +};
> +
> +static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
> +			   union st_info *info)
> +{
> +	switch (req_type) {
> +	case PCI_TPH_REQ_TPH_ONLY: /* 8-bit tag */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (info->vm_st_valid)
> +				return info->vm_st;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (info->pm_st_valid)
> +				return info->pm_st;
> +			break;
> +		}
> +		break;
> +	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (info->vm_xst_valid)
> +				return info->vm_xst;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (info->pm_xst_valid)
> +				return info->pm_xst;
> +			break;
> +		}
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +#define TPH_ST_DSM_FUNC_INDEX	0xF


Where is this coming from? Any spec to refer to?


> +static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
> +				  union st_info *st_out)
> +{
> +	union acpi_object arg3[3], in_obj, *out_obj;
> +
> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,


Again, what is this revision 7 based on? Specs?

I'm trying to use this patchset and this call fails. I've tried to use 
lower revision numbers with no success.

FWIW, I got no DSM function at all. This could be a problem with my BIOS 
or system, but in any case, this should be clearer specified in the code.


> +			    BIT(TPH_ST_DSM_FUNC_INDEX)))
> +		return AE_ERROR;
> +
> +	/* DWORD: feature ID (0 for processor cache ST query) */
> +	arg3[0].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[0].integer.value = 0;
> +
> +	/* DWORD: target UID */
> +	arg3[1].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[1].integer.value = cpu_uid;
> +
> +	/* QWORD: properties, all 0's */
> +	arg3[2].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[2].integer.value = 0;
> +
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = ARRAY_SIZE(arg3);
> +	in_obj.package.elements = arg3;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
> +				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
> +	if (!out_obj)
> +		return AE_ERROR;
> +
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		ACPI_FREE(out_obj);
> +		return AE_ERROR;
> +	}
> +
> +	st_out->value = *((u64 *)(out_obj->buffer.pointer));
> +
> +	ACPI_FREE(out_obj);
> +
> +	return AE_OK;
> +}
> +
>   /* Update the TPH Requester Enable field of TPH Control Register */
>   static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>   {
> @@ -140,6 +253,47 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>   	return pci_write_config_word(pdev, offset, tag);
>   }
>   
> +/**
> + * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
> + * with a specific CPU
> + * @pdev: PCI device
> + * @mem_type: target memory type (volatile or persistent RAM)
> + * @cpu_uid: associated CPU id
> + * @tag: Steering Tag to be returned
> + *
> + * This function returns the Steering Tag for a target memory that is
> + * associated with a specific CPU as indicated by cpu_uid.
> + *
> + * Returns 0 if success, otherwise negative value (-errno)
> + */
> +int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> +			unsigned int cpu_uid, u16 *tag)
> +{
> +	struct pci_dev *rp;
> +	acpi_handle rp_acpi_handle;
> +	union st_info info;
> +
> +	rp = pcie_find_root_port(pdev);
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return -ENODEV;
> +
> +	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> +
> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
> +		*tag = 0;
> +		return -EINVAL;
> +	}
> +
> +	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
> +
> +	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
> +		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
> +		cpu_uid, *tag);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_tph_get_cpu_st);
> +
>   /**
>    * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
>    * @pdev: PCI device
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index a0c93b97090a..c9f33688b9a9 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -9,9 +9,23 @@
>   #ifndef LINUX_PCI_TPH_H
>   #define LINUX_PCI_TPH_H
>   
> +/*
> + * According to the ECN for PCI Firmware Spec, Steering Tag can be different
> + * depending on the memory type: Volatile Memory or Persistent Memory. When a
> + * caller query about a target's Steering Tag, it must provide the target's
> + * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/document/15470.
> + */
> +enum tph_mem_type {
> +	TPH_MEM_TYPE_VM,	/* volatile memory */
> +	TPH_MEM_TYPE_PM		/* persistent memory */
> +};
> +
>   #ifdef CONFIG_PCIE_TPH
>   int pcie_tph_set_st_entry(struct pci_dev *pdev,
>   			  unsigned int index, u16 tag);
> +int pcie_tph_get_cpu_st(struct pci_dev *dev,
> +			enum tph_mem_type mem_type,
> +			unsigned int cpu_uid, u16 *tag);
>   bool pcie_tph_enabled(struct pci_dev *pdev);
>   void pcie_disable_tph(struct pci_dev *pdev);
>   int pcie_enable_tph(struct pci_dev *pdev, int mode);
> @@ -20,6 +34,10 @@ int pcie_tph_modes(struct pci_dev *pdev);
>   static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>   					unsigned int index, u16 tag)
>   { return -EINVAL; }
> +static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
> +				      enum tph_mem_type mem_type,
> +				      unsigned int cpu_uid, u16 *tag)
> +{ return -EINVAL; }
>   static inline bool pcie_tph_enabled(struct pci_dev *pdev) { return false; }
>   static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>   static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)

