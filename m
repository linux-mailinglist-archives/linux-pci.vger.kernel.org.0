Return-Path: <linux-pci+bounces-14413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120399BFFA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342261C22C64
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 06:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB922318;
	Mon, 14 Oct 2024 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ddE7Dsa1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4713B5B3
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887053; cv=fail; b=mRO3YqRzOuVSzW+fHBlSMATiHV0y3ZPjiCth8Xk2koWHNm2FADo7zHlzWy3B0MqRQB05230QGr8WzvjE0hqr/wgBmw5Tl0jPjFWekXqXfJSbTxlk7eFzHMHApPye92yz5i1rH3a/ytRd3dRMg5jlQcfPgaCi+6TZo7LMMVtAxOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887053; c=relaxed/simple;
	bh=62do1EF5JjXM3YXuIgj8W+iO/ieox9OSZ6Kmb5JCq0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYStUe2vD/2aSA/oSuffQ1zkknM/quckKZE/oM1kd/ApMHekxUgd3PxREiRQ0y4Xp/0OXJxQtjQJ61GmKg5dsdSt160KXdwP6dtsrD371UmqgCeiBMJhSJJrteOdJiIpPAg66IsL+CkwmlxtxV9yUt2Fgbk8MsYi5yPMd3rEb6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ddE7Dsa1; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFC5RhUfqnpZmjIX/rsN3YnaNbba8RLk+OX0wquWx28qpnDI6A29r3Rq7GYpmWUiYrOS1GuS/MudtIrTELh3EB8dV7niWlxpmGsvKNOzb1grguUs7xlv1bQ7viBQpytY0rvIBzV8oHzBcu0VaFDvLS61nDy/UsalNJZVpdpmeuLfiuuSsX1/4MmKJDhfN7VuQ82aLdmT9RBckb1l3p7mBTKVaBV4w9z/aiQkf8ISv/bEgcKPvm6Er+DCkgtjxsSrlf+cxiJBOhWXaf/9Ry31JztnWHNW22XafSn2pHQOteVQCI8ExJCORes0L7/7s23u+ZSf33NZoota3OHkEyW+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62do1EF5JjXM3YXuIgj8W+iO/ieox9OSZ6Kmb5JCq0c=;
 b=XIhm/bIHmsFu1RJCvLSeEIV+dQ9xohFv3qQMgEbdJd3NLajYBY1fFhvw8Vv7qkMggwm+jBTJ3zHHPO/nx8AqtDdm2ZFwASY9gV6gyMqDfZGUAoaiVC9pBjJMc6mhX3atT9QUKiFdrMrrMoq+tit5jSW8HwFGLTCCQn+SZLurLtBuPQPpXDQGSUc14Ov1PuLiR+fktUo0pmgqN4X42YNS/riKdF14z0A4XLR8R4xucd7gEKQ8Egs3/lLWTsWhuJYmD6l8sgzg8mKB8exom/gYkYzSXruuVy/iv2ZpyjpzUupCgnmblZ6q5oNtwRAnR9NclxxPmnuxttLQFmMyLhrE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62do1EF5JjXM3YXuIgj8W+iO/ieox9OSZ6Kmb5JCq0c=;
 b=ddE7Dsa1nCbejT6KjA5NVWndbr5keCaLXwnZYOcROe7ZNsE+4+HtHRDlfO2aGKuzTYYAiNxKCzE/2+ye977eXEkNr7GlR2FQFfhfd4CFuzyVBZXvNxLhqDgE2dbLL38i8+GB90jAbRNDRc0cZ+66YifaVIJAM9eXD7kRtqi+JExQ1iDylkmlnJPwgF4DmaTwQRt6X+ByI+RwvJWqQfxjePjg+vhX7NZFnQYBhRHyEfidRKDkySnj1/68WFSJ8iMq8DAhbkbT/h9qu3DmALg49umDKC5tctA7AiVvXpNj0Rxb37dMG8OsF+V1qKCWtR2zF0Olzxq8pgm/x7tEJGkQZw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 06:24:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:24:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Rick Wertenbroek <rick.wertenbroek@gmail.com>, Niklas Cassel
	<cassel@kernel.org>
Subject: Re: [PATCH v2 1/5] nvmet: rename and move nvmet_get_log_page_len()
Thread-Topic: [PATCH v2 1/5] nvmet: rename and move nvmet_get_log_page_len()
Thread-Index: AQHbG9mAKklXIF9VgE2bMZf0gnIvkrKFy6WA
Date: Mon, 14 Oct 2024 06:24:08 +0000
Message-ID: <189df742-3b0c-4116-bb68-cbe89b848362@nvidia.com>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-2-dlemoal@kernel.org>
In-Reply-To: <20241011121951.90019-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 2a080682-0461-4fc5-0e80-08dcec18cf9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzBGZTk5ajF3ZlpQRSs3a1ViTkFOYnpSNUJER1lOenZqVitENFE2MTY3R052?=
 =?utf-8?B?bGZUaVkzb0xXRTBWNjl4Y3FMM2M3NDBiUDNLMHJnRUdKcXRiQ2MvTVJIK0dT?=
 =?utf-8?B?TmRzQ1Fjbm0yT3JXb0lNenF6cXZoOGljZGhUN0VXdHY3MktZTTdmOGRtSTlm?=
 =?utf-8?B?UE0yYS9wRVJpR0NzWE5YaSszNHpieTJlcktXNUpONkdXZDJUc01uNS9jbStv?=
 =?utf-8?B?enE5TEdrdkhQM2VpNkxpTGMyWEVhcXdKajh0aFRiYnJ0bDgrTlYvMnMrK2Vs?=
 =?utf-8?B?eURYT3hZTDBmeVd2WVpjSG9zTlNUVEZwRW0xbWNxMmtYZ2ZXVFROSm9BOC9s?=
 =?utf-8?B?VTVDQjFabXB1VVRpQkZ5TUI1c29BNDllWU8rVnJacFpJcmxHQkk0WVdkOGpI?=
 =?utf-8?B?R2lBb0piRW1qbnZTWmhtUmh4bFdpS0FaZ1AxT1VlR0g4MEFkM3VtY3dSckdp?=
 =?utf-8?B?RGdOdEhua3NWUGdyaHdCZU9ZMmNzbjJ6Q0lINlVCeEhvSXdsUU5OakRPM1ZK?=
 =?utf-8?B?Mit6cFRYT2dpL3o3T1pmajJqWC8zK09ZVTNpRFNNR3d4STRha0VHbTI2S241?=
 =?utf-8?B?NEJCVXBmbDM0N0ZNSFIydDNrcGRLYUl3OGFYY0Zxd2NSTVIxeDkzUUI1R3dJ?=
 =?utf-8?B?M2ZPVVRzdFZsRjA1emttaDUwUm1CV2xNeUp3d3ltNEQ0c0dBbnRIU0tYTklx?=
 =?utf-8?B?RE1heFBUMXJzWG8xVjFjcUJmdnByZy81Q0FWVzhncG91dmxRSnVodnNIZndP?=
 =?utf-8?B?MUNVNFdBUDl2SFYrTWJYc3Z6VEN6aU9XOE5YZlNncThCcEM3bmxrQk1BWjl0?=
 =?utf-8?B?djZDc2hhWDIreHlJc2szaVNCck1PMVY4anhpRFI1OVo3VTdQbUh0aFlZOGpk?=
 =?utf-8?B?Q2hiTi9wTFFJQXZScUtCRFl5cG1pdTlJM0dnaXVqVjltS3VOTVBpUGRaamY0?=
 =?utf-8?B?cEhERHV0ZHA0VWRBVVNhV0hHaFNYRWJQQ1gyaml2MDJIM1pxWC9iY0RTVTdj?=
 =?utf-8?B?bVVWNGpEVkhYVUhtdjRXcGdnNW84cHRMNDFiYm13eUZPakNmaEdhOXBhMmxm?=
 =?utf-8?B?aFFIZHhpY0lINEpZb25STWJTM1g1SGdIbzArVlJJa2UyS0tGcnpSM0VHOFVp?=
 =?utf-8?B?ZHBmbmx2SUdWazlIQ3J2NjVzSjZCaXo0UlY4UnpVZWtxa3pQYkxML05pRjBk?=
 =?utf-8?B?RU9oU0l2Z0NwTWtJOUNZSmswUml5Z0dNL2thaElSY0R1ZDdLSjJNcXN2VUNW?=
 =?utf-8?B?bC8zSWd5T0hMSUI4WFJFVm91bDg0TXJZV2tSSDRjd0VqQUc5ZzN1dWwxSDhU?=
 =?utf-8?B?V2FwRUU3a2VPMjJYZTQ0bGlUMzIxZmhVUUtobGl6TjJrbFhxT0RnMTFHbFl2?=
 =?utf-8?B?UzB5VXJUSU9aalZ5aDZtWHRrSkw2dXh2VjVDUFM4dUhoWkU3Tko1ZHRlUjhJ?=
 =?utf-8?B?Vll4Si9UOUtxUW9CQmZTdkVteDNQYjQvMlo3d1h3NEQ2SlNNWFh1MC9heVNF?=
 =?utf-8?B?SUh2M0VDOWsyeFRnWEdrU1l2ak1uczRPS2xoMjVkNGdFS01hMFlzSG5ZN1JF?=
 =?utf-8?B?M2ZWWjZmQktPck4vbmxGWks0QXFsRHNnWnZNUlkzZWdPNnloQldzQkJLTXF3?=
 =?utf-8?B?TWl5Y1lzcWRvUnlKQVdyd0R2WmNZbHBoZkdJTjZ0SW1PS21ncUpRc3g5UkUr?=
 =?utf-8?B?eEtBOHN1RjQ5M09oeEd4dlF0SEVkL1JFY1crMVZiTlR4UitKVzFaZTRVbDV6?=
 =?utf-8?B?SCsvZHlaREJmVjZDM0FLUWdDa0VaTDNWT2t1a3NiR0lDTmVjWlJwQWVxTVB1?=
 =?utf-8?Q?iI6xGlkr8qVrdtAzRkQNDpUEzEWpxZzHhtN5M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3IvcGhqRzhBa0NXdVRwTndnSFMvMlUrOWxqRUxsUHlOWjZ6N2hhMHcxK245?=
 =?utf-8?B?SEFNTlNjQ1FyOXgxelFhVk4ya0NFREM4S3ZPZk51UWdQY1hpMk5MamQrUXVo?=
 =?utf-8?B?dWxuUlZvaEg0UjFwa0IrR0FSQnUxSnJ5YmNJejFueGIrOXhEUFZWYUZ0V1Vk?=
 =?utf-8?B?dkplL0IzVldqOG9PTEZkeCtWeXZLbVpBOVVqL2dTWkU5QThYOE1GTHRBN01k?=
 =?utf-8?B?N1Nrd1dwUFhBQ2daTWY4aXBRUDNWb283cFVoTSthOGlvV2dnK1hHWWxZcm5v?=
 =?utf-8?B?eGNlNWNPVEdpTGdWaFQyTlQ1aVFNbVU0MlNWY1hab2NVK0FGZVZ5dU0wbkZH?=
 =?utf-8?B?MXU4dVZzOWNhekduTC9COWNydjJQSW5oSFlqQ2k0UHF2NkZNTWhFVlRoQ3Fu?=
 =?utf-8?B?bkxXQVNHekcvSE1FTkFNQ0sxSTFZaXkwM0FGS3ErZzNqY3JnY1ZGYUxNVTJD?=
 =?utf-8?B?RzJsWmRBQ1FJZ0pqeVFKKzJqK003ejNSbnVwOFFwZzRaUDhqZjcyYnpJZ0xW?=
 =?utf-8?B?V25ZV0pPSDRoZmc3d04rRS9rLzFjdGNiUUJ2T1lBNVFFVTJZTmlPTjI2M21m?=
 =?utf-8?B?WFZGeG9YaEg4VzRQVFV5amhSenVLRWZlZm1pVkJ2bkdlWE5TZHdpaW13bFdH?=
 =?utf-8?B?eWV5S01TRVVCOUZ0NkdUT3FIZnhGQjVuMnZiR1UrNGZKTDhUU3ZDT0NMd2ly?=
 =?utf-8?B?cDYwY09qMjdDMHpYYW5lU2EzaFZlVUhUVURtckV0YUY2aHArdTRSU1B6cEtB?=
 =?utf-8?B?eXdJOC8yUmxPcVFRSkhsZW1PR28walMxUStueWN2MWtXY2gxWTZ3OFdoc0JU?=
 =?utf-8?B?Mk9uZzJZRXpLZUo4RWp6SU9LcWdDbTB6T2JPVzRZd0k2dE9ZdHRyVkZ2V0hC?=
 =?utf-8?B?VllOaHl5ZGd0U2JlZEJXcTRjVjNwUjQ0VXVUak4xYm1NZGg3bnd3OWFnMlJF?=
 =?utf-8?B?N3g3UldscmJhZ2FtYjZCOXNLOGxNZ2tzTWs4SzRIVUlISFY1bUc3RERPZ3NB?=
 =?utf-8?B?dVdhNEZ5NFI5NjltVnJ2ZkZ4dE5pMDhpSE9FSnNNZCsxckhJajlvSG8wRWds?=
 =?utf-8?B?MzF5OXBIZ0gxSXFQSERJMGVEZ1IwV3lhL3JKREU2dnVTaS9OVE1mR0JCeDlZ?=
 =?utf-8?B?aUh4OUN5TWFuSmVBeXg5bkU2a3VoQWswdHJGUG1rdGpaYlIrY0lQNDFlR3V6?=
 =?utf-8?B?TURTZDIreTFQWTI1ZEdXRHFnVDZKSTU0VXVnOVl1dmpFS0Q5L2pQdTFIWlBQ?=
 =?utf-8?B?U0hWSmNkV0lrSHdPeGFzbkNWZ1FvSmxoUFBDY0wwelI2dS8xNXVJeTdlUjlV?=
 =?utf-8?B?dklvdVNqY2hRKythZm5XNEc0QUp1UzZsUitCMWt6anlNMHVYaGVVbUU1MkJo?=
 =?utf-8?B?SHlDSG8zT0g1UDBhbjJia2t4OU92OCtMS0J1UHdFVXUxUi9uRW9WYTBrYWNm?=
 =?utf-8?B?NjdSbUxCb1BQdElMbkwrUEJuMVRMcE9lbmQzVXQ4WTJFRmRoeVVrTWI5WWpP?=
 =?utf-8?B?TytLNWxvVkJJK3pJTXQvalkrNHlzM1hJbVI3K2tvdlZBN1Z0cmdVbGg2K3NV?=
 =?utf-8?B?Q2NBdUNTajlEaDQ2d1VsMFBzL0RFTkdNYlY2NXFrK09WS1VzWmt2aW5YR0h3?=
 =?utf-8?B?SzYxZTVPUzZhVjVyU01yWlhRc1JGUDJtMU5kT1VmYk1GTGZpODAweHk4cmwx?=
 =?utf-8?B?VjhwOFVsRXBtbzRIOU4wb1FSclBCOHArakdWNFFKN0FiSlZwcThGRjBPSjNM?=
 =?utf-8?B?WDd5UXNBeXZqVHZETVlvK1BlTUgxMXViN1BKREsyUjBZalFPdzgyQnFWZ0pE?=
 =?utf-8?B?Z2lHdnRlKytXWjZkNkYvZzBzbmRoT2N0eXcvZXY4QzNUcE04NGJrVUNxc1ZS?=
 =?utf-8?B?VjVuelJWUjJHUFMwTHBIbHNLd1lsME9kS2MvRjhMWHlKRjduMVllR00reXBP?=
 =?utf-8?B?d3owMVJMaGxJak1SYlRnZE83ZTVRTmZUaHJqR05TRlB6Njg0VXkyaHdGWVhs?=
 =?utf-8?B?dkR0dzZIbnByQ1JwTmpMdEFpUVl2R1d2Y1pybUJRMDNpaUVLQ2V4TXdYdmdy?=
 =?utf-8?B?YkdjQkpjamRLV0dOQmhZb3pMQUhDRTcxOUhRTkZoMkpPTGNrUVo5MmErQW1j?=
 =?utf-8?B?M2JWK2VEVEFkRzJ1QnpoTWMwczFwTGNKRnRBSEZEV0dQODlmTTUvWllNQ1hC?=
 =?utf-8?Q?lP10twHgc9Rw4n3ZMxpBefXn5OTd+taiTgBLlyINDcKa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33503184CAE912439B1106424F5C9B65@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a080682-0461-4fc5-0e80-08dcec18cf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:24:08.5877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rHHU7no309pKT3LsZTu5er326XRDV0ix7RjKYetHoYSgBOO79wl5V8WcXKislFfOUZ4QN/0EiemdIab1aaz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

T24gMTAvMTEvMjQgMDU6MTksIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBUaGUgY29kZSBmb3Ig
bnZtZXRfZ2V0X2xvZ19wYWdlX2xlbigpIGhhcyBubyBwZWRlbmRlbmN5IG9uIG52bWUgdGFyZ2V0
DQo+IGNvZGUgYW5kIG9ubHkgZGVwZW5kcyBvbiBzdHJ1Y3QgbnZtZV9jb21tYW5kLiBNb3ZlIHRo
aXMgaGVscGVyIGZ1bmN0aW9uDQo+IG91dCBvZiBkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNt
ZC5jIGFuZCBpbmxpbmUgaXQgYXMgcGFydCBvZiB0aGUNCj4gZ2VuZXJpYyBkZWZpbml0aW9ucyBp
biBpbmNsdWRlL2xpbnV4L252bWUuaC4gQXBwbHkgdGhlIHNhbWUgbW9kaWZpY2F0aW9uDQo+IHRv
IG52bWV0X2dldF9sb2dfcGFnZV9vZmZzZXQoKS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVu
IExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWc8aGNoQGxzdC5kZT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

