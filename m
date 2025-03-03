Return-Path: <linux-pci+bounces-22751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AFA4BC7F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574863B91E7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BF23F383;
	Mon,  3 Mar 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="WMm7f73t"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E51F0E40
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998146; cv=fail; b=hn3sOQK8IfvL6yw9TM3te45Dcs8mL4GFIrqjKF6ppPKZGeGkn8GuEEdPTQO3Vr6Iv/w0j7ZEiGHbKmcIxJYYmlLdchNJxp+ysbu5coUn0kOV9Lx0SNGC6sOfaAeGezsUx2yxwbfv4fk3cHJGI+WwSdiM3giyItBSd+I44dOxW30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998146; c=relaxed/simple;
	bh=KT8wtOCyKFo+A3Obrawf/rK64AEMrtYT50uTzN19fBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3os1vQw0wkR3Xk8ErjLV3Rin5CmWnmG8VC6uT67pp8dorm3+FgyWJWcyLC6JiDHcMkTIamjhW70o4kou9LBf0eTL/Q2aaPVawVk6W+5syXCVh5nk2b5v393LwkndlJXHQKxY+DjG643EwrhWceWL1nPJSL7bP2Xf+ZLwUMYftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=WMm7f73t; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDLzKE7NkMp6h5LaGpNwlBLw4YxHEZeQgnh4X4mtSRM9iaKhNYdHHAHPo5sgTLrr2lxwe3kXIotboig+48DtDTdXhMu7WLP/XMWTU3uY6op/MU9dODvQ/aoC82U7BWb/72KQ2c6lASqOkkrhRupTXHe/wCkga9TYSMY+0kCylHHhn368jAN0arbOZuwAvT8gWrjn2w/sI23hhxRkQ/eOMDb2R82GRMKzbm+cXvYEVs3Frz7zjcpBkdFh6aOvsg4LUy9F22Qxq3JQL3erhCquX774d8TpmWxhx4hJE+ska5uT3GNn5agWBJWFqcdrXiY00FC7qORmh6Bm/ufowppGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT8wtOCyKFo+A3Obrawf/rK64AEMrtYT50uTzN19fBQ=;
 b=wBfFR3yxQHnwNbQoC7HA19lmRpQTZhILxzB+BWEe2b9O7L2Blwf4Szr6LeDpH4b7jzfXyUKuxiIqJwPBytXtDcXUDpD5po42LOtMI1t4ltXe24q47s0cinqri9lsjepLhl6lDOZU/f32hblOY5Xz11HAfRhHVKNWtChiy4SWRyKrDxIOizZJtDQBnkQjYbGeIwGF+AzhGVPyBarzfIjwVjgqyWKhNawyfkMwzrX0FAmEd+iJxxQkIf09150P3Y1tuMYY1YZOO/dwRuwSkf/wdAhZWv0v5UOcs9Coo9zkSLQ3adIl+tFF+DgPmrvvtWqZlSc5tCBSV5DtyVYm+EtJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT8wtOCyKFo+A3Obrawf/rK64AEMrtYT50uTzN19fBQ=;
 b=WMm7f73tjEc8P1MaWqk6PlELKo5au6YueQRKSIA7mWAEZRZSHaPZUUoTdFXQeyRwCLdTk/1T3PvC8gQ+TQaWEyEbTfWBFIsQ6LnKqhGXUOURCcroITnWu/PWCxsNnfkuo6U7IerAPFu9WCXpJL5thmRDQ8XiXIf6OXMsQvXDWWcv5zDFbwy3gSeo0mn69fcl2frDvgCaKVx2+dUU2lZK2bFcEdps7mu10DF3x+mhKl7u+PQJmhQezZjOyF3Px4gNlYLRbXGTGs7P9p62OLAf+gHHSRwRpypRlMc8xezduSwmod0CfytHgJmuiT5kZvhLSoIFdU/6C/Mhr7N4JozuJA==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by DB8PR07MB6284.eurprd07.prod.outlook.com (2603:10a6:10:131::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 10:35:41 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%3]) with mapi id 15.20.8466.028; Mon, 3 Mar 2025
 10:35:41 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Topic: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Index: Ads2njIfwP+JWslVRxGz+DAgijI5nRTcDrYAAAmU4YAAAIn8gAB78Urg
Date: Mon, 3 Mar 2025 10:35:41 +0000
Message-ID:
 <PA4PR07MB8838D3064B113BA7925ED5BAFDC92@PA4PR07MB8838.eurprd07.prod.outlook.com>
References:
 <CAL_JsqLzic6b_Bnwf9EOJvsb-HjXnu46czqGntwZyh6M4jZ9pA@mail.gmail.com>
 <20250228231717.GA79086@bhelgaas>
In-Reply-To: <20250228231717.GA79086@bhelgaas>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|DB8PR07MB6284:EE_
x-ms-office365-filtering-correlation-id: 3954041c-c0bd-4d4c-e8eb-08dd5a3f256c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUZ0d1p2emtvVm5Celh1TXJyeSsyelVIbFQ4c3I5YkNXTVMxUEJvMnVNQmxm?=
 =?utf-8?B?enYwdFVYY0E2OGFVbWVSN204VEkwTXVhWFFsekVCajl2K1pBUEJlQUtacGR3?=
 =?utf-8?B?aFJ6M0NFK20rZlFPb2ZTbTBpM3NVMUQwOG9CQW9JdlVBN1B5cFR3M2xwalNY?=
 =?utf-8?B?UUhvd1RQSXZQSUNpaWgwNjJCTGt4dytnYUJES2N4UnluUFIrZWZBM1F2ZlVn?=
 =?utf-8?B?SmUrTUFMcG83MUFyNXl2UFlhN292SXIvUmxqZ0UvckN1MjRKRnJCMmpGeUt3?=
 =?utf-8?B?dUsyZ3lBV0xhaURQVW9KODVOQzMwZkVscXdZb25ELytwOXJKaUttTnZIbWc5?=
 =?utf-8?B?Rm1TdWV2VWVENkppSGhHc0dnMVkxOHd1SzBVMzBEaU05WEpoaGxqcEY4ZTJQ?=
 =?utf-8?B?T2J6QU1CMHBtOFpaUk9jSjNrMmx1aVpBTEhyNnVlb1JtS3prd2laTTh5UXJK?=
 =?utf-8?B?dktMN1pHbHROTFF5dktqZjJIUUlKSU90K2kyOU9tV1pkUy8weHdxY0M2Rzky?=
 =?utf-8?B?RnhlRXZwVjhZSDBBU2pqRzBDWTlWcUJZbFlYN3pvQzczR2JwTDJUL3hJSUgw?=
 =?utf-8?B?U0txRjZDTWdvOGdRS2w2NDhXYUVqTmZ2anJGSXN1bm9sMVlsNUFuaTAybnNk?=
 =?utf-8?B?TWNLYUwwOUFISWl2M3hRZnlBTERvOXBUV21JYnFvTXhnUGxIeVU2SFVqamxW?=
 =?utf-8?B?ZHBOem1Tb29pQ0c3VzcwM0lSbEtZSDdxNGtDazBqSmtyQkRDQWs1MVlQYzVW?=
 =?utf-8?B?cnJVSTljME9LcTNGWHF6ektEZGxteHFMY25qNTk5N1gyRklNbndVeGpTVkNU?=
 =?utf-8?B?ZGR3MXRmRTFpYkVBYU9veFpuNHYwNXQ5U2NhdkVQUStiS1RubXlTVHJmSXh4?=
 =?utf-8?B?b3BoVEpkNytTWmlySXM1dEx6UERrMlRKWm84Wm9iQnhidFBVaUpId25KbUxX?=
 =?utf-8?B?VXQ5cGdsUkNqZUUxVFFjQlJ0UjlFb3dXcG85MFZtUklZdUR5TXhtMWZQOGxR?=
 =?utf-8?B?dXQ4Z2tkUGN1d1ZJVWlseTRlZHFDRDVtT3F6UEdxbEJnSWZLT3pLSFpoSVUw?=
 =?utf-8?B?OVRYMW0rOXZqbXc5ZUZFSWN5L0ZLeEdCeENrUEMwVW5WSnh4VzMvUWdBbEVs?=
 =?utf-8?B?S0cvZDc4anhlLzJqbldSeHZpVXVYTVlILytTUmw3WFVnWWxZa0VpeEFJZUFR?=
 =?utf-8?B?MlA5Zmloc3hxMExDajg3ZUdaM2ZiUlBybzNKS1dabGtPdXhkWG92SWRDWmRR?=
 =?utf-8?B?aXhKcnZ6T1k2Y0tHdmxTUFdUaHhidiswTXU4RnNYTStMMmIxUnJHOFdrYnBV?=
 =?utf-8?B?S0xhLzFkUHpNcnhFOHRhNDFiWkgzSnJCYTR5ZFAyMXRMQzRQL25ncTRPRXhE?=
 =?utf-8?B?U25pZVU5STVSUkwzM0xTNGZadVdJQU52K1RjcGFtZG5GVlAvdnNpTDI2bzhn?=
 =?utf-8?B?OXc1TExHdWFqY01zV0hOd3piaW9udC9hK0dhUUVlc1l4OFQ1Qml3NG9BMHlZ?=
 =?utf-8?B?N1BnckVYVTRSOWd1YXpIUVJhTUVuQ2QyL0xuYzlIR0grdHNzREdESVFQSFdP?=
 =?utf-8?B?MFFlbXBwalRMSUMyeGJQZ1ZRb0IxWkFvYk9IQWpTMVVoMzkvOS9LN2w0bmta?=
 =?utf-8?B?SXBCbEJmZTRaMG5RUmkrTUxuQVA0ZzJEZ3d3L0x6S0MxOWYrRzJvUXZtZ3hQ?=
 =?utf-8?B?aGY5cWdEU3BHM0c5aWtQLzdjZUZ0TkxGemVHdjFTVy9WUGpyUkJwZ0dvTGR0?=
 =?utf-8?B?VmYwc21hSWxMNldhVWgwSk9JaTc0S01Uck5WaUYxYVFsd0FlUzJsbWRQMUFy?=
 =?utf-8?B?OG94aWJLOGQvRXc4QU8xeDMrdjV5amQybXhPZUxzY2gyMWVRNEF4TC84L0Ja?=
 =?utf-8?B?T28xY1orNG9FWGs0NGdmNnR4WDRrcUVXVkZ5TnJJVEFLUU5zK0JUelM1V0sx?=
 =?utf-8?Q?Cq0JodPbI4L+Bp6UArYVzMvk/BIfWUBB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0hJa1ZpWWtOUVN6Zjh5MjFIYnR6cnppSGtZL2Fobk5uUS9UZVcrcWN5QXRJ?=
 =?utf-8?B?NU9xNEdMZTlvOHRIL25lUmx4SnNNaFdWZ0VhdVZoUUpmWmFFeDloS1dPaWJ1?=
 =?utf-8?B?UGI4ekNVbmxJNEw5amxXWHhzYW8rQUVZMTk1R2w3dC9zY0xjMUhYRmd6UFNj?=
 =?utf-8?B?WkZ3OS8wdGxtSGpqM3RkaW54cExmZGNPSzVzOGRQODBnRmZkMFVyYStUVnhD?=
 =?utf-8?B?VzFxVkJIZHYyeE1RazNTM1puK1VHU29LRWVHajlrRWVFeldHZ3dwc2w3RDNm?=
 =?utf-8?B?SjVheWhQOGhVL3dvR2REUGNtWURQVXpJM0M2dk54ZHdvV2IycHk3ZTlWbFF6?=
 =?utf-8?B?bUxLUzduV2sxRzdwdUxDemRPckUrTHpnREVhQnRoL3BJdFlQMFlJWlVCaHMz?=
 =?utf-8?B?R2hJeURGYWZEUmtsUnlEbFQ2ODRuYllKcUhLZ2FHS1dzQXI5dHRvRVpacVNm?=
 =?utf-8?B?QWNLMUtGak16OE1FcDVMMlhKbEFWNGFWN0pzUEJuWURNdy9VTWRVWXpGSlpo?=
 =?utf-8?B?dlhHSjk3TUJraTNUb3hGbnl1VUhoMmdPZ1E0Rk5hbndIejFxS1NaaEZSTUpa?=
 =?utf-8?B?dy9qamVmY3VPMFM2QjhJVjE0b2VPUVorcE0ra1RRUndVSWMxTlRzNE80UFBD?=
 =?utf-8?B?YlFwSkp2cmJtOE94UHh6TTRlM3U1d1lrMmRjTVg4MUErb2IxSXNURVl1VzFu?=
 =?utf-8?B?Q0VNTTRnVDJaWktUOVQzR2cxNzBEc1duMFlrMU9Talp4OHZLSTYyNkZZR1Rx?=
 =?utf-8?B?MWxlT3ZSNGpFWldGc0RvTUY4UG82ZU1URHAxSDVCbTg3U3dEWFNvOVVLSEhL?=
 =?utf-8?B?dDFlN0YzL1ErOGNIV3JDakUvM00vZzhGT2NJcHlsdGc0ck1wT2lobHpBckxS?=
 =?utf-8?B?WHNHbGQ4dHZXT09KMFp4L3dvbEdacldIUW5HOXZ4RnFRREJFb3RKYlJOMWJX?=
 =?utf-8?B?RTRYTkNRaVNwOXk3SUQ2ODRWbXplL1pOdGxxZE9wYXQ4T3loLzdRZjBYK3Q4?=
 =?utf-8?B?b3AxOU42QjNIRUEvclhtVWgwTnI0bHBzVXd5RnhTcGFCUG5VK3MvRVJ6UzZB?=
 =?utf-8?B?N3ZCVVdmK2ZIcVZuR01LbFVsQk1Wdm1XTHVndkloUW9CMDMzcHhaSjZTdm5P?=
 =?utf-8?B?RkhJcmk2czJWWWVMVHowVTc0UGw1QXJHMktITWw1eW5QeWVBU0JqUFMxbVdk?=
 =?utf-8?B?dVhTQjZ0WHo3dU9vbUpHWmpOYU8rbU5pNkxCR3lnK21XNVlYT0NRRTBOeXVW?=
 =?utf-8?B?QUtPaXNDSEI0WGlJOFpHblJVY0RMeXk2UTQ0VnhYaVBDMEtJYTRhRnFvQUh1?=
 =?utf-8?B?TmZJUlRwd2xZUU96Yi9nT3h3RW5YRjFLRGdLZkVwUThTL1YyT0VtMzlmUFBQ?=
 =?utf-8?B?MUp3TkF0RjFGdTdKbUx3TVZVbDJXT2I4UkNqdk1OTzlaL1g4M0JBSHNoSHNF?=
 =?utf-8?B?bWEwdmpGa1pTQk83TmNnUlpSNnpVcVdFajhsRUpZMUJURjBrc0RuSEpvR1Fj?=
 =?utf-8?B?SGlKMkdhUEYzb3ZlM2RwWk5taUIzdXhYT296cHdtUVkwcERtRDRHTHRpRUhM?=
 =?utf-8?B?eTBKQWRMTHU3R0tFWjVmQ2cvZWxjQnRjRUtIWTYwTnR3Zlo3WDlJbkF2OCtk?=
 =?utf-8?B?NW5TaGFRM2h3Si9PSG1oUXd2d2xqb0t5dGVQNDZPWld0Qmw5TU4vdFF2UGJN?=
 =?utf-8?B?Qys0OEU3Y0dmZk1LQ3dTYlVTbWVNNVpIaTBaVjE0M2xJWXZ5NWNzbjZHS0RF?=
 =?utf-8?B?Tmp1eHNZN2VLYWVwa0lnQ2dGY0tWVURwM1huUWF0SUZJQjZJLzJTMXpvd0di?=
 =?utf-8?B?NnFkMFRmdU9QMVJIcEdxWmdVRVJCNUZsRGorNXpmZVgwZDBUZm1sTDlEbnpp?=
 =?utf-8?B?eGdvaFJmbFVvZzN3N1RlamtQMHAxOEFWRmlOZXNpZHdXTFpkdElJOHJoV0ZY?=
 =?utf-8?B?V2xta3BuMVBCalhsdWUraHgyb2ZldnZoL2wwbDdydXdIUzVGRFFwWkdoZEJ0?=
 =?utf-8?B?ZlVFejR6alVTSVlwSEordUJjRTg3aWZQS0JXZTkxdkdsUmtpWGliQW8xdzFV?=
 =?utf-8?B?eEJMNXVobWpQcVRWRFZtVW0xMm8rc2l2ZG92MnZDL2JGS3BHTUpFa0REZ1RD?=
 =?utf-8?Q?J9U/0egpajOD0cAeDwUNOeb+j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954041c-c0bd-4d4c-e8eb-08dd5a3f256c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:35:41.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dD55WpjK1wV1A/y+VuD+bAWYfvnGg50G7jZmbs/DfxCwTNlw4+NKWtpgCAtiuVC416xoEkN3+ajQuEwtq55jOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6284

PiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCAwNTowMTo1MVBNIC0wNjAwLCBSb2IgSGVycmluZyB3
cm90ZToNCj4gPiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCAxMjoyN+KAr1BNIEJqb3JuIEhlbGdh
YXMgPGhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE5vdiAxNCwgMjAy
NCBhdCAwMjowNTowOFBNICswMDAwLCBXYW5uZXMgQm91d2VuIChOb2tpYSkNCj4gd3JvdGU6DQo+
ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIFBDSTogb2Y6IGF2b2lkIHdhcm5pbmcgZm9yIDQg
R2lCDQo+ID4gPiA+IG5vbi1wcmVmZXRjaGFibGUgd2luZG93cy4NCj4gPiA+ID4NCj4gPiA+ID4g
QWNjb3JkaW5nIHRvIHRoZSBQQ0llIHNwZWMsIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5IHN1cHBv
cnRzIG9ubHkNCj4gPiA+ID4gMzItYml0IEJBUiByZWdpc3RlcnMgYW5kIGFyZSBoZW5jZSBsaW1p
dGVkIHRvIDQgR2lCLiBJbiB0aGUga2VybmVsDQo+ID4gPiA+IHRoZXJlIGlzIGEgY2hlY2sgdGhh
dCBwcmludHMgYSB3YXJuaW5nIGlmIGEgbm9uLXByZWZldGNoYWJsZQ0KPiA+ID4gPiByZXNvdXJj
ZSBleGNlZWRzIHRoZSAzMi1iaXQgbGltaXQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgY2hlY2sg
aG93ZXZlciBwcmludHMgYSB3YXJuaW5nIHdoZW4gYSA0IEdpQiB3aW5kb3cgb24gdGhlDQo+ID4g
PiA+IGhvc3QgYnJpZGdlIGlzIHVzZWQuIFRoaXMgaXMgcGVyZmVjdGx5IHBvc3NpYmxlIGFjY29y
ZGluZyB0byB0aGUNCj4gPiA+ID4gUENJZSBzcGVjLCBzbyBpbiBteSBvcGluaW9uIHRoZSB3YXJu
aW5nIGlzIGEgYml0IHRvbyBzdHJpY3QuIFRoaXMNCj4gPiA+ID4gY2hhbmdlc2V0IHN1YnRyYWN0
cyAxIGZyb20gdGhlIHJlc291cmNlX3NpemUgdG8gYXZvaWQgcHJpbnRpbmcgYQ0KPiA+ID4gPiB3
YXJuaW5nIGluIHRoZSBjYXNlIG9mIGEgNCBHaUIgbm9uLXByZWZldGNoYWJsZSB3aW5kb3cuDQo+
ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbm5lcyBCb3V3ZW4gPHdhbm5lcy5ib3V3
ZW5Abm9raWEuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL29mLmMgfCAy
ICstDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL29mLmMgYi9kcml2
ZXJzL3BjaS9vZi5jIGluZGV4DQo+ID4gPiA+IGRhY2VhM2ZjNTEyOC4uY2NiYjFmMWMyMjEyIDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9vZi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL29mLmMNCj4gPiA+ID4gQEAgLTYyMiw3ICs2MjIsNyBAQCBzdGF0aWMgaW50IHBjaV9w
YXJzZV9yZXF1ZXN0X29mX3BjaV9yYW5nZXMoc3RydWN0DQo+IGRldmljZSAqZGV2LA0KPiA+ID4g
PiAgICAgICAgICAgICByZXNfdmFsaWQgfD0gIShyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9QUkVG
RVRDSCk7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgIGlmICghKHJlcy0+ZmxhZ3MgJiBJ
T1JFU09VUkNFX1BSRUZFVENIKSkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGlmICh1cHBlcl8z
Ml9iaXRzKHJlc291cmNlX3NpemUocmVzKSkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAo
dXBwZXJfMzJfYml0cyhyZXNvdXJjZV9zaXplKHJlcykgLSAxKSkNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICBkZXZfd2FybihkZXYsICJNZW1vcnkgcmVzb3VyY2Ugc2l6ZSBleGNlZWRzDQo+
ID4gPiA+IG1heCBmb3IgMzIgYml0c1xuIik7DQo+ID4gPg0KPiA+ID4gSSBndWVzcyB0aGlzIHJl
bGllcyBvbiB0aGUgZmFjdCB0aGF0IEJBUnMgbXVzdCBiZSBhIHBvd2VyIG9mIHR3byBpbg0KPiA+
ID4gc2l6ZSwgcmlnaHQ/ICBTbyBhbnl0aGluZyB3aGVyZSB0aGUgdXBwZXIgMzIgYml0cyBvZiB0
aGUgc2l6ZSBhcmUNCj4gPiA+IG5vbi16ZXJvIGlzIGVpdGhlciAweDFfMDAwMF8wMDAwICg0R2lC
IHdpbmRvdyB0aGF0IHdlIHNob3VsZG4ndCB3YXJuDQo+ID4gPiBhYm91dCksIG9yIDB4Ml8wMDAw
XzAwMDAgb3IgYmlnZ2VyICh3aGVyZSB3ZSAqZG8qIHdhbnQgdG8gd2FybiBhYm91dA0KPiA+ID4g
aXQpLg0KPiA+ID4NCj4gPiA+IEJ1dCBpdCBsb29rcyBsaWtlIHRoaXMgaXMgdXNlZCBmb3IgaG9z
dCBicmlkZ2UgcmVzb3VyY2VzLCB3aGljaCBhcmUNCj4gPiA+IHdpbmRvd3MsIG5vdCBCQVJzLCBz
byB0aGV5IGRvbid0IGhhdmUgdG8gYmUgYSBwb3dlciBvZiB0d28gc2l6ZS4gIEENCj4gPiA+IHdp
bmRvdyBvZiBzaXplIDB4MV84MDAwXzAwMDAgaXMgcGVyZmVjdGx5IGxlZ2FsIGFuZCB3b3VsZCBm
aXQgdGhlDQo+ID4gPiBjcml0ZXJpYSBmb3IgdGhpcyB3YXJuaW5nLCBidXQgdGhpcyBwYXRjaCB3
b3VsZCB0dXJuIG9mZiB0aGUgd2FybmluZy4NCj4gPg0KPiA+IDB4MV84MDAwXzAwMDAgLSAxID0g
MHgxXzdmZmZfZmZmZg0KPiA+DQo+ID4gU28gdGhhdCB3b3VsZCBzdGlsbCB3b3JrLiBNYXliZSB5
b3UgcmVhZCBpdCBhcyB0aGUgc3VidHJhY3QgYmVpbmcNCj4gPiBhZnRlciB1cHBlcl8zMl9iaXRz
KCk/DQo+IA0KPiBSaWdodCwgc29ycnkuICBJIGd1ZXNzIGEgYmV0dGVyIGV4YW1wbGUgd291bGQg
YmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+ICAgW21lbSAweDIwMDBfMDAwMC0weDIxZmZf
ZmZmZl0gLT4gW3BjaSAweDBfZmYwMF8wMDAwLTB4MV8wMGZmX2ZmZmZdDQo+IA0KPiB3aGVyZSB0
aGUgc2l6ZSBpcyBvbmx5IDB4MDIwMF8wMDAwLCBzbyB3ZSB3b3VsZG4ndCB3YXJuIGFib3V0IGl0
LCBidXQgaGFsZiBvZg0KPiB0aGUgd2luZG93IGlzIGFib3ZlIDRHIG9uIFBDSS4NCj4gDQo+ID4g
PiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoaXMgd2FybmluZyBpbiB0aGUgZmlyc3QgcGxh
Y2UsIHRob3VnaC4NCj4gPiA+IEl0IHdhcyBhZGRlZCBieSBmZWRlODUyNmNjNDggKCJQQ0k6IG9m
OiBXYXJuIGlmIG5vbi1wcmVmZXRjaGFibGUNCj4gPiA+IG1lbW9yeSBhcGVydHVyZSBzaXplIGlz
ID4gMzItYml0IikuICBCdXQgSSB0aGluayB0aGUgcmVhbCBpc3N1ZQ0KPiA+ID4gd291bGQgYmUg
cmVsYXRlZCB0byB0aGUgaGlnaGVzdCBhZGRyZXNzLCBub3QgdGhlIHNpemUuICBGb3IgZXhhbXBs
ZSwNCj4gPiA+IGFuIGFwZXJ0dXJlIG9mIDB4MF9jMDAwXzAwMDAgLSAweDFfNDAwMF8wMDAwIGlz
IG9ubHkgMHg4MDAwXzAwMDAgaW4NCj4gPiA+IHNpemUsIGJ1dCB0aGUgdXBwZXIgaGFsZiBvZiBp
dCBpdCB3b3VsZCBiZSBpbnZhbGlkIGZvcg0KPiA+ID4gbm9uLXByZWZldGNoYWJsZSAzMi1iaXQg
QkFScy4NCj4gPg0KPiA+IEFyZSB3ZSB0YWxraW5nIENQVSBhZGRyZXNzZXMgb3IgUENJIGFkZHJl
c3Nlcz8gRm9yIENQVSBhZGRyZXNzZXMsIGl0DQo+ID4gd291bGQgYmUgcGVyZmVjdGx5IGZpbmUg
dG8gYmUgYWJvdmUgNEcgYXMgbG9uZyBhcyBQQ0kgYWRkcmVzc2VzIGFyZQ0KPiA+IGJlbG93IDRH
LCByaWdodD8NCj4gDQo+IFllcywgQ1BVIGFkZHJlc3NlcyBjYW4gYmUgYWJvdmUgNEc7IGFsbCB0
aGF0IG1hdHRlcnMgZm9yIHRoaXMgaXMgdGhlIFBDSSBhZGRyZXNzLg0KPiANCj4gSSB0aGluayB3
aGF0J3MgaW1wb3J0YW50IGlzIHRoZSBsYXJnZXN0IFBDSSBhZGRyZXNzIGluIHRoZSB3aW5kb3cs
IG5vdCB0aGUgc2l6ZS4NCg0KSSBhZ3JlZS4gVGhlIGNoZWNrIGlzIEkgYmVsaWV2ZSBpbiBwbGFj
ZSB0byBtYWtlIHN1cmUgdGhlIGhvc3QgYnJpZGdlIG5vbi1wcmVmZXRjaGFibGUNCndpbmRvdyBk
b2VzIG5vdCBleGNlZWQgdGhlIDQgR2lCIGJvdW5kYXJ5LiBUaGlzIGlzIG5vdCBwb3NzaWJsZSBk
dWUgdG8gdGhlIHJlZ2lzdGVyDQptYXAgb2YgUENJZSBjb25maWd1cmF0aW9uIHNwYWNlIHR5cGUg
MSAocmVnaXN0ZXIgMHgyMCkuIEkgZ3Vlc3MgdGhlIGNoZWNrIHdvdWxkIGJlIG1vcmUNCmNvcnJl
Y3QgaWYgd2UganVzdCBjaGVjayB0aGUgZW5kIGFkZHJlc3Mgb2YgdGhlIHJlc291cmNlIGluc3Rl
YWQgb2YgdGhlIHNpemU/IFNvbWV0aGluZw0KbGlrZSB0aGlzPw0KDQpAQCAtNjIyLDcgKzYyMiw3
IEBAIHN0YXRpYyBpbnQgcGNpX3BhcnNlX3JlcXVlc3Rfb2ZfcGNpX3JhbmdlcyhzdHJ1Y3QgZGV2
aWNlICpkZXYsDQogICAgICAgICAgICByZXNfdmFsaWQgfD0gIShyZXMtPmZsYWdzICYgSU9SRVNP
VVJDRV9QUkVGRVRDSCk7DQoNCiAgICAgICAgICAgIGlmICghKHJlcy0+ZmxhZ3MgJiBJT1JFU09V
UkNFX1BSRUZFVENIKSkNCi0gICAgICAgICAgICAgICBpZiAodXBwZXJfMzJfYml0cyhyZXNvdXJj
ZV9zaXplKHJlcykpKQ0KKyAgICAgICAgICAgICAgIGlmICh1cHBlcl8zMl9iaXRzKHJlcy0+ZW5k
KSkNCiAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiTWVtb3J5IHJlc291cmNlIHNp
emUgZXhjZWVkcyBtYXggZm9yIDMyIGJpdHNcbiIpOw0KDQogICAgICAgICAgICBicmVhazsNCg0K

