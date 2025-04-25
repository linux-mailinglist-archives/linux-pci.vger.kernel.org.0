Return-Path: <linux-pci+bounces-26721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A961A9BCBE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 04:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D701BA5B39
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C3155C88;
	Fri, 25 Apr 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ae0m63nC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="z3alpOf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817F14A0A8;
	Fri, 25 Apr 2025 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547567; cv=fail; b=HejbnGYu3FHmdXa7fKqBI5XJRSH3GgaN80sdCflaYMHyr+YiUunCqiEmYUoHtpVG+I1awT8saHmTRvTYRS5HF1uGRm6vSExfieHV7Vv0HkEUVZLTl75NwyClMSvptOYLDndNIlYynQ9Oy27EJPLM2sC4mtBai5zQos1rJEeADsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547567; c=relaxed/simple;
	bh=wieAikUHU84R8PY9/yVEtIohRAq8j06Yh8trx2gwQCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Re+MbVecQmVloQ999mSdtlIrWG0zH4IZ8qZ19LXv0BzBkprWB7IIDKYhoSYnGUliumxncUwIFGpJYeFPVsenGumx/cPirY3PEPFfaQlM+zqIL1CJ1Gba3+wX9yxZPV5z84KGF2FEx6SOTYtJkpDtKdCvYVp4raiAW5ntqzuvdJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ae0m63nC; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=z3alpOf6; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P1K7Ic023666;
	Thu, 24 Apr 2025 19:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Q9UokVYHBKdXuQuY+2rXoMrqw9j9wNUUgv0B8rF4+kY=; b=ae0m63nCeC3k
	HEHPlLaUPcXbpI8By5nneP5xJyoLPIrJF6L5k1OHBAAHA0xupMKjuf6jj86Z9P8f
	Ta78bPPkK66mJd5CsblRlMeThagZtCkymlVzo90vptEwLlFDtie1kwWjUPup6GB0
	XT8mhBYgUSM8spdFPJat5q2kjP30KpEmok1hNmmMgvwg70FZL5n6IroHx8kGbfLc
	NJ76W5hPzpTQqRQl5mFztKaVgWenLHkjaTRHzlI5Uk7QmhLTnqWFyqQwxKJ6Lnrz
	uYKta3rCs5H2fn98P/ll5a0EntLJt3uTX3mOlcIXRgXl8ahJHCs7AhsUbx+/rt2t
	yjUGX5cCjg==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjyu36n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 19:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2ZfUm+ih86kNnme4hEtb9fVgzaPjtTaUkK2WmAi7sUigB2ChuNAXVmAPr4kt25KR4uqN7lm9GfDFyYWdb+guGvWBsYoZyIQYYfuFLuPmylGtwaRLbCnZ1WjPZ/ytFPkoZrEcmRAOEZPHHjKUYbqvJDBTgf9KtlFIbofscNeF6FnhIA/RHkBgT5L1MRAXPAqHpQMed19aEZxcV+03dO7kOaFFMie0hdGiUGzIY5XVnv+FtZZhp+bBR6c+Sp3cz7NXsRAsum5CoP+9D5GD4TK01f31dEeMgc4RrJFeA90UqsZwnTNxSYL4wIfNBIr5WBc1M2v4K4ZaVLZUBYpgcGarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9UokVYHBKdXuQuY+2rXoMrqw9j9wNUUgv0B8rF4+kY=;
 b=JMfVVY6XfYu16eRNjmFpD3ZeLYFTS911l4iNtQniV7dXgrFN24bv8toaqnwQ1yxFBf4Vc2se3ImfimRLNPz0Wi6S2g+evbRdsjs7qvHXfWSwVpBnmyON2boQMwFBiM41FXUCp+qYsjYZ8hp/B3C2lizi3slTn5HY1z2SBy0p7h89cecVo/RtgXf+X8fI4AV3OzlG95HbU6Ie2MYg9GBCuKkkUrqJn/IbUT97I/yBAGQDWDgNpQFGVOzv9vl4uBPXHkXDmoV+woAtnZPXomTsKMm7IFpJ9UE6yvOczHNdKag0WJYhP+c11h+bHrtaIYJpnoIKM1O3MlauEhIzc5Oj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9UokVYHBKdXuQuY+2rXoMrqw9j9wNUUgv0B8rF4+kY=;
 b=z3alpOf6FV2rox/X2YesakF/jmHw3xq/2vHV38/CkqPuy8eRAgaiXz8qziy47TFfrInKPDYMY4/t3dT57qQjYJCqx4PmugWPIsxUHnKoxVCernwUIip436tP4pXOTho6tmKgneMDBOfWCYQ0inkXpJmQt/Azl3Yzg0hhYf+it1g=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BN0PR07MB8973.namprd07.prod.outlook.com
 (2603:10b6:408:154::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 02:19:11 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 02:19:11 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Conor Dooley <conor@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Topic: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Index: AQHbtLTnbnpkizAVsUaczHiSHbV2I7Oy8fOAgAAASoCAALTRsA==
Date: Fri, 25 Apr 2025 02:19:11 +0000
Message-ID:
 <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
 <20250424-proposal-decrease-ba384a37efa6@spud>
In-Reply-To: <20250424-proposal-decrease-ba384a37efa6@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BN0PR07MB8973:EE_
x-ms-office365-filtering-correlation-id: 601be080-bce2-41b6-05b2-08dd839f9154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qIUsqKZV/6VLf3AMduNf6Fl31Q9zFasGX/QQ2GaMmXk8Wwtgp0bqMegI2whj?=
 =?us-ascii?Q?+cdvneBTI93ozW2PzcFvBBgwMj/6ts8OSy7mxDb5odx7SUTrkMNuVj6S6u6z?=
 =?us-ascii?Q?nRjSXzlGki22kPaReI317sas7YLzjyDRpFM61TYY/v4kq4jXpCDUgmgcn8k0?=
 =?us-ascii?Q?3r8Jq/+RivjhT1B5BDExTCFlGJpjHKG2aXqbL50SHbGhOGHKttTbobQeezlb?=
 =?us-ascii?Q?htmoOLVjKSESZ5+gNPcmvkOmcCgGQ/9ZWaC1SwivPPriFcz409IjzKf2PlTA?=
 =?us-ascii?Q?F494BXVdkCxal3p0dOsUTO0yUfceknDDidUn/lHjfrE8bL0HwNNFpE95dbxd?=
 =?us-ascii?Q?XqVJIzPNa7MxyPUiERZIAFpiLfnXJe5OJUyt0twY+omf8kUYnZEqfwmB4sxu?=
 =?us-ascii?Q?rh9k+INKva2oyE2jF3Ew/88JJd94U32JAuDmxHNbDh3JAXbf1Rggofh/DAMv?=
 =?us-ascii?Q?nfM/fZuwjBM9wH2ipvlHjeZxmiEgFTDBA5adwP5nJ4pCcYr44PdGO1+ReNOR?=
 =?us-ascii?Q?MqdJFvIXtMI+pPQij7yb0Xm0lx1PKfiT2YMgpLcVry5RonM9UL6wLoIGzlht?=
 =?us-ascii?Q?iAIyiEuCa3ehyiE9UxzzyC9vT6hpM+H2nndnrK3IJ5yicjos6SI1cKDpaU7x?=
 =?us-ascii?Q?Dm5t5nf+OgPT7Dy4gwQOwHpblMSUxvpJKLIYcJbNX8gJNQRElZEcIaPrua7v?=
 =?us-ascii?Q?G/0D00ozQieEfLCGakOUDDmd9kreIO3kNStVC2kvrZ6tTEsTufltBXvucY7N?=
 =?us-ascii?Q?CfMLfDQGL2ZdE2bFnOo0+dy911BCXDVn1xeImiksfP1TIaOSKBy63Wfma9XC?=
 =?us-ascii?Q?s5oSzSzyvHtu2mMdy/6ucKx3W31rKDofwFGbWEMIg89qiSfzxZREVNSWGjcm?=
 =?us-ascii?Q?IfRNmROoJP+RTCE9BRwzPZrsS+kfZvB6oBZ7KVaer8HbbBAO1UB6/Dif87JY?=
 =?us-ascii?Q?smbqvd5k4atPUoorIX6JDdNqsgOAiqsN0iG6ZcEy2VCMLUCK2WGGWiG+OTwj?=
 =?us-ascii?Q?yzdlk43rdL7lUqdv34lV7MsJiHo47zES0MEleWV4kSu8nruNYKKAWkyVHbPg?=
 =?us-ascii?Q?6WdEfDS1k5MaxwZjmmNpAm9xty8IhMfb3n4AkwKQvMixhEi5mwWy9FgrUo3e?=
 =?us-ascii?Q?4bfUMLnLJcZnR+xEaleWAVxXRAghN4JlmPTLGfZWF491fJRw0jUPcFhqrov5?=
 =?us-ascii?Q?wtn5r6t/nFf+q3a4OsJ2A919rEqCMttXE5aVk/EwnwxEa6iCQTbf8rh70a5w?=
 =?us-ascii?Q?PzCuf+1oY+q2b3ub0sutTVxEKGRFkPEbfI9XYl2FYCR75l3HgDk2M981CvQv?=
 =?us-ascii?Q?EDdPHCp+urMkEkB+g11yI6L7ZMUYD5HdzDLjzfp+xdxVGOlGTnYi1d2Gyvqj?=
 =?us-ascii?Q?z5APRfJCMgqlJfUNQ6A535BHSEut1XLl6MeZTjU3k5ZHNnjK25aVjnQuTbXp?=
 =?us-ascii?Q?fxgRBlniyfI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vzu45f1WZXZ6H09g/1Hef1i+arMFKDshg8jkkxjqyhLBRcl3K1QoVVJW2Xn+?=
 =?us-ascii?Q?IRnFQYM1NFGGPKqHSi0/BU6lT/hcBIZ0o73V7HI+miB9zROaqD+FPchC5vtN?=
 =?us-ascii?Q?L69leVVcNdDMJs8dqctsSZP3X34ab+wAO7E5DWLuPM1KRHOz0BuVgm8B5QtA?=
 =?us-ascii?Q?1tlZBuDBXnmzzH1j89HRMbWXxl70NOPKXHis6ctHxvs/o1QCgBicbZMoGlra?=
 =?us-ascii?Q?Sq9sRYLIrEIc+zSKI3yK3GRiwCKHzozxl9ODgBTjtvClSqRz4unjRxOotYud?=
 =?us-ascii?Q?Mk0wl35Qv6RpjiB6IJOfkXZ0po1AoQBPGOCPnLOeqsHKKauE2uSrc1uxXkpM?=
 =?us-ascii?Q?zE05PaneFtv0+Sy4XuZ/+4lfSG3SIpbCBo6c5n+eXP6haS4O/xcUZmwzCR+s?=
 =?us-ascii?Q?H4zbZYHe+FXtiCQTXqemc1v7HWlWm6ASLin+/1ptB71Te9eJ14ggW1GRuJED?=
 =?us-ascii?Q?Pk/9/Lk25oxrmNlRWjob+XrWEAYozqqMYy6PoI18owwLw2K3tuWhHSKQuCJF?=
 =?us-ascii?Q?XTelGIKn2PG6IEgXWf8LkSiXCUhVGRiujTjgNgZWtD2Zm0X75nAB2GGH7UQu?=
 =?us-ascii?Q?nqKrV8Uq1qv5b3zZ61z7BXWwx71bK0jEfreaCpmEp2+RmnVfTWzdgD5rhKRB?=
 =?us-ascii?Q?pKrgl7un72iZ92UZUgzrotFeVUjAl//GbtqcK22QWqzIDj9F068F96KuBG4P?=
 =?us-ascii?Q?kh/pf/7vRMmACQfUZmkBh7MH3lKWNJXk6pWfIBJs0mQ2DHC35Z/n3JIi4qmL?=
 =?us-ascii?Q?AawXOoIDGVV02c2iNpBV9cREfoiF66PhEVcVrxzq7eTdTYBN8bJYGQoOHauR?=
 =?us-ascii?Q?757NMeXOWPFGOEjxfLDqhK/zSRrgspiSFt0EXyY+IemWB6NaoAkLRVxMeKWb?=
 =?us-ascii?Q?++vVRzGrEYx4ynUjFDDpyFLTZD1zYitEwMizGmowTnEXHMMZHuLiZByeGHyv?=
 =?us-ascii?Q?mdLnv1a0MLV43aq1T+yTJ+EIje6Xi+1Vm67eU0zUBcq5l4ZE91lyLV0A3VUp?=
 =?us-ascii?Q?RKstTe8BYf5I9xLh3gzdd3l09n2HBMIn/ctv5RCfIhiYWWijYx2xtNzSZirJ?=
 =?us-ascii?Q?BeLJwNsAT9K8RocXXjBgToFLi8WG0X3RYcLFJ3qfHTwCOML7hEWPYSRASfHa?=
 =?us-ascii?Q?KYLFDOscjLjYXSAnUc8xjDnB7xm6/bXd10zfntC0NqOECpAAngity+UMrwYY?=
 =?us-ascii?Q?gjnkD9RV2+hfaPZBcsCm4NzDvO7R0gaGgNIqdMvq01Tb48r0SteZygzEieMf?=
 =?us-ascii?Q?vWhkh+LPnv2Lo7q5mfivKCKWbdThIlxojLYtQJf4HmGPYJtPoOFQh+wutMB3?=
 =?us-ascii?Q?pdJnKWA3FsB+Ee0zWnOLlqYwzZ7e2E/vyNNcRzswOAbPtaQz93doR8T1YPSX?=
 =?us-ascii?Q?ZNYXSIoisgNwexvOGxt7KMMPtNf/7nCB1ldfrxftIW9iyBVc06sdX2697Owj?=
 =?us-ascii?Q?h6GM5S4VPKYuguq5+SXrdQjGfaGzhB8fqdcMUwI5j5GHh1KTmJrz9GfH0fhb?=
 =?us-ascii?Q?JL2eqHhKpfCGwnu3ZjGkarESD010crsTmiBelS9tbQ872C018EAR6Mh560n7?=
 =?us-ascii?Q?WNHzR61ZoVBpcRhoYzL54T8unvP/WfYscbNR8GkW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 601be080-bce2-41b6-05b2-08dd839f9154
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 02:19:11.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UV3+4faPZyhABfZ63f6XaWg1vqC5iMYUWTHKqWjw6pbctGd7vLd5HBopSEVY2By55wevRl6RrsM3054v4IkyE+bMGD7nclM0x9dXM8AexkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8973
X-Proofpoint-ORIG-GUID: rS5YDUcrE7mq69gSyKjey1-YpItprjYW
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=680af122 cx=c_pps a=6nUVeFXZkCqfDP2MWDHPNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=gEfo2CItAAAA:8 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=vfBck_ie-NQBOy9Fdd0A:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAxNSBTYWx0ZWRfX0KECHovNG/IJ ppmDOC0pczPxCSuukH9tdXF8aa34+F7yv9eG8Oh4NYJcs39i0xVxePyK188ah/CT14NyM8Bc7wq 3Ig+PN4kGE2NQDbrhPACjXBSghKNLT/POJhhfN/MDg/e3cKMIar0R1A0wSTX+XB1k/BRUGj+ssG
 eHtaqcgMZNznWv9geYwZUQ5io6it5Sutd7QmnoXiewe9pWF1aiIcVTw69Bj7IJ0ETLfn/+rd64t jqYTRFdMHnLOGOwse4rs1kKhIGzDjeAuXMPDMNj4CjhqvUeayCbTpGuMhLnThGSiAwgFsiGPaMk uRRcmMNM8WV3SCzM83YQZyRB5EIMsI3bkawVBvyNYzlb7kjnCXL4pS0KK2bZcG/Hpq/zrIJp9VD
 rvpJPQPSH21CjiyFwNxSTQbA3qltCBmwanpM96aZP6uzsqNa9EoiXveQOlEbhvA1FrYTA2eY
X-Proofpoint-GUID: rS5YDUcrE7mq69gSyKjey1-YpItprjYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504250015

>
>
>On Thu, Apr 24, 2025 at 04:29:35PM +0100, Conor Dooley wrote:
>> On Thu, Apr 24, 2025 at 09:04:41AM +0800, hans.zhang@cixtech.com wrote:
>> > From: Manikandan K Pillai <mpillai@cadence.com>
>> >
>> > Document the compatible property for HPA (High Performance
>Architecture)
>> > PCIe controller EP configuration.
>>
>> Please explain what makes the new architecture sufficiently different
>> from the existing one such that a fallback compatible does not work.
>>
>> Same applies to the other binding patch.
>
>Additionally, since this IP is likely in use on your sky1 SoC, why is a
>soc-specific compatible for your integration not needed?
>

The sky1 SoC support patches will be developed and submitted by the Sky1 te=
am separately.

>>
>> Thanks,
>> Conor.
>>
>> >
>> > Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> > Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> > ---
>> >  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++-=
-
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.y=
aml
>b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> > index 98651ab22103..a7e404e4f690 100644
>> > --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> > +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> > @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-
>schemas/core.yaml#
>> >  title: Cadence PCIe EP Controller
>> >
>> >  maintainers:
>> > -  - Tom Joseph <tjoseph@cadence.com>
>> > +  - Manikandan K Pillai <mpillai@cadence.com>
>> >
>> >  allOf:
>> >    - $ref: cdns-pcie-ep.yaml#
>> >
>> >  properties:
>> >    compatible:
>> > -    const: cdns,cdns-pcie-ep
>> > +    enum:
>> > +      - cdns,cdns-pcie-ep
>> > +      - cdns,cdns-pcie-hpa-ep
>> >
>> >    reg:
>> >      maxItems: 2
>> > --
>> > 2.47.1
>> >
>


