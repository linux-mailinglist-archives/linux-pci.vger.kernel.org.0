Return-Path: <linux-pci+bounces-1940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13616828BA1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144BF1C210A5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EEF3BB25;
	Tue,  9 Jan 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kdw71M/o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UOYOMteg"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC03BB2C;
	Tue,  9 Jan 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704823144; x=1736359144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r5YFzULmOfYvdbOTxTn6qh31C8F/2qPjT1r+LtWmH2U=;
  b=Kdw71M/o1o11QjamPih2vSDGngDOd1BHmoMw0BDfApLofPUzyuCleBXX
   K2jWVymDByeVKSKUCpJjSYpitmfCD9+kf05dAPWSwbR90F3zJAJk1pkZl
   H8zmBbZ7RoYr4HT558L2kYGYIaPwD63FrzZ+hNQs9rclbIfDnNBHKKbyU
   vps9+m49bRVAajqBfXXQys5ojv35mbO5H91TeACtr6xsRGkP/+l9hmvwn
   cyAMXBX+b2BWLArjQfJjoOjt0yfuTi2lWmE27lI2gE7ZnhgqiqxRw9owp
   nCerRdVV2BUEvvcrDrJm6nyKrTKKsIdinCLjC0eXhakxQfOL1VqFSHw2R
   Q==;
X-CSE-ConnectionGUID: Tash1ezdSdCexAt2JGoCkQ==
X-CSE-MsgGUID: 2lMlqeZ5ReKzNN49Lsqmqw==
X-IronPort-AV: E=Sophos;i="6.04,183,1695657600"; 
   d="scan'208";a="6479688"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 01:58:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmKO/ZYMNIs7z8NtXQkZB+drF9dhFxpwQO2LvgEOPUanGSSEo6WPlD7abQ3loBeIw6pAZAwyWJgUIN0LVvYvf+le+M0R4qxvzyf0qQa3oEZKB2NZztS8QpxxpAqj71Io1TOAtl6hi91ozOQMa6B3PURx6DxadmgfY9KiYAHIMFMk0LFQWxf3wRUqtiApJ+pJEB9c6aj/eQe+p5nhJxVuOrdajcCCnyTzRBpUzRRDstCXc4QMUa52d+I0PMjxdVrEemekwVKKcTGo883p9v9ihwSlHU7nS5YNVEFdDFCL8NoTZq13DR83BZBNySjm0UIsj4o73+ieX6Z+Twa+SShitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5YFzULmOfYvdbOTxTn6qh31C8F/2qPjT1r+LtWmH2U=;
 b=IKuDvBOhgkMY/X4RoPDtrxjhcuIL6EXGa+56JnudlolagIo1Wkye9/jbMCPjeymqi3JdgH/EUDAOK7Z1P6Ir4UbB5lmZDYmuZPH+JPXf+T36ukikKiFWE2JBrGaio6mFYBP8A1Cf6nfkqp7rnzjKGIEAKQvwgjNXhM3LiRwm378ezpg1poOpclqi8n8yLUhJkWxzFxQ9XrjhNrcjsgLLQ5NIONJwR2YGD4PIJzVBnP5JAcFMP+HXz5yWCm9QuQ8Fg5wQI2UlV722RmcBCCKXqqxZhCQfX+dzFDiG4l5X1ryid0mgcilxaNOEwv6eU59JAQKZOXNS1n9b66b9c5NDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5YFzULmOfYvdbOTxTn6qh31C8F/2qPjT1r+LtWmH2U=;
 b=UOYOMteg1khsxhZjuHcNCs6PuZQXN+kwkdXo44kWUNXmlPEPFyj+SdQbDGRZZPffao9UtzmZXdt6dnOhoMgZ5QQjHaaY/UdTvKNq2mqehAPE86cIKfUifdF31+t+ZMiehiPiA+6nAfnIT7Re0wBd/J/+8TJWXdHclx5w/SEVSVc=
Received: from BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14)
 by MN2PR04MB7008.namprd04.prod.outlook.com (2603:10b6:208:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 17:58:54 +0000
Received: from BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa]) by BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:58:54 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>, "vidyas@nvidia.com"
	<vidyas@nvidia.com>
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaQyWCoLb8WRl3KkWO8x9Jzhtf7w==
Date: Tue, 9 Jan 2024 17:58:53 +0000
Message-ID: <ZZ2JXMhdOI1Upabx@x1-carbon>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
 <20240107072707.GC3450972@rocinante>
In-Reply-To: <20240107072707.GC3450972@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB4850:EE_|MN2PR04MB7008:EE_
x-ms-office365-filtering-correlation-id: b117c58b-2255-4ccb-fe44-08dc113ca4ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gBSi9Q8lFQAReVOMaj8pMZkoS9jnp98j+VLhJdKaQx+heUmKi6I0sNdMOBQd6OtvHOOY2CMuVZt9o3MmyfR9aBZWN7exxywfUuBWGL+wi4FRZmdElbLAWiV42FEE8tXJtgR0yF0zVOV/wQHi4OaGCnJ7tKv+H6slZvIS4GM7zG4f5GFPzjP57+CDTuN6yxj/UB/QLPxxv/45FyaBLbBZDW4ir4eo4u5c9JeK9N8ZzdgHpwokfXa8tEMCQHCly99fG3YhKN42XnCDDxXlYrpT1VN+rh1Khrjn9VWKjlb0XhtzEGZm+Q4hsQj0yYmprekW4TYBzVrTyvjYhtPxDes3N1jKwFdSXvjMwufHJ58BuSOm03BnJPV37fWpvQ+yLYCiyyFR5J9jwAzKgqJ1aklp0VBUAiJ8weLKipFC4PeCXMWO9djoGDv2O+qOgWMgYh5BBXh3eHcDiYKAVJmQV6xu5OpHIoAbWogHr2AW9Q+SZMkB0bAWZBkz7PciPItHV9lqDDJXIBGIvZdqoGoncC+E95BEIVKXc3o5VGKK84+WyEbvt6VXYCZVsUzGEZqOfNznEjjfU3dWryHFLrw0CPBs7NV1sGTdrm/J2v0s+CR6U2LEASWpu4zYszYydeii4U3F7MGKXUZuTvsotrzy5C4u2A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4850.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(7416002)(122000001)(82960400001)(4326008)(38100700002)(2906002)(5660300002)(38070700009)(41300700001)(54906003)(9686003)(6486002)(33716001)(86362001)(6512007)(6506007)(6916009)(316002)(8676002)(8936002)(66946007)(66556008)(66476007)(91956017)(76116006)(64756008)(83380400001)(66446008)(966005)(71200400001)(26005)(478600001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVZvRGhzcXR5OFZUWmV3bklDQ09aMkd4dDhMQTVPdWRoT0FZcU83VkNLR2V0?=
 =?utf-8?B?U2NoQ1lpL2JJeENZNC9pZTNWYmZ3bDYydjZOVENodno4RDAyYVpZdzhpYTM5?=
 =?utf-8?B?WDBZQWFWbXlRY2RBWDlyVGtiem9HcndEeWlPRnJUY3BPZXFOWUtpN1lsNnp6?=
 =?utf-8?B?TzNCS202R1JjMGZQbGs1VmhTakZCbXhqQktJaitaQXVwRlB6bnIvNTZ3M3Rz?=
 =?utf-8?B?b2lpcldyVVptc2VieFd2SSs4VVJ4U05Gb0lsMnRZeGJUWGhaVjVrN2xObDFt?=
 =?utf-8?B?SHJWL2hxdWFpbzF0RGVKWDBZU3RvMSszRjJYdVhWTGdDaytoMXR1OEloSHNZ?=
 =?utf-8?B?VjUwTWpwTWh2cVp2Q3YzQmJ3d0dXakU4a2dTaVFhK2xpUGY0ZzRiT3A3azhx?=
 =?utf-8?B?K3lRejFVYmcxc0xWWmRuMy9HbHJOWlBESHUxRXdtN0hTc1ZtS3hBS1gwQU5u?=
 =?utf-8?B?enFZSHJQc1VqMEdiZTl0N2dtcEVjWDdaS3NhdnlwT0d1ai9kR2JSUVRvSkQv?=
 =?utf-8?B?MndCZmZjd2tGUk9uczlkWENERGVyYnhKV3ZVd01aRE5ta1RET0g3RlQ1WFZa?=
 =?utf-8?B?WEsxNU9KWEtVTUFWRjlTK1hmamMxMW0zdmJablQvSUw1SGgrUXRJeFF2cVRX?=
 =?utf-8?B?MXRxaU5vUnJZOFFteDBjY0R2Y05iaGtUN0d1c215ZHpVM0w0eDA1RTJtenZ6?=
 =?utf-8?B?ZDh0ZjFmZlREL2hNMi9UL2lDdjk0MHUxTUtpZU04d3ZZUlhUeUZZTk45Ulgz?=
 =?utf-8?B?SC9oei9PN2pGMWNGdGY1VVdVeDdYYzI3bXdkR1dxRzJPN0EvNXZwME5uejdM?=
 =?utf-8?B?Tm1vWHRWV3pWZkNqcG1PUkVqVm1LRjhwTHY3aU5IWEgxeEZjYzdBV2s0cGt0?=
 =?utf-8?B?eHYzUUJSVk1GZkRKa3ZyMlZKWk1RTHVwVExrVzhFY2ZKMG1iaWVZTHBtaGtZ?=
 =?utf-8?B?U25RVDJpUndweTJhYUJ6WEZCZXZmMkVkN2xHMkR2ZnZ1b29mUS9yVjA1RmdE?=
 =?utf-8?B?N0FSNGtLU3FOTndFaElNbSsxRHV4MGZjSk1ZbTJyQ2Fjbms3WVZBUEJORXA5?=
 =?utf-8?B?emRLODdWU2M1ZlIwSy82MytwMzg5UFl5b3ZETldHQzE3TUtvVS9MeXVPRUdE?=
 =?utf-8?B?MWZ2RjRwWU9FVEdHWnlneW1XRGlzZFV6SHFVcGlqQUIvaG5vN25nZXdMWVdC?=
 =?utf-8?B?UkRsMlBHTzNsaFNINFR5eWNXaTNtL2VSS0VkQXRiWWt1VkZROGFQOS9yZDBE?=
 =?utf-8?B?R3cyVjY3dTAvOTNlTWxaaGovREhZeUVuZ3pXM0VJQ1ZjampuMjVKVjREU1NG?=
 =?utf-8?B?Z0E0VkxmS0FRT0Qzb0luUmRXMDVQNmxVV1RoTlJIaXZIREZCdUZ5alBjT1E3?=
 =?utf-8?B?MnU4Q0pjQmIxWGpSeDNFeEIwVnNLMXFSTi9OZ05GeVhxWm5jRmtRVktwLy9r?=
 =?utf-8?B?Y1laaUV0QU5pV3BWYXdXWU5ra21MWWJDbVg1TVhCYzhrcG9VL0lqVWd5Uzln?=
 =?utf-8?B?TG13UkN2NkVncGVzaDJGNnFuS2FyT1hZa3VLcXBiSE0rdEs3VWdYTGxrVWpJ?=
 =?utf-8?B?WUNoT2VEWk1qV2dyT1RTM1JEYmJtTnlLK2FtU0RyTmFaNmxJc0xCUm5jcFdy?=
 =?utf-8?B?T0J3T0hiL1kwNEdma0xTRlpsaGdkUlVOcmlZUEppNGFSajVGbENmRkJjWnVk?=
 =?utf-8?B?MDNrUzMyL3lkbStFT1k4R0dhanNVcmxPMnRxc2pkNmtrLzlHOE15Y3dkZjhO?=
 =?utf-8?B?N2dmUGl1djVlQ05VMDYvSEtCMkF3bUNob0dGQ1dMQTJ4Q091Z20waFNrTlp4?=
 =?utf-8?B?dTRKODhiUFBQSGNXUjNlZVQ5T2NTeFNORlBzMFo2T3A4SkVpUFdCN0xjVGRB?=
 =?utf-8?B?ckpkaXdtcG1kUHNEbmlUeHV5OE8vQzM0T0VZT1V6SlprNGpsa01WaXRodExa?=
 =?utf-8?B?L3NCMVRxaFFuR3Jtemg2aEVjdmJJMjhqdHV4U3R6UWxraGplSWVEU1R3alF0?=
 =?utf-8?B?MmhkQndvaVlhVllyL0Fyb3FqYldZRjRMWDl4MlFnamlTTXg4aEtOU010UGlT?=
 =?utf-8?B?SEZEbEtuc05udW92eVhZc09nZnhkekRGSERxdmU4V2xxdEhkTENkbVR3YWJM?=
 =?utf-8?B?SldjQ2ZjOGJpcVo2Z1N0RUNUakxEOUhTeDJnTnd3VmwraGRQY1d6YWFIeTgv?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC589091CB9EBC4D8CE2D83FAEB85A41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K22ahFrp1y9Q/jHQ6uy5sI7B53JKLNnMDOUXM9JpqFQwnv73VLFxCp6JTQfDLHQ39K1vXM0do3GJIBCeUcycl6+NYG5bc5VG4LkfPHY4kwMIZ6OF4emqvqnHmAwukUsLDZBJVj0IfFxMORTL8o2thwnWloffkrrcrXcP81owMngp1m8n4U/zoeWexEGLlWSsPyBVF8aiLKWKNAjaYwFRg4pX4R5ZyxOi3rNMvr/ujhNGRTnyC3h6R/MrWdNaapyGcmuSvXgIaJMn87H3OobGnCoVc4tMi+1gAr6IAABGWuX+Tyc7XwdBajG+4w/icdLp1+70m4iwpooFCdvzzpNLbeP+SG/9FxZxvDsbqlg9RTt83du3Z1xYP1tXu+FVcuKYObpia6a0wT8UZ2FpWjU0Vre++9B4NLLnv1x00H0VjKHGS61/OJYCY/S/SkqMke0g9W8l0gxfsRcB4MR3uP6kEV+V0dy/Ah4VSM6DnIsPP3+EPuobDQAIE2aAWRBLtbM1MzS1UEKNefGQWe6XkDeKULiHC8tXTyvzoK2GMHRB44J83hOh8A/maCYI+mbAtm6j55kpAlXD2uGLMUL3T8ZBzTlu33+V9oj2la1jjw0wUBNpOCz9JL6mMm6hxi4ul3An
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4850.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b117c58b-2255-4ccb-fe44-08dc113ca4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 17:58:54.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCMk9VqwWClJdkJtwkBDkneMI2A/Izxz24byJxF7r1gX/RMIJES26cJMZJE5hjq8T7fsyqvkBWc5LDAgmTQnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7008

T24gU3VuLCBKYW4gMDcsIDIwMjQgYXQgMDQ6Mjc6MDdQTSArMDkwMCwgS3J6eXN6dG9mIFdpbGN6
ecWEc2tpIHdyb3RlOg0KPiBIZWxsbywNCg0KSGVsbG8gS3J6eXN6dG9mLCBNYW5pdmFubmFuLA0K
DQo+IA0KPiA+IFRoaXMgc2VyaWVzIGlzIHRoZSBjb250aW51YXRpb24gb2YgcHJldmlvdXMgd29y
ayBieSBWaWR5YSBTYWdhciBbMV0gdG8gZml4IHRoZQ0KPiA+IGlzc3VlcyByZWxhdGVkIHRvIGFj
Y2Vzc2luZyBEQkkgcmVnaXN0ZXIgc3BhY2UgYmVmb3JlIGNvbXBsZXRpbmcgdGhlIGNvcmUNCj4g
PiBpbml0aWFsaXphdGlvbiBpbiBzb21lIEVQIHBsYXRmb3JtcyBsaWtlIFRlZ3JhMTk0LzIzNCBh
bmQgUWNvbSBTTTg0NTAuDQo+IA0KPiBBcHBsaWVkIHRvIGNvbnRyb2xsZXIvZHdjLWVwLCB0aGFu
ayB5b3UhDQo+IA0KPiBbMDEvMDJdIFBDSTogZGVzaWdud2FyZS1lcDogRml4IERCSSBhY2Nlc3Mg
YmVmb3JlIGNvcmUgaW5pdA0KPiAgICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcGNpL3Bj
aS9jL2QzZDEzYjAwYTJjZg0KPiBbMDIvMDJdIFBDSTogZGVzaWdud2FyZS1lcDogTW92ZSBwY2lf
ZXBjX2luaXRfbm90aWZ5KCkgaW5zaWRlIGR3X3BjaWVfZXBfaW5pdF9jb21wbGV0ZSgpDQo+ICAg
ICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wY2kvcGNpL2MvYTE3MWUxZDYwZGFkDQo+IA0K
PiAJS3J6eXN6dG9mDQoNCkNvbnNpZGVyaW5nIHRoYXQgd2Uga25vdyB0aGF0IHRoaXMgc2VyaWVz
IGludHJvZHVjZXMgbmV3IHByb2JsZW1zDQpmb3IgZHJpdmVycyB3aXRoIGEgLmNvcmVfaW5pdF9u
b3RpZmllciAoaS5lLiB0ZWdyYSBhbmQgcWNvbSksIHNlZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXBjaS9aV1ltWDhZJTJGN1E5V014RVNAeDEtY2FyYm9uLw0KDQpEbyB3ZSByZWFs
bHkgd2FudCB0byBhcHBseSB0aGlzIHNlcmllcyBhcyBpcz8NCg0KDQpSZWFkaW5nIHRoZSBwYXRj
aCwgaXQgYXBwZWFycyB0aGF0IChhdCBsZWFzdCBzb21lKSB0ZWdyYSBhbmQNCnFjb20gYm9hcmRz
IGN1cnJlbnRseSBjYXVzZXMgYSB3aG9sZSBzeXN0ZW0gaGFuZywgd2hpY2ggSUlVQywNCnJlbmRl
cnMgdGhvc2UgYm9hcmRzIHVudXNhYmxlLg0KDQpTbyBwZXJoYXBzIHRoZSBuZXcgaXNzdWVzIGlu
dHJvZHVjZWQgYnkgdGhpcyBzZXJpZXMgaXMgcHJlZmVyYWJsZQ0KdG8gYSB3aG9sZSBzeXN0ZW0g
aGFuZy4NCg0KQXMgc3VjaCwgSSBjYW4gdW5kZXJzdGFuZCB0aGUgdXJnZW5jeSB0byBtZXJnZSB0
aGlzIHNlcmllcy4NCkhvd2V2ZXIsIGF0IHRoZSB2ZXJ5IGxlYXN0LCBJIHRoaW5rIHRoYXQgaXQg
bWlnaHQgYmUgd29ydGggYW1lbmRpbmcNCnRoZSBjb21taXQgbWVzc2FnZSB0byBtZW50aW9uIHRo
YXQgdGhpcyB3aWxsIGN1cnJlbnRseSBub3QgZGVyZWdpc3Rlcg0KdGhlIGRtYSBkZXZpY2UgaW4g
YSBjbGVhbiB3YXksIGxlYWRpbmcgdG8gZS5nLiBzdXBlcmZsdW91cyBlbnRyaWVzIGluDQovc3lz
L2NsYXNzL2RtYS8gYW5kIGRlYnVnZnMgd2FybmluZ3MgYmVpbmcgcHJpbnRlZCB0byBkbWVzZy4N
Cg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=

