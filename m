Return-Path: <linux-pci+bounces-21575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCCA37AED
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A104B3A5CF5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 05:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF81494CC;
	Mon, 17 Feb 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kbb8SXaH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C907137750;
	Mon, 17 Feb 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770346; cv=fail; b=ptaGE3LUTlKpX3FfThACeGfaq+QjHlL6TB3FknGXG4VgDWJIH/Cr1ObZ5i3XQnNrCINq4FiPPtKqQ9eFXiPJaJ44s6R2uW+vnKc+xABvROXmBGdgzipmjKPmehmpIJtobf3ma5tZlaDsJKU+YIqBQ73FyPQ4WPC1/tjiWn136Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770346; c=relaxed/simple;
	bh=kHKMwky0Gq3v7LOVYzRMuIbwGir4V6QmoJo1fORLsu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hNKSn4Cv/aJRrYY0+ooz6XiUytw6besFrJiV11aOzbBTtsrrVEslwTWJm0sWK2P0a7KJe/GdfzcCrgrauCwi4ljsA1GVwSuiTAdu1Yt1TCaqf5iCvalICz6yAwEw24UFKtGjSYi7R6nojAb7IyTQ1RmgUtuIXLFBxFfQ5iMMfSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kbb8SXaH; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHERDLlUAWzZBVab98Dv68V1V4teH5Vtct1rwh9jIFcQTAz89m9DCrUOIkJ3hYq/EYjDmQm67sCxNl54vB5kad84zjzyviLf/Jkx7+fFSwNLOGhDEQ8HgJtIDeTGGCUerQmHvzXSNwMRlDtHArEhd3+3zzGnFD72PWzUP+0ncVv7qTRRW2DcZc7oJ1Sg0GG1it39dlg4DYuMpgBARJ5OpPBBpmKD7t7WqisvuzlPwj4h5uYFyo8e15pgLFJZ40PsaEhHaTCrwWmaBWzjDrmhvWuQf6GiF/E1WHXJjQbNFr3XvIgUP/uSyqAP7djBDnY00I6La7ePjqxBBGkuSfXv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHKMwky0Gq3v7LOVYzRMuIbwGir4V6QmoJo1fORLsu4=;
 b=dpdTZ5NdulpkwGI9oQXdTtAf0+fT9Frp2rmfmiPudfzAfjJNLSYTLwo+TAWswlbXslNfKOup4Su3rSj3v+Uk0XrTJug7IZ8WpZMVuaJkSWyY3fzijrgkMXMttUkXpatfMNfax0rr4MTKXpSvMtfHKtIIPUlM5qfGepXfOOoklq5+q4EA6ezXNvEkRWPlRsqJ683M/wSUFOWKk1ren6M1dVWjmEBjy1FF5l3IsluqBy+vzpI9idKKGHjsR5W6RvrR9Y5l9w/NufWGO3mA+mBU3DMyTjZNsVBVuzadgpXrkT7PSnx/00x0YS4K6pbAvXSV288ejQUGFInbSwm+cv6FkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHKMwky0Gq3v7LOVYzRMuIbwGir4V6QmoJo1fORLsu4=;
 b=Kbb8SXaHaMXBlx+xTnafrRSHOONzQLV+UdocfmQM4d/7AT5stggJ6DJ7buUXVDNyRKacD7YYq7Y3kChSOdGZWEj+PX6ZiGrQvzCZw4kXNUqHcUuTpvKTw3xWiA7oIAiyC0AIZwLKptr6lHrH31vnSqQ9rMtgDdQr1xb+yXDrNnU=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 05:32:22 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 05:32:22 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5NC Versal Net host
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5NC Versal Net host
Thread-Index: AQHbfRIoteLRuRjrJ0qtTzZXpxn96rNG9NmAgAQLWzA=
Date: Mon, 17 Feb 2025 05:32:22 +0000
Message-ID:
 <SN7PR12MB720119C25A7BFCF280DB95688BFB2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
 <20250212055059.346452-2-thippeswamy.havalige@amd.com>
 <20250214154539.jqbjkms32ew5zpd2@thinkpad>
In-Reply-To: <20250214154539.jqbjkms32ew5zpd2@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA1PR12MB8947:EE_
x-ms-office365-filtering-correlation-id: 5bd3b351-70ce-408a-d09b-08dd4f147411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTYycm41VXRvbVF6UFlyeU9qdlpzM3l1Z2JHT0MrVVpGVUR5QTJ3aS9mR2pM?=
 =?utf-8?B?MlFBbklUUnRuNm5uN1RGYld1anhyVVV1bGE5KzR0amxyQy9qQm5LTlpWc3dI?=
 =?utf-8?B?U0xXbGhRbFpNZGFZU0pPTFE4Z2RpZW5tblV2L2ZSeHczVDZtQ1VtT21RSWRJ?=
 =?utf-8?B?QzRkUmszeFpFQ0Z4R3dJSnMvNmhFTkRyWW9mSklMUjVJWnpib3VsMGZRcHZs?=
 =?utf-8?B?T3hYaTVHRW9VN3JPK01JTzhKcld4N2UxeWZaSHQrRThPZ2YyVjBwQnd2Nmhs?=
 =?utf-8?B?Q1doOWdEL1VGdXFvcGZhdTVTaC9zWkVuN1lmc20vV3BBbms5VlVNQnkvZEhX?=
 =?utf-8?B?cmpBRVB2TEdiN01iZ3h5eHA4RjgzbENwUmNIMi9xMERuOHMwUkJpMVNCQW9l?=
 =?utf-8?B?TUNKbWg1STBEUk5UOWNTWHF5bFM3Ym81TjVTeU9XMGV1KzliTFBRTFcwT213?=
 =?utf-8?B?YkdTc2tZOVRSTW12ZnQvMnU5YVc4YkJTN2VOYXVPV29LOGtUS2Jyazg3emRM?=
 =?utf-8?B?YlRCeTN6aXlodXNTcEZ4Z0pQUWZVYm1BUDJVODlBSytIOGROWDV6WlE4OFNs?=
 =?utf-8?B?RlJJbFNEWnZoeEpocmRyY2h3c3FmcjQ5SG1wNkNVT2JmVnVYSzhrM3ovU1Rj?=
 =?utf-8?B?d2lqSnk4aTdYa09jZC9FRnA0UHFmMHdVaC8rNEk3bjJTM2VFc2gzUXhvOFZV?=
 =?utf-8?B?bmZMYXQrRVRvWVFGQVliS2JEYk9rZFE3S1BLYVRBendqcXhFUjh3eXlHZ1VS?=
 =?utf-8?B?QTR0UHAzNWdLK3FqUGFBT2REU1F2SUtTd1gzQ3ZNem5tUkhwQkJ2azByRndC?=
 =?utf-8?B?cjEzakpxYWFPU0NiRGVHdDQ2MFdoRkRaWG5WZmNBalpQTXFUSWdIYllSajVQ?=
 =?utf-8?B?Q0xpeGcvRkZ6b3crZEZsM2ZSaFhnTDRCVjdwdlhHNjVkZjVhY0gvUThoeDNp?=
 =?utf-8?B?cHYwYjU3NjRhKzJhRlBZV2dFOVhBT1VoUE0xTEFNNExIa3g0dmpZelF3ei95?=
 =?utf-8?B?NXZIT2tGQlNZS1dkQ0FqYmlWRkkxSlJ2UGZ0SGRQMWlvMXBOMm1jNHRXZG9W?=
 =?utf-8?B?UlVDODZOaHR0ejN4U3hRRGVER3J4MC9PQzR4c1BwZFpMVlZnY3FkU3o5Q1lB?=
 =?utf-8?B?cEwrYkc4aHFtaU5ZS1U2UUFYWThlQ2haOU1tengyS0NFUm5DWE95SGJwMDRZ?=
 =?utf-8?B?RUFhN0YrdFhScm5peHBkbXpjNFg1Zy9sU2w5RzIzaEYrblpGQUhlNThNMUEw?=
 =?utf-8?B?Z2psRGtuNEZNZUt1eVhWY0tObklmblI3OWJkVlZKNEx4OVEwNUo3T0pMeWZ4?=
 =?utf-8?B?T3VLOVFNRy9wbXVtcDJYU0VNNTNhWkp5ekZHcFRsS1BveVhXN0RQcGg2OE50?=
 =?utf-8?B?NXVLTW4wY2tyV2V4SVdOOElCYVZxaGw2OXd5aVZsVndFYTBzdFBBQUxCUjhx?=
 =?utf-8?B?OXY4VjQ2ZVBOVmN1eFdaaXFXWi9YU2k1UCtmeCtlaDZ4YTVVbUpFT1NUV3pm?=
 =?utf-8?B?NXdBMnhDeXNaZ0VKVmp1anNIZkpqY2tZTXJZS2dBaVozaVRNVjUwQnFJMkd2?=
 =?utf-8?B?MVJDVnQyNWk3UGxSeU5aOEc4SENyK2xIV3VjL2pwYUY1RFVkdE12ZkNVbDkz?=
 =?utf-8?B?dW92Um1xeCtuUjd6Yjgyb2F0bDIrRGZkRTBISXRFZ0lQY3BaK2NaQWFGMGpX?=
 =?utf-8?B?SnJGQWw5WmYwWW9kTWhpK29GbWMvaGhteVhsKzJvWHA3aFN0bVRqSGZHOUdJ?=
 =?utf-8?B?aDRiSm8wdGh3Q3U4aG5NVkVHV3ZTdlVWVFo2UjNidEVlTDF6MjFrK3I2SVJh?=
 =?utf-8?B?N3RpODdQRk9HTUwvZ2x0T0lZUFlGMHB2Y2grS0xlcGY3UE5BQ2VuMHQ3eGRm?=
 =?utf-8?B?aFIvcm9zUmg0MEw2aDNWc3E4TjNxYVVyd3htRi9iR2tuRGU2S2NrcFhhcTU1?=
 =?utf-8?Q?t+2B/Dw5oQMfVjwE5+XNdEi9lOXZY9pn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjZEMU5sZ3dLalAzNzRYOFdEK3YxeGwzSXdmYXJRU1l4aTZCamF5MkhBek9N?=
 =?utf-8?B?UnpuN3ExQ1FnOWh5RVVhdnYyTHN2MHdLMHRqY2tlcnM3bDFXMFg2MFltNkJ2?=
 =?utf-8?B?ZGxsTXBuZklnYXJQUVk5R0IyMTN0bWdwQm5UNVJHVUVObUxGdkNXRFBtNzlH?=
 =?utf-8?B?bTRRUFNjSFFJQm5mWkVFUWhjMGxHZmJ2Mzhoc2xNd2psZDhtTlZ5eWp1V2Rv?=
 =?utf-8?B?aUxFekhCbVVCeXcyNUFjc0tKVDB1UEFDZVAxUWVqQU1nYVhuS0p2WnpFdjlL?=
 =?utf-8?B?a1VVZVlrY0laOUhKTzJoSnVzMy85NktJcTdrSXM4a29WNW1IMHFwN3NkNSs3?=
 =?utf-8?B?OUdwRzM5VmUvdzhrcEZROUFqNFhjUThJN2RscExsc283T0FXY1lub2V0YlJO?=
 =?utf-8?B?R3U3c1RhcktMenkyamhvNzBEQkRKV0JsaFJNRndOVFppc05LUmNYMUNGTVFD?=
 =?utf-8?B?M3ZCKzdrWmxyYUlDM2I1NlBCZk84YzhXUWZidEdBbFh1VXZRbGppeEdZenJp?=
 =?utf-8?B?WS9mYlhNanpMYkxLaW1YaEtWMFlCRW9pWjZjNzR1WDV4WUl5MDV2b0RVUnZS?=
 =?utf-8?B?ZU05K3Fnc3JPRjQ2SVlRUjBlYXVRdjhmNGlCUVd4VTN1NHU5WUNnZDZqUWxl?=
 =?utf-8?B?U0JhU3lIeHBTREozYzh4dDlPQzVvaUpiS0lLY0R3TUZQYUhGdHpZenB2Sm4w?=
 =?utf-8?B?TGg5YU9nbDRMeXo3cFo4OHVWenozMlovck9tNkNqbDZKMEhlc3c5d25tS0pB?=
 =?utf-8?B?MlN6SHAxcEFseW9rajhZeVhidTdqd2sxNnN3UmhTb29zZ2ZCNGZRWTk0Tmdh?=
 =?utf-8?B?eGxUNHZaR3dDZ01aTTJUQnpKOXBoTkpOQUJMc1Y5QXNoaWZFdGNmY1h4Z1Nl?=
 =?utf-8?B?dEpvWW9MQnduaDAwL2lETXF5TkI2ZEwrM0ZLSWg2T0Y5Vm1MZlhGRm1NMitl?=
 =?utf-8?B?ckhOOXRjdVcxTW1Fait1ZFV2RWZSMGErQ0pwWmpsc2N4U3NWSTk4N0F0R3Q2?=
 =?utf-8?B?U2FrT1VVb1ZHTXhuU2ZEMDdDM20ycGY2cVFkUTJ6MHVYdkpxNXExN0x3Nk9W?=
 =?utf-8?B?YUd0YzkrL1JxZStCQ2lWQVNMZlNoZ1VHQkdnYzMvM0RlMXVrWWxBM1JhT29j?=
 =?utf-8?B?N3I0Y0ZzTGgwZ2RvcE94WUg1KzJPVXo4Y0laYWtmTDVjNTZsdy95NnFLYkMv?=
 =?utf-8?B?NGRNWDd6eEl1bGVjQ0VYdEpTVjI4b0JteVJPWk5pMlczSGxPQS9FMFYvT1Er?=
 =?utf-8?B?eXp5QlpUQnpmd1dyNXlsNDVJczRXTWZJVFNQQTErRnBuNmZOV1RRTE9QSVI2?=
 =?utf-8?B?QktzR1BFQWZVV2RpQ1VwMHp1aUM0OFJ4WnluSkNSR3Z2emhWUkN5S2tzYnAw?=
 =?utf-8?B?TkVqT3RyNG4rcVh5UTdSUXFvdWRtb1NQZjZUdjYyK1k2cS8zekI1aE9Yd21X?=
 =?utf-8?B?OXNSNDl6MUhKRXU3TWRaSGtnOTRMb2IrSnhmNmVLWnJqcEZuL1E4QWpjd2Q1?=
 =?utf-8?B?NWpPOE5PY0duRHdyc0hRNEJnOUZBc2xqR1NiV1oySjhMOVNXWkFQNkZNdzh2?=
 =?utf-8?B?TEVxQnZnRC9TZDNteU1ram9TaWlldjdVbGxJRXJrcDNtUERwZXNmU0lCYlBQ?=
 =?utf-8?B?L0NjUHJpbG1SNFE5OFVRMGpBUENreEhLbWRpSFF0cUNsMXAydVJGbWR1c21p?=
 =?utf-8?B?ejZSbCtRY2NxMkN1RUxmdUlOMnhZUzMrcEIxQndoUmhxYnJHUnBZZHkvL2Z5?=
 =?utf-8?B?SUZFNXUzTy8vb3ZmakFldlYyUkhjTTJKWmxhWk52a3dXa0UyRlNWeWJCZkxl?=
 =?utf-8?B?STE0ZTNPNGdHUkcyWU1renlmVVd2SnA3MXhla0svM1BsZ2lhaldtTFhrdWgz?=
 =?utf-8?B?TTBiYlJTb01NdUMzaU42TkhHcHB6ZGR0Q0I5R1krSEp1b3BZTnBkSTh0ck8r?=
 =?utf-8?B?WkFGNzVRL1dkeFVXazhpc0E4bWJIWXB3TUkwbnQ3TkZ5V1VPbmxCWlZ6Mmd1?=
 =?utf-8?B?NS9udy9mQUt5MDRPR1BkRjUrQXFKNlYvcG5tUnVaeDB1VE5DZ0xuYUozaUx1?=
 =?utf-8?B?T2FTTHhZMkdDS3BWTEluOWtOOFFlSllLWUIxTzlMclROcUxnWk1URSt6TGM2?=
 =?utf-8?Q?npMM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd3b351-70ce-408a-d09b-08dd4f147411
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 05:32:22.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8MJnoCHXuZpNRPrTrsJ5+kpZQlcwhq1Mk71OsGIB1dAuMlYFEq32Jo1gqub+quqqZhRLqk5fxtaBiJIlf6kVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947

SGkgTWFuaSwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5h
biBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkg
MTQsIDIwMjUgOToxNiBQTQ0KPiBUbzogSGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2Ft
eS5oYXZhbGlnZUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRA
a2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwg
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gR29nYWRhLCBCaGFyYXQgS3VtYXIgPGJoYXJhdC5r
dW1hci5nb2dhZGFAYW1kLmNvbT47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogUENJ
OiB4aWxpbngtY3BtOiBBZGQgY29tcGF0aWJsZSBzdHJpbmcNCj4gZm9yIENQTTVOQyBWZXJzYWwg
TmV0IGhvc3QNCj4gDQo+IE9uIFdlZCwgRmViIDEyLCAyMDI1IGF0IDExOjIwOjU4QU0gKzA1MzAs
IFRoaXBwZXN3YW15IEhhdmFsaWdlIHdyb3RlOg0KPiA+IFRoZSBYaWxpbnggVmVyc2FsIE5ldCBz
ZXJpZXMgaGFzIENvaGVyZW5jeSBhbmQgUENJZSBHZW41IE1vZHVsZQ0KPiA+IE5leHQtR2VuZXJh
dGlvbiBjb21wYWN0IChDUE01TkMpIGJsb2NrIHdoaWNoIHN1cHBvcnRzIFJvb3QgUG9ydA0KPiA+
IGNvbnRyb2xsZXIgZnVuY3Rpb25hbGl0eSBhdCBHZW41IHNwZWVkLg0KPiA+DQo+ID4gRXJyb3Ig
aW50ZXJydXB0cyBhcmUgaGFuZGxlZCBDUE01TkMgc3BlY2lmaWMgaW50ZXJydXB0IGxpbmUgYW5k
IElOVHgNCj4gPiBpbnRlcnJ1cHQgaXMgbm90IHN1cHBvcnQuDQo+IA0KPiBzdXBwb3J0ZWQ/DQot
IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLCBJTlR4IGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiAt
IE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7g
rprgrr/grrXgrq7gr40NCg==

