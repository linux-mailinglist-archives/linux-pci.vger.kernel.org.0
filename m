Return-Path: <linux-pci+bounces-13193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36223978A08
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618411C2154F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160E14831E;
	Fri, 13 Sep 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YK0r3Fyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401714A084;
	Fri, 13 Sep 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259623; cv=fail; b=iOPuI2glH9Yvq+l+kU6B0/cYDf4dOvLW5ctI6yZhF/ZUMT/UXeKIMLK+8wgPYuw9T5+OKG4eEVHcpOqpo3vF/TObV7G3FwFZOyV119Q12mfoTNlZp1cuYPZUsciD6ZLUdD1oSADwPH7Q9L+uY6volfgLxRFHrHLy7Ac2p/B7FOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259623; c=relaxed/simple;
	bh=YRFpeCqXhFCnxZlQZVUaXW0WRDzyBaTrRafJYy9Pbiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uq87aOho7tpS4MzqjUKwt1dOb3kO+9c+dAXSJ9/aaRNJ52uU/F3zthe4b5Z+yk/2i27ygSTjhbGScBYR73zlMBMzMIDFWCDOBB+d3MQQzlsdF0hmFBlnjkx44Rw/4EEHsmI6mQVk0xSwWze4PV8dM0swx+eWhXlDKYiVr/d3TG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YK0r3Fyo; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8f4KPXGpQ9O0UfQkuYWExlgfnfTUuDQPk63nfL33vsv5QqZ4t1jgUtx8nhkryiQB3d5cHxavAAvoNUH5sZq2gx/E5O3upLyN9j39MeIkfHfDrAKlp2cOrzj56laaRhwjG0Q2BzB33sKvmYqhOb/ny97G88D7XOw7O6tzlrsn/28AONqrdVWfNxBrtL3uEcqLrBPQ4RE3p+f2vgg6yS32v9xN5pm/VE3rf+F2RofTKvUnZ1zooV+85lQ3sNxktFObHx0Fr3nlZ8eScXImNCe+wnAeFsBR6IWexhuudDD76Qg2YT+7/ZezzTw5EMQ6PWPgHYAUkXxvw0fJmpxFQZ92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qMq3GOWniEnXCHPQtBrXLNc2AwE3WbKG9Rd2gUBjuo=;
 b=ZzwHbHvY2TdqKhEAwN0NUS1Hk/Q7Nl3jVf7iJ9J4wokzshcd2U3yYbm+BdxgY16B7bFL5rRy2imQscEWxww/dIjq8n/1Ed9uno2XIu7664GCfnzsjfN/FhaBbLeUVYkDg91wzeZ/LGm+e1AFvSfK3/Zp5ZdpHss1PD3OS8vtVq5bMODxiUPqabeIxAeHEka0g7exhcIfvb7tOi6tvn5+eI8CjjEtxRKtx9xp7pjEoPHPmgt7HNatt4UzMQcNbPPH2wn6pSZhUhhRPuRX9VWaaadegrp8lNKu41ReCQjAc8pHt/EdN4h20YcoiH9OwhuCOLxcCq1BEUPvK8MYyJoPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qMq3GOWniEnXCHPQtBrXLNc2AwE3WbKG9Rd2gUBjuo=;
 b=YK0r3FyooSbB/sOfMInfx7JLCWpQuHoYbeq4d6nzQoon6XB/cQAuz8OAbXSHPxix0UIK1MByDo4rKTutY47w51uSLh1LcIrwI8HQj8IAAyGeyb7FGWl+d64CtzwuqqsJ4HEFbqMfhX/xiT6KkORzD46UXl36MWFmHoe4TD2Kd1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 13 Sep
 2024 20:33:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 20:33:36 +0000
Message-ID: <12857e01-f6cc-4489-935b-7e6c354706e9@amd.com>
Date: Fri, 13 Sep 2024 15:33:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Kai-Heng Feng <kaihengfeng@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
 <20240912165709.GA674430@bhelgaas>
 <CAMusMWqxi3s8sb+j0wV251kRj9R9-oqKQUqKscVTk_sktm2m5A@mail.gmail.com>
 <20240913080123.GP275077@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240913080123.GP275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: acb23724-af14-4972-ccec-08dcd43357c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0pvUVJDUm5nRmQ4NG12TGFCdmpBMzVESTNhbnl2Ny9PL0ltRElXaGNoT0Y4?=
 =?utf-8?B?Y3FkcFRVNldtWW1uV1h6K013eFd2N3REaTJFU2F6SkZPWTIrdnU3TllvQllh?=
 =?utf-8?B?SXNJL0VMcVdEdmljZFBCclRSWmYrRTRxR2h1emwrc0V2MVZsL1JCTzZwd2N2?=
 =?utf-8?B?eVVhdmJWdHBNUE9mWEMveElRcXJwbnEvTloweVBaWTZlTmQveWhmS1RGVG5P?=
 =?utf-8?B?eWc2OFFreGd3d3RCallwUURrVTFGWnYzMVR6ZStULzUrRy9OdUVkOTJoNDlz?=
 =?utf-8?B?SWY2UEpGQi9YSSs3eWQ0QVRXd05tWXk5MGtET3NCenRlemJORHN3MVJyU3dE?=
 =?utf-8?B?amJnY3FDbC94NWhwQ3ZBbGdXQTNNSWxXQmJjRFBLTDMzRUJOYytYV3l6M0Y3?=
 =?utf-8?B?SmR2eSs5T1JHM1B3alBFdFk3V2JpWEtUQW1IVDd1a3RaMkFqR09MNHVOTlZN?=
 =?utf-8?B?emFRMDltT0NITU5BY2FiRFNDSFFsZ1JRdlBON1FEQ0twcW1oZjcySlhSSVow?=
 =?utf-8?B?SGw3Z2VMRS9jSldvTVBXNVVJNVhCYVJNdUFnTERWT0htcDJORjFRQUM4VlN1?=
 =?utf-8?B?T1d6VVVzK1NubUV1OTFHc0pic1BaMDFWZE5laWVQd05QWU1VWmRNVkJLaGFQ?=
 =?utf-8?B?by9EbjhkTTVVYU45Mi9jVDZQY21NaDIzQXdoRlNHcTNGVHQxTDM5Q0ZlWm5w?=
 =?utf-8?B?MXdUVlJrL1dxeENlWG9ES1BkOE8zWlhQeVNlSGltYnUzV0tLSmQ2Q1ZZdEFB?=
 =?utf-8?B?SkxRU3JacTZCemxrNHNxWWFLOG40b0I0c3JIZUJjYkhpMzV3cFpsMlg3Z2dI?=
 =?utf-8?B?OEY1ZjFvNE5VUm9UQm9UdmhyRkxIRS9kcDhHQ3BsTW1XQlJneVhubS9PSEtH?=
 =?utf-8?B?WUZLOWgxS2JVb2JKNU9oYzdiQ295Qlk1cXZ6a05WMHpUTlRTMENMbHZPQUhR?=
 =?utf-8?B?ODRKZWx5VnptLzZUdU1IN21pa2RnZXZVdGxBRldkNG1aVHhLUGZMSWw3eVd6?=
 =?utf-8?B?Vk0yOUxGalBrOUJLOVlBZnBxNDRtZjRmRGpHVGNwRXZpRW5zZEt6ajJ3L21x?=
 =?utf-8?B?WGV1eHp2b3lCV3FYcVhxRUN1dm14VnpWZWlzR0VxaVM4RVJDQ0hiRiswYU1h?=
 =?utf-8?B?QTM4TkpOMkdpaHdmYVFaYUwxMlV1VlpnQmdRNk5uKzNrRkhUZ0JpUHJOdjBv?=
 =?utf-8?B?SjdvUWttUTdiVHpXNUdmTzc4aE1OL3JFdThzVE1FTU5zWlkxbUtaRDZiZEFx?=
 =?utf-8?B?Nnd6VkFjUEl6L0hTV3UxVVBTTzdBaU9mZ09kNVFVNEFRQmxYbUVoSjJtRkFk?=
 =?utf-8?B?dGNaR1ZVV1RlcEpoeThqaXZxV0pZQjZibmVtRE1raXBtRXUrd3YvVHJadFVV?=
 =?utf-8?B?SWs3eDFvWkNhQ2tKOGVpdFVHZFBHNDQ1NWRTeEpvQ1pjQjMwaEgra3FXd05a?=
 =?utf-8?B?VHZ6NnliSEVSWFE4UU1MeUdpU2EwZW8yR2ZVTENFcjMwcHFmUTQ1RTVBd09v?=
 =?utf-8?B?YU9sMlJEakFvYVdSdnlqMWg2UFM2VGUzZTdrTTVZQUVxTmQvMjVicW1Rek1L?=
 =?utf-8?B?MDlpa2tqMWlKdzBFVDVNb0pYTHpBMHlRKzJDZktmNGFxT1JzTXM3Zm5ub0tY?=
 =?utf-8?B?RThKaUxqV2lrbWRCMnM5eVcrWnJNNlNVVTJDbXRZSExxOUFFU1pwVTJtZko4?=
 =?utf-8?B?SjJjbG9nVjdiVm5RU0pBRnZKMHRQbzFheHVrTjg4dERkRTJLRGp6LzFuRHgw?=
 =?utf-8?Q?1XXB9UmWL4k2JZCruE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG54T0F1c3E1SXZOdWRpYWZhcjJQMDNjR0czR2orcStvMU95R3I1V1EydEFR?=
 =?utf-8?B?MGhROXFkVXE1TWlTYlNOREc1K0xpakFycTcraW9CNmVJSVdITjh4QUcvMDBm?=
 =?utf-8?B?SUtlbjZZN2Q4TXp6ek00S2FxcDNuT3dUT2hFM0xweWY3TUtHNVVieFBUa0tm?=
 =?utf-8?B?WFpCVHYxYVlFbnY1dXBpdHVuSUpoeVM0RHJTV21aMWtmL04vUmlpUnNUTkFx?=
 =?utf-8?B?T1RoMFlMTGd6dDVTaktncXBIend5bFJJc25La21BTlFNTXo5eXQ4aXIrYXhu?=
 =?utf-8?B?Z1Zzb3paVWkxM3UyNzVJUGQ0eEZRMGk2NG9EeG94dHErMEF5ZTNhTGlVMStD?=
 =?utf-8?B?T3paemE4Ryt4VjY3Q05seG8vZXQ1MWVBSFhoZ0tDM2tUZEhSMmJoU1VDNzdj?=
 =?utf-8?B?Lzh0L3p0WGZKUkdESHA1VDJuZnQwSHR1LzJLbklVb09UNFc0TVFpTi96RUQ5?=
 =?utf-8?B?aUVHTW8xOWV6bjg5ZWRMYWhGVit1eDJKaDNpYzhGMVJCRkJTRkhJclAweTFU?=
 =?utf-8?B?WGY0Z0RwYXc1YlVNcURxdElsRHFON1hQN0IxdXV5ZmNIaXFPQmpHVVdhYXlv?=
 =?utf-8?B?QVNRRW5tUFRpQ2h0VFJ0U2o0anc2ZDdkMWkraXBzbVFZS3lOLy9tMUM4VnJC?=
 =?utf-8?B?RmxTOFl2bUZRODJ5S1JrdWtxWGxXRWN5eHFVUkNhTGJCL1U5Ynk4UjRVNU1W?=
 =?utf-8?B?Vnl5TXpIM0RJb3hzUTh0YXdjRHNraDFZUEdtbjAzc0hzYU9uNFdrdDI2Wkpk?=
 =?utf-8?B?NWRIV3RWLzV0Z1AxRHJwSndrK25lQUZWZU1SRitzK09KME5CbDR1N1QvT0dL?=
 =?utf-8?B?QXV2VWxVTFZ0K3RrTTl4OEpiN2s2ZVVucWl5M2hjK3hYeGRCZkRJYlFrempI?=
 =?utf-8?B?Q1A1dTV2RENZVG1oQXBWeW9HdmRPOEFEVEt2elUrZTd4aUpBZlZXV04wRXJk?=
 =?utf-8?B?Q2gzdEJFMllDMjg5OHZGTk9aUkd1RzZ6TnFLTVlXODJWNURuR3RyWHFpbGN3?=
 =?utf-8?B?THBUTEQrZzM4QWtsRTVkZFpjbmJES3R1UGRWTkNWcm8yb0RSWnZlR2pvLzNo?=
 =?utf-8?B?MUxPcnJmc0NmZ0pKWHFsME9FUUNvY2R0RmZuRGJieHV6clg3UCtCMy9mNnpP?=
 =?utf-8?B?azRlblgzK0Z6Q1JDSlZTYXM2dE52ZVo1d2VCakNvbUpyWXFMblp6Q29yUnY5?=
 =?utf-8?B?VW0yM3JOSXBLQTFGQ0M3anhWR09qWnFwWnJOV205T1N6N2w1a3ZBY0FpV2JI?=
 =?utf-8?B?UUhGeVVJQ3F4SWM3UGtXd2xDT3hYeFZVK2dXQW12TlJuU01HVEVBQVlpdC8r?=
 =?utf-8?B?OCtFd2ZYYWEvWTlOZDRwRFdDVjJJV2lUc3dCQW8xOUgzQVFhZm1USTRmL0FH?=
 =?utf-8?B?NGZld3MySnhKMVFsam8rc1ozb0ZOVDJWQXYxczR2bTAwTXhWMnpHRlI4UHZw?=
 =?utf-8?B?aW53cUZyZTJESXk2bm05dW10b01nNEtMZVpsaDV2S0Mxb3h2OWg3cTFvSmhB?=
 =?utf-8?B?cWIvaG4rN1NuWFlDSmVESXorSGU1V0g2cTVsYWFidU1LSjZxODY2Z01tTFdI?=
 =?utf-8?B?UUVkY2hWSWNqZDB4Y284eEFpVTdHYkZHSjJmM1J5ajdtbWRaUDFrdFh3T3M0?=
 =?utf-8?B?SXd1UmVRYUZPeEprR0l6QVMrOW0vUmxXVk5WWHFZNE1UYmM3UElDNkFzbjZL?=
 =?utf-8?B?K0Q0VUMvL0VBbkNvaVJzMlEyZEZ2SlFURG51WjBPK2VHek11SmxvUFNCL0lp?=
 =?utf-8?B?ek5SczJPR3NCRXdtTHcwYm41bzZJMHJnQkpnR2hiSHhsWGVGRE5ma3BLeUZO?=
 =?utf-8?B?Mk1jbDdiQ2hwVWxBaXVmWmpvcko2WjcyUk0vZUx4S1dDTnIxN2JYSEtnV1BF?=
 =?utf-8?B?cm5Nb0dKY3gvNDBsVis4RmVDaUJERXpTQ3Qvd0NhNGZFR1BHR2daVDVRWWFT?=
 =?utf-8?B?cHVKbXJuTUxpeVlraHJPYjQ3K0t0SHNVZDZVcWphd2RmbWdlN01qVncydkRI?=
 =?utf-8?B?Z0t3dDd3empVbmtaaDZhYkZYdFZucHdtOWNaTElWcERLVEUxaDNSL3llRkJS?=
 =?utf-8?B?cjBWTEYyVkJzSW5ZN2pIYTJacCtydmpHRDJXbysyRzAvbjVxOWFMUUtvbUZG?=
 =?utf-8?Q?QrJj2g4Xr/9sWe+sw5FuuZmpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb23724-af14-4972-ccec-08dcd43357c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:33:36.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPeBH1ExSyNvTG0gTUMibY+E+esrxB+X2OzFzAGDMs/Eh0XoJNXRoom0Vu/hV9MIDDk2vBxUmHGEnWe/Q7cIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822

On 9/13/2024 03:01, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Sep 13, 2024 at 02:00:58PM +0800, Kai-Heng Feng wrote:
>> On Fri, Sep 13, 2024 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> [+cc Rafael]
>>>
>>> On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
>>>> On Thu, Sep 12, 2024 at 3:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
>>>>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>>>>> connected.
>>>>>>
>>>>>> The following error message can be found during shutdown:
>>>>>> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
>>>>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>>>>>> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>>>>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>>>>
>>>>>> Calling aer_remove() during shutdown can quiesce the error message,
>>>>>> however the spurious wakeup still happens.
>>>>>>
>>>>>> The issue won't happen if the device is in D3 before system shutdown, so
>>>>>> putting device to low power state before shutdown to solve the issue.
>>>>>>
>>>>>> I don't have a sniffer so this is purely guesswork, however I believe
>>>>>> putting device to low power state it's the right thing to do.
>>>>>
>>>>> My objection here is that we don't have an explanation of why this
>>>>> should matter or a pointer to any spec language about this situation,
>>>>> so it feels a little bit random.
>>>>
>>>> I have the same feeling too. The PCIe spec doesn't specify what's the
>>>> correct power state for shutdown.
>>>> So we can only "logically" think the software should put devices to
>>>> low power state during shutdown.
>>>>
>>>>> I suppose the problem wouldn't happen if AER interrupts were disabled?
>>>>> We already do disable them in aer_suspend(), but maybe that's not used
>>>>> in the shutdown path?
>>>>
>>>> That was my first thought, so I modified pcie_port_shutdown_service()
>>>> to disable AER interrupt.
>>>> That approach didn't work though.
>>>>
>>>>> My understanding is that .shutdown() should turn off device interrupts
>>>>> and stop DMA.  So maybe we need an aer_shutdown() that disables
>>>>> interrupts?
>>>>
>>>> Logically we should do that. However that approach doesn't solve this issue.
>>>
>>> I'm not completely clear on the semantics of the .shutdown()
>>> interface.  The doc at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.10#n73
>>> says "@shutdown: Called at shut-down time to quiesce the device"
>>>
>>> Turning off device interrupts and DMA *would* fit within the idea of
>>> quiescing the device.  Does that also include changing the device
>>> power state?  I dunno.  The power state isn't *mentioned* in the
>>> .shutdown() context, while it *is* mentioned for .suspend().
>>
>> IMO putting a device to low power also qualifies as "quiesce the device".
>>
>>>
>>> IIUC, this patch and commit log uses "shutdown" to refer to a
>>> system-wide *poweroff*, which is a different concept despite using the
>>> same "shutdown" name.
>>
>> For ACPI based system, there are .suspend for S3/s2idle, .poweroff for
>> S4, and .shutdown for S5.
>> Unless we want to introduce a new callback for S5, I think the concept
>> is quite similar.
>>
>> For DT based system, the OS should also perform the same thing, as
>> there's no firmware to cleanup the power state.
>>
>> We can also move .shutdown to be part of pm_ops, but I don't think
>> it's necessary,
>>
>>>
>>> So should the system poweroff procedure use .suspend()?  Should it use
>>> both .shutdown() and .suspend()?  I think it only uses .shutdown()
>>> today:
>>>
>>>    kernel_power_off
>>>      kernel_shutdown_prepare(SYSTEM_POWER_OFF)
>>>        device_shutdown
>>>          while (!list_empty(&devices_kset->list))
>>>            dev->bus->shutdown(dev)
>>>              pci_device_shutdown
>>>
>>> There are several driver .shutdown() methods that do things like this:
>>>
>>>    e1000_shutdown
>>>      if (system_state == SYSTEM_POWER_OFF)
>>>        pci_set_power_state(pdev, PCI_D3hot)
>>>
>>> Maybe that's the right thing and should be done by the PCI core, which
>>> is similar to what you propose here.  But I think it muddies the
>>> definition of .shutdown() a bit by mixing in power management stuff.
>>
>> Do you think adding a new "low power state" callback to be called
>> after .shutdown a good idea?
>> That would make the concept of .shutdown different to .suspend and
>> .poweroff. I personally see .suspend, .poweroff and .shutdown the same
>> action but target different power states.
> 
> I don't mean to confuse you guys but with this one too, I wonder if you
> tried to "disable" the device instead of putting it into D3? On another
> thread (Mario at least is aware of this) I mentioned that our PCIe SV
> folks identified a couple issues in Linux implementation around power
> management and one thing that we are missing is to disable I/O and MMIO
> upon entering D3.
> 
> I know this is about entering S5 (power off) but I wonder if simply
> disabling the device (I/O, MMIO and bus mastering) could stop it from
> waking up? 

To me, it's a two-fold problem.  The device consumes too much power, and 
the device issues interrupts when system is in S5.

Putting it in D3 should nip both, disabling the device might help the 
latter.

I did the same thing a vendor did for KH where I double checked the 
waveform at S5 and could see the devices still in D0.

Or do you think that by the device being in D0 but disabled should be 
enough for decreasing power?

> To my understanding this can be interpreted as quiesce too :)
> Something like the below patch (it also includes the runtime suspend
> path which should not matter here. This is the similar patch I shared in
> another thread).
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..79406814699d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -514,11 +514,9 @@ static void pci_device_shutdown(struct device *dev)
>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>   	 * device to tell it to not continue to do DMA. Don't touch
>   	 * devices in D3cold or unknown states.
> -	 * If it is not a kexec reboot, firmware will hit the PCI
> -	 * devices with big hammer and stop their DMA any way.
>   	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> -		pci_clear_master(pci_dev);
> +	if (pci_dev->current_state <= PCI_D3hot)
> +		pci_disable_device(pci_dev);
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -1332,6 +1330,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +		pci_pm_default_suspend(pci_dev);
>   		pci_finish_runtime_suspend(pci_dev);
>   	}
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ffaaca0978cb..91f4e7a03c94 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
>   		pci_command &= ~PCI_COMMAND_MASTER;
>   		pci_write_config_word(dev, PCI_COMMAND, pci_command);
>   	}
> +	/*
> +	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
> +	 * the OS needs to disable I/O and MMIO space in addition to bus
> +	 * mastering so do that here.
> +	 */
> +	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> +	pci_write_config_word(dev, PCI_COMMAND, pci_command);
>   
>   	pcibios_disable_device(dev);
>   }


