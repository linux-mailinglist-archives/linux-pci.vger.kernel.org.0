Return-Path: <linux-pci+bounces-31171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA4AEF97F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E1B189D729
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC22741D4;
	Tue,  1 Jul 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kB4aTQgj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jlXgebmK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D22236E1;
	Tue,  1 Jul 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374751; cv=fail; b=I9UnkjVr+vsEOrfNp5VkGWgMouNuNXTvvBL9tTuMbQk2rmTh0NujQ/mPcITOK6umROyPYqKvWPt+jDlJeO346uxCh2Gdl5XRwpHM0cSkiIot2LaArGDJBeCumQP1FsNEpig9rULqSvzlB8izN1CkfL4FhE1hMnj0YBR+o39/vnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374751; c=relaxed/simple;
	bh=9d/R4p4k81cGsi5vbU1g+sE7GqRUrKpYW9MCX0hMx9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rF06OC9Ip0Q9S4t6rZAAajs3Y3WAE5mjW/emMMiv4SOJGIz7RyQ1iPDQ1KYtjDLjzrNTc69jhsQWoxGolHzhn8joVfkYE7GgWAq29yEY1dBAkkCaHUriEjs3NAiplY0mrY/doZhoHzOSnbgNpO5VhnQz08wmibHQs506hX7HAiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=kB4aTQgj; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=jlXgebmK; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561ACimQ021581;
	Tue, 1 Jul 2025 04:56:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=9d/R4p4k81cGsi5vbU1g+sE7GqRUrKpYW9MCX0hMx9k=; b=kB4aTQgjN4GN
	OgXYmrIBn7OLup/QTiJhhPz/XyyTyA3X1orAK6c8tYGzE/f4D+H/0ooD3bje5Z1u
	eMMGcsheDcWTFYiRou2JwH6iflSoVbx/bLviqz9rFTYDpAzsqpi0JRUzDlBGM5kU
	5GThPBT2hV1Vxn4USCwIRSZWhWvpZuEPQ3c/E6EHZnKSXScoFKPkmKMY03Mvvj0f
	pl+MrhqyZF+WtW42GYLy/gGXTmOFy2vbENRiFac6T2MC46VH5d5Z6dpGcHkKfcHJ
	f1EUcazmce+GaHiqSosrwH6lZDe9yh9ko1dlCqnjCizv2HRn4uByW0u8ZdcchMeL
	7nOXAbFxAw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 47jc002unr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 04:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbgXL5J594y0+IZVlpzVEpgP9IZU/J50hAwjxFDIwQ5VeCF0wUL34aZsE97B5w+oMAtEroOZPzGymc3lbgmuqy1eAXT7ZK8FXbrvN9CI2P29ZnHEPej9+E8wkNK6SduZw71jYy+NrVYFLvgv4cJXPgum/COPEqQLcF+VYORldguSG8JUmxvYippPC0I12sSSUVlMSrWn3Qh8R70kXz18GeD7s/oW/dbkH77twcIM5Au4jaCqPA3DHTlYTp7F14IefXurggQj4bT6CcgUkCCXVPQ7XwlFcK6/MTXbxMobouWOBv/R1ysnycBd7eYkds74Rq9XplIt/mzSGcMnsOYHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d/R4p4k81cGsi5vbU1g+sE7GqRUrKpYW9MCX0hMx9k=;
 b=I5Dkw9QhMNBr1FrwWCV2e5nc/XI9v4hbOvFSajLYHWHcFDgLGxH8wx2CLcRH8pY0Ya55nATy8TedZWEMC6+qUt/zRieymZChGAxZTjEEgK6jnrFEyuwWpn0xVvv+2uHOl4YJiYXFTTghTtV8Llytb74DwLN3LfBTlyVXj0e1tAf8OAit5qM1d63UJhAuh+DUYQ8lrJqrbm/0zoVzIJLa1ZBTzynL29pGpitcwQ5IIk/qPlJp5dKD+3JBCplBAzE4Lw64cvbK1I3HEDPAhPNzkAClhP+Ynpgb7s446nf/uEWfYWqGEfBt7UoKKlWVmQRwdGiexVKPT+09zlMNP1k4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d/R4p4k81cGsi5vbU1g+sE7GqRUrKpYW9MCX0hMx9k=;
 b=jlXgebmKrHHq+KWWk6wyCCk+BCCZi3IdPLC2IHOmEK/k8eCRvHUaCgtsfIBWHS5hYm2R7utzqSZcTPPgKWq8Zy1rm/ITYXlWPmS+2QbDeRtIFX8g/giRWev2hiMKvX/4AZXnFzWm/J94npLVmRJBBqG0DLERlyDMoFNIp75BuHg=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SJ0PR07MB9720.namprd07.prod.outlook.com
 (2603:10b6:a03:4d5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 11:56:06 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 11:56:06 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>
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
Subject: RE: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
Thread-Topic: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible
 for new RP configuration
Thread-Index: AQHb6XW6OLhXudgydkKfwI+xEE1N5LQbTsYAgAAJBgCAAABtoIAANDqAgAGeEoA=
Date: Tue, 1 Jul 2025 11:56:05 +0000
Message-ID:
 <CH2PPF4D26F8E1C590A00940496AAC9ED75A241A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
 <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
 <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
 <CH2PPF4D26F8E1CC95F84FFBB099955A065A246A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <31415739-88cd-4350-9fd4-04b99b29be89@kernel.org>
In-Reply-To: <31415739-88cd-4350-9fd4-04b99b29be89@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SJ0PR07MB9720:EE_
x-ms-office365-filtering-correlation-id: 1fabd423-35d4-4a6c-bbfb-08ddb89642af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s8d4ZgFcfe3odD8vITHEx9lPO7Yg0o253ZHxKfkIn+69MUjwTUtIsmgaHC4j?=
 =?us-ascii?Q?z7SSdqbjnDVWJ2d2alrg5/XyZnYpjRdyueeZ3xuhcNlvo+b6f00FuP3CxqB8?=
 =?us-ascii?Q?9xTZLH/nRKvYADHQVu9j9yZco0LwgjK5NdeC2+s+/Fwx5lY7if4JW2iNcoDF?=
 =?us-ascii?Q?dnjq/YHZJ4+5rn3exU58p0/950p2TW/vN9z3rISNuzf/FCc5pHiidoJkpsWm?=
 =?us-ascii?Q?z7w5KSrUz+Y+05MbJ2TeVO9T4fjBXOFKbwal1enLuLOSnj8kGhm4Akn01RyP?=
 =?us-ascii?Q?IQecqjRs+LwPjZ2FO+/EUXtpolkbNj69wienH7dd4/QUAdqQ4oULk4L0PP4M?=
 =?us-ascii?Q?jqOPBh/eMTlMwyB1wWZOoTn6saeUIsYx5qEcGsjZS82V2QUyDhgkjpCnuioX?=
 =?us-ascii?Q?wDU4A3cOQpo4wRx5o1QHWb9hB7D2VGObKHSyzwUx67GSF2bxkvfNnt3jWk6w?=
 =?us-ascii?Q?94XyziFBp90rMzI188e1ALy6/sUAmqu51Vu64akjUvdC+fC+bc3zgeeiCr9h?=
 =?us-ascii?Q?hPxfxdvc+NoMAgNRFsaGTAc6Vgq6l9YX6LgPStgoUBbmHYRN7p2aHehUH77e?=
 =?us-ascii?Q?bihZApCHuVlfdZ/ziPJ6M5EkGETT1MrC00J8GsVQBzJqHhgCRI9VBh//ir0O?=
 =?us-ascii?Q?tUAfdJjQq63Do951thlKEYwQIaYZ/KC1Al+0JVApFlzBpBbrY4GDNMyOz56t?=
 =?us-ascii?Q?uuY4oML4hhMMTG/WCw3kvRcrpujI7afKGtaQB+AzAd8kVPOOsDjgDouTnj00?=
 =?us-ascii?Q?tFUyy8WEzVQlMU2l1w2OxdZWE6S+1s2Q/2bCt2L2YsdsRHeaov8mYAx38HGL?=
 =?us-ascii?Q?EVTRwZ7uTi4IiBYcs+ZORMTE6Byj98cZIEaoHvgB7Hc/UwlkyUVUW8R2k3yf?=
 =?us-ascii?Q?LWIg4mma4MQkJcBBBOgTHLhjK+h8DfnCwub8bWAtcdNshWTandiFfUIBiZj2?=
 =?us-ascii?Q?yUNIjPvjgU32PlCd2cvMwLBGxBxxc+31SwFJi8qaZzvB70gGes13rwAsHuJ9?=
 =?us-ascii?Q?p7QFfqwPlGNLxNaXnyWP9hpaR9HhGcdrwq7jDnXxos2P5/sMA1JYH27smYe+?=
 =?us-ascii?Q?zm2W8MVdBV1A3tIVCS6tzREwDdWib3c9Ee8opA5JB0V4wHlXVmN8WdOPMkQ7?=
 =?us-ascii?Q?x0KxyghtqjTeDFkNIA+lghXCbjfDWIXV792Cq/CyDo47E9X1J2CqOcjReU+h?=
 =?us-ascii?Q?Tm8jJOnFFnsw+O9Po9DvnOXxifGuQ8+S4R10Pdu7iioBa4iAY/Ofek8ozuAg?=
 =?us-ascii?Q?Gh9Jjkatck1z0ZqpimmDlrmxCXvqiBrq9OOwDv9lnVLMySchYS62ozS13XHI?=
 =?us-ascii?Q?utZlTtNeJlCX5/C6R64QBxN02qXeik1A0tqAS0wjtHJiScmalssDLASxbCAx?=
 =?us-ascii?Q?hWwvPRbA7bvQ6OiCy/Nfdoyc/rw6TndHxYIxWYXNC8RCfjm76Ay2E6qlO1as?=
 =?us-ascii?Q?yZlo41eOKio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZPMT7dEl6xKh650G618Xpaa7KXljQvoW+zfHks1awCDGjNFQbcSEGiIRwD5+?=
 =?us-ascii?Q?2lx1CnFJwQv5LtsfCNEPc9FfiphnW0gpQHORUWbZiOTAE1wWxJdcXYE9CA8H?=
 =?us-ascii?Q?3zysBJ9imbGlkwB2s5CIjWhkyQ2xpIoV3WZ6NyAAmwqnjjP6x9/3gcy8CmO/?=
 =?us-ascii?Q?rd4Enxz/3ZSGDTiit15YJTWVH7Gobn9kkNXb/DV0mAqAeWsIOA9e3RtAG1xt?=
 =?us-ascii?Q?8TX9tLw+zZNkM6CXj4qtm2Ucc+Q7NXTV27KrdA1iEjfEAnHv7ksWFokNV8jn?=
 =?us-ascii?Q?I1mPgW6Wwv57+fC2o40Uq7gjBZNE0g95OHHv4/nv9kLtvTtWpIBX9khhm3cf?=
 =?us-ascii?Q?DkNkkV0r1o4zQO5KKezmbCTzCptLpIoyRDdtqyUp/Ic24Y+/L0rqz+SDGcq+?=
 =?us-ascii?Q?GNI4e57wN7zsbfjMGDwc+B5+yRyUo6SueZtuD7SXzt0spD3NANusSFueymB/?=
 =?us-ascii?Q?qDyua4A2mOhNxCEDlnINo1DC3Ies1ShTtP6MGoGx7XnxZumuLJhja9zKitah?=
 =?us-ascii?Q?1sKgYyZKQEfjIIBngPYcNXaQ86UTsCPIoWhB11TW4WALPy1gKnPYC/cvUUeY?=
 =?us-ascii?Q?NuPaqZymJL2pkEtSYanPMfOy76Ym1smAsACBccmPi8TbLpBWvNSGHRJbRH+a?=
 =?us-ascii?Q?EU71MYn+1hzV+RcQfXJbn1R15adHSPiGM6EdcdJT8S6AZFErzJP+h16V93E/?=
 =?us-ascii?Q?bWG7fStvrwzaM+QLp43MDYx7RvVNx3A8y25UaSKUNmFkrnIwc4qQYYBB2q4f?=
 =?us-ascii?Q?LWOq2dcBy8X40LK4XtHvIEoWDSJaRc2VykbTgS+vfeu1tmjLX99Ee0vK4yf/?=
 =?us-ascii?Q?8G9AvQsGOyOjPVqlaoqE6SFv6+zASnbcCHdx7XRs9x7cq1f8VN760B75McoC?=
 =?us-ascii?Q?rMIEMG4SqLvf/353VQl+c5RvQaA5MUjGjr1jBGrFtdIKcvT4J5x6VfZBirO4?=
 =?us-ascii?Q?PwaYNPL7zWXY7pltqN0fTLhe4xbCW+z4YyyA0aL6A30tsqcBUGKKG9+5L4I0?=
 =?us-ascii?Q?aDJ6LXY4dIHkn2LIjUpvdN73gaGxbi7HBRD1OoROEPsNSg8jiBA4NDaLw0c+?=
 =?us-ascii?Q?Kx0nyIXNsb76xRmZVpPRtfQEfRhHh0+unjWSZ3aa1d7WO/F5+QOuApM+IaVn?=
 =?us-ascii?Q?3ERQkSrs+aYhLsXp3/ViUBbIdVmKaGwqVu65JnlJMH1HC55yIaNfibu5mB4w?=
 =?us-ascii?Q?38juWjLBNiqYBzMRSvdG6h4K3QNg/cSDWSYGwLSQC2QrLB0SO7FEwVKuLOYQ?=
 =?us-ascii?Q?494uBzqD4Ep3t6fP9vlkq8cV0Z5OxykqSf+kct2GRdqQVNJBkYC0NCHu5kkU?=
 =?us-ascii?Q?EcTsTfDdw3bi9ofslDL4zYO8VZIrWXUDdJp8vs5Y3qwgrvKKZq9SdBmBExzw?=
 =?us-ascii?Q?EIrnTnhAk2q1AmPREJ8IwvKy3m751UIfoHV8z4PTIR7tiydkeNpelCKNP2XG?=
 =?us-ascii?Q?cD47+owc7nf372n2F+GPr1pWX9h9cXfL8TsuITi/LhxRGT0azYxHYaOq6JDQ?=
 =?us-ascii?Q?Qp71Iq8C/iRijv4lS/uTsIC38tVAPYaPwiwlsrCuKzwKyIjwgGWBtykIS1ad?=
 =?us-ascii?Q?Ys9o75xj0df2ZdEzsvV4SmIu+Bc73hTn2Y9S5erA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fabd423-35d4-4a6c-bbfb-08ddb89642af
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 11:56:05.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZ+NdktbWzvTHEAFMterSXQV1OsihenFUd0XdyAwMbJTh8tgn2hIPnR1kT37rJNfDZO0Z89f/P14Sj19+Nr2lHSjNBvopNyhX6eL/tKW0Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9720
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3NCBTYWx0ZWRfXxwEZodiqHzGt dnv8qpJeQEYquoSBNNvtosnjXFUhbIyc0K0WSQihotzhLxPSunaxH9bmBh4eCd8oGJaB5SDAwE2 iY8NleF6OywvQ32C7/KnWEcs5kXQNCpdWcdJ80Ki91n0vlqHKvVp6bFhRHDsnqTaYrCHJECThcm
 PtS/O5eDk7dEb6Szls4t7CpbIxJj59jPAi3FaFnjj0E4/2T/NaC0UdQe0ebYXXesXDhUedyzdZv 6hvr9QjtIYK7ZFUeRnVjWuR7ZxLE9Tcc3DRC2kzrYnE/K81uAf4Wl2tS0hio5jzQAtmTpw5blpZ o8Bz7DtSyqdNDPT+mI7Z304nIvZlz+rXPLn1jXGGQhSEKuMODvvVNrOBQCOp212Xy8BjZLHm6zy
 yTqAwU4+ywWdsNUGf/Ld/A9TkaukbZtFNJDkleZZCl/bcrucbd51OObhe5P4VEc2qPFfLmGM
X-Proofpoint-ORIG-GUID: BhLR5FPd6D0P3H2TEID6M76AuJe9XnDR
X-Proofpoint-GUID: BhLR5FPd6D0P3H2TEID6M76AuJe9XnDR
X-Authority-Analysis: v=2.4 cv=W6o4VQWk c=1 sm=1 tr=0 ts=6863ccd8 cx=c_pps a=2iGLAf+UVEzzWeb/t9v34Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=fK7Neo_HFmguwAxDVXMA:9 a=CjuIK1q_8ugA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010074


>>> On 2025/6/30 15:30, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL
>>>>
>>>> On Mon, Jun 30, 2025 at 12:15:48PM +0800, hans.zhang@cixtech.com
>wrote:
>>>>> From: Manikandan K Pillai <mpillai@cadence.com>
>>>>>
>>>>> Document the compatible property for HPA (High Performance
>>> Architecture)
>>>>> PCIe controller RP configuration.
>>>>
>>>> I don't see Conor's comment addressed:
>>>>
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-
>>> devicetree/20250424-elm-magma-
>>> b791798477ab@spud/__;!!EHscmS1ygiU1lA!Bo-
>>>
>ayMVqCWXSbSgFpsBZzgk1ADft8pqRQbuOeAhIuAjz0zI015s4dmzxgaWKycqKMn
>>> 1cejS8kKZvjF5xDAse$
>>>>
>>>> You cannot just send someone's work and bypassing the review feedback.
>>
>> I thought the comment was implicitly addressed when the device drivers
>were separated out based on other review comments in this patch.
>> To make it more clear, in the next patch I will add the following descri=
ption
>for the dt-binding patch
>>
>> "The High performance architecture is different from legacy architecture
>controller in design of register banks,
>> register definitions, hardware sequences of initialization and is consid=
ered as
>a different device due to the
>> large number of changes required in the device driver and hence adding a
>new compatible."
>That's still vague. Anyway this does not address other concern that the
>generic compatible is discouraged and we expect specific compatibles. We
>already said that and what? You send the same patch.
>
>So no, don't send the same patch.


Hi Kryzsztof,

Are you suggesting to create new file for both RC and EP for HPA host like:
cdns,cdns-pcie-hpa-host.yaml
cdns,cdns-pcie-hpa-ep.yaml
And during the commit log, explain why you need to create a new file for HP=
A, and not use the legacy one.

>Best regards,
>Krzysztof

