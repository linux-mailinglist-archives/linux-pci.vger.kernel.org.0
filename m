Return-Path: <linux-pci+bounces-34657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC91DB339DD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9EE1891917
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FA23D7D0;
	Mon, 25 Aug 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ayQ9PYzq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79413959D;
	Mon, 25 Aug 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111695; cv=fail; b=pp0wgbCUOGGh+WKUFEbIbaCut/OgU9aCPWPB7jgFzhWHWVu56JcvjQrQs8pLtn8OBPiHAhB9mckbH+lDDCJUt9hVwpwPzBzEoOE2l5422CBp/asUfYhzsZq8GX8O1bVrsKbD89J6p6RT6r8cOSvHjhB5y4sZIUOzr+YLx6l5SpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111695; c=relaxed/simple;
	bh=h+cseo1nX8ZAqSu4UPy6IFfDfbZluFoM6yhQqbJ6u/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1MGe00tyPXjybZY7oTJELQJv/iN90SdpaRxmh1DNZrCagGCFTJBtWQpmcvQ+w7LhFoDZqbJignPihW5TXi14oWGe1I8dJLvIhZWaIBOhXLrTSvRA0y/wEZN/WM6V+PWBJI1Cay9oqchePffwB3y2/LXoxeABSt8F2Bl/rveU1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ayQ9PYzq; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57P5OPHP2753569;
	Mon, 25 Aug 2025 08:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=h+cseo1nX8ZAqSu4UPy6IFfDfbZluFoM6yhQqbJ6u/8=; b=
	ayQ9PYzqSdpdttDqtuv2Q2Son8uHyWqdRWZoUW2B3Eax/LD2QfbOMxeol7hMrdCY
	Zgm886r7mRtW9QS1M/IhNQ4i08i6WiqnHlqvMrXa0mcBfl1AMfQ0/hs6+l9EEl/K
	g3J445F8Y+fhxkTibfDmGE3wJaNoVeeuGBEAyQsgbkYRAdECpY1MuJk73x0/JS/q
	vINesuNGpnhqlvAPRWlQtKbUQg+fmLbDZDQGt53mi5aIMJJNTTJCwXt2xwu8EmAw
	8kT+MUWSuB0e93fdRCeo/UOuXhKMZeeCxsqBnOO3kesCdyp7Vn7o7mE8TKDelGwp
	feNtS5zakTrW56zt4nJbpQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48q4m3smct-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 08:48:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjhh2BdLAPsYD0LiB8Nx3ofaKY8GT8EvX4QU6DW7Mqzr1WeU5LS/l9t8FiWcI+1RBNN9BRCyQGLSRx8KfDEmkVmdkPXcKTH66S2c6MQisfjCoswUmFBAMTxarB/NbMX9HWiH3BjkrQ6H3jE+VA457S0Ad8EOcQoJgljEn7lrtJWHuxrP+6zCgdjzvw0xqVF/9FM0KwJ1MDc+yO/fdaGn7XTQxVpy24d+/AmIFiJgwqg/P8XkbmVE/zjZf0M7oNwDpjvA/EKQASZslj0QyHE4wP3p/Y8jtyvm3AkVe+Uxi4WljmXcS318S1chIKAZrNqyGmtjxHW4gbZ79VoFytZNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+cseo1nX8ZAqSu4UPy6IFfDfbZluFoM6yhQqbJ6u/8=;
 b=rh76SEcdQJoUZcBoF0LNEtBwUpIVuex77WpRM7Kn6EFV+pDaWh3vpE0Ug/qKQ3ihUmvvAdI3RAULAMw5sosBPbyOnRdF+wy7qN44QqfVOu6Wi2Y7Oo+pMVLIY2MdpG3RkjEZgxRny/r/g8cCW1ypnrj3/99zThmyIErAx7r9mXai6fOsh6F6MNT2yfkOcwl4mKrQidGOUMI1lI+JQ6wsfsXuHWlzxm9xhFXlGcO3XOAccftR+EQMZ3oy8Dmoh09FWzq1nZz1JxAvZ2/Cz4yzBmza0vzqufG27nCXS8GqbGMDZJwJhD+JUynr40SXOyZfLrACVXTgEvAuTNTmSPNarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD24E991EC.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::52) by SJ0PR11MB4926.namprd11.prod.outlook.com
 (2603:10b6:a03:2d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 08:47:57 +0000
Received: from DS4PPFD24E991EC.namprd11.prod.outlook.com
 ([fe80::1b9f:260e:5332:3a03]) by DS4PPFD24E991EC.namprd11.prod.outlook.com
 ([fe80::1b9f:260e:5332:3a03%8]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 08:47:57 +0000
From: "He, Rui" <Rui.He@windriver.com>
To: Ethan Zhao <etzhao1900@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chikhalkar,
 Prashant" <Prashant.Chikhalkar@windriver.com>,
        "Xiao, Jiguang"
	<Jiguang.Xiao@windriver.com>
Subject: RE: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Thread-Topic: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Thread-Index: AQHcDP9f25lxQMSLe0e0vbFoJx8HyLRmKCsAgAzYy8A=
Date: Mon, 25 Aug 2025 08:47:56 +0000
Message-ID:
 <DS4PPFD24E991EC33DB3627FC112C84080B963EA@DS4PPFD24E991EC.namprd11.prod.outlook.com>
References: <20250814093937.2372441-1-rui.he@windriver.com>
 <64025ba8-948a-4d91-8fc6-a1ede807ca8d@gmail.com>
In-Reply-To: <64025ba8-948a-4d91-8fc6-a1ede807ca8d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=7efdc5ed-f75a-469b-b39a-b629f51e8cf5;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-25T06:57:10Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFD24E991EC:EE_|SJ0PR11MB4926:EE_
x-ms-office365-filtering-correlation-id: 9a43af31-0808-4b03-bead-08dde3b416d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|42112799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHpWa3FRRDZJVXdOWG1OSlMzYnFrUExtK1l0MFMyQUZiL3Z4OE5PUUtEVHNX?=
 =?utf-8?B?SHdZbU56ZkVCeFpkN3FJSlg2YW4wWU53NXMzQXJEdVpHSW14cVpSYjVmalRh?=
 =?utf-8?B?T09hYmRQNDF4M2RPMFdHTEI0elBQVTdaRjA2b2pJSGg2Q3FnUVYyRitNL2du?=
 =?utf-8?B?RjIwUXYrTEd1RTdTLy8rMlc3WXBPZHlucUV6QjNaaDk1OGppOGhNWTNENDBj?=
 =?utf-8?B?VHcvTmMxaDFpTEpTY1VWZ2ptVi95UXhIQVFsOFJGYVF0eDZkVE1xZ1JVRFg0?=
 =?utf-8?B?RDliU3hFMTFSY2NFcU1wam93Wk50SUFkUGFjY2UzMFBTUXBDaS82dnpHWXVW?=
 =?utf-8?B?c3prQ3RyQlRDeXI2dFRtQXBkQXhKSW5aL3NaSTJqenVMaGZKamRzMUtEYWtV?=
 =?utf-8?B?RFlKTzVhQUw3cllsN3hjTjRsc3k1dTdPVGN2WFRSS2JlVDRZK3ZweXlIcmYz?=
 =?utf-8?B?dHNJWG0rWUxubk52ak5oQXNydmdCM2E1RTFOcjM4cXZuLzgwLzFkUHhBQ3Nq?=
 =?utf-8?B?d01CWkVEcjVxV1RyT3NESUVXSmVsU0ZCMjBSOXBoL05XNjd1WFlmQ1NPMVMz?=
 =?utf-8?B?eTZzb2FWbUJ1aVR2UklMdU16eVRLeFk3NmtnajVQVDJUMXJoQnhveWdYN1lG?=
 =?utf-8?B?Q0ljcE5YODJBblhwaTBZYXUwQ1R4MzNSUHRyYmNOaWg1YTB0Z3Y5S0JxRWlT?=
 =?utf-8?B?NHF3REluMWhDZkg5NE5KTmhGa0xKVCtnVXVNQ2NNNWdYb0hDaFAwU2JxcGRi?=
 =?utf-8?B?clJoNzRYRnZDOGRWblEzQmJTVjhWQVNrN25zN0NGdEErbms2MEdpSUlwSnkw?=
 =?utf-8?B?WU9XNnViV1Q0S3prdGFUYkFMQUZXSDdqYzhUM3VPNFZTTzQzWUl3NnRsT2o5?=
 =?utf-8?B?aUt0VGJDbG1DaWJoSGFXUERDM2UrV21XYVgwajdyME1jNVNCNUliR2FLWFpD?=
 =?utf-8?B?TWcxd09JV1RVNy9BL3MrWmdPQng0eG1ZNE83V3BpaDVHZ2hFbkJubGFPTytK?=
 =?utf-8?B?ZlVPejZJbkZFV2tmQmtBaHlOYklBb2xBaytqNFdaT3lkMkh5aDVDVldwczdo?=
 =?utf-8?B?UVQvL0FGN2JiSFBQS09FNnFSc28zVllUdG95WnFoMWdWYi9ONXRCVkhiQ2hq?=
 =?utf-8?B?NlNKakcwUitSM2x2ZnljZW5rY0g3TGFvUlozWTVmQ3RST1pUMmY4UFBpWDh0?=
 =?utf-8?B?UGMyMmFXVXZ1VEVzWnNDWlFQSjdGN1NJcmJyR3BobGE1c0FTUkF6TWdlZjRF?=
 =?utf-8?B?azlGWG5SMFVqUDEwVVp5WENLQkppS1FiUzFPeGNlVFZ6RU1mN2d5djRLTGxL?=
 =?utf-8?B?amtseFhRRXRpRTFDejhuZmhpY2t4UlJ3R3JTZkc3MzRWbS9IMUVlMldKa2dP?=
 =?utf-8?B?MHdXcUU3djZ0V09VVWZVN0YwZjJJSzYyMHRVbTgzMTkyaXlUWlFKOFRkUmJB?=
 =?utf-8?B?dG5kY1pHNG5mZFExVDcvQlA1aitYdzBSYi96TE1xQ3ZXZUIwZmdMSFRPYk5I?=
 =?utf-8?B?SGdLVFEwVVpiYmxnaS9vZkl0QkdiWFhsZlJic1E2WnRQdDhTVGY3NzJzNTlr?=
 =?utf-8?B?cjZmV2dSWUYvZktKeWRjeHc2ZFNZSW1jRk4zWlZxcEhrWmFYRjl6T3daR0dw?=
 =?utf-8?B?U3NYRTBMc1JjNE5nQWc3NTBLT1F5R1RFR3puUUlEb1dVc0xuVzNrVkpUaWdo?=
 =?utf-8?B?ejRuMmlvbzVWQTVOWFlRTHJVK29EOUtJYTNrTTdSWkxDOGZtL3JCZnVSOHUr?=
 =?utf-8?B?WUJZVTRYUVk0ajVUMmNFM1BUS1JHcDZvYjJDK2VFY1NBUG4yemI1dndGOHFZ?=
 =?utf-8?B?a0gyKzZ4b3FYUUd0Um5DeGNMZStyNytYMVhMSEw1TDJCcU1mQVAybE5lazcx?=
 =?utf-8?B?djhQVEZiMlpReFBQanhITzFnMGZWbXZwa0xCdEN6RlRvWmVtU0tTem1NaytL?=
 =?utf-8?Q?l2p5/RRKDYw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD24E991EC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(42112799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDlEZk9HZ0dYckdMaFpwU1kxZXIyQ0psVGJET2VUVHR0RnFlVndKM0N0Skg3?=
 =?utf-8?B?d1dEZ0RBajJXeDQ5QUJoOGJwSlI5enk5cnMwM1RFdXBJWGNGbEpVMUEvUVJl?=
 =?utf-8?B?M3NYTFJaMGxRb0hUa1lGSjkvNEhPMnIvbWJFRDZrOHExVlpsOHJjQ0k0Tis0?=
 =?utf-8?B?bThubWMrbVl0bXNzQmhuV1ozR1RJZnVuVXVBMGgybmN5QVg0UHpSaFVxZWhN?=
 =?utf-8?B?d3UrT2F4K3lLNWR2NjRvT2VMaHo2WE9JSHFoS1h5RHV0cWUrUGw4MitySnRC?=
 =?utf-8?B?V1ZzODNPd21tK3J4T2VaR0xVY1MzUXBodVc4RThxK2tEM0RZblZTVzB5TEhK?=
 =?utf-8?B?Y2srYmVINnlZdXpzL1hyamZLWVg1c3pDYTNXdi9BRk1CT3pLb2pxZXlseEpO?=
 =?utf-8?B?RG5DUC90U2F1VDEzWXRPODQzSVpmVUVzWDFDc2RMMWRQaFNQZDlrRURjYkVC?=
 =?utf-8?B?WkNLUFNLdjNjM1c3SlJOekFWQzlFaktJR2JXUHBMdU81N0RMTHVyYXNYMVlQ?=
 =?utf-8?B?ZmM2ZnlWOEZzVXRkWm9EN1RDaEJnQVAzTzZVR2xRNExmdVVDcVIvR3N2dXJT?=
 =?utf-8?B?R25ibW9IN3laeDAvcnRTYVJOOFR6UGRvR2QzZ1J5MW5UOUtRd3B0dTR5cjNr?=
 =?utf-8?B?T3FWYTBlb0Z0c1kxYzliWDBUQVZUb1hwRTVHbldCMUJyNGl5cXRCK3RNMWZq?=
 =?utf-8?B?OWxubTlqL2d2cys0WEFMNzF5TEMyL2dqSCt2aklPZC9lWXhWUEcvb1dlb29j?=
 =?utf-8?B?aXc3ZXdRZm8wWUxwaWhaRVJONnBVQktOY1YrUzFHVGRnK2NMUis0TlR4WVQw?=
 =?utf-8?B?cmdEU3pjTkhpeG1sRGlwY0w0dTJrM2NESFptZTNCOUtML0Ridy9xMXBvZFB3?=
 =?utf-8?B?bmhQa2kxRUNCcUQ1c3RjMDYwNmZ3cTl1TnhrLy9hekNpN0FMdEVINEFBQ1ZS?=
 =?utf-8?B?VVc5SDZrdExlRU82Um5tRDg3YjM1bnpncFNVTUxNamFtVHR5ZlMwR0hUSEw4?=
 =?utf-8?B?c0x6ZEM0RXZuczV4aGpoc2swcFhqK1Vkd2VzS1ZCWVArT3JXcTh1czJIYjRI?=
 =?utf-8?B?L0pJSWdjQmwraTZoZ0tZTnpaVmpxVC84eExscVBFU0dmSEs1bURkc2QvaVhC?=
 =?utf-8?B?bnBSaXRIY0FYaXhWblpPMm9sYmZmdnZPYTY3aFp2U3RPdUhkSWx4TWlKanFX?=
 =?utf-8?B?OHo0L01Hd1pLazJlWEZyV091RjR0cnBJWEZCM3JiM0VOSC9HVGRHNFZ6dGxr?=
 =?utf-8?B?dEJUdlhCYi9PZnhkMEt2QzUwSVRISTFHSjlFZ2IwSCttVHBrYnZyTjJySEhO?=
 =?utf-8?B?cEN1dXh6R094S3NPeVRDVTRIbDFrV2JNNkxBRlFPWUhySWk0UFp2L1c4R09Q?=
 =?utf-8?B?RHk3UHBNWFVoeU5OcHFONzdKWC9kWFo4dDgyZGFjTDdRK2JvdGJwKzBFSy9S?=
 =?utf-8?B?WTJRVGNXTjlGZEU3ZzI3b0JoS3hEbHkzd0w1ei9pWEVrTmp4VXBTME5GbHBr?=
 =?utf-8?B?b3NRTUltMUFSQkZQRGFITmErZnJ6V2h4M2tXbE9TcHVrMUtoK3RqU0NkWm1n?=
 =?utf-8?B?L0RZeXpjUHRRdTNzN0lXZDdzQ0dmMnJMK1hKM0docTlxT1h4VDNMQjY5bzdo?=
 =?utf-8?B?UXlLYk5hWGxRa0ZYQ29rdS9Zdm5EVFhFTHI5YWJqOEZoeHo2bnFScDdlWDZt?=
 =?utf-8?B?d1ZDRWM0c0gwcE1OeFE0YndXcGY0Wm9YQnQ3c21hbGEvRWtPSDFYV2VxY1Fy?=
 =?utf-8?B?Vk5JMWV4Nmc5aG5mRCtIY2RKTGFMUnN1MU1yS0p2NW1WZWZ1VG9FYTJPSnM0?=
 =?utf-8?B?SDdJV1NUaGJiRlhXcWlHQnd2bGI4dWJDQW5oNndaUGh2Zzk0aVFxdDVYYkQ3?=
 =?utf-8?B?Ylo5TzMwcjNBRWlwdnJ3WmRIZ2l2K1g0c2wwRW9ESElsbTRXRUJOTUdwc2dq?=
 =?utf-8?B?WjhudGhWcEdnM2k5VWk2YU5IQnhqR3o2RFlncnF5SENRWTFDaEpBMDBscjM2?=
 =?utf-8?B?N1FCNEVFdjcwWkwyMlNPWVJmV2Z3aXo3UWducFNodjgwSEcwZVhHbjQ4YUVi?=
 =?utf-8?B?eXU5SmZQVGtpbHFNU0xHMzlpaUlMMDlVZmhucktUaklMYm0zbUZ6VE5zQUhi?=
 =?utf-8?Q?caMoEChGPNflTKaEkkz+JX6Gk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD24E991EC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43af31-0808-4b03-bead-08dde3b416d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:47:57.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndJiv09htVAICXr3jEyd7APe9uE4eU5BbIcC+7on/ub8Sj7EtLDza7aWGC7nGU2tggzy7t4PxaRA33GZrL5aXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NyBTYWx0ZWRfX8SV4lKggE8wH
 ENVjtHcWJURzWEpAZAx9TUXyx//CFOdl3zBsiNm+2jpbja2MgTDdjweVUrgsVcbQBJWQ0eEgpJA
 l808gqHHUwKeNLqTsxlKOUIOQj6vVJ3+UfMxX0KZOuI+l1asdVn7A0srzv/EsHCJFBnH1JBPn6P
 9XQQU/omBf0rrTL3Ay4LVVWwi/41WurD1ky/FmLBYINGKOQfRAagXYja5g2LReqIOMuxbXyqNGg
 dsZMxMngPCysGHjB9DZ9F80OqgXS/cdAlbPjYp38ptAKHYY8wb2M4F2eEgOMFkq8N9+Rlm/DeLp
 vTnVNyouct1tA7YofsPakr1WhHuFfcdYDFAvGd1mm2G0+z1oAH7TGjn44tPE6E=
X-Proofpoint-ORIG-GUID: 9P2hDFuaeq2FNIrbcKh3sCZV4zr0Vpcu
X-Proofpoint-GUID: 9P2hDFuaeq2FNIrbcKh3sCZV4zr0Vpcu
X-Authority-Analysis: v=2.4 cv=CcwI5Krl c=1 sm=1 tr=0 ts=68ac2341 cx=c_pps
 a=qdv+Q4TnSqLF0nLC9wtOhA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=x6A4zavapyowX69IOBMA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXRoYW4gWmhhbyA8ZXR6
aGFvMTkwMEBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjXlubQ45pyIMTfml6UgMTA6NDYNCj4gVG86
IEhlLCBSdWkgPFJ1aS5IZUB3aW5kcml2ZXIuY29tPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IENoaWtoYWxrYXIsDQo+IFByYXNoYW50IDxQcmFzaGFudC5DaGlr
aGFsa2FyQHdpbmRyaXZlci5jb20+OyBYaWFvLCBKaWd1YW5nDQo+IDxKaWd1YW5nLlhpYW9Ad2lu
ZHJpdmVyLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIHBjaTogQWRkIHN1Ym9yZGlu
YXRlIGNoZWNrIGJlZm9yZQ0KPiBwY2lfYWRkX25ld19idXMoKQ0KPiANCj4gQ0FVVElPTjogVGhp
cyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gT24gOC8x
NC8yMDI1IDU6MzkgUE0sIFJ1aSBIZSB3cm90ZToNCj4gPiBGb3IgcHJlY29uZmlndXJlZCBQQ0kg
YnJpZGdlLCBjaGlsZCBidXMgY3JlYXRlZCBvbiB0aGUgZmlyc3Qgc2Nhbi4NCj4gPiBXaGlsZSBm
b3Igc29tZSByZWFzb25zKGUuZyByZWdpc3RlciBtdXRhdGlvbiksIHRoZSBzZWNvbmRhcnksIGFu
ZA0KPiA+IHN1Ym9yZGlhbnRlIHJlZ2lzdGVyIHJlc2V0IHRvIDAgb24gdGhlIHNlY29uZCBzY2Fu
LCB3aGljaCBjYXVzZWQgdG8NCj4gPiBjcmVhdGUgUENJIGJ1cyB0d2ljZSBmb3IgdGhlIHNhbWUg
UENJIGRldmljZS4NCj4gPg0KPiA+IEZvbGxvd2luZyBpcyB0aGUgcmVsYXRlZCBsb2c6DQo+ID4g
W1dlZCBNYXkgMjggMjA6Mzg6MzYgQ1NUIDIwMjVdIHBjaSAwMDAwOjBiOjAxLjA6IFBDSSBicmlk
Z2UgdG8gW2J1cw0KPiA+IDBkXSBbV2VkIE1heSAyOCAyMDozODozNiBDU1QgMjAyNV0gcGNpIDAw
MDA6MGI6MDUuMDogYnJpZGdlDQo+ID4gY29uZmlndXJhdGlvbiBpbnZhbGlkIChbYnVzIDAwLTAw
XSksIHJlY29uZmlndXJpbmcgW1dlZCBNYXkgMjgNCj4gPiAyMDozODozNiBDU1QgMjAyNV0gcGNp
IDAwMDA6MGI6MDEuMDogUENJIGJyaWRnZSB0byBbYnVzIDBlLTEwXSBbV2VkDQo+ID4gTWF5IDI4
IDIwOjM4OjM2IENTVCAyMDI1XSBwY2kgMDAwMDowYjowNS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMg
MGYtMTBdDQo+IENvdWxkIHlvdSBoZWxwIHRvIGF0dGFjaCBhICdsc3BjaSAtdCcgYWJvdXQgdGhl
IHRvcG9sb2d5ID8NCj4gYnJpZGdlIDAwMDA6MGI6MDEuMCBhbmQgMDAwMDowYjowNS4wIGhhdmUg
dGhlIHNhbWUgc3Vib3JkaW5hdGUgYnVzDQo+IG51bWJlciwgdGhhdCBpcyB3ZWlyZCBzZWVtcyB0
aGV5IGFyZW4ndCBjb25uZWN0ZWQgYXMgdXBzdHJlYW0gYW5kDQo+IGRvd25zdHJlYW0sIGJ1dCBz
aWJsaW5ncy4NCg0KRm9sbHdpbmcgaXMgdGhlIHJlbGF0ZWQgbHNwY2kgbG9ncy4NCiMgbHNwY2kg
LXR2DQogICAgLi4uLi4uDQogICAgXC1bMDAwMDowMF0tKy0wMC4wICBJbnRlbCBDb3Jwb3JhdGlv
biBYZW9uIEU3IHYzL1hlb24gRTUgdjMvQ29yZSBpNyBETUkyDQogICAgICAgICAgICAgKy0wMy4x
LVswOC03M10tLS0tMDAuMC1bMDktNzNdLS0rLTAwLjAgIE1pY3Jvc2VtaSAvIFBNQyAvIElEVCBQ
RVMyNE5UMjRHMiBQQ0kgRXhwcmVzcyBTd2l0Y2gNCiAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgKy0wMi4wLVswYS0xMF0tLS0tMDAuMC1bMGItMTBdLS0rLTAxLjAtWzBkXS0t
LS0wMC4wICBEZXZpY2UgeHh4eA0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgKy0wNC4wICBQTFggVGVjaG5vbG9neSwgSW5jLiBQ
RVggODYwNiA2IExhbmUsIDYgUG9ydCBQQ0kgRXhwcmVzcyBHZW4gMiAoNS4wIEdUL3MpIFN3aXRj
aA0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgKy0wNS4wLVswMF0tLQ0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgKy0wNy4wLVswMF0tLQ0KICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgXC0wOS4w
LVswMF0tLQ0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICArLTAzLjAtWzEx
LTE3XS0tLS0wMC4wLVsxMi0xN10tLSstMDEuMC1bMTRdLS0tLTAwLjAgIERldmljZSB4eHh4DQog
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICArLTA0LjAgIFBMWCBUZWNobm9sb2d5LCBJbmMuIFBFWCA4NjA2IDYgTGFuZSwgNiBQb3J0
IFBDSSBFeHByZXNzIEdlbiAyICg1LjAgR1QvcykgU3dpdGNoDQogICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICArLTA1LjAtWzAwXS0t
DQogICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICArLTA3LjAtWzAwXS0tDQogICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBcLTA5LjAtWzAwXS0tDQogICAgLi4uLi4uDQoN
ClllcywgeW91IGFyZSByaWdodC4gMDAwMDowYjowMS4wIGFuZCAwMDAwOjBiOjA1LjAgYXJlIHNp
YmxpbmdzLiANCg0KSSBhZGRlZCAwMDA6MGI6MDUuMCB0byBpbmRpY2F0ZSB0aGF0IFtidXMgMGRd
IGlzIGNyZWF0ZWQgZHVyaW5nIHRoZSBmaXJzdCBzY2FuLCB3aGlsZSBbYnVzIDBlLTEwXSBpcyBj
cmVhdGVkIGR1cmluZyB0aGUgc2Vjb25kIHNjYW4uDQoNCkhlcmUsIDAwMDA6MGI6MDEuMCBpcyBw
cmUtYXNzaWduZWQgdG8gYnVzIDBkLiAwMDAwOjA1WzA3LCAwOV0uMCBpcyBub3QgY29uZmlndXJl
ZC4NCg0KPiANCj4gRG9lcyB0aGUgZGV2aWNlIGJlaGluZCB0aGUgYnJpZGdlIDAwMDA6MGI6MDUu
MCB3b3JrIGFmdGVyIHRoZSBzZWNvbmQgc2Nhbg0KPiAoVExQIGFyZSBmb3J3YXJkZWQpID8+DQo+
ID4gSGVyZSBQQ0kgZGV2aWNlIDAwMDowYjowMS4wIGFzc2lnZW5kIHRvIGJ1cyAwZCBhbmQgMGUu
DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGNoZWNrcyBpZiBjaGlsZCBQQ0kgYnVzIGhhcyBiZWVuIGNy
ZWF0ZWQgb24gdGhlIHNlY29uZCBzY2FuDQo+ID4gb2YgYnJpZGdlLiBJZiB5ZXMsIHJldHVybiBk
aXJlY3RseSBpbnN0ZWFkIG9mIGNyZWF0ZSBhIG5ldyBvbmUuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSdWkgSGUgPHJ1aS5oZUB3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9wY2kvcHJvYmUuYyB8IDMgKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMv
cGNpL3Byb2JlLmMgaW5kZXgNCj4gPiBmNDExMjhmOTFjYTc2Li5lYzY3YWRiZjMxNzM4IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9w
cm9iZS5jDQo+ID4gQEAgLTE0NDQsNiArMTQ0NCw5IEBAIHN0YXRpYyBpbnQgcGNpX3NjYW5fYnJp
ZGdlX2V4dGVuZChzdHJ1Y3QgcGNpX2J1cw0KPiAqYnVzLCBzdHJ1Y3QgcGNpX2RldiAqZGV2LA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAgICAgICAgICAgIH0N
Cj4gPg0KPiBUaGUgYnJpZGdlIHNob3VsZCB3YXMgbWFya2VkIGFzIGJyb2tlbj0xIGFscmVhZHks
IGJhaWxlZCBvdXQgZWFybGllciwNCj4gd291bGRuJ3QgZ2V0IGhlcmUgd2l0aCBicmlkZ2UgZm9y
d2FyZGluZyB3YXMgZGlzYWJsZWQuIG5vIGZ1cnRoZXINCj4gY29uZmlndXJhdGlvbiBhbnltb3Jl
LiB3aGF0IGlzIHlvdXIga2VybmVsIG51bWJlciA/DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBFdGhh
bg0KDQpNeSBrZXJuZWwgdmVyc2lvbiBpcyB2NS4yLjYwIChodHRwczovL2dpdC55b2N0b3Byb2pl
Y3Qub3JnL2xpbnV4LXlvY3RvL3RyZWUvTWFrZWZpbGU/aD12NS4yL3N0YW5kYXJkL2Jhc2UpLg0K
DQpUaGUgYnJpZGdlIGNhbiBiZSBtYXJrZWQgdG8gYnJva2VuPTEgb24gdGhlIGZpcnN0IHNjYW4s
IHdoaWxlIHRoaXMgZXJyb3IgaGFwcGVucyBvbiB0aGUgc2Vjb25kIHNjYW4sIGhlcmUgcGFzcz0x
LCAoIXBhc3MpIGFsd2F5cyBiZSBmYWxzZSwgDQpicm9rZW4gaXMgaW1wb3NzaWJsZSB0byBzZXQg
dG8gMS4NCg0KW2J1cyAwZS0xMF0gd2FzIGNyZWF0ZWQgb24gMDAwMDowYjowMS4wIG9uIHRoZSBz
ZWNvbmQgc2Nhbiwgd2hpY2ggbWVhbnMgdGhhdCB0aGUgaWYgY29uZGl0aW9uIGlzIGZhbHNlLg0K
DQogIC0+ICBpZiAoKHNlY29uZGFyeSB8fCBzdWJvcmRpbmF0ZSkgJiYgIXBjaWJpb3NfYXNzaWdu
X2FsbF9idXNzZXMoKSAmJg0KICAtPiAJICAgICFpc19jYXJkYnVzICYmICFicm9rZW4pIHsNCg0K
cGNpYmlvc19hc3NpZ25fYWxsX2J1c3NlcygpIGFsd2F5cyBiZSBmYWxzZSBhcyAicGNpPWFzc2ln
bi1idXNzZXMiIG5vdCBhZGRlZCB0byBjbWRsaW5lLg0KDQpJc19jYXJkYnVzIGFsd2F5cyBiZSBm
YWxzZSBhcyAwMDAwOjBiLjAxLjAgaXMgYSBicmlkZ2UuDQoNCkJyb2tlbiBhbHdheXMgYmUgZmFs
c2Ugb24gdGhlIHNlY29uZCBzY2FuIGFzIHBhc3M9MS4NCg0KVGhlIG9ubHkgcG9zc2libGUgaXMg
dGhhdCAoc2Vjb25kYXJ5IHx8IHN1Ym9yZGluYXRlKSBpcyBmYWxzZS4NCg0KVGhhbmtzLA0KUnVp
DQoNCj4gKyAgICAgICAgICAgICAgICBpZihwY2lfaGFzX3N1Ym9yZGluYXRlKGRldikpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgICAg
IC8qIENsZWFyIGVycm9ycyAqLw0KPiA+ICAgICAgICAgICAgICAgcGNpX3dyaXRlX2NvbmZpZ193
b3JkKGRldiwgUENJX1NUQVRVUywgMHhmZmZmKTsNCj4gPg0KDQo=

