Return-Path: <linux-pci+bounces-27065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195CAA5FB5
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 16:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A925E1BC5397
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4C01E0B9C;
	Thu,  1 May 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="dYTbOnbq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10F1EA7DB
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108893; cv=fail; b=UmK0AzwohZ1AAUsS3yLZwa2eyqkl3uUvE6ym83L9Eu/UuK/kpgxqzRP8OkFTsj3Q5YX8DFx64BxiAV7dISNRWW34oh4YJ8awU88Z6bgOCa1xkloOTiBBuwOphf7EDTuUBXeftjCsLWuEVMn83t66Py9sXmnnZorUiiDWIvcwBVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108893; c=relaxed/simple;
	bh=HuUrOGwxh32z1iRTwf9o00eiN44q9QzjSNeknuJwHSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ele70ypgy8AWoWFhk/wBRcR7rrBGkMKMno1aAYqtoxS42Gqv+TYJJ8S2QNgS5bGllktuSQJJiyEFq51U0zYS8XgR3Ya6uss++ZzsxhhB/dTez0Js7NIldSysqyKoFenQKDAWSlGQ9xmWAWDPQoD5CSLj4St/icLDic/v+WHLPSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=dYTbOnbq; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418s9oI004149;
	Thu, 1 May 2025 10:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=C
	MZbtQyQA9r26Utse+Zbt68lsvFr88OqGnp2mzQ6AKE=; b=dYTbOnbqYKmrwTqfG
	auFQy5a3ySQ0Yx7tN0dfXNwORgZD7h7S9SSQJCwlkvLfFiJ6ksjVLh2+Omx40EZY
	4c0l5XCY4378KPRkKKgYk7dAwWiLhvB6dkdRxYoaKzpZl3veVHK9XTKWEz2DWvDa
	US3La/Dug/OUqBblt7LxpM8aZFPBA2x+JOxnMq6DG/TWI+QBOKmlgMGqsYquwlwS
	aZwCegVUvFTPUqlMKedrYw4yqLCraycXtm9fGOTg4Q9gGR7YA/Coo4okroNqghPF
	cC8CCUqw2GM+PqeWA01ZygoWg4/OMRolzEYE7Hpsz1GIic8n7pti1ZR9bltpJkdb
	ykgjQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 46b6ts0s0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:14:29 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Dlpmu000648;
	Thu, 1 May 2025 10:14:28 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 46c55v3ac9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:14:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7LGbCRJW/FpLxgg7pDRqUx6QfEz49aFtFCSADY+2PNNIvr2xFoYfpLMazWOgPHh0Zze8guxOpnHHFUSiPSXYbe01+hbpz3BfIaX9A8AQ15TxehsBi2MvHGTI3rjgYvmrVQE3o7jc6qbpjSNL1GqgTOERwrxsZ+lKz3Nh7JX0kZH/fepB0XzC5EZeV1r8Z/yI8eMOdVVdU0ztIq/QUbXYPIiDFCF8R7I6lVj2TAf88NUoeNoEEmK0t5uHL4cBP4HSUE0MwHBOGCs659Ht0YZodjrB62kxeSvFCrvVgdA4mOoIQZs4G0FysKCYOnrW76tj+HtfxFQJE+oL3hk76jvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMZbtQyQA9r26Utse+Zbt68lsvFr88OqGnp2mzQ6AKE=;
 b=Aa166gYEJdui6c7t+ZFWEl1bXYfXJQXzj1GouzRWoJPsMj7F+nsdjlO7AqGy0R4BiBvF+UVD8Px+Okfv+GAwfBUtnY04OaH2sdqkfNlYk+s1nt4xSlNYzJ4/ffL/DCr1+UmBnFBwpPaTK0xO0L0rF1cwL2WuGTzrlUq4zysTe3XvuS7cMM+vTER4kjbE4W0CpuStRyuAQISoopEDh0qXcscBvZ78lSyYJBoENAEOGbjEWvqUj15cKwJmdmjlW6jYyzUY8/7LUAgJHOw7LrNT0v94OHbYfXx9d7PaSjQEulFzbCz2ubcdSJAabMcN6etSV7ttJgrlCeDHN6hIXK0ttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by PH3PPFAC235501A.namprd19.prod.outlook.com (2603:10b6:518:1::c44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 14:14:21 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 14:14:21 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Mario Limonciello <superm1@kernel.org>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "huang.ying.caritas@gmail.com" <huang.ying.caritas@gmail.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
Thread-Topic: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
Thread-Index: AQHbuqNVz1R58+uJDUuaujVHB35ivw==
Date: Thu, 1 May 2025 14:14:21 +0000
Message-ID:
 <BY5PR19MB3922318563A0CFD56A04BF9D9A822@BY5PR19MB3922.namprd19.prod.outlook.com>
References:
 <BY5PR19MB3922D2994064085132D8FEBD9A822@BY5PR19MB3922.namprd19.prod.outlook.com>
In-Reply-To:
 <BY5PR19MB3922D2994064085132D8FEBD9A822@BY5PR19MB3922.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=2db68047-4387-4be8-ae64-8d49fc237fd7;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-05-01T13:48:49Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|PH3PPFAC235501A:EE_
x-ms-office365-filtering-correlation-id: 494582d3-13b7-4a52-8ad4-08dd88ba7820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RDqBcOs+rPrmRJ3qKrTD/CxYh78ZTTyGnXWhkDu03mDYGuEBOO2hxYj8r9VK?=
 =?us-ascii?Q?pLtx1IKp2ADEO29i06TQeAy+oWaDHc0J3euVWvnczjluM5+Xqx46yrvEL6GZ?=
 =?us-ascii?Q?l/6Ej96tfpBKkZEllC3XFnwpY6+G+WkH7T8tzDmPkRxvVdmpAgwcGOAAt7nn?=
 =?us-ascii?Q?DiMKktYcv612ZjOdagBpZnt5wORiJiO0+L8ldILbcJ6SI0aBQDVLQfTy0Vx/?=
 =?us-ascii?Q?fhDgFblfhzWOjoiUKSA5xKCmhzI5T5qRjGdPAK09FK7kIL560V3Ki1LCkAYd?=
 =?us-ascii?Q?JIFy7LuyKess9loEgzEWoObBuOfCxlAKDsTazlJQ71so6GUMedmg1YTPcchE?=
 =?us-ascii?Q?t7AwycoafS0Msl96BZyYS+w7wye6jBJpsOba0HP4wwBu0vzJ/9udoj4l8/IG?=
 =?us-ascii?Q?DVkclapwHhkSjBNUJOqwb1NYyP0Xx/S+KZMayG40zAAQpcC13AqjyC+V9Pvb?=
 =?us-ascii?Q?xlgv4242jcjJ8gOaE8QlvsxX7cq2/InjOGsisYjYNV7vIiLmeCuodrTqpW5N?=
 =?us-ascii?Q?gvg5nsZG0jtAK+9ykJGSu7dU0TXSTB5OzbERCfLmz8gxe4ypjgn8tvc5jExD?=
 =?us-ascii?Q?8Bd+g7SfFU1Bj+1H5Og6jgxvFludxdwHpK3s99VEvf8mEI35RCT9R4fMJGXZ?=
 =?us-ascii?Q?QtzYToed1J2WzZA4O41zgwDcTif/P3ILhebG64dykSFyLDpQLJfBmaepTl6S?=
 =?us-ascii?Q?IEzwl9479dDO1pyICKPejYd+Wri0ZnR1vQ6rb+HhJ/dbGGMCTmsqU+36A+EI?=
 =?us-ascii?Q?811bTBA3YefLMP0zMcPppxTAJnHnFPbS0ReTsVPgYBSU1QbI+Hyh074amgEh?=
 =?us-ascii?Q?+UpnrJAYt6Ft3ekoxfNwCpEowGHoadmi2tnT9vlC1Edr9xPSnlqsZ0BGeGss?=
 =?us-ascii?Q?LKa9SN2ThinS6e1pfKRBm+XJNeGLB6nCIY7I8KoYirIYKuKxOXf8em7KSGeF?=
 =?us-ascii?Q?BAIGkcU57LzIw06MmkPSrqm50HyaSHXIPwq7Xc345qrIE1YOSTTM58vvCrL2?=
 =?us-ascii?Q?ttsDKJ9+iTH5/89tAyfBnemwaL9ojCvOi9n2hosNtVjWIsYUdAn+/tF2K4j5?=
 =?us-ascii?Q?cddj6f9TiwfkDHbkXoUop1uz91RYzMyuCKS09KArc9M22CshuR0boqsLhAfR?=
 =?us-ascii?Q?pt/XeVFcaAqRa+UcuiiILgHk98Ddc1ZedouyAeqEn/gd++DfxUMCtxiV/JQJ?=
 =?us-ascii?Q?AICQ9pmPBqAoteVfF4boMWJeHix+hZ6w2V82gEmZFW4XsC/+fw7c6LLBgovJ?=
 =?us-ascii?Q?GGXCv86V168wVTjeHPJt7txuRKRgpVkl3MnuQNT8yyGVZJuJjGYAxC4VV+wM?=
 =?us-ascii?Q?YkK/mMi1GM44/p2meA1sNxz0sTrguSTbagKcuQE+FnGSDZRISWtdCoNSEgud?=
 =?us-ascii?Q?7siUvlMGSPuzVxkIfGP42YzEbrhl3pRP+779uG+JZiYiMTuzgjpzSLigWyYp?=
 =?us-ascii?Q?HXDTGHStPUdBrwspWXdYpIis63YJ5m364nYOBnG3+mYQP+fVsfHF2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m/dZpKP4KgXvf4lwYxg0WGGeRTEvywzLMj1D6J2b6QgTV2ToG69BD6ps53iD?=
 =?us-ascii?Q?qjRYXv0gfN3Z8hWPIw9m5Z2Hl6WKv060EbC/OZ3HQpYMrvwHBVVNYR9D8OrS?=
 =?us-ascii?Q?LDGLEFLNtEkBbfmG3xylkPvewqc4vFL9pMrPhHh4AWFWkTG+EF9A2qpJQJ/v?=
 =?us-ascii?Q?+T17ShlASpolXzYvJ9pCKxWlMZGSyFRVHf4B2Id6veZ6suvVp4h+zsrk2Mzc?=
 =?us-ascii?Q?rF2kt8/TQkv4taLD+hon06wTIv/YnxwmG6e/OHyn/TwuboyEsNfsita+Y93A?=
 =?us-ascii?Q?Kd5JQMEULShRSF9e/t5vObuhRUD15SX6iFwlhq+yX1h7US7nM2/RDyhzoJwO?=
 =?us-ascii?Q?4rbxH8EJg8Fnyujq87UsKHPKiPQ7A2S9UIHHkv4EIbOJH/hfyZ8VhqL2YINp?=
 =?us-ascii?Q?u/ocRUxrNGaeNjN0GWCoSQ/jJAh3ga2NEAsD/nSJQr/BTfV5DeXD+rAGPt/j?=
 =?us-ascii?Q?Ipn0g8Zkzq1kfr06VdVTcOczqbPACogJzS7JvWAsSNaZ8AK5cnENHG2vEQBr?=
 =?us-ascii?Q?JK9kpN4OOP+fHdHikln+VyE4mbcbvTtoyGQNv5TgS8dIDmdHteKVLW0j8+Ki?=
 =?us-ascii?Q?ti23iY8Kdp/e0EaF9Eiowj6ZZ/CTEV4OLcmHhdKfBLtCj+iFijaJC7h8jWOv?=
 =?us-ascii?Q?Yj1NOqVD4xgDgYcij7Qm4iLgPFozgJI8ayO9PEdk9Rt3ui5Oz/b0xsng9wv3?=
 =?us-ascii?Q?FIACkF3oE1rUPTgxcXHMeeqhFbt2cgxTjgngRGFMqyNiT1Qd0s+exNKYK/rz?=
 =?us-ascii?Q?aEiBGUmvp6ilPAxeprNzt2JmU0lUu4/gJQX8GQOQodW4GOMnIUZjlPeGV1Sd?=
 =?us-ascii?Q?H7hQcNR9sLT+NggP/4MNjOE103ESk4CorQXsBA2I68D7Eu+Jpa0uyiQR+wAp?=
 =?us-ascii?Q?eeb3HTXDlxKDHsI1/wF5U/d4HjvbSCMXFBw0bgEX8XaWG8LJu1l94P5IFkOc?=
 =?us-ascii?Q?CT8Xg8nodz/gJbbeM5C+nAny/Bp9N6iAtgWJcpmEPY5raAKWt6z4SPSmw3zm?=
 =?us-ascii?Q?rEgc4lNrzZxqPKDF3mbFz4htTROgDH8ahV8q1Ycc1R1duZzyv1rILT7vOcZV?=
 =?us-ascii?Q?9v6/RsOuM/Iu4FJ9P62umW7xWIzhRiAOazx5AbOlLd4FtaafsHHeUaBgtMB4?=
 =?us-ascii?Q?HQptmbgqJE3LHA+bBcmkrR7Ay1ij1t9Gog+IEQmt3Hy34rzsAXYWsqYAjNP8?=
 =?us-ascii?Q?2B5RTVvtkTVBuiuwCoOoa2X72qvpyy1O1VBPtIBMtZ3s3LrMG1QoMW54JPDp?=
 =?us-ascii?Q?K8NkJhAWuEQN5ubDfUPB0hWKO9Q32egRsmiNQOudvGHvv7hIXlQTfEngLvct?=
 =?us-ascii?Q?1e110ossHp7Zstk9dgGCumNmwq8rFHesona102dUqbnCCZLujt2+uTrMuZQZ?=
 =?us-ascii?Q?ZRfUa1Fksfu9bHm++HPTsEUGILcJDI5SC4+TaUcyBlUliCnzPR8n4pGAonlT?=
 =?us-ascii?Q?ewRTTtMrwA0bC71pGSBqT3H5WL1B0PwekYnlqRJwUKt6XmjcRTdl6LaJfSPN?=
 =?us-ascii?Q?kN2RVLDAxtafgBS2trcWhinr/j+4gHDZf46w1SgmxRiQxUO7g/C5ktXv45ro?=
 =?us-ascii?Q?Y/kQLtP7GL8bGmUIEmDikd9SJ0zgQNeGPYljquW1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3922.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494582d3-13b7-4a52-8ad4-08dd88ba7820
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 14:14:21.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YymUvY3Hn0FWo11WW635mcaR8240C8TIKLz1el32ptUD9ce5ceOYkmLrye1jCxjTDeaSyax6j+wInShTT62z+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAC235501A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEwNyBTYWx0ZWRfX8+LIYq3gXyif GckbF/MIhAhURfoSooJlrTLorCO2LBSQ8UgaPrRM4MqTAhjMV/G/QXc63T8CR7NA8HK0r5AWfw1 eKUgOVJEKAYBFCdWrAaaspHvaGi9jX8+vIg6FIiJ8zg/X08nmcMqxs5BPKpDEc7S7CHsLdadzDS
 rm8Ja/bDL3mnRN2XNt23kTeiLnK1X0NlyAOfI0wyqgj5TFSxcMEd262+BRL3MnKuZGfT83fbfFK KbH8viiR+2it+zmQedzvCnImT5kqSTdxtanMyifXaRFAfaJubIV42R0jJB+O5MLZk2M6OLiozlh SssnfFM7y7rMtlZWhzAX2IGe18GgrqZM+AvgsUMDBaI1jd+bkOT+DWc91gU25vC7fEPMohI7Lbt
 55sdxqBmgCF8d1DXOYqlDypB4Ng5vmZiW9Jeuofb6pCJez8Ug/wDmew1Zasya4Dwc61mbwKr
X-Proofpoint-GUID: NVaLekmJKJGqbaOR0g15D964jYnSQc4t
X-Authority-Analysis: v=2.4 cv=PLUP+eqC c=1 sm=1 tr=0 ts=681381c5 cx=c_pps a=j0++y401J6f/BxNAf5EDow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=zd2uoN0lAAAA:8 a=iLNU1ar6AAAA:8 a=IICk_OI6UXWMu6ek2N0A:9 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: NVaLekmJKJGqbaOR0g15D964jYnSQc4t
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010107

> From: Mario Limonciello mailto:mario.limonciello@amd.com
>
> AMD BIOS team has root caused an issue that NVME storage failed to come
> back from suspend to a lack of a call to _REG when NVME device was
> probed.
>
> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> added support for calling _REG when transitioning D-states, but this only
> works if the device actually "transitions" D-states.
>
> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound
> PCI
> devices") added support for runtime PM on PCI devices, but never actually
> 'explicitly' sets the device to D0.
>
> To make sure that devices are in D0 and that platform methods such as
> _REG are called, explicitly set all devices into D0 during initialization=
.
>
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> devices")
> Signed-off-by: Mario Limonciello mailto:mario.limonciello@amd.com

Dell hits the same issue.

Verified the patch on the issued system, the issue is gone.

Tested-By: Yijun Shen <Yijun_Shen@Dell.com>

> ---
> v2:
>  * Move runtime PM calls after setting to D0
>  * Use pci_pm_power_up_and_verify_state()
> ---
>  drivers/pci/pci-driver.c |  6 ------
>  drivers/pci/pci.c        | 13 ++++++++++---
>  drivers/pci/pci.h        |  1 +
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c index
> c8bd71a739f72..082918ce03d8a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev
> *pci_dev)
>         pci_enable_wake(pci_dev, PCI_D0, false);  }
>
> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev) -{
> -       pci_power_up(pci_dev);
> -       pci_update_current_state(pci_dev, PCI_D0);
> -}
> -
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)  {
>         pci_pm_power_up_and_verify_state(pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> e77d5b53c0cec..8d125998b30b7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)  }
> EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev) {
> +       pci_power_up(pci_dev);
> +       pci_update_current_state(pci_dev, PCI_D0); }
> +
>  /**
>   * pci_pm_init - Initialize PM functions of given PCI device
>   * @dev: PCI device to handle.
> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>         u16 status;
>         u16 pmc;
>
> -       pm_runtime_forbid(&dev->dev);
> -       pm_runtime_set_active(&dev->dev);
> -       pm_runtime_enable(&dev->dev);
>         device_enable_async_suspend(&dev->dev);
>         dev->wakeup_prepared =3D false;
>
> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_read_config_word(dev, PCI_STATUS, &status);
>         if (status & PCI_STATUS_IMM_READY)
>                 dev->imm_ready =3D 1;
> +       pci_pm_power_up_and_verify_state(dev);
> +       pm_runtime_forbid(&dev->dev);
> +       pm_runtime_set_active(&dev->dev);
> +       pm_runtime_enable(&dev->dev);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop) diff --g=
it
> a/drivers/pci/pci.h b/drivers/pci/pci.h index
> b81e99cd4b62a..49165b739138b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);  void
> pci_dev_complete_resume(struct pci_dev *pci_dev);  void
> pci_config_pm_runtime_get(struct pci_dev *dev);  void
> pci_config_pm_runtime_put(struct pci_dev *dev);
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>  void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
> --
> 2.43.0

Internal Use - Confidential

