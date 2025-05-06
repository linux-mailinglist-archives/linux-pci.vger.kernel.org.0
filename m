Return-Path: <linux-pci+bounces-27272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69328AAC094
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525F21C24196
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B226771B;
	Tue,  6 May 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lovfbexx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0C19F115;
	Tue,  6 May 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525519; cv=fail; b=pKbos3ESJDRLagtP9evI52AZWAIvB1kN1weEZWoCS5DHDfHNbrePUsKFE0EOMhRHeWxbRWbkX8x/dYKHw6YTNjc0QMpozbGkXrGw/k1ReGV5xqRIOv/r21jLGRYmtaFL0R/zKhEO9XLWZkMcIXIxFto6QkfW0wAukufIl6zdcLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525519; c=relaxed/simple;
	bh=dAWnnOcT7rdzwfykgWaeAvuxU8ggybnunRVR0YVRqas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMNSArV2t7isN2gm5eg0jQ2ZkOn9RVmoZk5mEesLm/lyNgVRRVogYi6+bKD7gqS9GnguaXYVbJJOfk4ftP3ENQGbxHMYDA9nUS3xmGh7JFmu4GrLhBpAhhHpO2kejeYTQDm1qw3vKREvVNrl6YlPfKIImZouZJQdoRGuGdU9r9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lovfbexx; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ2XF4Qln0WWfJdzCEl3klLrB5mAAtbpvpK77UA0waCaJNUmeNjCuT5hhBmPo/43OtAcuSWAsySMIHgT6Kpg5Fns4thyZYPtQ6DVlh3o7PEU//OU69hRDFMEnnPHiJjyfYEtzPbL9W6YH0nOlNH0wzFhFFpy2UvCKeN1k1Zsde2X7hgwIbGtfAVv9NXkRdocT5FWneqeF1llKm9xOGiWr0gSPX1JZlqwpv/yd0pcpxNl/1JFU6SngOLCFKO2R1adJ/BHan9tIIcPe2kVmvfe0y8AgOw3NGEQStAKX+yedOzd5hFjSJ755MYvJhMQOjinhtN9Hlkc/WIJm+v6+HbcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk5G2tkGiDoRaf/jv6zdwvDStjZkwTm3MCGE97BL7Bs=;
 b=zQk7bORcF75yAMLL5aPLYjEKaffzFlq8zN46oqUC57yrsnP3nX9Hz39yJ3wZEcACdp4kqUsYCaZ1jDrfvafLZZl1EoVA8WcAz0ANT2dCQrV+ZAOlcr5meJO1xtvqWoUxu+2JaryQtxSGHOG2EEwwWni8TDFMSdKYm1gxJ8qBo72klG/X20oXBWx4wLYotPtoYmby4UYand1N40xugcw5p7A/FaJu/aUmA/Wav51QX34Kuyi6Jtzk7OOsk6La2tLV3BWN47UsY7ZmvdUiIyjKk4pWHQsOfFNiawqP7ALQpn2LwTemzTRsdyyc0PCTaM3p8BDqmo/WEI0uo4VGQcs1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk5G2tkGiDoRaf/jv6zdwvDStjZkwTm3MCGE97BL7Bs=;
 b=lovfbexxbDIH5Jn0GyrdMCfPc2hdxHBUhhNRSdQe5R/aIkYOLxHKlnAX2dIDDJ9z7izcVCk9YjxvIIUQXOUVoycLPn040IlpFcoUiK1dksuWB3TCfL/amzeXnVVbzbM3dmxf/H+gwevdfx8pQBMtwAglqJleidaPQblyepSNvkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 6 May
 2025 09:58:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 09:58:33 +0000
Message-ID: <2915026c-698f-425a-9999-c903f4057bb1@amd.com>
Date: Tue, 6 May 2025 15:28:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250505211524.1001511-1-tdave@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7576b419-fdd7-45ac-5044-08dd8c848ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Skg4MXRJa2d3WXRIbk5NNkFIbUs4a3JNSjBqeUI4S1B4cTZkM01aTVVQb0hs?=
 =?utf-8?B?czIxeDN5NUpRdENvczZWaHpyV3JsL2VCWlV5ZnYvVUpoTWZhS0swOU1OaDd6?=
 =?utf-8?B?U2ZHdCt4eFlVRjJPNXc2dlVZK1RmTTROU3dDWW16SzlJaHZQUEJ6QlZMM0JD?=
 =?utf-8?B?c0NUMHRPelRwZEZBVkM3Szl2eHo5b3FKbGRjR2k5eGNreGdjTEMwQ3Q0bDNa?=
 =?utf-8?B?NFJ4UjBwWnpvZGZyTW00MHBQZnErRDBOTEpyVmdDeVZ4TkdlU1ZZYk9LeW0x?=
 =?utf-8?B?Q2Z5S2dxTlNxMldyRFJvZUtKWG81U1lnZnBjbTdmMGFwYlFkTm53a2xoeHBZ?=
 =?utf-8?B?dDdMUm9vdUZ5TGt0VDBpbi80MmkrLy82WFN1ZGlOYTZwR2FYaDhCQW1VdDhp?=
 =?utf-8?B?UzRIWWxHeXBSMTJjSDAvTG4xdjdhNHQvNm1IVWRlY3hsUFRkVkJiYTg0bDAx?=
 =?utf-8?B?SXducVFGOU5uUEhmT05YaXg2a2dBZi9VMC8yS21LUDFpZlBGMG9veGhxOUxW?=
 =?utf-8?B?OEpxUm5lUnNCZG4wTFdPV3o5NXpOQkNEaUNyamZtNkRjZXU4TnBDdUtpRXo1?=
 =?utf-8?B?Ym1md1JUWjJCQ3dDY1NNZklNU1hCTmVkSDhUdHlMVGlRbk9Gc25McW1IRmtI?=
 =?utf-8?B?dDl4SVFBOTU3U3VDWThLUWRxN0Y3QmJlblpvNm85Vm0zZjNoTkZIdW02blVU?=
 =?utf-8?B?OXNVSW9GZWJjQXlWWkVpNTdEei8rekY2UVluaUdqOTJaK1U2U1NqRGJpYmJN?=
 =?utf-8?B?WjdMendWejNHamxBRTZSNHJ5dy9QYWFWaWRxS0lsL3hvM1pSRFYxTHp6cnRB?=
 =?utf-8?B?b2lXOHdJd211SWgyOUFycC9mcGh1U2RDcnpKQm5NL2dzV3dZM0J4d0JSdmo4?=
 =?utf-8?B?T0hkQ3o1VG96NUZRa1V5TWl3VURpQkJoYzZGZ25WdzRydElCcVh3cnhPOUov?=
 =?utf-8?B?dWVXSlVLL0JRZTN4aXdoaVdxVk9QSFY0U1F4UFBTaEJzSTJ3WmhuUUZaNTda?=
 =?utf-8?B?TUY3SW5PWU1CcXMxYzJvN3QzZzZCTTFTcmhDZHdUbHV0VDY2OUw0YXlhOWNu?=
 =?utf-8?B?amZjaDJZSjloaGNzR2pwREQ4dUQyTWY1U2xNc0JESlRQNnNFbDc4OXZaejg2?=
 =?utf-8?B?TjJWaGdnaE53MDRLdmJpZzBxbis4OEJjVXZzU3pJSzNtWllqQzJHSU5xajdE?=
 =?utf-8?B?allTeXRnbWw4eWcvWU5ySFNrY3lndUFFZFQ0UTZhS1pMUW84eWdLUXpNOTdS?=
 =?utf-8?B?Z0hZYVczT21uVzRJa1V6MEFEMGNjTWJmZVpUNURrSFNVVUlxeXBFK09sQitS?=
 =?utf-8?B?Vlhqd0VxWTlmWHRlOTVPOUp3bndEbVlyaVJZUjAzU0hnUWw3cFlGN2oyMEpR?=
 =?utf-8?B?Y2NDRW43MWZSY2JzTmhVZ3BSU1VKazFSYkVCc2VRejRnL3N5TXFZc2dyaVRZ?=
 =?utf-8?B?UUtTWjdUbndnUGp5NDkwdStBOGJ3YWFGeG8rZ25EQkVkbDRLV2hPbFBwZkFP?=
 =?utf-8?B?a3RRSXhBd2tQbzhLS2JHT0ozNENSV1FxOHFEeDh6bC80enVJbnNDaldwVFNX?=
 =?utf-8?B?U3E2V3J4cGc2QW1ONFdJM0FMQ1ZZdHlOK2YvUXlZWUVLdlY1dVFnTytQdjU3?=
 =?utf-8?B?VU1QWTZkVFphMHduNktENW1wV3pxL3o3K3VtQzFCMFJmWnRoVFhhbkhHa2RG?=
 =?utf-8?B?OFBPK2RNdndpR2plWXh5Y3lKd28wakhMS3dFOUxNblNtMXBwcytVZlUyOG0w?=
 =?utf-8?B?RHdqR20xajA5OGExbzRPcVlFbmV6SDllbk54MXBuWUVUa1NwZyttTnh1U21J?=
 =?utf-8?B?RFI4a3dtVVFrWlNxS21iU0UrVjlxakl2RUVIUFEzcm1uZnBUOHpHK1Mwalh5?=
 =?utf-8?B?cURDdDJQbktpdzZqVzZZUktHZWc0YTZWbjF6NWo3U21lYXQwRzZoTFpONk5y?=
 =?utf-8?Q?+8vvRAwU2wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0wrdlY4MDZJTldSdFBxZjI4M0FqVWdqYk0rTWlqM2x1VTNqT0l6bUJOVjU5?=
 =?utf-8?B?dFI4Y3AxOGVHMTlrOTlpRC9BNUdFeWVONGFUaGRsY3owQUZER1h4K0lVVmJt?=
 =?utf-8?B?K24ra0tKNU1hYzVQejMxeWF1bEtoc0puaXVNRzhtMFV2NjlCaCtnZWkzSU9r?=
 =?utf-8?B?YkFJK1cybUVub2E2SWZ3OUVOSEluN2lIb0lyMU1tZDl0RW1vRlROQzVrSWsy?=
 =?utf-8?B?ejhEZDdyUzF3R2p6TzBkd09EZ1QyMXRIOXo1MFJJeE9YZ2o4K0s1MjZxSUh4?=
 =?utf-8?B?VkR6eDY2OGM5b3J3TStCZDFGbEwrUk5sc1AzWHhiNjJLRDhIVWowbGloaVA3?=
 =?utf-8?B?SFlYL3hVWUtSbXg2dWZsSDRpdTdURFhRYlExTXd6cVYvVFY5S0pZcUlXcS9j?=
 =?utf-8?B?bEtTdjZDWDNHc2hGS2p0enFZQVh1eHpaV3ZrUTdiakZXV0NBL2paRndFV0Zy?=
 =?utf-8?B?cUtjQ0FjOStodWF2Q2lWc0dQUTdzdDZ5MkFKRHMrSTNCMmVaWmJqMURqS1dr?=
 =?utf-8?B?ZjNDZTNxdHl4dmUwUENKdlRiM3BqcDNOOUk2OEpUaWxacnRwY1dGdjQ3S0VQ?=
 =?utf-8?B?ZnA3cC9wSUFFUCtwYzNicFJWeFlCT0dyVXZTcHNPM2xYSXpCc2FXaEYrNXpV?=
 =?utf-8?B?K3JidlNKNHlmT1lmMFFIN01RR0I5bzNEbTUwNEZud3dVMm5ZODB5UDJUaEJG?=
 =?utf-8?B?Ynh4MzJMTWVEa3gveXFsMXRPSnI1ZGltRmZ6UmVDN2h1U3g3N2lKaDBRbXRL?=
 =?utf-8?B?SFZTLzMzR0tic0JOTUFHVUxBQllMS0FTaUlzdHphdmtmdm9GNmpYbmRHYzc4?=
 =?utf-8?B?VXhrUDFYMXUzTUEzVTFtYWhvZUlzSm9vM01tYjBscElYUmZTSjhyRXRYdTJh?=
 =?utf-8?B?M1dTNVFRTmZYblRoZ1BCWU9QQWxkK1F4UXU0UjgvbkRQdU92cUJ6cFZRTERu?=
 =?utf-8?B?Y0g4TFJCd28xMXZHdnhGUVhNa1owYlNpMm4zM1NqVFNvMXlRSVExQnprMWdh?=
 =?utf-8?B?dG83YWlRbWNZNWRUVGlvdnp3bUZMMEJiYWd1YjBpbzJaYnhYQk9Sc2o0aElO?=
 =?utf-8?B?ajl5NGdLRk41bi9zNXdQZnJRQS84ZTRuSGxJd0JucnRzenhiTUlwWXVPYmVm?=
 =?utf-8?B?RzY2bkcyRzhNMVJVUGtvQ3kvVUtQOGpodDJ5Z2lURUxkZGlGODJWY01tMnhj?=
 =?utf-8?B?TTlRbVVGSWVyVWlsVTc5czFLZzNOOHVXSzlzQTBzZERXREV1RnBXMVhVTHda?=
 =?utf-8?B?VWIzWVp5aGFVejNRZVQ2NlJoZzNXK0ZhQTY1enUyRXk4RFpFajNNMlU3Ykd3?=
 =?utf-8?B?MVBha3l1QkRyL0F6SnFXMGl4MXRqbEdJb0lLdmhva1RaN3R3RWJadnZJQ1l5?=
 =?utf-8?B?QlUzWEY2SzVuQkxvYWpIS0JXZXBMS1p1TkpZcHBRL2hLTjBrSFVISXEzc1pq?=
 =?utf-8?B?ZEtDcFhVQ1Q2dEpLdzRIbTRhZ0FuVXBHc2ZDakR0VGROeTJDS1pPTDBhUGlz?=
 =?utf-8?B?T29XSXVVL2ExZlZhcFo5dE41NGNncWE0VVp4elJzNDRLVEpkN25MWnZyR0ZK?=
 =?utf-8?B?cVdyNnpJK05HczlhMnlINFRkODZrWHNJUWZ2RnN5U2lOZW04b25UWHMvWUZu?=
 =?utf-8?B?VzJzbnNqSDYxMVh4VHpLbHBmYUR0czZybTZhYWV3ZklTQUp2aUF3NTY2bzNZ?=
 =?utf-8?B?NCtQTlVtSkxLSWo2cFZoWFE0b0puZ1hoOWNTZDBOdGRNcHFFdG9WeG5HVlFT?=
 =?utf-8?B?NFNzVTQvclBvMUkyL1dxNHA0SzV4Sk5LeEpHdmRrZmJPTXlON2VidzlNUE9F?=
 =?utf-8?B?NStqYTlVdm8yV2RQSkhqMG9GS00zajh0VC9GUG9xTHRMMlZBSTZEVDhFdW91?=
 =?utf-8?B?ZUdmVXBGdjY3Y3lOK2VkcjlRL3lueTNPbS96TkR2d1VGejFMY3VCR2w3QTI2?=
 =?utf-8?B?T254Z0Raakp1SVVTY2xMVU83dXZVd09VWWlzdHU2c0Rzd2lDejFLUHk0VEdi?=
 =?utf-8?B?dWpMNnRtUEh0Y1p0S0xQVEtJRmFHSE1xMnh1dGNLRllaV3FjMEh4UTlrdzhK?=
 =?utf-8?B?dmVNb0plL0hJUkJ2Unl3Z1VYYi93aS9CVDFwZ0hRRnZ6b29YMHI3T1Z1cits?=
 =?utf-8?Q?YLFnxYLZq6WzQ4jNJvagjIoCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7576b419-fdd7-45ac-5044-08dd8c848ff2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:58:33.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWsV6rH9NiE/EIPknUKuvpssWb95FzFBb5vW5kWN97ZRRoDdk2EFA1hSEOvuqwR8y+Rx0SWQzS45D2dno3yPUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

On 5/6/2025 2:45 AM, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> ---
> 
> changes in v3:
> - addressed review comment from Vasant.
> 
>  drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60aed01e54f2..636fc68a8ec0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3329,10 +3329,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>  	int ret;
>  
>  	for_each_group_device(group, device) {
> -		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, NULL);
> -		if (ret)
> -			goto err_revert;
> +		if (device->dev->iommu->max_pasids > 0) {
> +			ret = domain->ops->set_dev_pasid(domain, device->dev,
> +							 pasid, NULL);
> +			if (ret)
> +				goto err_revert;
> +		}
>  	}
>  
>  	return 0;
> @@ -3342,7 +3344,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>  	for_each_group_device(group, device) {
>  		if (device == last_gdev)
>  			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
>  	}
>  	return ret;
>  }
> @@ -3353,8 +3356,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>  {
>  	struct group_device *device;
>  
> -	for_each_group_device(group, device)
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	for_each_group_device(group, device) {
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	}
>  }
>  
>  /*
> @@ -3391,7 +3396,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  
>  	mutex_lock(&group->mutex);
>  	for_each_group_device(group, device) {
> -		if (pasid >= device->dev->iommu->max_pasids) {
> +		/*
> +		 * Skip PASID validation for devices without PASID support
> +		 * (max_pasids = 0). These devices cannot issue transactions
> +		 * with PASID, so they don't affect group's PASID usage.
> +		 */
> +		if ((device->dev->iommu->max_pasids > 0) &&
> +		    (pasid >= device->dev->iommu->max_pasids)) {
>  			ret = -EINVAL;
>  			goto out_unlock;
>  		}


