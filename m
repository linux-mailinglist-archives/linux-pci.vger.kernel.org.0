Return-Path: <linux-pci+bounces-42100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A2C8881A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 08:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787573B385E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FD2C08CC;
	Wed, 26 Nov 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIuPjL0K"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCD29A9FE;
	Wed, 26 Nov 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143535; cv=fail; b=sYj6omvxEBl0dPVSbDtCa3ymX7aAAgehvB7VcxzgIIqeGE7/X97ANNDC6IEdOQa+IuakN9nHyuAD5pRbmiCg5hx4yWpkTpUmziNhnHaTpMqhX7ekEdiJawvMIftrxzNkg1wadE4N6kAD24/cBJxlmFbcbKka2Fci0LI0t+BXuTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143535; c=relaxed/simple;
	bh=Tpl3rI4w41Ox2qUMylYwhiTMf3AvhQ6AQ1tF+KOcJGs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=K07BL2vQ6D2jR+yZ1u9MVjacaZ6NEYv9q6TkFDPEtl4RZIbEm7OrlNpjvvEDF7bAOiNJ3nc3U4zfjlOhjj9bBHMKbHYOLPr6sgXEon5bBJupFtRAS+XiSH6AEny9dff/bjhlL0AD8v/myT/amn22MVgKNTTliuHTqR5+DluWnFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIuPjL0K; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3vhS1tFWP1y7y2XaHNfozmJ1ayTTiN8pZiHFFqFbu2WMxVEuh88RAkqrpmL4GRGEKNwLD/ht/yHVJ2Ta4sQYadMPr7Tw2y5RlIx+S/KtvSxR3WTkl5AIQlKBRhVIutvDPHvUbdJLZKMFuuQrXRhnJkME4sxtWhL7qegst5ztLX0DzxnLdLowyM4rpyzC8AORNCIisVxjqUgfkVA+HJgPY+Yc3YhOMw2oLag/eNBRSmnXzpPsTl3K0881Uc/ygOuJYZ7E4QAhhgjEHBZhsT8ujmIOyZ3zcgWsW4l/628gEhsLRwhQ5nj4KKtvnhJBlANXUYbqq7uogWAUgR9kSEI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sQPIhCFSXVwh3UkqxT1ILh7a19MK45kyeyeMEf+0IY=;
 b=a3RD2hJ/uxr1nMpmfdu7uGT5LxkrNBoKAE0/XSB6/2pMPyHmbXu5qQ3ExZglrMpQUoEJMfxuUwXO6QiobzRXVRvu9dvLaTHGdHMH8OkFKXlhstaPGRiUzzFqo1J31c1uSdOqP/exw89mrizu/fGH9PwFW2RfaX4LnsxfrqghSI/1vM+onpAl2GquySrD7Plz0EZO6SCHpph0qEWvISssLhyhm48tw8pCzWJSPCk9uHn7A8sXaoE3+q3aupduQaWUPEoSQnGYX7G6ULC4i2BecuPJakGCP/T9pCes4f388mxe/IXB4FauF1JVsUNSXBIAm3QB+L201QEwssXLM48O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sQPIhCFSXVwh3UkqxT1ILh7a19MK45kyeyeMEf+0IY=;
 b=oIuPjL0K+bTPg8qKiI/DBxLYirNZ4u96mZGo/qgrBOuVkWpCPU6HAgt7FIJn9t3isi/2FGo+fH0fR3prx8x+7coIsNprGFi3bl8MoIGH4YjlwiQb9xwIOSmqnLs/MC0/wIKm34oqn2U614htAuXo9gKRtGf57/LSZnTXMWqBTkUqPkKv1nK5gLCPYHRMhMrIhQmwqa50mdpkkO8ydRPcS4hejONhGoaNNqe14YZ4AyWiSl/Q3zGFQ2nc/KYQGZ0yfUJGKotpiE3Y6utWzbNfv5RHO6hBN+UYIu3t56hYNzoT9MRFyFZh7Nh1v4OgNskqUsylAfh3GPrOYab8RVL0Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 07:52:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 07:52:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 16:52:05 +0900
Message-Id: <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
In-Reply-To: <aSXD-I8bYUA-72vi@google.com>
X-ClientProxiedBy: TY4P301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef28eef-e8ed-41b4-549d-08de2cc0b378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkRwaWNrVkF4WUJ5OWJGZ3RTaWh4SHhwa3MvQms1TXF6dDM4NUtJODRVQU1y?=
 =?utf-8?B?ZGR1clQ2RGp3TSt5RXFGSllsbENuamkwckk3TGNIa0d6L2pCV2xSYjVkSFNy?=
 =?utf-8?B?QUdyZnAwOEltVS95Y2dyZHhLMit0cUdQa1B5V1RqZWZKQmorZlRKbFBjbTRE?=
 =?utf-8?B?M1Y1STIrQ3kvRGhkNnBoUHNLM0J0Qm5LOWt2b01FM0VGdnVsQXRzbUZGMlF0?=
 =?utf-8?B?bkYvOG1xWFZiV0k2ZWIzVHIwQUx0NlI1WUpHV1ZBME9NeHh0OHJobUd3dUMz?=
 =?utf-8?B?Vi9SanJnR25MbkpnN0hhK2VaNjRraDNhMHBTVWtBN0xSV1poUFlxSmJRV01B?=
 =?utf-8?B?Y0drUGJWREFBVEdGNXpRQXFJVjB6ZG9oaVNQR0NVTWhWbVBTdS92Z2VISjE5?=
 =?utf-8?B?RG5nQVpMWkZGdFVHOUF2cmt5OVd4T1dmRkE5NTZ0NWdVOHBBUXRaYWVBVEF2?=
 =?utf-8?B?Zng4SUlVRzVueHpjeEpBaGZ0UW1sLzIwTW5OQ3QzMG83TWZCM0U4NXdYM0hH?=
 =?utf-8?B?WkYxTUxzbDB6eWxObU1kekt5Wm1rWFJNbDV3bjVqR0x3NmlibXdnd0xtSjQ0?=
 =?utf-8?B?c2dWUEJITDFYUFJKbk15K3AzUEk3cmJVaXR5NkR0MXBKWXVZWkNONDdZRkVN?=
 =?utf-8?B?L2RDV0hScGlaTEpxcklpa3M3R3BORlRROG5QYlJaQ1R4Ujh1aUJ3UmVTRkNB?=
 =?utf-8?B?b1dFM2lvNjZvbHdianU4VU41K21NNlNiLzlSN2toK3BMSXNVcEdoUHdrcnZC?=
 =?utf-8?B?Nnd2ek13RjQrdkV5clVJd1M2UStObFJFTE95VUU1MFo4bHBsLzVvallwQ0xU?=
 =?utf-8?B?K0FTUTByMjc4emgyVnduRkRoTDZkdytadG9YcDdRb2RsS1NWMDhvTU93YXNk?=
 =?utf-8?B?OWo1WkhBRUs1TGhubkJHU0haQlZqK1kyalRYbG5USXQ0azRPbnFYSU1Qa0U5?=
 =?utf-8?B?SkV4QjVhcjdmeFZSQXhIMWcraW5lUks4cEUwQ3phR0tXZUE1NlRUbjJHdTBU?=
 =?utf-8?B?K2pSS3VJMTZnQ0k5dkRhb0FFSXpZc3M5S242anhtSmwybmM0MmZwcmpjY2J5?=
 =?utf-8?B?R0Z4R1l2N21PclpOVFhzMlNxUWtxek5WNSsxNGU1QkJBcm1WRmZTaFFaV3hD?=
 =?utf-8?B?MkVMTU45R3c2OGlVUUI3YmVpL0JVQ01GS2YxKzRNZVdwU1Z3ZFB0UElMc3Fl?=
 =?utf-8?B?UTlubDVudElWdVJmdHlhSExMVXg3KzVWbEx3MGJlRzNmczUrRXEyR1FZeTc3?=
 =?utf-8?B?ZnYvQnVvNGZpdXBrSzllT1NxeElFMnp3aGozb0k1ZzN4ZjgxWnVDSjg0Nnlv?=
 =?utf-8?B?a21XZnQ4QUZDekZHeFdhMVNrMVNjaDBpcC92Mm9mT2dsM2paVW1wakExRklp?=
 =?utf-8?B?L243MnIrL3pxRm92cU9FSVZ5UGtqT0VmeDBsZ0RVbXIxUXBoeldpRU0vN0NN?=
 =?utf-8?B?ZHdsVmFxTnc3NjJRWlNwSml5aC9tdmsyNUs4M3pHSjhFWEVTOUU1enM1ZVFJ?=
 =?utf-8?B?a2VrSmV6VktZV01HT20xd20zbTJyRmFOTlIrYkNTR0VqN0xXWkJrVllVbFRX?=
 =?utf-8?B?dnl0VEpxRS9pdmxnVHBnb3doRVUvaW5aM1NsNkt2TTdWbDYzWXdxcXFDcjJx?=
 =?utf-8?B?WGNnZ01vZGFjQmZWbER5eDYvWHloTEQ3NjdWallBYk9iTVVvQ2ZrRTBuWEJL?=
 =?utf-8?B?QmJGNUg4TG9jb1ZjdjgzblI5TGpLWGt6WVhxR3JwT0hvWi9DZ2JRU1c0ZjRP?=
 =?utf-8?B?Q2lZckZnNUlVUmhUN0lMbExWbnpDNnFtZ3B3NDNydWNMZ1JnbXVDWWkzNDZM?=
 =?utf-8?B?eXpSdDJSVU02eHRaMHdQMDRURnArOEloT1hhdlpBb1JtcHRST1BRaHhDK3Mz?=
 =?utf-8?B?d29RY3pQYXZQekVLTzhkUlV2NHN1N3VvYUI3RXJmRUxRUHAwb3VXZG5WU3Ar?=
 =?utf-8?B?SXdpdDJYbVVpSzNOaW1CdjJLRmlSVFM0dGhkbW9SeXVueUZjQ1VyTFhnL3ha?=
 =?utf-8?B?UGpza1RWUE13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZUZjBSR2wwaSt5K05qVTdzNlh3TGVscGFwUlNSVmRrYXZmc3M5NTdaSjRR?=
 =?utf-8?B?S1BXSjg2U0VKUUJFZXR0UkJTWHNLTFhwRDIxQXQvYTcyVlIrZzNFUVVlaGRt?=
 =?utf-8?B?dGFqNERIVHRUUkZCU1lORC9PM3dCQVdrUmgrVUorN05ya1BNaWpSZ0pHanNo?=
 =?utf-8?B?RUNJNHlpLzR3MU9pa0kxQkhXS1Rub01oRmR1SGQrSkdGVVpzNTFqMVBNR28x?=
 =?utf-8?B?eEZDc2V2K0lBbklUUU1lbTRXbEpqTnpEcmxweFFHTUJ0RGczMmo4YjFRLzF4?=
 =?utf-8?B?Z211MjdhMUNObWR3ZGc4dWxLVnVXbWt1UndOenFxWXlDZkFFZjdpZnM1d3gv?=
 =?utf-8?B?b0svaWdRNktrRjZzT0J4eWNjK2hPcDdTNVhqQUtkR2hoOUtPRDJ3ZFl3SVlY?=
 =?utf-8?B?anFDZGZiOHBYZVc1VUVDNEhBeUVqTWQ3ZDhvMk1KVS9kUDQ2NmhhMTcyNDNp?=
 =?utf-8?B?b216L05SWWppcmFWckhwbjh1c2E1Tk9mcWVuNldWZWNJRDhJOCtNTTIzblJU?=
 =?utf-8?B?Sm95Mk1YY3kzVHJnQ3dWaXBNWmVKTEJvSXRucERPQ0NtcTFtVS84OTRiQi83?=
 =?utf-8?B?Qnp2L1ZRTDBYU211cWd2M1JNTWtsemk4eXFwVkhYbFBva0YyK3pCUnNHaG9U?=
 =?utf-8?B?T1hFaUZJMGloS05wSmYzMytPQ2dKbmptUlIyekkvUmVDbmM5V254K0xCOUw3?=
 =?utf-8?B?VVM4SC9xRnFUSjBKRW1KMTZTTzc3cVFxcjlnSStyZHZxY3dodzJCMnFOUTJ4?=
 =?utf-8?B?VS92OGkvUGwza1ZKNXpMd04yV1AvRHV5YlRRUXBaQzA0QjJRSWVMMW9nNkRx?=
 =?utf-8?B?aWE1QUxrTFlWTXczUHdWc0hHMVh3c0JqeTF2SFNPa3VDK1o2c1ptMHJjSWpP?=
 =?utf-8?B?YWZUZE4rZm5YY3N2ZjNvSjBNQ2xKRDY4TzFHK0I4VHYwOEtURDlzaEQ5ZjZs?=
 =?utf-8?B?MXNBOEdCUE9tVnI2QUpFSXMydmJkcG81SVovZ1VpRjhEaHl2TFJsNm5MV0VV?=
 =?utf-8?B?SWZ2SnFTY0tWYXRKa2tZeFA1WFJrZGk1UExrSm9kTnYxaWlMb1VONHA1c0Qz?=
 =?utf-8?B?RGV5WGcrVFRvSGRIaks4MTRTQzFVRkh0Y1dNRHhXU1QrdjljUEF0bDdoZEhF?=
 =?utf-8?B?alBySmNjMG5KRTJZUUxkbStNSGJWZEc4WUFpb280djcvdFNRaGxVQUM5dXdX?=
 =?utf-8?B?MFVxMFVaZWZ2R0grb2tGdUZObWpsUEx2QWpYaWI5MWdEL2pUM1JIZ0ZwWnpo?=
 =?utf-8?B?ZEVsVnY2K3ZvTys5MForL243WmFIRFJvZDFkWkhrZ1dLUjNxK0tBaVR6ZHhS?=
 =?utf-8?B?eEFwUjRodG5ZeFljdXFkbUNiNmFwQldxNysxRExhSDZNWi8xc3VvczJkdmJS?=
 =?utf-8?B?aExqdWw5eHp5S2xWdmcyNjVQd1V4blpsR0pqL1Y0U2EvemwzRWtXZTIwUEF1?=
 =?utf-8?B?TUxvbnB6VXNYYjBKZVRpZUVWakRmR2dYU3dHbkpORGdzbmNsa2sxR1ZydlhM?=
 =?utf-8?B?aWd4Q2hGalJMQXRVRC9qejIxNVV2T013YnE1V1JySEpEUVRFaTIxWCtnVG5B?=
 =?utf-8?B?M01kL1FyVmhZME95VmdWaUJrcHFGSGhKekMzeVNhL1htNk0rbmVZUUltQnk2?=
 =?utf-8?B?cGowdktIQVpQcytCOTgxMTJ1ZFhPVld5dWQyT0lPSXlDc3BoMjNtaXc3cmRp?=
 =?utf-8?B?RS94VkpuMk15dzJmQ1h0VVNzOERycmJwR0JRcHZFc2xVNXZuYWxLMDFoMVF5?=
 =?utf-8?B?TGM1aFZEeWxaYk9VZHZhdUJiUlZ3eWFGcks1YUFNaHgxWlVRbEJDaTFVOEFK?=
 =?utf-8?B?V1QzRUwrOGlHczRrSEZ4VlVYSktHQlhsb1huNGw3OC91UWJGVG5HeFRrS3dD?=
 =?utf-8?B?RlJFcCtrUnlMSlNmdHFPQ3JPRWVxWUpkY0xsUVAvcS9maVdpcm52Ukl6NFVD?=
 =?utf-8?B?UzBraXYwcHpuMktYVUNyMHVMZGhyV21wM3dhYU9IMVpIa3htQ21RSTMramQy?=
 =?utf-8?B?cDZpancwbzRNWnB4RzMzNURIV01kQmVoWmozVnh0YWZDNS9SRXphYXlTZVZY?=
 =?utf-8?B?eDZlWTNuYkNZWkg3bGs0NXpUSVQ4aGc2amNrdTJFM0FibGNxWVg5MVhsVEVq?=
 =?utf-8?B?ck5tWEVJelJTSXpZOEtKTi9lU3dXdDFlU3doblpQN3ZsdnZVUjdISkFhMXpW?=
 =?utf-8?Q?crAHUty1gqWOdjXGanUR9FWrNImhrKMW6Ekbyvzt7lMA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef28eef-e8ed-41b4-549d-08de2cc0b378
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 07:52:09.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pCIR6+bJfFAOT7U99dkNqHnVPhAnc58BU/kJtXHOIds7xW5kfkaFtWuJF286WMGDXRrV7rP1MRA6tZyrejXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469

On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
> On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>> >> The previous Io<SIZE> type combined both the generic I/O access helpe=
rs
>> >> and MMIO implementation details in a single struct.
>> >>=20
>> >> To establish a cleaner layering between the I/O interface and its con=
crete
>> >> backends, paving the way for supporting additional I/O mechanisms in =
the
>> >> future, Io<SIZE> need to be factored.
>> >>=20
>> >> Factor the common helpers into new {Io, Io64} traits, and move the
>> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing tha=
t
>> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementa=
tions
>> >> to use MmioRaw.
>> >>=20
>> >> No functional change intended.
>> >>=20
>> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> >> Cc: Alice Ryhl <aliceryhl@google.com>
>> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> >> Cc: Danilo Krummrich <dakr@kernel.org>
>> >> Cc: John Hubbard <jhubbard@nvidia.com>
>> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> >
>> > I said this on a previous version, but I still don't buy the split
>> > into IoFallible and IoInfallible.
>> >
>> > For one, we're never going to have a method that can accept any Io - w=
e
>> > will always want to accept either IoInfallible or IoFallible, so the
>> > base Io trait serves no purpose.
>> >
>> > For another, the docs explain that the distinction between them is
>> > whether the bounds check is done at compile-time or runtime. That is n=
ot
>> > the kind of capability one normally uses different traits to distingui=
sh
>> > between. It makes sense to have additional traits to distinguish
>> > between e.g.:
>> >
>> > * Whether IO ops can fail for reasons *other* than bounds checks.
>> > * Whether 64-bit IO ops are possible.
>> >
>> > Well ... I guess one could distinguish between whether it's possible t=
o
>> > check bounds at compile-time at all. But if you can check them at
>> > compile-time, it should always be possible to check at runtime too, so
>> > one should be a sub-trait of the other if you want to distinguish
>> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
>> >
>> > And I'm not really convinced that the current compile-time checked
>> > traits are a good idea at all. See:
>> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>> >
>> > If we want to have a compile-time checked trait, then the idiomatic wa=
y
>> > to do that in Rust would be to have a new integer type that's guarante=
ed
>> > to only contain integers <=3D the size. For example, the Bounded integ=
er
>> > being added elsewhere.
>>=20
>> Would that be so different from using an associated const value though?
>> IIUC the bounded integer type would play the same role, only slightly
>> differently - by that I mean that if the offset is expressed by an
>> expression that is not const (such as an indexed access), then the
>> bounded integer still needs to rely on `build_assert` to be built.
>
> I mean something like this:
>
> trait Io {
>     const SIZE: usize;
>     fn write(&mut self, i: Bounded<Self::SIZE>);
> }

I have experimented a bit with this idea, and unfortunately expressing
`Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
not doable as of today.

Bounding an integer with an upper/lower bound also proves to be more
demanding than the current `Bounded` design. For the `MIN` and `MAX`
constants must be of the same type as the wrapped `T` type, which again
makes rustc unhappy ("the type of const parameters must not depend on
other generic parameters"). A workaround would be to use a macro to
define individual types for each integer type we want to support - or to
just limit this to `usize`.

But the requirement for generic_const_exprs makes this a non-starter I'm
afraid. :/

