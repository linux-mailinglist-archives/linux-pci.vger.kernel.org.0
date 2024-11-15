Return-Path: <linux-pci+bounces-16889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A39CEFD3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E961F21A80
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54A1C07EE;
	Fri, 15 Nov 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uovvuDNL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2058.outbound.protection.outlook.com [40.92.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AA1CEAD1;
	Fri, 15 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684504; cv=fail; b=ZpynIRIdlulWFFwQ/TVr7dpRYlKQZiG+YA/Rt/DnYFvedshrvEwNL6KsJJokYobDw4BbF/jQ8CoUVcPzep6hU3YRXVS0Y/MCFJOs3lQ44MBxUJy2vhN2835e1Tm0YXnWubZci6shk8eb3Wii0UIvrioQImOT5xplYvwRwUzBymU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684504; c=relaxed/simple;
	bh=ZLRBqW9eBCLbooxCTEmUqMahSjHsCN+9AFzwkfdOj7M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qbsVU9HKT8EjwIhVM6LURtLG+OIXoF0/flfX3HxiKIea7EGUMfBZF0VpB6MQHWii5ahP5lMQ9n2ZEjDYN3I+uKYc/0VTrWjO5De/M6hPVWOgh5k3h627IDGrCzg9CZc6ZfglbFh9iXCveLMAyu6e9wZbcNmE0mziCTpjDqA+H9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uovvuDNL; arc=fail smtp.client-ip=40.92.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9aYSUYEhzUVrrmgdVvtqY3YEpP1zJ9lWyoQIDk+bip65FzUaD+IpA8yU4f4uaRBfBsocvehJ++8X64JNXAKYSRHMvGzEOiqUl0K8fh/MX6WAvMlPDHdA3qtAKYUKHDN9xb38FDFXFhI4QCF6BI+DycbiFwesvdzHqQXjk9NgricQJkMnype1safgVC7BTtxKaGSY5wbE8PgOBaZ57K7wFyjvfpiMfn7pr+44+Xb+23iKXHhuTnuhqM5x9iuim4BtBbsj2uFWGUrTm/HQXUYnlXmBHr+N/KXhA+azBpuJ/ylriSQP/06BBazZxzheh7U0ZbXddbKQ3yK62d3N2Lyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xt4RRoG1phTSI+k2jA8el3ZJy5Gk+4ILsZetZ+UTgg=;
 b=w5qRgX3lKsC4CvtS/lUIkXIdJmWai9mbC/Tlxv0QIe2tHoUIsSMSFQcK3dWFwYcqq7aZvvdBoyLiStgQJU7daryxMthvMSyVPpwqHrY/e+RVzgXJBc1r6hwMeJ4FtII7QdY2QW8aDWXeAJHUgDCyQLi5dIRkC09jAGmiF1c4EQJC1g0WSB5Gg+/d6IFA61fxYWPSL5ns0RJ9mZMkYxcf8i/IScz1S56wc8ESjJuv8ENrRY4/yVt4YQgA4IO4EUYNx9Yv9vFuChrJu3EIigM3rYlHyk53AqR72BFc6Vdx3T8rm3z1iOC91cM7M2/g75J7OW2Pq7Yr9W8Ue9qbhSHo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xt4RRoG1phTSI+k2jA8el3ZJy5Gk+4ILsZetZ+UTgg=;
 b=uovvuDNLSUqFUvuB197/McWkYrm/SkujEJ1jVzyZmPdXY1a4MRBE3vRoPrMVSyYNyEVbNCdr1zuLKJDQRLWLwFXcuuF3BNJ9LiI1xTRPE1y9a/tNYYcmVxYHr6n6jREml9i9/uYYig8mcfkANLObrY689bxGdXwRt/Jud4/Y/jX4dlHLkhWqq0NDepDeHgfxjWVbj5pmRwWZJOSAqTSTj+AfKgE1cjCoVIuhhZ9kLJT7UyykUAC1BZfoUPhxlpaBhkCbGohu85rIt5Hucbn0OC0OoG3XGAugVJ2P4fbdaMcnOUYt6fEZOJCxP2Tt69QBvuFDNWmnD8pQu7QqbCeJ+w==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by DB8PR10MB3960.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 15:28:19 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 15:28:19 +0000
Message-ID:
 <VI1PR10MB2016F4C71BB315D61076ECD7CE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Fri, 15 Nov 2024 23:28:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-9-terry.bowman@amd.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <20241113215429.3177981-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <4994ac27-8dc3-48c9-b136-9f75092578e1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|DB8PR10MB3960:EE_
X-MS-Office365-Filtering-Correlation-Id: f53824ef-ddbd-4e39-c171-08dd058a2197
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|36102599003|15080799006|461199028|6090799003|5072599009|3412199025|3430499032|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUhHUml0a004QmFTRWVIa1JJL0txY2p4eDRIcXd0OXlBQlJmQUZTOUxwNzFV?=
 =?utf-8?B?MWxwUHBvOVFmSXVPWjhkRHBqWjRXRUxQdFFqSTRFOWZpTis3WjJ6dGhGUUcz?=
 =?utf-8?B?eXd0Wkcxeml2TnBENzg0VUplTXpjVTR0R3FmSzlwVWVGUDJWTUs2WUcvKzAy?=
 =?utf-8?B?QnZsSmtsZk1GNkdoL1FPQW1KaGMwZXBkL29UeXNYUmtZL3BobjQ4MGNDeFFY?=
 =?utf-8?B?RkdaeGdZOFc1cTlWL0JTYk1vZDQ1Q1F6YUtydStyUGZqcVNoWUJQTEs5M1lE?=
 =?utf-8?B?bzVKSHY0UE82KzNYSFN0bExJNEh5NVpVTWNTa2J6L3pFMzVZYUM3b1ZYNElW?=
 =?utf-8?B?RHIwZUhaTkZnU093L0ZNYk5vcGdvemtFemIzTUxOeURxRmxtRFFJOFcwNGxl?=
 =?utf-8?B?eVV0QVlKclNRVUFkRk5Va21uSkpEVlFLdkdFK0lzQmc3eVkwTWtXNjBEOU5K?=
 =?utf-8?B?VjdrQ2x3UVY2UDZERVFiRDRsdGhkQjZ6SEdLZytkOS9MZjVoelEzS2txZWg0?=
 =?utf-8?B?MGZTTkltdmNuaWI3L2RTTi9EZGE4ZzNVTnpQR3ZJbkxNdHlnQnlnbWlOOHFH?=
 =?utf-8?B?ZC80ZDNCc09OUHpwYnFWZFo3Uy9oMUQ4MytxSnN4MUVHNkVtYXhad2FIQ01t?=
 =?utf-8?B?ZnpISWZFelVtMGU4UzdHZkErS1c1a2hSOVQzYzBKUDNwM1dtSjM0NjdNOEls?=
 =?utf-8?B?V3pQQmw5MFVvTmtvK0ozbW1SSEt5RmF1bTZldHBqbXFRUkNxT05aNG5FZkRW?=
 =?utf-8?B?UmFDVHBsNE51QnFjM3RXQnVUYWE4TGFpdTdjcXR4cGhnK2FPV0xuU3FKNWVz?=
 =?utf-8?B?WW4xVGtQYUd0a21MNW5hN2lzU0M1Ynp4SXFQNkExcCtKaUtrK1pvbCtoOFNr?=
 =?utf-8?B?S05DTmtvc2xJQ2RWRWZORFF5STlXaUpVRXpNQU1ER0w2c3o5bUlKV08rM1VZ?=
 =?utf-8?B?SVZkeW54R2RPUG1sTVl6UXVGNU1QYXlZWUQyYXc1RjhVbnc0bklIdW00Y3Fa?=
 =?utf-8?B?TG81cnZDRHgrcmxNY01OSitrc3BUakY3a0NDUkdFRm1hNzVDa1pzUG9ORkZR?=
 =?utf-8?B?VTE2cG5XVVhQM0ExUTFUdW1RYU8yY1N2YTZ1eEhINUpPZG9DRkhVVEIxZmVk?=
 =?utf-8?B?RDRoQUtsRTFEUmc0S0xqZGhzT2M5VGZzcHFtdGc5N2V4OGZNTG9mS0F5ZFc4?=
 =?utf-8?B?VzlpbHVKNnJNT3I5djY2cTlpQ2Q3WWE5T3FUODJST2hVa1p3ZHppbGZGajZ5?=
 =?utf-8?B?S3dzaTdGczA2LzMxT2g4OU9rZ2VBcHFDV1cvSDAvbkFEZWpRUHo2Z0xiV1Ny?=
 =?utf-8?B?M2w2anVvdUF2ZURiRCtTN1I4bDRHTm94dWc5bnZtRWpIWXRsU20rd255eDg1?=
 =?utf-8?B?N2ZHT1dyOWtaUTNyOElUeGprWk44OTVKbFZoa3BFbE5oV0p3M2I1dXFmOHBa?=
 =?utf-8?Q?nAGea12N?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW93WjB5UkdlRk5NeWdyY3JWT25Fa0h2RUVOQjZLeXJVRUIvdElQbEFoVFRC?=
 =?utf-8?B?NW00TlBTTEYxWmxtaUhCV0JYUjJyQzlkZEpJbnFNa0VDQkY1TW5YQS8vNkk4?=
 =?utf-8?B?UkpwRDByeGE2YkxiYkFLMVF2VEpqZzdUWWQwTEhQUmxQN3pXM0tzQkFPRXFx?=
 =?utf-8?B?NWVkcVJYSTc2OE55VmdJNThpVVFCMXNPTjNJVm5KUVNvMzd2ZU00UHBXMzV0?=
 =?utf-8?B?QW84SE1VZjd5cm83UjR2MzVEVjFNbTlzZTBRRUNIUnFyc2haemV4bEJvUU1m?=
 =?utf-8?B?SDM4ZGpjcHFWQ0gyWnMwaEROWlRva3k5dVAvT3hYS3dyMzFvTGxoKzIwYmx5?=
 =?utf-8?B?OGJ3dmk2ZTIvVDhGbXQ3NzF1T0hOTHk1MUxtWlZWcHB6WDBtb2I1M24xbmNY?=
 =?utf-8?B?VGpySTBHYklTL3dwWStVVytscEp1cWRtMmpqYkNFSEl3eVVVdFV4R3h1bU9K?=
 =?utf-8?B?dUt4R2V4dVVpVjNKNVZHQzRGOGN2c0JHZkQwZU5kQXhBS2RJNnBzTHJwQ2JP?=
 =?utf-8?B?Y00zZFYwMnNmeG1QYXN4Z1BTem5OOGJ5eFJBRGRXNm1nMHpGR3h2aDZyQkJw?=
 =?utf-8?B?ZjJReko0cVRUaW9ZVUZyMjR6Z0RIV3NJT25nM1h5Y25xckpSTzQzVVIxMzVQ?=
 =?utf-8?B?UGFnb0cxL2xxSFZsR0MxdW5MWlJuVHJiSWNUUUNqU2xUKzloVXFXdGs1d1V1?=
 =?utf-8?B?Sk0xcitQVncwNGh1aGh1UnRXdmp2ZE1qUUZEM0NZdTNtODNYYk1zMkl0SFZ6?=
 =?utf-8?B?aGhKVzh3Wm54SlBaWEpJZHNmT0NEYUZpcXBRd3pCcHNWemRKQnU2VXBNUVdW?=
 =?utf-8?B?b3I0Kyt6cDVLRHJhaG9KdHhTWXI3Zko3NkpHbVVoVG5tZi9FTlphSTZFMFZK?=
 =?utf-8?B?UmN4bFRKV2dpZWt3K2RWY2pjRmhaT3BVdUVKemdNUk1OYjhhTWZCUmd0UVRT?=
 =?utf-8?B?dlV6TUkrVUNoU2lTSHpNMTVWaHZOSGtFVWIxYXEzYUtRSDdJbmYvZDFpVXBq?=
 =?utf-8?B?bjBDUldKWTFtd1JBRFdEelE3cDlZN2hWclk4UFhuVHhRM001dDZBTFBXeWx0?=
 =?utf-8?B?Z3MzRit4YURwNGZLUm1Yb1hZNVhOWm9XYkNLRFJqK3U3bEZ0K1ZxbDA2WWdB?=
 =?utf-8?B?bTZmcjBkL2Y1b09qVXU5MDR2ZGlYU2pjcU5xT2dvdzN4cEdpaEJ2NGtzM29D?=
 =?utf-8?B?Z1hRRzhmeElqbDBQR04rLzBMcnR0U2RHaG9CSFFZcFF6eVBQdjRMS3l1aWJW?=
 =?utf-8?B?THlUbEo2YUR6ZlFVa3NGTVBwNWxkaTJ1b1MzOGZTU3ErNW5NbWFPSUhtekh2?=
 =?utf-8?B?VzNVTkxGOFdwVFpzY3gxMWZsOGFZU0N1eVlBTk0rR2RZbzRCYVkxWFVHRUgy?=
 =?utf-8?B?WldLZzFEZ2x4Zm8xMDl0R21Zb0I4S3dXWWJNMEwxQ0RudU02cE9VaEs5TUNl?=
 =?utf-8?B?WnRhaVIwdHhreHc5dkVaMXBaZFlFblBqRll4R1IwVllFU1dGcFY0YXM4cnVB?=
 =?utf-8?B?K2ZoZy9aTmRrcG5jWUpsZFViNFlBKzFUdmRWUFEyUjZDU1ZKcVVYZTUxVjEr?=
 =?utf-8?B?SWNFK1UxdTR6QTRkVUEzeVdXRW5hdkhRY1Q0R1cxanpJMXF6dWtmcnhzYUl4?=
 =?utf-8?Q?uX/AgmLuiYZ+h0l670779aIHa3v3KVH2qwKZ0be7JiFE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53824ef-ddbd-4e39-c171-08dd058a2197
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:28:19.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3960



On 2024/11/14 5:54, Terry Bowman wrote:
> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's root port. The same needs to be done for
> each of the CXL downstream switch ports and CXL root ports found between
> the endpoint and CXL host bridge.
> 
> Introduce cxl_init_ep_ports_aer() to be called for each port in the
> sub-topology between the endpoint and the CXL host bridge. This function
> will determine if there are CXL downstream switch ports or CXL root ports
> associated with this port. The same check will be added in the future for
> upstream switch ports.
> 
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().
> 
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL downstream switch ports and CXL root ports.
> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is necessary because endpoints under a CXL switch
> may share CXL downstream switch ports or CXL root ports. Ensure the port
> registers are only mapped once.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

[snip]

> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return (pci_pcie_type(pdev) == pcie_type);
> +}
> +
> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (dport) {
> +		struct device *dport_dev = dport->dport_dev;
> +
> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +			cxl_dport_init_ras_reporting(dport);

I think cxl_dport_init_ras_reporting() is needed for both VH case and 
RCH case. My understanding is that dport_dev could not be a DSP nor a RP 
in RCH case.

Ming

> +	}
> +}
> +
>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   				 struct cxl_dport *parent_dport)
>   {
> @@ -62,6 +87,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   
>   		ep = cxl_ep_load(iter, cxlmd);
>   		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);
>   	}
>   
>   	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -166,8 +192,6 @@ static int cxl_mem_probe(struct device *dev)
>   	else
>   		endpoint_parent = &parent_port->dev;
>   
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>   	scoped_guard(device, endpoint_parent) {
>   		if (!endpoint_parent->driver) {
>   			dev_err(dev, "CXL port topology %s not enabled\n",


