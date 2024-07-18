Return-Path: <linux-pci+bounces-10527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE79350EA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428331C21C66
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80714430A;
	Thu, 18 Jul 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qJINU/ZQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C613C3E6;
	Thu, 18 Jul 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321406; cv=fail; b=aX4mT8ng7P/xK2kwSBsqIEVjLZ+kiQRxmSdzidm5KykeN6fQb5AvFDUAtCE1vmOvu5YO/8R3mb18m7K8+czjgMuof0pSUPnmZAF5pzZX5/E6zE9XnG8VnP12ldwrRmj3o+9XDZ8EIklIyxPfi7hpJVGmPU20PMj5R1ZPNFVbOHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321406; c=relaxed/simple;
	bh=BiYKEJUwa6U6+7uuJQODH6vCXqR0B2A8+sbAV5P6b1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKtamW2j3RvPdGHgp5oR44ekokdtm/JRfoqGxjbH+B3gUeArREiSXt9SvfjTtk5z+6PZU0ZkmNii/r49IkP0QZvtU6tWPo2GZWSzAT/+I+WZZusVUan2yeXalSzZyfbRWeU9PbHYD9Ouz0+BEbnVmg2+zYserYViXbKXO6MGs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qJINU/ZQ; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x626FL5/pMCN/0FfJb5DAx5HaURYaZqRJmjRorje8LgEKjVo8fnpLaDtxOP+F+ynQTPkE3nuCSQhwa6q+ASpEm2nJOoBgtOwe4EvdAMKy6da2p9dwVFTQeEEiYkMsOC5Xwv/B/VtI45HevGTHVdb7bVRThrie0qvFP5IAA4sTz7RRSfC8MJcQaO4qS8DrWzDj290EitVs9836GOc/9c4SZddOMb4PkmbEW0n9YLtYCmLLdy4lJQHUEUOhgV5AmqWRCk56rbBEjYppVxOSvc34Es0kEtksGHUENh/I5Jv/GGTIuBQQdVDlSOMdSwYpcOtX/09X2E+mLw8UEJ7gvtC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTNRQY0qPmvwy6h2bJ1EIqhHqx7jqwk3HRZloCgGxmA=;
 b=J3kvduqScK1XQMTGGwnkkxWcl1jQkUVuRom/Ou3pNRUO9iI9ccGhC88tb+uAR4OT9TIdsEPmWQ/S0+/sEXK+QZ2jZ4M6u18QTZX2hiSOS6ylM9tbwEbJBQDq4UsvJ0DAeea9vTdCa0Zn30Iy8pNZvESwwTCWjAn1AXTpo0gtJyyECiLBtkcTiIfuSj9xAclM/bFqpVZDi+VeVpV3uQ5Y/535sY15xQNGKb+2fiT9f5ZIrfe2bKa0bSEO9xybIEsoLu63/10c4QQ0+RT53/G4lbVe/pOSiLMR8m6+9CSP4YEGz7nw+sHL+n2/uvDWVEl094PWG/syLytZxqezW/srew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTNRQY0qPmvwy6h2bJ1EIqhHqx7jqwk3HRZloCgGxmA=;
 b=qJINU/ZQasVymQxo8Wwfu5jAWLF4AZOYKgONyWElJ/fG0SGFtWPLjsgiTNFvUN0o3cAssFpSFLmQjhxEvnTEJwKJuQc8VzUQaVNlvuhGQCEmt6XSh67HTDDDwZVJG8yeuFZsXWi1UsaXv4FBehIjiPd0ALGH0ZJeRAEWg3LNbWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 16:49:57 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 16:49:57 +0000
Message-ID: <e4e59c9d-a44e-4b19-bec0-c7f7bdc808e4@amd.com>
Date: Thu, 18 Jul 2024 22:19:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model
 60h
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Muralidhara M K <muralidhara.mk@amd.com>, Avadhut Naik
 <Avadhut.Naik@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>
 <20240718154323.GA54785@yaz-khff2.amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240718154323.GA54785@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: bf00d531-55dd-4cd2-d21c-08dca749a807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckpPcmx5aW1CNWl2bmREVEJMOWhIVFRzOFBHbFUvc2RTSkhTbVhWY2QwSzNs?=
 =?utf-8?B?dzAwMGd5RFVLR0tCSTVDT1hVRnBqSjQrT2N6UkZsOXViam9MT09MU0pEanRi?=
 =?utf-8?B?TTh6ZHZtSWNqcGFzSXBDdjRZeS9BTENNUGI2TGUwU3FXakc1eGRadHNZL1Zp?=
 =?utf-8?B?Z1NqNUZELzA5bXBaWGx4NkRIV1ROVjRoRGZDSWVtOHJabnhyemxQbi81Z0dx?=
 =?utf-8?B?bGQzNnpxVi9pQjhpQlZ5Q3J0d2ZBdTNNM1NZRitIeFRKQ1ovaFhpRStoYmRZ?=
 =?utf-8?B?OENDclRvVlRiQkJFL1F1K3VwUzNMRGpqVml3Ykg5S2M1dmtGUlVxTlN0MVRj?=
 =?utf-8?B?dDhmWkFtdkU3eU80YmhGc1pBUGFRSTFpL2F2S2FKMmNCbnRTV05RQW0yRUgz?=
 =?utf-8?B?RlgxTDN6YnFVNm1ENmQyUWRTeVZFMWFTeXNQMGdBYzYxUnFDTjd3cFo3Vldi?=
 =?utf-8?B?RWU0Y2t3S2FVWUZBaGNMZGFkOUpIY3lJdU5TTElseTFQR09ZNk1kVjZsNk1R?=
 =?utf-8?B?ZTJST3hJVUdhY2ZNZS9qcWtGYzM5U25lMXNSdXgvRlBTZmFSVTdZRFVibWRM?=
 =?utf-8?B?UmlGSGllNVNOeHpYdWJpMWFBeXF2Vlp2UFY5dkQrVnZJR2pWN20wNGhaYUVn?=
 =?utf-8?B?Y0MrektoV0t4YWZVa3d3ME1VaXFycEgyRjl6emcwOWdZajdJQWVRQlBrNW5k?=
 =?utf-8?B?eVVEL3dCaXN2c2xTUXRNNlRLUzEzZmM0Y051M1pQanZXL1RaZDNzTEw5cjJo?=
 =?utf-8?B?OEF3S3FLTU56dVNrbS94T2lZNlA1T2ZnTTdqKzRpeUZYQTkxOU5ZSkdIaGZM?=
 =?utf-8?B?bmd1bW1PWEV5amlvLyt1c2NuZnJlSDJQMUZIakJGT3RzTTV1eGgvb1QrTVJt?=
 =?utf-8?B?bGJ6emdza2JjTjU2MlBUWVhTUVJXWmM5alZuUkNYa0VlbHF5RlRpZ2tHQmJN?=
 =?utf-8?B?Q3BhWFhzeUx0V2U4OXhpR1pnSG5vTG5haGF2V1Jabk42R2ZhWExRNkxLYkRK?=
 =?utf-8?B?eGlFTDd0WlhtWEZBcmNpbmVoQWkrSnoxTVdqb2wzL05Tc0FmVi9wVzFCYkpU?=
 =?utf-8?B?eHFtUDlUT040dXNrbmo3b0lyYmVWRVhENUVMZmJBL1FLRlh2ZXNnSVdtOGd2?=
 =?utf-8?B?SWhnSUxrWUMrNHV6YUQrL1RNdzRZcjFKQ2RXM2JQS2FTVGpEbC9PN1gyVVly?=
 =?utf-8?B?aUdxM0JCOGZUU3FRaVY3MjR5S0NhbHZvRFIveFZ3eDhLZ1NZRFdlakZ3OU8z?=
 =?utf-8?B?VnF6a2lJOGg2NWtYOXZiZ1lJNzFZa1ZhbGhoNWxoUjFPZU9qSnB1ZEJhUTRK?=
 =?utf-8?B?TUV2L3BEMFJIcXg0QWU1eTVmNExTMi9WTllIejdRQUxNcFMvcEtyYlFmUnFB?=
 =?utf-8?B?dUxhUGw1dThqRklJQi9uMmFkN3FEODJiNVBFOTNOV21FbmNtYnM2alFUUEJV?=
 =?utf-8?B?eGo5djQxTzIyUmxTa2xIaVAvQ1hKcHFCSHkzd2V3WGNvcXJ2NDYyc1QremZD?=
 =?utf-8?B?QStXalA1eUtGVlF4MS9aK01Cd25FZlRFalRza1E4aFVTc3U1aXVPOWY3WmNN?=
 =?utf-8?B?dFU2RVZLYnFQeEdvL0dqMGZyQno5aE9ncTR0K3E3ZHRmVG1MbVBvMWN3Tmw1?=
 =?utf-8?B?bGd5UlU3VnpBRm1iVklFc1NuMXg5Um1tdG9FbDZUOUs5a1d0TnpmaFdza3RM?=
 =?utf-8?B?enoxMDZQdk1NUFJIQUZkb1ladVo5Y25LaDIyZnRsL2YyNm9ISTJONCtweGRL?=
 =?utf-8?B?Z0laNHc0Ry9aTllMY3dHZlVCNldTZ2JNZDNOVXByUU83b0YwdGplUms3NEl6?=
 =?utf-8?B?T1VPdHlHeW9OdXNtNFVSQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFMxYnVNcDJHS0dqRkthWlFSNWU2eVFxdDhCa25uRkVNMWdyS2tSbStsTktu?=
 =?utf-8?B?ZGY2dUZGN1QxZUdRNVVBMzM3S2FYR0pVOFRCR1UwRkY3L3d0RjhrYUNLTTRp?=
 =?utf-8?B?MlNXOFRCbG5VeVJxaTk5WjdjNEVXYzZPUEprdnlyWGxVSTBiUlRUSVdxbjAw?=
 =?utf-8?B?eVlkU3VRYitWaHh2Wmd0b3piUmM0czlnalhxbU5lU0dtK25VMVlVWHFQRWtm?=
 =?utf-8?B?U3o3dFJmdFhVRzhadVk3dHZ1c0p0amtEYkhHOGhjNWVpTDV6OE8zRzdQN1U5?=
 =?utf-8?B?VDhQOHFGTGxOWFp1akZHZkc3MEQ3M1p4NC9wUEhXUktBUUgvQWxBcm02SUUr?=
 =?utf-8?B?OHpHSi9GTGVlWVFlTDhyOGM0S2dhSXRCbCs0ZDB0NXRuMWxURm95RjNyQ0NJ?=
 =?utf-8?B?bkFWSHU2T0VhWlB2NjRkcmZiUWFIYk85YTRQMSszdmlFSm9WQzdXbFduL1pM?=
 =?utf-8?B?eEx1OXd2OEhYbnBMTXY5NVVyRFhHZWQxVkRGZjlZL3FiRElyd0tCcnFDeVV4?=
 =?utf-8?B?UlQweEpHSU9ha0RKNlBaSjh6VW4ycWlUREdCMlhWbm5veW0yRGFMektWZlNT?=
 =?utf-8?B?bFVVVVpWVDBkMC9jQlU3azlBUU5JcGZwZnNmWmMyOWkvWHg3Z3d2aGZqcHlT?=
 =?utf-8?B?RGlodHh4OHNzYWk4c2RIZU91MFc1dS90Ky9vc3F4d3FZNFdXejc4NXJaejBE?=
 =?utf-8?B?NWp0MHZESEU1dG5QcGduSm45cGE1Q28yOGNkNmp1OWRRYUl3V2M2U3FrQlFp?=
 =?utf-8?B?Yjg2emJWQURXcWJmck1jV1ZBdXZVczZUeE5YZjFTYnpLUHBNa1lFOWd2emNQ?=
 =?utf-8?B?dUpIeGFpNjFhVVZKSXIrS2FUdzI2QjVCWm5XTmd2ZUhKU2xvMW5zL3Y0anRZ?=
 =?utf-8?B?Ny9Eb3Y0WUJHbDgxTkU5WEs5d3lQV2FCU2ROcnk5VUV0ZEloaC96U3NHODBS?=
 =?utf-8?B?alJCc3h0bkVyYVI0Yi9CeHpOdVhBVDFMb3RIa21Nc2szMGlTMmo4SUFIWER6?=
 =?utf-8?B?ZnN0SjlKdldHdW1BT1VQUUZoWmxIbkxDWG40d3B4M25Cd0ZmZXBLbG9sRUgw?=
 =?utf-8?B?eloySUw0dnhBTDFoZ1Rub0V1cmZ2M1orSTJoYmRKekovMk11cWVpUHdVMVhR?=
 =?utf-8?B?b0pYa0JLOVJ2Z2MxVmVUSkhaM2lOZm5Eb2NNRHhPWk5NcG9QUi9hdkFGRDdw?=
 =?utf-8?B?bzcyYmsxTWRwY0Ria1dQUjVrMzRsSFVDazI5SWZNRlN2UlRuRnJkTitTN3I3?=
 =?utf-8?B?WlZwVDhYajgvdVk2Z21XOVNVdG94WWVnL1d3Y1l5L0hmRWdhV2hOY2hicCtk?=
 =?utf-8?B?MGxIK0RsYyswZmwvdkQwaVBuSTBGYy9IMzloM3RoVGlnbFcyc2J5QmVQZkNC?=
 =?utf-8?B?WWdNNnFNbWxPK0JLalFmWXN2eDdWSGJXWnFBQ0haY08yK0RxV2xLRHlLUVF6?=
 =?utf-8?B?NUhCVm1yM01abXB5aXVuZVNReWhOcng0REExUkFlRyttVkF6aUpyNHNQSTBm?=
 =?utf-8?B?aUhnY3hHODA0dTJzdDBVVzU4TXRNYjVIcUlESzE2cFNoRXJDYUdBVkp5VmFz?=
 =?utf-8?B?KzRIZHIzU001Vy9BNjIzQkRKdXd2RExLQ1g5VGFiZjYxTDZQNFJtaHB4aDZ2?=
 =?utf-8?B?Wml6UlpRTkdPM0lXbncvRU11a0ZBUlArTGpzbWNaV0NwRmk1K3lIQkQ2cmd6?=
 =?utf-8?B?ajNIRWM1emc5cGVnRVBnL2xIREtGb3FkcllyN2Q0RXRaUzdnU2xjU3g3ZGRq?=
 =?utf-8?B?Q2RneFYxRDQrcmRzeXZjdURYNS9jY0xMSnNOTXo1cDFENFhlbUIvY21hak1r?=
 =?utf-8?B?aXM1S3JwMXdvU2FGRjNSS2R6UC9RM3prZFY1ZHdlRE00VHRNYkcrb3ZVRnkz?=
 =?utf-8?B?bmpvVklwMlpKdE5iRmFHZStsTU5JcjRadXBxZ080RXpGT1NkK3BZOGR6eGVo?=
 =?utf-8?B?WmcvbndMQmJGRzF2M0Vib3NLYkJwZ0VxQXcveEZOU01tUElwSkw1RG5LeElJ?=
 =?utf-8?B?TVFOTE44ZmwwM3RPZXlpNU9rUEFZUG92QTFXbWV6Z29YNXhrVVZXWTI4RndZ?=
 =?utf-8?B?UXJaNHZQKzEzRjJTa0dFcWJSOFcrMDFleVNKck1VdGVCTVRzWjU5N2puL1JC?=
 =?utf-8?Q?/PZeB2wGVSZEMmcU2fGcFT9R6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf00d531-55dd-4cd2-d21c-08dca749a807
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 16:49:57.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk8Bz2HZv/CfCV8gGvqUJGL16uUBHeLrRk64F1YeVvIUUkKWbkrpWylieAu8BXdNBQW4KQv/2K8EE2ZEdaGnHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088



On 7/18/2024 21:13, Yazen Ghannam wrote:
> On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
>> Add the new PCI Device IDs to the root IDs and misc ids list to support
>> new generation of AMD 1Ah family 60h Models of processors.
> 
> Please be consistent with formatting.
> 
> "Device" -> "device"
> 
> "misc ids" -> "misc IDs" 
> 
> "Models" -> "models"
> 
> Also, you have "0x1A"  in the $SUBJECT, but you have "1Ah" in the commit
> message. I suggest staying with "1Ah" as that is the format used in AMD
> documentation.
> 
> And "v1" is not necessary in the "[PATCH]" prefix.
> 
> Furthermore, if you CC the "x86" alias, then you don't need to CC the
> individual x86 maintainers.

I used get_maintainer.pl to send it. I can remove individual names and
send it only to the x86 maintainers.

> 
>>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
>> being present AMD PMF/PMC probe shall fail.)
> 
> This comment can go in the commit message. Otherwise, it'll be lost from
> the git history.
> 
> The comment is helpful in that it gives a reason *why* these new IDs are
> needed.
> 

My previous commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD
family 0x1a") included this note in the commit message, but Boris had
to trim it. Therefore, I excluded it this time.

Should I include or exclude this note?

I can do a re-spin based on your further remarks.

Thanks,
Shyam

>>
>>  arch/x86/kernel/amd_nb.c | 3 +++
>>  include/linux/pci_ids.h  | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 059e5c16af05..61eadde08511 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -26,6 +26,7 @@
>>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
>>  #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
>>  #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
>> +#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
>>  #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
>>  #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
>>  
>> @@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
>>  	{}
>> @@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 76a8f2d6bd64..bbe8f3dfa813 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -580,6 +580,7 @@
>>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>> -- 
> 
> I can confirm that the IDs are correct.
> 
> Besides the formatting issues, this looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>>
> Thanks,
> Yazen

