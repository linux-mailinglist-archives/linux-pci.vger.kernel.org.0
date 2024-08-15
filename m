Return-Path: <linux-pci+bounces-11709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE6953902
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C65B250D0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE340862;
	Thu, 15 Aug 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o1h8la7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718C1AC8AD;
	Thu, 15 Aug 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743104; cv=fail; b=knVpchZ7LBbxAiZYMuATbt5bKb+3KH/6caYXyuCd4xlezzKtObbah0OLFpKn+cL0Cn6s6iVh7xvxbka1mAPU7r1lROkfZZ59rfTkVGNDVmV+/F3Q8Mfsrq0gmqVteR3hCUWTSZTTj0SXnMDLd1e+Z4WXZWyiPZ4W3TGJM9ORXIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743104; c=relaxed/simple;
	bh=LCbfWUPPHte3gDB7irBWRGLRCB2YTF7kLX3ULLNbCo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVmxXOJ9Mjdahq+Xi2PuXbsLvohDyVXXU7ToPt0J2c/ps6u37dYRft9kPdVuDRa6ei5dGMtGr/fu3oq0Pyjgkj+wKP1Wwv0M6iN7SAhmbcSz5JgOD0XCyNltO3aPb02YVOYlRdKdUllSr4/njxjyVAwi/VsocuwvlkWAMzVOUvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o1h8la7L; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPZIr8uA7+QxT7+TYq/6qjOmgOGgfdRJE7gUN+d+T6I7/BCsNGagcGzkHAZqwaqVkzlnVjEP8qgyAkKELF9PFXke3PM2ZLDukT+pONsqnyNPdIEzpAh6O3uMtSvj51hdKztPsQaOHdNsr+u61Z55RJrCwJGSnfagGL4XnI7qw6UWYVvfa/LJzViexBmIOUWfZ1bqe6Z9xspckWiX5O9kJxuwEtk3tfNz/7WI7ULdNFEIaynsDFb5lNmjimC9hjvgRtriSZH9o+aLP8PicNf6a39RKQayOxmj6FiJwLjRfZToUwpza0CJ/2CruICEd7RaFW6jRPXpQQuDOmVUm7rS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwHAcEEkh8z6eqax48v7Rq61mU+rxTj6IESWyR+YTuI=;
 b=IK2t5iGsEt/Y7aL0UYgo/Tj79byE6nuw65EeoT5B+GCnea2OiPO8qKZMR89e1zV26MY04EgFr7zvTNV+lM40TpgQwxFcw01zVq6RE3ZIk6Fxa/B/zSMSctxePjKzbT2OPxdQykSiG8nnWj2a6GcVgIOxkQU2eJvDYVb/3NCKd1xwHs11jrUEs5somWtCV3E2RrWBivNUo/IzNfjCxNHbMcoE/7YdAJ4spY+OZsiQYIHCYMfrLp50ND0LLhPM2b1hX437hxKtWngcx1YH7T5swF6rir6AcVzSdmIoN2d45iRgl2M5vyEgov2AC7kiN1UM+T2avz+i0Zm5/7R2Z60duA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwHAcEEkh8z6eqax48v7Rq61mU+rxTj6IESWyR+YTuI=;
 b=o1h8la7LGwfXOCLm5wL2ZedVkxLfn7e38LHuJTmttpGLicq6rj/rzNKSjTuHaY22SaBSkYpNp3jIwZQx4LWgRiPtfWyYqBGUNvwCi3ArOy/Rnt1w4C0ZpTWIul+TXvb3dal+dqhIOnYt4R2YaBR5euEVlXwIhLufLJZa6J98hyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 17:31:39 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59%6]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 17:31:39 +0000
Message-ID: <43994d76-aa1c-4c59-9393-1fd683e20d59@amd.com>
Date: Thu, 15 Aug 2024 12:31:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/amd_nb: Add a new PCI ID for AMD family 1Ah model 60h
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bp@alien8.de, bhelgaas@google.com, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
References: <20240815165454.GA49023@bhelgaas>
Content-Language: en-US
From: "Gong, Richard" <richard.gong@amd.com>
In-Reply-To: <20240815165454.GA49023@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 89277f73-d4d3-4345-dadd-08dcbd501eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlJVSEpVVXQyTUdBL1RQUEFjSGgzYUNFWHRqL3A3NmxWQ3pkYXZ6aUpKbG5O?=
 =?utf-8?B?YXlaZTUyaXBUeXIrQk1GV21xQjk1Szd1STZnWlQzSWluaVpOaUNLeVYzTlNi?=
 =?utf-8?B?M3M4bXVVMmZVYkhSbEh2OE5tTnJHdU4reWl1TjdkdldxUEV6Ulk1Wm1MTVZa?=
 =?utf-8?B?alFOaTZRUTQrOVk3UTJZOW1FN3NYekoyNGxvODB2SjdveHllVHpESVNKeGdy?=
 =?utf-8?B?endxYTVqVjJUa3hzVGE5aGZVSC9TT2ZrNmxNSGFET2VPT3pKTHpBM21DbWcr?=
 =?utf-8?B?VnZ3Qm9PZ1Fpekx0enQwRHI5K2NFazNpVjN5eFJFTXJMNzNQMHFud25UUWU5?=
 =?utf-8?B?eE94WS9yd0FjMnAvRWxqSE8vRitkTERTUmlCUHB5SVg5bzJHeWJ6WEluTFcy?=
 =?utf-8?B?RkdzczdYdHpNV1FXZUlNRm9TQWIySStlanhsYWwrOUpycDVSZ09YRklpaUhK?=
 =?utf-8?B?WFYxUnJzM3ZKNFhabXBYWnFBRWV3b0hXT1FOOXRLUmt0ZXhpVysxTTRoTjJs?=
 =?utf-8?B?aEdadGpldGtwdWp1TzhwcnVXTGhqV2NYaWd6eDVKZWhURmlYallERVZjRXBD?=
 =?utf-8?B?a0IxU2gyc0JxY21hRXNyZy9lOE9KbjgvYkFHSndLTHQweXZxOHJWajlSbTRU?=
 =?utf-8?B?QS9oWG5ybktRMlp3aWdOMHFCWEhFRU9ucGJVQTRLbncxYmZVa3hHdDkyWGZr?=
 =?utf-8?B?NDRqTEh5T2JsTXl2Nk1UaDd6NGZhRlV3Vzk5Z0N3dlREQStnV2UyZlV5bDRO?=
 =?utf-8?B?YTI2R1piWDBHUFJMWHg1MGpOS3dGOFovKzMxZGp0a1hJRTQ2S3VSc0VoMUFB?=
 =?utf-8?B?d21NZ3ZuVVE2VGhwRFpMdXkvY2VlTXVXUWpOUVlUOWtEb1ljcEhaWjRkVU4w?=
 =?utf-8?B?VFVKS0lMcWhxbzdiUU1uZ1VsdzkrekNFd3NOQTU0NVNnbjVIWEk3aUtMKy9p?=
 =?utf-8?B?WVZkUVRLVTcrSUROa1BDWEVGNWkvMk9sL2JjSE1hZk4yNFlGNGROUzJ1RURq?=
 =?utf-8?B?R09BVDI5WkZlMnVib1Y3YUJCancrOHEvTlhWalFta3dlU3RaSXhPOFpoSVd4?=
 =?utf-8?B?OU55ZHlEZm5ITURPRUJHaDI4UWJMTlRhWVJZUGJvN0NJRVZhMFE0Ym5TNnBx?=
 =?utf-8?B?N2pRRVdaeEZ6aTYxRWd5aS9sbk45ZnltRG9ielpsY01lN2huNjFDVDl0SFlI?=
 =?utf-8?B?QXpxc0JGRkZCYkhYTUF4c2VLeGVaOWhWYklEQkpxZmpYNlZBVjF5TCtNOEUw?=
 =?utf-8?B?eWl5OXNXbVBSWHk2WXV0UWhMZ2xiMUM2aHVYRnlUZUo1S1ZIc0VFT1JGdit3?=
 =?utf-8?B?TGs3SFFDQmpOOHRmN0ordHh0QXJjRWt3c1F1eFJNVUpRWncxc2hsUUJseTll?=
 =?utf-8?B?YWxRRXpWeWN1V1B1YnkvK1JPVTc2TzZJeURtYjdjbVdmc2d1eW4razJ2QnJV?=
 =?utf-8?B?Z2VxQXRvbXptM0dYY2E3UWRwWTlMZWFsNGFJYW1Xekc4Rk45U05QUHhoUklV?=
 =?utf-8?B?ZERkNklqMy9uUG43dStWYlhYZnFHOWt1c3RuZDljV3ZqaHBQTVpNT0x6VjJ0?=
 =?utf-8?B?Uk9GL1NOV1FyakN1SlJiQnVXN1FoVzY3MTE0cWlrTEpRbW5qMVZ2S2JkcUts?=
 =?utf-8?B?cDNOdGpsTTdidlFzdmZxcnozanFEbFpIVTFMWWtQUlExbmdBZVlpVThCZjZj?=
 =?utf-8?B?eEVXUU9LY3dmZWF4ZnByQWUvL0NGUVZpZS90b0t4ZEN2VUlOWTB4eWpUaXdW?=
 =?utf-8?B?bXRWUEpXMDUrbmVRVGExcjJuUzVjWW1oU2xwQS9uTTQwYk9jZFVaT1Q2UjdR?=
 =?utf-8?B?OW5XTFZhNFJKci9ld1J3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RPbHVsVVNYZTU3dWVId1g2UlhGT3VibjJlNnZOTlY4dG5pN0dBYjRUVDJv?=
 =?utf-8?B?VGw5OVdsUWxJSldCZHdXRXp4OVUvRncvYUpTRE1DdjFKTjZ6N0VCMlQvZFZ5?=
 =?utf-8?B?U2hkeU9GVHNxMG9HSCtqdG55d0hqeDcwcWkyYy94Nm1mT2NYU2FQNzlWZDU4?=
 =?utf-8?B?U3o0eVlWRUJjMll4V3VISmRWamFmMnZxSmFJTEdSeHQvb0p6dXBrWnB6MVg0?=
 =?utf-8?B?bVVXZUZuWElCYVppa3BjSFpIM3MwNWxPWk50c2VSY0pxMzNHQzhKVDJCY3V4?=
 =?utf-8?B?Y1ZXMW1GOXFieDhGMDF4aFNPTlpBdTVBSlZIamEvYnFPNWdiMGhmdjlYcGRP?=
 =?utf-8?B?ckdRQU9Wa3RZQldzenhjSWhydEZPbnpza3M5WG03aUtZN3dpcDk1dEZKSDNE?=
 =?utf-8?B?Wk41OExGZGJHS3Jxc2xlUjk0eTlWaTJtdGs2SjBpb1ovbUFIM2FlcUh1Ni9U?=
 =?utf-8?B?a0dNaU80RWJ4dGxPYTl1dTV5YkdxcVBtZVJhSFN2TTlBSjgzamswNDRRWThn?=
 =?utf-8?B?OGowY0p5UENWNUJLVGtTNkJsM1NkY2lSYU1kRGNBQ2EvSytOVzFoVXJZMVJs?=
 =?utf-8?B?TkxsK3o1d25rODJMN1dqZG1zNHZQb3ZjT3RDODg0TzI2NHFIeVN3T3dtR1VJ?=
 =?utf-8?B?aks2bCsyZkJycy83anRndHF1N0lMYTQrVWRPU0RsWmNoRDdlV3Q0a3ZsSTBH?=
 =?utf-8?B?VVZEODlmQzVEcTFsMnF4eDFtamJ1TDArWDVpZlh4UDdVSFJSRWRIRDlobno2?=
 =?utf-8?B?alRDbkh2SG41L08xS3FLSVduZEhNbkwrSWhKa2FnZU5SOCtUak5LVnRERjg5?=
 =?utf-8?B?VnFrNEV5TDhiL2Fza1c1VUppT2xGbmEyNGRxVkxXTyt0U2M0WjR2ditpVlVV?=
 =?utf-8?B?Z3VKNk13enlpSGdFdkd0RXdKN3VRejU4SHBXb1J6N3VmT0xaWGo1M0ZtNmZ2?=
 =?utf-8?B?QVE4eDQxL09UTjc4YW9zVlBJTFZSTmVrZEoyT0R6M055eFdkMlVoc2tkWXRs?=
 =?utf-8?B?SXBPc0k3MFJGT2syYmhzakcvZmt6dk9OeW4yaVVFMjFXWUdMQ1YvWDNXRlhX?=
 =?utf-8?B?TnE4MW1UM2FaYmdRMVhNZ29ScmhpMTVvSkQ4RUpld1RpMDdNMDhuK2hxMC9i?=
 =?utf-8?B?WG1semtuYkxZdU9vWm9NS3VCRkJqWEY4NkljWVF2Q3U4dWEyMUl2ME9ycllo?=
 =?utf-8?B?QlNaaFhWWlZCMTk5UnNTNnd2R29nSUJjN3hBVTN1YWV1M0cvQXVSL3lHbzlu?=
 =?utf-8?B?OU9DSXU0SWs4T1pWMUdydjJreFlBNnhEWTkwVmNpbTNQMDZFcTBaZXpCVlB4?=
 =?utf-8?B?VHQxblJQa2ZpUlc5OFhwbE9vaDBXTEh3dEhOQkljZlVPaDBhZUh2anRGRnpD?=
 =?utf-8?B?Q2dHR28wTlV5RmlsMG54cWkwSnliZjUyd25adXZVU0lmTkwyVGhGazhLQTRJ?=
 =?utf-8?B?WVdpWnVpUzJ1VkhqVUNvdlV1U1lFc0R6UytWZXhjRndTNGhDRXRmZUdCMlQy?=
 =?utf-8?B?cXBMRUNqZVp5Zmh6S1owS0hOTjJqMVZ5MmFUUzVvc25zOE9ONDZGYkNQNXdo?=
 =?utf-8?B?MnN1K2tlN2RPUTdjb1JiSlB2T01YSnU3TTBRb25yVmVyMmVxa1ZJQ0NjQ1lj?=
 =?utf-8?B?d1dxZ1BFMVpOSEw5WjhObGRKM1QzdUxadVFsMHYrYUZ0aitPaTByeFFvZGxD?=
 =?utf-8?B?ZEVETzRGZXZ2ZXIzcHhpN1JzZ3d2a2dyYlRkVW1kYldLN1FoYi9hd2RKYnBn?=
 =?utf-8?B?MkZFVmNld2d1WCtnd1lLc2MyUEo2d3BoRzFicERJbGlZL3N4Q3NqU2tLZHBZ?=
 =?utf-8?B?T1drRVNKcjBpaEIwM1l2Ulpiem8zRGFoR1AyWVZXbkVjanRGd2VtcVdEcFJS?=
 =?utf-8?B?cDNmVk5EOWc3S2V0a0Q5UGhIWVJNZ1hJZzk3ZXlUd2F3OGN3Q1lmYXIzNlJu?=
 =?utf-8?B?U2Fpdk04VWlibS9HL2V3RURiNXlMRlYyb0lSQ1lKM3ZaT0g2ZFdBeFNUdVlQ?=
 =?utf-8?B?UHRUMkFBRkJqemtIOWR4UExCdnFjL1VhYTArOHRodFhZSEllL0NHa3pmdFY4?=
 =?utf-8?B?VmtONExMMSttU05ZbGROY2IzLzRPSjlJY3ZTbldBSHNsU0JDSk5xWDFxcXJ1?=
 =?utf-8?Q?oH5kW3che/e6d4GXZq7VBGWlb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89277f73-d4d3-4345-dadd-08dcbd501eea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:31:39.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9iwuZbOE00Ss11tQAIVgZTOKkhvIIFqii/AEyfw+LrAlhOz5400T5iEW1WHAfQuv5SxePaQ84xI8VbrNZe+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

Hi Bjorn,

On 8/15/2024 11:54 AM, Bjorn Helgaas wrote:
> On Thu, Aug 15, 2024 at 10:12:40AM -0500, Richard Gong wrote:
>> Add a new PCI ID for Device 18h and Function 4.
>>
>> Signed-off-by: Richard Gong <richard.gong@amd.com>
>> ---
>> (Without this device ID, amd-atl driver failed to load)
> 
> "amd-atl" does not appear in the source, so I don't know what it is.

Sorry for my typo, it is amd_atl (AMD address translation library) driver.

> 
>> ---
>>   arch/x86/kernel/amd_nb.c | 1 +
>>   include/linux/pci_ids.h  | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 61eadde08511..7566d2c079c2 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -125,6 +125,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
>>   	{}
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 91182aa1d2ec..d7abfa5beaec 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -581,6 +581,7 @@
>>   #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>>   #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4 0x124c
> 
>  From include/linux/pci_ids.h:
> 
>   *      Do not add new entries to this file unless the definitions
>   *      are shared between multiple drivers.
> 
> Maybe there's some value in having this definition in pci_ids.h as
> opposed to adding a definition in amd_nb.c, where there are many
> similar definitions?
> 
> Can't tell from this commit log.
> 
> Obviously this isn't adding any new *functionality*, so it would be
> nice if amd_nb.c could be written so it would require updates only
> when the programming model changes, not for every new chip.
> 
> Preaching to the choir, I know.
> 
>>   #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>>   #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>>   #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>> -- 
>> 2.43.0
>>

Regards,
Richard

