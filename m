Return-Path: <linux-pci+bounces-16378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784C9C30F3
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 06:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7378BB21221
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 05:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3A145A09;
	Sun, 10 Nov 2024 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PY7iZXOU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43637347B4;
	Sun, 10 Nov 2024 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731216068; cv=fail; b=Y9dYJuOcv0aYRDxJfopnUpG3zMQ1kehOfk6LEh4piWbVEMLmFsscI3OHCXGq5/PdMglyYtA9jiT9/YiTeh+BRkqzZJQx/47RUGLeJWnEGiS2Wi5SNIGmWgyaoMmgiUU0L+MK70hoMTLLp3t5I2rjmaraQOsrLGxgRKOqmgQ7hw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731216068; c=relaxed/simple;
	bh=tXT0qrxncZGDm7cQkZ4woYO5vLfmm8xZkcovLJT0e+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P40oYz1WLc5rMEnUE/hy+AM7Ha0fvn3fi+n+MBwn9kTIozD4q9o4aVKUx5nLUSfdq6vCK3ex4Di35M38kP+rVa6U8h9WK1UGBssSTxJFPTJSW3XhRuIOfLedcoK7TPAWUyEgACbIJzP2jmA9ipt70gvLW9FJZpAhnX+4Td1vb5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PY7iZXOU; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA5JAYM032439;
	Sat, 9 Nov 2024 21:20:32 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42t5yq12dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Nov 2024 21:20:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYpQCzOM+LT1uXwv1H36P3LG9Vf0XM2YdzHi5ubE3hY5VmvQ16GO0VCKSriBSnItZ+iWmReEVJfXe1WUjharb+qPlRWeF/MZIdRdmI4Y25hqIK6Bz8EUDAAsd4b1PI/5xV59iEaDq5iEr//QOD+wr2lt1WneD5wCrW0VJFSdIC6HC6QXrhoVdVd0fdzv1qEDj2vdy1BLr2ioTgMfSlXRfqe5LEQa5y52Qn0u0D1BSM6k3afbLZZPpQ+Vbtkdf5ZzXJTkrYjhmDPghd6hfPbiBRrpEw/ZwW7hiBA4Ym188KCkM3cwpi1plR/9S3XFLWvqO0kVpyvS6d0At3bWI5XoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXT0qrxncZGDm7cQkZ4woYO5vLfmm8xZkcovLJT0e+8=;
 b=UHb+XK40piSHz7czO8g901BL/1SO1ba5+AJs0qP15DoXIf8DmMEEIdxeK4ahrWi1QUSQEpwXq3C6Tixo4XVOJKg3ivZx3sGYc80qpWAm+O81463iU+f+HqkL7MGNnzuK0Sofx9XdFfE8TJXs6qOolmyqb+HTIEzkcrc9AT1w33GhaVU5TAqz7J4X2KiKIoQg5xzJ5liO/gBmZxjtvvui/lKe+uX/IilUnO9e9lUQY7UvMwL0AmBsstDv5z6U/ABEOp1BdYu0hauISW1N6X27V0cEK3iF9wI6U8JV1Kh90nxq9+Jid25AiZ+KlCH8QZlvYKWtQ5pWfkHHYnZNqrtk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXT0qrxncZGDm7cQkZ4woYO5vLfmm8xZkcovLJT0e+8=;
 b=PY7iZXOU5aBEkElZgB8A6TL/UqgNjAQVT/xlo5oo5UBGZRKadzUQlu26WZ/iZp02+aQWPGyTbYOf2qj+6MxAMoRgrd1HtBQaF9ixpJLaPomZzk2QhUiPlNbcJgFN4mubBqZ8H4AGAiExxv167YDmlkDC6Hsx7rBNShbLvgK9kXo=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SA1PR18MB4598.namprd18.prod.outlook.com (2603:10b6:806:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 05:20:28 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 05:20:27 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHbMzBAIWgZBNjHOUu0h+t9d51hKw==
Date: Sun, 10 Nov 2024 05:20:27 +0000
Message-ID:
 <PH0PR18MB4425C42B8FA68D9A75B98547D95F2@PH0PR18MB4425.namprd18.prod.outlook.com>
References:
 <SJ0PR18MB44293B3E1A4860D44DD5CD8FD95D2@SJ0PR18MB4429.namprd18.prod.outlook.com>
 <20241108123908.GA1657702@bhelgaas>
In-Reply-To: <20241108123908.GA1657702@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SA1PR18MB4598:EE_
x-ms-office365-filtering-correlation-id: a64ddd9a-9b3e-4ec5-3a25-08dd01476335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzhjUnR0a2RUN05qbFQ5aHZlZUtFZ1JWZTBjeUlGcmx2anBKZDRXa21TUjJI?=
 =?utf-8?B?WHZhbVpXN3FlSDN1Z0oxVWNxMCtRektjUDdPdjNjaWh5V2d5cTJCYloxZGlW?=
 =?utf-8?B?OS9oQUZVVzFDTUdidWx3RXp2bTRhbFc2ZmZlcjd3YjhldlJGekF5UkdQMDdZ?=
 =?utf-8?B?WVkvdmVDZ2ZVMktGUitqQXNDR3dNWWFkUDRwR3QvdVBueUhMdmhZWmdyS2R6?=
 =?utf-8?B?Y1hod1luQVUzcGU1VXgvdW9QSE1LTFFKeWxDTm1HSHZqNHF2ZkNmVzIxdFI5?=
 =?utf-8?B?YnlJTjFJa3grQ1hqSkdkQTAyeTVKSU1uWnpZeFRCVFVLRzRpWTdRTUtDQ3I5?=
 =?utf-8?B?Y2F4T1hvMW83Vm5qOXVJQktRVDMzbC94SVh4Qys5ck0vcVoyNVI4OWU4bmdF?=
 =?utf-8?B?Nzd4eUN6YzNMaDdiVEI0QjgyUkVRVjYvN0JJZ3VEcENNY0RGWmpQb2ZCYzF6?=
 =?utf-8?B?UGliUVZXbmRSbmY1Mkd2R2lwK0ZXUTE0MXZkMTJLZ2ZkM0VIWHFQalpQL00x?=
 =?utf-8?B?ZHZGSjNpMFdjbUp3YUplanA5RG1JcFMweGQyVm93OE1xQjNLL0dIOHc1b3pN?=
 =?utf-8?B?a1FkakorV1JidnRiaXBZZG9uSlFWSUViYzQxcTh0NEJZY1o3MFRMdk5rNENZ?=
 =?utf-8?B?Z3pwaGJzUERzN3RRdU1zRksrTmNVRUZSdUZCYnRVS3QvbVppTC9vRnhhdXp0?=
 =?utf-8?B?NUxkQXdzUG9wWVBvTWlaclhpaDNqV09uSHVrTWZLMTlNNXlERHZqQzAzNkNp?=
 =?utf-8?B?MElRdnFBR2tJVTZNUjd3L2czNGNnNGlZcTlTOFNtQ01vNjRZcWZxOGFCcUti?=
 =?utf-8?B?NXZ6ZzIxOWNBZjBWWDBhQUZ2ODRMcStMaHlxVDYzcFp2K2RZY0N4TEFybXJV?=
 =?utf-8?B?a3NZSzNPOUpZdDBadnlMb1VwKzY1RHA4eFp5azJaYWdVaFBMdHFtWTRxWkN0?=
 =?utf-8?B?dVhSek1Bazh3UXNWeHFGbUdFdHdDamE0UnVVV2Y4dDViYnNUaXZyb01YQlFi?=
 =?utf-8?B?M1FrckIvQ2Ryb05udGY1OS9wNkEzNHpFbkdjVTZ3c0V5U2VtekxJMHhGdzJv?=
 =?utf-8?B?ZHVDS0NFMU10MFo4YUk2YTM3cGxhaHZHRzRjMElKU3dCeWlKQTYzODNKMWVT?=
 =?utf-8?B?NmNyWWc5Z1E4dXgzMHZEL3R5c21FOHFCNnVReGhKUjd0b1pqdFpHNURuZUFR?=
 =?utf-8?B?VHFQRVF5K2pKbXMvNnJYc3MxenBCRTNORmhnaUlJMThDL2NJVWIxQmtKanFV?=
 =?utf-8?B?Wml5aERKRXBjRnN1SHE2cDF4N1JGMTVwL2pRaWJldU9IWkQ5MzJHaHRwS1Iz?=
 =?utf-8?B?MXR2dDc1SVdjd3pGc3JNd29IVkhKNzhIQS9VS2dRdStNNVNTRFc3SnpUMmlx?=
 =?utf-8?B?N3BxOWRLOFEydSs4cHZBZXlaTnp1eExPM0tVSndMaXM4WHQyRHVzZXhxNHJX?=
 =?utf-8?B?NHBmTTVMTFd6aERmQ2RLRGp6d3IzcngzTnVqajdRVUZFbGw5Vi81MVl0Ti9V?=
 =?utf-8?B?cDczOHIxeGRiNERyL2hNd0hTNWVKQUcvVzFZYk1UcWhGTzZYVEwwZ3c3bXhs?=
 =?utf-8?B?RHdZbzN3eCtiQXFhWExvVEJPVlpFbTNRcG9IWUpyU3h6NzRyUHdpMzIwczdK?=
 =?utf-8?B?d3BCOTI4ZGZ2dDh5VzhUVU16REpOWmpacTlYeWdVZUFkY0ZFdjd0TVVzVWRT?=
 =?utf-8?B?R0FZVk83RVp3T1hkendDM28zenh2YkRZMEttcllOWTNrWHhnRFVZTVFLUlF5?=
 =?utf-8?B?ZUxOZnlwZnY1V2lYK0lLYkhidHI5eUpyaE10RExhL1RpemJzWHk5bWlUT21R?=
 =?utf-8?Q?ZohC2MANXzw6gNNJlSMdY4ICjHAR+q378tJpE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS9Bc091ZCtGTEM1MmNKYjhxbUhvWTQ1RGEzOWplcFpaU29mcjVVdk8wRnhr?=
 =?utf-8?B?MzhzMXpkczNuS1pWYjF1L2IvSlVPcXFNbTZjK205ZGRWM0EwTUF0NDZvMHBp?=
 =?utf-8?B?UXE2NGh1T3FSSGxud0dVVHdJOGJwVEVMSmNza2FTV1ZCVFRNWG8zZkU0QlRi?=
 =?utf-8?B?THRzbVYwSXBYWmU2ZkxSSGJ3aGNpbHBrODhWV1Uya2JMMzN0VHVXbG5ubmg3?=
 =?utf-8?B?UWRtTFlmdzBpSDZJcG9xaEk3dDM0OVU5cjZhK1ZRY3RMd21RcUF0OWM0aUxv?=
 =?utf-8?B?QkF0QTREcUlyTnlTdzdOWnBnOFN4RkJNYVhrYldaejNLU3BzdW1jbTYrb1VN?=
 =?utf-8?B?ekYxc0J2d21kaWpMcnZlb0E0Y2xraE93TDcxdmFLVkFDMy9rQVozdmRWeTRQ?=
 =?utf-8?B?V1hJRnVIREtmQ0d0TjJVTXRzL3hYQWJFeTJiQVNIT3AzV3htYWJCMDBsUzI3?=
 =?utf-8?B?Y0dOc0toVWhBSmlObzhjRGxhZDhIM1NURHNKTXZyOWtZRzk5elRVb1J6blJ4?=
 =?utf-8?B?dldUUEpWR2pKWkFQTHJrTFI5RkVYNkU4SG00SFQxV0N5MFdaUlprNnlHM3J2?=
 =?utf-8?B?RGxNMmlIY3k3VUFGdDlHQlp0eUF4ZE5CZDFvaGNsdVFwdVYwN0dHUWlHWnZi?=
 =?utf-8?B?QWd5dXFoZlBQeElLczNYNDRmOERydkFFTWt3TXZhK2pxMlJBLzhXWHdySFNU?=
 =?utf-8?B?dmIza1pvMnc5QnkzNkdjQ2Z0elp6cnQrQ3pKN3J6VXkxby9xTnRFQUFKb0hx?=
 =?utf-8?B?S2pISDNSeGg0Q2pmRjZJaExUSG5GM1llbUZQMU56TDd1RCtnajlKbzNjVndR?=
 =?utf-8?B?Z3RFb3JEUHIwK1ZQK21WZTFuYVUvQVpZSDBld3h6UEM1VkxNTjYvWWFvV0JC?=
 =?utf-8?B?RzAvQVlOM3NhSXV6U3pOUGp5TnUxMmNyVWNhaVErblUzNlIvdDhMbktwb0pW?=
 =?utf-8?B?MmpuRUVDdWZWTHpXZml4VWwycFZxN3Vhcmd6RmVIb3ovQWxRM0VWM1ZsNkZo?=
 =?utf-8?B?UGFNdE1mMTg0TEx1c3hiT0dOVUJpVFVEdjJaSXNtOEtRQTYrczhRNE93bmZY?=
 =?utf-8?B?TXdHVXVVcnNpVFlvOGw1WnJtenRxbmo1STBrNUh5U2RuTzIwQ2VyaUNtMXIz?=
 =?utf-8?B?eHJWSm1WZzk3N0RXc2lKR2J0cDI4YTVVUmFRWkozM1lnbUlGZzJMSktKVk5W?=
 =?utf-8?B?M1FVYk5kYWJkc2Q4a2F3QUhRbmpqeXl0THQrVWMrLzZpRkF1RFlpQUtlYjZy?=
 =?utf-8?B?TDBxZktkWWVxams3NllCQjRkbGNYRzlNTWpwRzFnN29oYWIxYlRpbERCQjJ0?=
 =?utf-8?B?NDJvZmlWYkRuSWx5MXVxcHR3TzNacTdUc3JQUFNIOE1md2NsZU9GelFzODhh?=
 =?utf-8?B?UmwxU01UK3hwcjVwUmFTUHFTczRRNGlWNFFaNVhnQ3JMQnFXN3BNOGdTQzEz?=
 =?utf-8?B?U3RhNkk1TXZJVWdSNlNwRXFtNzZXbEV2Tjl3K2V1dmN6RGhwM053RDRWeFM3?=
 =?utf-8?B?emNFTXhVQkJrMnFmVTN2M0F0NmlwMWloOURKN2xNdVVybENXNEE5VWE4aWNY?=
 =?utf-8?B?bTNsaFN5Ky9KQVR4a2dDQTdBVHA1c25vcWZFcDlBY1o5UDR3Mk80YjVKMWxj?=
 =?utf-8?B?L0pMNWY4WXlVK0J2ZXNxS09FSkhCM2pjdWJsLysrYjE3MXZ4Q2VzRG53RlJT?=
 =?utf-8?B?dEVvYVNQVXdvOWoyUlhaQk94cVVKRWFZanl4SEE3YWxKd2VUVkJyVEwxL2xB?=
 =?utf-8?B?ZFV0NmVCZU9CNWR4YkpXMlIxaXJQWFJXekprMGxoeko1YklIY0lHODdrYVJy?=
 =?utf-8?B?WlljVXgzSWpLQjhQL1dxMEt1bDNTeG9QcElPWWdaNVNURDY5OUp1VVI1K21S?=
 =?utf-8?B?RzNBV2dyVlpWY3kxbHNXK0l0U3F5Sm5lWGNpSU9WdEd5REI1YlMxenlpajFk?=
 =?utf-8?B?Y3RIUHVndWw4UTdXdnJxZUtUZjNuVE1DOEtndXR0RXowRWMxaWVqWHUwcFlX?=
 =?utf-8?B?VEJHU2N1TS9aendzeTZjRFYwdXV5eXR2OUxVaS8yMkhIdFdRUFdIa3ZOV2Jo?=
 =?utf-8?B?L2NMM0czQXNud3NROHNFdzVnZVF1SDFlNlRaanYrQzNPZEhpVkxmSTZQLy9Y?=
 =?utf-8?Q?CR7d1cS0fkWyzj6s6SXna7ir8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ddd9a-9b3e-4ec5-3a25-08dd01476335
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2024 05:20:27.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sCpbk9jj5b3CEW8EUEbw/MGwNrp6YPBarENgVyq9ifVKLCdCIrZ6gMvYrEU2ZO9HDdXBXsrw8G9PliFKPNg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4598
X-Proofpoint-ORIG-GUID: OhINT93l-PeHlp42HjxGS3nsLHAOjx7N
X-Proofpoint-GUID: OhINT93l-PeHlp42HjxGS3nsLHAOjx7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUENJIGhvdHBsdWcgY29udHJvbGxlciBkcml2
ZXIgZm9yIHRoZSBPQ1RFT04NCj4+ID4+IFBDSWUgZGV2aWNlLCBhIG11bHRpLWZ1bmN0aW9uIFBD
SWUgZGV2aWNlIHdoZXJlIHRoZSBmaXJzdCBmdW5jdGlvbiBhY3RzDQo+PiA+PiBhcyBhIGhvdHBs
dWcgY29udHJvbGxlci4gSXQgaXMgZXF1aXBwZWQgd2l0aCBNU0kteCBpbnRlcnJ1cHRzIHRvIG5v
dGlmeQ0KPj4gPj4gdGhlIGhvc3Qgb2YgaG90cGx1ZyBldmVudHMgZnJvbSB0aGUgT0NURU9OIGZp
cm13YXJlLg0KPg0KPj4gPj4gK2NvbmZpZyBIT1RQTFVHX1BDSV9PQ1RFT05FUA0KPj4gPj4gKwli
b29sICJPQ1RFT04gUENJIGRldmljZSBIb3RwbHVnIGNvbnRyb2xsZXIgZHJpdmVyIg0KPj4gPg0K
Pj4gPnMvTWFydmVsbCBQQ0kgZGV2aWNlL0Nhdml1bSBPQ1RFT04gUENJLyB0byBtYXRjaCBvdGhl
ciBlbnRyaWVzLg0KPj4NCj4+IENhdml1bSB3YXMgYWNxdWlyZWQgYnkgTWFydmVsbCwgYnV0IHdl
IGFyZSBzdGlsbCB1c2luZyB0aGUgUENJDQo+PiB2ZW5kb3IgSUQgIGBQQ0lfVkVORE9SX0lEX0NB
VklVTWAuIEkgaG9wZSB1c2luZyBNYXJ2ZWxsIGlzDQo+PiBhY2NlcHRhYmxlOyBwbGVhc2UgbGV0
IG1lICBrbm93IGlmIHRoaXMgcG9zZXMgYW55IGlzc3Vlcy4NCj4NCj5Pb3BzLCBzb3JyeSwgdGhp
cyB3YXMgbXkgbWlzdGFrZS4gIEkgbWVhbnQgdG8gc3VnZ2VzdCAiTWFydmVsbCBPQ1RFT04NCj5Q
Q0kgSG90cGx1ZyBkcml2ZXIiLCBidXQgSSBtZXNzZWQgdXAgdGhlIGVkaXRpbmcuDQo+DQo+PiA+
PiArI2RlZmluZSBPQ1RFUF9ERVZJRF9IUF9DT05UUk9MTEVSIDB4YTBlMw0KPj4gPg0KPj4gPkV2
ZW4gdGhvdWdoIHRoaXMgaXMgYSBwcml2YXRlICNkZWZpbmUsIEkgdGhpbmsgc29tZXRoaW5nIGxp
a2UNCj4+ID5QQ0lfREVWSUNFX0lEX0NBVklVTV9PQ1RFUF9IUF9DVExSIHdvdWxkIGJlIG5pY2Ug
YmVjYXVzZSB0aGF0J3MgdGhlDQo+PiA+dHlwaWNhbCBwYXR0ZXJuIG9mIGluY2x1ZGUvbGludXgv
cGNpX2lkcy5oLg0KPj4NCj4+IFRoZSBzYW1lIHJlYXNvbiBtZW50aW9uZWQgYWJvdmUgZm9yIG5v
dCB1c2luZyB0aGUgbmFtZSBDQVZJVU0uDQo+PiBJcyBpdCBva2F5IHRvIHVzZSBgUENJX0RFVklD
RV9JRF9NQVJWRUxMX09DVEVQX0hQX0NUTFJgPw0KPg0KPkluIHRoaXMgY2FzZSwgSSB0aGluayB5
b3Ugc2hvdWxkIHVzZSBQQ0lfREVWSUNFX0lEX0NBVklVTS4uLiBiZWNhdXNlDQo+dGhlIFBDSV9W
RU5ET1JfSURfQ0FWSVVNIGlkZW50aWZpZXMgdGhlIERldmljZSBJRCBuYW1lc3BhY2UsIHNvIHRo
ZQ0KPiNkZWZpbmVzIGZvciB0aGUgVmVuZG9yIElEIGFuZCB0aGUgRGV2aWNlIElEcyBpbiB0aGF0
IG5hbWVzcGFjZSBzaG91bGQNCj5tYXRjaC4NCj4NCg0KT2theS4gSSB3aWxsIHVzZSBDQVZJVU0g
Zm9yIHRoZSBkZWZpbmUuDQoNCj4+ID4+ICtzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgb2N0
ZXBfaHBfcGNpX21hcFtdID0gew0KPj4gPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9D
QVZJVU0sDQo+PiA+T0NURVBfREVWSURfSFBfQ09OVFJPTExFUikgfSwNCj4+ID4+ICsJeyB9LA0K
Pj4gPj4gK307DQo=

