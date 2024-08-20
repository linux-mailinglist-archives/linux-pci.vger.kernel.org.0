Return-Path: <linux-pci+bounces-11904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5D1958F66
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159E51F2280E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA614B061;
	Tue, 20 Aug 2024 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YETrMDkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF249626
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724187715; cv=fail; b=MC2hZgwSMzvxxjI2aTGzeuhRrv2sDl8BmGtjfZWjarEs5Hs7amyRuvoaipDkWvKh0M7nUvU56a1rRbNPIwnf4j4jG8aMfJgXhr+63+Kd0a9eHRWAOPXArWh9sxCrz+J0YJ6+8Q8j5WcoLY4p1d+JuFUMajJblwyC27qSh2qBzHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724187715; c=relaxed/simple;
	bh=+PizGFl9aKF0/dC15YCcCs0NhC2N4LtBiHhDvomqk6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ij+xUxDMWdnTGSu5uCBGue2E9kVR2zWMQrV9NQjGeGZOfnaO+pfV0ZFtbIM8O1VicDT+ctp1udbKxiju23ClFJWZa8bbCRsF74vk9A463hoGSWQaBi0I5nzBL25CwkUe6/btF8hTlf1VsP1WFoZb/von9arI1h4aME2NcHv4Zds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YETrMDkV; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeVE57Mg52Kkszd1kQho+2dRdFoWM9xg1Uwfsr71i8pWRDcKyVaRdPcaG2XCRH/v5ju72+MqEZG1IunLDbZFrSxIigqWVry0T8McK1XQ1AEFa/8JrYdNr3+a19WEnKOeWCmTcjOB3IhwSy6grntnqD/llxPdXM8GFbchQknjILicMv+/rz20i2me4XvGh8CRMuEWYBrGYyP4M3SB0pDroILF+ud4kKJ0J0cSJi8hEAdei05KBi/pFKvSAi6uBXNgxxKMM9xkKPGtKUoP2bfaLylK21+bLgcvRBQANF9GUjteNzmmb2BJ7+hmw9ash2Q7eHRTEItMhCK+Lf1duVAUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebun0T8aGHHzy4tOYPeBPTUdry7ssm+15GP/y3mwk+U=;
 b=FNrw/qKK2Al30G3BG6v/tlOvt6GfsYWfuuB5Wn6+K0NULpHDxGaDncUAJ9nt/m78SDxr41Ev28g+UIf7kFl5+mMqOaxgmSqt27UvsrRcWojcsO2Gk81czf+imKE5mYxVRY6dbcdYYe0+q8GTMrRt5StQoVXApaMeKvnGFM5nC10igEgRx7/3YW7E6izK2O/zamubrfDAC66w1lSLcTmLppp+A5En4QEMTPQsCz1z0/8MDh2/SGzHKRz3kzZismoAfN2DnTmrTYZufso7Z1MjXLUm/A5vl4hzlX0BhH/ZyI8ArOiobJ2GLf4wa2rLwq/4a7hhy6hPfxNbZ4tIJj471A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebun0T8aGHHzy4tOYPeBPTUdry7ssm+15GP/y3mwk+U=;
 b=YETrMDkVE5Efak+9bIxnwHG1RaKJUOJTGJSm4oxFLE3Bpz/f+8m3M6aojRIETEjHSt7l3ce8G/WtkWTNVF8jDJrtHIyLSXOAqU+LMoIlUE46UrbVm620pFYc4JptjwZB1Gp3Cl5gp3SMdchuOZZMYuc/tIgBhggoLuSdrw0M72E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:01:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 20 Aug 2024
 21:01:51 +0000
Message-ID: <37796ec8-12a6-4807-b19a-888afee0777c@amd.com>
Date: Tue, 20 Aug 2024 16:01:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/PCI: Fix Null pointer dereference after call to
 pcie_find_root_port()
To: Bjorn Helgaas <helgaas@kernel.org>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20240812205159.GA294028@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240812205159.GA294028@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 45571a11-d0fc-4628-ed84-08dcc15b5002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmdpUzBGVVNiRHhVekV0VFVvdGZLdHJqTEpOUXNUWkxYWE1ZQU5DdWMrNHFU?=
 =?utf-8?B?TGlranl0V1hJZkN0VVg5RWhyS3prbmU5QXBpMGs2aWpOR2hOUVVrUGtGVkFa?=
 =?utf-8?B?TnNic3loK2RQeG41U1d3TnNRdkV5S0ZhcmJ0OUxjNkhpL1ZIQTZXRmtsOVc5?=
 =?utf-8?B?dzdSSG5qM0hFTjJlOUlDelpPSWNvdEdDeG9yZVJJdW1Ick1rZmllYlA0Y1p2?=
 =?utf-8?B?bGhnbWZSckhXNjlsYTVLNlJIVVNiOWpQanFtM3J6ZWRQbjd0QVdUTEN4UXEr?=
 =?utf-8?B?Yk5SZTUyZFU2ZFFsa2JMR01JRzI5Q1hSWnBNY2NqTE0zK0FyMmwwTE9ZY080?=
 =?utf-8?B?Nyt6dFoxRGJaSTF2UEh3Rk1rSTBJbHpmMnJTaG1oL0lmVk81aWNZZ2JIZVFG?=
 =?utf-8?B?L3lYbEpQUG1nd3NDaEhGOStsbVFwUVBhNzBBNVN2UTZUUmJsSzhqV0p1VGxJ?=
 =?utf-8?B?VnNINmNEd0J2azNJSTVMck53dm42UU42WGUzN09EdGFxUUh1MDNSU3VmQUZp?=
 =?utf-8?B?SXhZc2JqRFNKUVJCZVZvekE1U0pXY3h3cnBzT3N1azhESm1WbXFQN01lb3N2?=
 =?utf-8?B?L1AwVktLSy9GcXpzNXIwRXFhTkEwNnkyOWQ3UlorVTZyV1I5bnFUOHBjTnlu?=
 =?utf-8?B?YmdqcDBwejU5Z2JEc0dUWWk5RHhSbDMrR1VVY1AwbXFZbWJvS3AwTDg0N1FH?=
 =?utf-8?B?VkVDOGFsQ3gwNFBYZWRqV2RzeFk0MzNPL3JtWWdjOTE5dDJRVHZBL1R2S3RS?=
 =?utf-8?B?UjZmdncyWVl2TnFSM2VaLzN0MjBBSmQ3RHdHbWNTRFR6OFE1YkZMYlFHM1NZ?=
 =?utf-8?B?VjB4b2NRWmthNGh1Q2NTbUJHVm1JTEIra0YvckR3dW1tTjdYdFkrWE93UjZB?=
 =?utf-8?B?TVh5cFplMjhwYTFvVmpZR3RHRVhpamViekw1UFdpeUlNajVSaWVCYmRPS2VO?=
 =?utf-8?B?dlFLbUVRS21LajhCUzFDcjJJQW5vUy82NFJhbkVUT0tuRTFzUUhxNDQ4elU3?=
 =?utf-8?B?YW4wQm5ac3hCOWgxQzA4S2lQcGZCNEo0UUFPVEs4d3p1eHF5bmFhWE5zVW4z?=
 =?utf-8?B?Z0pQejBZeGlJclBqZFFaZi9JcGg5QnM4bmhxR2xpZmVVYks1cXlLT3VsRnVF?=
 =?utf-8?B?TXIvZE13ZWN5cjM1NEFHcHN5aEdzM1VFY1JPNlRhN1JDTWNLd04waFZCLzFo?=
 =?utf-8?B?aGcyeWM3MkFmUWdDWVNiRmNYOHY3eVYyZjh0a2hhUnJkL3VxOWxCalR3T2Ny?=
 =?utf-8?B?enM0dFN2dVlUMmhmb0lJa2dxSVVyaVlLS3J3UmJpTjVkSkltK2YwVUVNVzRE?=
 =?utf-8?B?cE9KMVlkOVNrb1FoSWZET0RXR1FYV3MyVnpKSzZ2ZXBTd1JyVjdMU3VQU1Bs?=
 =?utf-8?B?MTZOTGVmSTN1dHBnN1pZZVpmVXkycHlzS0FNVGJ5c3J1U3JWOVIxNXh5dzM3?=
 =?utf-8?B?aVo2c2t6VWVqd2MxQUo4UGlQZUpzVDhPaklXWGtVSFp3ZVJKblZ3L3NCMzZS?=
 =?utf-8?B?eUxweVlSQkE1TzBPQzlrRklNQWtYQzIzaitGTE5xbTZEVXVGNWJZenFYYUJo?=
 =?utf-8?B?VytuNW16aFVZZFpXTXkxTDFPSWVXUmczUEZ5RVNsL1d0RW5YNDNtY1c5Tm91?=
 =?utf-8?B?YzUwejBrWHh2K2hYNHZSUlAxc3BINDgyaExYbEowUHVRQkNqeGtXbkVqMnhn?=
 =?utf-8?B?dkJ4Y0JpV1FSZ0Y5ZjE2STVZZXBGa3JyK3VZcXdpQXN4VlVKNkdBaldzc3JR?=
 =?utf-8?B?SERLcDd3R0pncWxUWUkyUFVNSFV2b214RlphLzNoMmRxcHJvNDZEdVBaSWIw?=
 =?utf-8?B?cFNwRkRFZzhZcmhhczhGZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elZNS3V3eS9sZUh4OUZWN0dBZDE4eVp3VGJXWnBISCtkUGZmWis1ekgzTnhF?=
 =?utf-8?B?OFVHR0NPbWxkeDNLeXc3dDU3bkhnQU80R2l3TVErOEJFYzE5dGdSeGdJY3Bm?=
 =?utf-8?B?NnNsS3N6NUxTOWt1WGlJVVdjQ0pCMmVMWjJxOWVMVjFXRWVBS1MzNEJ0MjVq?=
 =?utf-8?B?SHhBdm1PY3JhTDk5cEtpaXMyMjJlbTZxYjB1amxuTFlqN1ZGR0ZndjZ2SDFX?=
 =?utf-8?B?WXd0OG5GcEp6WnhwU3hYeURkU3V4TFpaQ1Bac3lHZ1BsYlV1V2IxelRud1pC?=
 =?utf-8?B?OWU3MStseWt3UFFiRHlSbU5UTUNXQlFvUHJCVEpLRUlrSzZzTVpXR2ttVkRR?=
 =?utf-8?B?dXprbnZUOU90QlFsamx2Vk9hOUc4aTZWR3M4QUVxVUc2b0lET3o3UUNJbzVE?=
 =?utf-8?B?dDB0eVRtZzZSZmtZdDFwd0Z1aTFzZ2tkS2ZVZEhHV2s1RTdHYjZRVzU2dURs?=
 =?utf-8?B?Mkovb0VLWW9lNUY3VHJlYnBESkNUTEFoVEVkRVRhcWdGYWFzREYzRnF5SzJJ?=
 =?utf-8?B?VjFJbllWbWFFNys2WVp1RCt0WkVtUC90QmNuZzY1MnVaSXdyV3VibS8yeWkx?=
 =?utf-8?B?V0NoQy9JYmVhSVZ5eHdPNGxMU2VMTElWNS9vUjZ4bkYwWFhiMnpGY0lHV3hE?=
 =?utf-8?B?eURDbWV5V0NIUUdKbCs0R2lISkNIZW5oUmx2YmtWRHNhVkM2OFlsRysvUDNT?=
 =?utf-8?B?VkJ2RHRNWndQQUY1Mms5UmNBcTVLUlFuWnR1a0xtbXNSS0tvVXVrNXBHY3Fm?=
 =?utf-8?B?UHhUUmovcVN1OUhTZjdaRC8xU2xJSWFYMWZKc2VpV05kdVFFNkRKMEFaSCti?=
 =?utf-8?B?NjZMZjhEcDk3M1ptTEtHbndzWUFLaG53V2ErOUN5d0VJelphVXM2MWRzbkRL?=
 =?utf-8?B?WnFtNHBFRzhUaTV0MlRZMHdhUWlWOU1qUDMxSmxBZTRDaGNaV2w4dVkzbUh1?=
 =?utf-8?B?WVUyMDhRU0dMZ1RUZmtsaVFDdU1JOEJUcjlOb3lrZ3dMVmZPZDd5Y1N6d2Ji?=
 =?utf-8?B?U1UvMGR5cjBieU5LYW4raVYvOUZETHVvY1FGQlppQmNMMzZOVEdKNWhsZ1hV?=
 =?utf-8?B?RmNrV3JVRFpXbzBTVnRNRnAyNERwa002d2VqSG1KMWtqTkZYWFJ2eWFac1NN?=
 =?utf-8?B?SVAvdk9CRUtLVEZKVFRpZkFoRUkwQzZOQjA2YVJZT3pWemdGUWt3NWtzNVZB?=
 =?utf-8?B?bE5TK3NUck1PRVNieGxQeVU5K2lPMUVqYlIrbW9MUElUR3gvYnliSkxuZWts?=
 =?utf-8?B?K1VJbGNLWnVhYkZ6aHVPZUVTZ3JKdFV4YWJIQ0pONXZkTnpPSlp4S2s3V040?=
 =?utf-8?B?TDlqQWRXaDVPemVVeGZHcnJtME5BL1JsSHUzSjhIaEppamR3V1IyRE1Yclll?=
 =?utf-8?B?bDM5YkxDMjM1bVZGd3JHRjl0cW8xV3l3ZnI5NzJyZnVVbE9aemFFSHFubEtj?=
 =?utf-8?B?OThmSVFIandVQUt5RHlQNGIvTzg5QkM0ZGx0U3B0Z2Z6dFJIQUZnS1VySWM5?=
 =?utf-8?B?dWFlTStNL204Rld3TEwzVkczUHFhVUx4ajAxTm9WK2U3UjRVOEtEQ044Rjlm?=
 =?utf-8?B?djBxektJTnZxQnVFSi84OVhoWnFQbXY2UFJnSnVtUDl3bDVHd0FmWUxqZUpo?=
 =?utf-8?B?eEJEM1M0U3FzQlZTcFRQaWc2ZmVLcGhiaGhDSHRWamF4UUFsYzZTRW44MDF0?=
 =?utf-8?B?RE04Z1kvQnNrSkxHK0FnWVF1d0RHRU5JeEd2cFlzUTA5d3UrL0VRUW9ZQ2ls?=
 =?utf-8?B?UU1Bd1lFV1h5elNSL3BsM2pGMThNY0dobGtGbXg4WGc0YlVlQ2VyU3ordTlG?=
 =?utf-8?B?aEpmMDJNcDg5THN3OEQ3YkZoYmVQZ0NBWnRSZllDeTBhWFJKRUlNNUI3SmpB?=
 =?utf-8?B?eEJUSzVOdHJzT0phZ3V6ZnRiaHQzVEtQS3dIUlFZS1pnU25xZEVmR0diWjQv?=
 =?utf-8?B?SUdHRkV0cmgxZnlmS3hLVUdXQmJ2Q2NKTms3WWxoWW9NdkxCT2U2ZXU3RXlS?=
 =?utf-8?B?QWZpbG4zWS9lcy85MjVETlhSUzNRZCsydnFxOXJHS3V2cmVydWR1cWpCdVl1?=
 =?utf-8?B?MFNjaVlSN0VERUdiZ2ZTbTltdFNhKzliR2k4NUZ2cXNHcHZ1R0R0ZFh1TDdv?=
 =?utf-8?Q?nTbbDnZnSkLPxw+DFT21TD2S9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45571a11-d0fc-4628-ed84-08dcc15b5002
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:01:50.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eMIALbZuDcMUw14kT3xM2K0I0pZgOzm1D+29rtjtyM+6dMpFEhpUn7XeVYco4v7Q2pHdm5zj7qRWX7dbsjC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

On 8/12/2024 15:51, Bjorn Helgaas wrote:
> [+cc Mario, 7d08f21f8c63 author]
> 
> On Mon, Aug 12, 2024 at 01:26:59PM -0700, Samasth Norway Ananda wrote:
>> If pcie_find_root_port() is unable to locate a root port, it will return
>> NULL. This NULL pointer needs to be handled before trying to dereference.
>>
>> Fixes: 7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>>   arch/x86/pci/fixup.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b33afb240601..98a9bb92d75c 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
>>   		return;
>>   
>>   	rp = pcie_find_root_port(dev);
>> -	if (!rp->pm_cap)
>> +	if (!rp || !rp->pm_cap)
> 
> Seems reasonable.  I suspect we haven't seen problems because these
> quirks are limited to Device IDs that are all PCIe, but I think we
> should check on principle and because it may be copied elsewhere where
> it *does* matter.

Yeah totally agree, if nothing else it prevents copy/paste mistakes.

HOWEVER I don't think this needs to be a "Fixes" tag because there is no 
problem in THIS code on the applicable systems.  Those PCI devices are 
always attached to a root port.  So Bjorn I would suggest stripping the 
Fixes tag when committing.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
>>   		return;
>>   
>>   	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
>> @@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
>>   	u16 pmc;
>>   
>>   	rp = pcie_find_root_port(dev);
>> -	if (!rp->pm_cap)
>> +	if (!rp || !rp->pm_cap)
>>   		return;
>>   
>>   	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
>> -- 
>> 2.45.2
>>


