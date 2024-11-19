Return-Path: <linux-pci+bounces-17072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4849D25CE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E321283CCF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F11BDABE;
	Tue, 19 Nov 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VCOCPKVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133840BE0;
	Tue, 19 Nov 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019387; cv=fail; b=pV0WXTuE3dZS5i/XaMp7VVA//oPn1YFBY6Ke1D2ct/19z0GsZDBbj7VDJAbbj1iL4+2MWIQJUQvD2WD8SG5QlBVj2vvS4CTw0kR5I8nOHMZWIklA1yYkoJufurnsBeh0PYHKv4dvbQKvtJHzVz3pLmgwLDJMBFJeDzhmC3ZMphA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019387; c=relaxed/simple;
	bh=IIT2B5cheG+MBnPZeeAEDPk0+M1p2Qq98wMNbg/jOQk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TphbfidvhsQcqGanrDVV4lOoOesuMuq2z5ucYwUK6Wd09orMNoBSNy7NCIzBqCXyXS+/CJKDG3Qjl46YbNElbGaOtXM3dlu6rYrjelH0SKm73Nx82y+n/PTlCUonOU9yyBOAyNrhhtgipS7Sj24VEoL2nshTDJCPGD3/I7oDO08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VCOCPKVZ; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnbiqSj3HGhuMx2xdNIJcLpquHH7y+5U4B9Ecqgg8jZeu9AkE6onSwuiUAO/q0w48YzW4LBb0G6RARTnZJhgFL80f9Ip798chu/sWqoEajB5n1l8IzGaW0e1S8prZGwsrzlRplKKBRHVQ2n5sP5jevt+mF3/xsk7TEj+72pgQTbCsf7Ao/BfULNToI6Lr+RVldixRY9JBaMErSZRlpOl/sO9qvnK8ozFuIMa0k0QoWz8zZs/djvgRKQaX2ITsOOh3Y9rGWkZh7Oz+7YYOKivSpVrE9/pThaqTwj15ScDRTxUgvGcCY+6ix5ad2pQvOvfLUC9uNzc7GCesRSRgv0G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8yyPlDXDNngH4y254EN6UFnGFyyi0ApI0gtOCemFvU=;
 b=wBzqmx4x5DQ/Rj1OVKMMBEuWKaP903iybBMXwO9AgY/vxtcy9dIhZalAxGC5rE3E0tdd7EVCmeK3ogBdJZvrjAHoT0w7m1jX+JBNIWBCm+fBSCXpl9X1tmyl6wI4h9BnQZ3Rp2ix2UIMkZWPM0W8xvrKxNHakLRnw+AAqMO+o+E1+lMR8f8DoO6y6C5RmxJtWNiSI0+8NXmKhn/lo3AF/3O9yt4rIXFulig++DX5/K33rZPIoQi5Txfdp67ysveRfDmK5Iv4lN0KfWV+niR4VFB5bxUj6ZNu17IhZtZ8O7f7o0BObiYq2EOUNAkmAjcA3uPoZ5/E7Y+JqxsALTJ6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8yyPlDXDNngH4y254EN6UFnGFyyi0ApI0gtOCemFvU=;
 b=VCOCPKVZm578IX1oRx6QVnXvRhRmbRjwgdiR5/fgOHHwt5p91Wa1OKe8MrBAtHgNMvDOTkPsJQXAwY1+XBKdRaYbxHTtdShpTmLYP+FcG44PVyz0RIgcshaRY46OTUxaZu7VwVX6DAqhAkndvHYQOQS0hoeibVOnkySBlCXYvwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.15; Tue, 19 Nov 2024 12:28:53 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 12:28:53 +0000
Message-ID: <e1f15720-1ec4-445a-9e72-a1fb0c4b7923@amd.com>
Date: Tue, 19 Nov 2024 06:28:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
To: Li Ming <ming4.li@outlook.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-9-terry.bowman@amd.com>
 <VI1PR10MB201647BD9FC20C8BAB8F4A90CE262@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2016CA9B2CE19DE49693794FCE272@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <VI1PR10MB2016CA9B2CE19DE49693794FCE272@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: a141fcd5-15f5-407e-6a27-08dd0895ba94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmVLa0JPUjZpeVU4K1FOcHh1Vy9QU2dLTUFxNjFCYzR5Q2NqRWEwODhqaTdi?=
 =?utf-8?B?ejRGNEFLcjNtWFdacnc3eDhvbGFpdlF6UVgwSHhHa29YS2JuV0JhSFpZWm9X?=
 =?utf-8?B?RWJPU1lZL3ZWYm9xTkErd3N5Q0o4QUNIWnUyUDI2clRuWldkQ012Q0dWTmMz?=
 =?utf-8?B?WTF4Wm5VckVMT09MOVRGS0xFcmxiUFVvRUprTml0TTdvKzIyVWVSakVYTVRk?=
 =?utf-8?B?eng2Tit6emlXbU1SUGJIckpIenB0WXJEemVhNzd3RUsyaWZJaHp0RnA4UlNi?=
 =?utf-8?B?bWVranJoaEFXdDl0UGl5eGlHM0I5RmJOYkN1MmxHTDV3bWNDRS9ySzlURU82?=
 =?utf-8?B?RzcwdEtZWWI5L0IvcHJqMGN5REVlMkJFWUthVjZJeGF5bjd5V0VKRHlWUllJ?=
 =?utf-8?B?eVlMZFYxb0tvTHp2YWk3ZDlJczBGZ3Z2ZkpSQ2Nxa1BhZW44M0UrTUNvakxG?=
 =?utf-8?B?a3daeGFoU2xYbWhMVG4rdG4vMDZJUm9ZNm15UVc2bWVrYURXQzl4bnFSQmhY?=
 =?utf-8?B?LzVLUm1ZdGNCQXhLdEhqcXhmNjI0TTNPUys3RnBkRUdhcVR6R1B6WUV0M2U0?=
 =?utf-8?B?SGtValdYN0hvYkUwSE9EMEttbFFlWW1oaFg5Nktja3l5M3VUY3R5TTZ0T2gx?=
 =?utf-8?B?R2RqZmkzZWkrbVQ2OUJYZEJMb2M4OUhpL0MzVVVmbUVnL3ZvWFFWM3NDNXZC?=
 =?utf-8?B?TzA5YzM1dzA0WnRHZHYwVFErY1N2b0NscmRwMWhDdzBzSWlEaUFJMTc1MHpY?=
 =?utf-8?B?aGVNY1ZWK0pWYlJsdDRXeERCS1NzRk93UzJKYmFwRFArWnc1V1Z3MVVsNU9B?=
 =?utf-8?B?R1dQMmdYd0lFNUEyV0wxL3QxQ0NEV01vOFFnU25Vek9YYllGZE82a2JvU3Np?=
 =?utf-8?B?OU4yWEJGQ3ErOUV2dmxLYjRGd3FkVVh3QkE4bUx6Z2VuMmViYWNNdmlwUWNs?=
 =?utf-8?B?M1I5YmhXQTRrYjUxdHk0WEdoT0djVEUxeE9aYkZ1K0JCOFVFaURDaUpLQXl3?=
 =?utf-8?B?ZENjZWdVTUQzTWx5OGtOTTJJdHBQdUJpK0w3cTZRZFJCaytGWnhSK0RaNitK?=
 =?utf-8?B?WXFNOUgvNnRHNlFadHJVUW1pVnpRZVh3Um8yQm4zMThVYUtpUkN1enJyRC9Q?=
 =?utf-8?B?V3FzWFIwemE4aURqWkpLUmd1Wnh0NjRmOGYxcWhLSTNhMldVb3BpUlFaRXVv?=
 =?utf-8?B?WTlwckNEekRkZXhibHR4TVRIdlUrVzMzSGhtWTBtbm5wM1NKOC9PM2EzNGhn?=
 =?utf-8?B?anp1NHZubjdwckhuN3cyNlBEQ2d6UzB2YTNqT21yRUJ0MmRJYXkrQU80WUgy?=
 =?utf-8?B?QjdrSzNXNmJBemtDZS9pT0w0WVdiaWt5LzRlbVNCc1BsOG5OR3IwTXlSRnA3?=
 =?utf-8?B?MC90VjgvS0lMTm9aV2RFbllkU29hZFByMVIreFloaGZ0U1lCcXdvRkJ0cDBr?=
 =?utf-8?B?a3lZWVN6cGFub1l3TEoyQjlUQ2pubGNyU04vbWxhanVBdjA4aGEwRjZOdWh5?=
 =?utf-8?B?Zms5UzQxTk1jRHdBWDVQazdHWERTUjArR0JVMEZBMzNoTW0zeElBWm9lMVFr?=
 =?utf-8?B?ckhmRk9UZFlKL2pCRnR1cGZFaXM2OGFTSFFITjk4TWdSMXhsczV0NUp6VWdj?=
 =?utf-8?B?RDRkY09nMXNZVE1naWQvZ0RZTENLOHdxeFdoemV6VjEvbEF4M2lYRFVOUXJU?=
 =?utf-8?B?UmpWSXdGOGlDZWptNlhKQXZBbjZnYU9jaVNxanRiMlB0YjlocVFiNjVDTjFU?=
 =?utf-8?B?ZG0rK0RxZFBBWU9oQmF3eVlvMHp6RDR1ZVJVWDUxZFNvTTdhR1lKdGFMUWcr?=
 =?utf-8?Q?i+icb76fCWnkENuorPmgNfVFvtI13voJ9PHEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3Vlbko0OFkxWEdFNWQyRjJJdEt5UzVINTV5OUJRNnhOMitQS3RKb3EwRENR?=
 =?utf-8?B?RG04YitjM0pnZjZHSUtJVkVYdzZKWWxCTXMvOCs2bkNVZVY3elpWVlhNd2V3?=
 =?utf-8?B?aFB1VmRuZmVqVmhxT1dkWmZrcnMvTWhNczcvdlhwVGNxM0JDM2pobmdmajk3?=
 =?utf-8?B?YkIydFdwRnNXbUI0a1VNTkNHSDNaK0lLdFpLUDRoU3lBam5yenh0TDQxTWNX?=
 =?utf-8?B?ZXMzcUVjTjloK25KY3RwUjdIODkyRkVVd05MQkxGUlA3UTlaYUpqbGV0TnNk?=
 =?utf-8?B?S3Y2eTlUeVBrK2ZnQ2VBYWMrN1k4VDViTERKbkdDeStIcGlzR3F2aGpIMFFR?=
 =?utf-8?B?UWFNQk5FS1ZXOEl0clNGM1NtRU5GWElPOE1ReWl2eEV2bFl1UVZyL1lyenh4?=
 =?utf-8?B?akhrNTFSMkRCNk4wNFdQNmhyNURRcEE3TDIzaG5UdVBoaDRobmJwejRabXZ0?=
 =?utf-8?B?QjZzRkU4dm5uYTlmRkxwSTRtbm9tdHpVb0tJRXdjRWttUzBxcU0zNnlwcnZk?=
 =?utf-8?B?UXV3eHFRblphbzJYVmlpR1lERy9HM0lOMmNHMGZxcDJESFJxUTdiL0s1SXFz?=
 =?utf-8?B?ZXo5SjVtNllFNUdqZEpRQ3NqVU53c29pWFpLWVVKZGlwMWppK2t1YWRkcXVK?=
 =?utf-8?B?RGRDeWk5dWovNUY4cGUyMDQ3K3Y3cHkzd0Z3dmZJZ1dqeFN5YVlOK21Kd1dm?=
 =?utf-8?B?WnVrMDVYMzE2ZDdDQmE2WTdkNnBIVEsxRUpzRlBtVjdLcU5zL2NFb2liR0Ir?=
 =?utf-8?B?WmZ6Z3JCdndHTDBJcGFweU5XcUFEczh4b3lycWUrNGEvKzErK0E5RDgyNklV?=
 =?utf-8?B?REZuUUUvTkJRWmVwNFlOby9zMCtkQkZGUmIybUhweGExakNrS2FMZm4wTlVn?=
 =?utf-8?B?bFBSc1hTUWg4NHFkS2ZqdSswWTY3dHFYSzNGb0t4a20xSVB4RURmcVJuMHF4?=
 =?utf-8?B?QzRKVmZ1bDVZWlFLVktMWTNTb0tjRENaZ1AzRVZ3V0Vqb1h1elUwejVSMDN6?=
 =?utf-8?B?QVRmT1ZaTGo2a0pTWEhiclhIcjBPaWdKeGRhR2gxQ2tiQW1jakZXWWtGa2ZG?=
 =?utf-8?B?TWYzc3lCTm5hbUt4amVMU0ZIT2cxMnhLczlQbmRZQmorVGJncGRLMEdUMkRR?=
 =?utf-8?B?WGoxSnIyMDdyVXFLcytiUkg5RlhoQXBTVmFBVmFMWWhtVVRUSTVTRjZoUjFn?=
 =?utf-8?B?RDRraW1ZbTlGTWYvNjFwQlRqakxkZW4zTG16SUNRMkZOUnMzUmQzUXhlU0xP?=
 =?utf-8?B?SnpndXNjdEZaOEFrUjJFSytBenY0aUZHV0VEcTErT0RuaUlhYUVVVUVFTHRS?=
 =?utf-8?B?Vy8xaHN5QmIzQ2tTeEhqdEFFQUZtY0N1UmY1MFlCUDhMYVBKNklMS0VMRCsv?=
 =?utf-8?B?Wk9zVU1vcW9ETG43a2Q5Y01CWXZUR2ZXbDBGaXQyZmxNaXdxTHRScnJ2L2xn?=
 =?utf-8?B?eVBlZER4OVhRTGNnTlhKSjQ1K2dJOTdRRGxBUm5qZVhVSFlSa3BxTW1ycVFV?=
 =?utf-8?B?Vlk5Q1ZBU2sxTkRxWTJQdmVDVjFxdjBJdy83N0RCb0QvV3dnQXE0NVNiVmxj?=
 =?utf-8?B?M0c3dDdzclZvU1FMMzgraUV0VXNYTjYvWmpsQlkvNExDOW4wSEJJRjBGVTZZ?=
 =?utf-8?B?SnZYaVhmdkd4SmtqT29taWxaRk1RRGIwWlFySHoveUM3TjRSTG9HbEZqNTgy?=
 =?utf-8?B?U1dYbE5WMk4waEdPRXZUaUlQWDVCOGRUbW51N2ZVY3EwZ3AvckJFMkFrTVYy?=
 =?utf-8?B?V0RzZ3RhTVI2R0d3TVNIdEg3TzFUUlRIb2VKaWZ1SHBZQkNnT0t3c0MxMkNR?=
 =?utf-8?B?ckMvSEVtVnBteWhpV01PbHgzVmlpeXA4eXVXdjJUUXZVM2wySDNsZjZDUlFm?=
 =?utf-8?B?QVo0SVFTS2U2bzdVYnN0RXVBQng1S3dyWTdRZnZPVk8zeWxVZ3krM3VzOUZu?=
 =?utf-8?B?TzI0Q0JZZS9MZ3NpTEx4bEtmdUQ0ZnhLYXBOcHQvNFllUHJCc0lIdFNCM2di?=
 =?utf-8?B?anJsY1ZmVllTTXoxUnVBVEk4NTY3WGpURFgzdEtuYjJIMnRnMU5iTFRPejlY?=
 =?utf-8?B?Wk1RbmN3Q0dpaHppWW1XV3JiZ2J0VWVvYUtTUjVKN0txTHBXTWdwdmNzTktD?=
 =?utf-8?Q?XKyemY5zG7Tj6InaAbZoQDLnv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a141fcd5-15f5-407e-6a27-08dd0895ba94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:28:53.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0u/EbPHHeMvBhlXf6Rbcp1JMjLoGFmuQ5aRtZ/6zFLXxxxCLd6RQWpu2VxtfQT5KtLVayytiV1z5FBmGOLMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695



On 11/17/2024 8:21 PM, Li Ming wrote:
>
> On 2024/11/17 15:45, Li Ming wrote:
>>
>> On 2024/11/14 5:54, Terry Bowman wrote:
>>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>>> registers for the endpoint's root port. The same needs to be done for
>>> each of the CXL downstream switch ports and CXL root ports found between
>>> the endpoint and CXL host bridge.
>>>
>>> Introduce cxl_init_ep_ports_aer() to be called for each port in the
>>> sub-topology between the endpoint and the CXL host bridge. This function
>>> will determine if there are CXL downstream switch ports or CXL root ports
>>> associated with this port. The same check will be added in the future for
>>> upstream switch ports.
>>>
>>> Move the RAS register map logic from cxl_dport_map_ras() into
>>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>>> function, cxl_dport_map_ras().
>>>
>>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>>> the RAS registers for CXL downstream switch ports and CXL root ports.
>>>
>>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>>> before mapping. This is necessary because endpoints under a CXL switch
>>> may share CXL downstream switch ports or CXL root ports. Ensure the port
>>> registers are only mapped once.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> [snip]
>>
>>>   static int devm_cxl_add_endpoint(struct device *host, struct 
>>> cxl_memdev *cxlmd,
>>>                    struct cxl_dport *parent_dport)
>>>   {
>>> @@ -62,6 +87,7 @@ static int devm_cxl_add_endpoint(struct device 
>>> *host, struct cxl_memdev *cxlmd,
>>>           ep = cxl_ep_load(iter, cxlmd);
>>>           ep->next = down;
>>> +        cxl_init_ep_ports_aer(ep);
>> In RCH case, seems like another issue is here, I believe that a RCD will 
>> be added to a CXL root directly rather than a CXL host bridge, it means 
>> that no chance to call cxl_init_ep_ports_aer() for a RCD, because this 
>> loop is only for a EP attaching to a CXL non-root port.
>>
>> Please correct me if I'm wrong.
>>
> I think above explaination is not clear, what I meant is the hierachy 
> in RCH case should be this:
>
> cxl_port(root) <--> cxl_dport(host bridge) <--> cxl_port(RCD endpoint)
>
> RCD endpoint's parent port is a cxl root port, so that the 
> cxl_init_ep_ports_aer() cannot be called in that case.
>
> Ming

You make a good point. I will leave the original cxl_dport_init_ras_reporting()
but renamed. And will add a check for if RCH mode before calling it.

Regards,
Terry
>> Ming
>>
>>>       }
>>>       /* Note: endpoint port component registers are derived from 
>>> @cxlds */
>>> @@ -166,8 +192,6 @@ static int cxl_mem_probe(struct device *dev)
>>>       else
>>>           endpoint_parent = &parent_port->dev;
>>> -    cxl_dport_init_ras_reporting(dport, dev);
>>> -
>>>       scoped_guard(device, endpoint_parent) {
>>>           if (!endpoint_parent->driver) {
>>>               dev_err(dev, "CXL port topology %s not enabled\n",


