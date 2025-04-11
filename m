Return-Path: <linux-pci+bounces-25648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2580A8526A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184D77B3259
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A627CCCF;
	Fri, 11 Apr 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gna0jt/o";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="U+yqnUMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3AEEB2;
	Fri, 11 Apr 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744344616; cv=fail; b=V25REW/Lc5/wqElcVpHKP/jUzSUi2M+ZWLk0ANgkySxMRg8JJefL6iWLs7JCwNC8mi0R4BzW3P6O50H36tPNWyV7tphcXx1lhYhxZTcChjEz+8VK9Q/hYxxOqwF/gNGELsDfkP4Pq/YvnKWTzqaFVymVGyq9mCyO/DoNJ6p8nfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744344616; c=relaxed/simple;
	bh=6BesAd+rI/F9FZ0c95RQxiwk7Ig3CM5sMcct75wJWDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lG0nWAyO/4BNQOc0btiiH3Z7jgy3gzcnAfCdgWrBB1YgysGJH0beDxSRABaVUPdjmEtSongKP3n18xo/bms/Fen7w6Tu6JLEpZ367ead+N5jOSZCF89dNfDLUb0JXPAOzMitrT0vVn5z7WpcZ4moS7KmqVF9hdeUsJ5TP6AmjKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=gna0jt/o; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=U+yqnUMI; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwgii001987;
	Thu, 10 Apr 2025 21:10:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Hgw83K3ja0/Y84o82aRw5+EVpU3yQDYPc3exinTzqzA=; b=gna0jt/ooRUw
	rDkJbJR96DgPVBeoTo/3BzqG6Rm+rP1MQ/VeTaJC7kuJPw7kLNzAsnAHESJHmDey
	tdqpaw1uUOINv9VB+1bbsUPNkAQIQTn3rMyAgChavIs+iAIC05QzWRUPsLIHZKbs
	SZEPll+NXqX8LObGtzNzazkXzpT9DanviMQ2Prz/QlaW1lHbjqnHaSkrVnl0bBru
	YmYOJZjQ9ciqbYuXJOtWPG2zMK/x7516FTEX2QWUiSgytAfJz80A3NVPz64wjQsj
	w8oRDFGUB4iDj4UcrvP3DLajBiULCh//qrwCtTMNoWmpSRG7VpWVnmq4manRS6U9
	5E32gaHO8g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2wuj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZ/9g3UX780YJBoh/4qrfM1USpXb8Saz3JyDI9J2TrayjxahVCQD4WIpFF3HZdm29ufppzSiTWcjxG4rwuHFV0LjqJIJVs2G1OeylldMxsVKI4Pr4rBlUdwfrUjcWQN9p8XkL0k19csxrXGNIBic3SNHvFNr7Htg8tTzB2+04p+5ZuDBcSX1wLGX/BAv97eD5TEnQfWHzLnEUZApsZlXuefDNCncCv2+pfMuy+IyePmQ2ZY8JUp7JxB/KRGPjrXzWWsIloQCMnpez8/GH4dx9fphWGr0oBRibT/M8XKR0AivQK4BN00YeymU+V0niWCbDweP8i1jp5e4SUzn0CFrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgw83K3ja0/Y84o82aRw5+EVpU3yQDYPc3exinTzqzA=;
 b=PTeQI3a6vZ310/R9YMdvUsf4+OoO7l+O0BoWPzdUALCIJDA65iPxeIwjimR0DxAG8FC/E2DAELuY4XK4nMG0AAgkuSJoKMMUTyzjG3mtZ7alyp2sqWmMct7CJb4LInzRXf/mYgVGv9mM6vkMPapOJt1UOS48YwDFJfraeDYABIS3AtqlomDKioMmvQ20NrJGr9Ab9ma7JGLEP3AOFnp+Ruz9L0hmKk2WQ33xGq8KI4kleXKEdidPq8LHUHJNV1sFgPD6LZw2Q61zeWukdBL4nKPANasWq/nRXSDFtX2skfmkaTAVpPvDkzmGGm5t+TDQoSi65a7KbzGFb/U8akV0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgw83K3ja0/Y84o82aRw5+EVpU3yQDYPc3exinTzqzA=;
 b=U+yqnUMIwSgeXPJt9i1gYXNu/3QHb+i7+axefpUVDz+0iyBoT60jXr9r7Cfeci+24eNqDSWOhLvA5kMUANs5RQVzHqhqa7Ml7bP5BRTnslGzBHY6Apsr4Uenybp23Wkw13zsMe6DsMMpkmqdoAGaulxwnD1xWKk5rx0XbDiofDg=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH2PR07MB8169.namprd07.prod.outlook.com
 (2603:10b6:610:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 11 Apr
 2025 04:10:01 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:10:01 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Milind
 Parab <mparab@cadence.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Topic: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Index: AQHbnwasjE0SelmZSEibiI56xlER37OGz6YQgBUJVwCAAhfkkA==
Date: Fri, 11 Apr 2025 04:10:01 +0000
Message-ID:
 <CH2PPF4D26F8E1C62AAD4619677E94525CFA2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409201104.GA295084@bhelgaas>
In-Reply-To: <20250409201104.GA295084@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH2PR07MB8169:EE_
x-ms-office365-filtering-correlation-id: 62ea7232-5510-4881-8923-08dd78aebaf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TmW13uh+A9gGDtdYuurYUNtHtVzfe1/jTMTwrKBtTi40Cq80fhLRB2lrIeeh?=
 =?us-ascii?Q?CLhwVvVenIMC+XQIz4jQ2QXh7McMWKWC7KuLHRcPn7eke3SCDBbvojqUSTKl?=
 =?us-ascii?Q?nH3CkEGyfr2kr0h1vjTCEnw6MQ34zPvOoaAKHJTtEGyo97/jl5BEStk895/C?=
 =?us-ascii?Q?xqkfnCm1GLFXFyY+8Xel4/j8QFR2zpWJ5gZZnqSKQEX9r55JOMKIcQEgBm9X?=
 =?us-ascii?Q?mTAMiiog6I3yw7mUxQ7SdHn3l2F90tU+8z0hIjF8U7j98Jnfxk93I5u9A+6j?=
 =?us-ascii?Q?xWuSWqUT9UCgk/l81tZo8KaAoPSd1kKQ0Ge7ic+tHSMBH+DhfZXcY/KC29R6?=
 =?us-ascii?Q?Db9MTJZbA1DDNhBs1oh44u0QA5b5dcnPjXxwru6UXxoj+RFQdfXSmfPXeRGW?=
 =?us-ascii?Q?APz9qew3PNT79nOe67kwe73sK7/++8QWn3AqYiSd1u1kqrKQxIUDrz0sz0rY?=
 =?us-ascii?Q?x8McWso8oHIF3b/0j97jtxvfcSdXpnRgYnOPSOsuXSmMlFwKPVbLFGrN0wZd?=
 =?us-ascii?Q?geboTPgtdMEdkNwDvBKSq3EbQOzUy9Agh2N3Gh5NGTrLTmfgrV2Iym1U8Ft2?=
 =?us-ascii?Q?CvMHDpuBG0Pn1lAMScaOmuVelV094zisbTG9sn+41zPxJ7Qdz0kqn7KvGrPv?=
 =?us-ascii?Q?f6IA9Y7nLarZigJkgLAFaWeApxaMEnE6eC8hXIQlSqo4aGhhVNk8+CvNCYHy?=
 =?us-ascii?Q?EFhWABZx604NYC8oDnp51DcjBO+mLxY7v/luqfb2gB8g5BBq2J0VTKfXplX7?=
 =?us-ascii?Q?TerDRlJEi144eJeia0L0rj65iv+U1mzpnxG+aavr5BfBj0scy4ZMBHK0KuIW?=
 =?us-ascii?Q?Tjg6lqSpHzgI3N+RucgPOUQ8KQ2fcvkeSUUsPd6qloCkGssnMm5IJOQg5e0h?=
 =?us-ascii?Q?4q+/iw+srGi2G5i121S2EI+k3FGSX74eCjoJF2US4JR56Hml9OrA4siS/2fx?=
 =?us-ascii?Q?dlZ9hCuIFwZPxmK/ocWxR6WRC79Zmt3f7oPB3nbmziNCglQb/9Chj2noGcHX?=
 =?us-ascii?Q?vsUvAoEuxpRGIqxdVhiH35dyLaolFVEqxl1rhYrxWrcVBlNUxHjzfJEbUkPC?=
 =?us-ascii?Q?mw9kwksHKzJtQ6SMO8HtjUOydIGSIdbFNJZvc8YcOzM/4n2qe8mJVHy8TUQh?=
 =?us-ascii?Q?K2VNmRG56kc2JL86ZoEUCtyBdYy/JVyjDim+OChOQ2n7YT/bLgohoFjgp3nP?=
 =?us-ascii?Q?z+wRVciqAHfLlNxAOu8B4ZKz6jF1NJr6QfQ33rFlZa4qiyM9CHSK49eJVzSo?=
 =?us-ascii?Q?o2R2taxsOyPd7NgB/QNMtqAwo4CKgRGT1xSukZpxycD+r4gn9JCCIO8I1ZFM?=
 =?us-ascii?Q?0wtrveOG0AM7KQd+zhut9e2EJ71eePHF2rMMbNIwl+j+rKayTkAr+d5EdWs9?=
 =?us-ascii?Q?G7bIN5xGLBolOFJdWpjWS7eNOOYoTi52d6C1W8wELoFQC1NY24sTGbbJk0AS?=
 =?us-ascii?Q?K15btD42ahekQfiiUL8c5BT+v0i6/riNM7sVT93FsZn4jaKaH4gTwBfmfjVc?=
 =?us-ascii?Q?sWptBwpSdvP3Q28=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bggfaoru9elNTld5gF7ayxm76xi1AE1VvfRFRwpBFWAaLGYS4rMPk5n/IRCY?=
 =?us-ascii?Q?SUjbvVMd0AphrtrpURKMHiV6iwuM2RiQbyGHaU0uk91FX+NuC9sKFuf7Bo17?=
 =?us-ascii?Q?dRnbwCj/nZ1ULXxT6qnXDDWUR7sngy+R1VBDssQXB53uIOu3ajaFdRpRYbag?=
 =?us-ascii?Q?lP9Gm/vDNBeA7c6ycRh9kyqraklO05Hnl4BRuGRgKmZc0rEn65LntmJarOQL?=
 =?us-ascii?Q?RejGgZka5+5MdWz3RuHgc+5MFe09Lu4tGXnODgyBxYCsLYvT21GR1+DWhuGI?=
 =?us-ascii?Q?BGN+GZmIEMzxYeCYvbYXUsrM/35j1ZpbdXU5DF135GdQEgpzyVm9vJk32+Pl?=
 =?us-ascii?Q?HYS+CfuXe05Rk6H0g9/tBKBApcqsPIRn2XEOpeDP4ghHqFOMggOlcKocNX03?=
 =?us-ascii?Q?3pSWAYsIY8MSs8F5Cfjotk4wPYDdsc7N4Q7gQMFvLDl+28hinXQS8zo41Gq8?=
 =?us-ascii?Q?XCfw3/pk1MhVLzQgqaYzawpGLTI505SFIOeQULjpTKIRvZ0TAUWW+pTNwEpC?=
 =?us-ascii?Q?CwmI/TcQIk0X35uKJky9vS32qlJRMyXCUwQXjbgmKBzNe3YD4XlXPXeSLjEZ?=
 =?us-ascii?Q?lexlm3UVjYnUNq8IX4eWcRA0+YtJC08o6Qkb1TYY3MeOiCdQUDf5+D2+qOwd?=
 =?us-ascii?Q?S/HSTG++Yr+JbRYU+GKmtfzTolEGQH2dkzhANrMcx5NMMkuiDdEvq0WH/hgF?=
 =?us-ascii?Q?QaW4fh5uB1Z/iuQgt2JdUbQ6DrHEpwAt+8AD+eEWt5Q8N5C7E4FZipwE3tUt?=
 =?us-ascii?Q?dI4rzeZwFpzP8n8rGKXnk+Y1Vyosn6yKT1dG/KvUrVDmevO3a0usNcCL6y44?=
 =?us-ascii?Q?ClnqMuAC/AqJcn4iVrID1TW+KeGzxYU0lj/NX19FW+KD7OcU0Y4YsHTJTbKt?=
 =?us-ascii?Q?CSnDw2VoFgjr6NomH8R7V09kcCcmKwZGg19cxNOajheJXebF5Yl4nHoSVtiY?=
 =?us-ascii?Q?HMNl4Exb+o6eqfdR4XPiDK0et1a8hT1DY0hbDmxMp5AgRoJusDsZ7EkdieU9?=
 =?us-ascii?Q?Y8o/Y1mw/tzdK6T6yedRCRXQF/Y7QX3LpDsYhmHroKGnizzxPzd8XzGV/dSH?=
 =?us-ascii?Q?k25jNpghIckF5QwsX4W30XLUixAaiVXg1GiCNK4bc3qfhy2io3VMczFMxqBI?=
 =?us-ascii?Q?5cQqv9yk3JupxeWf8qkRrmmxS7DM83qhx043sTXzckWdTV6Cqkb2S8ZJCtLk?=
 =?us-ascii?Q?0hV/dz+z+IzFI/EVvYpHYANqKPGPy+lqQaVY4gaL3qP4CsyuVGx8PjLTBq0d?=
 =?us-ascii?Q?GGYTTh5b0XywM0Eu/P/0Z4EFOvXTwMuUMAZ1LSgZRWkuLPHNiwl7ni5++0gF?=
 =?us-ascii?Q?WuVcL1R2zQvGcicyhKBfWbbw/koqKEHecRAfLophhk24FOP5TWVHa63ttIYd?=
 =?us-ascii?Q?EjGCKSbJR68Te9GK48qpeQjQaX9+vKOqdcT75HIEjPDyx8Etn4JznyQK0F2r?=
 =?us-ascii?Q?zRoO8nlAKZNfqt7O9XSI4WCTnQSzkweov4WuBmbJ7s4eC5LGohYJaDYOYXPA?=
 =?us-ascii?Q?NDRfCzM67ncktd6Lv3FEawfkXPinIuWls5yv1Tug85ZRjnKXmtB8UH21U+Uw?=
 =?us-ascii?Q?IvCiRI4Q/3DdJB6bvqxSjMVRkIDL/7k9qY0FBzHHi/1VC1eyB0IImZ0FpWRS?=
 =?us-ascii?Q?2w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea7232-5510-4881-8923-08dd78aebaf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:10:01.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8fQCj0h/Pd+z7E46+YRakSREOv3NHfqoGJDUJzCNfUfSobQv3gZNdCmflx5Cu2sV21fS7/3JmCrMCdvq+3YsKBJXzjEkHCJeUpCmx6XAHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8169
X-Proofpoint-ORIG-GUID: 1bcKk0awmGj3eJ7IvxRtow3EIj6l6Yac
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f8961b cx=c_pps a=eoA+jwG2N97X2eoE7Om4vA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=hslJUmW0oW_hk4mgZC4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1bcKk0awmGj3eJ7IvxRtow3EIj6l6Yac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=760 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110028


>EXTERNAL MAIL
>
>
>On Thu, Mar 27, 2025 at 10:59:08AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Enhances the exiting Cadence PCIe controller drivers to support second
>> generation PCIe controller also referred as HPA(High Performance
>> Architecture) controllers.
>
>Usual convention is to include a space before "(" in English text.
>Apply throughout this series in commit logs and comments.
>

Ok

>Others have mentioned the fact that we can't easily extract the
>patches from this posting because of the Outlook series.  That also
>makes it harder to review because we can't apply the series and see
>the changes in context.
>
Planning to send the patches through another Linux developer who has the
necessary environment setup.

>Bjorn

