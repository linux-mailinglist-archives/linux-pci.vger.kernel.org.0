Return-Path: <linux-pci+bounces-12965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBF9723DF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62473B21331
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04718A939;
	Mon,  9 Sep 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GCVHGSKi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260913B2B0;
	Mon,  9 Sep 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914464; cv=fail; b=R/yEdZvMbeEuR7/syhe6X/nBki+N450/YE9CEHGcETDqhJ9a7WGxVe3qi+y0Dh2TEWnEV6iKb9i77gt4247lYN7vbxmxzpnj5bEU0xX/VYPlG5hlb0Ah6HduKzeoMYmbm2ya7+NrwS3QSq4Od3NiaQTLgjBBftoI3rQs7bXStf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914464; c=relaxed/simple;
	bh=dRJ2rUyIzjLBigxoHMgZwa0lBIpQ6uIXDXdTR9Wh8MQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sx8tW7yGc8S2K8jrbn9b3e97aTZQhLPxL9/v4DCcOJ+JZXR6nv1eUTRgv8MTV2OkPAWIoRQTossjbhymAewZUZAMKKtrenSLjt1cBxO6XR9Y4VUq/a+RIbzVb3kOkO12ZY5vhgVxUa8GJ+cUXawXxGmUnTLkKXdwJhHp9v9mw48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GCVHGSKi; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs8lXpDFoOZT+4K5E5PZRIx6gO/qBxFolgNNFD2OMuDp+X5vnO8YMUxcQhAe/ABltZD4r2VB5sdtSUaYtC+Mprv5pBKi6ntbvn2Pxb6y+fFJ+upTdG8gW/hL50VgFjTVL6drBZq1Pv3NF6KFCXLlcxLxF8CUm3zg8ARjGZBZ6r12yIOOcdEzI8MaWZNM5z6dGo1kK0GeSTJA2WQjD73zCxLnQ+6PB71H1cDY5ejCiLrvHN06411HNEbq4AZ0Jy+rXqsFd1YbqVPXqUyHEBh0i2sod4zkU04f9jO8HaqJChiV6kcFiAo0fgx74zmzBEpSL1cDX86Uda1ykRiK8EapnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRbc+xJB6g9BofvUU2g8NnHRllCsRv7HXcTRDl+SLdY=;
 b=TToulhJ73vd3zZX/kd8zhRf2AG3WF9huB0DKo+h/cIAR+/SXo7mKkFGzcJSyCmwmJhqbYFqlWzgKrIwEtk4v5NE9vDiMd1wk1dKTWBx7B55wTGEohvGGgRQKpyeBIqZXb04nZvemk1ifxf8ZLS5gqoF7VhIwWsOweBY8UmhZOxsHuogRp2oAVCcTDibZnYlXMsL8FPsShav//CtTe3qYYrty3JRgHIHbZmaAg/KRdDq7eP9Sv2pJ30Q2Stc30ws17zZrUyy87EQt7MRlg0cdbLWdxFsxA5yLJT3Zh8yKwCACGUC73n/vCAnq3h5l1vJcYa1aXSuVZM9e2F0JpQhgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRbc+xJB6g9BofvUU2g8NnHRllCsRv7HXcTRDl+SLdY=;
 b=GCVHGSKisKYRtBf5jhgR4iAvyXvNdD71nXYztdgnh1CGeJh4iltrfMphvntRUJUMznEajlKQHR0cCP5r/h2kLBs0YvbkSk1z+9uaCe4umm0nzNj1H+5+sd2buPq3vzE50VRz0/bMPb5U45rFZndVnFqT80KkXU5oayGMxphHt5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:40:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 20:40:57 +0000
Message-ID: <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
Date: Mon, 9 Sep 2024 15:40:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
 Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240905093325.GJ1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:806:22::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: c24ccd30-0f2e-48d9-2b4f-08dcd10fb516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2ZObDZiQ2hVNkR6Qk51ZU5FNXl4SlA4aXNsTnphQ2JwUHFpVU1PK3lYbjM0?=
 =?utf-8?B?YnUvcFN3Qzh5WXRHSWQ0Q1ZzQzcwbU9FbEM1OXRFNUFpMmJGSi94a1JFdlRr?=
 =?utf-8?B?aFE0dDBySGs1TWkxTnViMFNmdVFOUHlUZlVaVWhzcW0rV2s2RlJFZHRCY2lI?=
 =?utf-8?B?SFdXYS9yMUF0ak9jYVBTUXBuTmFZblNIRFptL3ByclFKSEo0aWR4dXJNT2Zs?=
 =?utf-8?B?K1hWZmNwQlZtM3FNTzVIaGpYQ0QvWFdJK1RIbTMrQzlrRnZyNUp1TUlwb0Zz?=
 =?utf-8?B?YWFobmhUSHd0L3pOTEhVbUVXcHNwUkJjQVYwNUp2alVmdTViMFNuUmlxSWRK?=
 =?utf-8?B?ZkhBWHhYdCsxT0FzZlNmMGRUQi85VzZTQnRka1JPUlc1TEFacDQ5VzNFMUc4?=
 =?utf-8?B?NzJITE5UNHJ3NVFabW5PUGtOVjBVeE5ueVZncXBUVEpFNWJteXNXQy9HZjhJ?=
 =?utf-8?B?VWZ4ZG0rcFhDaHg1OWNsVEhSOEtLWUdrMzc2Y3UweW5pWHZqbE5NVTVhcFNT?=
 =?utf-8?B?cnVvd3pFejE1c0h3eVRCZDhucUxKN3NhbHRzWU15dzVRSnMzdTVMWmhTZG15?=
 =?utf-8?B?bmhNT3RLblhYek5OZ0J1Unk3OGhFRWI4OURucy93UHlTcEppRXlrWnR5UlFK?=
 =?utf-8?B?ZHhsc3ZIWHZVVlp1QjJLbnNoZjM1a0pMN3dsTkpmQ3REV2hUYTNoUkYvSXc5?=
 =?utf-8?B?OFgzWjBSMS9EdCtmb3NCVGZtY0NoRnhhVjhzVVk0dlpsRFBxQzRMOTBwU3Y0?=
 =?utf-8?B?Ri9abzZKMml2VzVLQzZjc2RmNCtEZG1WUFJZNVBheUNlMkx6MVNTYjNwa2NY?=
 =?utf-8?B?UmJBMndRUkpMRmxHWFJ5eG9tVUo4SkwvUkVrNzVBeXhGUERRVzBZRDdXRStH?=
 =?utf-8?B?emxrdUN2V0UrcVUrdFozL1VvS0p3QTdrQVd5K0hOTXdVdXdHd1VmVXR1dTJO?=
 =?utf-8?B?eStQRzB2TUVIbGk5RkxuZVI5dVp3ZC9ScUR4dEltMm40NEhWYkVsNXBqOHRt?=
 =?utf-8?B?bzlrUm1VQU9UWkdZQ3VaanpoTm1Ebmc5ZThta0dvdmgrSytpemhobkdLQ09q?=
 =?utf-8?B?aU4rSFFzQmlNL1JXbStYUCtTdHlHbDNiSGtwVTMzdmw0TTByc2xsSFc2NjF1?=
 =?utf-8?B?cGRONitCb3U0bmQxUER0QVFmU0NUbkpjMDhwTnU0d0ZFNHdkbWtJY3VITlBh?=
 =?utf-8?B?a0JSSGNpMDB6RklnRjlUTzZIUWNyQXV5QUFSTWxibjBlQVcrZys5dFMrRUYy?=
 =?utf-8?B?ZHRka1pJNnQ0cm5FTGJ1RGltdy91a3BXeGcwN3hoekpNMVpKZ09HWkwxUHEy?=
 =?utf-8?B?M2Z4Ny96SktadjRvYksxbHZGc0dHVHlEenNvZlRwa1QzTG56RFl2RzRORitj?=
 =?utf-8?B?aGNZMTl0SFNNM0lqSnFraEpBTnhkTUhhQVlvT05aV2RySUFGcHpoL1dDd3hr?=
 =?utf-8?B?dnBXTDhmQ2RLcWNXR2g3cTkyYXE3VEhlSG9iY3R0TFQ2anhsS0NFQVJGWkJv?=
 =?utf-8?B?a0cvNFBQWkt1bUF3VHExOXdlKzEreS93RHJETDhuUTgvRmE1VWxyYkZVanFr?=
 =?utf-8?B?S0VUQmp4MzRxK3o5VUw4Q25IM0dKM053a2ZSTzFmN3JLcjRZT1FNZnB0TzMv?=
 =?utf-8?B?cTE5a0NTcTBNR0VremJlbzF6Zll0QUpKYnlPRXhrU1NDOHV0a1BKQWQ1d0pC?=
 =?utf-8?B?THk1Q3VyT3Z1NUYwZVdGL3krMGRQRWpxQjdsdUdrU1Iwdm50ZHo4cUd1eWMv?=
 =?utf-8?Q?l92wKPU6j3ORRZtt1EU19OSyn7JifYFGRXVW1VI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHFueGZqRExubnhFZy9kZzROeGVac1YvL0VnSUx4aW1xc3RMM3prNnF0RE5C?=
 =?utf-8?B?TksxMWFXRzBjbCt3VlArOEJCSDJWektod2tZQXZCUGJuNkczMzl2NnhUb3o3?=
 =?utf-8?B?RThnaGZFQTB0VGY4dmVESE0zL0FxMnBFVmFQVkluU3BPY01icjhTa1Z0Unpj?=
 =?utf-8?B?dmhDWUJNVFRJM2xNNzRCNmtVMzBGK1kraE1ITU9yb014ck9uc3BEc1N3aVky?=
 =?utf-8?B?ejAyUjVnT1NDVUxCVjRFdVhVK2pKWnhCU2hiTUduMXQvRXFnZDQyOStOcWkx?=
 =?utf-8?B?dVRxc3dzR3c2cWp2N0hVNGlkdnlEc0ZBNjAvSnlQVU9rc1JaaHY4c3ZSbmx1?=
 =?utf-8?B?R1dSRWFqdGpHVEloaVBGNTJoZ2wrNUNQdG5MRmxFR290UXZaUDVBVDJyYThU?=
 =?utf-8?B?UWx6OWFCN2hGek14MmRIVnRYazM5UkxKMnZmVll2RXJWU2YwVHlWSlBFV2ky?=
 =?utf-8?B?OHIrYW04eTRyMlovSDdKdDBqSHBsVmxMYUdPTWhBT3JZWUQ0NDJrS0NERGtH?=
 =?utf-8?B?U3JleitZdW80ZGN2WHd0cjkvejBEL09SWFpjdDIvam1ZU2duVVJ6MEk3TU9N?=
 =?utf-8?B?UzZidVJjUFhWYllMTDlUa29KN3ZxcENBMGsrd2FiSWdBWWk4NDBtbnphRk5w?=
 =?utf-8?B?RWEvVDFQYVhLRDR2bndJR3NpZlZZTTNhUjJ6R1ZZZlZxbGVaYjY0NHNnMmxH?=
 =?utf-8?B?RVY1VmFBYXhpWVI0dXRoRnJoRW13WTN0RTNLT0drVkxJek96RGN4ZS85NnJY?=
 =?utf-8?B?LzFPWmwzR053aWZyVGszam5wUUxkdE03QlQ4b1FRaFFMVXFSMmZXT01LUllC?=
 =?utf-8?B?SzBVOCtpenZLWURpZ2VCMkpyUVdwaWxHRHJLRUdXaHp1WjNTWkdBeFg3Rmxh?=
 =?utf-8?B?bWg1YzdjRXRCd3E2WUZvQW54T1ZqL2FlRW1MVUFBclhmbkpobzRjdHNDUGN0?=
 =?utf-8?B?bENVZ2diQytycmJsMnprNWw4M1VTbW9HYTdZV0I1RjFDS3REWUozVmVrSXdO?=
 =?utf-8?B?RSszZ2Nmb0JOWjF5WHcyaXFGNjJvTE13cjBCclJqdko4NWFidDFzcDJ5cnBU?=
 =?utf-8?B?TGZxOThxOGVwMmwvSUs1QlBLQWh4Qm5OVjdlSEQzQk9jYUxMekRtN0NwWGEr?=
 =?utf-8?B?bnBTV0xkZElaMzFyeElaMG51VXNRVlVEbUlwZ3FDZTVGc1RLUFd1SHVPTHRT?=
 =?utf-8?B?eWU2UGQrRWNVKzF4dm1OUGZVMUJZWGNNbVZ2MzYxd2ZnL21JQUNGczUyWXU1?=
 =?utf-8?B?Qkl5OHhLSjl0Y01LeWNLU2p5akYzTkhaS3c5YnZSMXJOa2tmNmsrcWpaeFJs?=
 =?utf-8?B?T3RSU3pvZjhDNjZIb3Z4RmY1dDJRaHBZWWR4bnNmK2ZoS0xha1c4d3dnZm9u?=
 =?utf-8?B?NUdaNlcwTE0wQ2NxR0hXcHRkUk9hbUMvVDV4QWJJMy9OWlpmQmJVZHpkVk9m?=
 =?utf-8?B?dHpYdDM4MXpkNjArYVhuQXhVc2JleDA5MGowNjUxcTBGQkdlcnB2Sm1RSnRW?=
 =?utf-8?B?ZTNOMlVnanFnQ0YwYVVQUXVKMDBjVldRK013Y0lNRnpOeHNBZnZHNmJ5WEZS?=
 =?utf-8?B?VTlYK2V5U0FiWDYwQnBGT3NFSlQ0TTZUWWdISkZuMTJLVGh3RGdGZ25ucU91?=
 =?utf-8?B?VGQvb2hqR3BLcWRadG51dW0yY2xFaEFPdlkxOUlPTzhNeG1OOEZDWEVnTThQ?=
 =?utf-8?B?NWQ5ZWVVWGNsZGhhalVqRjVGSVBXVDBpN2EzelZ5SldlQ09ha0FlTXdNZklQ?=
 =?utf-8?B?ZzIwU2hZWXFRNi9lN0dUTWY5dldRSjNTTnY2RXVQa0ZWcldsWHBKTE9NYk1V?=
 =?utf-8?B?Nk0vbENKemt5LzZDMHJKK0tiYWxCdEhjUTBOMU1DTnpwWHRHdkZWcmhoM2Mv?=
 =?utf-8?B?TGxDUmJZS3d6MSsxTEt5elZ4NGdoOWQ5V0E1S1l0aktnaEZjOFJqbGIwWUsy?=
 =?utf-8?B?UUFYU3FpaVN0UVB6NXJ2REVSekswN0FKY01qQVhZdnNPRlQ3YzVIK0xYVUVX?=
 =?utf-8?B?cFphT2NtalVUaDI3d2cxb2ZLbUpCZHRwOXhrTitjdHEzOEI2VUVsU1p5c0Zn?=
 =?utf-8?B?VDRsMktLR2Z5OXNjRitRNjhJS3ZFam1YYkE0K0VSS2k3a21zWDNlQlZzdmZ2?=
 =?utf-8?Q?7D+R4W/RaABHfnGURYre4FjVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ccd30-0f2e-48d9-2b4f-08dcd10fb516
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:40:57.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAJAY31bELoGgeVCunsDG0kyV5mljPWQOBJHSVII6X9xcPByoKYCuyU0JS5ZDJEwsnFo78QqqAERbQOi0cSzjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

On 9/5/2024 04:33, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Sep 04, 2024 at 10:24:26AM -0500, Mario Limonciello wrote:
>> On 9/4/2024 07:05, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Sep 03, 2024 at 01:32:30PM -0500, Mario Limonciello wrote:
>>>> On 9/3/2024 13:25, Bjorn Helgaas wrote:
>>>>> On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
>>>>>> On 9/3/2024 12:11, Bjorn Helgaas wrote:
>>>>>> ...
>>>>>
>>>>>>>       8) The USB4 stack sees the device and assumes it is in D0, but it
>>>>>>>       seems to still be in D3cold.  What is this based on?  Is there a
>>>>>>>       config read that returns ~0 data when it shouldn't?
>>>>>>
>>>>>> Yes there is.  From earlier in the thread I have a [log] I shared.
>>>>>>
>>>>>> The message emitted is from ring_interrupt_active():
>>>>>>
>>>>>> "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
>>>>>
>>>>> Right, that's in the cover letter, but I can't tell from this what the
>>>>> ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
>>>>> MMIO read of BAR 0, not a config read.
>>>>>
>>>>
>>>> Yeah.  I suppose another way to approach this problem is to make something
>>>> else in the call chain poll PCI_PM_CTRL.
>>>>
>>>> Polling at the start of nhi_runtime_resume() should also work.  For the
>>>> "normal" scenario it would just be a single read to PCI_PM_CTRL.
>>>>
>>>> Mika, thoughts?
>>
>> We did this experiment to throw code to poll PCI_PM_CTRL at the start of
>> nhi_runtime_resume() but this also fails.  From that I would hypothesize the
>> device transitioned to D0uninitialized sometime in the middle of
>> pci_pm_runtime_resume() before the call to pm->runtime_resume(dev);
>>
>>>
>>> I'm starting to wonder if we are looking at the correct place ;-) This
>>> reminds me that our PCIe SV people recently reported a couple of Linux
>>> related issues which they recommended to fix, and these are on my list
>>> but I'll share them because maybe they are related?
>>
>> Thanks for sharing those.  We had a try with them but sorry to say no
>> improvements to the issue at hand.
> 
> Okay, thanks for checking.
> 
> Few additional side paths here, though. This is supposed to work so that
> once the host router sleep bit is set the driver is supposed to allow
> the domain to enter sleep (e.g it should not be waken up before it is
> fully transitioned). That's what we do:
> 
> 1. All tunneled PCIe Root/Downstream ports are in D3.
> 2. All tunneled USB 3.x ports are in U3.
> 3. No DisplayPort is tunneled.
> 4. Thunderbolt driver enables wakes.
> 5. Thunderbolt driver writes sleep ready bit of the host router.
> 6. Thunderbolt driver runtime suspend is complete.
> 7. ACPI method is called (_PS3 or _PR3.OFF) that will trigger the "Sleep
> Event".
> 
> If between 5 and 7 there is device connected, it should not "abort" the
> sequence. Unfortunately this is not explict in the USB4 spec but the
> connection manager guide has similar note. Even if the connect happens
> there the "Sleep Event" should happen but after that it can trigger
> normal wakeup which will then bring everything back.
> 
> Would it be possible to enable tracing around these steps so that we
> could see if there is hotplug notification somewhere there that is not
> expected? Here are instructions how to get pretty accurate trace:
> 
> https://github.com/intel/tbtools?tab=readme-ov-file#tracing
> 
> Please also take full dmesg.

Sure, here is the dmesg with tracing enabled:

https://gist.github.com/superm1/5186e0023c8a5d2ecd75c50fd2168308
> 
> It is entirely possible that this has nothing to do with the issue but I
> think it is worth checking.
> 
> The second thing we could try is to check the wake status bits after
> this has happened, like:
> 
>    # tbdump -r 0 -a <ADAPTER> -vv -N 1 PORT_CS_18
> 
> (where <ADAPTER> is the lane 0 adapter of the USB4 port the device was
> connected).
> 

Unfortunately the adapter is in such a bad state at this time that 
tbdump doesn't work.

> The third thing to try is to comment out TB_WAKE_ON_CONNECT in
> tb_switch_suspend(). This should result no wake even if the device is
> connected. This tells us that it is really the connect on USB4 port that
> triggered the wake.

Yup that's correct; there is no action on the hotplug with this change.

> 
> These could (also) explain why the host router appears to be in D3 even
> if it should be in D0 already.



