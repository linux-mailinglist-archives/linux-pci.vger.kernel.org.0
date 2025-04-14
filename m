Return-Path: <linux-pci+bounces-25775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A9A8761F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B618904D7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFF1865EB;
	Mon, 14 Apr 2025 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Xru+5xt6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="oDxB3D7B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB999E571;
	Mon, 14 Apr 2025 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600379; cv=fail; b=cqHO0DypWE9pN6EBj2cNN9AhNKhfuAyJCVIOwcsxUfFkXzzGagVVM0JhyYdtopq0hUKv6Aekis3mHZOIh2VAAw5H9xfmipnxRkg0lFhsrdysmzlTZPToaSQERuw/+h2G0CWKaWkjcH3y7BWtMXLXxcY3XSUW3w0IOHqKSn7gbdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600379; c=relaxed/simple;
	bh=jEqH/ZnSNxeFWvOzmfOdqxYgJ8TL1Y6U3KlKERWeKbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SiSlgxx9QjcDscsylEQ9XMyqCEYcRKM+QAc39XlV+GNVV88p/CPpHAHHwB8Z2JH9rn9QqZogYUQ0f0EuS5pO8zDwT8D/dsYc7mL8ruDG86fn49DdaND7tWUkeUI+R7rC2Xt1cX1nVPvWLHMYxrs9VYc9wSKZZxWn/el9dEkQvOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Xru+5xt6; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=oDxB3D7B; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNcBf9030836;
	Sun, 13 Apr 2025 20:12:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Dp11Zn//7TlNNssKNLEmFhUVFClOmU5p26Zk+Ds8xMw=; b=Xru+5xt6VUdi
	5lhU7q+jfc++gCoNxl6L/cf5wRhp0PqEN8ekdzO/rTehokyR86nvLou+FsLcORzq
	kZxLqiWLsg3+HQ5OXyH30Rqt819RLHLW5yBv9OJoIeGygh2mlyRNrzrfjUbBlCjo
	MtIJhgXxYIvH8q+N7Ghdo/THAS7x6lNHyVWp2nDnPmZbLRMh8A9BHpHwvgv3Gtt3
	kLlm8KH0YeEffTVYr+wGDbPGQE6FJPZi6FsdqceR0Zoxx6CH1KVwFD131yLpkIZn
	giOu5eDkhD8GjK/K9XSTy9mcwUAN10aFQ+As2YCqDwhbTmsU+c7avh5BKJk0buo9
	4XgjCbozIw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45ymqx63dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 20:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As5dbCRdciag9MgyUAP4RszvDLH30fAv/046A0fYQNzzgIWFm1n/ReUd+mKfodKaHF9Cxr5R+Tqc62xwTYDntfN2SxXprJn4I31DVGH2LSOKrHS8BtFt4fj9pdgQy+/ZVL6Q1DUkPqCCgtApHm4IWvq4BFsK/HvoTo/1L3Z2qHJ9GiB1hkuQzbjItMaHvjRCZZmQdyP4gmNincXqWcjBI2eQIHF72+E6SNHFnPAF8lcjuIN/BJtsg+wia/Oo49nH2RFBi48HwknQZajc30HQrGA+6L/Z8wTxdofEcXpLWZccv8yYXJ3keH58qsPmUvkMF3fdaCqkChdRE9BTCrQvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp11Zn//7TlNNssKNLEmFhUVFClOmU5p26Zk+Ds8xMw=;
 b=EiczAtgMC08DZxaYnMQSVv2P74B63m6qLDvdHkedTPGJM/Y4eneSV7hs505VxbklWf8jjWvXtO8upDc2QTs+JNjCMtJPp9sHQFgenyQVoXR9nltQv6i5KszOFYU1n/bqT5RWM3XfYawQWArwFv+I9jFoTsrb4y8FyJzrajEZmU8c7r2E3HCVnz55yaE1DcL7FL8xmugrqEvb2j1dR5W/JbiuJzXVcCbmpFdDZ2s0PZ9CiO0dPU4myrwk6nDKroZi8o8P+rwx2PTF0AniSutoyzpKnb1Pr9SLem+V7k936NNsgfbbgWvEUmvQRASgOihLlTp86ImrRSFFmSdSILmQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp11Zn//7TlNNssKNLEmFhUVFClOmU5p26Zk+Ds8xMw=;
 b=oDxB3D7B//WP4k9kO6UiuxlBZkzCvNnWTT11ICTMrYFpSv1vgiEcPtaD2/IlnUHyokA73OUyvOPXGTqKX/gYrvalITVw3TfK24ce1Yp3aN2DLX9XVjNaytt8fL6ustOghnWRxmXi9vPNfBDLBl/4aEUgX8yqKKVP6Ur5Grb4v7o=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB9743.namprd07.prod.outlook.com
 (2603:10b6:806:33b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 03:12:44 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:12:43 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Rob Herring <robh@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] PCI: cadence: Update support for TI J721e boards
Thread-Topic: [PATCH v3 6/6] PCI: cadence: Update support for TI J721e boards
Thread-Index: AQHbqs2w8FUXGodC6Ea5aXXqHgN/eLOe6hIAgAOWVFA=
Date: Mon, 14 Apr 2025 03:12:43 +0000
Message-ID:
 <CH2PPF4D26F8E1C4E4B759326DF5A04D2CCA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-7-hans.zhang@cixtech.com>
 <20250411202518.GB3793660-robh@kernel.org>
In-Reply-To: <20250411202518.GB3793660-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB9743:EE_
x-ms-office365-filtering-correlation-id: 312606e9-06a9-41ff-a463-08dd7b023948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kGSFpykQYqhcr2EEs78tJWyk9Nt/Ire39de2iYxjncSHuqU98+g59wna9rVZ?=
 =?us-ascii?Q?DT1JEYSG3XFWEwAIvswFO7ef482CY+uYH/KsFaRNB59JM8+ghf/sK0YXyTqP?=
 =?us-ascii?Q?/TG+rJ6cOZ4jVKO+TVUFGIiDnXpROK5tZ4C6Z2g3ZwwDwyE9ioEHU+2BbvUL?=
 =?us-ascii?Q?/REGOZtzC//RP96T/bfXUcy7WmWQAbsTgs6fhfs/bt1lyQxzwWbxT3XawOtK?=
 =?us-ascii?Q?2M/hGar9QfLUTmuW9wUX8E14rYsUQClja+i/B/fBF1VNkN2iFgnwO0flbZze?=
 =?us-ascii?Q?KwTNAi//X1HrIm0dkJm5S9dNfdWZERbtRQPbsBi5yPfaTLdmhuHRicCOC+33?=
 =?us-ascii?Q?H3WTDwcUcEdzWrILIeFdEmUaalFw7kGqcD4nUMiExHPumgjufEPATL8/vMHs?=
 =?us-ascii?Q?LqAck87o0bK1b0UT2rHIBOTzublSCLxKbwh7OhIjk1DwosI/5Cto0uCyoJC7?=
 =?us-ascii?Q?GqJe8b/moa+vlcJ5Wvn8/DoUadjSyhuZBcKagyDnE9a+yIuFjSbIO8nME0zc?=
 =?us-ascii?Q?ns6itBR1Z4Lm987HmFADIoO7VYhR6HX1Xl8SkDBIgmaqNgmMlXyCWQDxmcVi?=
 =?us-ascii?Q?SiUT9K8priBh0qxNZGuPLGPD9WGIArjTY5VzeqioSpqXtoqJXW8dvARX46dZ?=
 =?us-ascii?Q?h16j8rbKHIZWQ8pd19bM2CwGh0R0ujYSCqX7z3QU0BD/8vBhI+2asz249ij5?=
 =?us-ascii?Q?X48zR31cZ0F563YBlYsauE18acuNDA+Ao4yOPH7o19YJ+BREvmhrnW3l6Mwc?=
 =?us-ascii?Q?yyYpoQ4cqWrPc/in40BOXIhxI7Vir4DO/UqmC3HHl+6iD+g4lqbvj/pgvuKT?=
 =?us-ascii?Q?/nQUrIiVX41h2iuKA0a7PPf9G8Vug/wLebieHqUN4CAdjXeL/Mjm1NkT7xGt?=
 =?us-ascii?Q?Jo3sO8N1XwS9pPojUPhSw8T61fuhf0GWdSBADoyigm1b7SMnCekRLAZmb3V1?=
 =?us-ascii?Q?dx7j89RIuB0OFKeCvmE4uhvM9ZGuY73nMGDhEWqTqHI+4QVDQRWufDivMzMK?=
 =?us-ascii?Q?Fse17/Ez2CbTaO/A/mCQX9RSE2c0xzSvOxJTnk1P/USqhXfiwlZJncsXLZAl?=
 =?us-ascii?Q?CPKvoodL0VpT2pRJjeEVTrCC79tnX6NRhRa2uGO0GvoMMWcXeKIvWFknh4Re?=
 =?us-ascii?Q?ZMRDCQFYug0cagGyOnC55df/WtBL9iczpIgltkt66mI851BXW6cDR2IgFgL0?=
 =?us-ascii?Q?4z2/v1OqBC/i3dQ5YammxQAZOmPY1kU/PFU0oINQllalhGUlzdLbEC2tSHY+?=
 =?us-ascii?Q?Lm89ZJTcuyuoAN96P3jafvGfVNcyA6UPFDWfLDkTAlr7Uu6uCAKAgJWN75u9?=
 =?us-ascii?Q?m4Xj6aYdc02tUVpsCKvhX+46Tjy9/lADb1ZmZZK1QJ5u9IM5yAkCw+N9lON6?=
 =?us-ascii?Q?zui4vtogua5y4an+M6oJHgrwMVcJqHoED248tfYCv+F3K4UCaWjA3hzI0bl7?=
 =?us-ascii?Q?cFIgW4S8J7vpqsVAVie/6sg4OYiGjJyV4z2IQkzcfjHUK1CMRHPupQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rTLTWXsTL2ZZqGVkmNTBNp8ZZb+D/cbvKcU+Xc1BYg0KIfLlC1IwzAmcHqRf?=
 =?us-ascii?Q?uE0ILkOHtYETVnk5hERTPjqWsFQC2LnMKDy/pho113ZsE6FbrRkoS7GY31Gk?=
 =?us-ascii?Q?i+GifSmNOEvxKEHzPE+DFkOZPVoPqBjXtke1d7dcoRItNfEA4una2z3A6Kzt?=
 =?us-ascii?Q?/7D/xF8Ig9fMVw37Oto+UECIIhJttKOE7Jy1Nn0vSiA74EBGk8mg48mWOujv?=
 =?us-ascii?Q?8enGOGrRWE65eLUknkUO7/D90dv+FtQCIEOSAR7SuP1y85bsyEjBSWjxEF9G?=
 =?us-ascii?Q?7RRcHy2UB40W+uFKmuEVq2PMLcMnp2RnyKQ1zVUT4BfGUVPeMGhZWJIJ5rea?=
 =?us-ascii?Q?oLNnMe9eJhfTJQ3hL/W6U1/GvAp7RCy09dd175nS8QcmpNBC6a2gXo7B3r8L?=
 =?us-ascii?Q?cBEdky2fzerErhSvBSZzvr89htsu4erRuGiLlCHtHQz7yCa34QCPedNKPOTH?=
 =?us-ascii?Q?kSdzFeIGLiK3COuZiPCRM50Fq7qRnRSy/b5t1poDOldfysn7uU9+b+0+x3vS?=
 =?us-ascii?Q?wtyMpVxFu6D23d7sB1RbUCPeyCSd0+kaVmp5xEgl2XTCmR8HAikQvlDJVYwb?=
 =?us-ascii?Q?ZJCQp64YE9u7LjpIQ/D+a0vUzDmDyxPiyMMTMzpnsciR1ydR90WMRQNoxDFs?=
 =?us-ascii?Q?g0pMDAgAhmtQTh7vxg92hnbImyD8C1/upa+OucPQw8oT4m+AfRUH2N60dzzM?=
 =?us-ascii?Q?Fv99saXg9qpQY4Az/f1yAGaM61hahoaEQFBZfOSIE3Sw3Y4wF/m1TdBrnjnL?=
 =?us-ascii?Q?CmwMEsyFlP2PnsE70MJp56nMSusLyns5+EBin2bR00pxppny7RjGWtBW9Q2g?=
 =?us-ascii?Q?OI64iG0tr4cFpwESq2uGAlZc14Vhn/UmPc6EHAfaVFrKeWY1MdL6yxRhdWJE?=
 =?us-ascii?Q?3FEIV7asGq0Co6Mpi6hswtH3n0MAYPuFImAEmzjdRtBFxG7Uo75HukGTGlWw?=
 =?us-ascii?Q?6y03sYrDIUU0s9fDHWSd4bJYMYRtHC+RQ3k8dP1I6v1HnaA0+gylXcceAz6H?=
 =?us-ascii?Q?ZLbcLxGITRkrP7EoFwXQFseC1WAhJAW8YPjgdf9QqTDPnRfJXgI9tg+9bkSV?=
 =?us-ascii?Q?3wWxE23vuoQDCk9j4JdeeQD3xRlWCLylTHRDKjfRJKqfTWPqaxNJp6+AFJnC?=
 =?us-ascii?Q?wyaVc+B3cNRxwF5abYayPbUXVJ6H18sk7LZFRUhml3oUu3RU+qSSiNntwxL9?=
 =?us-ascii?Q?n3X4/fQv+SPyAdpXHUbEoDRJVx9hBnLprIb11eXQOsRzbkFyGeu7QpSCXzbi?=
 =?us-ascii?Q?KJFOk1LydhavE0aUOELheqIpFuIKCMKo6D4LzoNOM684Ju0M1x1koO4xtxjM?=
 =?us-ascii?Q?TfdMCnoe+A9u3fqOfE1nnsU41qPlqsqbRJa65x1VPhaG5rru+jV4AKOypmBY?=
 =?us-ascii?Q?aNUxOaUHebwlWHCucbMEv85O5/SPuVGIXsgZY41WuqAea3tiFEuK52FIKjCx?=
 =?us-ascii?Q?FeFT6xa8dq6PDHo/MdH/M8ik8clmBLN5Fq8YxqwGcSeTQRCVQPtMlNZOHyzT?=
 =?us-ascii?Q?20rGz4FHxapan8hFYuVcCUcrszm6SYlPi2CRcoSAQHtCx7a9VFyNFLnMs68P?=
 =?us-ascii?Q?zKzjlGW2V7L/r/+K/CxLPueyR8muLBQRvQxaMcur?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 312606e9-06a9-41ff-a463-08dd7b023948
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:12:43.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEoJuxIXvvH1K9dse9PZyAeQHOqbeuZnd2abhXGom+Z6QtPkU2d2FgSwth2ejgMgvflinb6I5R6Ieuwib1w/dT2XltSG3xUAFWmrXtjiMx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9743
X-Authority-Analysis: v=2.4 cv=EeDIQOmC c=1 sm=1 tr=0 ts=67fc7d2e cx=c_pps a=RoG0BMNHDmmKSZcrvsSD+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=bVOMk3t7uOZLSsJcZgwA:9 a=CjuIK1q_8ugA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: Zb81H_w3roB05T1b8SC-fpfCK0e1pAnw
X-Proofpoint-GUID: Zb81H_w3roB05T1b8SC-fpfCK0e1pAnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=605 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140022



>Subject: Re: [PATCH v3 6/6] PCI: cadence: Update support for TI J721e boar=
ds
>
>EXTERNAL MAIL
>
>
>On Fri, Apr 11, 2025 at 06:36:56PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Update the support for TI J721 boards to use the updated Cadence
>> PCIe controller code.
>
>Without this patch, you just broke TI. That's not bisectable.
>

Ok will merge this patch with the earlier one.

>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>  drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)

