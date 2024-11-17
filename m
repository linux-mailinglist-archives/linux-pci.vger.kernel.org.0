Return-Path: <linux-pci+bounces-16997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7D9D025E
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 08:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E311F2233F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA12E403;
	Sun, 17 Nov 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="obZVZz03"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2095.outbound.protection.outlook.com [40.92.91.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790B8831;
	Sun, 17 Nov 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731829530; cv=fail; b=dNvKSI/lsXGv8ZljpavFQ+QtbzhWHmSo7n0MB5gmssEBjW3x5bZ+KpgKrRW8MBGDhoALoR0pN3NiAShJ3COF3K9sSw0ef9gpN3xPCJWLRMctif/W29XPhiNthCGJCtGJx121f4mDve03dyv9+kp36hOruFfbv3ypISl+Am45tIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731829530; c=relaxed/simple;
	bh=EDXi6jpeIQMCGfXABWhh/FV2Dwhrd8YJyjN4sFBBWRM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ulLAqmdgNLI+nMumLiFds+spBGzyYYXscaGhzwKLtP4QKXHhXDvl4IfB9cbefnXIlFugrCBTO6fu7hUXXwPCIJmN28z7KW5N0FeRSvBvt7mbCyLPOVa5ILTArI23peMnJXp8l0tOQfqLpnBj27yAdj5Zr4CMSGHRmnOgyz6Vbuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=obZVZz03; arc=fail smtp.client-ip=40.92.91.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNK5TgMXJv/u6cP8N0ktO3mcv9MFVrJxt7VBibGv2NTCixeL3Lf0nN6VoEmsoN/wstBunKIoL2zWsONBGKjUR1ZI37hElZp0tDiDnBqjk5mgvQ7HYJJAl4zCmgTkdWyG7qIda9I+AYU93HzimoAIJl7eBmnBIpfynioG2xRGvSXWkk85aQlV7J5nsAEvjHu2Et+Bmb5/73pljKp+65cjz4k6Ya2xJ9dgLdcyXnEooOXBEaH9HqtMOvdFfGCZ7rH+IdhnA150oW2hZ03567QSuWQ5qXgkoWDkVWu2y9irSuoZnrCwtq2JKIkzVHyazQSkLD+z4aSsf+WP4f6sEskphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5bKix5U6KSTJpI2WdH2c/dGAvKztqyG3acAMgEgGVM=;
 b=j5Yg8vc7iC+4bJUgdmG6Wfhm6TmxGYKnLBY7kQ87xP84s5HEsrhVFFJIm/VL9oWXfVJVmlD+EbpxnuJyfn/yeOVGVg5AUh1GETHdQqFXW2Ktw2ItPE6zp2JSXNPveXRKSxXFD1lbXKgIg2sK8Y8DZ+o7QhcB2DWe8iNrwqUlO6fHgXJL4uNZO3U0zo3Bab4Mm8K/K7/u4ItNbgclN+v+M1wC763fIZljA/BPsMiZKfDrZbA85N3yo4DGCBZgF/frSMTFgaDJcicpYMkztylcJo9deID5cOO8lOOEjLlSSAyPJFQEvdFyv+JnIExt7UGhKZh7z98LPBTotX2I5jDLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5bKix5U6KSTJpI2WdH2c/dGAvKztqyG3acAMgEgGVM=;
 b=obZVZz03OP4xbjd/MYXQX38AxWYNtX9ebPBWjNIFZpQNskNYjoQWd7rvAnRyx8qS/m1iZ+TMxoaeUk2WXdG5snmLeNiRlIUPipO2UNMElFAeL6OVg3ZLAeL3apcoqK7sv3P8PttNFv9h32BYgSpvkoXuPTw8xktxo80qEtXofcocIDr03+KCs+y+hu4co+p0N/MW6bXqjphmS1cR3y0Y4X3N9MbhLa8s9eI10aUmxiYYIe3985USshIKuh9J0SsBrrXUIVTNTISfJogZ/xoholT5NxpGWXn1Fo/7J6uzBekwoy5aDE4BC4fnGXv1LOtrEnE3V+f5X2cUsTzYP+E2cA==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by GV1PR10MB6417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Sun, 17 Nov
 2024 07:45:23 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.004; Sun, 17 Nov 2024
 07:45:23 +0000
Message-ID:
 <VI1PR10MB201647BD9FC20C8BAB8F4A90CE262@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Sun, 17 Nov 2024 15:45:15 +0800
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
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <63e04e2c-e302-49c9-bae7-cd39b2dcea26@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|GV1PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 238285fc-7dbf-49ed-b364-08dd06dbcaf0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|36102599003|15080799006|5072599009|19110799003|461199028|6090799003|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFCSTVxL1BrWFFOSWtaZ3JUMmpraGw5amlFNFMyM2dFQmFxaXBiYlRibmIr?=
 =?utf-8?B?cUkxSm5LMHJmMlpLQTNtV3dXSXUxS3pibWJ3Uzd4WDV2ZXNVbVpkcy8wTkxj?=
 =?utf-8?B?QktaYzNmUEZJYmtIK2hjVWNjRkpaRzViSHdueEJPdXlkTVJjS1A2Y3ZLWDZw?=
 =?utf-8?B?dTVqNUxEeGE1V3JNTmJWcnl6U3QyelRpS2xLVDdXRm9XTzE1QkZkV2ZHTzQz?=
 =?utf-8?B?WEttQkFMMmdZcGVGUE9VTnR4cjJTWkNlc0FVSWhTRys4cjJWQXNlZDloVkQw?=
 =?utf-8?B?ell6THI3MGZWeTNrVEE2Nm1kNnZDUnA4UVlFQU93bTZ6TzBOUmxlV0sxd2dQ?=
 =?utf-8?B?SU1EVkJQV09CVUlZeVl6emFlaEdtb1VDM1p2aC9rT1N4K08ySXcxYVVKTFIy?=
 =?utf-8?B?dEFFaktpZ2QzY0ZMTzdpdS8rV2t4S2w5bFVxNVRtamJYN1lVbXVqYllTSFNY?=
 =?utf-8?B?WmwvY1FuVmE2V21EYlBjOXdtWGVyWmFoRHgxaW8rN2ljRnNNQ3lXdjZxbC9m?=
 =?utf-8?B?enB2VTVjS3dXWUVwMGZwVlBEOE1Kd3dHZVJKRVAxQmJmYkVwaUs2a1NxNFly?=
 =?utf-8?B?L04wL1JzMFE1ZXdScjdNY3ZXWXFFUFI5SlNMWk13bGwrRFVvNTZsTDEzQXQ5?=
 =?utf-8?B?RkpZMERvR3RmMW1uSXBMWXNQTWdydTZjVmVCanhGRm1FMW8vTHpDVFlOQStK?=
 =?utf-8?B?VU8yalVHbkZ4ZlJwcmVibjVkR01OYkM0V3ZLaGlwMVR1eXZOUys0RVdPWGxQ?=
 =?utf-8?B?RGRlTHVNb1FPaDJSUG90N1RzMy9YMmN5VzJ2dzlrSlBzRUhDOFNhWnhHREo0?=
 =?utf-8?B?OWNkUTE3TmNack1GM0R0ek0zMFVPT1ZBMHJkVXpDTG5ER01EUm54cEJxQUFu?=
 =?utf-8?B?OUlLVEZ3Vy9TclB6NzEyNk1KOWYwL1oxRFFCTnBFTzU3RE1peEI4YmpCeDNk?=
 =?utf-8?B?bVd5NU1Pd2d1QTBUNnpXMy80TFdhRXN3QU9uYkpycFA0SmZUdkRycTZtZmpN?=
 =?utf-8?B?VEtWRWExZ3ZzenZLeThpaFpVMjVOaXliZzhSOG1vVkJhL0dFOERDd29QSDVw?=
 =?utf-8?B?ZDlPK0pMYzNKV2RGVS9SOGNxa0twQlNGOEE3dWU5ZGFYdEtTcStncE9KTXhV?=
 =?utf-8?B?eHdEdXgwRkljVDU5TGFqdFBoaEZxZm0wSy9wcWFXTGdlU0hNL3FsdW1FaHJI?=
 =?utf-8?B?enZDUVRpa3BkS0w5N2JyYUhBdGhDUG1NNEtYaDVBR2xVcUdYdWs2ajFNMFFq?=
 =?utf-8?B?SXRZQ1RoKzVWZFdCZ1NhSjJSVjZwTlhmekVpelJFN3NFYUo1cUtpUkEwak1C?=
 =?utf-8?B?OS94S3pSa2Z3aUpjTGN0dlNOZUZhNE9Ec1dLSC90NXdGS2JuL1M2dDR3TGMv?=
 =?utf-8?B?SHF6dDc4eUFIYmJaNlpFdDBiM05OQ2tuSDRqNWpHTmFpcEFuOThTbjZQZGVB?=
 =?utf-8?Q?fBaYoTrI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJXL1Q2MnNmZ2dZa1dOSFdUM2h4SGk2dkdQSCtuenJXWkhPd1JOd3VEZlZZ?=
 =?utf-8?B?QytJcEZVaVJMNi9tRzNNakJOeWwwZkRvTUxaY29oVnMydDQrdWlpbENyb0hJ?=
 =?utf-8?B?dklhaFF2WER4QTAwOWZMWEMwdHYvNDZ1ZkgvT3gxMjRKY3dya2V0S0dIbGth?=
 =?utf-8?B?T3k4Z1B4MC8wUCt4WGJBMUNhQmcyUzdnYXUwUi8wWlczYzgyR2RZZ29xUC9n?=
 =?utf-8?B?YjJ5QVRhOTNmREJBaXJZUGEzOENoZGIzaEt5d2pMQU5mZVlxTHhrTGtjVDF3?=
 =?utf-8?B?ZUlleVRsbEIxd2piVlhpZ2ltNndGZk0wRHptQjNxL3ZXaTJIMHVyUkUxczh3?=
 =?utf-8?B?NmNFYTJFOUlSbjJMRzVGZjNoZWdJeXQ0UzZFMkRocjJvNTVWWTVTYnA3aHdE?=
 =?utf-8?B?SVBHZEFJWHgrZW1yVEZmTWJQZTRac0pTYlNMTHdpOEtHbjJCZ1dWUjVhbnRa?=
 =?utf-8?B?ejNHdDlZdXV1UGkwU05MdWVqS1hEQ3l3M1hheVozamJkdHlkQjZSQ0lIMlcy?=
 =?utf-8?B?NzZVa2hHSnFoUDZNa3JZRWlTblhNYWxXa25mTWh3OS9yV3dKdGdORlBWVlhU?=
 =?utf-8?B?QVd4UWQvUkJVU2FKbDFkcGRRSTZTaG1RQmdHVFhTR2g4OVRCR2szeEp3WVpj?=
 =?utf-8?B?SkdiWnp2bHhuWWpPLzhCK09PRkVrSk1OeG1XdFVYS1kxRXM4U3hQd21FUWQ3?=
 =?utf-8?B?OFFzS1JmcndPYitmQWhjZjFUcUZiNzFKdFNJWG90YXNySjlsYXBwQ0RFRFBv?=
 =?utf-8?B?eXEvSlhiMGpIdmlpZFJBbDYwZTJBWEVaKzBJbkcxS1ZZZWlCdkVKYlhoUEhz?=
 =?utf-8?B?c1dyVUxNWGY4NXloOEdJdThheDR1WVhvM2lWdE1wekx0UnJuelM5bG0xOEkz?=
 =?utf-8?B?d2NMalFoTjE4MmJ3MWpWY1luM2FFVmI1R0RSVmtCS3dibzBMMy9JQTh3bWJR?=
 =?utf-8?B?MWVwVFFNQ2xTelZhbkEwcnEyVmx2aGRsTkNNVWNNMCtZd3FORnMrVGMrSmhU?=
 =?utf-8?B?b0JWcTFpMVdiUDhVZDVuQmZMMzRjb3lDODZmd3I0Nmw0YWZSR3pKU0NPRy9h?=
 =?utf-8?B?U3J2SytObTB1ZUdTVGpHdHl4dGxXSFJienpnQ21UNm13TStGR2RZS21rNDFz?=
 =?utf-8?B?VjhqYkNWQlVCMHA2SnY2TTlLcWtTcVhGMVBQTXdWeDVoSWtqckxLYUhmTG92?=
 =?utf-8?B?ZW5OcEpBVzF0NHhkbkkxclZ2dlk1QmdhWjdpS3lEVDJxaDJkWFN4Ym84TmJt?=
 =?utf-8?B?OGJxZ0pWK2ZaUkhscmZSL1NFWWlBSHZHV0QzV3M5Q21RTHVVZis2dDVVZTVD?=
 =?utf-8?B?OVFYVUpSR2pvOGRkNzdnV1ZJT0ppTUJDWDRiTHhQR25yKzZRYnRNMkhrMFBu?=
 =?utf-8?B?V3BSemtBMHZMU1ptQnMwRzVsRnRLWU44ckZHY2ppZzBET282NVFrL3R4MGdD?=
 =?utf-8?B?Wnh4Ry8xY2lxYUpBZG15L1J1UWMzcDBLV05qZ0JiNmtETDVVb0dKckJQb2Nq?=
 =?utf-8?B?NUFTUUc1L0FZYjR4R2M0S0hmS0M0MklyNWZuWlU1WU5CYStWU21udHU3bnk1?=
 =?utf-8?B?MHova0U3NnJMYWxLV1pwN3B0Rmg4Q2JzaXNZczM0YngxOWJOdmdRQm9jSG1T?=
 =?utf-8?Q?AHgCG2l9J0Jnr/rqLysM9oAlYlKtiHgQhPga4JNuRVr0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238285fc-7dbf-49ed-b364-08dd06dbcaf0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 07:45:23.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6417



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

>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   				 struct cxl_dport *parent_dport)
>   {
> @@ -62,6 +87,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   
>   		ep = cxl_ep_load(iter, cxlmd);
>   		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);

In RCH case, seems like another issue is here, I believe that a RCD will 
be added to a CXL root directly rather than a CXL host bridge, it means 
that no chance to call cxl_init_ep_ports_aer() for a RCD, because this 
loop is only for a EP attaching to a CXL non-root port.

Please correct me if I'm wrong.

Ming

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


