Return-Path: <linux-pci+bounces-15010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7149AB020
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165C0B213EA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F119D06E;
	Tue, 22 Oct 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iOv3Iboy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D145945;
	Tue, 22 Oct 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605248; cv=fail; b=aFKfs9Zyl5v60K/PFVQ4P8UgMyx7jpR6WvBmtentYwa979CVAKx8vsq3PGiJ58Fu/ryuVhI3D7BeK4vyfUbtSsq26TiHlteVNXiHS2k70esto+1zgrnL3WgbGtMcX/xlCpkMi3Rmd/C1w3JS6XARMXty3nK0zFfEZfAUvk6x1MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605248; c=relaxed/simple;
	bh=UayE3pvkCQHxDLsRvusj/NkBMMBI9GRltqr1KpKK6zU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLhoBkwxzGybPZmgOUMbmzvfA33BwKdPOKBnUEnNRnYYDGz+6POFN1XtKjv+X29LiTvU96w0qjA9qRjqRw6a0VynmxJlSoo/+l9vs6kRGEBENL0O9DhIRFZ2z2f+8vR0cD6QLmd05M/vaCAfusJiPeHdMNFdm4YeyFGmZCu4w3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iOv3Iboy; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF1ypfxfo+azVH8Za9k5vWPnjCIP2OB25yWsmaDUcICT8Q81hRQmv8GeVdbNFCfSY8nxz0h5x1/2iAJKw4qT8ELThtwV9/yXzrufp61Ns5FG2ctkXlM8oSquvmiAFS7Uj0Oov0sfOeCxFBVP+FxxyODccafEro06grKuxmsJGLgCCRiuhuJuzIeTq0XJXrZSU2J4Wc4cnSMBDlRdzgtPNXX57HgazymPnidBxQZKLSRmuU7R12RMXnrszXUrNIzPeXo65cKGs5CoCN8POKHOhv7QPdIXj5SZTnHrV5qfaEb22XzUuxMorIVKyZpXOJd9myEMm0++9QGky4YJHdeKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6j8XfXz3wKHYuopkg43wGHJeE5KnYx4iXxmchIsPpU=;
 b=h6RGHTBY7INlDkrFS53jhnOOT6/iUW7m7qxoJfI1DcUvOMgsE4Xsy+QsLMAJcmieE6bb9i/W4ReK6+95fS4545dtIgTIrlSytNQgMW8XP39O5nHjYoy23sOxjYejiMND5iw8tOsxlkx1oXQPEtOHJjlIZ1WIrcMV/+3v3f4ZbZ8kNQA0hm0Kh4XBPW8pZiG4LQHdwRioar8LDXyTOzxbidjEiVAi//9fNHK9CSWv5T4W70xDXmP9+LtEt1psx6+KxkStaRhtvXqHI/37/4zdOQFvDCG3vQLXhDLDizwQaMa4tQLb9nRj86TIRLeR/VBFwHMVujyA4tA//IImDkTK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6j8XfXz3wKHYuopkg43wGHJeE5KnYx4iXxmchIsPpU=;
 b=iOv3Iboyi+lgk64GnLcG34h0tIrcCZUeLJu0PDa8MgJexGViWuKr7U82v4WRWzARk9WOWtuVXmv4huznP76ioGi8hHoGgTil9vmN6iXN61q97UmKTtAh+BmJ7u2v29fMr/mem5xuQtvVS6k6IbYwTNrPRlwjSjbKx+bzhYsOdn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Tue, 22 Oct 2024 13:54:03 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:54:03 +0000
Message-ID: <5bfc156e-10f4-4ecd-a8d8-852b2e708671@amd.com>
Date: Tue, 22 Oct 2024 08:54:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] cxl/aer/pci: Update is_internal_error() to be
 callable w/o CONFIG_PCIEAER_CXL
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-3-terry.bowman@amd.com>
 <67170b1ee6d1e_2312294ba@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <67170b1ee6d1e_2312294ba@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0208.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::33) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: b3927bcc-eab9-4367-58fe-08dcf2a0fcde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2Q2SWlOYW82Rmk5ZFM3SU5jcGVxdzNqMzFrZWtKN1NDVmdFS2ViQUVJNVJS?=
 =?utf-8?B?bEtzd2c4cGtYNWJkWDJtYVh2SkdtL09NY2ltSVVLUXBWRHVQZWEvMU9tTVkr?=
 =?utf-8?B?Q2tFYWNhSklUR1IwWEsydzlJcVdpcFVTd2lxekJkUTlSU3l1NTFPUy9qaFlC?=
 =?utf-8?B?aUR1ZVdVN2w0OFhKVHVTdGNNT3lFQVdvdCsrekhGZkpHWml2aEhRVWZIMW1B?=
 =?utf-8?B?RWpJNGZTMjJ3Zk9rbDhmakJHVis2a2ZFVFVJU000V2RqbjRnWWNIUEkzeSs5?=
 =?utf-8?B?MlNqZTBrTnA1aTZXSXdVREhFMlh0U1hoQWJFZDgzbzlCYm5sWWlHVzM0c1NJ?=
 =?utf-8?B?dWpHbnBxMVNIWkY5MzAvSXdnT1JUWmE2ZEYyTENlWGIrS0xJcW1yTzV5NFAy?=
 =?utf-8?B?WVdNYktCdnF0dWtURmcyVG9xM1BTWUtzdWVkZTRDMEgxVmo2Wk9ieVlIOXVG?=
 =?utf-8?B?Z1hwNzdQdHhwZ1oyTUJDbURTcEFSWUY3anNDTUVSbE50RVpOSXNpVlpJREFk?=
 =?utf-8?B?dHVmZmxXUEV0di93THNTRmpBMVpnTnREbHAzQ2pKd2pKQlFmRGpqRzMwVkpY?=
 =?utf-8?B?OGplNTluTTk1RVJnQzlNeWJmdm01SllVOE5jZ0p2U3BBTTlaRTBhbEk5OFlF?=
 =?utf-8?B?MTN0RFZyaElEOFlRUXEwWm5wQmoxeEx0ZzFNNmhScEpCUEZGcnVRa0VJVnh5?=
 =?utf-8?B?bjdaUnpTWXVEcWYva2F2UW5WSTFaVENmSFIvbFJzQWNwMlNRamxaOXZTQXc4?=
 =?utf-8?B?U0ZiMVc1YzdsU1ZIanRFZnhuVFVGVGgzeHVaVkVrcjkxNGNOYURKV3g0QUU0?=
 =?utf-8?B?RTQ2V2FIV0swVGljV3NUUlBNWmFLSUxiQm03YWNQa3F5WU8venV5MXhoekJN?=
 =?utf-8?B?RFdMQTJYMm9SaW5nYkw4R0s4K1M4LzgvOWYwSU9IVk5rbDFEWlVNZ0M0MEJw?=
 =?utf-8?B?OVFzZVU3ODdRaktKZ2piV1FZVTFoOCtEK1A0eER3SmxIY3dEb0twWnQ0V2V6?=
 =?utf-8?B?dng0Z2ZYNzJqN3BaanJmZ2lzL0hsRCt1Y0NTSk9La3hLbnMvSVduZHhnWEUy?=
 =?utf-8?B?UHVhQUlRUXRiVTFIelhQR1ljb0VxelRGSnRhNTVuOGszR3BKd0tFS1lYNUU4?=
 =?utf-8?B?c1pIekNjR3c5VlU5WCtXZzhCS0xIZW5lU210cDJ5eDZPQmcvd1JQbCtDV3FV?=
 =?utf-8?B?ZFM4cWZlcjZ4KzlLczMzWStENEdwUWFiTkpSNDFLaElGRUMyUUo0WFRpbUNX?=
 =?utf-8?B?NmFwK29GUlNQc0lzenVDRUJud2RoZGtIdU5MVEd4bUE3cEpaY1l0Q3UwOXUy?=
 =?utf-8?B?cDFNK1d5azF1WkZFb1JCaW5XZ1JqL2dRVUVITm1zWnBsNGR2K25CRGxCMUZk?=
 =?utf-8?B?UVoyWXpUT3VRWG4xU0pDL01mZVVnSi9pUzFQVXhVVjhaMm1jUFVBSTYrM2Rl?=
 =?utf-8?B?N3VwenVhMnNEQk9xT0E5RUJ5SHJQNFpmRnhuNjUyMDZIcnNZcWxlSS84K3Jt?=
 =?utf-8?B?TXNFdXpXVzNFM29hY0JnU2tTSFE4M01RUStLRzBFVExMUDl2dHFoR1VsVWxl?=
 =?utf-8?B?dnhIT1d4eGdoVVZDOE1wdFdLUEUvcGlOV3hjdjFLV3V2UW1zRStYVmZpTVpv?=
 =?utf-8?B?SlBGaEJBSzhtcmdUM3A4RFdhRWFVYmhwYkhUclZZTzkreEt6M1dLaG10WjhP?=
 =?utf-8?B?RVFQQ1lKbFplL2w4SU1ESjU0UWlsNHRnalNIdW9nUGVXd2MxRlBLYmhHMndK?=
 =?utf-8?B?aC9qanRjL1RZSjd0UEhjT2JiWlNFbU9oQ1dOZW1mSkVyM0s1WDl6eXRGVjdJ?=
 =?utf-8?Q?kDflRlazmBftbGEinRAgs8O+XzKi5H3nUntRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJLQ3FzNXpjT2Q0NVdFbVhEQWIxSFZoSkY3aTc2TUYwbWkrZ1FaeFJzc1pm?=
 =?utf-8?B?blBpWjFBYjR0SUQ4TDcrYWRFMitGcGxJVldBK2QzanlETjh5OGQ2TnZEWktV?=
 =?utf-8?B?cExoci82bXRhcEcrZ2lYMmFudEw5VzJpQ1hJVGUzak03Y0ZWdFhja0hpSGd5?=
 =?utf-8?B?Rk9CeUQxMTljYmprdm9IRFlPRCtTVVI0R3kvUUE4bHg5WGJ4YlNLa01KWHNF?=
 =?utf-8?B?ZGM1VGdoOVJ0ZjdCOUUxaXdwdTdxSHAvTEVmU3Bnczc3WStjZ28vM21GOEJC?=
 =?utf-8?B?aDNVQnpnd2E3bk1FSXd0R0Z0cjhoZGMrN0I5TnVDSkE1ZjFmM2xaNUtUMUdW?=
 =?utf-8?B?UU5SSElHQlZMMk1NSDJZQ0tzVE5mem8wcEZUNUgzRTY3eWRVYWlkNFdobHBE?=
 =?utf-8?B?SGhsM3g5c1BqdkNQS0lmSTNwZ2RBT3VsczBJK1RITjNtaERvaytsL2VlbTRE?=
 =?utf-8?B?U091Sml0bFZWZGthSGZwMkhZcmVSNHFUZk1Vdmt3WWVwTDgwa1RKbmdBUlRW?=
 =?utf-8?B?aVYyTlZhaG5HNW4rTTh4ZjhxVi9NcVJBbGY0RVpMNlZmYzJ2bnNDYmhvNFlE?=
 =?utf-8?B?S3MyNnNhREpQZG9MUEZtNzBlWVpkK2drNVRoRnYwVWx2WklNdzRJTmNjUUpF?=
 =?utf-8?B?WE40b29lT0ptSzNNRHp2TG9nRWkyUHFwRVQ3NGpIUS9MRGc4WlVyVE9OcHV3?=
 =?utf-8?B?OW5sb1RHNXJVZjEvRmYwMXhZVk4vWmVuQ1NmemtOSi9jbGpUV3dzem00UWFW?=
 =?utf-8?B?VzE4Vi85L0NTU3BkaGdhM1lWdG9HNGZhN2J2bk9BVGJEUjZBQVZmQ2NMRDJv?=
 =?utf-8?B?QUh5aTlveXV3Tk9WMGNTaGpuMi92RFVSTDZCYlhxZzhqNUtCU2MyM0pUc3Zz?=
 =?utf-8?B?N1I4ZTZKSFZaN0MwTFU1VEYvM2xtaWlXT1ZXY3REcGN2YkRQaHZxRERRNEsz?=
 =?utf-8?B?N0R6U0JWNm4rWFd0OTgrdnA3eWNibTdaeXd2ZXptRjEzSE42a3grYkVYUHNC?=
 =?utf-8?B?RkRFeEt0ZXR3dnVKTWVxUGR5bkpzU2xHZURua3VBMWsxYjk1N3Q2ditTVFBj?=
 =?utf-8?B?WlBST05UQnJ5WGE2OEFhTTZyZ21BdEJYNEZMUWRnMHR3RllNM0FoaGxNTklz?=
 =?utf-8?B?REpJUEZEdVp2bUszdFNObENLSGQxMUJnQ1RPOXBadERrd0ZIT3dwUG5udWU3?=
 =?utf-8?B?YlRLcW1ZSXJjb1VLZ0R5cjkzUkxCdjhkRHZNeGR3eGMyZ0hXcjdRamhFT1pu?=
 =?utf-8?B?Y3AvNEZTT3FBb0FVTXJzWnkvMmJwME11a1hwMmI3L3U5b1VwdDhYaG9lRXRJ?=
 =?utf-8?B?Tk1mUXRkTnREUEtISlJudEpnRVBLVjRvNE5WazYzY1hRMG1LMGg1MU95Y1Zh?=
 =?utf-8?B?MHRuVExscEw4Sm04cWIybVRMRnd0LzRXSytrZno4N0NZeS8xTzFuZ2FRMEtO?=
 =?utf-8?B?R2NEMms4UkNiL05tNjhBRzN0STR4d1NOV2RiUVlyN3pmeDZxWXJHVmgvMGIx?=
 =?utf-8?B?cGJUZGdVQ1p3UE45OFlRTXBJYkxJMGt4NS9wZFNEVnJkWVNKbi9veldOOGRo?=
 =?utf-8?B?MFA4SU1lSmwzZGtqcDNZVXdRdFdRTWhBd1MxMHErOEx5eDdrRkw5dUlZRlNX?=
 =?utf-8?B?MGhVQjhBamZzU0NpemFxNVJKMlBhMzN0ZFlxYVYrWGVNYVFIdGpvai80SFBG?=
 =?utf-8?B?N1FKcC9NeUdMUDd0c09HSy9ZcmZoTDBvMWxoQmpRNXhJNkMvL2UweitwVTlv?=
 =?utf-8?B?cVV1cjNja0JkL2hVYXd1SExJVkNmQW5TUzVGRXNqU3h3UzVkVk1jdWtPekdL?=
 =?utf-8?B?QWZRS0ZQMk5WRDZXZzAwNExXaHpqZkRnSnl2dnBjTC82aFVrdzcvZ0o5MXdJ?=
 =?utf-8?B?Rjc5TFRrWjdubWhYS2xQOFErQjNBTGNaQ1ZHUms0OWsyeHV4MW96MnNCVE1O?=
 =?utf-8?B?L1B2ZnNaajdKSDlEaE5aeFhkbGQ0VWJLUDlyR2dKZURack42bGNlbWRJb0U5?=
 =?utf-8?B?ejBENCt3WmFrK0xadGI2UGw3NEZ3cjRpZHhUUy92cUdxdVJNd2ZvTkJsWmxN?=
 =?utf-8?B?ZE1jN2hBVXp2Z2tsLyt5SGorV1Z2RUY3ZGZrUWp2dGViejdWdGNqMklIRWpR?=
 =?utf-8?Q?WASK4Tnx5SmZslIF+pgLr9Bg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3927bcc-eab9-4367-58fe-08dcf2a0fcde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:54:03.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNXU7uNNVOl8ei9Be2pICpttDXAZ/QivWaRd+zDTIR30BnSlzFbEeBsgu0GQUrxaFBvgaaoBy9NRiXLRFTKPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

Hi Dan,

On 10/21/24 21:17, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL port error handling will be updated in future and will use
>> logic to determine if an error requires CXL or PCIe processing.
>> Internal errors are one indicator to identify an error is a CXL
>> protocol error.
> 
> I expect it would better to fold this into the patch that makes use of
> the is_internal_error() outside of the CONFIG_PCIEAER_CXL case.
> 
> With this patch in isolation it is not clear that a kernel that sets
> CONFIG_PCIEAER_CXL=n should distinguish PCIe internal errors from CXL
> errors.
> 
> The real problem seems to be that CONFIG_PCIEAER_CXL depends on CXL_PCI.
> I.e. is_internal_error() only matters for the CXL case, and the CXL
> handling is moving more into the core and dropping its CXL_PCI
> dependency.

I will merge the patch as you described.

Regards,
Terry

