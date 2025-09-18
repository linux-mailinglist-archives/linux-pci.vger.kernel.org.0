Return-Path: <linux-pci+bounces-36412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A8B84398
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D3C3BE338
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7302DBF5B;
	Thu, 18 Sep 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQ+L0h+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331327F728;
	Thu, 18 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192455; cv=fail; b=Q7qlu6xPP4UH5Dj6I4LQGje6O5laEbTx96JDrUNmrC0xfSs8zAtcO+nn6O4omgB0fTF1CVD2FTygS/jngh+p6+DbhSVVYJnDMAds31dxSS87uQ+GPf347uulnF2xf9etqgb2++BuFKNyfnuJnxQ3TTxrOBGqYS0mkzzikmYo1Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192455; c=relaxed/simple;
	bh=B64I8hhZThq/6lBF/PM9cvsf2K4oLwhQtzkdUvuRdas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8m+4y0lx4oSs2W1MucYXj0alzRPemFMAri+IQ5FdXd19CqmrLR8oYJ7dRo44vmpUbFJnT5IyozAiyLmOuUrFq+a9zu25CUfFxhFFhY1d9DldgFeyJ9WBm9rE530uZ2BNVhLb/2o6NKQTzlBWxRufexW45n00wLvdAZdQgeyHYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQ+L0h+8; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8xAFrccZqFUFZDMGJup8H3aPILtK6M6zPZttViIfmV5H9PGJnxXPDgYJAbzDK/utDOmsiDX3mMMRATwfF+W+VXVJwpAH/Id5oP4/t3/Ih/sSjSzCz0k/MCV0pL86rZT+eqEhqJkAJko4zbneiye84vFvsmwTe2Qx/WVhyYAbflGAJ/nUKnGo6Wksv2KRgHMgDjfCMvllGiAoCCKYIGLMcwKX7Oqu2nEWzh7W2R5/3oZySvDfKIzqg05budeFEa1mhBwp4nB+IlMtNglM4eQ+l9b06l2WzMw9g7svmk+ZOHix4Ce79SxiioZJGqarieQrbjJLk+vgBdphBQmzDal2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Kr8npEFYAQYNHegrs9QRU+KopgTyHYNfcpjlTuGew=;
 b=TFKD2Hd8AljRvUqdFHkzbrpwOzLKpmc+yz+F2qXWcU/o8T7z6vXuTfA1ouGrvgXyi3g+BtJH1kMJQpl39xiPbZCzxYIOGeHFr6VGkjrKL3gWGEpXI9HaMyrhDz+DCgCKn20T//yFtoK0y6ssXaT36cJHshksINanFPU4vBZdZMYphqLWg9FXMYyLG0OCK1ySE+VfnJR5XfPr6qIKEI+7tBzvj1b54g56CJ1rfjQos2q4sNTDMQB6zAJhIAx8A7eAq6fncnYSux+kQ/W2ttCTMX+U7vfAX9w3xlQbqPBKrW1H3NiunaLD2LvubrbJuOeWiWxoPrdoy9ZvqUAZuse/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Kr8npEFYAQYNHegrs9QRU+KopgTyHYNfcpjlTuGew=;
 b=fQ+L0h+8A0ovURdpfk5MmAxpzXh0OiO7JCWVGI0ql9EZaP6/SMGgIAaLmTf3wqA5/TgCjTa7gbl2fFWd+uVk+gnkXGp5nrAR9qTpN/WRgNxY5xw/IMfRgQ9b8/9Drb9AgVE3sIG/zDaLsYpCIaibYaybokSLaH/oxF5D7fcaORh62ZsQ5NNA3iJWfGwzjhehPL1pN/huiGohVdoaD1iyGSA6Uc6DZEKxx3BqvBXI3XPmJQe6nlV5v6ceEqII7qWnjUP7VLJAHmUWuW7HBzdQfmiSm1k1Wj/J/FGXWL8YRmymuZ8ce4q/ey6btavIKAjXy3/3FnvnwI0miuFezH6iPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 10:47:30 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 10:47:30 +0000
Message-ID: <29aa275c-ba8a-466e-8179-ff90f434541c@nvidia.com>
Date: Thu, 18 Sep 2025 11:47:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe tegra194 endpoint mode regulator question
To: Niklas Cassel <cassel@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <aMp-z6BufaYil30R@ryzen>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aMp-z6BufaYil30R@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecf0e2b-8106-4e58-1ce7-08ddf6a0c3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VURpd3JveGtPSzh0dUd1TFhWRmoyRHR6eTh1aENjNmI4ai9RRFhNb1BGT2ww?=
 =?utf-8?B?QjFvVnFucjNBZS9pOWx0b1JNdGJEY0VXOTdFTDZ3bkhwd05JMkp3ZlBzaE9W?=
 =?utf-8?B?MlZoUkd5NGEyU01zTlV2ejEvWTlodndqcnNSVktvNnRSUXFJUGdoS2IxQ3lW?=
 =?utf-8?B?YXVPNXFsRUVJTS9jWU5yZjJjbG1ncFFhd0tqMk1tSGdnNlVKb3B2bWZWdXpp?=
 =?utf-8?B?S1l2WGZXanlWaCtta0pLRFJTTG9tcXZQN1djdElaRjNUY0FOZHF2Smg5Qi9U?=
 =?utf-8?B?WWlQcUI5Q2NVRktIVHhkVHNmMFRnU09xbXAzQWFoSFh0YXdLdHpsY2FmOGwv?=
 =?utf-8?B?U2tpNGVqSkVoWVllUE54OG9ITmM1dTVSOVd6eVRYTHh3b1RCZmJkcVBPMnNh?=
 =?utf-8?B?VlNHcTlqWkxPOE5FZFc5ekttNFJucXF2dWI2Wjc1S2NMQVo5TEF2NUxnVG1T?=
 =?utf-8?B?SFN3Wkk5RXZ5SWcrRGc2K0RuWmNKL3U1OCtTNnNxdVh6Wk5BakZKT2cwQWJS?=
 =?utf-8?B?SGs3cW01Q2lUVDJtLy8wN1hFV3AramljVVJvcEsvcHpGLzdCLzJ1aE02T00r?=
 =?utf-8?B?RVIweWxOUlVoRkxWOGljR21RS05GYUZCRWtRWndhUjBWWlNtdElSb0VVS2Ix?=
 =?utf-8?B?Y1FLL3ZzQXZBcXZZeWZNRDRVRzhMbWVXZmNlQUxocUlua2M4Nm1CMVBPdk5m?=
 =?utf-8?B?aG9wTnhlaFBUZ2ZrSFk1K1cvRlpjQzhuMUQvYlpjWU0zVEcwc2piamJ0Ym16?=
 =?utf-8?B?RW02VTNwU20wTnNaNWluQzR2SDNRV2l6TG00U0tHQ1dFbXFncGtwN0VJSXQz?=
 =?utf-8?B?M1JqbVlFZXJoQ3EwbE9LdTVHcnY5TVpWVWg2aFJRNk5TNW9CbkRxMmgyVVRt?=
 =?utf-8?B?VGlvL0ZvWGtGZWlIRnFBeHlVL25IM1lFSnZ5RnlnaExwZ21JVk5UNEpVMUtM?=
 =?utf-8?B?N3VYcUE5TDVXOU1iZ3ZxdjBSOHNBSWVkdE9tRlVZc0EwWjNNbFNXV25mQW5v?=
 =?utf-8?B?L3BDY2JyRjdEQWhXRkZRY0VocEJiMzYxZjVXaW9WK3RmM01maWRoQWpBWnEv?=
 =?utf-8?B?elZrUmVxdnRzVS8rQ0p3b1VSOFI0UkRTQjA5bFBZVDVjVXNwWWdTazNoTEtu?=
 =?utf-8?B?SWZybS8yOGZHWjNWR05uZFlQNVdONWtFaXYvdy9rcGt2NngrdU9WMk5YcXJy?=
 =?utf-8?B?T0pwV0RMUXF5QWUrbUJNajNSeHFGUnJNcHFObFhpNzZsMDdBNmc5YmZVaUxW?=
 =?utf-8?B?bXF0QUpPSVRQV3FseHlCaUV2RUVoMGsrNlA5SjgrcHdQeGZ1dGt1UHZaQ1dn?=
 =?utf-8?B?SXBCcG0xZFlZeFJ2eTUvSURDUDNFb2VTM3lLTkdocXQ0Z3dlaUNnYlVlS0NJ?=
 =?utf-8?B?RGFueE9NVjFBUXVockRJaVJrQ3ptNTYyQkNDYmV1NzRIWDVJdTlLZ2dpZmtx?=
 =?utf-8?B?YWw5YnNXSUFCQ0pjTk5KUjRjTVpxMzA4Y0NYMmhFMjNMWXU0ZFRpcG9BZ1dx?=
 =?utf-8?B?a1lpZXg4V2pqVDdIWXNDbmZMQ3crZUNpUmorSjZCNjJURENXdGJDWUdFME0x?=
 =?utf-8?B?OGNpb2xac0FYUkxzTnRYSldVTi9Mc3V0NFEyaEdMeHRPbjRlYm5GWERRRW5a?=
 =?utf-8?B?MnJ3akJtNENFZjZackxQeHVoRkk4UUtJczhrWUVSZ21xWitvZkljUyt6dTg1?=
 =?utf-8?B?bExHTytUTEptMmV1bDlSRUVSSHc0NzhVeW1HTU9tclJPL3Q3bzE2eVdRNGh3?=
 =?utf-8?B?aEVpVlJiWDJ1OVRDWDh1TnR0MU83RVQxOW0rMU9zVGZudWlFSml5VUJSNWlr?=
 =?utf-8?B?RUI2RkpkQ1U0MTBHc1dweDYwOU5iUktUV2xDOXdKVGlKQkx0eHZOdThDZ3p1?=
 =?utf-8?B?d1JFQStCQ1dzV1RpSDVVeDAzSmIrQ1gxY0xCbDRlY3dvYVVveXB1SzhaT0J5?=
 =?utf-8?Q?sW3qN/RzWEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck11SUNncEZaSVRxb0dMQ00vZnVyK1JrL2pQcklXMEJuNDZUa1YxK05GWnk4?=
 =?utf-8?B?MmFSMWQ0N2ZIcU9GaitodGlpYS9JVXpwRTNOYmNKM1FpN0ZhVTQ2T21HRzB2?=
 =?utf-8?B?OEptbmFJVWZHTitpclV1RWNhajFncTVFVGF5S2tzMUxCelpnMDBpai9pUVlB?=
 =?utf-8?B?cldNM0hrSHRUUjdIM0s4YVp3VmI3bFFYNGlzbEVhWnRUd2lCZStwRnFCcVdM?=
 =?utf-8?B?V2wvTy8wSUk3WTBpZXB6OXFEQjFnZDc2dFhJQzYzVlhOQjBTdW0rKzk3RFBS?=
 =?utf-8?B?WURFNzE0QXJwbUwzSktpekZhckY0VU05SEhhMUZBZTNjcEVaS0R5eXNyMjRN?=
 =?utf-8?B?SlVGT1VzeVBsek1hYkl0OVV5ci9SYldNSEVnZlNjK3ZjdGRGNS8wTE5kbk5a?=
 =?utf-8?B?bFZpTUErODdJNHFuVGRidFFpNGFLOWJYRE5WTkxDbHp3VzR3YVRieWJRZGN1?=
 =?utf-8?B?dDhJUWtldndnOEtIRTh4THpvNWR0RTZscFpCcnhKOFJXeHNNT0RQSVBvWWNN?=
 =?utf-8?B?R2xOMVFtc1pJNlI0NFlHVHhHRnUzekttRGFjQ3MzRmIvUG1aSWtkYTIzRHRU?=
 =?utf-8?B?Y1hDSGhROGdmYUdwUGtSOUNOK2hMVGh0TDBpUG9IYStFNEtuQ2x5UldSOU0w?=
 =?utf-8?B?RUJOdmlzTkVxaHFSd3VjN0tNMlhtb1ViL0pGV1d0RU4zc0xnTW1VUGVabXFK?=
 =?utf-8?B?NVFveGliVzZyUXRhM1dSOXpDODZGSmUwd1FCMEFSa2RURENqVGh5Qmg2SmNB?=
 =?utf-8?B?Mmc3VnRKcGVkUFNYVExFNXhTME42bGZ6MG9MN1NaL3YzdS9rTm9nZXRJdUN4?=
 =?utf-8?B?SmlSWWs1U2VNQzE0OXhPYWpoa2daNkRmeExzVThycmFqc2pEOWVsS1haWUxa?=
 =?utf-8?B?MzNIaGoraHFwVGVmeDFQb0Y4MjRtMTVTY0VnR0E3eEFNT0hIb1M4ZmxIRkpY?=
 =?utf-8?B?Tm5TRVJNY05zRHY3VnBoN3RVV1VTL21nN0srendZQ09jekJVZUZMTWNBSmVr?=
 =?utf-8?B?SGtBUTZpbjFZQ3RkNHlqelpRays3MlRHd3hFSVJ2L2ZZZlczelExS1VCZVRZ?=
 =?utf-8?B?NVdGQUFRRCs5d2YzajkvNWlydDMxM3BoVWUvVHV5TkRZeWt2NWlmMWVGTkZV?=
 =?utf-8?B?cmpGSU1veUV5NDBRNlJpZGRUQ2xad0lNakxFZDhwZDZlSWRlQ29YQkZMYVhR?=
 =?utf-8?B?L1FxM21zVmtoeTJQbEFmclBrbUs1bjVTc0xIcHlxQ3Bqd1IzT1B4Z05sam5Y?=
 =?utf-8?B?VHhhdFZkRkNvOHhkYkg4VXlQMTJNOUs1eDNqa0ZUWlJEZzVmUnhwbkFFWDc4?=
 =?utf-8?B?VEFkSTFNV2hHaEg2aGZOVzVYZGNLUHB6T2kxRlZoN2hFQ0d3NVZGdFJJaE1a?=
 =?utf-8?B?VW1WdUc2ZVN5MC9OYzZ1Slk3NXF0ZExVQjhqT1B4U0pRWDIyUEpwRWhKN2pH?=
 =?utf-8?B?b0JJaUFUSFNqVjNUVzJ6WWZzdC8zQUh1TnR6Zk4rWjJWaXIxTFFsWmwwVWU3?=
 =?utf-8?B?SExiM1dhckRQTHp5UFhYck80NGprYmNQQ29MZ2FLaXVxYlpxVjBOcGhOWDdF?=
 =?utf-8?B?K0xmbXVGYkV4V3hTU1RWWVBIbEZvbEgzM2ZoUldySHB6YVFaWW91WFppeWRj?=
 =?utf-8?B?VkRJR3lRRUpoOTI2WnYvUEtRR1NXa25EN250UkNSdEE5TVpzNW1WdlNPK1V4?=
 =?utf-8?B?TjkvUEduRU5hZEZVdUViczJHZ1VkQnJIVndsc3pVVkpydDFFWVRWVnVtV2NS?=
 =?utf-8?B?bmNORy9BN0NuM09JWkl5Q214dU44LzUvTEVldlB3U292bjJsN1NrbzFSdEpj?=
 =?utf-8?B?S2Rrbm9BMHJOckh3V0ZUN3hWSFVmOWJJaTQyRG12aC9vZVR3eTI0emhwVnVi?=
 =?utf-8?B?ei9kWmNRMkZSYld1UGx3SUNQOUszem9pMkpXREFKQjR1aXcxNFNNTlVsVmZp?=
 =?utf-8?B?dXJRYm9RWndzY0JIS0ZTdDROdWoxR1JrNnpQSjY3OExVcVMwTDRQbS9NN256?=
 =?utf-8?B?RkxoSld1THpjNlNXSnV5QWRWWE5zS0o2S0IwZEoxd3hHcEZEOHhKZ1IxMDVV?=
 =?utf-8?B?TjJQZE9kYlhUQXZTdFJhK2FvdWhoaW9GdDk3dythYXVzNEs1U3RvQ3VQckV1?=
 =?utf-8?B?bFNoQk5uSGJkbUNhM3VPYlZZMEZESTdCWWlmcjdQL0Jmck8rYWt2NmcvNDU0?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecf0e2b-8106-4e58-1ce7-08ddf6a0c3e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:47:30.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07HdraUwFD3701eD8qx2Ja2QYFGYG38q7yzl0rXjBcr/vR4EguZTb9RFVM+z2meZEGzKQT2tCf2M51woT78T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

Hi Sagar,

On 17/09/2025 10:26, Niklas Cassel wrote:
> Hello Tegra PCIe maintainers,
> 
> Looking at the device tree binding for Tegra PCIe endpoint mode:
> Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> 
> We can see that 'vddio-pex-ctl-supply' is marked as required.
> 
> However, when inspecting the driver itself:
> drivers/pci/controller/dwc/pcie-tegra194.c
> 
> regulator_enable(pcie->pex_ctl_supply);
> is only called in tegra_pcie_config_controller().
> tegra_pcie_init_controller() is called by tegra_pcie_config_rp()
> (Root Complex mode), however regulator_enable(pcie->pex_ctl_supply);
> is never called by tegra_pcie_config_ep() or pex_ep_event_pex_rst_deassert(),
> or any other function called when the driver is using any of the
> PCIe endpoint mode compatible strings.
> 
> So, I think there is something wrong here.
> 
> Either:
> 1) 'vddio-pex-ctl-supply' shouldn't be marked as required in the
>     PCIe endpoint mode device tree binding (or perhaps not be there
>     at all, since regulator_enable(pcie->pex_ctl_supply) is never called.)
> 
> 2) drivers/pci/controller/dwc/pcie-tegra194.c should call
>     regulator_enable(pcie->pex_ctl_supply) even in the endpoint mode case.


Looks like you added this. Can you confirm if this is needed or not?

Jon

-- 
nvpublic


