Return-Path: <linux-pci+bounces-39437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C75C0E9C9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189854F65C8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48B239E88;
	Mon, 27 Oct 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="I4idUuPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F440748F;
	Mon, 27 Oct 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576335; cv=fail; b=WboFZDef9qGeKeXBERx6wD4Y2BNWiVHgpLYUZ9Lk7Z2Nc7f0Vgfj8POYaKmjnk1G5dvf59AHSDHKHqgLHqj3fFlXBE/mCkReAzvz3DIyB5ll6ord71QFLjp17aaaaZIYr0uZwUbkO+gQtFalpbCEJprfRH3IszuOdHTr41beTHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576335; c=relaxed/simple;
	bh=aNra5Dw0isVO2UPQp4QvDWOfnuNPjR+YlfUzPMO8sGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYu4iUGAPkB2mMNVKr05sdJ5zvOkRVKGdGbT+27UW5dUUGsEhY331Gqnm+dWILwTgFXKTb4XAAuWSBHJQoNE2tiu2q32+148Ssy9VA8uU+tNAzc/zqK6/UzyFVaWSY1Fn99rb4pnPdeLfPU9yavJrzuUYrY2X5esQ3SxDpksjkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=I4idUuPI; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RDUKCb507069;
	Mon, 27 Oct 2025 07:45:29 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023107.outbound.protection.outlook.com [40.93.201.107])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a1fa5tpea-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 07:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2vZipIAHYP7eUDPWEFtmI8NTrCM5wXQZmpE9UmwtF/NSP5MALZ+4+mCRL3tALI3sMr19rOFb/wfVAqRk1qBoteRmbLD9b+HJSP2RgSIvXbLtAzY9VdZ4J6q7td2kB2qp1IzUOrxtb3GoiZ13GSYjrWvqHvXUJreOukhC2yczwuZ07D3NmA3WGysWhXekzXcmn40jmWM97OiXf0YxVQegs+L3cIOxRVnOthtYSg3oL5Xe1r+bm155tbfylROUCO19YjWvOquLSBDvIeoli/pksBWffQAszb9OX6hAlJbYd0v8oA51RSDcBJDZJW41mypwLTyomocS6JGCJQso0UjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o19uTHpbxExccMdz+Q1H5QWNy2xER0w26Z4JcJgvB8=;
 b=DPa++ziLliE80o5swla4H5yO6WjjB4m7ipSrUL8EoQ2AV7a3cTXaVQLvbd9I8ttxzZAwvGylmD2rAYbDINcRzTsy66OrhnnUII359rzRq8gOlN4T+FFwri/8odRwG+RsT/JynVMNtEmTTTmo+qvCjUV6Onws2GTt2XqGvXf99mqSzpV72lnJ9LXWspsJYAs+eOi8LX9RDvWP4pGAmHikZlUGxslAN1/Kg2TDJc1qWG5mPKZpiySq5O2Q0jWl6X/EDtwykrySI28EbeItwjRLBuPXL5aRZNuI8+UYSC+nU7aiwYm9SB2dxpOoU3CrDpGFHTsy1MfCPSjbk3Cydu/Wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o19uTHpbxExccMdz+Q1H5QWNy2xER0w26Z4JcJgvB8=;
 b=I4idUuPI+bCP4sm4kcELv0An0ggYyoXpEXi/6XE2x+vPFb9zeCBzzAy9QhPpiDsUhQQgZMJ84up0Cp8wkIO1h9rgcMcqcnDD8zoJWfGV9ztKRopVFO5KyuJS+wgCwNa75hzcxs1nhPOUJM4bNb1SJGpAM4n2J6zQUmQVB1PkybM=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by PH8PR18MB5311.namprd18.prod.outlook.com (2603:10b6:510:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:45:22 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:45:21 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Shashank Gupta <shashankg@marvell.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Shashank Gupta <shashankg@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
Subject: RE: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
 during SR-IOV VF creation
Thread-Topic: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
 during SR-IOV VF creation
Thread-Index: AQHcIwzYhSVuceY1zU+F8qJPS01h97TWWbCg
Date: Mon, 27 Oct 2025 14:45:21 +0000
Message-ID:
 <SN7PR18MB53145C30677F872D61EE49AEE3FCA@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20250911111106.2522786-1-shashankg@marvell.com>
In-Reply-To: <20250911111106.2522786-1-shashankg@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|PH8PR18MB5311:EE_
x-ms-office365-filtering-correlation-id: 852b7c8d-bf88-4268-4da0-08de156774c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g+h1IAVsqLitjz8/fwOeZWYNC1gvwg7CgbR2oW9UYP8tyBgtd8LP39NkeTvX?=
 =?us-ascii?Q?0WNEPHyhY7MRz4HF16yByQp9EDLGJrJwlhOy3+8r6tr3OugasyOnNk9fw+RT?=
 =?us-ascii?Q?67R8k1cUWJNWbNdoGlftTUVTKOtuwhZm8Zkb7DW11xYD0ZHKAdokFyIiONiI?=
 =?us-ascii?Q?GaqEm1fvSV4ON1H0dMgkRjP7sPeZHqqSXCZE0+jdLiK5w6FxEI/AQ2OJgy3A?=
 =?us-ascii?Q?4oKA3nhKisQnB3+L6kAZisQxAT8EXk7pp3J/gLd8CQM6GLajnbhHJJ+dAnUN?=
 =?us-ascii?Q?hs8oGfOn+Nn/LyPW6qcU9VmN9aYu0t6jArSxT3TOhOcUfUTam5GIswE2Nttc?=
 =?us-ascii?Q?AxtAwf2SjRENUeQBYypEQ7ixeeXhsuT8V8KnulSHsret6oLjM6D5gpnm6VAL?=
 =?us-ascii?Q?EihJ9KT9Dcg4vCyR7Yyhy2RsZhd8/znacVY/Fh1cuBdEO/DgcV8rOkiqxsMg?=
 =?us-ascii?Q?Z+s3Z/KQzmraCbfUBUqj89b6v6Ftj4KDmKeVXz4qDjLsAyzEd+SiJUVXjO4A?=
 =?us-ascii?Q?yo3+EuX5rqPzfzd4uYhVkUTvyQg0p53++4Olt5IDSO9w6jYFhH3apVBd9wb+?=
 =?us-ascii?Q?Mzo/0uS6Z+zyXJChF9YOdF5UYJlgKGa6/nsdxj1lTZFtC7zBgdn2af4rvKdM?=
 =?us-ascii?Q?6LYqTcg3GRp+oEfGmFoV0gSclhLDmbHX26Xblm8UjusqrvITwyeIxqsN8e2C?=
 =?us-ascii?Q?hMwHVOME6/2J6L3WhEe4UwtedvhulNJnVgpQCmUOQi9EV3FLMpvysWli1Wy3?=
 =?us-ascii?Q?VM2AdO1J2DcnDB3Xv2I9Onl0dmGOTWe2Rx5t7GoOV0+cwg5rtMotp6Er3V0D?=
 =?us-ascii?Q?Hmb5wtUoYdFwh3f88ogIqNkXWzPzcrmVECgXluIga1Oz+6VbTs+SZjseuOCv?=
 =?us-ascii?Q?Bn1uTeCu25yJWsB9iGn/h8WHhFbeK3hRgFvjbL+HyJmUXRwqPJq2+z4qdjRI?=
 =?us-ascii?Q?BTE9SwIxMQ8kI8V69k0vPb3a4tCPmpf4T6HuFGNVCqk9JTyvhEV44t50g1Tc?=
 =?us-ascii?Q?Og+F9E/Pz5yNXRKG+Owd0QDb4xz/oHr3CZbqaKKli8NPz6jlxtfEqG14GWQZ?=
 =?us-ascii?Q?i5FQsXjfngLmoedNorU7+LKAvpHkthZ2orsRwKKLmnyXRJtDDeybxEh4kL6s?=
 =?us-ascii?Q?oRK2OlPndkCXPH+nupv3coKwjH9ISzd9zlwBGb6HqYhPweDnNzMlWPVc8eUi?=
 =?us-ascii?Q?58dUetwEtH9G4PBdWW6TF0MlbRaAz0e4dm4RgC2YTACRFngVTd2dniTzgUBz?=
 =?us-ascii?Q?Fd0yl/A4X8jlAy8rjPdeBQeDHFZv693ChPZNoBa06AhBhQq57YxV0PjpjQYt?=
 =?us-ascii?Q?9YPOs7Rph/XTNnFdeykTw2AwUAnj6B68v68r4ix/1fEcUOwCG8tY25hlHGWb?=
 =?us-ascii?Q?X/ybRspElo86SgOEZUAsL6x1meTLb+F7nT30riN2m0rQbpp2BFryf0Rze67x?=
 =?us-ascii?Q?JYImzUFY4QEjcU7bvtaC/YWR5kWT/LiXaQodXJ62ZQVo4wvygyb6XtGWN6fh?=
 =?us-ascii?Q?myJOQsVy99wp/xYT7Anymyry4za16TWq5Wtb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XVzTck81stfAvFqz4f51NDc44ylCLVoM0ucVckM/RFiyhb4OLRHVMQAyJJ5O?=
 =?us-ascii?Q?G9K73beRXwaflM1YCLAhIvO10dm8dl8JJNXc2AKoiB4IOFpUCAEI1oaZ6iUB?=
 =?us-ascii?Q?dOSjBotZcg0wOikT87j8XTp8oevpw4aYaLsYfOYJAnHEfzDPHMTp+kFaxWhk?=
 =?us-ascii?Q?0r0rCtdQRzwFQjyYoDHGDMJaVtX374/0FFrgYzJ4Pgt9IFhn7pjszigUGwvU?=
 =?us-ascii?Q?RqZaNX+4oL7Bb/Dmiud9f09GlBuqMLTA2Gsj25lZDEaydQGUHoOewudH6zcV?=
 =?us-ascii?Q?X88LG8JqPdF8jTSUa9gv31M0X19nyVZ6tBBilZyQtJuj1ayDy7zAqxFzEFri?=
 =?us-ascii?Q?RuBR+462hoGAuOgnfgfSW3hXR3/ZlWZBUscrMfFkYt+Joyrqnbjfzj551jR8?=
 =?us-ascii?Q?1rwPSIgE0lGtb4QMn7YQxSZMFhgJvMxv29z/lNcJ1UM3poPIZdwW1xpeGVml?=
 =?us-ascii?Q?DhmR1fyYSzPqGPEDwsUe2+3AXfpF1/h1didIF89kCbgHalY5pOyRaMg7nPCD?=
 =?us-ascii?Q?ilEFF7iPO9m8jDwtx7DARFnNdRdt4Rr1DT1Z1ps4fIrnG/15bYdxEaPelBze?=
 =?us-ascii?Q?zJpWQC9gyLHPomRLSbECc8P5uEUBSUSDiSZ8313FV56ZxMP+rmtd0iNAbces?=
 =?us-ascii?Q?IOlsk9JQAx6F8nNmRjnEvr3TB4clMlIOQENYzBpTcQo8JCzrX80uwjfkMXBU?=
 =?us-ascii?Q?x8YsFthUOLiMJxilJK1lx5Vn3rC4duxPx++XK4HBzcd+dGBSQ2M1Vxkqhm8J?=
 =?us-ascii?Q?rTqwzjWliv/KbSjcqJqqiMuvln1Us7aAgG6DI0nqDNNyPw7XlmSdQYBpR1jW?=
 =?us-ascii?Q?wPBqSymNzQFu32DzF9JOHKHN5MscocM0HFlxRMVmTY/L3tUVPSDZlJ6n5xkn?=
 =?us-ascii?Q?M0q8baR1DD7MYA5GqC+6OhZ7U4+Wvy/3y0BRAUw+BPiafQRuX+T3X5u8vVRO?=
 =?us-ascii?Q?QlXMI5+boGdr+kXvg98ORWKUAWBpJy8AGjJCOxRP63zmXxbrLx1MFlckl7up?=
 =?us-ascii?Q?VY+PeB1cA0cnQbfNlQ21HTV4RPi29kdISfuUVH/HLS1sQ9g9kqtTXmHy9A0X?=
 =?us-ascii?Q?lYqbuNh2hzuemscB8SH79nGWawpCzlrErCbW86tyNiW0xPl4dgpgu8fQd/5c?=
 =?us-ascii?Q?TqQmePQW8F7ef1GYsG8jZ2pFGaHg5Sv6m+mFDTwl8OOp65PtBNiIVV/aQGZw?=
 =?us-ascii?Q?tHZCyMDhkqBG51MDcbdANEDbd4dFKk6owowtyL1EgwydTUpPaFRxCWqFk/Tv?=
 =?us-ascii?Q?IR26wMWoXA8bc1YgXNxI6wfL76KaScwIRQdwTkB5PdA35tUEMHD1aOcyXzjl?=
 =?us-ascii?Q?34c+DqSuR49KDTdy0y/+zunvbweuymN6gox43KQRBMvUDoXjCzul6n5qjaU2?=
 =?us-ascii?Q?Ggva12gAe1z80I1NF5jMuFqZ9QVsL9Cbsc13NUyAvAZlvsBnZSic/0Cl7IKo?=
 =?us-ascii?Q?4pCblB5IwLRZNy/KgSmLJiT9h2CngxgGKqphKeYZ1Z1TWM2wRV/zkUlm2+Bq?=
 =?us-ascii?Q?vrDPcoaBN5w/vQFcM97ZXlwl6Q4wtcTizLjyJV5FrxUO0fyYent/sJbcZ2Ic?=
 =?us-ascii?Q?p9n/dr6kV0H8c3KHp5q09CKClRdPX7K4dVL2Ofmm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852b7c8d-bf88-4268-4da0-08de156774c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 14:45:21.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3HUnEaixfRWXw0HbaGSD+2QFsDJAJYJOE36TYAWudULf7nSQgSk8F4krou6bxJeBHs1c3mUcQ7OzSq/SNyjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5311
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNyBTYWx0ZWRfX5sN1eTgHKa+y
 tP0vryuuydsGtT5ca7Lgoxs5BJCAqsEaCm63IclxX03HpvqyvtvuEUULRjdh2KKHMHfFPhJ1V0e
 6t7KrCs8on4XGWRx2jktdlso2jmTvvYPM/8SpLWB/FeTkOFRYfYDIfgVcK/TKTDoI8ZNxpp3tKl
 IHoq3W7yD+i09w9/eg88jso1duVyix/3qPSAN6Geg+WqTplGweCxGeuvUAE+JJDF5Ima327zH6C
 hSmxEB/xtvd0K8xR9HitYZiN7MA2Y3a3SwUWk57u5cg0ZKn1FmaiEvRr/J+DT3uJpyYW40/ZUG5
 GFvgGZgLcy9hQkqRf7quL9WZZJp5S64KXmxGIR/16quldCUcGJ48QaNxLWzHrCII6r7fFGRJDCu
 7IRdmHIAnti7h6TNtteVHKY1DMv2tg==
X-Authority-Analysis: v=2.4 cv=VOnQXtPX c=1 sm=1 tr=0 ts=68ff8589 cx=c_pps
 a=hPX4sJ9ttNblXMIvR1KFjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=E2dQ11HkgCZhHc_7pMYA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Aj3wmwygZlO2tvsGRmakXQq8PpztsE2Z
X-Proofpoint-ORIG-GUID: Aj3wmwygZlO2tvsGRmakXQq8PpztsE2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01


> -----Original Message-----
> From: Shashank Gupta <shashankg@marvell.com>
> Sent: Thursday, September 11, 2025 4:41 PM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux=
-
> kernel@vger.kernel.org
> Cc: Shashank Gupta <shashankg@marvell.com>; Bharat Bhushan
> <bbhushan2@marvell.com>; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>
> Subject: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
> during SR-IOV VF creation
>=20
> When enabling SR-IOV VFs via sriov_numvfs, a race can occur between VF
> creation (`pci_iov_add_virtfn()`) and a parallel PCI bus rescan.
> This may cause duplicate sysfs resource files to be created for the same =
VF.
> `pci_device_add()` links the VF into the bus list before calling
> `pci_bus_add_device()`. During this window, a parallel pci rescan may ite=
rate
> over the same VF and call `pci_bus_add_device()` before the PCI_DEV_ADDED
> flag is set by sriov_numvfs, leading to duplicate sysfs entries.
>=20
> sysfs: cannot create duplicate filename
> '/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:02.0/000
> 2:03:00.3/resource2'
> CPU: 10 PID: 1787 Comm: tee Tainted: G        W
> 6.1.67-00053-g785627de1dee #150
> Hardware name: Marvell CN106XX board (DT) Call trace:
>  dump_backtrace.part.0+0xe0/0xf0
>  show_stack+0x18/0x30
>  dump_stack_lvl+0x68/0x84
>  dump_stack+0x18/0x34
>  sysfs_warn_dup+0x64/0x80
>  sysfs_add_bin_file_mode_ns+0xd4/0x100
>  sysfs_create_bin_file+0x74/0xa4
>  pci_create_attr+0xf0/0x190
>  pci_create_resource_files+0x48/0xc0
>  pci_create_sysfs_dev_files+0x1c/0x30
>  pci_bus_add_device+0x30/0xc0
>  pci_bus_add_devices+0x38/0x84
>  pci_bus_add_devices+0x64/0x84
>  pci_rescan_bus+0x30/0x44
>  rescan_store+0x7c/0xa0
>  bus_attr_store+0x28/0x3c
>  sysfs_kf_write+0x44/0x54
>  kernfs_fop_write_iter+0x118/0x1b0
>  vfs_write+0x20c/0x294
>  ksys_write+0x6c/0x100
>  __arm64_sys_write+0x1c/0x30
>=20
> To prevent this, introduce a new in-progress private flag
> (PCI_DEV_ADD_INPROG) in struct pci_dev and use it as an atomic guard
> around pci_bus_add_device(). This ensures only one thread can progress wi=
th
> device addition at a time.
>=20
> The flag is cleared once the device has been added or the attempt has fin=
ished,
> avoiding duplicate sysfs entries.

Please provide feedback to this RFC patch.=20

Thanks
-Bharat

>=20
> Signed-off-by: Shashank Gupta <shashankg@marvell.com>
> ---
>=20
> Issue trace:
> ------------
>=20
> CPU2 (sriov_numvfs)                          CPU4 (pci rescan)
> ------------------------------------------  --------------------------
> pci_iov_add_virtfn()
>   pci_device_add(virtfn)   # VF linked to bus
>                                           pci_bus_add_devices()
>                                             iterates over VF
> 						PCI_DEV_ADDED not set yet
>=20
>=20
>   pci_bus_add_device()
> 	create sysfs file
>         pci_dev_assign_added() set PCI_DEV_ADDED
> 						pci_bus_add_device()
> 						 duplicate sysfs file
>=20
>=20
>=20
> Issue Log :
> -----------
>=20
> [CPU 2] =3D sriov_numfs creating 9 vfs
> [CPU 4] =3D Pci rescan
>=20
> [   93.486440] [CPU : 2]`=3D=3D>pci_iov_add_virtfn: bus =3D PCI Bus 0002:=
20 slot =3D 0
> func=3D 4 	# sriov_numvfs vf is getting created for vf 4
> [   93.494002] [CPU : 4]`->pci_bus_add_devices: child-bus =3D
> 				    # Pci rescan
> [   93.494003] [CPU : 4]`->pci_bus_add_devices: bus =3D PCI Bus 0002:20
>=20
> [   93.500178] pci 0002:20:00.4: [177d:a0f3] type 00 class 0x108000
> [   93.507825] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =3D  0=
 func =3D 0
> # pci rescan iterating on created vfs
> [   93.513288] [CPU : 2]`->pci_device_add : bus =3D PCI Bus 0002:20 slot =
=3D 0,
> func=3D 4     # sriov_numvfs: vf 4 added in the cus list
> [   93.519388] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =3D  0=
 func =3D 1
> 	    # pci rescan : vf iterated 1
> [   93.525438] [CPU : 2]`->pci_bus_add_device: slot =3D 0 func=3D 4	     =
                   #
> sriov_numvfs: enter in adding vf 4 in sys/proc fs
> [   93.532515] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =3D  0=
 func =3D 2
> 	    # pci rescan : vf iterated 2
> [   93.539904] [CPU : 2]`->pci_bus_add_device create sysfs
> pci_create_sysfs_dev_files: slot =3D 0 func=3D 4 # sriov: vf 4 sysfs file=
 created
> [   93.547032] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =3D  0=
 func =3D 3
> # pci rescan : vf iterated 3
> [   93.552714] rvu_cptvf 0002:20:00.4: Adding to iommu group 85
> [   93.559812] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =3D  0=
 func =3D 4
> 	    # pci rescan : vf iterated 4
> [   93.569002] rvu_cptvf 0002:20:00.4: enabling device (0000 -> 0002)
> [   93.576069] [CPU : 4]`->pci_bus_add_devices PCI_DEV_ADDED not set : sl=
ot
> =3D  0 func =3D 4 # pci rescan : vf 4 PCI_DEV_ADDED flag not set by sriov=
_numvfs
> [   93.576070] [CPU : 4]`->pci_bus_add_device: slot =3D 0 func=3D 4
> 					  # pci rescan : enter for adding vf 4 in
> sys/proc fs
> [   93.576072] [CPU : 4]`->pci_bus_add_device create sysfs
> pci_create_sysfs_dev_files: slot =3D 0 func=3D 4 # pci rescan : going to =
create sysfs
> file
> [   93.576078] sysfs: cannot create duplicate filename
> '/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:1f.0/000
> 2:20:00.4/resource2' # duplication detected
> [   93.608709] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot =
=3D
> 0, func=3D 4        # sriov_numvfs : PCI_DEV_ADDED is set
> [   93.617714] CPU: 4 PID: 811 Comm: tee Not tainted 6.1.67-00054-
> g3acfa4185b96-dirty #159
> [   93.630399] [CPU : 2]<=3D=3Dpci_iov_add_virtfn: bus =3D PCI Bus 0002:2=
0 slot =3D 0
> func=3D 4
>=20
>=20
> Fix trace (with patch):
> -----------------------
>=20
> CPU2 (sriov_numvfs)                   CPU4 (pci rescan)
> ----------------------------------   --------------------------
> pci_iov_add_virtfn()
>   pci_device_add(virtfn)   # VF linked to bus
> 	pci_bus_add_device() enter
> 		set PCI_DEV_ADD_INPROG
>                                      pci_bus_add_device() enter
>                                      PCI_DEV_ADD_INPROG already set
>                                      return
> 	pci_dev_assign_added()
> 	pci_dev_clear_inprog()
>=20
> Fix log:
> -------
>=20
> [CPU 2] =3D sriov_numfs creating 9 vfs
> [CPU 4] =3D Pci rescan
>=20
> [  178.296167] pci 0002:20:00.5: [177d:a0f3] type 00 class 0x108000 [
> 178.302680] pci 0002:00:1b.0: PCI bridge to [bus 1c]
> [  178.307746] [CPU : 2]`->pci_bus_add_device Enter : slot =3D 0, func=3D=
 5   #
> sriov_numvfs: adding vf5 in sys/proc
> [  178.313636] pci 0002:00:1c.0: PCI bridge to [bus 1d] [  178.318592] [C=
PU
> : 2]`->pci_bus_add_device set PCI_DEV_ADD_INPROG : slot =3D 0, func=3D 5 =
 #
> sriov_numvfs: vf 5 PCI_DEV_ADD_INPROG flag set [  178.324939] pci
> 0002:00:1d.0: PCI bridge to [bus 1e] [  178.329895] [CPU : 2]`-
> >pci_bus_add_device PCI_DEV_ADDED is not set: slot =3D 0, func=3D 5 #
> sriov_numvfs: vf 5 check if PCI_DEV_ADDED flag is set before proceed to
> create sysfs file [  178.337719] pci 0002:00:1e.0: PCI bridge to [bus 1f]=
 [
> 178.342704] rvu_cptvf 0002:20:00.5: Adding to iommu group 86
> [  178.350586] [CPU : 4]`->pci_bus_add_device Enter : slot =3D 0, func=3D=
 5     # pci
> rescan : since PCI_DEV_ADDED flag is not set it enter the pci_bus_add_dev=
ice
> for vf 5
> [  178.355597] rvu_cptvf 0002:20:00.5: enabling device (0000 -> 0002) [
> 178.361193] [CPU : 4]`->pci_bus_add_device PCI_DEV_ADD_INPROG is
> already set : slot =3D 0, func=3D 5  # pci rescan : check PCI_DEV_ADD_INP=
ROG flag,
> it is already set
> [  178.373726] [CPU : 4] <- pci_bus_add_device return : slot =3D 0, func=
=3D 5
> 	# pri rescan : return
> [  178.382852] pci_bus 0003:01: busn_res: [bus 01] end is updated to 01
> [  178.395474] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot =
=3D
> 0, func=3D 5    # sriov_numvfs: set PCI_DEV_ADDED for vf5
> [  178.395721] [CPU : 2]`->pci_dev_clear_inprog unset
> PCI_DEV_ADD_INPROG : slot =3D 0, func=3D 5 # sriov_numvfs : clear
> PCI_DEV_ADD_INPROG for vf5 [  178.403289] [CPU : 2] <-
> pci_bus_add_device return : slot =3D 0, func=3D 5  drivers/pci/bus.c |  8=
 ++++++++
> drivers/pci/pci.h | 11 +++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c index
> feafa378bf8e..cafce1c4ec3d 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -331,6 +331,13 @@ void pci_bus_add_device(struct pci_dev *dev)  {
>  	int retval;
>=20
> +	if (pci_dev_add_inprog_check_and_set(dev))
> +		return;
> +
> +	if (pci_dev_is_added(dev)) {
> +		pci_dev_clear_inprog(dev);
> +		return;
> +	}
>  	/*
>  	 * Can not put in pci_device_add yet because resources
>  	 * are not assigned yet for some devices.
> @@ -347,6 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
>=20
>  	pci_dev_assign_added(dev, true);
> +	pci_dev_clear_inprog(dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> ffccb03933e2..a2d01db8e837 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -366,17 +366,28 @@ static inline bool pci_dev_is_disconnected(const
> struct pci_dev *dev)  #define PCI_DEV_ADDED 0  #define
> PCI_DPC_RECOVERED 1  #define PCI_DPC_RECOVERING 2
> +#define PCI_DEV_ADD_INPROG 3
>=20
>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)=
  {
>  	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);  }
>=20
> +static inline void pci_dev_clear_inprog(struct pci_dev *dev) {
> +	clear_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags); }
> +
>  static inline bool pci_dev_is_added(const struct pci_dev *dev)  {
>  	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);  }
>=20
> +static inline bool pci_dev_add_inprog_check_and_set(struct pci_dev
> +*dev) {
> +	return test_and_set_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags); }
> +
>  #ifdef CONFIG_PCIEAER
>  #include <linux/aer.h>
>=20
> --
> 2.34.1


