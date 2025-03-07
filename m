Return-Path: <linux-pci+bounces-23104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B4A56632
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4809C1771CF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8D211A31;
	Fri,  7 Mar 2025 11:02:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BC21019E;
	Fri,  7 Mar 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345342; cv=fail; b=TSigmIybcw49opH+Pah8sAK1ArDzLbJdlo1zLyz1tXefIdNSJML+rEHIf1+3betr037XQ8WBCCqwr2l01nxhFUuDeTbd8L7J9AIntaxdfTitUo0tEYf/VnZ/DrGCdzmWNHoQ/z03iNlZl3lrn79Bp/RRTWLz7U9fIBMd59BOalk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345342; c=relaxed/simple;
	bh=G0OObRIQ0VMyuF6o3IVW5SgY1MwCAqjHXU0SwS1bhpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbbtIJGbqwRc8AnKxEmrZSX28ISJgVYtVEGb+09/JUf0VCAAdSUnqh4xyHVaxRVqvv+lrvD1nN3SvkWhjjkOw6CpCsI85bHArNXpRYh211nC9tXRvcmrh5VTHikECfJD1ZPPIP2wt2D+4u7b6hht14lOwG6Qlb7NE16un/WM+mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5276e33A018180;
	Fri, 7 Mar 2025 10:14:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 456ct8b3kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:14:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKxPKTAYAenIempvuAx15f5xD8eUqwKsBBMjWKxj6T7ZOgWJx09X2zBT/0rPALSpRlRa8ow7qDVchAmwiORuk7DlR0j/YlyGQ1WG9hs6PSmQOKnLwvprj5lzmxxW3I3lJk4N2pzkCzDjiMIK1IcYAvHdMBt92W/gZP2XlzJG5c8E+QdmvUy5lAu1ulrORh6Zi84dxBVz/cVU8QPHDOgHOC73PJPSObaIuGOIThRjoh13pP3dNacIBwte5gtg3rWa0OK/T2Vmb2AkjSoafpg5vqqBcnV5OxMuBGc74zHAmMRTq5TdrS53vSXeY2UlY3o9iqbLoQ+IytUWbVv0Fx1bjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rngqwXG4514QE+uKqP2FtuFjvxWVlRUhqoLUI5CX3cE=;
 b=Yt+RpjfvW5ltwt1okZtrNj4nEX2kfqxpx5jLIk+BELhjr5rm+0Hm6WNvZVtdhr9q4CuQCQtpnpqRDJP5TL+WFhn70xr2jVhiIqvi1ZC8OwYAlaGn3G4c3jkKXoWhc20VYCmccsJ0CI83ayONw63v1PJqvXJCLc5bU5Z9mgw0GbuurCi/hhx1XbXZ8G1xkgApyoTX8L+MDsEB+Lpq/msU5mKIqczTesZ7qImK9/QZZ1iRo1PtKJPekSY8YVnV0nK+uGfBvxWj/ztP5CDyHBeZCje9VwXwclIOZvuk8Ky3HqI+4E0glQkqGyJILIHh0Zt7x+LStQ0+5WOgGssE73PtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CH3PR11MB7249.namprd11.prod.outlook.com (2603:10b6:610:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 10:14:40 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 10:14:39 +0000
Message-ID: <416a2d7d-eeb6-4163-8805-3178476f5a8d@windriver.com>
Date: Fri, 7 Mar 2025 18:14:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Kexin.Hao@windriver.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
 <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
 <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
 <55a33534-bff0-488c-a2a2-2898d54bd62f@windriver.com>
 <20250305060607.ygsafql53h2ujwjp@thinkpad>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250305060607.ygsafql53h2ujwjp@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|CH3PR11MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: cce739e5-570e-42da-ee37-08dd5d60debd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2RVczN3RDdBbkhRZHJ2SURGQjFjRy8rRjVJajhRRWRXU1BYS2l4M2VRY1Q1?=
 =?utf-8?B?YzNKdDdQN2h1NmtlelBDa1ZDZkdmQ0UzSFVDbGVUSFNRTEZ1M0JhRWVRS25P?=
 =?utf-8?B?VnNHS1AzdmM0UkZoWWF5VWxwOWJLSDc3WXlyMm0yOVRJS2FLeE02MGp0WlNq?=
 =?utf-8?B?Sm10ZFpjck1aVVNBWWpqNklVMW9RSjF6ZDhKZDhHSWJZdld4cG5iRDRlK055?=
 =?utf-8?B?YXV5K2FDc1RCd0dmMzhQb1J6cHFoQ0NteDhBZzduc1NYV3pKczVtMktlWVlk?=
 =?utf-8?B?QzFnbEs2OFRMcU93aXR6cUp4dlJjaVlGSnNTT1FXKzdhK1hzOUpZR2V5UVJ1?=
 =?utf-8?B?QkJvVmUzSEc3NFFvWXpUT2tjTUlMQmI2SXFqa0VRL0RtQ1dVYTFJejNDekRj?=
 =?utf-8?B?WUZPQlVIallWeVVHVGR1dW9yQkpIVzAzV2pwV2g3YVBHazZMbDVHb0JyOWs5?=
 =?utf-8?B?Q013YlppdjVxM1NpdXF5aS96cnVRSlVHWUp3REdGSWRpQVB1Wi82UXVlWmV6?=
 =?utf-8?B?ZjJJcmowR3NwN1QyMzlFSWludGV1Si84aWFlNVNLcURDVXJ5cG5rMTlBQWpE?=
 =?utf-8?B?T3BlL2IzLy9jSE10dHB6L0txZDg2eUJ3bnF6L1Z1QUFCc241MGJhMnV6RHVp?=
 =?utf-8?B?T1I3THVnVkFFanplZTRuTSs3dnZNYU9iKythM2ZydXZWT1Bva0ZIRUpvckUz?=
 =?utf-8?B?YWY0RzdKRXFlV1RRN1pkQ2VlcktiMGZTRDJiV0lWWUFucHYxWVF0V1R2SDhS?=
 =?utf-8?B?UjdXY2VLMUIrMXZyVzBHVkJDZStTSk9aczViWEliVVl6MjVZdFNVWHRGTVJj?=
 =?utf-8?B?SVFpbjFhS0pobCttYStDeS91YU9zb3JuUWhUa01QR0t4OEdQWWxpRkxiV0RQ?=
 =?utf-8?B?anNoSlUya3JxdExqNENBcXZwNXRNQ0EzRG9Ybzl0SjRJc2EvS3JiRjFhNVNo?=
 =?utf-8?B?VG9CQmthQVdjdjV2anRZK3NudllRWmF1OHl1MHZFWlhEMnlmZ3dMWTFkbVIz?=
 =?utf-8?B?eGpnT2RJQnlLRVYxdlp1RGVlSW1rL1B4OXpyenRKOVUvZC94ODRvUTE2U0Ux?=
 =?utf-8?B?c2xxZkhLTjNkVnZjSWE2K3BMcE9SRnM0YUxIRXQ2bDRKT01JWlRsK2tBS3Fy?=
 =?utf-8?B?V05NTCtSZTJFcHdLd2R2dkJJU0twM1ZVUHVqS1dZWHhHb3E5NzZoNS9qWDRz?=
 =?utf-8?B?YmwrZGlBMVdBQXVydTZqVEdmd2RuVDlNYmZaL1FKYS9ha2hkK3BRV2JiYVdV?=
 =?utf-8?B?WS8reWhiWjZNV0NHendNVCtDL0txYTZXYkljMkVmOHp0blZDVFVPNlVkVWJB?=
 =?utf-8?B?aHJ6OGg1SlFIVzhscUxJOERNSTk3R1VMSjZQcDVpUGkrdm1GdzVHb3A0eTY4?=
 =?utf-8?B?REo2V3FuZHM1bnVRSnl5RG5ncUl5RSt4MTVlY3hWdU95TDA1R2QzZDg3dkZp?=
 =?utf-8?B?djlpcUhUWG9aWnJqYVhRZUFYeGRCRHNSMXRMVlJGSnNLUEVFTWxsWjN1VXp6?=
 =?utf-8?B?ckhOd1FpUWJoWlgwS00yQk43MlduLzM0Ym9BR2RDU0Y1a0R5SGNOQloreTB6?=
 =?utf-8?B?cVYydytvU3hkRlIxcjZ0c0x2VGtSaGlKalVBVjN3cU40QUtQVWxaUXQ5Q2tr?=
 =?utf-8?B?ZW1VNEpCZk1xRnNoUFdtRzEyQmhCK0VERFdaOTRWcXNCQmFxVDh3R0ZYbWVp?=
 =?utf-8?B?UytBck1rTnAzQnRITThOQUxGTEdyTjEwSFc3eTFFR24rUWRVQmFJU2lvQXVP?=
 =?utf-8?B?RXVPRGo5elZNMCt1TVc5MklhOFI1QWYwb3lMYlFBc2RZQ1VnUSs0OE9CR0Qy?=
 =?utf-8?B?dnBXMEhsVnAwTlYrTHNadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUMxWUM3RTc5NE1CNGVHWGZOL1EwZnQzQmdic0xnM1RiKzUwUTdSd3B4UVpN?=
 =?utf-8?B?amZiSG1LbkhIaGdzVG94cUt5UGl3aUgvdmlNZWcwRmlBcHlOZm1SaC9nd2ta?=
 =?utf-8?B?TS8yUmQwMFZ6ZVROSWV4dWs1U2VrcTlsRC9KWk4zVTMzaVZTcjdLZG5nTlpr?=
 =?utf-8?B?VUppZDU0UEEyMVBkc3ZEcjgrQUxKMWdxZ1BCbVNKUnR1Y1BIQklHSWtNUWhk?=
 =?utf-8?B?bVBwVU9tYlcvcGJPMUhLalBKVUcwQW1JMjg5YS91NXZVVHhwelQzR2J4bXVo?=
 =?utf-8?B?S2ZXbFhka0d6T3NkVmxhTm85bVY1NFFEUmF4bFlseUdFM1NhbTJMa2M5NTdT?=
 =?utf-8?B?ZUVqS29vWkgvUXF6SDhNVnR5QiszS1pnS2R0VjBzdU1Pd1VRKy9ZZ1FScmp2?=
 =?utf-8?B?VDVSS0JpdXVNRnNVUGxxK2wvV3pqWmtlK09RbXlEOHhvUVBham9tWnRZT3Q4?=
 =?utf-8?B?dzhnMDFZaWwwS3RzTkdwQWJJdDhubi8zYVJrVFZ3RFVRdDZudHFadklEM0Ux?=
 =?utf-8?B?RmJyOVMwNVJzRERBUUVTNThxVi9tOE45Y0l6VzEwb0V4bDZnQ2NHcXZ2Z241?=
 =?utf-8?B?QmVRQTZhcWdaMkNXdEJyV0hIU0FUZzY1b1JnV08yN2RiTkQxQllnOTZyTlZS?=
 =?utf-8?B?b2lTVGJUSnd1VHBYTmFTTW9TNmZPNWZ4TXh6ZThIVE5uZTZBNDBzak92OG4v?=
 =?utf-8?B?RFp3bDk0aklmUFp4UE1oVEoyNUZKdDdiV2g2RHNXOHJ1MHdCL09hbit0eXVU?=
 =?utf-8?B?cFFUa1JhMURERHZjMXpOUWF0dnlQOTlxRjE4b2pTVzZaWXpWbVQxdWR2SjJi?=
 =?utf-8?B?N0ErUzg0NEZaN24yZ1RwVDdxMEhNbk9DZDN5L2prZ09FTFdpbFNaSStJRlR2?=
 =?utf-8?B?dWJYZDUrcGlIVkZubTV3UjFCcnpVb01RWGZwTEVod0dqQ0lHY0djdVNNMU1r?=
 =?utf-8?B?S3BVQzNZVU9lQUVLYVNjSW1yWjFzbHBRcmRvNHIzcWFSTzEzNnJ4SUhrOFpn?=
 =?utf-8?B?OWg2YVpiQm9KL2MzaXZORURLbUovanU5VE9jaXRSSjd6M041eUJRYXNudWRI?=
 =?utf-8?B?djZSeU5DazdOcXp5WnFvaFlCaGp0ZWhVNW9jWEh1WHB6ZTVTZEtndUxjdE1U?=
 =?utf-8?B?MFBrTC9PeEZDZEdTd1lvMWUyS1FaTFk3eldZRUllc2tsZTQ3cFg4bXVJUjVX?=
 =?utf-8?B?RDJuZnkrajl1cVN1THUwVU1tZ2pnYlFEcXdqRHdZNVBwbnljRTFaNVhZUzlt?=
 =?utf-8?B?ZkFPQVkrMTZTcTFobTViVWlqZWVyd09zcDJlb1g0TlNPOHY2aGxBSTcvMlVr?=
 =?utf-8?B?amhtNFlWYUZqUmZLNXhKMkJsc2haZ2tPWFByMExvb2JqR1NuSXhMZitsV3F2?=
 =?utf-8?B?SmtWUk1TTnhSMEFtNmxZVUV6ZWVhUHRUZkxqekZFUDJBaHJwUkFNWGNnazlj?=
 =?utf-8?B?dUVuVGxia0diRXdXZUd6a0lPWHR5SndBa3I1RXNPYm1FVDRETU9NOERrUTVK?=
 =?utf-8?B?YjNZMXFSeDFzelpLbnhOYlN0NjBZbko4Q01RbkRPaXFWR3BrekFSYndCanBM?=
 =?utf-8?B?OWUvRTVISGUvUE16UUQxVXNYd1grdXpsRVlibm9ZTDlSTXJIVmVBMmZGWjdM?=
 =?utf-8?B?Z3JHQVpSMHgyVzFWUk0zWlBocVduSTIzMExyQXdHTmhaMkRrZUpZMDAyTmcx?=
 =?utf-8?B?VUFEVzZiYWlVSXhzT1pRc09FYWx4dGFhN212RmhTaEdhWVpybTd6UTdHbzVt?=
 =?utf-8?B?QXowaTMyMUpyOGNpbGsrTjlTZEJ4dDVpdzdnRGJ3YkVCU2NDVkZkN290OUVm?=
 =?utf-8?B?Y25SdTVObnNMUFJPVDJIRUNHY0tPbVgrYlF2STBuM0QrQVQySEdka2hTYVNV?=
 =?utf-8?B?ZE5DWkZxbVJuK1BMZS9OM0VwRjVTMi84RXBCWTlWZTBkMEJlZE1mbUhGVkVO?=
 =?utf-8?B?cEZIQVoyUTQ3NGo5V3RqODd1ZjJhL0kxVGR1MFhRY3RtdlVtM25TMTRPLy90?=
 =?utf-8?B?TUJYU1VTa1ZlWVkwVE1DMUxZcjRiZ0dNVDVJVU5Lbmp0ek1YTUlvSXBEYVNX?=
 =?utf-8?B?UnM5NFdDTkhRbU92UEhLaVd6cmwrUTByZEROZnUyY0FLcmgxaGlTUmxmeVpv?=
 =?utf-8?Q?/uUx8XZ2Izbq30ZLO6Nlk/gXB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce739e5-570e-42da-ee37-08dd5d60debd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:14:39.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkIYpiJsEFciexP2CzKpuyIxupMwOiAjZM7KUAXzbuSUcNqLrU5NwIDrO63KQc9PZRYvpCVcySDJ8U8lOklj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
X-Proofpoint-GUID: sgie5u2iVLQm_eMnhKP-TZwFXF6WvuKg
X-Proofpoint-ORIG-GUID: sgie5u2iVLQm_eMnhKP-TZwFXF6WvuKg
X-Authority-Analysis: v=2.4 cv=D4W9KuRj c=1 sm=1 tr=0 ts=67cac715 cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KW8eYL2dbHb8wmTwd0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503070073

On 3/5/25 14:06, Manivannan Sadhasivam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Fri, Feb 28, 2025 at 07:58:10PM +0800, Bo Sun wrote:
>> On 2/15/25 1:00 AM, Manivannan Sadhasivam wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Wed, Feb 12, 2025 at 03:07:56PM +0800, Bo Sun wrote:
>>>> On 2/10/25 18:37, Manivannan Sadhasivam wrote:
>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>> On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
>>>>>> On our Marvell OCTEON CN96XX board, we observed the following panic on
>>>>>> the latest kernel:
>>>>>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
>>>>>> Mem abort info:
>>>>>>      ESR = 0x0000000096000005
>>>>>>      EC = 0x25: DABT (current EL), IL = 32 bits
>>>>>>      SET = 0, FnV = 0
>>>>>>      EA = 0, S1PTW = 0
>>>>>>      FSC = 0x05: level 1 translation fault
>>>>>> Data abort info:
>>>>>>      ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>>>>>>      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>>>      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>>> [0000000000000080] user address but active_mm is swapper
>>>>>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>>>>>> Modules linked in:
>>>>>> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
>>>>>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>>>>>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>> pc : of_pci_add_properties+0x278/0x4c8
>>>>>> lr : of_pci_add_properties+0x258/0x4c8
>>>>>> sp : ffff8000822ef9b0
>>>>>> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
>>>>>> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
>>>>>> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
>>>>>> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
>>>>>> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
>>>>>> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
>>>>>> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
>>>>>> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
>>>>>> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
>>>>>> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
>>>>>> Call trace:
>>>>>>     of_pci_add_properties+0x278/0x4c8 (P)
>>>>>>     of_pci_make_dev_node+0xe0/0x158
>>>>>>     pci_bus_add_device+0x158/0x210
>>>>>>     pci_bus_add_devices+0x40/0x98
>>>>>>     pci_host_probe+0x94/0x118
>>>>>>     pci_host_common_probe+0x120/0x1a0
>>>>>>     platform_probe+0x70/0xf0
>>>>>>     really_probe+0xb4/0x2a8
>>>>>>     __driver_probe_device+0x80/0x140
>>>>>>     driver_probe_device+0x48/0x170
>>>>>>     __driver_attach+0x9c/0x1b0
>>>>>>     bus_for_each_dev+0x7c/0xe8
>>>>>>     driver_attach+0x2c/0x40
>>>>>>     bus_add_driver+0xec/0x218
>>>>>>     driver_register+0x68/0x138
>>>>>>     __platform_driver_register+0x2c/0x40
>>>>>>     gen_pci_driver_init+0x24/0x38
>>>>>>     do_one_initcall+0x4c/0x278
>>>>>>     kernel_init_freeable+0x1f4/0x3d0
>>>>>>     kernel_init+0x28/0x1f0
>>>>>>     ret_from_fork+0x10/0x20
>>>>>> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
>>>>>>
>>>>>> This regression was introduced by commit 7246a4520b4b ("PCI: Use
>>>>>> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
>>>>>> bridge is misconfigured by the bootloader. Both its secondary and
>>>>>> subordinate bus numbers are initialized to 0, while its fixed secondary
>>>>>> bus number is set to 8.
>>>>>
>>>>> What do you mean by 'fixed secondary bus number'?
>>>>>
>>>>
>>>> The 'fixed secondary bus number' refers to the value returned by the
>>>> function pci_ea_fixed_busnrs(), which reads the fixed Secondary and
>>>> Subordinate bus numbers from the EA (Extended Attributes) capability, if
>>>> present.
>>>
>>> Thanks! It'd be good to mention the EA capability.
>>>
>>>> In the code at drivers/pci/probe.c, line 1439, we have the
>>>> following:
>>>>
>>>>                 /* Read bus numbers from EA Capability (if present) */
>>>>                 fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
>>>>                 if (fixed_buses)
>>>>                         next_busnr = fixed_sec;
>>>>                 else
>>>>                         next_busnr = max + 1;
>>>>
>>>>>> However, bus number 8 is also assigned to another
>>>>>> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
>>>>>> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
>>>>>> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
>>>>>> bus number for these bridges were reassigned, avoiding any conflicts.
>>>>>>
>>>>>
>>>>> Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
>>>>> flag was not set:
>>>>>
>>>>>            /* Do not reassign resources if probe only */
>>>>>            if (!pci_has_flag(PCI_PROBE_ONLY))
>>>>>                    pci_add_flags(PCI_REASSIGN_ALL_BUS);
>>>>>
>>>>
>>>> Yes, you are correct. It’s a typo; it should be "when PCI_PROBE_ONLY was not
>>>> enabled." I will fix this in v2.
>>>>
>>>>>
>>>>>> After the change introduced in commit 7246a4520b4b, the bus numbers
>>>>>> assigned by the bootloader are reused by all other bridges, except
>>>>>> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
>>>>>> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
>>>>>> bootloader. However, since a pci_bus has already been allocated for
>>>>>> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
>>>>>> 002:00:07.0.
>>>>>
>>>>> How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?
>>>>>
>>>>
>>>> The device 0002:00:07.0 is actually enumerated before 0002:00:0f.0, but it
>>>> appears misconfigured. The kernel attempts to reconfigure it during
>>>> initialization, which is where the issue arises.
>>>>
>>>
>>> Ok, thanks for the clarification. I think the bug is in this part of the code:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c#n1451
>>>
>>> It just reuses the fixed bus number even if the bus already exists, which is
>>> wrong. I think this should be fixed by evaluating the bus number read from EA
>>> capability as below:
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index b6536ed599c3..097e2a01faae 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1438,10 +1438,21 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>>
>>>                   /* Read bus numbers from EA Capability (if present) */
>>>                   fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
>>> -               if (fixed_buses)
>>> -                       next_busnr = fixed_sec;
>>> -               else
>>> +               if (fixed_buses) {
>>> +                       /*
>>> +                        * If the fixed bus number is already taken, use the
>>> +                        * next available bus number. This can happen if the
>>> +                        * bootloader has assigned a wrong bus number in EA
>>> +                        * capability of the bridge.
>>> +                        */
>>> +                       child = pci_find_bus(pci_domain_nr(bus), fixed_sec);
>>> +                       if (child)
>>> +                               next_busnr = max + 1;
>>> +                       else
>>> +                               next_busnr = fixed_sec;
>>> +               } else {
>>>                           next_busnr = max + 1;
>>> +               }
>>>
>>>                   /*
>>>                    * Prevent assigning a bus number that already exists.
>>
>> You proposed solution doesn't work on our Marvell OCTEON CN96XX board.
>>
>> When probing the bus 0002:00, the bus number preset by the bootloader for
>> the bridges under this bus start with 0xf9. Before configure of
>> 0002:00:07.0, the 'max' bus number has already reached 0xff. With your
>> proposed fix, the next_busnr is set to (0xff + 1), which evaluate to 0x100.
>> This results in a 0 being assigned to the secondary bus number of
>> 0002:00:07.0 bridge, causing a recursive bus probe.
>>
> 
> Oops. This is turning out to be too much of a problem.
> 
>> For reference, you can take a look at the code in probe.c and the
>> corresponding log.
>>
>>      pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>>
>>      primary = buses & 0xFF;
>>
>>      secondary = (buses >> 8) & 0xFF;
>>
>>      subordinate = (buses >> 16) & 0xFF;
>>
>>
>>      pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>>
>>          secondary, subordinate, pass);
>>
>> pci_bus 0002:00: fixups for bus
>> pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
>> pci_bus 0002:f9: scanning bus
>> pci_bus 0002:f9: fixups for bus
>> pci_bus 0002:f9: bus scan returning with max=f9
>> ...
>> pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
>> pci_bus 0002:ff: scanning bus
>> pci_bus 0002:ff: fixups for bus
>> pci_bus 0002:ff: bus scan returning with max=ff
>> pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
>> pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> ...
>> Kernel panic - not syncing: kernel stack overflow
>> CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted
>> 6.14.0-rc4-00091-ga58485af8826 #16
>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>> Call trace:
>>   show_stack+0x20/0x38 (C)
>>   dump_stack_lvl+0x38/0x90
>>   dump_stack+0x18/0x28
>>   panic+0x3ac/0x3c8
>>   nmi_panic+0x48/0xa0
>>   panic_bad_stack+0x118/0x140
>>   handle_bad_stack+0x34/0x38
>>   __bad_stack+0x80/0x88
>>   format_decode+0x4/0x2e8 (P)
>>   va_format.constprop.0+0x74/0x130
>>   pointer+0x204/0x4f8
>>   vsnprintf+0x2c4/0x5a0
>>   vscnprintf+0x34/0x58
>>   printk_sprint+0x48/0x170
>>   vprintk_store+0x2d0/0x478
>>   vprintk_emit+0xb0/0x2b0
>>   dev_vprintk_emit+0xe0/0x1b0
>>   dev_printk_emit+0x60/0x90
>>   __dev_printk+0x44/0x98
>>   _dev_printk+0x5c/0x90
>>   pci_scan_child_bus_extend+0x5c/0x2c0
>>   pci_scan_bridge_extend+0x16c/0x630
>>   pci_scan_child_bus_extend+0xfc/0x2c0
>>   pci_scan_bridge_extend+0x320/0x630
>>   pci_scan_child_bus_extend+0x1b0/0x2c0
>>   pci_scan_bridge_extend+0x320/0x630
>>
>> So, I propose the following solution as a workaround to handle these edge
>> cases.
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 82b21e34c545..af8efebc7e7d 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6181,6 +6181,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536,
>> rom_bar_overlap_defect);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537,
>> rom_bar_overlap_defect);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538,
>> rom_bar_overlap_defect);
>>
>> +static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev
>> *dev)
>> +{
>> +       if (!pci_has_flag(PCI_PROBE_ONLY))
>> +               pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
>> quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
>> +
> 
> LGTM. Please add a comment about this quirk too.

OK, I'll add the comment. Should I send the v2 patch?

Thanks,
Bo


