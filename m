Return-Path: <linux-pci+bounces-34161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2BB296AF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D94E8050
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4A2356BE;
	Mon, 18 Aug 2025 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ApxYifsY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AL2haHf7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D220B7F4;
	Mon, 18 Aug 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482523; cv=fail; b=SyyMgSUcpPlzLCQIIuNdKmIimKZNp8EzdL31PKBk+J5meuy3gpINY+4gFexJzaR9/nu5t5EmDaEN/UpLkDilkr4Wa85WAwFjBKn8p76y6HhhaSry3YEcZ2gFRHBOBIT2OC5cVitTkpr5JMNuWwQ0EZtX5l3CPMsfnHQ69XZJebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482523; c=relaxed/simple;
	bh=JNCcRRd16Fzb6OVFSiW7E/RdYOkZ3bwgtFpWjSl/Knc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQ3b0HnhW26oO8RmvLoLYvU7KSv/Kygj5cKtZSfpNp2BeTAbKJB43DXa+mr4R2PUR8025r/GdUeYgtI+jC9HAExx2jcm6MSNGdAWsVyAhHyPp4LNyvelxUiXpD6eIgLcwIcBP6JfcIvkpczpxd/+Oqjw2S8uaF4cBU8k0xEDpP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ApxYifsY; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=AL2haHf7; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HKOZfm007131;
	Sun, 17 Aug 2025 19:01:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=7U4z4fc0jP5pIeayXZKEx/LuglZeKFdyfs5yS6apPzI=; b=ApxYifsYWuoJ
	JHqkc738BP3FxhOi+ChiWgV3ptjWAtjGW44MNQZMVek2JxyiI6Juzkh69uZTGV8w
	hC4UJNpJ2x6pfhJkMi6HkpgZyvrZHmlLobANhgEN+Z98+l1t2+8ZZUuP/Tbc7oVW
	dkd2sFbmrai7x5mZK+Ral4YVCv6kT9FeqyMJkhPV+X96ddS1YZywzwuhdE6L5/Vv
	BZIK0c1LicPjuuqF5+7zYZQnyCpRfHi415Slt7abb+bHSwz4EbB29cLp/7B3csMw
	MWgtxrOUVMnwF+30cSWvLqDMi+9EDZpgV9LIUQCZHaq0fANW93MVv+kAHrlrxMny
	Qp53ojkvVg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 48jnjym41d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Aug 2025 19:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRKchGDujPPDTYdEQhfUuXyn/gYkH/mbekqdcseiHDNLCuGJqcqqBlLAGUCGdcO0iLxhoZxMR31qsvmiG2zIpbjyWg56jMrzswnQGCw8ZRKElsL6TH3eeELJHdTKVFPF+zwHM3YNqR4UuUUTmNOX/vuswt7t0RNqui50NP4XMaJTspvUnPaniX3XoDgYQ9oFz/bvEVhOwX/6WtplemEpZN/7f3hZRFzh0Nq2SMDJcWYcVE2WiPWuMOZ/u5p54HxRmumr2rbUsACGMVnmqO4NbM5vED8fmgAgZCyMrXuNZBvFaDNGkgxYxE3+R1FH70xNm3HneG4AoObchRslZNcKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U4z4fc0jP5pIeayXZKEx/LuglZeKFdyfs5yS6apPzI=;
 b=nC4finRfJQG6ZzWcPayqepMghpmfUVayAezGesRvISO52/7PxoJ7jgRDkiffrjlmM0zoLnI1zdKBElBttuYp+6F6pSslv0UAfZ8tx0fRMY1CmJ8yBgyx79aCd+VAAs8hnwvRFjrPjT68m0MDJw9fjf1Xzk4AKj5DSLV6LXk5n/LC5dsMg/K2NHzFtppV2GiP/3lfkkpFXS+HAbnc1Dlz4iOIrS+fXYP8orRqy70i239alGt1TAo3mrJcUz0MWTdeK1KVPiV7nfT0A3JpirQknUbzB7ZJ2IQhUSk63/mJcim7T/7gXc/L5tP4LCZlmGL53EXL4dUrM/LYY/Fq3mSsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U4z4fc0jP5pIeayXZKEx/LuglZeKFdyfs5yS6apPzI=;
 b=AL2haHf7i94DTWtrmTpMr3RfH5LEtmbbApu6YhiWtTnrkn4eu6byC2RKc9Hv7KEbsB2iYgyhnqGma1tNhMPCd0I9AibAQcUevVone0P5vET45dHBc1ZZSi2idd3bBXoKIeqG0mzBBByerAuHR+wXa0OMFf/RlQuahhqOVS3wb1s=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by LV9PR07MB11432.namprd07.prod.outlook.com
 (2603:10b6:408:2f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 02:01:32 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 02:01:32 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com"
	<cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 02/13] PCI: cadence: Split PCIe controller header file
Thread-Topic: [PATCH v7 02/13] PCI: cadence: Split PCIe controller header file
Thread-Index: AQHcDAqNRdQ84VNj9kWDV0Pbew7o57RiqXKAgAUGFgA=
Date: Mon, 18 Aug 2025 02:01:32 +0000
Message-ID:
 <CH2PPF4D26F8E1CE090B54394D1252312FFA231A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250813042331.1258272-3-hans.zhang@cixtech.com>
 <20250814211657.GA349149@bhelgaas>
In-Reply-To: <20250814211657.GA349149@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|LV9PR07MB11432:EE_
x-ms-office365-filtering-correlation-id: 525587a4-5f18-4a00-df8c-08ddddfb2745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N1TzZcSWUt3sUDayqDzeJ1We1gomWQOya8xq2U8OcpGLW7ni9ge8xSAIFWeX?=
 =?us-ascii?Q?Ik48ni6LnX/F0dCQVae0i8zcwTgFdkid79vZKaWg7rrYImgDJHKMWCPpVKbX?=
 =?us-ascii?Q?fM34Z8JeLWBgg38DErguvLFXsuCJitvWwz4S26lmFc+Vn0899zwmciRZJU8n?=
 =?us-ascii?Q?tFcTXjYkqlNCqHyswJ9Vu+fO+GZzQ5M2fxxKNI540OV+9I5Y29wgaA6tzV1G?=
 =?us-ascii?Q?KaAPuk3knsZw4ywUYQjMGquXTFu8dLkGbe/CgpvMWLcAma2+HI3IqzcnJWse?=
 =?us-ascii?Q?PvcnfBSOCVTlDlhWuvk0GLhkhWKAutGOI1DwXa24WczgS7JmQ8JbFIqiUAe5?=
 =?us-ascii?Q?73SZTT1ABEaWtgLNwui8VaOc9KsjoNlZDHWycA38H1Sf7UgRV4rWfAZgopF3?=
 =?us-ascii?Q?qdQGCax4VsDhA6yVDHVb6yh1ZheMFx9TD0V+2pgabfZbaF9+f6/6d7pUTD3z?=
 =?us-ascii?Q?YZy7LSLYn3dNkd+z70leQEGBt4Vp63lL39Dd2CTxRPwgQ5uETejqpGsZ3Yiv?=
 =?us-ascii?Q?Le13emKdOe5sXxRR2XAjqaa8DU0YJXUlx1yHmqdvhlbH4KIqcmcKjckuQZWT?=
 =?us-ascii?Q?DiYcguQZkYUy62xu5icSTJSVQLrirqqYG1aEx5G5n++s6JqO0qO/uJUEAJ1p?=
 =?us-ascii?Q?WDNtjCuHl4MbLAg/Z5GpcezkjCZG0U+5ac8kd1gCMdG8AbE9PmcRp7iyJadC?=
 =?us-ascii?Q?Ih5bW1vrPbAQ44Y4n73X8aMZzm2X/QAEyU2Os3xKmvkpk/GMlYsVAKHJD+0r?=
 =?us-ascii?Q?+jNRdlizjfs5JNY/beYkXTt5bq/MdBjxEOQ7KnEL4hmh0+/XzztSHrLcmLXk?=
 =?us-ascii?Q?n8sfllGWbRb2yEqNynsACXOxCsNzBVhTQbQ3y53z47K1iQL0hb/TX3IMHSYC?=
 =?us-ascii?Q?MdqAgFkvxKxsT3BNgzbknaSUANGGYF+Ja8LMKxl8Ihp2+5pNww6cUHH8DtbV?=
 =?us-ascii?Q?hcSCKxCoh26x08wWNoml2MECNt71LWy4T2tAYgmeTr3vwSbeAuvnT/Ov+GWp?=
 =?us-ascii?Q?favZzoi3v7ONGoTiOTiSuSHjQBh272o7gHTD3ypKlg8AlzKioX6fhr7OYA3L?=
 =?us-ascii?Q?qWadyV0Y9pExEWtA/uvsQU8gtI13VBkp/5PdcJyjYAaTcEZYd2BnU3BRclTc?=
 =?us-ascii?Q?LChnLnArD7cBh9IeLXAueXkeUEHF75889W5b1vyr1VNbDD9RqKPgl7G5Ql1n?=
 =?us-ascii?Q?Se5NmGkgvxrSUTWTtpA2xZLoHvIFN989Pnabm2H5xRgNVnErpX88C/wdwDrV?=
 =?us-ascii?Q?vc37+3NaNS6qfuwah0nBcPYk7HA1O7aoEWW4ZirNkEWQTj+gR+7q7x7knLtN?=
 =?us-ascii?Q?HA6YCWwTe75nvJXAXIhGPWLbMVRMeSkT/7r/9rHQTxtTzvD5marSjCuhLQOy?=
 =?us-ascii?Q?FOij5FA3KqXkrrw1iFbVXS6BnxM9hJGFC0muBk+ICAtf5QpVa4AeqQYSfUHS?=
 =?us-ascii?Q?XDEmq+Mu8eK2ViTglqUibS4FBBYmToYVeIP+qbqANT3EUyJ/C4eBpw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XP7WlAYZwygVWhUMoe34tLWnLI9c5uIfX7i1JKvIR75l6jolaZlTE8okRc3A?=
 =?us-ascii?Q?t9pf/YRVPORGoc6RrQ0VVwc9k22CBHsIiut4QzVHegdCbeuOB37ZnWdlW2+m?=
 =?us-ascii?Q?uu8dWhinGMEaVBg5ngEYm64XaE3irM9moxgEmZJrlxfIhGKKCdn39IJ6iy8v?=
 =?us-ascii?Q?rccO+aPAqkhNksPApcv0nkkQAGsLkkohBYA4xGlmYh8Xmwdpt49VMfsZX51S?=
 =?us-ascii?Q?hv0Y3jxqXc1yGlSMFg5TqBX7ABZrJB4Qnu+xm8buCMiO/HjBFWK9v483dtn3?=
 =?us-ascii?Q?ah/sf5ePU9eWWVAvxL91XXhBf3pKaWFqTxDQQU5wilMU9W/Zoe0b4rcXN8d1?=
 =?us-ascii?Q?0CJh12yPzkz4J6FB7xy1xleSNp+nbnLeLBShhYQQUzMoBzuqIUY2dy2C+mlg?=
 =?us-ascii?Q?mr2Z2l8Q3b+LTGjqXVpiMzivJbIMWJ1hynpUCHlTaYAZzFNFY2hJn0w9MJdz?=
 =?us-ascii?Q?BqpGWKs/YAFV1y7/BfZuz28acC8R3BgP4yfDhMy8K8Y8WCIqpe4skVEgx743?=
 =?us-ascii?Q?Ci/xeChdHYCLk18o9F1a6MfoDLZbYiFjviLn+89kvRl2WB7p5K0iMD3VUAKE?=
 =?us-ascii?Q?hClOeYgnQGn0SHnbIuyI0GpcS76TognUkyqKFq3XEdpMX7enMdDRBgucOQsU?=
 =?us-ascii?Q?R++3ophPgpc76y6OFc6pV/T3xUKw7oswPmEe/c9I456KWcCoEtfCmEToiAME?=
 =?us-ascii?Q?xGh5Ecw0OtewdM5H0O+j3i2kHPMBNKKQWGgOTsEqoxAt4jEKsHhnJPVrrLqr?=
 =?us-ascii?Q?8Hw6deVY/3DqIYR+eq9+hkXdu2F54Unv1yvdsGu7kB3WsqT84qYRRWuquQYJ?=
 =?us-ascii?Q?VtOMpwT400SttWQxr2a9oFz+m8AiYyqQMvweRaoWEv0nIjzVaMnisb1JGq7h?=
 =?us-ascii?Q?yId0gN5+h7A/Cn2KusbIywBuvHyKRLcwk7CqLgr/NWYkFaBbhJcRdza0FvFH?=
 =?us-ascii?Q?PRBYgoYyFrInD5tI7dWb5/Odv9Lyb5TzxsHBVusBfY7kuY0Dd4PwNbtP1OMX?=
 =?us-ascii?Q?3Ye1E3WrNeqLWmvSDFWBcDn0si9eFIJmwNYFAKlBCqvDegZ0A4bihrxT6nen?=
 =?us-ascii?Q?rgoZulE46Ad4nAPYrHm9FEutOU1B7Z15LVSbZQFWgZ40K54QrWeR55nc0Pvi?=
 =?us-ascii?Q?zBdEiqmPyVzti5qlt/v3M7NkVp0WvTdc8s0eYuVi3T/aU+yhA0VP9gpadVSm?=
 =?us-ascii?Q?uVRVfuwP9m6HHUwCjQN5bGx8HrxQNAI9zjh/90Ox4YlOAYlkCSdl1Te4BPfN?=
 =?us-ascii?Q?5/xs8IwR5m4DUxBXxTs8FP6ffQ2B2E/USwWdP8BG7vQt2jqIzlLmAt8gry2c?=
 =?us-ascii?Q?J41JxcxzLgJjF7X8gHgWdFvzq5p0wwQxNtF0zLZyl03+nO1/oIwr/rZhfmoZ?=
 =?us-ascii?Q?41qKlz2G3Eskyi6Ly8Rj8P6+RIkyEeI8ZOksXvmc0ATZmogbqWfJbmQQyvJP?=
 =?us-ascii?Q?en9e5JVa4F3XK+aSyBU4Iy3pb8v15Fedmybhg++56C9ZxUSDBxMRK87vC1Lw?=
 =?us-ascii?Q?GQtNkVaZnqbgVxu5JBXV3FLt0i6UnbZyXCgxG+33ez/+rn3t3dCDBCiKl9IH?=
 =?us-ascii?Q?033VN5wUgv2XSKjra9Mc6ruSV14wr40LrP6yeA6+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525587a4-5f18-4a00-df8c-08ddddfb2745
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 02:01:32.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHdxjc7wLHr/tOaFbFsNGpF6O3qCYUMEULsouNh87w/bvBuJcIlBAtmzgIpB2wlmrn/gIIS6wcRsUczLTM8hchtOePRsicOoclcuW5nmE/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR07MB11432
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAxNyBTYWx0ZWRfX4zY+JHh+5h6Z sxKHqfDt0ZAmSYoQNhRrbbi0lNF9Rj3BORF9DOKpTJS5eqFR8Wirakz8u8i+PqUiBuYGPSPA4Z+ biFcD5m+hqgs0XNGjSyDSwWiNNxsfkmcQaF98VUHghUGaPVAMHkRrFgQZ/IqaJAVRZGGnAiP12V
 Dyb86Eboj1AlFNj9yVYK8PSSRxTgwqfFnCrN4vh8tnXD2GlOh7IEQLyl8YfcuNqfaPTd4ezm/fE H6goEdvyxZR3+odo2hLJVENiCfw4jgPzm4eXjmwj+fBB3r7lfZ2kIHsVJ+N7q5ImVGPtMdPjNtf DDdEWgovPQlK4K4bYTjXuvtM179fZlAKXc6oEPwnf8ylTPJkr023Cy/doQW15z6CyfIeZfdJEQv
 JIzq9opluFLA3BLlaiT/ErPBKAEvDLXwPkPtbZGXImIItqaX3X6HYbGFoafIPeG3LlcIngVS
X-Proofpoint-ORIG-GUID: 99sGud3L_S5HfNgHf_nme4otHqPeTnNc
X-Authority-Analysis: v=2.4 cv=Fbo3xI+6 c=1 sm=1 tr=0 ts=68a2897e cx=c_pps a=wl18FVzv68UoWdwoSm105w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=TAThrSAKAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=Br2UW1UjAAAA:8 a=SD6YdbDMld327vezLHcA:9 a=CjuIK1q_8ugA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=TPcZfFuj8SYsoCJAFAiX:22
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 99sGud3L_S5HfNgHf_nme4otHqPeTnNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 clxscore=1011 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180017

Thanks Bjorn for your comments. Will address your comments on patches 1 to =
patches 7, in the next submission

>-----Original Message-----
>From: Bjorn Helgaas <helgaas@kernel.org>
>Sent: Friday, August 15, 2025 2:47 AM
>To: hans.zhang@cixtech.com
>Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
>mani@kernel.org; robh@kernel.org; kwilczynski@kernel.org;
>krzk+dt@kernel.org; conor+dt@kernel.org; Manikandan Karunakaran Pillai
><mpillai@cadence.com>; fugang.duan@cixtech.com;
>guoyin.chen@cixtech.com; peter.chen@cixtech.com; cix-kernel-
>upstream@cixtech.com; linux-pci@vger.kernel.org;
>devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v7 02/13] PCI: cadence: Split PCIe controller header f=
ile
>
>EXTERNAL MAIL
>
>
>On Wed, Aug 13, 2025 at 12:23:20PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Split the Cadence PCIe header file by moving the Legacy(LGA)
>> controller register definitions to a separate header file for
>> support of next generation PCIe controller architecture.
>
>s/Legacy(LGA)/Legacy (LGA)/
>
>Similar for "HPA(High Performance architecture)" elsewhere.
>
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
>> @@ -0,0 +1,228 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +// Copyright (c) 2017 Cadence
>> +// Cadence PCIe controller driver.
>> +// Author: Manikandan K Pillai <mpillai@cadence.com>
>
>I'm not trying to be a killjoy, but the only author listed in
>pcie-cadence.h is Cyrille Pitchen, and I don't think simply moving
>these definitions to a separate file really counts as becoming the
>author.  I would at least preserve Cyrille's authorship.
>
>Bjorn

