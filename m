Return-Path: <linux-pci+bounces-28253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5EAAC01F1
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 03:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28501B61C9A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D01EA84;
	Thu, 22 May 2025 01:56:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97118EAB
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878974; cv=fail; b=l7ShDHvM+X3ySHykm7H40kf8EIyzmnje5TWXc49G4GzH92iDqfF4PFNiyNI59deivlbx6F1c7BWmxsMG/Q0RGO2cqshLajFR/eQZqW8yK/8yo9DZWSYANzSwnreAfpQFhUjjCUZm7CzT+gM5tj6jX0FOKIou7A85AxhSxZ3JetA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878974; c=relaxed/simple;
	bh=eDTfg9q+6KisAleiQctZNgqSc+p3UBdIsR0FjKHlTpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G7/EcZm1dcIaH3sa0nganTj7DJ2RLdGsaR5jyD8uqmhWgpxrlz8CI1PMnSsbvf+eAEMrrsHpaToIcwkj8qQQXAjSOzR1TMBWEIkOZzTZzEf8d2Dzp1XxTQAouTC+zRTmpANc/zguh/sv8VC7A+IE2jzmSIjTPdfjbnIlqtln23Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT+u8kmRjWEBwuqz/REQKftewThjeYr//mwoH4RhAGAqzTwbpO6v4L0IR7VblUl1CNLHxsQw2aNqAlHM2uinIYwfSnZkGVXhBRtuHmIJTt6spN58uZbT6vpNrvNiyHTVd08fXpDo99QD3tYG7OdEeAgUyODGIG844gaR7hPITXpwjCBJEmFp7kKy0dUTN00tQPzZAdDObwlJ/BrjWg9BXuf9YY2h37cF6Ak//70IDUh2Ul914j2x0BkyocGSewCt32oscnHTDOaE+v1ydY+0SqJIa/x13fNMhHlZBLsp+mntuzniCY+n5zcZSR0CpoIeR+0rlN/rXW3c1Ygk5n904w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDTfg9q+6KisAleiQctZNgqSc+p3UBdIsR0FjKHlTpw=;
 b=W+EwRqZWSOGWGeYuzRQmnqC6f/DH+J3X1s0nDg3LkVEMzmB22QTCNAMtemiUhdP0B3SWPDiaHEMYc5lFZxVTUz+/xd/xlThe0AEFhSHCkBOoK8LuY9pP+ydAxpkA+shgB6Blm+C9WTaXqpyAk3KvfDXy/MgOOwieDTHtl+3Mubg7fq99ynFU1Mggx0WPKIFl9sqRYjTAueFE2+d8aXppViUM9504X1388Z64Pzl6CAEMQanGRSx3nLq4o27BogaXpH7ghAtrbMtUgXSac0z+vnWF3H40Ia+S2B3eCONPanHRNtwpM7dKfpBXejv64S5qh1f3dcn03xgf6BMqW6nD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 (2603:1096:820:87::13) by KL1PR0601MB5725.apcprd06.prod.outlook.com
 (2603:1096:820:bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Thu, 22 May
 2025 01:56:06 +0000
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462]) by KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 01:56:06 +0000
From: Hans Zhang <hans.zhang@cixtech.com>
To: "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
	<linux-pci@vger.kernel.org>
CC: Hans Zhang <18255117159@163.com>
Subject:
 =?utf-8?B?6L2s5Y+ROiBbdGlwOiBpcnEvbXNpXSBQQ0kvTVNJOiBVc2UgYm9vbCBmb3Ig?=
 =?utf-8?Q?MSI_enable_state_tracking?=
Thread-Topic: [tip: irq/msi] PCI/MSI: Use bool for MSI enable state tracking
Thread-Index: AQHbyofhgPOAfDL140GSoMPk5RRYj7Pd4/bg
Date: Thu, 22 May 2025 01:56:06 +0000
Message-ID:
 <KL1PR0601MB4726D1314F571FF49149E41E9D99A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
References: <20250516165223.125083-2-18255117159@163.com>
 <174785627988.406.2996126912434384302.tip-bot2@tip-bot2>
In-Reply-To: <174785627988.406.2996126912434384302.tip-bot2@tip-bot2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4726:EE_|KL1PR0601MB5725:EE_
x-ms-office365-filtering-correlation-id: 6f3587bd-d708-4f01-8e92-08dd98d3d0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWRwcWFlMTJjcHB1cnc5RWo0RnZIOHhPTkRtVS9sVVpJVjZlQzhkZXYvU3I5?=
 =?utf-8?B?R2lua0NPa1dwbUJFd1N5aGZXcnpmbkZ2Tm4xNHQ3UW4zUCtZbXlqMHJMM3VS?=
 =?utf-8?B?OW51c2RHM2t6ZWN4ZXJkdGxjMVVDTFJTaEVVY2hrYmc5SWxuTkZaTC92WVV3?=
 =?utf-8?B?L0hnVkg4YXBIRnI1M3R5RHI2SWNCY1dKM2FoNTU1TVlldm9pNk45Q3N6SDZ0?=
 =?utf-8?B?M1VsMmdoSkFXS3NWd3RJRm16VXRJSW1SbjlWblNLUzBaOGJHVHd1OTF2a29y?=
 =?utf-8?B?Wm5Zb1l4RkVCeU44bjArUkcwY094YTZyTnBqaEcrQ1JJblVJV0QwRmpwUndt?=
 =?utf-8?B?Qi9QVXlxZEQzN3BmWmNWZ0QwaTV1R05WSjNlT3dSRXBsYm50WDdEQ0dLOFM0?=
 =?utf-8?B?Nkl4RkkyN29Xem9wM1dVWWFmbmRsVmFhVkV3ZHJxMjlUSkJSTlVQRDNaN25q?=
 =?utf-8?B?U2JhL0t6dDc0b1NsQjNNeTZWM2RvbDc0MFJYdFVZZlQ4TkxDbHhTTDIySVNB?=
 =?utf-8?B?SXg5ZVdJbnVwMTF4MU1vOEZ1alVqejJyN2NZandnUFFBbitPVUdjTnJGU3lE?=
 =?utf-8?B?ZHZwQ0tZaWI4c0toR0poMmM1dmVlWmlSYWpTQ0NCOXlISFRxdWxQejkyZ2px?=
 =?utf-8?B?WklxWFdqempqa2lmd2xuTTA5WHU0UUFZbTN5eisybDNFWCttTUZzNURxNjVt?=
 =?utf-8?B?VkZTRXZjK3JNOHJyMTgwaWN5aXpVaW5NeCt0M1R2a1VzdDlzYm1LWmZodUN2?=
 =?utf-8?B?OE9NVWdUY3E5T3dTNStiTTBEeEdSQ21wODN4ejlrWDg5NHdPOUNtbDdwak5t?=
 =?utf-8?B?T29TLzRiL0wycFZPbmltNFNZUDUwME5GcVg2T0ZPa3VkUWIvVkluclF0VFp3?=
 =?utf-8?B?emVqc1ZIcUFSRTRWMkVIakx2UUtjekp3Ni9KREVIUmRIbjg2Y0VOSVdiU245?=
 =?utf-8?B?aHZLdTZGcldyTkd0MW84TVVQTy9mUXB2cGNNQzVOZGVYeWlwT0FvNkZyMzUz?=
 =?utf-8?B?NS9qbnNlTEJibi9KdmdSSXRpeWxYeVozczJidkdWaHhOSW9CRnJVeE9zMFJp?=
 =?utf-8?B?OXlmU283bWc3cEpvQ2lwSUxWRzd5TWJnNmNsQmhCczFVcm9CZ3JjYnBxYVFP?=
 =?utf-8?B?ZDUvTTZ3Umh6YndNRkh5MzJsci9nWmxDUVNueHNvQjlyZFlZT0VoYzhCWEJC?=
 =?utf-8?B?RGdxa3gvbThMZFNtUEFNKzg1SURrRWxzdlJBc1ZNVVNsTTY2ZXBhcmNrb0Vr?=
 =?utf-8?B?OG5mM1lKV1hJQ1NvTXdLZWNSMmt0TC9DdmpSTWRCaGF6cmlJaVhaSEtaUjJV?=
 =?utf-8?B?VTQ0YjRWdWx1a1pRSm9ZL2xZandxVnhjOTVSZEZrMDFES0p4ekxEY1lhbEM2?=
 =?utf-8?B?ZzR2N2xZVWV3eW8zYWh3c3M2YXdxa1RuUGZPOFpVcWJjZkNYYXJ4UWh0Wm9u?=
 =?utf-8?B?VmFTaGI1QlgyLzlKMGVhMzZROXVyQXdsZ2xpQUhtMVh6VU5OdEVOcENFNStZ?=
 =?utf-8?B?MjB6czk4ZE52S0ZidWFta0dlRFBiUlVtWHUxSVBjVlBVSHhhQlR4VnY0azU1?=
 =?utf-8?B?akNZRjJuaFJoVHR0WmdRQVg2Nk1GQ0tQMy84VFVxY3lkMHp6UWhTalQwbkw1?=
 =?utf-8?B?L0Fxd1ZCZHhJdFMxY3JoRGZ0TG5qY3pDSnJPUmVMeVp5VU1nNFBwSGQ1amJu?=
 =?utf-8?B?dC8wVktoN2N2UElnQ20vS3UzbnRPVmJHdGhpdFRUdGxOeENNL0dUTkRtNXV2?=
 =?utf-8?B?bXQyd2lQMEJ1UDVUcVd2WVlSczhPbzVaRlVoV3dvZ1hkYVBZTHl5SFBISGpU?=
 =?utf-8?B?RHlSMmE2TGN1RFpyRDEvSWhGY2wwSWEwMWtQazZFMWFNTHl4SjBuL3lSTUlv?=
 =?utf-8?B?Uy9kQW8wUXZteFhQK2xkb1AwQ3FrbzJ3L3hSV0ZvRWN4SVVUWEtCMzA3aHJC?=
 =?utf-8?Q?K6qT+roPyMs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4726.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3IzNmVCSzlUK09pNThCb2JUV0VrVVQ4bFpoNGx2Y2tsM1NaVlVkR0hPTHZn?=
 =?utf-8?B?OGVqOFRxRWtqeHk1NUhDeWJIZG9UOEtDcVhKTkFLd2xwUnBsb3NjdkZaclpu?=
 =?utf-8?B?djQ3T2x5WGdIWWVlZE03enVnQmorclAwK3huTmhSWm12QXJXeWUrYWc1U3pG?=
 =?utf-8?B?d3VDZURyVmR5T3kyc0F6TEFVeDViR1dEa1hGNlovTWpiSkRKaE9aVHJDS0V6?=
 =?utf-8?B?cFU0SzNKYXJFOUlMcGczZEQzbE1laFNqR0ttOG5NZmdRYnVyc2pFMXdKK2lP?=
 =?utf-8?B?Y3FyTFJHZklhWHNkYmw2alVGTWNSeGlkOWpOOHE2OGVQUDVUWW1ScVpMYXFq?=
 =?utf-8?B?d1UvMFR0YVFRSXdvM2dXQWN6R25QeUhidjFVU2JLd0RIMENJb3lUdlBOQ2R6?=
 =?utf-8?B?TEFBOFJPRnNudmx0RlZhUFBCOERjbmZUMTBWNVE3VHErbTRmY1hWRnYxeWNa?=
 =?utf-8?B?ZmdPcEt5WXJUMzA5aU1KUTE2UUxIQkNkdVNUNHRyUXFnb0JXQTBLZUxHQ2Vl?=
 =?utf-8?B?VVZqQTAvMkQyZ0RQUnVXSGNJR292R3IxdEZ3UXFVL0pFbENJZTE3eVBwS2RO?=
 =?utf-8?B?STlNTjV5aXozVUVDa1FnRXdDMFZqYldLeU1NUE1NY1VZWmFaT0hUN0ZBSlly?=
 =?utf-8?B?eWFPb0VoMldZY2lxNmJ5NlcxR3JzSklFRlNjczVpU2FFamNkZ21aVFFEanJl?=
 =?utf-8?B?WFA5QlUrVTVoMUtXa0ZtUk44b0JHRzJyeWRaNGVXZzhMQ1hEZW5yOUFoNTZu?=
 =?utf-8?B?Zm9ObW5OZ1lBSmN1aW4xN05YTFVLYUZBblBvTVRQVVFseHhLbEJnaCtBaXM0?=
 =?utf-8?B?WVdBSFVncTdQbnBianpuUGVWbkZnY0xoUkdHb0JzT0FaL2Q0WkR6L1Y2NzNq?=
 =?utf-8?B?R20zZUU0MC9pSE9UYXBIYmRKMFFXNjZ6TjNCVkVyYk9wSmw5TjJhK01xTXdZ?=
 =?utf-8?B?WHBNeUY0cEdoSy84WHdNK2ZJeGpad0t5RUFJaU9mOWdGWElZeVFVVFFDdlBZ?=
 =?utf-8?B?NkJsd1FVNXBjL3ZtL2t6V3pPWFNleG9OT1FtbGlhWWQ3QnRtTHNMRmlMSjBH?=
 =?utf-8?B?TXdNOU9jcjMxc3BlUUd4YjNiRndFS0l1YVRzeXBQM3FQLzlUMzc2U0xBdHFS?=
 =?utf-8?B?cXlTdWdJVnZNbTIxSFI3bktUU3JOQXBUNTlKQjg4ZkRBUVhoMnNSUXpXNGhQ?=
 =?utf-8?B?SWNKU3lPZ1RUdzVrMUN5bXdxQTJjQmFvbWtYT0wxWGI0eGhGc0hHNmkrQ0VF?=
 =?utf-8?B?K3N5TExiTDlxMnhNOVJzcnlUR2Q4TFliU0J5bERqR3ZDSnNVVFh6eE1vSTlz?=
 =?utf-8?B?TWhpc0V0VGlNS3ZFVjg2Y21tM2pGUmhiSFhKdU1NZFJuTGgvV2tNekl6VURv?=
 =?utf-8?B?WTZKMXJmWWlnbnpmb3NNOXN3clZOT0llZEZrRHRyWWFaMmtoTnRRdEVpbEg2?=
 =?utf-8?B?ZG9PVVhtT3orc3pCOWlsR0J3ZTRWMlhxTnFPWjdMYk1nRUtQay9uV1gxUEdJ?=
 =?utf-8?B?WlprdTluenZCYk5VditQTGdZQnd3Q2lNdFJpeXRYZDZQanNFdHZpYWYrRjJw?=
 =?utf-8?B?OGJJRGlrMGtzdWNZWjMxSGZtMFFsMUZQbDhxYXltSytSaXYyR2ZXaFV1Sm1T?=
 =?utf-8?B?UXJkL2QzQjU0M0RmZTF2VHhBOVZWbFAwSFZ5N1pxR3lVaEpKa0xRUXMvR3U4?=
 =?utf-8?B?eEdFZkNYeE4vQXVEUTBFVHZpV2wvZCtiZFpSV0lYSXRkZUFKa3Rzdk9RRDRL?=
 =?utf-8?B?UWZvS2F3VExGNlJQeTFjYWprUVdiN00rWW9Ja2xGTXhpQ3d2WWdaTkttcENz?=
 =?utf-8?B?MGEzUk1uTjBxd242bkQ5UXljdTQ3aW1FY1FnSUtBZXh3MHNLVXlDdXJQTDJt?=
 =?utf-8?B?dlJoQkFaTUxOWFZEYUo1MHNEL3JzaUZmTG1TcEtxRUIvVTlrWVB6WjQyTlhv?=
 =?utf-8?B?SnZUZncwRW1oMnlxSmpiQ3dRQU1IeDQ3UkJNb0ZxbVZKeklwekdzcFNQOW5G?=
 =?utf-8?B?K1c4NHZuNytRcGp5OG94cVBMK0V5eEVPZFZaamJqY3hhZHBLVGh5cklzYnBC?=
 =?utf-8?B?UTMvQnRaODcvNVVYb2FCTTFhVG1IR2dlcXNLSVFncEtaeFgrUkwwUXl1cC9a?=
 =?utf-8?Q?CTOUpR5GL5qpyyucsOFbAXYZ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4726.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3587bd-d708-4f01-8e92-08dd98d3d0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 01:56:06.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kK5+PLWA9JVfwrcr+aD6EusycQr5VXaxdq0k1o+MgKRi7rz2EmY6kbGXOd2XopRMb9vW6mkkhAvm1/+yTwUymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5725

Rm9yd2FyZCB0aGUgZW1haWwuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
dGlwLWJvdDJAbGludXRyb25peC5kZSA8dGlwLWJvdDJAbGludXRyb25peC5kZT4gDQrlj5HpgIHm
l7bpl7Q6IDIwMjXlubQ15pyIMjLml6UgMzozOA0K5pS25Lu25Lq6OiBsaW51eC10aXAtY29tbWl0
c0B2Z2VyLmtlcm5lbC5vcmcNCuaKhOmAgTogSGFucyBaaGFuZyA8aGFucy56aGFuZ0BjaXh0ZWNo
LmNvbT47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgeDg2QGtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogW3RpcDogaXJxL21zaV0g
UENJL01TSTogVXNlIGJvb2wgZm9yIE1TSSBlbmFibGUgc3RhdGUgdHJhY2tpbmcNCg0KW1lvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB0aXAtYm90MkBsaW51dHJvbml4LmRlLiBMZWFybiB3
aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklk
ZW50aWZpY2F0aW9uIF0NCg0KRVhURVJOQUwgRU1BSUwNCg0KQ0FVVElPTjogU3VzcGljaW91cyBF
bWFpbCBmcm9tIHVudXN1YWwgZG9tYWluLg0KDQpUaGUgZm9sbG93aW5nIGNvbW1pdCBoYXMgYmVl
biBtZXJnZWQgaW50byB0aGUgaXJxL21zaSBicmFuY2ggb2YgdGlwOg0KDQpDb21taXQtSUQ6ICAg
ICA0ZTdiY2E3NmUzZmVkNTg0MzdkY2Q3Zjc0N2QxYzhkOTg1MDczNzllDQpHaXR3ZWI6ICAgICAg
ICBodHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC80ZTdiY2E3NmUzZmVkNTg0MzdkY2Q3Zjc0N2Qx
YzhkOTg1MDczNzllDQpBdXRob3I6ICAgICAgICBIYW5zIFpoYW5nIDxoYW5zLnpoYW5nQGNpeHRl
Y2guY29tPg0KQXV0aG9yRGF0ZTogICAgU2F0LCAxNyBNYXkgMjAyNSAwMDo1MjoyMiArMDg6MDAN
CkNvbW1pdHRlcjogICAgIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KQ29t
bWl0dGVyRGF0ZTogV2VkLCAyMSBNYXkgMjAyNSAyMToyODo1MyArMDI6MDANCg0KUENJL01TSTog
VXNlIGJvb2wgZm9yIE1TSSBlbmFibGUgc3RhdGUgdHJhY2tpbmcNCg0KQ29udmVydCBwY2lfbXNp
X2VuYWJsZSBhbmQgcGNpX21zaV9lbmFibGVkKCkgdG8gdXNlIGJvb2wgdHlwZSBmb3IgY2xhcml0
eS4NCk5vIGZ1bmN0aW9uYWwgY2hhbmdlcywgb25seSBjb2RlIGNsZWFudXAuDQoNClNpZ25lZC1v
ZmYtYnk6IEhhbnMgWmhhbmcgPGhhbnMuemhhbmdAY2l4dGVjaC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI1MDUxNjE2NTIyMy4xMjUwODMtMi0xODI1NTExNzE1OUAxNjMu
Y29tDQoNCi0tLQ0KIGRyaXZlcnMvcGNpL21zaS9hcGkuYyB8IDIgKy0NCiBkcml2ZXJzL3BjaS9t
c2kvbXNpLmMgfCA0ICsrLS0NCiBkcml2ZXJzL3BjaS9tc2kvbXNpLmggfCAyICstDQogaW5jbHVk
ZS9saW51eC9wY2kuaCAgIHwgNCArKy0tDQogNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9tc2kvYXBpLmMg
Yi9kcml2ZXJzL3BjaS9tc2kvYXBpLmMgaW5kZXggZTY4NjQwMC4uODE4ZDU1ZiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvcGNpL21zaS9hcGkuYw0KKysrIGIvZHJpdmVycy9wY2kvbXNpL2FwaS5jDQpA
QCAtMzk5LDcgKzM5OSw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHBjaV9yZXN0b3JlX21zaV9zdGF0
ZSk7DQogICogUmV0dXJuOiB0cnVlIGlmIE1TSSBoYXMgbm90IGJlZW4gZ2xvYmFsbHkgZGlzYWJs
ZWQgdGhyb3VnaCBBQ1BJIEZBRFQsDQogICogUENJIGJyaWRnZSBxdWlya3MsIG9yIHRoZSAicGNp
PW5vbXNpIiBrZXJuZWwgY29tbWFuZC1saW5lIG9wdGlvbi4NCiAgKi8NCi1pbnQgcGNpX21zaV9l
bmFibGVkKHZvaWQpDQorYm9vbCBwY2lfbXNpX2VuYWJsZWQodm9pZCkNCiB7DQogICAgICAgIHJl
dHVybiBwY2lfbXNpX2VuYWJsZTsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvbXNpL21z
aS5jIGIvZHJpdmVycy9wY2kvbXNpL21zaS5jIGluZGV4IDU5M2JhZTIuLjgwYWM3NjQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BjaS9tc2kvbXNpLmMNCisrKyBiL2RyaXZlcnMvcGNpL21zaS9tc2ku
Yw0KQEAgLTE1LDcgKzE1LDcgQEANCiAjaW5jbHVkZSAiLi4vcGNpLmgiDQogI2luY2x1ZGUgIm1z
aS5oIg0KDQotaW50IHBjaV9tc2lfZW5hYmxlID0gMTsNCitib29sIHBjaV9tc2lfZW5hYmxlID0g
dHJ1ZTsNCg0KIC8qKg0KICAqIHBjaV9tc2lfc3VwcG9ydGVkIC0gY2hlY2sgd2hldGhlciBNU0kg
bWF5IGJlIGVuYWJsZWQgb24gYSBkZXZpY2UgQEAgLTk3MCw1ICs5NzAsNSBAQCBFWFBPUlRfU1lN
Qk9MKG1zaV9kZXNjX3RvX3BjaV9kZXYpOw0KDQogdm9pZCBwY2lfbm9fbXNpKHZvaWQpDQogew0K
LSAgICAgICBwY2lfbXNpX2VuYWJsZSA9IDA7DQorICAgICAgIHBjaV9tc2lfZW5hYmxlID0gZmFs
c2U7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL21zaS9tc2kuaCBiL2RyaXZlcnMvcGNp
L21zaS9tc2kuaCBpbmRleCBlZTUzY2YwLi5mYzcwYjYwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
Y2kvbXNpL21zaS5oDQorKysgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmgNCkBAIC04Nyw3ICs4Nyw3
IEBAIHN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfY29uc3RfXyB1MzIgbXNpX211bHRpX21hc2so
c3RydWN0IG1zaV9kZXNjICpkZXNjKSAgdm9pZCBtc2l4X3ByZXBhcmVfbXNpX2Rlc2Moc3RydWN0
IHBjaV9kZXYgKmRldiwgc3RydWN0IG1zaV9kZXNjICpkZXNjKTsNCg0KIC8qIFN1YnN5c3RlbSB2
YXJpYWJsZXMgKi8NCi1leHRlcm4gaW50IHBjaV9tc2lfZW5hYmxlOw0KK2V4dGVybiBib29sIHBj
aV9tc2lfZW5hYmxlOw0KDQogLyogTVNJIGludGVybmFsIGZ1bmN0aW9ucyBpbnZva2VkIGZyb20g
dGhlIHB1YmxpYyBBUElzICovICB2b2lkIHBjaV9tc2lfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYg
KmRldik7IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9w
Y2kuaCBpbmRleCAwZThlM2ZkLi5mNWU5MDhhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9w
Y2kuaA0KKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KQEAgLTE2NjksNyArMTY2OSw3IEBAIHZv
aWQgcGNpX2Rpc2FibGVfbXNpKHN0cnVjdCBwY2lfZGV2ICpkZXYpOyAgaW50IHBjaV9tc2l4X3Zl
Y19jb3VudChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsgIHZvaWQgcGNpX2Rpc2FibGVfbXNpeChzdHJ1
Y3QgcGNpX2RldiAqZGV2KTsgIHZvaWQgcGNpX3Jlc3RvcmVfbXNpX3N0YXRlKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpOyAtaW50IHBjaV9tc2lfZW5hYmxlZCh2b2lkKTsNCitib29sIHBjaV9tc2lfZW5h
YmxlZCh2b2lkKTsNCiBpbnQgcGNpX2VuYWJsZV9tc2koc3RydWN0IHBjaV9kZXYgKmRldik7ICBp
bnQgcGNpX2VuYWJsZV9tc2l4X3JhbmdlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCBtc2l4
X2VudHJ5ICplbnRyaWVzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbWludmVjLCBp
bnQgbWF4dmVjKTsgQEAgLTE3MDIsNyArMTcwMiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwY2lf
ZGlzYWJsZV9tc2koc3RydWN0IHBjaV9kZXYgKmRldikgeyB9ICBzdGF0aWMgaW5saW5lIGludCBw
Y2lfbXNpeF92ZWNfY291bnQoc3RydWN0IHBjaV9kZXYgKmRldikgeyByZXR1cm4gLUVOT1NZUzsg
fSAgc3RhdGljIGlubGluZSB2b2lkIHBjaV9kaXNhYmxlX21zaXgoc3RydWN0IHBjaV9kZXYgKmRl
dikgeyB9ICBzdGF0aWMgaW5saW5lIHZvaWQgcGNpX3Jlc3RvcmVfbXNpX3N0YXRlKHN0cnVjdCBw
Y2lfZGV2ICpkZXYpIHsgfSAtc3RhdGljIGlubGluZSBpbnQgcGNpX21zaV9lbmFibGVkKHZvaWQp
IHsgcmV0dXJuIDA7IH0NCitzdGF0aWMgaW5saW5lIGJvb2wgcGNpX21zaV9lbmFibGVkKHZvaWQp
IHsgcmV0dXJuIGZhbHNlOyB9DQogc3RhdGljIGlubGluZSBpbnQgcGNpX2VuYWJsZV9tc2koc3Ry
dWN0IHBjaV9kZXYgKmRldikgIHsgcmV0dXJuIC1FTk9TWVM7IH0gIHN0YXRpYyBpbmxpbmUgaW50
IHBjaV9lbmFibGVfbXNpeF9yYW5nZShzdHJ1Y3QgcGNpX2RldiAqZGV2LA0K

