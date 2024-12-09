Return-Path: <linux-pci+bounces-17913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D39E8EFB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCE285B73
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D5215F69;
	Mon,  9 Dec 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oEHln2Gs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DD215F46;
	Mon,  9 Dec 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737460; cv=fail; b=QWPMtwY3xLD/ZQa/6UHnaxYLH9Pwf0mdRHwFbjUWbokt6dWI50eZ1NUFZMugZIR3l1syIZqPvt2DH3ncBH3HhoGDWxxU/WGvLt8LvCNJDXEq6RaliDI18cqqM5l7RebYowWJFVYYo8hAYNDOif6EjStpzPm8WYJhcveqIxyqME4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737460; c=relaxed/simple;
	bh=TjghnJ4v89ldagDE4jgEi+HEk5lgd7ewtteW53LS3lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibqBCrGnsx43VGjw2in+OMJ1EZqQ3LIBJXjl8DJjyw4B44p2uHemIAgj97tyUd7W5E2EF047BmKs/p6p2TWxp85udIwrQIsG5rn1ZkuOE73Jq0kcRzx+SxtOy/nYrZCqb2JJlqqN7aqkX75mBW5ZP+ECSUx8WpQBqX/LWzlnyf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEHln2Gs; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7Y0zDKZSbDzWFb7nrrzM4pZGoNrClyeyHd9hKRVa/mys5p+SoQrGg7iv5TDQbZ82oYUrkwP95GqlMiNgB1oW8YSzEsjqPKFjReIRafYc0l/T90MHyzRmVD1UmS0yP4idUglfK7TuqTRTMuy/A9K4GMvGZEqjtxf/As9DzWoUUzEucraLEo2iEgY7rAZySDy5Q7JN7m/s3I/oSTcKQ3/i6+EHpv1xYvtlfA29gplA8iHXeh43YeZTBHtgejlq3oWlNRjIpTX2EjFc/qVdtVYnlKLO3JDMmMCj+YnGWvXEVxTg+brhBJJ6caKPYI/4USe/bdCG8v3Ww18wfo0TRvtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjghnJ4v89ldagDE4jgEi+HEk5lgd7ewtteW53LS3lE=;
 b=owXaO6iYH8e1uW9x5D4pex7lw97X4egkYL1/lADv6A1IO0vT8MSgJj7LAA3y8VoR1KO6QaBpvXcfY472F331wHPmrccY/XdrdBp8eWsIQAZQjmdrAerEskQMju2Vw4KvJTQcFu2qak1vTsky1nR7E0/o6noTFPEvXjHo2gZUQ5UiPqEWC8JsDVh6Qnt2duWgt1xFgMey3XrJnJZ9rXCVwchAjzYDZeXLaHqQEFo9qV9b26E2yLH+psRMU0ZO+V8uwkjji4N0JRdvlYDFrKgFu+ljl9kjHId09y7JIT6RjbXOmQ5uuB0exv+nTvv22ODMRfE/oFWfrzFC9BEtwQptBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjghnJ4v89ldagDE4jgEi+HEk5lgd7ewtteW53LS3lE=;
 b=oEHln2GsQJg3FR5PW4cz9O2OUo3u19yg7hMY1Gei7RBtpev4xf3v5TqJN17uvoM9XuEhFtL6eKmRCRZYpXcs4ac7grXAOPdHpUIXYhmkqIS2SHC31mcvQWfF7d7Ye3bGCD24P28O8ABc7GJRZoGgffQjQzwQxHYvKUjNZ7eT58E=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:44:15 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 09:44:15 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbQMPBUsv/8qTDsEOX3G1ItJvCnrLOtysAgAPsY4CACbzOAIABLeMQ
Date: Mon, 9 Dec 2024 09:44:15 +0000
Message-ID:
 <SN7PR12MB72012B3F617DCE9BC398227C8B3C2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
 <20241129202202.GA2771092@bhelgaas>
 <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20241208125858.u2f3tk63bxmww3l6@thinkpad>
In-Reply-To: <20241208125858.u2f3tk63bxmww3l6@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA1PR12MB6704:EE_
x-ms-office365-filtering-correlation-id: 65584e70-b6ef-46f5-38eb-08dd18360b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXBGbUdCVjJTb0hHVmxQM0M2dERrZE1lQVZFZTd6Z1RNMXQ5ZUhTWm1pNVVw?=
 =?utf-8?B?UEYrdEZuQStoQlJTdDdqRHFsTDkwSjZlajQ0NzVWajBYTHhybzVLcXRuaTMw?=
 =?utf-8?B?VG1jM1huWTgxSEhNN0hzZWY2L2RwK25GZlBPQmVyNWVlYW5hNjVoeEJOcExI?=
 =?utf-8?B?VDBMQVNacGpRdWpHcnZYMmdkU01NMUVFbWN4Q2RPMkwvL2dsS2JIWGRjNUlJ?=
 =?utf-8?B?Z2laZHZkUVpxd1ZURTVlUWdITW9UUVRPRE5NSEdVOWlRT3dCVVlzd0xCY1l3?=
 =?utf-8?B?Z3EvaEF3YmhlUkMzWEpyVmcwalNoSEtja3kyOGUxeEJua0p2YVA2TFUvYjNm?=
 =?utf-8?B?MGVKcmEyd3Ezc3Y3WnNZYjZ5c1dPSFhubDRvNEhvODdHM3hyVFhtaXViTmJj?=
 =?utf-8?B?aHJEU1pBT0dic3A5KzZMakFTRjRuQXBCV05scFROWXE0SGlqUzU5M2dLKzFh?=
 =?utf-8?B?SGdTZVU4U1pHUjVwUnFsRW9XSXVOVFArQ2JmRnVFRzQxS3JDUURvZHZrOXo1?=
 =?utf-8?B?TC9zV3QwQTgvTWtDQ05JVFhoQURmQ3BxdXZ4YTlITEJLSE0xUncvcFdhcnhN?=
 =?utf-8?B?STl3NE5qZ3owQ2Y3R0ZpdjlhYWtkYWE5SGR6N2diR3FVVVBkM1ZWby9Xb1hw?=
 =?utf-8?B?MVU0V0JzQ3FCcVBEOTRyVE9DUjBzc1YzZ3pZSG50SUg1aklIWkJ4ZXBSYnBw?=
 =?utf-8?B?WFlCeVdCZmVwOWlqWVlkUXN3TjBXQ1V3K0VXTW5lOFNrU1k1MzN6SythL1VL?=
 =?utf-8?B?cTh4dkJTc1dIQzRjUU1YWDdwZk1FaWpid1F1ZXNmZlJTY1RucEJNTnNMQUQ2?=
 =?utf-8?B?SDZMRzQvSllQZUdhenU2NE5NSVJ2WFVadGNMU29uak8vVHRDSDlDbWx4TWZs?=
 =?utf-8?B?T0hrSmc5RnU2V3dyWTJoS1lxZ21RS1labHg4SFgvMFAzYkNUd3lPRDFhT3lK?=
 =?utf-8?B?SENRMnRhRGNPUmg5Ny9wcjllL2RtV2hpUng2eXlvbmlNRUMxb1pBQkNWNEJW?=
 =?utf-8?B?WW1GRlZ4TGdFMW9Hb3NQTXNqdDN2cDZpMHkzUktGTGxZekEwOUhJcnE5cS9U?=
 =?utf-8?B?MlJBVmxYM1lOWjJZeEd5N0ZZVjZISkg0RXdFcWR5MitSWVJHWU43YkZ2Yzdw?=
 =?utf-8?B?RVBpbHNQSjN0cUIvUU5mWWJjNzNCYkwyZStYRmF0VlNDbHlxSnhUa0RwUFNj?=
 =?utf-8?B?aFdRMmhOUnI0UVNNb1RleUVUaHphZkZIZ1crOE5QTjJSUnZJTXBDMVVBb2ls?=
 =?utf-8?B?dGsxQ2Y3YlJWaWp3OWM4UkNWNjZZc1gyUi9OL0tLQTNGNnl5ZG1KTldQM0RE?=
 =?utf-8?B?aXNNcGkzSktTUEc4Tkk0Wk9XdS9WQlhlSnAwbDlyb1EzSThpbnBrOHhrVlRz?=
 =?utf-8?B?OTVlcGZOVTdDY2NNMkFtaU41bzRQZ1hCM25tdk9OTndrWmYzbVl4TE4yTGM0?=
 =?utf-8?B?dXFtV1lVMlZCdzU3dTZvMG9KekFiYUFBSWQrYlRhTHJrVGpCZzNpK2ZJOHQw?=
 =?utf-8?B?U01WZWhUWmRLV0s2aVNMbkZ2RzFXeXdUN0Q3L2NJWkdVMzVFalpUaGhNZnJO?=
 =?utf-8?B?Mlk3bTFSZmRvRlNYYnhaTXd6QW5DZUR4TGxFbWhIQ0kyQy9EQTR4YjlOeGtw?=
 =?utf-8?B?ck83QzVjcHBrWjNkMjhWay9kNUdMOHpKR3NTMWM0SXBac3BNNXBNNG9wa2g5?=
 =?utf-8?B?ZVNUeHdwMmE3M0ZBdmUwOE9lNGVEOUx4WVBjWDYyR3FWQkxpMzFxSUxpL2JY?=
 =?utf-8?B?T3NKcEdNTC9KNml5U1F1S1FESUhBK2QyQTRUV2syQkh1ekJ1cytxeTBuZmZj?=
 =?utf-8?B?MG1YRmFNdUNIMVBkQUs1TDc2UjZmWTNOS0FFS0YzVGJEUTl1TXRQZWtYNmFv?=
 =?utf-8?B?bGhmYnJRYUpvNm1BT1lBQ2JFTFlwWmdodlJCMlFDcy9lM0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGF3OE96SnBhNEZoQStWVkNLVS9aQXRXN3pGZnZHM0tQWXEyODdSWXFPVjB0?=
 =?utf-8?B?MU8zS29zWStGdVpoaVBnUVpUaGZweUxIWnd0aTEzdUdqU2RSbCtQRFFGanM2?=
 =?utf-8?B?SG1Odnc5Z1dXMXZFY2FIaC80SVJXSVZ6RlRsSG9wMjlnb3lvbS8zSnZPeVg3?=
 =?utf-8?B?cmkwMnoxUWVWMUVNd2d6WUF5VzU4ajUrSTVqQ1BEd25zaHlLMVpoOER0REpN?=
 =?utf-8?B?ZUVCc1hZRkdhNTJpcFNKVU9pQXJKenpBSGRCSHNzMWw0WElYTW9ZUU5pZlhV?=
 =?utf-8?B?NWgrbEFOZjMyVjc4OGxhVnpNYy84eFRXQ0pGRnNhdTBNRVV5TFY0QUVNVnRq?=
 =?utf-8?B?TkNWSDRsVzRNQVB0RXdQdjFvUm9JQ1VjdTJlbzJON1l4aUVrQlVMSGpMNUdn?=
 =?utf-8?B?VElrcW9uN2QrMUgyendUS283TWhOdkF0STM2emlYN1VhaXFSVFR0WGhQWmov?=
 =?utf-8?B?YlRYZ0d5Uk5uL3JWVXAySnNZZXBYVEJXRFFDTk1FdVJNU1d1Vys0eGVoSlpP?=
 =?utf-8?B?QTZhU0xJbWxMMlJzWkt2SjY5cHZpd1JYaCtkYWpSc1NnTitzSDNqd3ZOQmpT?=
 =?utf-8?B?MjJjRVNzSkJlSVd4R0dyaHpGZWJVZUMrNDRRQ05WVmk5ak5xUGI0T1hvTFRD?=
 =?utf-8?B?UHNQT0pmS0hubEN3UlVjVUdjYk9qdisyL3I0bkI1RmtLam5PNkZGd2hvdlll?=
 =?utf-8?B?cEhWY0NnZGV1RVhYcEhwV1VxYlcvVU9DVnltVjExM2RGWXhCd2dkT3Z3YVY0?=
 =?utf-8?B?cmVvQTNod0pRZDdQSGl5TWFIU05JRWJVb2hYT2xtTWF4VVAvUm1VZEFkOGdO?=
 =?utf-8?B?TWNYUXZFMmFwcldXNUNUZnFGV0JWZ3J2NHMyMGk2SG56NXEyTndkMVNONXNW?=
 =?utf-8?B?RW54RDhGcjZEcDYwNGpJMzhmanZUZi9TR3hMZHhHM09jOXlLSU45VkZCcXVz?=
 =?utf-8?B?QkdUTmIxdE5KV21WcUhuZzlHbEVqamo1OEp0VHU1a2xZNG5QQllJY0hRNmJp?=
 =?utf-8?B?T1VWcXpjZkRhZVpxQlpIUkdWek5ta1JCT0s5eGI2QUlWY3FNV3UzUnA4cnF4?=
 =?utf-8?B?Q0M4ekd2RFpTakxDZEhLQW1zM1hIeUE2bDNnK0RmNHpheFFocS9ISTFORmEw?=
 =?utf-8?B?bU5CRWNvMVdnVEVzUldCeTd4MnZtZHRYVXhxWGNyMC9pUzRMZmZJSHQvMkVU?=
 =?utf-8?B?VnpnbGh2UENvWVIrYnJtelBSVjNETkM4R0lyN1hVRXc5RDUvMStXOWlIN0JH?=
 =?utf-8?B?R3VrRm4vVXlaRHNyeGErL3lBNit2TUc2RHVlV0J4S29DVmR5NmVJc3lsUFRS?=
 =?utf-8?B?Y280NjJvZDA3Q08wUkJXRTZHeFdZM2tYdlNMMi9ubW5PWGJ1RTJlaWJBbEg0?=
 =?utf-8?B?eEVkcFlNWUVETXVhZEsva1pjeWRpVUI2ZEQzdmZlRFAxNU9GU2NkUU9DTndr?=
 =?utf-8?B?VVBkK1RudjZxUnJNOWpRUURLREdaU1ZyMEd5NzkrNEc5dmxwU2hVRkw2aDF3?=
 =?utf-8?B?c0psSC9NYktWbEpIVEQwTlgxZExkV0x6eG9LOFBYYWpMUmgwYVRrMVpuQzQz?=
 =?utf-8?B?YkZxNThFWDJUeTRZcGtHLzBZWUpiT2g2SEFWL3Vnb3dKMko4RVVGTnhQOWUw?=
 =?utf-8?B?akg0UFVXaG0zRW5yNEh4eWVESWNFM1pHOTJhN3drSlNVa0tRbWxUdWZaeUxI?=
 =?utf-8?B?Tm04a1BZendJN09TSlYybjh5Tklma0V4SS9EZ0NaTjdNaHM2dVpkYmdISEZu?=
 =?utf-8?B?U1B6WEVPaVNhZmVGSERSOUpOZkdYcUVBUXF3S0hQRlhUeHB2N3pKbTkraVpk?=
 =?utf-8?B?UTh3ZnNKbUNmbFRVVnI0RGk4T3FYMjA0bjk4VnlKWFVHYy9FM2VnNnlPUFFs?=
 =?utf-8?B?aUFQTFJBbUxSajFDeGd2SjI4VThHdHFSQ29ORElOZjdzVlE1eE96aGppZGlD?=
 =?utf-8?B?MW5QWVNtTXRHMnFPd0hHMnZZL1lkZmtXdnJPVTFDa3VhZFNaMWlrVmhKYThB?=
 =?utf-8?B?Vk1iZGJQSUVLTTZ5alVGTDFXS2pxV282QWQ2WHZEbWlCaThMeDJXQm1SV0t2?=
 =?utf-8?B?ZEpzOTZlTFlBdk1JSGJ4RHdxWEEvVnVJWTEzcmYvR2h6YURmaU1ZVkNFZko1?=
 =?utf-8?Q?JcHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65584e70-b6ef-46f5-38eb-08dd18360b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:44:15.1359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7oclhVSwLv16vkOE3kS2CisZKklnL1HgHA5TBPjBHCmMdEmpHZb7x4n5QRZTvf90Yp35HT5p5bj1kgq/UY4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

SGkgU2FkaGFzaXZhbSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBt
YW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZyA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgOCwgMjAyNCA2OjI5IFBNDQo+IFRv
OiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+
IENjOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBiaGVsZ2Fhc0Bnb29nbGUu
Y29tOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgamluZ29vaGFuMUBnbWFpbC5jb207IFNpbWVrLCBNaWNo
YWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPGJo
YXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIFBD
STogYW1kLW1kYjogQWRkIEFNRCBNREIgUm9vdCBQb3J0IGRyaXZlcg0KPiANCj4gT24gTW9uLCBE
ZWMgMDIsIDIwMjQgYXQgMDg6MjE6MzZBTSArMDAwMCwgSGF2YWxpZ2UsIFRoaXBwZXN3YW15IHdy
b3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiA+ICsJZCA9IGlycV9kb21haW5fZ2V0X2lycV9k
YXRhKHBjaWUtPm1kYl9kb21haW4sIGlycSk7DQo+ID4gPiA+ICsJaWYgKGludHJfY2F1c2VbZC0+
aHdpcnFdLnN0cikNCj4gPiA+ID4gKwkJZGV2X3dhcm4oZGV2LCAiJXNcbiIsIGludHJfY2F1c2Vb
ZC0+aHdpcnFdLnN0cik7DQo+ID4gPiA+ICsJZWxzZQ0KPiA+ID4gPiArCQlkZXZfd2FybihkZXYs
ICJVbmtub3duIElSUSAlbGRcbiIsIGQtPmh3aXJxKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJl
dHVybiBJUlFfSEFORExFRDsNCj4gPiA+DQo+ID4gPiBJIHNlZSB0aGF0IHNvbWUgb2YgdGhlc2Ug
bWVzc2FnZXMgYXJlICJDb3JyZWN0YWJsZS9Ob24tRmF0YWwvRmF0YWwgZXJyb3INCj4gPiA+IG1l
c3NhZ2UiOyBJIGFzc3VtZSB0aGlzIFJvb3QgUG9ydCBkb2Vzbid0IGhhdmUgYW4gQUVSIENhcGFi
aWxpdHksIGFuZCB0aGlzDQo+ID4gPiBpbnRlcnJ1cHQgaXMgdGhlICJTeXN0ZW0gRXJyb3IiIGNv
bnRyb2xsZWQgYnkgdGhlIFJvb3QgQ29udHJvbCBFcnJvciBFbmFibGUgYml0cyBpbg0KPiB0aGUN
Cj4gPiA+IFBDSWUgQ2FwYWJpbGl0eT8gIChTZWUgUENJZSByNi4wLCBzZWMgNi4yLjYpDQo+ID4g
Pg0KPiA+ID4gSXMgdGhlcmUgYW55IHdheSB0byBob29rIHRoaXMgaW50byB0aGUgQUVSIGhhbmRs
aW5nIHNvIHdlIGNhbiBkbyBzb21ldGhpbmcNCj4gYWJvdXQNCj4gPiA+IGl0LCBzaW5jZSB0aGUg
ZGV2aWNlcyAqYmVsb3cqIHRoZSBSb290IFBvcnQgbWF5IHN1cHBvcnQgQUVSIGFuZCBtYXkgaGF2
ZQ0KPiB1c2VmdWwNCj4gPiA+IGluZm9ybWF0aW9uIGxvZ2dlZD8NCj4gPiA+DQo+ID4gPiBTaW5j
ZSB0aGlzIGlzIERXQy1iYXNlZCwgSSBzdXBwb3NlIHRoZXNlIGFyZSBnZW5lcmFsIHF1ZXN0aW9u
cyB0aGF0IGFwcGx5IHRvIGFsbA0KPiA+ID4gdGhlIHNpbWlsYXIgZHJpdmVycy4NCj4gPg0KPiA+
DQo+ID4gVGhhbmtzIGZvciByZXZpZXcsIFdlIGhhdmUgdGhpcyBpbiBvdXIgcGxhbiB0byBob29r
IHBsYXRmb3JtIHNwZWNpZmljIGVycm9yDQo+IGludGVycnVwdHMNCj4gPiB0byBBRVIgaW4gZnV0
dXJlIHdpbGwgYWRkIHRoaXMgc3VwcG9ydC4NCj4gPg0KPiANCj4gU28gb24geW91ciBwbGF0Zm9y
bSwgQUVSIChhbHNvIFBNRSkgaW50ZXJydXB0cyBhcmUgcmVwb3J0ZWQgb3ZlciBTUEkgaW50ZXJy
dXB0DQo+IG9ubHkgYW5kIG5vdCB0aHJvdWdoIE1TSS9NU0ktWD8gTW9zdCBvZiB0aGUgRFdDIGNv
bnRyb2xsZXJzIGhhdmUgdGhpcyB3ZWlyZA0KPiBiZWhhdmlvciBvZiByZXBvcnRpbmcgQUVSL1BN
RSBvbmx5IHRocm91Z2ggU1BJLCBidXQgdGhhdCBzaG91bGQgYmUgbGVnYWN5DQo+IGNvbnRyb2xs
ZXJzLiBOZXdlciBvbmVzIGRvZXMgc3VwcG9ydCBNU0kuDQoNClRoYW5rcyBmb3IgeW91ciBjb21t
ZW50LCBZZXMgb3VyIHBsYXRmb3JtIHN1cHBvcnRzIHBsYXRmb3JtIHNwZWNpZmljIEVycm9yIA0K
SW50ZXJydXB0cyBvdmVyIFNQSS4NCg0KPiANCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

