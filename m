Return-Path: <linux-pci+bounces-16102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045E9BDFA9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 08:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B555B1F23A65
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540FA18FDDE;
	Wed,  6 Nov 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fb19RQGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB83C39;
	Wed,  6 Nov 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879194; cv=fail; b=J/Zv8K4y/eii5CWYtk7GRFhqlF0aBBIfrfK42N6yt9DeFBhthSelpHI2JcZ41tDe25MjpYbLkYhnxo/HQ51SQ629/Vs8ZomSE++LAclRuIRw36wgnb3a4UTCz35EbfbHko5XEPKbQLjBHxM25vDT/wE/9L2tJQOR2Y/GEhjpEsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879194; c=relaxed/simple;
	bh=sik2NS3S1siVXp/GrA1wwVO0JdtKNUaE48yQaZ8YKeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eb09pjCftPzM9yxaPjWTWYBjv9nLQUGJyj0NA3sSy+tOTBQeh6jbFM2w44mvLBL4ON/gyxKOkSqzjiD3EtjApFMMo5ecMH7gHe5SXbWl6cGPW4Ln7Xl+oEa5UAA5ICx18VpVwhkoecmQHO/Jm6ai7F+MFNxHal1sPyAclgO6hRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fb19RQGq; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5NReQb019427;
	Tue, 5 Nov 2024 23:45:59 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42qw280u3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 23:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds4k2kmc4sskkXsK8F7Sv5gb/nJgcDyHMXgm5ip+vqkE15AmgRkzis6hTwrlBVO/KHlWZti7uTdndMiiH5cW8K6uHqj+MjC9F7b5o7bqEQ9sxvs/cOu7h8oKKNE81Vc/EA+9037/tQJ3B4LUWsn2hsJReTi2Ipbd3cGo+fxlp2aCWm2Ovw2Jtc2rsrlwl/rZaAMs8jrvRWLArI8McnHzBgv79dhtRGhbRwMCXqGuPemVJg3vkKKT5BAivBPmHr9z75qeIbmNMVQJaGrSvAxVP1M0yrcydIaKJLr8wbjjMRzNz6p64dkCkqt0zyl1xEvrrk/wLib4+bSev7/G/5k+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqsOzKXkI6bU03CiiXORkENBgOxLJk5I9WCtJ8WPedM=;
 b=pzcGs1L7Wah2jkhJd0b36GoU2KxIf3apRKT+mOz/2nXxaaTNdd9qu/cKjApqXAagy3/ewjuX4PEff6IO9q49dBCLOXreTalD2NyeD75KaySbNJRrxSmyVTzdDNHUVXlaL+DKqSBSBxosOvA80fC8IDp210mdUGqtGvOOo69+PPcNnO5TLDyPw2I9jKfcEBqyAmPugczn7uO2NmRj3iGKY4NL0kJ483xvmEx4DVCLwuGh1dlkNJuM2WJYhMaBaOEyItz5OiRlULUnNymvNm0CJCyC6VjCwnTh5frDCJERg4wcKA57wnczm4GkXpEhT8hab1rCBMCkmTumC4lCzz73JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqsOzKXkI6bU03CiiXORkENBgOxLJk5I9WCtJ8WPedM=;
 b=fb19RQGq0BYlIovWFmhFaJuy1pYcnDoT1aq0b8Q65Al3JjO2rv0XFADawt7x9jkf0v31buFlPsERj7ywWYbWYaVglBmt2W3iil7kyzduzGgxMLDV2cKhkMvJ4ia2OrjLm4cwQRqSGg4jdU+r8T2dXson3dCJs/Cj13lL0+Lh7AE=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by DS0PR18MB5456.namprd18.prod.outlook.com (2603:10b6:8:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 07:45:56 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 07:45:56 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>
CC: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHa96U5wMquoeCkjUiLMha3b4gFCrKqTx4w
Date: Wed, 6 Nov 2024 07:45:55 +0000
Message-ID:
 <PH0PR18MB442568DB4B04F4871E03C946D9532@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
 <20240826104531.1232136-1-sthotton@marvell.com>
In-Reply-To: <20240826104531.1232136-1-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|DS0PR18MB5456:EE_
x-ms-office365-filtering-correlation-id: a34615e3-ebcf-48f0-5f09-08dcfe370c2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?24mSV1ofr9GAdBVrOjLhpcobiX6P++UfCdAqmXCyQizu/4dS/MHnw4UA1X?=
 =?iso-8859-2?Q?E/2zfHyDKx6ELLYL4ADfKQpw8OdLlxvDGKuKaI16NNKR2nKF65AZYbC4L6?=
 =?iso-8859-2?Q?nsgIHbhu7rpRqzv50JKqKc0jWQ1/8bk8ApCFXGFnUWucviHYdxQ1P07J+H?=
 =?iso-8859-2?Q?7ksedYt64fd2dvagwBzGwZ1ruXUN5BiP0SfNmythmBIukVh8Kb6Dv3BWVK?=
 =?iso-8859-2?Q?R9GbeYQwvUvZtRXSIaFWFJD6I1oy6c2KmBCVlGwfPAwgTxP/D7xJuEHFLy?=
 =?iso-8859-2?Q?AxHgBq4T2xtCcvmyQ8S73iqPkR8jfAYci1zfn+TuSLOUhXborYt7v3jjCB?=
 =?iso-8859-2?Q?AoCOPLULL2bzYO5dapTm7XJwANHPLUs1HMYmCu1ZX5CsetrID+oKCJFmJn?=
 =?iso-8859-2?Q?InWocsc44EhWwr4bJhxmxPSMY7qro0nzuk5R8txUZ9dlOier1ZbSAqH/vu?=
 =?iso-8859-2?Q?xu4b2AVMMDzkFO9/TxBdz4zIUYiEzgWRdrguaYuOUJj/b9sKobS0yVFOTX?=
 =?iso-8859-2?Q?+Y12sB2aDsGEyozMslLfs8cfs8uA4hIWLuwyNweQeQ8hwfnpLe1YZJREaH?=
 =?iso-8859-2?Q?8Z4iWJBr334jQzOOYFttWgbknIV6UbacIXbvpt0u+MWA2vnDYytjK251Mc?=
 =?iso-8859-2?Q?B2IJIYC0sdOlKSae1/1Lk4J95Fv4gKO2c0HAUKVi0jiandsO+6NBvU/kuc?=
 =?iso-8859-2?Q?tOC/DZJznjnJtyWFwZSU+XwaEENA3qXjgy5TzhICvAiRFFtrHEMnOoXi0i?=
 =?iso-8859-2?Q?+Nk4OcPDQr8UaP7m875pscqLuwu0Dd0uLljdhZEj/1MvWkZZzqnNo8s10A?=
 =?iso-8859-2?Q?1Q/GtOuC40KeIRmHQsjEVUoz3bnAN8tfEQ2oH5EN7J83PmJJWvnEr99hUi?=
 =?iso-8859-2?Q?2faZ7Fjf9lfYiWZBjvqfsNv4x9bJ9CNZ/IN8DfNLMurxJOwpDTu0C7efnp?=
 =?iso-8859-2?Q?XaIb7E3NNzB8y67Ex1p5csp14AVu6Vs6NeBUq/7mJWH2+PsNZsSW+n0LRW?=
 =?iso-8859-2?Q?7NxV2kSR8vNeRZI3uOJ/biSx2VgWPEK4W7pKKm4ogdlGms1+gNzqB/zNGi?=
 =?iso-8859-2?Q?1ooJ2GSLGnZU6HNv6yJZXwLrHAyYfsX5H7S35Z/Zz2iOjInh85K0UZwO9z?=
 =?iso-8859-2?Q?FyKZyTPYfc7HF6fRTI0me5Wz3NaLY/QhWCaM/UkczWYFho25+BLAIjwxYw?=
 =?iso-8859-2?Q?tITpyOxMe2EJbFQ6pVeRlOq1KkKX0AseFmZMXZCaPyoE/YsUHAC8eg1FEC?=
 =?iso-8859-2?Q?kZgllpyWsTHQ9/H57Ig/OPkkpZ0qYLFjWD3TnMkaOJUkSJB5P2doPODvym?=
 =?iso-8859-2?Q?KdyVTejcAFnrEHHRloZDCaTC3LXUJinduEkmq1oe7MQxq3JEmDvHuE9A7k?=
 =?iso-8859-2?Q?AcNo9A4kP45RZ0IHpPKsH3tluj7app1F++d3lf4eCQNeYnw/sepXo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?H2V+4+XzBtkPKEFHmszV1VQoCOgSHJcia7VDjnbOm29VbfHTVSCTFADw29?=
 =?iso-8859-2?Q?omBZBnnaDPeuy+v0OSpL0eulx4rfCdoXIQZmfA1Th5q6Wqp2n6HcJ9WtGw?=
 =?iso-8859-2?Q?cIdCmeaOxE8kYPTkLekt5d4PaplpWXXp0EWb3RImBIy/ccdhbpRLqpzmSg?=
 =?iso-8859-2?Q?z0IqBUtxnta6MkQgPaJg9xfcvHgxUMt7SZJ1nQt/zhUZmETJb5cAl9SO5N?=
 =?iso-8859-2?Q?9cMHofYDthvALReKVrlGEAaH/V2LzNMW4g7V9NqyVTEYnF+qtZa/GNiGh+?=
 =?iso-8859-2?Q?j7ngqm0gl/EgkbdNADXWNnVmiJtAe/kaeAQnJa+thT5kBAwPne5Yx26T1r?=
 =?iso-8859-2?Q?f5ACpK0yWf8Keuk9ZVqjfxdBP8naub9+q7W7487GuAq7K+e4Mfi3PbOQ6c?=
 =?iso-8859-2?Q?Db/JNwS2VrIHiv/B7SZ4b4wu/wY9XpmzTulsejLZ5EtSqwSx6m/sJQGBHA?=
 =?iso-8859-2?Q?FSfzOJfRRSllxKYmh8gN8KGuel4LgIgdWuTb0Fgw4U5BZs6HJ4B5zFP0d+?=
 =?iso-8859-2?Q?1WrGJPx+NAIyY5N2NHtNkg8euUdmeIEEFhUUdjFMnQ8V3pUiAgUabLTWOT?=
 =?iso-8859-2?Q?6EqhO4O5F/QFbaPqi6JhQTv+n75Ya66pNBbOaUkt1KlwcPW7Qh6Bsu9SWs?=
 =?iso-8859-2?Q?mtcDYNasyRAv4SlE57s7zKl3QHZjksnUzMlsAExHgxiq/LMk5Tf8J8Fa1Z?=
 =?iso-8859-2?Q?fxctj1am6ndErgvh9cA0yUdxCi8yXFb7gVQqL1u+lIgiu82fkBvTTsO9lO?=
 =?iso-8859-2?Q?YVS1HzGYd8p7DffoNIxbVQYxBD6+A8Nv/7isC2IdoqOw7gJxt+0Fyhb98X?=
 =?iso-8859-2?Q?1FdqW6QZ7L1mJcyyX9XzjHjWEsN31gK8g5TzjxqwFg88BB7Cfs2YU502on?=
 =?iso-8859-2?Q?cRioDqvfR+qk2oiwESc3VYvQorlswkY1o6VR1qwuerMFo+2tBh2kelshAw?=
 =?iso-8859-2?Q?2D2DwU5eb987lSiadOli/JUpiMDEhWBLPA5HnRaClFvoRvWGOJ3PiPqfy9?=
 =?iso-8859-2?Q?Pyi0xPyDLUSxYB9sDysdP86npE5UtQiz6L3QiPrXjQ0RiaQd1lLgWNBXkM?=
 =?iso-8859-2?Q?KX7n2HxDWeLhenm9L9u+F6Rdzzg8XraHXcmLWbOysP1Nwwe9x3CAY2QvwO?=
 =?iso-8859-2?Q?3Eqoj8a8d9kC6QBvpSiHBt+0Dq27v0Zo/HAdvYV5kYTfL/TUUWIqJJRrZ9?=
 =?iso-8859-2?Q?5JYGbqpBqEig3rE8EiKLtuFV7p7jjMPDXVkYncRCSwTivlYFq1hN+kGOPR?=
 =?iso-8859-2?Q?EzH8XwNHDkbwSvTuh0GxEMb8IDhZeDUVwjG2BMhryQn2tMxdb1PJztLo+Q?=
 =?iso-8859-2?Q?f/G8pu/UjOHFlMmgDBueMg0y6edw3qifddWvmDY8uDrW69JlYunvhjgrUb?=
 =?iso-8859-2?Q?5xnasoKhtXdtTwsqsPI84xFAyh1nCfk6zIz7x64+vkSVR2n35dZESO/qBS?=
 =?iso-8859-2?Q?ZP1Uc36XswxP5dyoZeTZeAHOi6s5gDUniw2tTvdZKK4JIiHvCG3zvIhA1k?=
 =?iso-8859-2?Q?fB/NiukylC+THXMmfTKCImMRwo4NbTVVJvMKFr+C+LUepyfsQqIt2ewOEk?=
 =?iso-8859-2?Q?htuIBbRLA9yR1uH8vq1FAqxfiy1n25kZm4X/jKXSowRVXtOXxZULLf0THj?=
 =?iso-8859-2?Q?E8otu3hFkGuOgXeLwtvfQ4NSnYTFRQbSbc?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34615e3-ebcf-48f0-5f09-08dcfe370c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 07:45:56.0209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdpu+FzXCoCIqlylBDbCfR1Z11MfwvVEubQ9cPFo4ETqwC9e8JmkfbWen34PXMibkwiWjDLDVxWVZxFLY2jrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5456
X-Proofpoint-GUID: G_Vq-bjM-njH5FIA73J1MPJ7-oupeYcU
X-Proofpoint-ORIG-GUID: G_Vq-bjM-njH5FIA73J1MPJ7-oupeYcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01


Just a gentle reminder to review the patch. Let me know if any adjustments =
are
needed. Thanks!

>
>This patch introduces a PCI hotplug controller driver for the OCTEON
>PCIe device, a multi-function PCIe device where the first function acts
>as a hotplug controller. It is equipped with MSI-x interrupts to notify
>the host of hotplug events from the OCTEON firmware.
>
>The driver facilitates the hotplugging of non-controller functions
>within the same device. During probe, non-controller functions are
>removed and registered as PCI hotplug slots. The slots are added back
>only upon request from the device firmware. The driver also allows the
>enabling and disabling of the slots via sysfs slot entries, provided by
>the PCI hotplug framework.
>
>Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>---
>
>This patch introduces a PCI hotplug controller driver for OCTEON PCIe hotp=
lug
>controller. The OCTEON PCIe device is a multi-function device where the fi=
rst
>function acts as a PCI hotplug controller.
>
>              +--------------------------------+
>              |           Root Port            |
>              +--------------------------------+
>                              |
>                             PCIe
>                              |
>+---------------------------------------------------------------+
>|              OCTEON PCIe Multifunction Device                 |
>+---------------------------------------------------------------+
>            |                    |              |            |
>            |                    |              |            |
>+---------------------+  +----------------+  +-----+  +----------------+
>|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>+---------------------+  +----------------+  +-----+  +----------------+
>            |
>            |
>+-------------------------+
>|   Controller Firmware   |
>+-------------------------+
>
>The hotplug controller driver facilitates the hotplugging of non-controlle=
r
>functions in the same device. During the probe of the driver, the non-cont=
roller
>function are removed and registered as PCI hotplug slots. They are added b=
ack
>only upon request from the device firmware. The driver also allows the use=
r to
>enable/disable the functions using sysfs slot entries provided by PCI hotp=
lug
>framework.
>
>This solution adopts a hardware + software approach for several reasons:
>
>1. To reduce hardware implementation cost. Supporting complete hotplug
>   capability within the card would require a PCI switch implemented withi=
n.
>
>2. In the multi-function device, non-controller functions can act as emula=
ted
>   devices. The firmware can dynamically enable or disable them at runtime=
.
>
>3. Not all root ports support PCI hotplug. This approach provides greater
>   flexibility and compatibility across different hardware configurations.
>
>The hotplug controller function is lightweight and is equipped with MSI-x
>interrupts to notify the host about hotplug events. Upon receiving an
>interrupt, the hotplug register is read, and the required function is enab=
led
>or disabled.
>
>This driver will be beneficial for managing PCI hotplug events on the OCTE=
ON
>PCIe device without requiring complex hardware solutions.
>
>Changes in v2:
>- Added missing include files.
>- Used dev_err_probe() for error handling.
>- Used guard() for mutex locking.
>- Splited cleanup actions and added per-slot cleanup action.
>- Fixed coding style issues.
>- Added co-developed-by tag.
>
>Changes in v3:
>- Explicit assignment of enum values.
>- Use pcim_iomap_region() instead of pcim_iomap_regions().
>
> MAINTAINERS                    |   6 +
> drivers/pci/hotplug/Kconfig    |  10 +
> drivers/pci/hotplug/Makefile   |   1 +
> drivers/pci/hotplug/octep_hp.c | 409
>+++++++++++++++++++++++++++++++++
> 4 files changed, 426 insertions(+)
> create mode 100644 drivers/pci/hotplug/octep_hp.c
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 42decde38320..7b5a618eed1c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
> R:	vattunuru@marvell.com
> F:	drivers/vdpa/octeon_ep/
>
>+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>+R:	Shijith Thotton <sthotton@marvell.com>
>+R:	Vamsi Attunuru <vattunuru@marvell.com>
>+S:	Supported
>+F:	drivers/pci/hotplug/octep_hp.c
>+
> MATROX FRAMEBUFFER DRIVER
> L:	linux-fbdev@vger.kernel.org
> S:	Orphan
>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>index 1472aef0fb81..2e38fd25f7ef 100644
>--- a/drivers/pci/hotplug/Kconfig
>+++ b/drivers/pci/hotplug/Kconfig
>@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>
> 	  When in doubt, say Y.
>
>+config HOTPLUG_PCI_OCTEONEP
>+	bool "OCTEON PCI device Hotplug controller driver"
>+	depends on HOTPLUG_PCI
>+	help
>+	  Say Y here if you have an OCTEON PCIe device with a hotplug
>+	  controller. This driver enables the non-controller functions of the
>+	  device to be registered as hotplug slots.
>+
>+	  When in doubt, say N.
>+
> endif # HOTPLUG_PCI
>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>index 240c99517d5e..40aaf31fe338 100644
>--- a/drivers/pci/hotplug/Makefile
>+++ b/drivers/pci/hotplug/Makefile
>@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>rpaphp.o
> obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
> obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
> obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>
> # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>
>diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp=
.c
>new file mode 100644
>index 000000000000..77dc2740f43e
>--- /dev/null
>+++ b/drivers/pci/hotplug/octep_hp.c
>@@ -0,0 +1,409 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* Copyright (C) 2024 Marvell. */
>+
>+#include <linux/cleanup.h>
>+#include <linux/container_of.h>
>+#include <linux/delay.h>
>+#include <linux/dev_printk.h>
>+#include <linux/init.h>
>+#include <linux/interrupt.h>
>+#include <linux/io-64-nonatomic-lo-hi.h>
>+#include <linux/kernel.h>
>+#include <linux/list.h>
>+#include <linux/module.h>
>+#include <linux/mutex.h>
>+#include <linux/pci.h>
>+#include <linux/pci_hotplug.h>
>+#include <linux/slab.h>
>+#include <linux/spinlock.h>
>+#include <linux/workqueue.h>
>+
>+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>+#define OCTEP_HP_DRV_NAME "octep_hp"
>+
>+/*
>+ * Type of MSI-X interrupts.
>+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>used to
>+ * generate the vector and offset for an interrupt type.
>+ */
>+enum octep_hp_intr_type {
>+	OCTEP_HP_INTR_INVALID =3D -1,
>+	OCTEP_HP_INTR_ENA =3D 0,
>+	OCTEP_HP_INTR_DIS =3D 1,
>+	OCTEP_HP_INTR_MAX =3D 2,
>+};
>+
>+struct octep_hp_cmd {
>+	struct list_head list;
>+	enum octep_hp_intr_type intr_type;
>+	u64 intr_val;
>+};
>+
>+struct octep_hp_slot {
>+	struct list_head list;
>+	struct hotplug_slot slot;
>+	u16 slot_number;
>+	struct pci_dev *hp_pdev;
>+	unsigned int hp_devfn;
>+	struct octep_hp_controller *ctrl;
>+};
>+
>+struct octep_hp_intr_info {
>+	enum octep_hp_intr_type type;
>+	int number;
>+	char name[16];
>+};
>+
>+struct octep_hp_controller {
>+	void __iomem *base;
>+	struct pci_dev *pdev;
>+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
>+	struct work_struct work;
>+	struct list_head slot_list;
>+	struct mutex slot_lock; /* Protects slot_list */
>+	struct list_head hp_cmd_list;
>+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>+};
>+
>+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>+				 struct octep_hp_slot *hp_slot)
>+{
>+	guard(mutex)(&hp_ctrl->slot_lock);
>+	if (hp_slot->hp_pdev) {
>+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>enabled\n",
>+			hp_slot->slot_number);
>+		return;
>+	}
>+
>+	/* Scan the device and add it to the bus */
>+	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>+						  hp_slot->hp_devfn);
>+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>+	pci_bus_add_device(hp_slot->hp_pdev);
>+
>+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
>+		hp_slot->slot_number);
>+}
>+
>+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>+				  struct octep_hp_slot *hp_slot)
>+{
>+	guard(mutex)(&hp_ctrl->slot_lock);
>+	if (!hp_slot->hp_pdev) {
>+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>+			hp_slot->slot_number);
>+		return;
>+	}
>+
>+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
>+		hp_slot->slot_number);
>+
>+	/* Remove the device from the bus */
>+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>+	hp_slot->hp_pdev =3D NULL;
>+}
>+
>+static int octep_hp_enable_slot(struct hotplug_slot *slot)
>+{
>+	struct octep_hp_slot *hp_slot =3D
>+		container_of(slot, struct octep_hp_slot, slot);
>+
>+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>+	return 0;
>+}
>+
>+static int octep_hp_disable_slot(struct hotplug_slot *slot)
>+{
>+	struct octep_hp_slot *hp_slot =3D
>+		container_of(slot, struct octep_hp_slot, slot);
>+
>+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>+	return 0;
>+}
>+
>+static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>+	.enable_slot =3D octep_hp_enable_slot,
>+	.disable_slot =3D octep_hp_disable_slot,
>+};
>+
>+#define SLOT_NAME_SIZE 16
>+static struct octep_hp_slot *
>+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
>+		       struct pci_dev *pdev, u16 slot_number)
>+{
>+	char slot_name[SLOT_NAME_SIZE];
>+	struct octep_hp_slot *hp_slot;
>+	int ret;
>+
>+	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>+	if (!hp_slot)
>+		return ERR_PTR(-ENOMEM);
>+
>+	hp_slot->ctrl =3D hp_ctrl;
>+	hp_slot->hp_pdev =3D pdev;
>+	hp_slot->hp_devfn =3D pdev->devfn;
>+	hp_slot->slot_number =3D slot_number;
>+	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>+
>+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
>+	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>+			      PCI_SLOT(pdev->devfn), slot_name);
>+	if (ret) {
>+		kfree(hp_slot);
>+		return ERR_PTR(ret);
>+	}
>+
>+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>+
>+	return hp_slot;
>+}
>+
>+static void octep_hp_deregister_slot(void *data)
>+{
>+	struct octep_hp_slot *hp_slot =3D data;
>+	struct octep_hp_controller *hp_ctrl =3D hp_slot->ctrl;
>+
>+	pci_hp_deregister(&hp_slot->slot);
>+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
>+	list_del(&hp_slot->list);
>+	kfree(hp_slot);
>+}
>+
>+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
>+			     struct pci_dev *pdev)
>+{
>+	/* Check if the PCI device can be hotplugged */
>+	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus &&
>+	       PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>+}
>+
>+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>+				 struct octep_hp_cmd *hp_cmd)
>+{
>+	struct octep_hp_slot *hp_slot;
>+
>+	/*
>+	 * Enable or disable the slots based on the slot mask.
>+	 * intr_val is a bit mask where each bit represents a slot.
>+	 */
>+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
>+			continue;
>+
>+		if (hp_cmd->intr_type =3D=3D OCTEP_HP_INTR_ENA)
>+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
>+		else
>+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
>+	}
>+}
>+
>+static void octep_hp_work_handler(struct work_struct *work)
>+{
>+	struct octep_hp_controller *hp_ctrl;
>+	struct octep_hp_cmd *hp_cmd;
>+	unsigned long flags;
>+
>+	hp_ctrl =3D container_of(work, struct octep_hp_controller, work);
>+
>+	/* Process all the hotplug commands */
>+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>+		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list,
>+					  struct octep_hp_cmd, list);
>+		list_del(&hp_cmd->list);
>+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>+
>+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>+		kfree(hp_cmd);
>+
>+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>+	}
>+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>+}
>+
>+static enum octep_hp_intr_type octep_hp_intr_type(struct
>octep_hp_intr_info *intr,
>+						  int irq)
>+{
>+	enum octep_hp_intr_type type;
>+
>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>type++) {
>+		if (intr[type].number =3D=3D irq)
>+			return type;
>+	}
>+
>+	return OCTEP_HP_INTR_INVALID;
>+}
>+
>+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>+{
>+	struct octep_hp_controller *hp_ctrl =3D data;
>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>+	enum octep_hp_intr_type type;
>+	struct octep_hp_cmd *hp_cmd;
>+	u64 intr_val;
>+
>+	type =3D octep_hp_intr_type(hp_ctrl->intr, irq);
>+	if (type =3D=3D OCTEP_HP_INTR_INVALID) {
>+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
>+		return IRQ_HANDLED;
>+	}
>+
>+	/* Read and clear the interrupt */
>+	intr_val =3D readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>+
>+	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>+	if (!hp_cmd)
>+		return IRQ_HANDLED;
>+
>+	hp_cmd->intr_val =3D intr_val;
>+	hp_cmd->intr_type =3D type;
>+
>+	/* Add the command to the list and schedule the work */
>+	spin_lock(&hp_ctrl->hp_cmd_lock);
>+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>+	spin_unlock(&hp_ctrl->hp_cmd_lock);
>+	schedule_work(&hp_ctrl->work);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static void octep_hp_irq_cleanup(void *data)
>+{
>+	struct octep_hp_controller *hp_ctrl =3D data;
>+
>+	pci_free_irq_vectors(hp_ctrl->pdev);
>+	flush_work(&hp_ctrl->work);
>+}
>+
>+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
>+				enum octep_hp_intr_type type)
>+{
>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>+	struct octep_hp_intr_info *intr;
>+	int irq;
>+
>+	irq =3D pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
>+	if (irq < 0)
>+		return irq;
>+
>+	intr =3D &hp_ctrl->intr[type];
>+	intr->number =3D irq;
>+	intr->type =3D type;
>+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
>+
>+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
>+				IRQF_SHARED, intr->name, hp_ctrl);
>+}
>+
>+static int octep_hp_controller_setup(struct pci_dev *pdev,
>+				     struct octep_hp_controller *hp_ctrl)
>+{
>+	struct device *dev =3D &pdev->dev;
>+	enum octep_hp_intr_type type;
>+	int ret;
>+
>+	ret =3D pcim_enable_device(pdev);
>+	if (ret)
>+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
>+
>+	hp_ctrl->base =3D pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
>+	if (IS_ERR(hp_ctrl->base))
>+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
>+				     "Failed to map PCI device region\n");
>+
>+	pci_set_master(pdev);
>+	pci_set_drvdata(pdev, hp_ctrl);
>+
>+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>+	mutex_init(&hp_ctrl->slot_lock);
>+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>+	hp_ctrl->pdev =3D pdev;
>+
>+	ret =3D pci_alloc_irq_vectors(pdev, 1,
>+
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
>+				    PCI_IRQ_MSIX);
>+	if (ret < 0)
>+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X
>vectors\n");
>+
>+	ret =3D devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
>+	if (ret)
>+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ
>cleanup action\n");
>+
>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>type++) {
>+		ret =3D octep_hp_request_irq(hp_ctrl, type);
>+		if (ret)
>+			return dev_err_probe(dev, ret,
>+					     "Failed to request IRQ for vector
>%d\n",
>+					     OCTEP_HP_INTR_VECTOR(type));
>+	}
>+
>+	return 0;
>+}
>+
>+static int octep_hp_pci_probe(struct pci_dev *pdev,
>+			      const struct pci_device_id *id)
>+{
>+	struct octep_hp_controller *hp_ctrl;
>+	struct pci_dev *tmp_pdev =3D NULL;
>+	struct octep_hp_slot *hp_slot;
>+	u16 slot_number =3D 0;
>+	int ret;
>+
>+	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>+	if (!hp_ctrl)
>+		return -ENOMEM;
>+
>+	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>+	if (ret)
>+		return ret;
>+
>+	/*
>+	 * Register all hotplug slots. Hotplug controller is the first function
>+	 * of the PCI device. The hotplug slots are the remaining functions of
>+	 * the PCI device. They are removed from the bus and are added back
>when
>+	 * the hotplug event is triggered.
>+	 */
>+	for_each_pci_dev(tmp_pdev) {
>+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
>+			continue;
>+
>+		hp_slot =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>slot_number);
>+		if (IS_ERR(hp_slot))
>+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
>+					     "Failed to register hotplug slot
>%u\n",
>+					     slot_number);
>+
>+		ret =3D devm_add_action(&pdev->dev, octep_hp_deregister_slot,
>+				      hp_slot);
>+		if (ret)
>+			return dev_err_probe(&pdev->dev, ret,
>+					     "Failed to add action for
>deregistering slot %u\n",
>+					     slot_number);
>+		slot_number++;
>+	}
>+
>+	return 0;
>+}
>+
>+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>+static struct pci_device_id octep_hp_pci_map[] =3D {
>+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>OCTEP_DEVID_HP_CONTROLLER) },
>+	{ },
>+};
>+
>+static struct pci_driver octep_hp =3D {
>+	.name =3D OCTEP_HP_DRV_NAME,
>+	.id_table =3D octep_hp_pci_map,
>+	.probe =3D octep_hp_pci_probe,
>+};
>+
>+module_pci_driver(octep_hp);
>+
>+MODULE_LICENSE("GPL");
>+MODULE_AUTHOR("Marvell");
>+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>--
>2.25.1


