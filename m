Return-Path: <linux-pci+bounces-6528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D88F8AD4C8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D89281ED7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857CC155323;
	Mon, 22 Apr 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HCbvb6kw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3602EB11;
	Mon, 22 Apr 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813684; cv=fail; b=eGuRcls8dmnw1+ShGQ9zRZk4/I0xqyJOYDejhH7GAUPf/zDrDsbzchYrwSig6UAGDFWTrcSPw17WuPyVDo3QzbnTTVR5dltGT7CkP5rFhOmDGjbAcGo8TpI0PBntOC6zXA6qI4eqGcRuv5HX+AybVkdrFxLXcZZITqL++Ez9udA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813684; c=relaxed/simple;
	bh=bBfhVgEKJ5mxtsXS2ImeASGBckmD2VMJN2aG6TMx8n8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZ2OA6o9myzxp0+MZaXVgZ1ci0k3Dl18PftsGYMIyPQvHcqPNRHkGoifWXC1VACSSDJVj9bpHdSbCF+RM40db/74ZM+5tY7kWjm8dNHdvGqc4JTFfmirVAdVpvl8Twcy2J/ZLhWskmHdjIEE7QLIL/vrZBrnBaz2m5ddHBeKbTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HCbvb6kw; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkxwoUCwbhpjXYk2+oFa6Q8l4RgOwd7iSvkmFIYjo9aeBjBuAnTAFigruwrJUaKhAA0fOF3apU98rGzqhHJaZOnqKjCf+zrymkDaStzoSjuNBULTkpcasOa9R8iN/tzTUACMP1Kkb/lFGggwix5DRGzzmWj0bIsdTXJ+Ds004FNH9s65Q22uAHo8f5nYseqXaS5bAvCAetS5+cQqZPo74D+5XHo5aQtolRb4+wMNbZiOvunsc1dFDJl6jStdTapnwLYxwpQxqcgjCGM2fT2jOvSOfSx8kbEIWnpv8BLMokzZ+xBjJH6WixaGNt/HUMaDCoWJrKghcTEY+ouI7+nWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrKwOfDT94T8asINtpKGRLZlwb1w1+mljOfFVhUCE28=;
 b=PscWGSfEtTxvTDX0MJhV3KZv37rN0oh9OCuNzDnCLLypEHJjjQiITG9gshKuKSj7mfzjTYNqoRcSl8oiHAOyldFyeYrNvMiaUlF03IRd6F2XimJw/5FDSdY7gCTSpeNrW8sjknHrf69eucRbdXPumRTPTrCc/FYlrBRVvXcya5gEDMeFjq4Lj+72GsL8kzcHt9hfNQq/ee1J8DynX78MvvmOyFMj12qqWe9O7+frNMHoO3aZ0m9WxZIzIWfgtwPRMG7T78te+5gd18ca7KCz1hiMQV19fS7XLy+sL8fwRQdeEmdUEYEemUYsJYz2367/nD2uhR7HAoFlspcBWrnZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrKwOfDT94T8asINtpKGRLZlwb1w1+mljOfFVhUCE28=;
 b=HCbvb6kwTHwiyFQvNRJxaOpVHABRM/IDCLQrSvmONqEpOPmKh/H+1kErrsmlw+/yOn6il/psLvsXVROBrCxJ87GQBqeblA5OnPHWfEd/pINh9sZ0FcgOT7K34iAR3GgN8TOSqsjj9nb0DSOVe+133FgsnEPVreqrkJeU4+BqLHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:21:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:21:20 +0000
Message-ID: <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
Date: Mon, 22 Apr 2024 14:21:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Esther Shimanovich <eshimanovich@chromium.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rajat Jain <rajatja@google.com>
References: <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:806:127::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad24312-b7b4-427e-769d-08dc63016401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emdUbGxwdWJsSHplMXg4dEVLM2NJQ052Snkza2xzVm5YWXZCUXhjR0I0cGZn?=
 =?utf-8?B?RUprcFVTazBCaUlCS0FNTTl1YUExRkNVUnVvdkJidWRyTVljTE0yV2dhVEo4?=
 =?utf-8?B?cjRCaVlUZUVIS1ZYY0NadXl2c3RzeGs2UVcwc05sU01EOEJGZWtXRmVwdlg1?=
 =?utf-8?B?YUF0NjBTaGZPOVFhVURRcnNFM3R6OXlKaEEyK2NjSkhlN3dWNW1MdlJGbk9m?=
 =?utf-8?B?cXBveUt4eFdrL3pNbjFOTHZ2VWhvVGo3eDd5dmR6MEdoUW1FS0hydG40VWRt?=
 =?utf-8?B?QWw4ZyswcUFhOTJ0VVVnQmxJSEo2K3k2S1pCSGM0Yi93QW5POGtFYm4yUVA3?=
 =?utf-8?B?cW9pUG1sdyswdythaFZvTE5ISDB1T3hwVEZPRkNqOE91RVAveVE0c2l5NElE?=
 =?utf-8?B?RERrdzhHSE1FdGl0SVFFNVRjeWxpYnA0d2d4OUQyQklSS2dkclQxVTI0Zmtt?=
 =?utf-8?B?VWJUK1Z0RzE1Vm1xcFZiS2t2MkNqeHhMNlZmWVBBekY1VFZuUGpOS1hlSnNQ?=
 =?utf-8?B?QWdsdSt3Y0Z1VDM0MjVCaHBaU3BLUmZYWjJQQ2JuUEIzbU5ZazJSd09BMmI0?=
 =?utf-8?B?aitCRk5WaGFHb3VhbTZBOTFBam1ySlErTmlqSWsxeTNvd1k4bnIwRDNjU0tk?=
 =?utf-8?B?Z1gwWUdIQ2x2Y0NaVFlaTXhhN1pSZlhBL3ZOZkNqdm15UXY2OEgwaVJzcm9v?=
 =?utf-8?B?S1hMNGc0dmdKaFpHUiswL3lHekZPQW8wa056Ui9vMVJOSTVVaWVFcVZIMEFk?=
 =?utf-8?B?TFVWUERWQXc2MUlwOHF3REJML0JRdm51b2k3b0plUWY5ZHlpblBmc1NXSC80?=
 =?utf-8?B?TlpIOXlnVFZUeVMyaGRNYVUzak9OM3c0RnRRZDQvN0JzMC9BZThxZjFvd0dS?=
 =?utf-8?B?S252aFhDcGk5TS9PdlBOL1N6YnRnN2laYmUzMS9ObzB2VG9OU1R2cm9oTnhS?=
 =?utf-8?B?ZXVCaFRJeFFBc3Ztc3pMQlZSemNpTkFyNVhlcTdza1VHWVZDN3ZFLy9jaklj?=
 =?utf-8?B?Zk9Cb1M5eER4c0d2bTMreHJiNHdsTkhwU0Znd1h4Vm5pNm11THliV20yc3dY?=
 =?utf-8?B?eDF2b1V4SjBIMkFvQWZPeExBSjg4OVFCNjJmQmh4ejY4Y2ZCemdEQ215VVpv?=
 =?utf-8?B?andPZEZ0YUdhdkkwTkg3UXZVMXpiL3U2VzZla3pBTGYwbVdPaENZakxaVDA4?=
 =?utf-8?B?VEJ0TFNFbDU4cFJWK2g1aGdmRCt2ejRPVTBlaWxwcWRwWnVrRUc1Zk9VWERj?=
 =?utf-8?B?c1NVdS9rK2ErWWJ1cE52cG9RR0FqZUF5Q0lMSG9nRlJLb3NoelZ5NDgvVENT?=
 =?utf-8?B?eWFQTlJIcmdvNFB5d0FZOFA3SDFQUnI3Y0xrZFNYcHhwcUp6MVFaamNabTRD?=
 =?utf-8?B?NENrdmdjcVBGZk9YWE15ancyOEg3NzhSVE94WkZZbVRyQTFrWTdUMjdpeHVX?=
 =?utf-8?B?aEIvbzdwZ0c2a2JNeElIb0hlVWtqeUZQNnVzUFB3TzZjVnNWeU9XYW5WQS8r?=
 =?utf-8?B?amlWbjljM2hZSjVLZ3Vndkc4eXRKZVVSZENaTkgwa0ZFZGxJR0o3d25SaTZl?=
 =?utf-8?B?emdKZ0Y3SG5MSW1TRjJONXI4MjJyZkFTWUZDeGdxQzVHZUxlU2liN3BGTSsr?=
 =?utf-8?B?NDRjNWtONUFJQkhlbmkxblNUVFFMdGw0WkhqWnhrTng0Tmx4UGhTREN4UTIx?=
 =?utf-8?B?cHVJMGVPTzhObGs0TytJSkZncXFHQklPdWtjU2ZDRFR5R21Zc3Z6NmdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExjelBxUHFybjBpQ0hTOTc4NDFzVjgreFdqTnNHN3hTRkpjNCtDNjllY1Rm?=
 =?utf-8?B?QkRCZUFkWWZzUVkvRHduemtWZHBRMU5kZHhlUXltUjZYcGJ5SU9xdTc0d0lU?=
 =?utf-8?B?V1oxWmd4eEMrZ095UFN5QWp2NkZreFk0N1J0Z2hMcTVjeGdBcTFiMWIwYzFa?=
 =?utf-8?B?dG9BNXJZaHhmSzF0akxENXZOSk9GSy84eTlGQm5jakNiYU5OOENrM0FJa0R0?=
 =?utf-8?B?MDRLWC9Ic1RGRU9ZZFBIVGZKdHJXbml3SDJmM0ZROVNaM1d0anR4Qkd3Qjg5?=
 =?utf-8?B?SnFYZzdaem9ydzR1Vkgycm5yaXRvVHBLSW1UV1MraGtpMDRxelpmR1B2R3pY?=
 =?utf-8?B?U0s1WHU0N2h0RDhFWGJ2Wi9LdVN4cllMa1dKY1hlU0xKMlppOEFtOTNUTzNo?=
 =?utf-8?B?dGZRcnRScEZORkpoRWtnTWNzZlJrUGcyUXJLWmMzeDN0QkpvL3ZvMEFCZEJJ?=
 =?utf-8?B?SzhJUTJyNXRWWDE3MUpJYmFrODRhZTVKdjRiYXNESGQ2ek90MVZtUDFDTm9k?=
 =?utf-8?B?M3VyTWZIK1pUUTg3blJvbTZaYUkzSStEenA1UlZIMDJuUHNIM1h4Q1hVVzVk?=
 =?utf-8?B?UVhJOHVpc2Mvb3FXV0g1VHEzTUpMNjVUYnVkTzllRTFxTlFRODdCSCtlVHBn?=
 =?utf-8?B?L2NZTWNUaW1MOU5RcWZRa1dFZXJkK1RxNGpZd0dWdU0yVHBxeU90aTRLUDc0?=
 =?utf-8?B?YXlOL1hCU1VKcWZCVld5WCtDaVFiazc5aU5uYi9kZlN5ZHUya2U0VUU3SlQw?=
 =?utf-8?B?YTBsY3o2TU82S3A0T2RsRzlycTI2blVXVlEvS2x1TFU5a0J6NmczbnBtdmN5?=
 =?utf-8?B?M1ZIWUpPamhxZGlyZHU5WGx0T2VqRHNmdHFlTHF1S3g4Z1p5VGo5cVBLUjFH?=
 =?utf-8?B?cTlpL3QyK3RUUUJKV2FMSHl0NlltbVU1aHljdnlrWVpDYU1qSXcvMEVuL2Fr?=
 =?utf-8?B?emRITWpqamNUT3ZDd1MvVDRNNVdsbWgybVAwQ0REeFM5MWVhMDJQOHR6bVNr?=
 =?utf-8?B?ZDF1VFZSaFYxMUtOYkJ0VTE0aGowelBreEFRSkcxYkF6UGFLamludkN3U21r?=
 =?utf-8?B?N0d4eVRxcS92Q0taZFM5cXk1YUdSblNObENyRWJmMlJ2NStWSWw3WXNjMmVZ?=
 =?utf-8?B?OUhGL2pzd0RrYklISzdRNURpWDNQeitWb3J1NHFTbzA2SHRKb05RV01RYy9J?=
 =?utf-8?B?bjdsYUM1RjFmYlBwOFFpYjRwa2R2MGl2RVZOQ2JMeXFmRms3TDBtUGFZdmlt?=
 =?utf-8?B?Sk9mazdUeURXQ2NrME5pMVZrVzl6TGVaTW53OTlqeC9qQkdjOTRGamw1bG4z?=
 =?utf-8?B?OW9lOHVmeGxqTXdqNUdabGpUbWRqNHNLOHZmTnI3cm1MY0pSR29wa2ZnMUpM?=
 =?utf-8?B?ZWdBcVdhM3dSempNdTd6Rmp6M2xObmNUVW1qcHV6ZVdsV3BRRDZYMEEzVThX?=
 =?utf-8?B?RkNvYkZrbDU4QXlyR0FQYzhhUEtnMmpGeXVyQTRCbHgrWEFDaURIbXZ5Vy9S?=
 =?utf-8?B?OTlFSXNST0dILzNMWGkwMENQYUx5SlFvOS9tRkZuR29LbFlMd2cxdlFibXdI?=
 =?utf-8?B?WU9LczNYRi9hRVY5RUJiOHRvdVZSU0g5d1lUVCs3S21TNmNuZzNBUzVoRk9m?=
 =?utf-8?B?UG1FUGV6MVRDSElZektkVjM1T2h6YkttaDdUdUx6ZnV4dmsreURFSk5TQXlh?=
 =?utf-8?B?aytIZGFRcEZOelU0bk5FbWdPS05VTlFEeUdBR0gwTS9uZ0VCdGE4ekY1NVVE?=
 =?utf-8?B?b3U0bEMrOHQzZjZDNkp2cW1SbnVFNkxwVWlVRzZMVng2S1Z4eU9aTWg2YmRJ?=
 =?utf-8?B?UUJzN0ZxNkZ2eC9oOEhaaUFPOEZVaFZqUlVrNFlRRVIwQ0k2a0x0cHRiMXky?=
 =?utf-8?B?WFlPeHFYbXdXUHFwNTRUV2VPTExhRjBLTkNiNzMvcFM1R2lobUYwZnI3b2hU?=
 =?utf-8?B?a2JUZFVBKzZ0YmpMQkY4S2pDNm1BN3JMZk41RUljR0pCdEhWK3l3SkxKMFhu?=
 =?utf-8?B?MGRGUkZZZkVZbG1CajNxUVdJeDg4dXF6SloxY25sZlBJMEs2R21GMTdQR1JK?=
 =?utf-8?B?eUoxYWtXTUtEditTYVBRQVVRUndWaTY0SmJVY1ZPbkJDWXZPZVdFSlJ0ODBW?=
 =?utf-8?Q?eW4J6l3VKDvV5FqYcV0rzpwtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad24312-b7b4-427e-769d-08dc63016401
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:21:20.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2srkV5dhPRXCg5RWxi8IX1iq2Zqu/gWUdsfF2njbBNFXcqr3hWVOA2alyUfCWsWlMSqGnkXtE2PsRvjaVOXaNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

On 4/22/2024 14:17, Esther Shimanovich wrote:
> Thanks for the explanation! I still don't fully understand how that
> would work for my use case.
> 
> Perhaps it would be better for me to describe the case I am trying to
> protect against.
> 
> To rehash, this quirk was written for devices with discrete
> Thunderbolt controllers.
> 
> For example,
> CometLake_CPU -> AlpineRidge_Chip -> USB-C Port
> This device has the ExternalFacingPort property in ACPI.
> My quirk relabels the Alpine Ridge chip as "fixed" and
> external-facing, so that devices attached to the USB-C port could be
> labeled as "removable"
> 
> Let's say we have a TigerLake CPU, which has integrated
> Thunderbolt/USB4 capabilities:
> 
> TigerLake_ThunderboltCPU -> USB-C Port
> This device also has the ExternalFacingPort property in ACPI and lacks
> the usb4-host-interface property in the ACPI.
> 
> My worry is that someone could take an Alpine Ridge Chip Thunderbolt
> Dock and attach it to the TigerLake CPU
> 
> TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
> 
> If that were to happen, this quirk would incorrectly label the Alpine
> Ridge Dock as "fixed" instead of "removable".
> 
> My thinking was that we could prevent this scenario from occurring if
> we filtered this quirk not to apply on CPU's like Tiger Lake, with
> integrated Thunderbolt/USB4 capabilities.
> 
> ExternalFacingPort is found both on the Comet Lake ACPI and also on
> the Tiger Lake ACPI. So I can't use that to distinguish between CPUs
> which don't have integrated Thunderbolt, like Comet Lake, and CPUs
> with integrated Thunderbolt, like Tiger Lake.
> 
> I am looking for something that can tell me if the device's Root Port
> has the Thunderbolt controller upstream to it or not.
> Is there anything like that?
> Or perhaps should I add a check which compares the name of the
> device's CPU with a list of CPUs that this quirk can be applied to?
> Or is there some way I can identify the Thunderbolt controller, then
> determine if it's upstream or downstream from the root port?
> Or are Alpine Ridge docks not something to worry about at all?

My thought was once you have a device as untrusted, everything else 
connected to it should "also" be untrusted.

