Return-Path: <linux-pci+bounces-33819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B6B21C4B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2486853AE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08B2D780C;
	Tue, 12 Aug 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KBrqzHm6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="uSR0o85Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888B1E47AD;
	Tue, 12 Aug 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974066; cv=fail; b=L9Wc52YUgqg9EoUw0jfHt1BNRbRsU7mq3altrlX3Lezx3xMubeSt18UZOqf2Ku6O5n/cOfyNNdgvJs5rFpijxwd0MUrStMwlYYpiUkCyfpZSamC0Jd+r4RFwxDwJE7aYDmhbapT/bSGdyzzZmdP9XZuQi3P32zqfUJKFIrKo12k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974066; c=relaxed/simple;
	bh=qjooq3Rn5wFYy+mqSKoM6ze0MxCyV7cysPmwv8ZR/3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SL+Y0NPTUEREZX0XLdOaukpoHT7Hb48gdzZQogbl6hME41P0mye5Zit658LME2nRnmFT7yej+P5cPZTdZsuKCBwx4jQhoDT4PKr/DCxwy7pIFPjjKA2zUXqtTASvofzkZPiVXSG4twmwdyuf+0i3nfReXHdW0+KDxtgD71JKIv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=KBrqzHm6; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=uSR0o85Y; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0k0gC012114;
	Mon, 11 Aug 2025 21:03:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Uh48nqjaj9o0ilj1yImRQw5xOCRKslEtMJ+ADowqsLQ=; b=KBrqzHm6PFyC
	P77ZbFR8L0z/9JpooY4HCMGWA6n6r9/BWiXelQI1w41n0MlDKZj3sehZwT6h2x80
	ea0i96QySX8iFSlbYVy/+VgX8K94dcsg1udp2f3qOzv9lSbyVkbn0+f4hfd5nvlJ
	wiiGE3IWcPC6HEMlkolwfDdithQbVxIWJoWTxRvUPXOPpit9KbER0dQyoOUv8G6z
	z1+smvtmS2HP7l4oaQGX2NjOZ7HUa8LuO88CRdw9GkBktxSSlqlRPPhm00oQjdW3
	HkngsRl1FG4W0s+Ufr2nKduKAtVwAFegxEzl5lteozfV3iTxp1QXf2EIu2Ar+iO/
	8OgkFaJRNQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 48e2vwshpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 21:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4dBqU80n3cdRdp/30ksT0kY1Wi7QcyFwLhQmMtCgNhjh2vOc/sc39v9gkL6LqBPVARsAG8MAhaArp+fmBiyIh3okYU2P4ASpKMABd0B2EJdf4CrLNwG+wVGBrBOfa0fQtplFoByziEPZgWtqiI63OBJEviMcCfTlskGha0ZtxEOswe9AAeSqhENxGirmq14o7mbaGPPbak3moH2ex+fG1HlAxtQXqAsP3sd4AhoV+chmx2eS413+qHC+bkbAOWnZOQ4w05Q6zSa3sDtqiT2vSLUZ8GUzdFyG8fpH+m7IDodZ7UyVo4EWuZhlCZukEWrB1YjWt34E3VbhUjZQSmlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh48nqjaj9o0ilj1yImRQw5xOCRKslEtMJ+ADowqsLQ=;
 b=zKxROaZ/Or5MuIGd1+7T1DDNF/57Yt6NrjYM4UP0Ba3mbJPDAeanmX+kPeg2ruE1zV/qgQZQsrIvytriv4w0oVqONIJINBIvRTUwTV3E48qtxM0U4XlgD43JIpCbCZNPvAKSKFQz/L8IeXhAMK4fny7HFiedpGKUfa7Q0JLA5rlbQPB722aYo9FNEN3/f9CYCP0Qhd3EV+sT8iNTfxJXu9cG6063GQ3JAzkbOv9m28FsjA8iBBXB4Ii7Q9e6uTm/Sop6WjTHo7j1bd+hFRbjdC22WWdxUzg85Ijy5mkRd0uvwfN942SzkAjs3suzUiQHW2i3bh+FsNdgyMTxix+TwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh48nqjaj9o0ilj1yImRQw5xOCRKslEtMJ+ADowqsLQ=;
 b=uSR0o85YaC4oPvTPHLGklZTDBudscSYc2nWQjsO3BtFCKYPj0NIfNqv6/tyDQjK1NOsJJih0DZ5XAAnQZPfi/77OvU2oiXNRdTFlF89+No58iB+rPV9IXZBkyGJRa4N8nXScCOsryIy4YK83Gfl5xaiFCosQN4KqzEDwV8s8k1s=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by BL3PR07MB8937.namprd07.prod.outlook.com (2603:10b6:208:338::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Tue, 12 Aug
 2025 04:02:57 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%6]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 04:02:57 +0000
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
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
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
Subject: RE: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into common
 and specific functions
Thread-Topic: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into common
 and specific functions
Thread-Index: AQHcCDY4N0WF98bIc0mW+Sj+/66gzbRZacCAgAUBSzA=
Date: Tue, 12 Aug 2025 04:02:57 +0000
Message-ID:
 <DS0PR07MB104928BA72FC46C5CA2D4312EA22BA@DS0PR07MB10492.namprd07.prod.outlook.com>
References: <20250808072929.4090694-5-hans.zhang@cixtech.com>
 <202508090739.3RYjIgG3-lkp@intel.com>
In-Reply-To: <202508090739.3RYjIgG3-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|BL3PR07MB8937:EE_
x-ms-office365-filtering-correlation-id: c072f974-cb66-43c7-7603-08ddd9551f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5zh5jvqwiFgOOn7GJhJ9bClxxnqTrgfSwlTwD9/A3KqsPo4MIOXm9XByUCQc?=
 =?us-ascii?Q?O8NliQ8m58u8aSityForYYpaudwN6QY7Gm54ZhhGsKS8UIFi97HgptanX/Pl?=
 =?us-ascii?Q?mxXI5xKmzRmz0YM5mnZ+9twSFtU4dndunB1O5zbLWVFFt3vxBmdcy/oel613?=
 =?us-ascii?Q?nmEFX1ej2wtUTpjvcjEWp84kdbLgDYEfYaCnpUbfIiujtojd6HWt5lQNulbs?=
 =?us-ascii?Q?e8mC7CQgiGfHWaSfhMtK2a6M/JIZZBr48LzVlad+IYY4u30vYb7+50KpBLB1?=
 =?us-ascii?Q?QC9lXXGJOtDnmKhYvAhGK2egXfZqxylW8brDY5pmpUXH8AEMwXmdtPy0z53e?=
 =?us-ascii?Q?DuGJDaYF/IsK9IXwnuuxpXjO71OPdL7UsPxluaT9HH51F9rxW1wuzvuq5hHf?=
 =?us-ascii?Q?G37I5YtUqd7bnpghSEuUAMt6TJeWyhlYZu+wQirkaQPhD1QIVb5JF954ttHg?=
 =?us-ascii?Q?BwQP/gGcuLepdyWyt+kymwzrR8/zgWgqim6+x2t6WbyKAplp3mJ35AzU6YQH?=
 =?us-ascii?Q?ysZkbgmJe9GkGz9HTZtiWxaGRGP/ougZ6wxst7MQljE/jlQkDVoPWS7pJ55w?=
 =?us-ascii?Q?0LWf6at2LFe4jD11oNerk4ofjmbCyS4cCA0Bzi3zBT0h+l/D7Axgp5JBz8pu?=
 =?us-ascii?Q?LLmak21/RKU2eCcZfDzapfrGN5Ho85jfUU2TbeYFpZCdYO1PxuZYGmO0HOIb?=
 =?us-ascii?Q?CDVrUo+YwwCRLhFctjNarg0d/1LnmdeK8rF3MtP3s3RJAilWcqK3JUDd6dBP?=
 =?us-ascii?Q?Kry++pgo8ZdBQLOTNKhK2J2MoaNm774sOT106X8McZZN673HB8cCsT8sHf1h?=
 =?us-ascii?Q?OU5danjAvo6wTIcAFNZj1ndKskPS+GUVGY4hmhhyY+NeWLXaeEZbDv4exNva?=
 =?us-ascii?Q?docBF3nE1s9coUTEoVY7tLDy36Z+iZlu1FLJQO0rZgLwUFqxHdo9uFTxV/8B?=
 =?us-ascii?Q?sThcF9jIjERwX9uqL1uO/wnOYhWaiXERXDR5a6QwCOEJmIGIehX+yaIQDa2q?=
 =?us-ascii?Q?DAM6cT1HMQEBahl1ar7H+PphybdOh3Fth1j0BV7G9Tg134+huUnNdzRfUhS8?=
 =?us-ascii?Q?wVVgIA1cKQGz1E8L8UYz1wUcK3RmthMsUoNhIs4f1QueqiQiFre+v4nglir0?=
 =?us-ascii?Q?WIBa8XphVDybD1clOaqlQd97NIf0XGHxjrQX2DnCGVjeu0AOFVuUCxdy71Hg?=
 =?us-ascii?Q?ROkOUY6oyz6KHfC5wL5EyN7rGCPPXtrmSVlys+XVFdZaIkC0HsRW+1KlY0Ad?=
 =?us-ascii?Q?H6Lhs387SwJJGUIss9u/7vosJ0fQhe06M0qoIFLNyHIh1ewy940V+kSp3J/x?=
 =?us-ascii?Q?xAXuIdHwljVIfkv7DlENITOnmhzKBVqR4kEvQHA64S7ZshAeIZI4aJtJsZq6?=
 =?us-ascii?Q?nCLmLAAIdnAk7lCcm66hXcn3gA+rrLTUISLsSgRSkWuZ4REQ1VnvXDi5l25Z?=
 =?us-ascii?Q?UCo6ccct3LudEaeI/Nhw4qToDJvTuweR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IwbVePfLQsoGU/IfjaXQqCKgo3JyHgX710lfYt8042n00/Hiai0Q4SB7khMH?=
 =?us-ascii?Q?Jy3EImjiZzkMwrg3cBYzxtGfARZmaTHutcto+Lz1iPvyqmCEVmSF49EZDeaQ?=
 =?us-ascii?Q?kZLn6/ugAoU4ztY5eA8ee6T4o90H0LbZZjAz0XMP1vY/BHTdMxpuYFBroBDL?=
 =?us-ascii?Q?y5RGV8QNckgOtedWvJ024dqOOIo8EDLp7+AP2DCYBr1p6zimWaTCtOt/11dI?=
 =?us-ascii?Q?iP0xb6SyZHrLSq7QsbEK5t7TMLRvj29qCctyp0O0EeCAfNeBxGY4YuAD04B8?=
 =?us-ascii?Q?jlSfTJw6BUWdGjWwhfbMvl2MoPnqPtcj8fMlns/sUdFQrONxdr1r5pQ/gtzI?=
 =?us-ascii?Q?9q3KdaYDv7ASplNOiuohECzRM2+SoS4W0D6fa4eo2syQQdhJc3SY86SK1gXs?=
 =?us-ascii?Q?ixdBncLQoenIRHXseSRJfLMLz1PSNDTwSOLr5e2TH5rrtSvuEURR7pO2FXx9?=
 =?us-ascii?Q?qU5/1Qdf7H6mReOmeKlcVt6VNF473EoZ1zVxsQszWIyvd0rpExHiXOFv3nkN?=
 =?us-ascii?Q?rTsMxbO4namMdpCErGRwMBaS5AXnmQxzpJ1rt1i7Shri0ZifIifBuRlQ988Y?=
 =?us-ascii?Q?HYTGIYJq/LctBcpcSqQvyGEvSRrekNe3zDIdBwi/rTcvcnSF52ee8pWRli5j?=
 =?us-ascii?Q?nrRNkm5KBudoKabsC4N5mwIP/1h7+eUdIKCNTMfptalF5Ux+08wqTR7CCD+P?=
 =?us-ascii?Q?YLBh+1bebvpTAyJOJ3MmjB/NS+rzHrocRlgElTunxUWjA5cikwYPNEdjotvF?=
 =?us-ascii?Q?Ee6D4jkbLPaMm6mBWzko9kGboWcY6uAgniJiYPYynHnvEDL0sgvdjUjk0lMS?=
 =?us-ascii?Q?QvwR8R111h397SDAGPjQTMU8J6rqu7HEKmu4yOlQqJGc/QU9fpNSMaQg+O/N?=
 =?us-ascii?Q?y8oPIkIeUOcdWsB3OTv52HT6w62Jina0xHvP2vitGQx0Hqdswg8y/qZDEdQ3?=
 =?us-ascii?Q?+q5bbw/SqdLTol8Ds1D3ZziMf/FoZHyIfF1LkOh1rhvOFph4f1L9EnpYTBaV?=
 =?us-ascii?Q?gscL92iSH9Vfym4Dygu5pE75CR2P+XJR85bvJYzjENMqkeQQhLbshaqnocdL?=
 =?us-ascii?Q?CYXi/p7NkdUc6EpW3BEYSREGY6wC86+bYAh+L/fBqs8rbMoIU6KhewcMvmfs?=
 =?us-ascii?Q?+q2AYEK+IGypu9VA60hSdS8q+LnyPfAsRE0kpseAQ2PPKoZREHxiNIFhnatw?=
 =?us-ascii?Q?RGM9TnlC/iurX7Q49ge3PwIkWXuAlf/7QHzqYoe/Hto5AkaYBmpqO8NmxUaE?=
 =?us-ascii?Q?Pmm7FQh/Ls0x9aPFKnlSGtWg2gr2BnhsrO4ouAnNbZAmldhU3mCH4nMCuBsW?=
 =?us-ascii?Q?gLnGbtUZ6rDsHcKumTgQkas6X6k6+pdO+zx0NgnZA0D5XrC5onTdYUiSxyxh?=
 =?us-ascii?Q?uOKaVc5Um2nzsWjyQtrgDle4Eh2TuNe+TxIOQlphctCFJ12OCGTbMLXQN/KF?=
 =?us-ascii?Q?6MkODftt4B6YH6RYfk1WDk4hFidG0O7Y/1IdzncKOp181a62CR395bXQJ40W?=
 =?us-ascii?Q?x+iUeGYjpg6IE2sdGa2NP0dCHAte8eHRVpV5cGB70ur1XGoBSoxiHMWVOYvR?=
 =?us-ascii?Q?/iHfOTuhiQtGd7uhFnOAMV51rbjZ03q3GDFA2Jg2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c072f974-cb66-43c7-7603-08ddd9551f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 04:02:57.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68T4sO4iTtu7hRXQY2sxJopDUxks9ER5p+qi83KGhU548XDiQ7B2j+1Ly+9YJ5OSvr8ZaQ2ZycpoWnrqtZY9pjOebM5k1xTIG9JeAj6eoFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8937
X-Proofpoint-ORIG-GUID: fZECZTWpg700VWdQqFuL5uKuBzLJIMkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAzNCBTYWx0ZWRfX2VX8qVXrkX+W 8LyDW1PMFCWzhk8uabwNn/YEm871kJHgYZGGLRdM6p7EMHp4EvSWcg6Ly2YPxls8x1IWMs3qJzr ugiZyM7bAaUz0iZyH1lnKmLZAIwWr13cqwaq8QVlA5iQiy3MDerG8SuBBmeHA5Uz+hqZDaQ/DKG
 pIb89n0G3rwlUUmRQGlfb8Q3aZVguEJA4mjOYHZ1ckrgnqR44xuCPPvAR8+zR3onRKPNq3dxj0U sMUdkz5wgmYMK/LYxa4nZZbk6ntFVQyFuldzWVl0ntjPzy4Xb9SNm2dNE+t9LvL+1Slt37ncTlq yoWp5Ywil6JuPjxxDg1Mm4pQ5JR341atkk2wkkvGZy7LFzW6zDwp7+tyk/jDOAcdZJLJnNwrt7Q
 UfonCsikYKu2KI0iuSJDg5rk/Icm0hgcL/aXZu6jDAjkA4uJ5hAmoJPNeyVsNQ5wqZB6Dp0h
X-Authority-Analysis: v=2.4 cv=DM+P4zNb c=1 sm=1 tr=0 ts=689abcf4 cx=c_pps a=UKvgJB4ZXemRNA6BSV974A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8 a=UQ1KzaeZlQ67ZmSTAHcA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: fZECZTWpg700VWdQqFuL5uKuBzLJIMkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120034




>base:   37816488247ddddbc3de113c78c83572274b1e2e
>patch link:
>https://urldefense.com/v3/__https://lore.kernel.org/r/20250808072929.40906
>94-5-
>hans.zhang*40cixtech.com__;JQ!!EHscmS1ygiU1lA!DCMSkhopul9WR7Bz6BCa
>m7-cqprQN2T7O0M83IllBZ6nXEi7hwKQXWn-N__dQpy98AyjD0M6$
>patch subject: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into
>common and specific functions
>config: sparc-randconfig-001-20250809
>(https://urldefense.com/v3/__https://download.01.org/0day-
>ci/archive/20250809/202508090739.3RYjIgG3-
>lkp@intel.com/config__;!!EHscmS1ygiU1lA!DCMSkhopul9WR7Bz6BCam7-
>cqprQN2T7O0M83IllBZ6nXEi7hwKQXWn-N__dQpy98Fre9nYP$ )
>compiler: sparc-linux-gcc (GCC) 8.5.0
>reproduce (this is a W=3D1 build):
>(https://urldefense.com/v3/__https://download.01.org/0day-
>ci/archive/20250809/202508090739.3RYjIgG3-
>lkp@intel.com/reproduce__;!!EHscmS1ygiU1lA!DCMSkhopul9WR7Bz6BCam7-
>cqprQN2T7O0M83IllBZ6nXEi7hwKQXWn-N__dQpy98MwL-lRS$ )
>
>If you fix the issue in a separate patch/commit (i.e. not just a new versi=
on of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-
>all/202508090739.3RYjIgG3-
>lkp@intel.com/__;!!EHscmS1ygiU1lA!DCMSkhopul9WR7Bz6BCam7-
>cqprQN2T7O0M83IllBZ6nXEi7hwKQXWn-N__dQpy98OsjU6W4$
>
>All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "cdns_pcie_host_start_link"
>[drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>>> ERROR: modpost: "cdns_pcie_host_dma_ranges_cmp"
>[drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>>> ERROR: modpost: "bar_max_size" [drivers/pci/controller/cadence/pcie-
>cadence-host.ko] undefined!
>>> ERROR: modpost: "cdns_pcie_host_find_min_bar"
>[drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>>> ERROR: modpost: "cdns_pcie_host_find_max_bar"
>[drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>

Modules build will be supported in the upcoming patch and should fix the ab=
ove issues.


>--
>0-DAY CI Kernel Test Service
>https://urldefense.com/v3/__https://github.com/intel/lkp-
>tests/wiki__;!!EHscmS1ygiU1lA!DCMSkhopul9WR7Bz6BCam7-
>cqprQN2T7O0M83IllBZ6nXEi7hwKQXWn-N__dQpy98FQM1doJ$

