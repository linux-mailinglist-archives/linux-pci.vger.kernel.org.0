Return-Path: <linux-pci+bounces-21104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E509A2F601
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CF5162EC1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F61255E24;
	Mon, 10 Feb 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LMVzhSKe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1531F463E;
	Mon, 10 Feb 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210113; cv=fail; b=nDWnEKbL5eWMV8XeL8+0BD4w5wtwc3oomeD24uJCh3Hk/BI6RYAsRKhus4yInERBNvjQLvspPRktmQrs0Abwl+TwwW3V1SB+WKvgyjQOBt2/UFKLbS/u87sc0k+RVjSxw9EzFT5Jti+2WKLsjZwm4a7FXLLfN4wx7bQ4W+OuL7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210113; c=relaxed/simple;
	bh=5f+3eHc/joFilP5jSaTstqotvhqSYY3wZuG7nYxOfl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lE3qVzTccaHQkKuaMM1SRFqgTwKbikwdK7G3zf13nj5ilitADKWz+tPLLw1fNxmM12tF5Nv4Cy2W1aCQg3ChdBu0r9HNVQJT4YwePLLAK8/WXjpoIJoCgt8eHzxhUii0lrZihrNqJET1S5LsncdSXfsrslK/b+mvcHy46LRQN6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LMVzhSKe reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NICn9007889;
	Mon, 10 Feb 2025 09:54:47 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44pw2r2crv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:54:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2u/W74QDQRhGYrP6gVra4xsVFYJ4Zy2EtutZLwADcPuMGKPCVKYG5bBbTSQX34/nE+QT7YWeqX9VvHCDQRtwonQxFbeYtBa/ohBkrGpqyjsqTPu1TBuwLdJsjzMAUjairVpbUdIDhBdpMzuBgBERwgEdiy2Nfnm/+sjTHAR9Z1vN6q9jaxNZ889v/9zP0hc5bglTayl2k0RFjtfRQHR58T9SVV+cdqvPaTXItnDeQPeG3GMW0B1IcVsSJ0UefISFa1LjzOt/CU/+iAUnPpyEmI4wocyGZaqcBl87Al834L8tQ5Kf3Z7pTCfnhD7CXyxCY94whhgDk/mi6XJhWzZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSYSgmX3fU4LGU4sZNnfRkhBL7zlV+/ywl30N1qmMfQ=;
 b=Df6p4BnrOcQt3dPNmZ9TFYP1NFKmsK7pjv+oK0coNufhKiz47y9eo5p+u+UURbl89RGeB5JyT3Rx3Wt7MqGb7tHX8SbprM0f+nilzH98ZS/oi/HNP7qVaIo5ULcvjEja6zfcarV3ssaxgWIB6IA8W5kzAb98ZD2Salz6YT94FxOdyFg2NUHZ+uYEoB/yNfptKxt8hw4OHucnxEoAJCc4Mz+iaIrackhd3paEg9dN4xlkmJCkq6oPrFhbrtB7DuyDiXWoVEGVaBKycayZSt90eoKvAxdeAfnniGgeOZ1h0m2cwqyqD0v8EUJO2fAfgic0UiuhOAz03U0CBcPs7EhhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSYSgmX3fU4LGU4sZNnfRkhBL7zlV+/ywl30N1qmMfQ=;
 b=LMVzhSKeTk0Gn/XMQtBmAzozGfEKoC8C1c6bYFxoWNbSvygrSMhwRnOxiEDn0mW8SdMh3EARGJ/bRuVKZD62f9YIQt37HWMrHCCo75vvIQTtci0D7PWJrlWEdvCQ9uh1CLP+Ds1aOf62I17nUuMyZq11K0lkS/lk21pzdgUK/PU=
Received: from CO1PR18MB4682.namprd18.prod.outlook.com (2603:10b6:303:e5::12)
 by SJ0PR18MB5088.namprd18.prod.outlook.com (2603:10b6:a03:437::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 17:54:44 +0000
Received: from CO1PR18MB4682.namprd18.prod.outlook.com
 ([fe80::ca55:457f:38a6:5ee]) by CO1PR18MB4682.namprd18.prod.outlook.com
 ([fe80::ca55:457f:38a6:5ee%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 17:54:44 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "cassel@kernel.org" <cassel@kernel.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Topic: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Index: AQHbe+TdhFpf+VtWCUaTz/qc3I6GNA==
Date: Mon, 10 Feb 2025 17:54:43 +0000
Message-ID:
 <CO1PR18MB46826E60C5512A113B5F8938A7F22@CO1PR18MB4682.namprd18.prod.outlook.com>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250207175759.jzmoox5mke3rachy@thinkpad>
 <BY3PR18MB46738F5857319F9637FA5050A7F12@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250208103618.2binrjgry7ghoavc@thinkpad>
In-Reply-To: <20250208103618.2binrjgry7ghoavc@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4682:EE_|SJ0PR18MB5088:EE_
x-ms-office365-filtering-correlation-id: 3d01d8fc-cee2-4852-1a9b-08dd49fc003a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTFlQVdOSU0rS1pmWkVDVE1LaGY3QkpsbmgrU0lqZDB4WG00WGxVY1dWazlY?=
 =?utf-8?B?Tm5pcGZJY0VpQmczZHNOV2RMK2dpbXlGTHVWOE9Fd2sxa0gyeEN4YVRQOURC?=
 =?utf-8?B?VzlDSStQSXJPdVRFK0dpTkM4dmVCQXF5eFFZMVk4dHNnRTRwWHlyOVRQdkY4?=
 =?utf-8?B?L2dDNlNDUmp0L2c5d1owN1dZV281NWNvdnlEVVQxMm1WU3NTb0NFZkxTemE1?=
 =?utf-8?B?RWFrWHk5TkhiWnFvZzRBR3RXT1NzcjRDTExWSk1LM2haSDdCMW1yOXBGLytp?=
 =?utf-8?B?eVRJVlc3YmVLZkVadThGTWlDTjRYbFh3TnBzR0JxMFFRL1VRTjBzanUxNm16?=
 =?utf-8?B?MVBvV0hjdzU3UmVIWWwwVnBNalN3VW5nRHNxTk43TmxDVXkwUFNHTE56dkph?=
 =?utf-8?B?NVEwSzFKTVVCUWh1dUsxSGdsNWhvQVpjT3ZDU3l2MDdjWjVzSk84QnZMT2p0?=
 =?utf-8?B?RlN3aFM4Z3FRTFJlRkxrS0ExUUIvd3UvTldrSkNGckwvMDdKOFBDSWFKRHhw?=
 =?utf-8?B?RWRuR1NUdUVkQmRSaEVhc1krOUVJbUJKVWNnNjBBcXhBbXU5MGE0dGJSQkEv?=
 =?utf-8?B?ZG95Q3RndzRrWjkvSU91TWMvbHEreCtRYm5KS3FSb0sxR3BDZXJ5OGJiem9V?=
 =?utf-8?B?dVNuS0hIMVdpdFdqRTlxMzFjOHBpSG9TblUzcDh3MnpFUitFcjBRNW1rTXo4?=
 =?utf-8?B?Q3d0YUYwR1EvQmNhaEo3azRBOFJKVTRBajlDaVFGc2tqSUV5bzN0aVNmeDYw?=
 =?utf-8?B?Q2Y5SG1Ia0tZVW4rc3RjQWdETCtvWGtSM3pjM3Z1NUs3QWo2R09NMDFVemJR?=
 =?utf-8?B?Y3B6QWlpSFVYT0RQd3FJQnFLbzdjWUllei92MkxxMlhZSXJaZGM5TFhrRnBR?=
 =?utf-8?B?WDV1OWlSdUFsczlveVc4Z3MyYzBFM2hFbURFMTl5ZktWOE9DcS84NVhCNHdm?=
 =?utf-8?B?SUpqUkNZeEtVVVdqZnN0VkxuQUFwZXYwclpJMmFZcjlpanZmbFY0N0hQZTRP?=
 =?utf-8?B?S0VwQnA1amNDTTlWSGY1UWl4V3BLampZbDd2UEFRWjBNaEw0Q01kVnVxa28z?=
 =?utf-8?B?N01qamFLYldyaGI3VXJJNlUvUUdTcXdVQ1ZxTE5lbm9wUy9TL2hBZW4xUXU1?=
 =?utf-8?B?ZldvaktqZmkybVJqdEZtM0ZBOCtYWlNxSTZmM05rcTZDdkhsdTduRUIrSnYr?=
 =?utf-8?B?Mlp6c2VoY3krc0lxTHhKdGwwMnQzRis4dWh2djdvVjMveTQ0OFJwWTdjUXJi?=
 =?utf-8?B?Z01JYmtvVVUwR3FXazArQnhQNXFjR0NkMm1PQis5cHBWWTRrejl1UG9nTGF1?=
 =?utf-8?B?a3I1Qkw3STNhd0RhRUkzY081eGtnZEpDKzlYUVFpNFRoSnBRWURYdW43M1Jy?=
 =?utf-8?B?WWVLTmt1dFFpclpkSVRtMGlLck9CRlVIdWhPd0M1WjBzeEwvN3JKanRYbG54?=
 =?utf-8?B?QnppZ3J3aTl6bGQrekdPakhGR2Q1WmVZOGw3ekFmbERTWFk1aTcyT0hSeWRs?=
 =?utf-8?B?bUpadGQxMDFhUWRJdjJiczZheDJpMWpNSUp4QlY3blg1KzZNdDNwdmZHdUV1?=
 =?utf-8?B?ancvVzNtM0V6UzVQZk13T3ZCSUdMZUgwb2o0MERrZFI2R3lyRHlFWldZRjFT?=
 =?utf-8?B?QVIzS1gyWnBUcW96d3VFaU9zTzJGVG9jVmtEMlZzUU91NVdiT3BZMHdnc2Ew?=
 =?utf-8?B?STlMVHZaSVY4Z003dTVMOURydWlEUGtDako1MkNCT0RLRy9xUmc1N1cvTDFF?=
 =?utf-8?B?dXdwS1ova3dRbDNuMDh5aHNnL0pGU3F6M3NCa2hoZWl2RXpUNGVrdzVTb2Fh?=
 =?utf-8?B?OFl1NUdQNEhsVUZISTdWcGt4RzQ5RXc4QWdhaVpwNGhCZ0FPcExuYnh1c3Zk?=
 =?utf-8?B?TnMrWUtjdm9QWmZiQnpCMk1WM2ZmOHhWNzh3RmVsOXdoL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4682.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWZFSVFIMjlXK0lNUVVWY1RTYlcrRy8vZ1BKQnVXdTZQZzlzcGpxMWRVVUJL?=
 =?utf-8?B?NVprZkVpWWJYTHF6WFk2WkpYOFJaeG5KeW1kdXNGUGtna3hJM1lyMmUxOGt4?=
 =?utf-8?B?R2IvZUNENU1yVjEvQkhFRk1FRUl1N0VGRHViVkg5dTBYTVY4SVJJeUNOSXd1?=
 =?utf-8?B?RDhhVTNjZGdMRnZqTVRMQ1V4SjZEUGo1SnNsenNIaEI3aWM1Ky95NjJPTmJr?=
 =?utf-8?B?WEl2cVVmemRBK28vSk5lWEM5M1dLRzNySmtpdDZhSDMrSS94SW1mb01ZeWFs?=
 =?utf-8?B?eUVYdm4zdXFmNWpUYjFOQXpkK0RBcGRyMUxBUnBXRmF1Y1UrOGpwSFdPL3p6?=
 =?utf-8?B?cHNUNUhOWU95NDZYQVVCaVhJa0c0RVVzWnRNWW80YTZzbzA0dzYwWXhjcXJj?=
 =?utf-8?B?WnBCTS9sYW9FT1d3bUZDTEoyb3BzMUVJL2NSc2s0VDVxOTR2cFl6NW83RHox?=
 =?utf-8?B?TEdNeGdSN0ZZR0E3Q3VVYkxidjhUMXh3Z29vdWFhdGlDS3lMM0tBNTI1SnZy?=
 =?utf-8?B?aC91Y3E1cGpTU2o2aVBNaXZVQkI0ZERpRnVxSzlrL04xSU8rNW4ycDFsTXRL?=
 =?utf-8?B?aGV5RnRCeWdOVWM2WFZVa1ptS1Y0bFNwaXdVZnJ0WEpWQ2t6TEwzMXdab1Uy?=
 =?utf-8?B?WnlMbjY3VTFKM0lLK3owNWU1dzIzdU5LY3JxVUhHU3Jud0NVd2tHbko2QitZ?=
 =?utf-8?B?Y3FUSlc1WTRva3Awai9ia2h3TTU2aUhsN1dkQXBiVnE0Z1pzcTVqSmtkampy?=
 =?utf-8?B?QTlkYnlIaGFOSWtWcXhZdCtERm1UaWlnQWE5OHdNNlBjb3BPSk5DTE5HRWxH?=
 =?utf-8?B?UnduNCtLUjRPazkwdmZjTW9xZUdrWllGRmtFWE5TOWE3Q1k5UGwzakxJenk5?=
 =?utf-8?B?MlZRNTc2NEkyZzBybWRCbjg5ZHFOQVJxK3E5cE1BRVRpeFpNQmp4a3I0V0tM?=
 =?utf-8?B?eTZIY0tnNlhWd1M1Sm5WbytYSGUyek9SNldubW1RaG5FQ0dLWmJyK3pQa1dt?=
 =?utf-8?B?bWw1T1NNSkVWdFJjZXBlR1FyZ20wSFVNMWxoL3dTeklNS3RFc2Zia1ZhYWhk?=
 =?utf-8?B?NXpmdkU3ZlZSUVdsSkQ3bVB5cDZkTlBJMFB5TEM3N0doODRXS1NEVTBpOHo0?=
 =?utf-8?B?K2cwTnFINCtCeEsxSyt5NUVpTm9STlk4WHR5V1J3OWJmRjltRCtPNDZWSm96?=
 =?utf-8?B?Ym10aXJKekkraERnRjdxdHQzSnlrRlIwekQzRDBjRmRsRXFqOUFITGhFSkJQ?=
 =?utf-8?B?TENSN0RZUkV5TVNrKzU3OTRtRmlSYnJwS2xYK3BJREQwY1hqbTBGQkJxTFhl?=
 =?utf-8?B?bm9peVlMNE1lQXh3QU40U2dnSDFMeElCRDJpK2E2b1FKMDRXbWZjSmRpN1RT?=
 =?utf-8?B?WVhucUdBSHlaWlV4ZEIySk9KYm9IYm4yNHB1NENzMnl0RFJDYjVFdEY3M1Fl?=
 =?utf-8?B?MHJvY0FiazNhNHNabWhSRGs1U1JQcWZkd3BNU0V2ZnJLcytONjdBb1dqZ0R6?=
 =?utf-8?B?NDEvalJ1RERBUXBCSDVBVG9sSWF6QWtVbmpJTjRRRlZWRUtsOTVkU1pGWCtN?=
 =?utf-8?B?aVI3NXYvUHZORzJnUWZWUG8wRUdxTjBhY1pENFMzY0lQeHJSQUgyWEdMb1ZZ?=
 =?utf-8?B?emFPTTF5Mk1tNnd0MXJDVlZoOE1DUm44TksvNVk3Q2tCa0hnUGlGOGFuRUIv?=
 =?utf-8?B?bExIdGNsVHdhc0JobnNEb1RXWVZ2MHl0bkZQSG0rSU5PSDd2ZkVsMmM1Q3Jy?=
 =?utf-8?B?NTFTTzM0SGFLaGJPQ0tZblYxQnFNdDlueDZkL0RNLzV4VUZieldDeHFsd0t3?=
 =?utf-8?B?NU0waUNhVEJQY2Q0S3duYUIzZUpVS2E0a3VjZVF2L0FaN3VJYjFwNS8zZXJK?=
 =?utf-8?B?aStMejkvRytIOTdTaFVsNVRKRW9XSmp6eS84a3Nqd0txUEZvazJEUGxWc2FS?=
 =?utf-8?B?YkhpRnQvMXl6VFpCU2ZoTDA1cTluRzRPeVExM3Y2aSt4WWJybkZ6eUdubFZj?=
 =?utf-8?B?M1M0dzNYNjBYWkhodS9TVittcVZuSUs1WlFFNGtEWm55RHJmc2t4OS9zVVNT?=
 =?utf-8?B?OUxWcWphcGFPdk1yWmdFOU8vZGZUQzZNRUVCdDhpUFltcnRqT1cwU0E4M1JF?=
 =?utf-8?Q?1n6X0vLQknT/A2I999iBRMsOg?=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4682.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d01d8fc-cee2-4852-1a9b-08dd49fc003a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 17:54:44.0760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+E2Y5XvSIU4wIQLrVzWXh0tVwouqXTBYuR6OJa8diSoBSEtVE4RBalK9/khrXzlFa6HdeKRJslTelemkgD0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5088
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: tAEVOhUImhMAEMhuTI5_LVlYLzTcFX_W
X-Proofpoint-ORIG-GUID: tAEVOhUImhMAEMhuTI5_LVlYLzTcFX_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Sent: Saturday, February 8, 2025 2:36 AM
> To: Wilson Ding <dingwei@marvell.com>
> Cc: cassel@kernel.org; Bjorn Helgaas <helgaas@kernel.org>;
> lpieralisi@kernel.org; thomas.petazzoni@bootlin.com; kw@linux.com;
> robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sanghoon Lee
> <salee@marvell.com>
> Subject: Re: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down
> handle
>=20
> On Fri, Feb 07, 2025 at 06:=E2=80=8A46:=E2=80=8A22PM +0000, Wilson Ding w=
rote: > > > > -----
> Original Message----- > > From: Manivannan Sadhasivam
> <manivannan.=E2=80=8Asadhasivam@=E2=80=8Alinaro.=E2=80=8Aorg> > > Sent: F=
riday, February 7, 2025
> 9:=E2=80=8A58 AM >=20
> On Fri, Feb 07, 2025 at 06:46:22PM +0000, Wilson Ding wrote:
> >
> >
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Sent: Friday, February 7, 2025 9:58 AM
> > > To: Wilson Ding <dingwei@marvell.com>; cassel@kernel.org
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>; lpieralisi@kernel.org;
> > > thomas.petazzoni@bootlin.com; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sanghoon
> > > Lee <salee@marvell.com>
> > > Subject: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down
> > > handle
> > >
> > > + Niklas (who was interested in link down handling) On Sat, Feb 01,
> > > + 2025 at 11:=E2=80=8A05:=E2=80=8A56PM +0000, Wilson Ding wrote: > > =
On November 13,
> 2024 3:
> > > + 02:=E2=80=8A55 AM GMT+05:=E2=80=8A30, Bjorn Helgaas > > <mailto:=E2=
=80=8Ahelgaas@=E2=80=8Akernel.=E2=80=8A
> > > + org>
> > > + wrote: > >
> > >
> > > + Niklas (who was interested in link down handling)
> > >
> > > On Sat, Feb 01, 2025 at 11:05:56PM +0000, Wilson Ding wrote:
> > > > > On November 13, 2024 3:02:55 AM GMT+05:30, Bjorn Helgaas
> > > > > <mailto:helgaas@kernel.org> wrote:
> > > > > >In subject:
> > > > > >
> > > > > >  PCI: armada8k: Add link-down handling
> > > > > >
> > > > > >On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar
> > > > > >Maheshbhai
> > > > > Patel wrote:
> > > > > >> In PCIE ISR routine caused by RST_LINK_DOWN we schedule work
> > > > > >> to handle the link-down procedure.
> > > > > >> Link-down procedure will:
> > > > > >> 1. Remove PCIe bus
> > > > > >> 2. Reset the MAC
> > > > > >> 3. Reconfigure link back up
> > > > > >> 4. Rescan PCIe bus
> > > > > >
> > > > > >s/PCIE/PCIe/
> > > > > >
> > > > > >Rewrap to fill 75 columns.
> > > > > >
> > > > > >I assume this basically removes a Root Port (and the hierarchy
> > > > > >below
> > > > > >it) if the link goes down, and then resets the MAC and tries to
> > > > > >bring up the link and enumerate the hierarchy again.
> > > > > >
> > > > > >No other drivers do this, so why does armada8k need it?  Is
> > > > > >this to work around some unreliable link?
> > > > >
> > > > > Certainly Qcom IPs have this same feature and I was also looking
> > > > > to implement it. But the link down should not be handled by this
> > > > > in the
> > > controller driver.
> > > > >
> > > > > Instead, it should be tied to bus reset in the core and the
> > > > > reset should be done through a callback implemented in the
> > > > > controller drivers. This way, the reset cannot happen in the
> > > > > back of PCI core and client
> > > drivers.
> > > > >
> > > > > That said, the Link down IRQ received by this driver should also
> > > > > be propagated back to the PCI core and the core should then call
> > > > > the callback to reset the bus that I mentioned above.
> > > > >
> > > >
> > > > It's more than a work-around for the unreliable link. A few
> > > > customers may have such application - independent power supply to
> > > > the device with dedicated reset GPIO to #PRST. In this way, the
> > > > power cycle and warm reset of RC and EP won't have impact on each
> > > > other. However, it may lead into the PCI driver not aware of the
> > > > link down when an unexpected
> > > power down or reset occurs on the device.
> > > > We cannot assume the link will be recovered soon. The worse thing
> > > > is the driver may continue access to the device, which may hang the=
 bus.
> > > > Since the device is no longer present on the bus, it's better to
> > > > remove it. Besides, in order to bring up the link, the only way is
> > > > to reset the MAC, which starts over the state machine of LTSSM.
> > > >
> > > > Well, we also noticed that there is no other driver that did this.
> > > > I agree it is not necessary if the power cycle or warm reset of
> > > > the device is done gracefully. The user can remove the device
> > > > prior to the power cycle/reset.  And do the rescan after the link
> > > > is recovered. However,
> > > the unexpected power down is still possible.
> > > > Please enlighten me if there is any better approach to handle such
> > > > unexpected link down.
> > > >
> > >
> > > There is no issue in retraining the link. My concern is that, the
> > > retrain should not happen autonomously in the controller driver. PCI
> > > core should be made informed of it. More below.
> > >
> >
> > Do you mean
> > - pass the link down/up events to PCI core
> > - remove the device or hierarchy by PCI core upon link down
> > - initiate the link retraining in PCI core by calling the platform
> > retrain callbacks
> > - rescan the bus once link is recovered
> >
>=20
> Yeah. This is what I came up with quickly:
>=20
> ```
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> b6536ed599c3..561eeb464220 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -706,6 +706,33 @@ void pci_free_host_bridge(struct pci_host_bridge
> *bridge)  }  EXPORT_SYMBOL(pci_free_host_bridge);
>=20
> +void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge) {
> +       struct pci_bus *bus =3D bridge->bus;
> +       struct pci_dev *child, *tmp;
> +       int ret;
> +
> +       pci_lock_rescan_remove();
> +
> +       /* Knock the devices off bus since we cannot access them */
> +       list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
> +               pci_stop_and_remove_bus_device(child);
> +
> +       /* Now retrain the link in a controller specific way to bring it =
back */
> +       if (bus->ops->retrain_link) {
> +               ret =3D bus->ops->retrain_link(bus);
> +               if (ret) {
> +                       dev_err(&bridge->dev, "Failed to retrain the link=
!\n");
> +                       pci_unlock_rescan_remove();
> +                       return;
> +               }
> +       }
> +
> +       pci_rescan_bus(bus);
> +       pci_unlock_rescan_remove();
> +}
> +EXPORT_SYMBOL(pci_host_bridge_handle_link_down);
> +
>  /* Indexed by PCI_X_SSTATUS_FREQ (secondary bus mode and frequency) */
> static const unsigned char pcix_bus_speed[] =3D {
>         PCI_SPEED_UNKNOWN,              /* 0 */
> diff --git a/include/linux/pci.h b/include/linux/pci.h index
> 47b31ad724fa..1c6f18a51bdd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -637,6 +637,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t
> priv);  struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device =
*dev,
>                                                    size_t priv);  void pc=
i_free_host_bridge(struct
> pci_host_bridge *bridge);
> +void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge);
>  struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
>=20
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge, @@ -804=
,6
> +805,7 @@ struct pci_ops {
>         void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn,=
 int
> where);
>         int (*read)(struct pci_bus *bus, unsigned int devfn, int where, i=
nt size, u32
> *val);
>         int (*write)(struct pci_bus *bus, unsigned int devfn, int where, =
int size,
> u32 val);
> +       int (*retrain_link)(struct pci_bus *bus);
>  };
>=20
>  /*
> ```
>=20
> Your controller driver has to call pci_host_bridge_handle_link_down() dur=
ing
> the link down event (make it threaded if not done already). Then you shou=
ld
> also populate the pci_ops::retrain_link() callback with the function that
> retrains the broken link. Finally, the bus will be rescanned to enumerate=
 the
> devices.
>=20
> I do have plans to plug this retrain callback to one of the bus_reset() f=
unctions
> in the future so that we can bring the link back while doing bus level re=
set
> (uncorrectable AERs and such). But this will do the job for now.
>=20
> I will send a series on Monday with Qcom driver as a reference.
>=20
> - Mani
>=20

Sounds great. Looking forward to your patches. Thanks a lot!

> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

