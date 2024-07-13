Return-Path: <linux-pci+bounces-10235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9493071E
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB7B23A82
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B413D8B5;
	Sat, 13 Jul 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jBf4U/sb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBF1B28D;
	Sat, 13 Jul 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720897982; cv=fail; b=Aukx1uwNsCOox2WuA8DJmfWjls8aTSRWxlrX5KcZjpl08SENVZYDPX3Fj2tSU9JGzK/9NXJNlhchnP1AOVj0S3nHDGgL6Y8JPQVtdOf1GawYoTTLiDMsJ8cCTIhyFHYF3KPhm0/jr+DHdprJEQUL3JN7tGWPU8Ygs64bFEhpfcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720897982; c=relaxed/simple;
	bh=Rm0fEeEdynBx7l1muGFIPFKERysIsRuLlXZNqy4ZPf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbGz1SKSi3ftNQ4s7PuDsLW4e69yIcdV4O0motzl4VoiniDYlvkm1TPtz5qHXiSTrbnKuRLe1/mN14ALvfw5MinpsDHchl4/yVKIPSQndnElaJGVdxxjPDF0H3Cw/UVIEj+ESlfOkhVwOhqfqWJSTeuVXIrhEq/CPpt33nbRZw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jBf4U/sb; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DEStiI010073;
	Sat, 13 Jul 2024 12:12:23 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40bs3g0naw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 12:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbQHDpFpz74DXidFMG94eUD7Gbn7iXnV+SaRIw5MXLbGZ+PGXbKdUE4Xil2dbmcu6pqr/K/skqcpzRwS9YcEo6LkdcBhrHcgR5MfZfTq5SGfCD8dWJa6tZhXrHGdcNCWg9zHM5MAbabFlDq2d2dMXQn/L1HUBoMqq2FDhbKMnk0NzLlQHHewLZSaXqTx0/xqzHPzgcWhzoLGEokbqtQfaJXLCYVXx2s9SGHzolFKRYCbVvrWWwuVtvG6iWHhS0ZdTJy+gvMS3oDZJA9ecwTNf/BvAu+GMJtKN5621413x197EJty0oEvzFuW2mMGL3N78citKcJEi9bq6aNggIC1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqnCN4Q+gFg9DIiuXAIo5JQSYQ0HdVsxLGTIJh2IvS0=;
 b=WIEaJR64gWa901fHSheIqaG/3PaPP60i5cGf9jnJSwRJ0PPjgaxdmI7EIIksFDsw/8tNSqX2a5Yo9iAkvsSzq/DENy7shHbAZBBPFg7ySa5Y57NkgOMwkmwY0TDD4f5w4tqPTJb0RAViHFXeMwhIhXthMVLBopABRs5Io7zZuAvbtOFqIl5kU1V/+hGjHfdzDgSc8di0hE+H4bOU/08UEMLqhmvtqzRa/z4aS0s8gQ3X4uQo29B6c9axvDVo9vtzkkxd2ksbmwURNqQwC0It5UbCM9N5GGirgv1oPkpp3VHfLttIcwox6nTqYK6H7vAFZmM7D6zKJL3sWLeqsXtVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqnCN4Q+gFg9DIiuXAIo5JQSYQ0HdVsxLGTIJh2IvS0=;
 b=jBf4U/sbuw0mjJFIwEnVidQkC2f2/wYYaGeUVwCDAWkvmpNMJmkgNf6soG0SLpPFOlCNmy2WqPydJIMeoIMeeFktsfBU6Xq8B2ZUSbe7Qm0lbMs2h+Ie1rC6Xof8kVpg+I4LVlI7LHhRyKDSKxQfaRt5X//I70hvKKhQTkzkPLk=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SJ0PR18MB4090.namprd18.prod.outlook.com (2603:10b6:a03:2e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 19:12:18 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 19:12:17 +0000
Message-ID: <2c539dc6-bfb1-4dbe-8fbd-4dc04984f473@marvell.com>
Date: Sun, 14 Jul 2024 00:42:06 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 04/12] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Stanimir Varbanov <svarbanov@suse.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SJ0PR18MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c07d97-269d-4cca-9091-08dca36fb62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2N2STRjRmZGMDB2c2VLMmYyYTJ5ZHI2bGgxa0haU2lhbitOK01vbS8xN2ly?=
 =?utf-8?B?c3Zqa1BtUS9aTk9rd3BQZ0w3d3l5UGl6ODYrNkdFZ2JTRkMxbURuM1JOSE42?=
 =?utf-8?B?a29TcXpqalhnVVYxTFNqM2dFbHIxU2htbDJjSTRFdTRyUG9TQmJjUzR1VjNn?=
 =?utf-8?B?N0NqZDV1VXhqNlpYTFF2ZWV6bUcyVmszejkvZGdtTjR1NnVMSERxVWZqbk9r?=
 =?utf-8?B?eWUwMlZiZFJ6ampXazFNcFFMSmlyTzlLUjlJY2RIVmFQS3IzMFplbzIzTkc4?=
 =?utf-8?B?ZmJub3JqcWpzYXRmRFQ0R3ZTenZmK2F1MHpWYmJvSmNMNmQ2TXkweS9vK1Q0?=
 =?utf-8?B?UVhkdXNFRjlqNDNoNVJGcmg0R3dtK1NVYmhhZlova2FGelZzbDRVVlU3T0dy?=
 =?utf-8?B?Qy94UTZmamhaTDZhNS85ZXJYSm1DSFc0THRrYzc2bGRvNmpBSFh6a2RBL0pE?=
 =?utf-8?B?ZmxLbkVUV3hpUTdrTGIraEpYMFJuKzFQSG9XQ1pJOE5zc3NVZHVRN1lNeTVJ?=
 =?utf-8?B?UUZmbUFPd1pEVkZOclgyaWZUdmpxZDZkYktpS1B4NVlLOFB2VWpjWW5aMmZQ?=
 =?utf-8?B?cEJKVksycE15bmhXS3VEWDZLdDNiQWZqSU9oUWMwamNGTWNqL3JxWmJlUFU4?=
 =?utf-8?B?SGtEYXBEVHdBWklXYTlUb2x6SDduNVZtUWZNNWluRGgyc2phd2lBUitsbjJn?=
 =?utf-8?B?cFJqYnQ0aFdjV1NudUFnazZJWVpZbS9WRTQ5NXZNbHRXdE81TGJERWpNVzFj?=
 =?utf-8?B?NFVaZmtiK0grMHJaTjM1a3pNS05xRDJ2U3FqSm9ON0RrWmE1WUJGTWM5SmFG?=
 =?utf-8?B?VDBOc0llNUI0Y3BJUE50VkJlMXhhbnladFluTFlOSytvejg4SGhMaktGUWQy?=
 =?utf-8?B?OWhmZ1F1TGlQbnRHTUkrRVlJamxQQ0RXTG02cG9HTXVBcGZJci9HWlhkQ1Jn?=
 =?utf-8?B?R3ZvZmlpUjZsZFVYUU12NXlJRmNuMXVnNlFuTSs4S2p5cS85ZzRnSWRNRmov?=
 =?utf-8?B?VmY3dWZqYmFNcjA4MjhCN09kUGdtdFNqWUJuMVZCT2hXNkJYL1BidVBBb2do?=
 =?utf-8?B?RnBVY3lFVGRpbmswUExNZUJTUENSWkppVjIvcE5jVCtqZnJjSzR6SThuVlRq?=
 =?utf-8?B?amxXVWJLU2tyK1VVNDIrVUp4NGp0MTZPV0ZtZ2JYTkc3VVNjbVg2S1RFTGJD?=
 =?utf-8?B?WVRPTFFmcHpQcW8rWHNNSXRNNkNha0ZpQmlhSlkwcjBjRUwyZENValNnRXcx?=
 =?utf-8?B?VmphS2VkNzBJM2xTOEZ4Q2lZWlo1M0g3aWg5S1pnSVVUL3lOaGVTN1VPZ3h2?=
 =?utf-8?B?bm9lb1pFaE5CNHF2dGhMWS9NUXpYUFRJcmU0N0JIUEgybng3MTBOL2xlblVN?=
 =?utf-8?B?VEtkNnRDRVlkM1V6V1pzZ3hYQVk1VHlTcnBDclFBRUg4R2s4RWttWHhsbDVJ?=
 =?utf-8?B?TENFWWJsb1FqbzVRbGVXd1lzSEhXeDZEZkxwbHFraTFyTVg5c1k1MDFrSWtn?=
 =?utf-8?B?UFdGbFE0NDBGdmZWa2dPQm1GcFNqcmQxQzRzZWhIUlFqdUoxUkZVVEtiVk9V?=
 =?utf-8?B?bU5FV01DN0I5Mm1VakpvczM5YkRhZVR6S2VSdk1ObGk4TUhFK2pPRVUxa1ZH?=
 =?utf-8?B?bldNTUtiQUNtMWc0OFp1ZWwrZWNETjdEMlMxeVJ6NWdTNmdJNlVXZjhuMHVy?=
 =?utf-8?B?dkRWdFpGQnVUTlYybGs0N3Z6YS9EdW1LWDVGVUtPOUxoUzc1dVo3cWsyT2FS?=
 =?utf-8?B?S0tBMmhFRTkrRXdRT29BTXJTdXE5SDJ1QmtRSnd2elVUVklCOTJTSDg0ME1X?=
 =?utf-8?B?NjJFQWJtQ3NoZkoycEozUFRYNGVYRTNjNk5WMmdrdnNtbnZjcE9DczZkZEts?=
 =?utf-8?Q?umj9otD5LRAAs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzdEUjZvcnFSTkZBOGdTaXhTV0xNYURQUW45M2pLNEVEeWc5Y3BhNVk5RW4y?=
 =?utf-8?B?dnl1STNCemZRRUp5R1drTWNqdGhxNnJqYmZEVzhDa3QvRmlIUEVId3FVa2tK?=
 =?utf-8?B?ZUFSQmZDcWxoV3FKRUwxMW56aHUrU2hqS1UwcVM0L0JTblYydlcwTDQwR3J3?=
 =?utf-8?B?b08xeXdWWWdIZDFKaFNMT3ArUnA2MGVxcFI4YVVzb1RsdFFCZWV3QXFlOXFP?=
 =?utf-8?B?YkJZaGtNMDlqQld5YXcrVU9FTm1ZUjN1WmdoeTNGNHd0RnNBT1dpdkh5RmtY?=
 =?utf-8?B?MDRLMXJldlUwaU1SeUs3c0dRNFh2MzcyUjJaK3N5TTFmMEU1UUFyOUVZU0FG?=
 =?utf-8?B?ay85UnRtdCt6bVJSc1gyOHJ6RHRKUDllWlphbGlsQ2l4TTU3SlZodVVVU0h2?=
 =?utf-8?B?U29JWGllTm5FdzVKMTFZNm9JYzNaZnpRdDhCTVRlVjd1V3NiR2YwOGZYblIx?=
 =?utf-8?B?b3NvV1RnNXBMSkJQSlVJb1lPZGJ5emE5UTdoaTJDQ1ZUaVNEL0IyRm1LWnJP?=
 =?utf-8?B?ajRvelFGMmRNWDZPU1huYmVpSmtUcXNlS1Jrb0V0aHpPZ3VWMUlvSFB0elZJ?=
 =?utf-8?B?ajExcnc0Wmg3SmdCNUwrSHJqaGdzVHR6K2FZUU8zMytsMThEU0NpZnp0c2tQ?=
 =?utf-8?B?RElqWW5TWW84S2diSk42SVlyak0vN2Rpb2htc2FaeC9DaWF5TTlZUlcrbWV6?=
 =?utf-8?B?b05wc1Z4Wkc4OE1udmxMZ2Ryc20wRUh0cVQ2V2p5QUY2cXlzOVVJNU9rVnZD?=
 =?utf-8?B?azJmay85LzgybnRlS3VYdHJwd2dXcmttUHhTeVEvNzMvbGIvM1dqZ1RCelBy?=
 =?utf-8?B?WmwvRXd5dlI1S1RWUG1uOXNjTUZPMFU0WTJtQ2JVSWFoTmZBUjFGbnJvWmR2?=
 =?utf-8?B?aXF3dnQ4TVB1ZXk0Q1F1Vk9sN0ZXMHp5dUROS0J6bWVOdUVISm50ZU1xOStJ?=
 =?utf-8?B?L0RKTzBCcmR5bWhJelR3R1Y5VTRkbHFJOHhrWWUwZndHMHpQUjU5bFkzOU5D?=
 =?utf-8?B?bjlWeGlvODY0UXZoWHpRbFJVcG9jRTlIMWQ1S3VKSVNWWWY2MHhNdlhqQTZi?=
 =?utf-8?B?Qy8xc25wMENXbUxFdzlFZUZOZWI3cDFQWTJxSk9BWHlEdzJkZmdrRVl2dEVy?=
 =?utf-8?B?TmJoSW9vRTZXalBvb0liZ0dkYnpOTlpxVzFhdSsrc0ZRZzErV3A4eC90bis4?=
 =?utf-8?B?eTR6c01JUEZ3OUQyMGNOMEVEenhINVhSUU9hNmtlcEgyZktQSEE5YUZmWmt2?=
 =?utf-8?B?emdsdTVqQjJhcW43ZTI2Wkw2UEhiOUdHSllpNjBuTHBObzUyRHg5cU1GUUhG?=
 =?utf-8?B?ZW4zd3k4Qm1BLzA1TzFkZjZqSjQySjk0bkQvM1hBbXdnSWFsSWU1bjJPcHY3?=
 =?utf-8?B?NVBsZ09aNnJHOGVlNTNROFE4amVLQ1NDbEw2TWo2VmJMMFdqNk5zVWVzZUF4?=
 =?utf-8?B?bThFWHRRZkNCc292WWNzakpBZ0c4VG9HK1Y5MDI5RTVyRFhqWTExTUV5S3cx?=
 =?utf-8?B?WVRyd282VGUyeDBraFJtZGlpS0o5OVQ5eUYzcnZvQUZEMmw4QzZvWWVMUVp0?=
 =?utf-8?B?dFFaNGhWZVFDVHFuRjFuMlp5ZDRMSHE0MWJGYzNlVUttQ09EV21VVFE1Zyts?=
 =?utf-8?B?eTVTd3BMWnVFNG9uOUhPV0xaZGc4SW4zVjJXcm5aZ0lrQTNXM1hHYWJUTEo2?=
 =?utf-8?B?N0JUWUNFbWRmbkRKV3pxdmYwOWpIdno0YjNBRkg1eVk1bm9mUmEzeVpJMVdj?=
 =?utf-8?B?bCtCSkRhdmkrZndRdmFvVUdxMUw0Y2dXTFZBRjAycHVhM3BQOUtEYlBoNlR6?=
 =?utf-8?B?NWhySUVzWDY0RzRXZFB6NHNxK2Y5ckk1MUVDbVhVeGFwQ1dZQjBlQldsb2l3?=
 =?utf-8?B?QmEycFhoYXhSSkpPNDlvNVlyRWFXczRORkJpOGY0cWZqUE5BaWFyYzdNMWgw?=
 =?utf-8?B?dlNpcGZUSzRmQm45djV4VThUVmdnYXFaMDRvUzRlay9QTXQzcDUyWjlXRFJr?=
 =?utf-8?B?OGNrWmhNR25NdU9jZi9QUG83Y3pjZ2Jpb2lNa3BNRVlsd2ZHWWdwL1lQeG5X?=
 =?utf-8?B?TkpEQVk3STBicGw5VGVQZHF4WGdKK0pwTGdDQ05ncjdyRklmVE1zWGY2ZWtz?=
 =?utf-8?Q?UE7Ia/Sht/gF5logRdW0MDbWC?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c07d97-269d-4cca-9091-08dca36fb62a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 19:12:17.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeW5c62eeB3ulrZxizkYOxSPCps35iiWOUaMRKZaylzwuWvVA6DvBckcLyVNYR9MCjWGHyUmyHHQQHLesqMBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4090
X-Proofpoint-GUID: 5yTeB_kRT8Fa3Rn4xO1AagLllsPHfKdw
X-Proofpoint-ORIG-GUID: 5yTeB_kRT8Fa3Rn4xO1AagLllsPHfKdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_15,2024-07-11_01,2024-05-17_01

On 7/11/2024 3:46 AM, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c257434edc08..92816d8d215a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>   	enum pcie_type		type;
>   	struct reset_control	*rescal;
>   	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge;
>   	int			num_memc;
>   	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>   	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>   
>   static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>   {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (pcie->bridge) {
> +		if (val)
> +			reset_control_assert(pcie->bridge);
> +		else
> +			reset_control_deassert(pcie->bridge);
> +	} else {
> +		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> +		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>   
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = (tmp & ~mask) | ((val << shift) & mask);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}
>   }
>   
>   static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -1621,6 +1629,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   	if (IS_ERR(pcie->perst_reset))
>   		return PTR_ERR(pcie->perst_reset);
>   
> +	pcie->bridge = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
> +	if (IS_ERR(pcie->bridge))
> +		return PTR_ERR(pcie->bridge);
How about using "dev_err_probe," which utilizes "dev_err" for logging 
error messages and recording the deferred probe reason?
> +
>   	ret = clk_prepare_enable(pcie->clk);
>   	if (ret) {
>   		dev_err(&pdev->dev, "could not enable clock\n");


