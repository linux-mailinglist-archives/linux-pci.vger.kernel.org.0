Return-Path: <linux-pci+bounces-33820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C868B21C6F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FEA7A30EC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 04:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF042459C5;
	Tue, 12 Aug 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UUhNuQzc";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="xwAVfM4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9931E47AD;
	Tue, 12 Aug 2025 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974642; cv=fail; b=BZYkHAZIol046w72AAuX/ps9pYyQpC5lfhwFtmiqMF+2qfLzMHlIg3MU5H8JstEQkCUtpHZT05xb3cjSIwYJFjZUZw4VNnK/II/rSQehHI2fvgCPL3zfYUvtoeX/nerc6La+s7tqi89udXnoOjbM3+EL4P6UFV32SPMh+uLi2Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974642; c=relaxed/simple;
	bh=UvIUL2wF57K7XP6Gj/X3lMB005G6c3dR9875aoVA6Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5+yFmsQG8ChAYhY4TOf3vhpW/qpXkDzBlgI3YBdjQo69IFLCntFe1Ok12Y4w4gpClp2z6Bg0vH72oSyJZgahdhBLN+Z5ye69cYdA03HuZ6Nf1LDMp/JUF2xHmd4voQkZWUBVv9GOtjbKLTQOlX+VaBhlenZCVpu2z3+r7L+vNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=UUhNuQzc; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=xwAVfM4P; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0jDAO003827;
	Mon, 11 Aug 2025 21:00:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=1sHnna3L6/z+DAbBPlZ9qRz0VmGdVdy7nQBDHSj6Jko=; b=UUhNuQzcJcPO
	94aV8KrUKEtiTi35tCu0BTQrOKATCr4ebyxRdBeXpDiWeg0LQetgMppMkeWM3eH9
	UJzBel7NoPy4LvoxweLYp5X0MD/tV2pssg/kfTT6YC8ctSBR88bWTKyeixjfu1Qo
	C+gGa5GR6JQXvkUAEIBEvZm47Y8NHROQa+RW9uoTQpdxU7OXu+yVU5ULm5K6+120
	d63X6sHdfUM4RG6r6PfMOtj7oPWdVVeBIAVzd4Ck8OEwu06gD7033oAk436GEoBt
	P19nx5o120aA2ul2Nh+SR2heZvuV47ROrxIQmAtRMCvVNd55Cm2MTgfkBa2YZdqt
	VzNjzhgqDA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 48e1wysb3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 21:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9IJWoCKNdjKW0pa+c6/cy6JUHC35v4s2eqoBmAFbK3ke5eXLx9Mq931bCZTgyd5cR6De0S7LwZb5dZqO5gkNK2FrG13IlZzze+hgjY2SWiRKayPtfqtLru8bNMjNOd2AziZM2ox11G1MQgSrGbOBaTLUkXpdz6vSwbKilcyBheBjcFcGnGdu29XOXJGuojHam5zRutrUJQcoO2FRgQ7KgTtpFPNt+rWvPqM2kYTuhIKIC4yhXoA1MWhcyCq1HbD1U/zkBwCsLJ6D8hur+RnZk1BtMMgcD3E6qaD3Ww1KrrB/xDCCf5b23HbNdrh1eZSE1AteHjHGPSpnjDE/aqIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sHnna3L6/z+DAbBPlZ9qRz0VmGdVdy7nQBDHSj6Jko=;
 b=XtC05e2/FOuIp4oETUli8CA8mngoeDRqcHB7ZsVHQLBgnB535t1bvNJAzKN95hSSl5W67xkNWMLuF4Vw6pGgBbg7J0imC5wr7ElXq3lU/7gtCr/+6wMMOgTS7AgC5aXmEmaX8ykqQesPy7mYvHiut0qcudcbLTGOjSLORvoqZodoaETSc2pbOd3AhNWPsX3kbXqYEQJYqSCC5KUUS9x28tqL3HiJTn7RSQnCBgMmcWQvIlozowpAdc7/4SXdh6KGdZXW7tRJSa4FeemrZ8enSAYUBhdRzM41HLmXrUxXDl6Q79Ol9LmgG66EKgouMp1DnG/TRQYun32dUkhu1ZyHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sHnna3L6/z+DAbBPlZ9qRz0VmGdVdy7nQBDHSj6Jko=;
 b=xwAVfM4PBYOJksknGSDrx5qssOXYbJLjKog7yYTid3Pmt61ltPMfVhADzmE8IJVNpolqnTD2eb2SalWf4HuEIbS7SJMYa5+D0wxqMTx5Lj7anBTccOAMglSnaQTyGNoNilKRshJHjIEECf8z0Ac3vXrPym5FqzNyoi224kM6i5U=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by BL3PR07MB8937.namprd07.prod.outlook.com (2603:10b6:208:338::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Tue, 12 Aug
 2025 04:00:44 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%6]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 04:00:44 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: kernel test robot <lkp@intel.com>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
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
	<linux-kernel@vger.kernel.org>,
        Hans Zhang <hans.zhang@cixtech.com>
Subject: RE: [PATCH v6 06/12] PCI: cadence: Add support for High Performance
 Arch(HPA) controller
Thread-Topic: [PATCH v6 06/12] PCI: cadence: Add support for High Performance
 Arch(HPA) controller
Thread-Index: AQHcCDY3GCpkdArwWEeiGCCxGkjBG7RZLM8AgAU6o3A=
Date: Tue, 12 Aug 2025 04:00:44 +0000
Message-ID:
 <DS0PR07MB10492CF1D21B9FCF3F94D0A4EA22BA@DS0PR07MB10492.namprd07.prod.outlook.com>
References: <20250808072929.4090694-7-hans.zhang@cixtech.com>
 <202508090343.TWUqM8E7-lkp@intel.com>
In-Reply-To: <202508090343.TWUqM8E7-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|BL3PR07MB8937:EE_
x-ms-office365-filtering-correlation-id: 36f41175-1e71-4495-2af7-08ddd954cffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x3piIAuAaE08rmlcOE83vIbXcKEOEl616ZGAidbaLfhGaJvobQphUlHxAN01?=
 =?us-ascii?Q?5KpuQkHPV7qguWocJYyv6RTNNwLFs64c1jSpD98EQZvvc+jeJurxQ0dfL0WX?=
 =?us-ascii?Q?fL5hTzdwZ/yDDEl32ay2cKevFl3DsoDbxTp7tuyLaCPDU+8vM6JbhNvFK9bR?=
 =?us-ascii?Q?yKZt0LjGE+mZO4RasvNVdgbFjLFOijLL8L8bv1W+JDIauNTdAawZuoMQmuLx?=
 =?us-ascii?Q?YcCZugRnnICD8DKw71+qg9wSlmopvpqNz5TTvFiohbMXjeBiiXmrn1JLE6/x?=
 =?us-ascii?Q?dnm1gynYDMHEFvZXhRco3nPBQ9mca3/sJsZ9sfu50sTn8X0qODOqeD383ePj?=
 =?us-ascii?Q?jtQrFSsOSskcXvktxFDK8QYAx+u8XB4XvMksuaBqXuR8/dlyJLTGNhmZw1WW?=
 =?us-ascii?Q?vadTsC6L26Lg3Dc00AUD6cvOAlLHpGVz1W9lhg7TZRXD03/nQHdAXxacnnZ1?=
 =?us-ascii?Q?URmdzp9rsHDpkqQCmmvX6tQpSgWtE2z2fhZhLBCuGSFeSCKNjDdnQDrZTWJu?=
 =?us-ascii?Q?F/4/t+rbFKFRQTYn8uCiRnfqbIw6tkJpZNU8MQADJgBueroaD8s2dSGnKubV?=
 =?us-ascii?Q?EBixer7yTRqPdPVMu7nUMLGlj+GivD6YjR/UH4GlP/6tXG74zmm+IGsgVJoL?=
 =?us-ascii?Q?QUJVI9Zuwahk/9sySAUGyFj/C68yWLWa3MuUVvorcR2eXbTNyT2RZHf2zYRf?=
 =?us-ascii?Q?fRe71Rs3/d/mneFV1y74gI3Iwbxq9vufhf+yKxUfWwNGuEyyHCCO1zCWS0U4?=
 =?us-ascii?Q?veToryOzQC+qArOaC79wVUU2bN0XCuaiv3jZhMm4T2QngIvR1ge91ykEykGf?=
 =?us-ascii?Q?Cfx/lX9aFvVscHwNJ3lEYGNsJHOHHhAlb7q8ZnU+v14cD4t0P2oDKqKb47PV?=
 =?us-ascii?Q?Kbz9fe7UZj0qaxPgdt9YaqD+dHyKwkaC/YbZek14h7fscJIvoxCGAz4nmbYg?=
 =?us-ascii?Q?Vt/g57GnIbT1WnMEQlvoWb6Grx/reRxw19+JiKYA24DGKVxEPcMIPiwlnUd2?=
 =?us-ascii?Q?4CteYhM+1h/ZpvPGhHz0oNh4owsgCzZ+dxZn6CUUjyZtXL+q7WMzmhjPdWA1?=
 =?us-ascii?Q?0G1UTnan3KUTSX/gIU6+YmalWNxBP1FS7uXRyV1Pd/dkXJycJglApubBaDRJ?=
 =?us-ascii?Q?S4r+pxmgsf30os+Aj2d2XFPQr0wKJaVCKmhL/8caXXvTvih7RX3aaFH2gjXe?=
 =?us-ascii?Q?fUibIXjoxFlLN39RiU4fVdzdeg4MnFezqTGK8VVxUqAmUxMoE7dBTHF2ZpBx?=
 =?us-ascii?Q?IKDVkGNksnl/utH4ju2aySu63Q4ycSn6cAr4GCuj5BRAZji8V5c/Wfi9hTpe?=
 =?us-ascii?Q?57N7BHXNMNHwnV53gv2sKb7J6tRgJCNQYp9+6PDKt2fGYILi973+7lJqc/HS?=
 =?us-ascii?Q?JBFWfj7PaXHnaLZt5ZaOErZVYVIFkmvdItqSXhpLT0kezO/NHifkB2LEMPz5?=
 =?us-ascii?Q?ybLjWxPoRKfZi5ysork2TMmEyqEd55bo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8mmID1Pl6gkWsuCSxmi315xPSeZwy8v0KyOQhIatbEgnt/lyMUChpFDmpdED?=
 =?us-ascii?Q?SKJRJk9rAjdotv3sW3S75NjGPij3PRgfn47QIqvxXe1SEaJP27IyJFO0wJrp?=
 =?us-ascii?Q?bCGn2WBjGIIls9JqjhS8z2iMSJAxcZBy+KV2F056ht7552FysljTXcK3pgQD?=
 =?us-ascii?Q?+Z4hnaRm8FTLnU0gVI5CYc4BZUEuacDv25tUm6UKYV1fKbwK3m6nskxeNvrT?=
 =?us-ascii?Q?wRR89qrDL5UXNnq9+A8WIHeqdlXCKOmYYjtM6+aX6mcf8f/q/0kA9TLWzGJ2?=
 =?us-ascii?Q?hZqXKH7O+QnJAYmg+QpMIcux7njg0RgBWeAPeShG2wgLqpqBcqCjh13nvIqQ?=
 =?us-ascii?Q?s89ZPefd/XsX0QYr+E6Flc7gc/DJ9ZyWTOSKp550iTmpb6K7qVedKJwVHejL?=
 =?us-ascii?Q?swKIQyU+JFhUxpwkjkikvGblnmVfpJ2VIKGlichUdeAVctOPhIF+DjgbDiOz?=
 =?us-ascii?Q?5DyOERIW2WswBBe3K9AJbl2fADUNMWAbZPLoj7H1ta/eZyJDTmv7Upm3lelO?=
 =?us-ascii?Q?T/yr+etRVPjSjr3T0vAy8x1Orzyv//3GalsLiuKflVb8TgL7akExXc34ZYjG?=
 =?us-ascii?Q?8NKTdQOhfI6QBI8ipH3LdfEdV03rXaX87QW1/TJTr7j3/ScErsHPRpHvSa08?=
 =?us-ascii?Q?d+rznQbY4GIJG+ECFv1kPX6g/cbc30H0EwTaanVW2bq1PUxzAg/6NKEk13AJ?=
 =?us-ascii?Q?PeqoApZRP1qBv8R5veTrDhJlbqsze8lgkzmDaim/e88UfAaDNIDmhrblaMop?=
 =?us-ascii?Q?2aZ6LymSGV3tfykeQd/BAWd5vJk6+5FLF2giA3TV35b1cxXyByttpC4peHDv?=
 =?us-ascii?Q?gVXJvO3HzJaEwhRbnOXDFraxMJq5VxOrKDDE4J8RveMTspRz1h4tHzKntO98?=
 =?us-ascii?Q?MAtIfJRdTkxmoj1wQEZAI2id/dyCOz/Tu5xPA21ha5KpnGBDHq7syakk6foi?=
 =?us-ascii?Q?aGZmGzd0pLmLejuD8is8r/Bt1Qh4fIRoWdZh5r2rDwHFSim/Zjgatabu5OeV?=
 =?us-ascii?Q?bYMbuoOpkKgy0REYUyPOQlelaKh5F647dSX57r+qCdB/p2A/53O7M5uH1WZO?=
 =?us-ascii?Q?H/BJX0A2LKMCyn3TQe8x7zmgLaHs6OPkU7VTDQmRNWpCiSpeE3shAFEeG2UB?=
 =?us-ascii?Q?wWcrxFPmBYIm1uDlbD6OSRINbdQ8u33Ergq+jJAja/F5sKC0Y0zGv/pnIu5G?=
 =?us-ascii?Q?kXRmeC6gzac2jcMK0ftm21wIQBIujwvwdSmWIBtoXqk8v0lntA2a/YBfJxAB?=
 =?us-ascii?Q?ybYhkxpqwTRTLSW9NIKL4nIfjCLqYt4WM7sk5FBiO0i7GM6719EC6KekWVQX?=
 =?us-ascii?Q?cLCw01G7M2T8Sg35wm/biIL7UvzZRfDUKNfq1q5T8K3DjEwYhf+0dSJcD8Tl?=
 =?us-ascii?Q?79fH+ERnRWCJ8a+0FZG9p9O9XhkcmY+JqeNgiqLE06F3hu6HKjWHZLgEtsMA?=
 =?us-ascii?Q?N6QGKNkMqfvr5zbBKEY+ZzHw5kPD5uZ1BRUH9P8ppmempUG+LR2DwhUQBQ5h?=
 =?us-ascii?Q?tyzuMRLfGgxQf9lTSg2sF+NNIXf8Fvy5+ElQ+Mx286+QZ/hvwPgDP1GEGbKo?=
 =?us-ascii?Q?gVRIlgnIgTLsgLupqfal9UIlcz3Vnv4M/ZLGwb41?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR07MB10492.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f41175-1e71-4495-2af7-08ddd954cffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 04:00:44.6016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK1dGX271I1/+/wbcHfGPNInDAxjRXjeZsgl6ywJ6pPI0VYYt+ECJeQ5PVrVZbBKm0Vg1CkOU2uUwTDSbVCM0RlBbAhsfiFdFMSzC7iMkKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8937
X-Proofpoint-ORIG-GUID: 2k3-WT8UgxzMaTRYvpiM987GBbPjlX9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAzNCBTYWx0ZWRfX5HvPp8O9FBuI 1LeHiecLXXlqgQARYWjZGfrsons4ywCguFA6yQ3e295sZGBg+oGRrUwckFRrbEmSrTxA/5KG1eY QShK6Di24yg3mW1j0VWQx0cxew5FO95PYIgTMX8uBMUhRBgazfanKynZilXz5uHwFV7YfZ0b90l
 Qjyzw+t041sUuW5WzAWXi6Btx9yDESHu1kC25Z7Ixkk5j76U/1QgKTNE6VTomm9tFTYb+rr4YKj LSCghQiK7gT1I5LWfM9A0ZEzE3eyX2Mq0EbBEV5cxOmen7kUcKshI8jGSWqJbtQJUQLoYXuv5w7 AEGMmbji8gUQfwMDzwUVXy2QeKhS0XFPcjCTVnKX/qAqStx8pTGp9EpdzsDHWkQUn2P2YFFkyQj
 u9qJzHoZxk1fPDyrwCga8/4pC1ADjME/DOXab+Aa89I+bJM1ZW+45nmXjYfVQsO9EABETApV
X-Authority-Analysis: v=2.4 cv=Us1jN/wB c=1 sm=1 tr=0 ts=689abc71 cx=c_pps a=Ns4bprCil9VHDTMiZxHROw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=TAThrSAKAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=Br2UW1UjAAAA:8 a=hSHHmZmi1eWprvm0XyQA:9
 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=8BaDVV8zVhUtoWX9exhy:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 2k3-WT8UgxzMaTRYvpiM987GBbPjlX9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120034



>-----Original Message-----
>From: kernel test robot <lkp@intel.com>
>Sent: Saturday, August 9, 2025 1:27 AM
>To: hans.zhang@cixtech.com; bhelgaas@google.com; lpieralisi@kernel.org;
>kw@linux.com; mani@kernel.org; robh@kernel.org; kwilczynski@kernel.org;
>krzk+dt@kernel.org; conor+dt@kernel.org
>Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; Manikandan
>Karunakaran Pillai <mpillai@cadence.com>; fugang.duan@cixtech.com;
>guoyin.chen@cixtech.com; peter.chen@cixtech.com; cix-kernel-
>upstream@cixtech.com; linux-pci@vger.kernel.org;
>devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Hans Zhang
><hans.zhang@cixtech.com>
>Subject: Re: [PATCH v6 06/12] PCI: cadence: Add support for High Performan=
ce
>Arch(HPA) controller
>
>EXTERNAL MAIL
>
>
>Hi,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on
>37816488247ddddbc3de113c78c83572274b1e2e]
>
>url:    https://urldefense.com/v3/__https://github.com/intel-lab-
>lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Split-PCIe-controller=
-
>header-file/20250808-
>154018__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw0Q52SASLPGwt1M
>z_xvH1T9cvMw2V5abHUz_wykYs72cK6Uit$
>base:   37816488247ddddbc3de113c78c83572274b1e2e
>patch link:
>https://urldefense.com/v3/__https://lore.kernel.org/r/20250808072929.40906
>94-7-
>hans.zhang*40cixtech.com__;JQ!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQ
>nIw0Q52SASLPGwt1Mz_xvH1T9cvMw2V5abHUz_wykYs7_AhVc73$
>patch subject: [PATCH v6 06/12] PCI: cadence: Add support for High
>Performance Arch(HPA) controller
>config: arm64-randconfig-002-20250809
>(https://urldefense.com/v3/__https://download.01.org/0day-
>ci/archive/20250809/202508090343.TWUqM8E7-
>lkp@intel.com/config__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw0Q5
>2SASLPGwt1Mz_xvH1T9cvMw2V5abHUz_wykYs74HFn7yG$ )
>compiler: clang version 22.0.0git
>(https://urldefense.com/v3/__https://github.com/llvm/llvm-
>project__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw0Q52SASLPGwt1M
>z_xvH1T9cvMw2V5abHUz_wykYs745bte2U$
>3769ce013be2879bf0b329c14a16f5cb766f26ce)
>reproduce (this is a W=3D1 build):
>(https://urldefense.com/v3/__https://download.01.org/0day-
>ci/archive/20250809/202508090343.TWUqM8E7-
>lkp@intel.com/reproduce__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw
>0Q52SASLPGwt1Mz_xvH1T9cvMw2V5abHUz_wykYs78iupW3p$ )
>
>If you fix the issue in a separate patch/commit (i.e. not just a new versi=
on of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-
>all/202508090343.TWUqM8E7-
>lkp@intel.com/__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw0Q52SASL
>PGwt1Mz_xvH1T9cvMw2V5abHUz_wykYs7_x3Ix-3$
>
>All warnings (new ones prefixed by >>):
>
>>> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:66:3: warning:
>variable 'desc0' is uninitialized when used here [-Wuninitialized]
>      66 |                 desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>         |                 ^~~~~
>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:28:18: note: ini=
tialize
>the variable 'desc0' to silence this warning
>      28 |         u32 addr0, desc0, desc1, ctrl0;
>         |                         ^
>         |                          =3D 0
>   1 warning generated.
>
>
>vim +/desc0 +66 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>
>    20
>    21	void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned
>int devfn,
>    22					   int where)
>    23	{
>    24		struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
>    25		struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
>    26		struct cdns_pcie *pcie =3D &rc->pcie;
>    27		unsigned int busn =3D bus->number;
>    28		u32 addr0, desc0, desc1, ctrl0;
>    29		u32 regval;
>    30
>    31		if (pci_is_root_bus(bus)) {
>    32			/*
>    33			 * Only the root port (devfn =3D=3D 0) is connected to this
>bus.
>    34			 * All other PCI devices are behind some bridge hence
>on another
>    35			 * bus.
>    36			 */
>    37			if (devfn)
>    38				return NULL;
>    39
>    40			return pcie->reg_base + (where & 0xfff);
>    41		}
>    42
>    43		/* Clear AXI link-down status */
>    44		regval =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN);
>    45		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN,
>    46				     (regval & ~GENMASK(0, 0)));
>    47
>    48		desc1 =3D 0;
>    49		ctrl0 =3D 0;
>    50
>    51		/* Update Output registers for AXI region 0. */
>    52		addr0 =3D
>CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
>    53
>	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
>    54
>	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
>    55		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>    56
>CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
>    57
>    58		desc1 =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>    59
>CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
>    60		desc1 &=3D
>~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
>    61		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>    62		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>    63
>	CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>    64
>    65		if (busn =3D=3D bridge->busnr + 1)
>  > 66			desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>    67		else
>    68			desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
>    69
>    70		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>    71				     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0),
>desc0);
>    72		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>    73				     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0),
>desc1);
>    74		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>    75				     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0),
>ctrl0);
>    76
>    77		return rc->cfg_base + (where & 0xfff);
>    78	}
>    79
>

Missed these changes while restructuring the patch again. Will fix these in=
 the next version.
>--
>0-DAY CI Kernel Test Service
>https://urldefense.com/v3/__https://github.com/intel/lkp-
>tests/wiki__;!!EHscmS1ygiU1lA!ASDwczVdgevm90G9xJCBQnIw0Q52SASLPGwt1
>Mz_xvH1T9cvMw2V5abHUz_wykYs7-WOjZLt$

