Return-Path: <linux-pci+bounces-34046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102FB26A41
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560141CE33A4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F2F9E8;
	Thu, 14 Aug 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gxo9+DqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75B33991;
	Thu, 14 Aug 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183191; cv=fail; b=VHbtm6EXvEeRg0HDXs+xW8Ozk2ppJrTAHQ0R7RFJOvinbbgsjh7uJ6/x8yXIP/xIa/FAhZZFmrE3mqe8UVw5EUdS7iYBh7LdW4uVCyY6d65xfptsDaBppufrRZgp6XmENlgl8Awf9m80m2pas6AuOxYvo4P5ID5y6RxXVq4Jnws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183191; c=relaxed/simple;
	bh=Ksxwkh0bkZAoR6+8tsn9sFMxZnKRQv8kYpsTu727QfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duyIorSG0lSSZoU5EtwB2WloUZ2FYdKhAgP2CHur73icjHW45ZeCYe6M5TkwICc1y1Dn/137T9Fy88ogXUFUFxjL0kIkX2o6PbjE82mE4rzsQkkt8ZzMdxAVrnpPnJIsp2WQx96a9zhpbijmCiC7bzyjAOS1PwNCdM1Bf04uU1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gxo9+DqA; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgjKcyS/GQWVQwGMcM86WF39T2ILqWZLaQyBU24Eb7dKCDmrK3NeoQ3IJGjockDdjL6mRwbb/RUhoHrJX/aes6CfDPNhc4m55IwjweQsvtj0MTCcznI7StsUB9phcEMpD2CdZ3MpAuMMQbsvbNEE/pusM7zQELVhT8MmGNgixRpa3rT/54COmvheIMiSly/2AHTmWJkdaSO0pVYy5fYWqxLnvZFpAF4WWRszMcnzwvk/SdS2MwZNrKdFpyoUM1k6V2EmvqlCmaY1C+1w77Oituh34MIZT8aWmtNWCdgUQk/fSFDi7vMzadE6KhtKxazEedP9s7sUDPtqyZhqG1x2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnGvq9W+jPozFeNxbRJZT3hkXGVr7+SzDJ0eJPMLexw=;
 b=UwaHzvTnMcHfH+aFQgPIY+lMTno1MHq74WdWIXlTo/x9OaTErTPASv9a/EZNxAODMxq1wTIGIRc4dG8uK53HPaBzl3d3E54Eva6hfOLMo1QwjDjizPww+x04OINptaWvPaGmVBxGR/jPiaWHX4/2kUDnhwG9PoXuWkR61gZKj5z1p2sTSXw8gcFPxn0lqzMD6sOcEgCFYAuMtwWu4CRAEFNSQ8FDqf/Fvb8cTCPzhX9RpPWgmCTZxnuag7p28ZGtyMKYZrT3enLBvLCqUl8m+W8KD4fwCzh0Fuih1F4v3IgmOiNaMHIL+M25vcJMUlUo3FdkWIs52JPxYGPpFQLkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnGvq9W+jPozFeNxbRJZT3hkXGVr7+SzDJ0eJPMLexw=;
 b=gxo9+DqAGAZeYXsRqPSgDFlty9uznEWS+S53K048BNxwP8B9pvKk/iOtkySLEeDwvRGktXV2qPpRpH4YhWzq8Qnv7OR5rI/0QzGes94YWogO7WZ9abogXPwU/wz9Fr1QTeq0Rh12JJm77dr382H+pEPh+HQ+GpkG94wrW/hmn88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 14:53:04 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:53:04 +0000
Message-ID: <be66626f-a871-495c-b7fa-42cd3f497245@amd.com>
Date: Fri, 15 Aug 2025 00:52:57 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <7b6782da-1318-4dab-8230-e59a729f8f11@amd.com>
 <689d3e97760ba_27091004f@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <689d3e97760ba_27091004f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c493b1-4c9e-4ff1-f72b-08dddb424566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THNudHhjb1dlamh5a0d6RGFTVnhJTElrVVhSTlJJZ2FmN085bk4xYlZ4U3l4?=
 =?utf-8?B?M2RFS0N4TFJzMFZIdmNWWVpIamM3ZGQ5SE94Tk1mN3dpOVh3OXlrZlZnNjlH?=
 =?utf-8?B?ZURzbVlxS2VzZ2JYYXZzcURET0YyTDJ2OWVCY2tZekZINzJ4WUtPcjhROUkv?=
 =?utf-8?B?eWEzcHR2SDBVK3R1R1hPRTJ1d3dSU3VFSi9WaWY2NGdWVyt6NFIrME1wQUY1?=
 =?utf-8?B?cUtXempkSGhvb3JZSDExUFlkUHRlcHN4cExDM200N2E2aHpETGdxTUp6dXlt?=
 =?utf-8?B?aUhQTEhMVU9ucS9wY3dQckYyYlByYWJRTEp6bTZsZ21LVnZlVldPWUszWEU3?=
 =?utf-8?B?djhPM3F6c0RMNXJjZ0VxUDBLS2laZStOYjRkMDJ5MndaUGluTUZGNVJkQ0hV?=
 =?utf-8?B?T0xheU9obmRzc1VTb2xXL1lyd3Flb25LdmttZ3kvR3g4WUp4c3Zvdnkrbm8y?=
 =?utf-8?B?NFc1RktNTUFUMlBFMHBSbS93SGdEQlo1ZWFZUHE3TEZYT1dhL2hKMzR6cE9B?=
 =?utf-8?B?UURKVnZ6M1RZWjkxNDJDZWdnY3dzU1pod0s4S1JKei9xTnJIUVhaUXF4eUJq?=
 =?utf-8?B?bys2aVlsVjBPeXBySWNWZ2llMG5FOUlSZFZsdjJqZUlmYnZDZGxuQ0VBLzc4?=
 =?utf-8?B?SGZmM1cwWjhsTHg0MVBSYzRzVUp1NVhIdTNkdi9TRGpVK2paTEpicm4wV2pE?=
 =?utf-8?B?dWFvanhuSVU1dkRIMmFqTnhCZDBRK2N1QU1paXhmcy9yRVIxcEN6cnBUV1N6?=
 =?utf-8?B?MytmamFHWnFEQkQ0Z05BTnRaRjdTQm12N0VGL1A3cTZUblVKS1A1cldqZ3J3?=
 =?utf-8?B?N01jVFFRelpLYmV2dWVsSHdVNk90QmNDaWZjSFF3OGxqbzFINFpoUG5GMUZY?=
 =?utf-8?B?aDQvU1ZKZnRCd21rbHlDellYQjJkUmdsVHFmMy9sTjh5LzgyTzVtRzB4TXVX?=
 =?utf-8?B?NE9WS0R0N0xMSTVhVldBUHQ1bEFsT3NTNFhwM1lCb2lGSWlxT2FQaWJLMWwv?=
 =?utf-8?B?YmJNUklzSmRKaG9idEN1SUl4UU1WWUp1YVFTZ0F3UE9tb2Q0UEFkWU9iQnVX?=
 =?utf-8?B?RU0xZ1FyM08yUmZ1QVppM0MwU0tOM2xlMzZTQjNESjBCM1cyQ0ZNVG5WTHdX?=
 =?utf-8?B?bWM0Y1kvdlRxdjRxelB2eEFDYk5GUGFuZUlUSjFGMk54cUJ4Y0JjV3JLNzhC?=
 =?utf-8?B?dGxERWJTUkZ2VWdKaXFWYk9jTjg3aUh1cm9MSy93cXZDQ0RUTWNlNGZTMjcw?=
 =?utf-8?B?ZXRDZ1NBMDJHeW1iV0M1VEREdjRzdDkxYmY2QVg3NlVwQzg3bmZaRVNqa2xw?=
 =?utf-8?B?NDdJNlV3dTVDb2RBcDNtT3JpZkRubnp1QjZDNHVyR0NJM3RZK2hsVERleFZM?=
 =?utf-8?B?VGtSSkN3ZXJ6WUxmZW43TVdDNC9HaUZhbDJkWlpYZTk4ajAwMjB1M1hrcmhH?=
 =?utf-8?B?cW9ZcXZ2Ly9RTGFVWXdNVWRhVnpaWDg3KzBHenRPYkhJSzF1T2JhSVJtMHpS?=
 =?utf-8?B?SW9ZSEUrS1pzRzZnTlVzL3RMRisvZm1NbEhYclZzZ2M1V3YzblAwM3F6eUFU?=
 =?utf-8?B?aW1YckhVUjRSdTh2N1IrT3NOYXZuRDlxdFJEc1lJNVZsWVFwQ1J5Q3RrY0ZX?=
 =?utf-8?B?NmpaYXlSWXNKUkxtdkhtMFMrRlYwYndHbnFYWVc2VVdrc1ZySFVkQzZvQjVM?=
 =?utf-8?B?ZGg5RUkrMmhFeStRcTNNdlBFMUxpV2xhMnJrTjJuV0FZZmQxQWM2LzZseENt?=
 =?utf-8?B?aFNPNDdEMHZBa2dRU3pnWlFIVGduVjRFUE01enRuZFZVTWF5R0NZKzRXemhF?=
 =?utf-8?B?UlZEUHUvbS95U1FFWlA3SHRUNWxiMzNlblFhak1YRWxwWURRWWYwSnBVMkpz?=
 =?utf-8?B?eDMzVVUrcklnM1VHNmY2dkFZaVRyZU1iTE5ISXRLN2k4T09xbkVkNFRoaVdD?=
 =?utf-8?Q?d8alxRxj/jQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFJpK2lGbDdpNzBjbFZDKy9uNUNsSzNPb3ByNTBDQXoyRHMrNXliSGhBaVVq?=
 =?utf-8?B?eFhwQk1sejI0T0xhdjRBSnVzRHZoZG5KVzFvYS9RM2hibUN4Rnh0WDZubmx1?=
 =?utf-8?B?cTJ2cGY1WTgxMTlmMndiMzVkZ0ZtcFI3Y2I3ZlZtUEhUNG1rZkpFd1ZDVlFr?=
 =?utf-8?B?ZzZaM2lyYUxHMEZaMHZoUDNPNlNKRVhLNGUxN242RkhSeTBMR2YvYk5ZdjhR?=
 =?utf-8?B?b3BEMUxzVGdDdWJVMEZyRWRiT1lWeG81THgvLzdRbm5HTmJ4dkJ6endUNEdC?=
 =?utf-8?B?WGRLWXMxZWREZUtsWkU1N095cUFCaDJNTHMyTUhqejlraU5yeUFiaXpiVnRF?=
 =?utf-8?B?L1JWdXVwUXRHSVY2UEVvaGxSVSs4WjA5OE1CdnNtVFNWQStXejlaMVpxeGpD?=
 =?utf-8?B?S2JXUjQ5WlM0LzRLZUFKN2ptOCsydnZVOUNDQk1FU2V6RkpINWJCa1pyUm9y?=
 =?utf-8?B?SjVTVGVCc0FmRXFQVGhTS3FaWmo2ODN5OVdPOU55b1RoODVGN3UxVThtcnVw?=
 =?utf-8?B?Uk1LL3dUUE9pbndXaisxdnBFQ3ZhTG82N21zaExweTN5TGROYnhxdzJibSs1?=
 =?utf-8?B?UTVXRDFmS29aOXJMdjRuRng1ZVBEbHJGMkFobFMxM0xBN0lhcmplRjZqc1k2?=
 =?utf-8?B?QXROL3BmSFhwUGR3WkxSQTF0dGFUT3VsRDAxbldaMUttdzhDVXBsYU42UCtV?=
 =?utf-8?B?TnhFamJqWitmQnVNNnhKU2srNVAydEZHWkZDNTJDanloVmRHSjFqMVZpa3Va?=
 =?utf-8?B?Z3JYQ3BySWxiU0NCakJ4ZlUyRHY5Q1lRdS9LMEtldldWVjdlek04UXdyNEIx?=
 =?utf-8?B?TjcvMWxRNXg1dXVubnlDYWJ0T1BPSXFrdUVkekhrbS9hSUhZKzJTbTVtSmww?=
 =?utf-8?B?cm5MeW9JZ1RRNFFoQU1VWUlyenR5Q0NvMVZYd0ZIZTkrR0wxZHZoa2RlM0dM?=
 =?utf-8?B?ZGFZU3BhSFNHSk1qQ3ZlRWUzRm0vUVc0Q0xNYU1VcFhqeGlSQjBTbUVJZUc1?=
 =?utf-8?B?SGhOYktDRmpvRHNCeDhTclZkRGlDaDhnSTB6TGdPUHpZMVpaREVlNlkwaUZk?=
 =?utf-8?B?SlRKRXAxdjZPaisvTFZmQkFxcXFKeCtFanlUNEZXWVhaRWNReVNwWmRRUHZr?=
 =?utf-8?B?OVVFUTBLd2ZveDhORXFWT1ZGaURwbnhjQ1N5VDlhK0J4YkpwRHdaakJBajJQ?=
 =?utf-8?B?aFF4RFMxY08vOW9xZWd4ampKd2RTRDVGNGc5aG16SitmUzZkYnBpVHkxZktj?=
 =?utf-8?B?eXUzajM3bmxETmVoT3h0dDQ3QmRUc0ZBSzRmQTVZUEtaeS9OaXRSL3BDdnhL?=
 =?utf-8?B?ZHdZZkxMdGJjbjVnc091T09ETDVMSE1zbzVmb0ZGLzN4NjRDbkV0b1ZXVzdU?=
 =?utf-8?B?bnFXNUtEZTkyRWxGeGsybnBDT0tNcjRLNmVhTTU4OXBDNEpWNHNkL1hMcTVv?=
 =?utf-8?B?VE1OSHlDVFhOcU5uSlhWVlZqb1VoclBIV2ZYYzlMOTR6TVV0STVxSGk2ZDFR?=
 =?utf-8?B?MS9wS1JRQ3lON2RGVXFDODNneDZFczVwQUVTQ2FoNDZRbjQwK1RLMnRkQno0?=
 =?utf-8?B?eFNEcWIzemRUZmdhdStKS0NGN0tXVzhUM1I3SUhWSDV0L3AvSWFhQU5kWTFI?=
 =?utf-8?B?dWVrK0l4cjNrc1hOamNYcHpKYnB4VU1YSmJBK0orUkdwVVlVZCtjNHNCNWh2?=
 =?utf-8?B?aEowUFV6SGVSQU8yVXUvelF6aEVlbG82aERMVjlUdHRnQzIzRXJISWtzU2Vu?=
 =?utf-8?B?aEx2UFhYemFMZm9rUHUwNDdUTUpNZlNBbFhveWdQTElNRGl5U3JvUVBHV1Zh?=
 =?utf-8?B?MVFoa0pPaHpSQ2JrQVNxeURUUkV5WnR6RSt4U2pwSnBlMWFMYjVMcVh0NWJU?=
 =?utf-8?B?UkFwR0lnZTZGZ3BMU2JRRmdHbGJBNTBON1JENXJrRXpEMFFjTHhsUlVETWFB?=
 =?utf-8?B?K1ZHTUNkVXUwVjE3QzQrbklUNVV4ZUM5TEM3WkdlQWhiZTg2MHBTN0lGSnN0?=
 =?utf-8?B?Tjd2aEN4Q3JYbjdubkxLcWhndVl6a2hid1M5VnltL3l4TGRPMjRLTVdWQkhK?=
 =?utf-8?B?Y3V2dXAvMGp5OEZiOGkrRGZPYTVxempvNzB3TWRsaGlsMUI1bWdIOHo2MVJM?=
 =?utf-8?Q?ea8Q3LGBKwGi53dT4dbHd3+pd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c493b1-4c9e-4ff1-f72b-08dddb424566
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:53:03.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S+Lbd1AJ3zEQ8tAhk1kGG9MdwpTMN6ww8q7EhyL7o8whd+tZgT3ZpT1ePue0SN7FyoIp5TB3qeYSxCGX1vIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614



On 14/8/25 11:40, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>> On 18/7/25 04:33, Dan Williams wrote:
> [..]
>>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>>> new file mode 100644
>>> index 000000000000..0784cc436dd3
>>> --- /dev/null
>>> +++ b/drivers/pci/tsm.c
> [..]
>>> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
>>> +			     const char *buf, size_t len)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	const struct pci_tsm_ops *ops;
>>> +	struct tsm_dev *tsm_dev;
>>> +	int rc, id;
>>> +
>>> +	rc = sscanf(buf, "tsm%d\n", &id);
>>
>> Why is id needed here? Are there going to be multiple DSMs per a PCI
>> device?
> 
> The implementation allows for multiple TSMs per platform [1], and you
> acknowledged this earlier [2] (at least the "no globals" bit).
> 
> [1]: http://lore.kernel.org/683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch

Right but I'd think that devices (or, more precisely, PCIe slots) are statically assigned to TSMs. A bit hard to imagine 2 TSMs in a system and ability to connect some PCI device to either of those. It is not impossible but not exactly "painfully simple".


> [2]: http://lore.kernel.org/b281b714-5097-4b3a-9809-7bdcb9e004dc@amd.com
> 
> One of the nice properties of multiple tsm_devs is the ability to unit test
> host and guest side TSM flows in the same kernel image.
> 
>> I am missing the point of tsm_dev. It does not have sysfs nodes (the
>> pci_dev parent does)
> 
> The resource accounting symlinks for each each IDE stream point to the
> tsm_dev, see tsm_ide_stream_register().
> 
>> tsm_register() takes attribute_group but what would posibbly go there?
> 
> Any vendor specific implementation of commonly named attributes.
> Contrast that with vendor specific attributes with vendor specific names
> that the vendor specific device publishes.
> 
>> certificates/meas/report blobs?
> 
> Perhaps.

Hm. Those groups are per a TSM so no device's certificates/meas/report blobs there, right?

> For now, I want to just focus on the mechanics of the getting a
> TDI into the run state. The attestation flow is a separate design debate
> one there is consensus on getting the TDI up and running.
>>> The pci_dev struct itself has *tsm now so this child device is not
>> that. Hm.
> 
> This tsm_dev is not a child device it is the common class representation
> of a platform capability that can establish SPDM and optionally IDE.

Yeah, I realized that soon after I hit "send".


>>> +	if (rc != 1)
>>> +		return -EINVAL;
>>> +
>>> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
>>> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
>>> +		return rc;
>>> +
>>> +	if (pdev->tsm)
>>> +		return -EBUSY;
>>> +
>>> +	tsm_dev = find_tsm_dev(id);
>>
>> When PCI TSM loads, all it does is add "connect" nodes. And when write
>> to "connect" happens, this find_tsm_dev() is expected to find a
>> tsm_dev but what is going to add those in the real PCI?
> 
> sev_tsm_init() calls tsm_register(). Userspace catches the tsm_dev
> KOBJECT_ADD event to run:
> 
> echo $TSM_DEV > /sys/bus/pci/devices/$PDEV/tsm/connect
> 
> [..]
>> imho "echo 0 > connect" is more descriptive than "echo 1 > disconnect", and one less sysfs node.
> 
> That makes it a bit too ambiguous for my taste as connect is "connect to
> a tsm of the following identifier", so, for example, "is '0' a shorthand
> for 'tsm0'?"

Nah, ignore my "imho" then. Thanks,


> ...and as I say that I realize disconnect as the same problem.  I will
> update disconnect to take the tsm device name just like connect for
> symmetry, this ambiguity concern, and in case multiple TSM connections
> per device might ever happen way down the road.
> 
> [..]
>>> +/**
>>> + * pci_tsm_constructor() - base 'struct pci_tsm' initialization
>>> + * @pdev: The PCI device
>>> + * @tsm: context to initialize
>>> + * @ops: PCI operations provided by the TSM
>>> + */
>>> +int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
>>> +			const struct pci_tsm_ops *ops)
>>> +{
>>> +	tsm->pdev = pdev;
>>> +	tsm->ops = ops;
>>
>> These should go down, right before "return 0". Thanks,
> 
> Sure, makes sense.
> 
> In practice @tsm will be unwound, but might as well not make it a
> valid object while it is awaiting to be freed.

-- 
Alexey


