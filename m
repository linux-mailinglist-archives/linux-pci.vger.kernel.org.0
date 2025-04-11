Return-Path: <linux-pci+bounces-25653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D19A852E5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 07:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40801465C05
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51427BF9B;
	Fri, 11 Apr 2025 05:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YhFlGDAj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="E1FyRcl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21122AF04
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348211; cv=fail; b=ttv7tQgMslnJ9CajYDJRtw2N97v+6rNIkkLUrYCehwUOVLsosOJi6+U7Y8eQKMM0G1OfRU3JHkGnd4XoUzTYYvIlmmaGaGLplVPH0GHhsqntNPfWXAgHRW53Si50F5AJOUVJed3jnP2bV2+VFaUaOVialC+BXDbwIDiPQTATbTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348211; c=relaxed/simple;
	bh=n24umi3FgyAQKVRz4KbqOd3TEWLH2Rmg8k56Bce08XI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OjZDGMGBQsQSZ9u3E2xtOxNMaHpubuZxBOP7bjORswjkd4J+oeYI2rTG1zvy1bLFSpxMPa/n+Fj1Fsbmxln9c+GlPAdZRFjRq6C4uqu07z+JdfALBo5v8Y8TIDE3JGKivBGbJNVz3L2j/AgninOUCrYmps4rTdM6wG3pzaIFb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=YhFlGDAj; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=E1FyRcl8; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwgci026734;
	Thu, 10 Apr 2025 21:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=czuepYI5C+sAGJpE9GSDwxeAPHSFKN8nLfW8XkpCURw=; b=YhFlGDAjdpqk
	/EkbuqL+TwYsT4JtQYkJ/ZU/Z5yySHlxQ2ThYYoX0ygRJQKSFRx150wfIe/tF35k
	0nZE7ep2H5d4d//TvQ0056Lo57TMBRnpzw444YB2Ao41uaGrTamsn4DkgyEgnMBK
	k8rGviFxd/8dFUysiDKKbD1nn191Pc9rXz35KJCNFGBTh8Vcdo2ww2j+tEKjfl7g
	eUQYN+o1ui7J6Y0Z/emi8Wj4MQhRXGjxPhfFpTLwwS8lpkxF7uQi6cK9DSa4g6+L
	qRd4GOqdyXSg5s3686uVO4G5K6S4OyBFfFyVclwB9RASU1sWUqrKcmyFNZcRh3Fr
	Ysmdusq+Ew==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45u03wudma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym1z5hwrhAzIrpm4XDtqmt5U9E78keX0SoZ3hTyxjD1i4LCUn5uHICh5GOQE4hVnBKjE1Mss52pCXupRKP9Fn3aVYpiP/DNQyrn1IoWwEXGdJTNrn8TpUDt6IYR4hfzipEjJFuQ+KgGdg3Ej2lYwFtP2cfQr4VfWykEZpr5K7D48K6q4ezVhHdwFBNgOLK06l7jNj5tGoG1gn48lAOHYTfbo2iKb+HscZ0+u41SxTsjgwZ2CBOY89hXOlgm0xfVJA5bzc5ZwPHbvI4eHvuOg1/+SNOsaB1sYWFLX2gkHeSLaw+czG51DqW51XDxHA4GIvVI/Y2Z8F9cb2JPukasFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czuepYI5C+sAGJpE9GSDwxeAPHSFKN8nLfW8XkpCURw=;
 b=QtnZuzrasntJu56ray/8IBDFVS3gOHzmaANeP4CMAX8gv9q/4qeqXybQ6HkDUnxYVeCocD0RQbaRdxiOOv6LVOlYmHLsq/XH1raN1dgGO/ybrrxlLZzBKyQKoCYyKny9IMPL9utWW3X2y2mXPJcpfUVsopqUQeXqip1nI8iB+xbEeWNwmIQCGnytcoDsJLIvD/Hh4vO+XH1eSeN/ESP67QNf/sWU+2WePZBSgx34892Ge3GBqfHpcyEisLtZThSELBaNUT5ueUKtYbN/lfEatAi9SLGuM6wTN7v8YRQXN1w13z1+Fggpx/DGlQP2Pn/DuU+xK2cIBmiHc+9k4rvByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czuepYI5C+sAGJpE9GSDwxeAPHSFKN8nLfW8XkpCURw=;
 b=E1FyRcl8e6uarq9rgSuHzsaxU6memSvcj8jjSssBnnsxnUNJZ+vuBl8r20uv6bkWNfJ0mGrGdXFpMBzGNzPVLfgs96gnn/vL/69cpv4U0R0avgQ6XT3UNOasrj7R3uhOuH6s8G85pv4GVErnl9M9obER7DZ/3D/p0xj7pd27NyM=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH2PR07MB8169.namprd07.prod.outlook.com
 (2603:10b6:610:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 11 Apr
 2025 04:11:28 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:11:28 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: [PATCH 5/7] PCI: cadence: Update the PCIe controller register address
 offsets
Thread-Topic: [PATCH 5/7] PCI: cadence: Update the PCIe controller register
 address offsets
Thread-Index: AQHbnwkqx9vVVGnw20encWgJa+x1hLOG3B3ggBT+9gCAAhYgoA==
Date: Fri, 11 Apr 2025 04:11:28 +0000
Message-ID:
 <CH2PPF4D26F8E1CC6B901D1FE7DECAFFBCFA2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1C900A703D6DA18E55E02FA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409201836.GA295223@bhelgaas>
In-Reply-To: <20250409201836.GA295223@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH2PR07MB8169:EE_
x-ms-office365-filtering-correlation-id: e6b4d12b-581c-4af0-81ed-08dd78aeef1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k2kgPIxc85q2f4Op9mUo93oPTTLkRKdkoBPMh8iS+noeO8GFyloOEOR3sIuE?=
 =?us-ascii?Q?YGEzRVWasVmUnlXPRwNWx42jdBJoC3pIkTuO8QF4GV5Yia9fMK1zV1pKeGUK?=
 =?us-ascii?Q?xlH8p29S6ZRz59Dl/CsbjuU8EMCVIOZFM0lBNxDx66VkNBw4qajBUKf0DxEo?=
 =?us-ascii?Q?kVX/k7bblZLWpNEUOzGCo/wHf6ygjt+mIB2QUoWgiPBGdQJRDzMNwh33KMH0?=
 =?us-ascii?Q?LQ2FrmtxVHg+pEvNZ21lwro/lwDJrN8jrx8bFCl7FihY+twGz8UaOQN1t6TL?=
 =?us-ascii?Q?hiUV9AIBE1f3kRDnu8c9VnygvgwyRYd0sS8F6Hsip4NHCHBBClAyjk/9XP4M?=
 =?us-ascii?Q?ckmc5UzrosMawg2xTBZxoVdxJGRS+WN2GNwNtJ23KRrlFTxk75CSKs1JSO+f?=
 =?us-ascii?Q?qCGaeF9Jl5mBt86r3CAff+vRcaCmFXSLLHa+bTDOvjD1mABUOLTgpKCuA51Q?=
 =?us-ascii?Q?VdmTXj1de1J2lWrWdN6hRCmtBlosifns5cp4W5qK7BzKK8pc9HawKbeOmO2R?=
 =?us-ascii?Q?8lHjt5QVMIjYOBDE0eQBnq88UI/79LGYX0q3iWs2PP/Qu8RiKND9MKciXq/u?=
 =?us-ascii?Q?4KwyCwFzebx1/Z+Dy+yqygTMhO5U7aNwDNou82UGcbaIOFBnYIFC+uP0fHVW?=
 =?us-ascii?Q?eWJBtl+gR6eDX08TVjbNkc4UZgz2BpCi1hTHx1ImIf+pvwV/T1IeeRxQi50p?=
 =?us-ascii?Q?/1+GpWoRNvz+ZdjS2pQevGOxtmXAZ2gSt3ubYeZaFeqIcnAcdK8WLmb/mRaX?=
 =?us-ascii?Q?g+OyeaD6we5T36WA04geCsI+X0GGJw9kD6aJkZM7G4cLAVM4j29sbZobKg76?=
 =?us-ascii?Q?xTibj7S1agIKLwgXmvoSKeA/lHL7N6OJ8Oj1Vjh0dWETAAAmCN4hXcD/9zoC?=
 =?us-ascii?Q?k2jb0O7S4+iKVOPndLjZypH4lE+IKauqRLKQMqkV1DvsG7iqGd5TTBp/wp6H?=
 =?us-ascii?Q?SG+TkB17B/sbs7rPTIxeB0LfxS4YLcPxjtq8VWfS0FjK4+fLO+mAgmav44x3?=
 =?us-ascii?Q?X0t+faHD0hA0E7ltKfk8A/JIDUCpzjnA+QhxGw4pimFKc0NkoGG/TA11omLZ?=
 =?us-ascii?Q?+2FaxcpH0UTMiIlfLsX38lsZrpsF2TyogtLtXADA0nAThHwmaNpIm94tdIkq?=
 =?us-ascii?Q?xlUV0rwMQXxLw/XXQ5JmkNLXqgMiUUOWCgroxySbIxozcumn7N/AfT7d4vwf?=
 =?us-ascii?Q?dHci0h9GTuJNjzWCWGuvvfGj+AI5f/iFMfZzMvjQlSDzt9gp9aDzVxWejP35?=
 =?us-ascii?Q?l+HYRTZ7e0cPyIX2lnZFM/y2sARP+CtXBnNDV69WsUBVKd4iZLmDjq127xho?=
 =?us-ascii?Q?l9/BAfwZev0NcC+Cz7ynwebhRJTJPs7EkPXdrPfBV9VqJeJGyf2LdzcZov5p?=
 =?us-ascii?Q?GRVlx5arCXTaUiwWuLnM5VQPjo+6Hd+ngUgLYZA5tV2VPyfb7EGkUD5qFagT?=
 =?us-ascii?Q?LRw5HfmIL7Ht2YiOWzNSgllV/K4Ee3lwfyaQj/RzHze9aZRbcrnN4nUOrI/F?=
 =?us-ascii?Q?YaH0yjMmB8dWGxI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NVDfCOsR5o5nbOFId0p2zE/1KHj514rJ7CdtDj+jwbr6EcAbZgIYUfh1scN8?=
 =?us-ascii?Q?cGfpLGeJ43BxqJj4CKs/uMCv5F4Fl6nVF8NsftMxTbXGixlKU12GwhloXqBQ?=
 =?us-ascii?Q?9+qpBXxo0G5eocL+cn6/lyTZzmEJnjIi97tkDog7qWehqT4Ys83yU48QOKtl?=
 =?us-ascii?Q?uamat/S6IP73s1nc8jXRTmJRrYt1ayGBjL5wVp5tAOEIm7icjN2ELBiEAIqw?=
 =?us-ascii?Q?k6fKnPBRWjE3mL5PuFfss2vcwmdsDx7syTFUhybu3ZQHNGB2lc3v7zwILm+b?=
 =?us-ascii?Q?Jyj4qMq7E+hI4mKlGyagup/sEFe8LPhJLorO9brZhQRVFdxaRYWpFFfqRtpI?=
 =?us-ascii?Q?wBn2O8JHWWAB98hT2PEOzdNTuuHznfaX2p34Q6Bt2cnglKpg19Z0l2fj+oQE?=
 =?us-ascii?Q?sqZAzwhJhMaC7mpOt4XyABWxdtWk/ERzSldC71IHGjbpR5M1kVjp+m8iNGBg?=
 =?us-ascii?Q?VxlaCuX+ojcJaVRedGVcXTtgVptoJuIsMK7xDVcf4WnJbV3HhTERorh4YnKx?=
 =?us-ascii?Q?h4Oc/vCR+05tH9qPKzsA72mUTdQCk/9GWDYm//psZkcKfv7/C3dCNYFvar+X?=
 =?us-ascii?Q?x0c0BUICjVRIPIrhgBLF72Oe0zM7iNG4q8rU3KpY0UazCbjTHv1QKAsAjGNs?=
 =?us-ascii?Q?tIqBaoDL9cwFVdsI6XVKsEw1+E+slpLYEvaqrsn0btslOrQ7pm3GOkwDX/E3?=
 =?us-ascii?Q?6aaXfQqT4WKREgJzMa/wUj+Kt5LREmV8P4RiGUZrn1nqkWnzjgACxMIeUmHZ?=
 =?us-ascii?Q?tMNIbnjcaXiljeX9YwDV+7YABGcYUanqUXwAsStew9PWQtYKnY/hEXB6ITFx?=
 =?us-ascii?Q?Vsf29VMID6oAmaFSA5ZNxA5vCBpWOJ7pteRqGd9QAfWOHa37hHxo4VNSskC9?=
 =?us-ascii?Q?70JE4in+NogHhFsQi/6qwUhuldF0Qxmle3Y8ZddVBVEDL+igBTRUWSsmiNvA?=
 =?us-ascii?Q?NiWfxoIht5O8mKLq6ou/yC9PY8gzmuA5w40xTha8poyuOyNiHCtmK9/kq6Tg?=
 =?us-ascii?Q?TStKYLDqHo1yBIuD88WZTzVgLokJUxh02CBKZWeKKpbxIcM94spH6OYzX2P6?=
 =?us-ascii?Q?K3mpsqLoEaLr5c2/5Vk91qwcTiAAsHGdryF2DI4GqnPD76xjuHuBEWAvaEbN?=
 =?us-ascii?Q?wq4d/wdRPnQKHVh8wLBiJ/meplfv3A57Tr7W+cqjG/Xns9YkW/dtjkbmgU2+?=
 =?us-ascii?Q?90OYDcPSas5/dagZxPSs/qtl9p5KTUE4u2KoGZlnmYan77BHKht6yR2HuetQ?=
 =?us-ascii?Q?8LjrfIWBElAwT7rG6S7MtspTQGn8M8dJYBaUKieQu4dAAn8nvRWCx2PAgiJw?=
 =?us-ascii?Q?yyP6zu3sMibiDmr0AicQAmCiRSYXMqej4M1hbyamjmz/g7Pi2div12Xh42ss?=
 =?us-ascii?Q?fi6c2ICfJMp/2/YTMGSyUW87zaY2j3emfrho+pyZkUK4I1bUpXSL7EW4Ua5X?=
 =?us-ascii?Q?gTZPnQQ8rpr4s625Oxfr3lu8QEqC+eoPw1w31bEgth1JNyxtof9BVa50NUk4?=
 =?us-ascii?Q?c72KtdA+94zI8UVChQr6naVGfEoMqrzvmw2/b2v4/t+TU3W7bFl27KXQL0Uf?=
 =?us-ascii?Q?S4E0V9NoPeMTN7/SHOXVFxqQhV0aQ929wqquct6KaNektoTRub2Q2wiuPqUD?=
 =?us-ascii?Q?mg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b4d12b-581c-4af0-81ed-08dd78aeef1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:11:28.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKZv/5rt2tONbtd9EP4aYtVnvBReRQsuJqdCT3u5QbQ5DvSFEQlOCzGu8LsKfErAx3OQ4T3XlABO9mtcPnXFYwGgLoM86aeyuKC5YmeyExM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8169
X-Proofpoint-ORIG-GUID: aZC8NRQER-F3sWLaqlCPxWCmhANM2jny
X-Authority-Analysis: v=2.4 cv=Qcdmvtbv c=1 sm=1 tr=0 ts=67f89673 cx=c_pps a=eoA+jwG2N97X2eoE7Om4vA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=hQH1uh-EvGXYXWIJAs0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aZC8NRQER-F3sWLaqlCPxWCmhANM2jny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110028

>EXTERNAL MAIL
>
>
>On Thu, Mar 27, 2025 at 11:41:36AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Update the address offsets by removing the register bank offsets as
>> register bank offset will be passed to the read and write functions
>
>Add period at end of sentence.
>
>> -#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02c0
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG
>	(CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)
>

Ok

>Pick either upper- or lowercase hex and use it consistently.  Most of
>this patch uses uppercase.
>
>>  static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum
>cdns_pcie_reg_bank bank)
>>  {
>> -	u32 offset;
>> +	u32 offset =3D 0x0;
>
>No apparent reason for this initialization, since this doesn't change
>the rest of the function.  Either the lack of initialization was a
>defect and this should be split out to a bug fix patch, or it's not
>needed at all.
>
>>  	switch (bank) {
>>  	case REG_BANK_IP_REG:
>> @@ -668,7 +682,6 @@ static inline u32 cdns_reg_bank_to_off(struct
>cdns_pcie *pcie, enum cdns_pcie_re
>>  	};
>>  	return offset;
>>  }
>> -
>
>Superfluous change, omit.
>
>>  /* Register access */
>>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u3=
2 value)
>>  {

The next patch series will have 2 patches merged where the additions to the=
 header file and their
Usage file is combined into 1 patch for easy read

