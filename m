Return-Path: <linux-pci+bounces-25771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D6A87604
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A481882521
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15113188733;
	Mon, 14 Apr 2025 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="V6YiQtsb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="xQSssxIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC11991D2;
	Mon, 14 Apr 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599970; cv=fail; b=avA9ASoCF7uvQ98tojXZLHSBcWTB9VIlz/kGzztQG0mw8xeRRE7xk0CWL7zPYsWhKS6zuz5mF+mYUO/6pek21WDC8cuKZOVtuqsS+oeBiFGmNCKxHnkYiEboXJ/5gcpxf+JsX3RJNHTTUs1M+7wa91FNc7igxfngIgcRz7Q5UZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599970; c=relaxed/simple;
	bh=q378xZ3VcXdyxaJxVfvO3pYuJTBTy34ZNQx5xWhxtUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6jieDUmynZF8d3p9afT0/OeMLRWjm8+0CsGsN6LbwVJqZ+Y6dkk4Uy+69oUUPANl9wCX40wN/JXimP9EAaCIIzEixBCEHWhhIo7BSVf6/iUZZP2PxJFiFG2ggbXpUVfqI3enWgInT2vRKa12sseqEOGr1LN7LJAdCqdENxaJfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=V6YiQtsb; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=xQSssxIk; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DMlEvR011910;
	Sun, 13 Apr 2025 20:05:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=S8s7QY260FRefRNzfPOfPN07ajj52L6kwugA4UsXUSg=; b=V6YiQtsbtSAB
	2N3hCeqi9BCdqY55cnZX9f1iNqCwaf8Q0jpz8nr6XiF1Ls4IPX6FRBEVIsd6lw8y
	OYp1Qni1SmbZJsWGLWLsK5HXrNbqW4ymNajRaXz4esWLewtBiYQrlWWxsD26QCVh
	S+934pm+AcGODpiT4ihXK+2limvsqF6zMKP84qCGvx4umX/gjMqld6UEy5QKUzGG
	DCoNIkzFW09iQ4AYuOX9kAVKvh3Pg3rz7A8nM0vgn+kdPLWS1cTRKPCYRCwH37xp
	CEltWGo9L3xLgswerxmt4NgCFlUYEbckZJuBQUNkAX9nqQ7fcCtxG9Gp/syhE2kv
	X/J4MFPDoA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45ymqx62nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 20:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paE5Q0H4rHzBsl0yd9wH06E2pfUyzH7EFNEJjiPf8hQ5F2moCH9eKNbiMV5JJVlPZ63WaNQHcHQigcI9fQQ+DhiXQIVjroucUV5qjx070wN/oj3o5m8E0eCBPmockF2CjNDK/JpI9LVexG8trd5g5/ltMOBpOiXq0zNVOawG4U1SrnXljA0vjEicjDsecXgOIPRFxC8gd1EyZvyHKgZvs5ZM418QVum90kIetAv4HQo/5J/H1jpqaeux3AAlHh6f/f8pswxKy7NsBbvaqjrpku5AmMLo1zbF/whGhJ3kDr/N40J/vJGcTuPIuFhb+hh6qc34gseLB02sZwarasyxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8s7QY260FRefRNzfPOfPN07ajj52L6kwugA4UsXUSg=;
 b=QV+dsl+mvi8KJg5qa+XXPbMjp1NFtiuCJdDRpU8/jHqAR5LMB2Qw69yeGzCwMtkWXBohGFbRXi36Ujme9VEtkiVbMLRfKgJkPjPMKREt0wJR1znaokFcdZSe6SfI0eKlM3+NVU755xpMVsiIYxA+QXdLyUHSq+lrlC07r2uKHsMJ0bfePGWm8LEWfy/kGQWE5h3amhOdvNRQveUNzhnTQX2xQHWISH/lxv0xeR4cvktoJq8ITnCpXvPWhCkNIA2ZNxZr/NSaP2ORQyy+lccPrVc8l0LifCkKwvC/HV05ic/OpkRKb3SRFrMFzp/1b/RPVRaMf0GhntD4IbwUvPsf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8s7QY260FRefRNzfPOfPN07ajj52L6kwugA4UsXUSg=;
 b=xQSssxIkP9PpLgQ49/lx1rJFCCXl2YB/NpuDLSTIph0mkggfv6PAT8jtnmPZTYlgsU2htVj1ZjjeZCdk+GKLvUiDwtjch7MwGRSxbMJ6BJKj8GrtkHCRO6DAjfe3gNXU3YQzQrsSCUlBGP5Qm1T2kllqCTg3MXCMs9o6CjhZKEU=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB9743.namprd07.prod.outlook.com
 (2603:10b6:806:33b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 03:05:40 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:05:40 +0000
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
Subject: RE: [PATCH v3 1/6] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
Thread-Topic: [PATCH v3 1/6] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
Thread-Index: AQHbqs2vtEKqaBAm90OeDox/zXa+erOe4e8AgAOcIMA=
Date: Mon, 14 Apr 2025 03:05:39 +0000
Message-ID:
 <CH2PPF4D26F8E1CAF9D2EFBDA6CC9E94646A2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-2-hans.zhang@cixtech.com>
 <20250411195610.GA3781976-robh@kernel.org>
In-Reply-To: <20250411195610.GA3781976-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB9743:EE_
x-ms-office365-filtering-correlation-id: 86a3d6a9-b2c2-49b9-95ae-08dd7b013cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aKqQYsvXE2NCLSRKq8T0AajlPieVAw2EtXSpnp86KT8lJeTsECmm54fIIY68?=
 =?us-ascii?Q?mlpurwM8Jy+mksy8qhIbByI52Far/L1gVhntB6x1920cluKJQc/yARWlp5BN?=
 =?us-ascii?Q?oKNiY7pce1HzfRt4DbzAt3uV1nBwCfz2kaKj/Puiar7YtJFC0biHVQkuQbsp?=
 =?us-ascii?Q?IgYGRsymzYul2YXDMvuiMAPsCQWt9ZifBRSNLojphsvhUwfVaca5+84NqI6q?=
 =?us-ascii?Q?HnApaDf07LtcLQoXqkI/Xf6Pplhdq2oNd2ZrSn9SdqJE0DE2SG6dnDSjP/pB?=
 =?us-ascii?Q?4IC1Bx+rbDGf1PCZY9n1Apy13vXBTt4A7TzIF+u3vIejTUlSSYt00eLtT6/+?=
 =?us-ascii?Q?CMReL7CiQLo+oApE99h7aFTROrIwhqZT0RcGyHJhSFjUlLnKLjYob7W+6LIG?=
 =?us-ascii?Q?KTSO2QG8sw5NcDeU11kAcKq/ttXuYvHp3imcaUTfyRbUjB1FBADo4MAzY+oM?=
 =?us-ascii?Q?kBfOxCHdgirEz4le5zAyYq5h46YA/Z4V0l5/SksRr3nEP+BLbQRDhgMMCqBO?=
 =?us-ascii?Q?68wyZh5omSk49gxOLT8wM79FNnf9yrVyBfoisl9bEhNUB81UGijlL03ZFjWB?=
 =?us-ascii?Q?hIG+iapFSqvcqh8OH3D2IWaSR/yUr8AxibJode8/DnZQi2zr80tPtb4jQ+VW?=
 =?us-ascii?Q?AVuFIa6dL9oQ7vcfBjWa2uEhaeuvdkGnxVm7KFzyCFSbB+ZvD/dgdmAMCD7U?=
 =?us-ascii?Q?1HyHR0aGdN4LWAqe2ONYfDwRhLc2pTKkzKAcZcEgWDeSDww2hyUkQ8MBx9RA?=
 =?us-ascii?Q?2G4fLgaR+PG18TKPswqO0SRFbxfahBWKzHhw99hrKx8EFmUVq5XfVDvlbfU3?=
 =?us-ascii?Q?0TeMoy0B1tPpc/S6gCmM+iw5axhQjIz13dB8JiVlhqtrOFxAQnbBvkThp/W7?=
 =?us-ascii?Q?gc9hspIk2pUIm9FKzxAO3aC+EqMmsWxlizyoM9M5VtV5ye5PjsPiHZs4hVEs?=
 =?us-ascii?Q?PgGrJbYFgCIuDPH7ela+pYMKTAj9g/JrP+sw9hCCegBPExIq6qx2TFgIyatu?=
 =?us-ascii?Q?HVJ3VyD8wwZmy50YP8Wnpxc9C4hh4AZTCthBd8HpaBdNZvZCtFzWkV4kIIbx?=
 =?us-ascii?Q?9zP/IwYNZGiI4A4LDha47KUfxywbnUw9bCXOKmgpp6sG5WQqFf+72hZS9ZxF?=
 =?us-ascii?Q?woHTQ9s0Si0i/32ZLHnFxH3IBG3/H615ibmSTZ6oFWMdWBSlRPgDPM+S3irE?=
 =?us-ascii?Q?rabRTa/931DF7iXN4UI10ppk9s3muUQJsZMEGZHuLvne72i3gOFDUuc2VWiv?=
 =?us-ascii?Q?p3ZmkH6sbwykn9mgt4+47UFoArBrbkHDsmsJg+peIAzv7brOf6UnoHJ/KjxN?=
 =?us-ascii?Q?5Ba2Iuq97bACO7DMkShZHtDqdNRfMDDq2G6Xwz2+WOcCDk5rTmhxhk105Ci7?=
 =?us-ascii?Q?u3wJYNPmpOIUr5M3009LtU7SYE4wKy0b3tQtCPpUtEKDlfV6wYhrzAZolEnt?=
 =?us-ascii?Q?o4m319XPiNI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TxC1gn2bA5i8UUdHcWd07iYQ6peytF7t+NCgGcGMT5fnTbnoxsc/avbgpvZ+?=
 =?us-ascii?Q?UMGsMnj6Tq7vR8SmnTxDCH/PbSKCem3NtBTx06Sc0yTkidpFiukJFfBcUHah?=
 =?us-ascii?Q?KmrxqIIiOiAOkMe2BXJdyn5DpxUnLzB1ll0W/HOnfMhh08XSXLNZZLSkJbKL?=
 =?us-ascii?Q?6741jeKpVPzgFzWmEoRi6GaTnB62JF/Q7g4wWZZPfIoEw9vD0r+ZY8bCslbt?=
 =?us-ascii?Q?9KiMespU4KNj3KtaXwxCDKDLxHdpTtCmQVgWDSX0iKni3wZiVRXn9omdMdMN?=
 =?us-ascii?Q?MPQAxcymLm34zcmmBsr44EIxzohL8SkEldFIrxuyKRhiTnQJxbyWxhjkXime?=
 =?us-ascii?Q?Y4IIQprhyPGgxLtqK9/zZrzwsG0Q5fy7m/dZSXOTMNPoUF4PnyoHpmdc470C?=
 =?us-ascii?Q?sVnJJFkvlbnjdkvB/PwaYvLTDWEpchQBPQ4mR9n/OUOTr6Ih470wGsSCZOx5?=
 =?us-ascii?Q?oZJPTLEVCaAd5m/U3V/Cu4/LYr5RJmYIvcP74rZuYQIxe5jbePnYADt4OCbb?=
 =?us-ascii?Q?TTGCifjY+olLNkZSvSYUcMt89zRmgsI4VjLZrQmvoeY/ZvYjTkeU1ipc6n8h?=
 =?us-ascii?Q?SFelm9sn3zbJnXj2FHejc2WJ8R5wJQz/7wUC7aqGHf/WVogJylw1So4i/GgG?=
 =?us-ascii?Q?2U2PkEbmJQbBke1DsVC9ZErckBTlnN0+bou9hhl/+u3aTTCoO8cYZk4ZqWla?=
 =?us-ascii?Q?ssCpMCR3SBDsjdzja6oXDMo6rW1uMd0W0du2Dmz7iGIVPom9E4bUJF9PMRm8?=
 =?us-ascii?Q?fRLeSUzTC9h6p6YsiHs2fr1k+NLsEd8FY0dbwIC5+AM27Q6fjOUdfnEm97bV?=
 =?us-ascii?Q?rvpNlMqw9TMULHj311xQOPaX/CYuCISvMeeDX8Pyu5jKOX8BaAU5vrWqo64J?=
 =?us-ascii?Q?kAYxzn1H2FBXpt+oOgFwaoMtNcdRJgUs5HvBxwSZy7cFPqSObjcQKqmeGqb5?=
 =?us-ascii?Q?7p68qlEGE1OnIZ8buqmb6bZsI3Mjgw3+QXFTyLiRZGnU9Drg4SWalYlMTfiK?=
 =?us-ascii?Q?K1cSPhGmKP5zWFztXj/fNVgVCNNvHeBD/GeRIHJFMy4cJ5MST/3JJZKYBAeN?=
 =?us-ascii?Q?4WQJLiwfrA2zo7kqU5bObG/o/sszT3+AFfCRuAib6VbEAi/hLc5xdJ3T1GXI?=
 =?us-ascii?Q?SK8Vu+YGtQznX2BSI2ICVw5oi0d403xjPLC8xJee6Gn1rqaHX3vW7yAWuL+R?=
 =?us-ascii?Q?pnDKj6/NT5GsVChIUB/REWCbzT8QKbsaVszHCSUHD+smmi1cXWa/eCxcIZYx?=
 =?us-ascii?Q?ky5jKCeI8n9YVC6+zxay2TUnDMqVbzkt/hxiDObmqkd97PPV4m0dPcg2h5gq?=
 =?us-ascii?Q?fUqdpI2iq+R6HEM5lQSBSYLYFqXaVeq4MmOeYIbtv6ZtOP/vhqGdEuaNmQ5Y?=
 =?us-ascii?Q?h6sdat0ZzLbwe+7vBnr2r8dRVw0Ofd5+jk1xnjcqVF6ewdInyth81BNCokJI?=
 =?us-ascii?Q?er+615GnuzdUJ7vQQTvV+Ouda7DjQUahsw4hZYJAq2Ps06kp3HBECIeDVsWy?=
 =?us-ascii?Q?ldwvK7ti4NZXqhWIRzr2Yr1qES8oOzQklVwcjFQTnD/9c9FJuBXtJBOdS+V8?=
 =?us-ascii?Q?xBdRLfBjzX4hRjb6nrw5gEBiGnYGa9HaTy5WAOPv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a3d6a9-b2c2-49b9-95ae-08dd7b013cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:05:39.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5i1PS0/yuYOtV/N/NKvO+60kYchwRLIWFcy6+yaodixF/ugFTylUHdY9dP4I1LPe+zeqAdeuJsBQOUASo2II093dnXih1AU/pUdiLnTFeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9743
X-Authority-Analysis: v=2.4 cv=EeDIQOmC c=1 sm=1 tr=0 ts=67fc7b87 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=_v3gqI2EVln_EuQbkF0A:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: qZJNmYG5a6NHHGb9DJED6ZtEgJW6RZFe
X-Proofpoint-GUID: qZJNmYG5a6NHHGb9DJED6ZtEgJW6RZFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140021

>
>On Fri, Apr 11, 2025 at 06:36:51PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Document the compatible property for HPA (High Performance Architecture)
>> PCIe controller RP configuration.
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.y=
aml
>b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> index a8190d9b100f..83a33c4c008f 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> @@ -7,14 +7,16 @@ $schema:
>https://urldefense.com/v3/__http://devicetree.org/meta-
>schemas/core.yaml*__;Iw!!EHscmS1ygiU1lA!GUdVym9DUn88yPquZ-
>jhRAWxXdadkOpGE7fasG33EWZ0zULMY3fQe_xbMFKTh33x577gU6FU-Ko$
>>  title: Cadence PCIe host controller
>>
>>  maintainers:
>> -  - Tom Joseph <tjoseph@cadence.com>
>
>Why removing? What about all the other Cadence PCIe files?
>

Tom is not longer with Cadence and hence this change.  Will submit a separa=
te patch for other files

>> +  - Manikandan K Pillai <mpillai@cadence.com>
>>
>>  allOf:
>>    - $ref: cdns-pcie-host.yaml#
>>
>>  properties:
>>    compatible:
>> -    const: cdns,cdns-pcie-host
>> +    enum:
>> +      - cdns,cdns-pcie-host
>> +      - cdns,cdns-pcie-hpa-host
>>
>>    reg:
>>      maxItems: 2
>> --
>> 2.47.1
>>

