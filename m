Return-Path: <linux-pci+bounces-4483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28D870C0D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35321C208EF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220A10A2B;
	Mon,  4 Mar 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JGFtbeXq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GyTdzJcp"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC510A19;
	Mon,  4 Mar 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586277; cv=fail; b=Qt4o5ZmW4UFaZ1cqIfKjFWuivqiKDIYDnqukuFmLAhS1JJfM0jGGuwoGxxNGiLiznIwwVK0cpzDYA8VhL/DQZ4T5rHnrWvunmSfR7AUqUUgzq6+SJ4B+YiUTgTlWbsb9FAxcjCoVhb5LFFlG6bfj2+Q5PX31b9+u9O2mNCfSQuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586277; c=relaxed/simple;
	bh=ydMqWyA2Eoi6YVVxZ7RctrIQYu0VjMuAl0M+XVvvaww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POwMe57WxA5pjWV+/QjRtaRUY28K8aRGlxUaY+qWY6qft7Ku/11ZSUkwNBD8rI3fw7k7VpocMxuDydC6oY1ky1Z03+kl69TfTBbV513Tqxa/2N/mn3m5QjA3HmnmywPuiwjlfo9U3BSa/eXreevwVfhfmdbi5bq/DuxcgIQPjcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JGFtbeXq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GyTdzJcp; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709586275; x=1741122275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ydMqWyA2Eoi6YVVxZ7RctrIQYu0VjMuAl0M+XVvvaww=;
  b=JGFtbeXq9o8Quv/SkiICGEMlTWuEVnXrErA3mPWPcJ01EducYSCsLTUv
   Phv01Dotwzawz3WGNUbkK8jp72EKEtwRQ3eV+FX0WRSD6iWK/w+zaA55f
   9fWXSQV0JBMPL9/ZINl6MVtYhCEJKK4Uw10XlqdrwzyhWJ/F1ZRrFSL1d
   x/WiV84gqiRme/GjMPdV3z+MTYwgLZk0WYIefCiOs+/DpY82vi4E1ojl1
   6t0T7u93EURCHEUZTuhhbzHY+fFDfV8+dk+6nU2AIP3XgrkX6vGIYKRwF
   RgMyiF/ZGe7f8WFARVhDq8HSrzsLKSkZIil+d1iZHK6B4BvK14rtfTV4b
   g==;
X-CSE-ConnectionGUID: xfP7h+82StKo6Bb1xk5THA==
X-CSE-MsgGUID: Nw7wXD1/TQGtkdrGEyc8Ww==
X-IronPort-AV: E=Sophos;i="6.06,204,1705334400"; 
   d="scan'208";a="10780089"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 05:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/jkbPRd16ado1n1F8oAtRRTyPIGabVkNOs3RweNFejYTf3XQa3V5wm6XwE93ECN3d2AoWcxkWyIq3OzybIsZgJ17C9p/gtlNXgvpJenfTNk3i8JoU6+0R0BGfWYIGGC9MbEFU5f9GpeNKM+SfKFuPWURCFWM3GLxj+JAi9TrgEiYWIlJEUjDohnHrR88DC3koXlYq/RIKoI/Pp+MpMmX26Xmpwcq3BwiZPjsvSm2DBE3suz2iM3+9iU9UE/88YEUCxBujtgN9Wj6PsBJCvcf9LxDAgFjWoVY17wNQb04V/EQ970nRPcrgD7e0AMlWBORnMY2v4+dL9nn33Sz0Vyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioYDdcHR1pnwo2wGi42WtZtjBIMI+pu5Wf/P6/ezC48=;
 b=G7zak/Wj4hv9E+bADyYBtq+LP0pAwdjj9DhH7CbczXUvziaPYQElBJ3aUcX4iiKT3OCPue3B+FsNwI4fpSJRvs/LFDmsm09l2GTxx+J3wy4262J0xTmm7Z/gja1W57bpO8nMGUvZLQ4VF/mybTQP5i5mxThhLVT+NSJPFg5mUwiy1y4nttE4bI5BoMYekDnRp5slBAPdQX6ffUYCwp04bwpzU7xAfFwYdrCWZguwP0AqLmW8Jk3LMiWG5yY9LlGEMRUxQdzXV/SuqNeBbB0TWSGIki5Vx+tfDxhqqIENPjVzNpi2QN9vzHF0E3lysOJt/NtPKCv/dFR+H3GVr4i5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioYDdcHR1pnwo2wGi42WtZtjBIMI+pu5Wf/P6/ezC48=;
 b=GyTdzJcphBCkveEjYURbNMr5xEzO4bRBtxoXFBqhSi1CbPYtpJQKxB9GkMdAQBX8nRED/GuE5/dypzZwWa3sUG3Hi7jepQLSivLHmHbDBlatdbo+OvkcGHTEAaNvqXvZmzFNQ3SUzM0hjMl1POiOkdVXVL8gEw0xoBYOycrHR7c=
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16)
 by MN2PR04MB6398.namprd04.prod.outlook.com (2603:10b6:208:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 21:04:30 +0000
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144]) by SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 21:04:30 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.li@nxp.com>
CC: Manivannan Sadhasivam <mani@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jon Mason
	<jdmason@kudzu.us>, "open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE"
	<linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Topic: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Index:
 AQHaMja1NResTHTkFE6//FhBs62b57CwYdiAgABGuYCAAAUWgIB3lVEXgAAW+ICAABG0gIAAHwcA
Date: Mon, 4 Mar 2024 21:04:30 +0000
Message-ID: <ZeY3XqgUf84qAMCL@fedora>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon> <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon> <20240304084841.GJ2647@thinkpad>
 <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>
 <20240304181005.GF31079@thinkpad>
 <ZeYdV3xMWa0nbz3k@lizhi-Precision-Tower-5810>
In-Reply-To: <ZeYdV3xMWa0nbz3k@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8326:EE_|MN2PR04MB6398:EE_
x-ms-office365-filtering-correlation-id: dace8d74-d200-4e18-a79d-08dc3c8eaf7e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KGZPA5SWrP1gIa3hg+1DDaidXzqRq92DOnZL0UpHK7/BPtMqLLNVdNKuQa/rCXc+xV4qFllIapNLZB0FFSkSxKrs/Z8YyuR4LRECQHo9CHp+RuqpjMrcZJ4FajstDKl/Ae6A7v8SEre7ilSADIQuZ63tvAW0utNvdsU5kzzeLlmgXJSAyyi7KVuJOv1fVjsvHnkubIDfr7vT17S5MqycWjbeWZXnlMGqa3OC+iUCAbbBayCHEbRp+UxCyZqjq1ck9pwyye11G+JrJ4T3uJdd1xROYMq6gJGZruUAnfkl05Kl+o2mthr3BwKO+MsTRk1spgWYQcwfBolkoGiNVttNYSbUpPoRHv52UmKCfJaT+boVvRXr4YqWH77Tx7GF7LEONjAxekPApTzmtsKGpH1iqbeLOw9WH3yk4RDwcOApWSiHCmYADp3ZaNv8GQPsffuRwyWyeK1Ezd/nbcQnK0COYPqw2x5EK6uV2aouahgz53QpSmhCAwyNMcFGZJjtlo523TwFMXx5sIfh58No0bxK3gC5fNaqLiJbPrH7v1zhqD/vM8PJRnPU3/eQoMNNAFJK0ozVHqbd6qIEkgurGT937ELfyPW+rOAOnNVLTgg0FrNEmX4xEYPgu9Ib2VIPosE+J2pn/mCnEix7SzkPSCT/hpoTO7uRE6S+q5eKYmw3cQV0x0qHU72j+XAMEFJSv2KMAz4MvmbO08PVZm6KX3vJXRUqcABa15bMt8EnWdxXChg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8326.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Yw5HEYzSYzfI65s8oLWgMbc2ooNZwVaLiCwaPQ5/Uqv3H7HyTOn2gxPKcG?=
 =?iso-8859-2?Q?NkQP34xpRyFReXZwTrtCrCQDYLq67YxMJujldDjAsfBar8A4qhGLoIVFSD?=
 =?iso-8859-2?Q?zEHkeaH3Zy4rOwkwsqh7TiVt8I9aE0y3eFHq9gEC2vHuMwRGcCnfZjZpPd?=
 =?iso-8859-2?Q?pl55vU1eDi4vpJtvxnIZG0Eo5QvVWYYpX3bmyho7FhQ1PWM89VrKyPMfPQ?=
 =?iso-8859-2?Q?r9SsYOlDCUgxi9Zljlzx0Ppf/tcUJQGoAGOQA6nBB0+s6ZPaUkQlOgRkyX?=
 =?iso-8859-2?Q?XUh3SkRY+zSnIvG0vxaicT1m8EPg4Nz/5dC8oF29yfH5NausB6eQIPgrtO?=
 =?iso-8859-2?Q?a917ZNzR1N+3OmAHcRYoK3tp4RY9s8q8VesbnE+mFKiAA9hzVZvBW5+7RV?=
 =?iso-8859-2?Q?Wkuol+Z/nvffxVS2A0wQ6O1yG27bg76tIlHWHe5zET0MkYzqhx/OkCQwxR?=
 =?iso-8859-2?Q?oEdu4/HNajW3ikg9fatIY1nfDAzcDY7046nfm0fJKB9USiNW+avK5w53MF?=
 =?iso-8859-2?Q?pyyILr5yz4EjqYrWuosW3n0Q0f9VVkQvQwQff2JJmJEAQP6W/tOJOUelhc?=
 =?iso-8859-2?Q?MbyALXbC22m1WeRCqQ5Qz0Z5W5lDN6B2ef1U3gcPYrl89DpJttBshIWBqd?=
 =?iso-8859-2?Q?3RT+EYJbpMH7ABgoImbDXHEmHmuacRgpni4qGO8u0w/GNHWM2cEr8Sxv5h?=
 =?iso-8859-2?Q?OHN5icIv9szUxoagvKAZ5AEzo7YvJLRiJMJVVBqXZxmC8k7h4X54ZyJRiG?=
 =?iso-8859-2?Q?vrvYAX/HgXOI54uKmQii53UpJx+7OzZIkPPq1MRNLI/7FX1nWW9RoDC5mo?=
 =?iso-8859-2?Q?qlLQLtL7qyCdUu1FM51Js8h9/EBq5uhxqXqrTu9AkOJemJIfRxeFcKroyz?=
 =?iso-8859-2?Q?hjqekeVVcfMzlneUjsFVuwH4pQI1+X9eFF+jv3969LK850k+CZW7/7JFQJ?=
 =?iso-8859-2?Q?T8N3KjT/1tWhib4DfNep+VDrc18ooTt4iKlhmJhBkHQMp3RT/rYbcp8IVz?=
 =?iso-8859-2?Q?p2ODgekq72YvUH5ZxFdv4sWNJUlI6dqMetQH6VxNm/KSiz2PtfsVBCqjVB?=
 =?iso-8859-2?Q?85bc/myQh7AjSBw4589rTkCXgoXynbWt53AP9cfYLANVI5JWIU7aroXwB6?=
 =?iso-8859-2?Q?VLSycFWm6Tr6mul5CIf4VNvRIs7S/B3iLUR5PQBUKu+SwX+PT9ArVL25Uh?=
 =?iso-8859-2?Q?tMWY//BG460PbpFtA5f+842oZInFml+xYwLahGCL5bGKc+Cv03Mjnh/s96?=
 =?iso-8859-2?Q?9VozTTuveE0I32N7G+7EgHTfy6Opw4FHBOuIGRsdgIUW8uLQv8jz3J6yVA?=
 =?iso-8859-2?Q?GE356lFG+iaP1bKWg9VY2X13YDj2/s+nSnSO9t6+we8vAhGygztKO3PcYd?=
 =?iso-8859-2?Q?khEZjc3qEbcj+Rd1QDK0PNDCFuxBaddcFgRNGM9YD/+rmeGtmF+89CImAU?=
 =?iso-8859-2?Q?YMJ74FS18joKFZK4VBExzfbMbakcI/kvdQdNBYbS3MCKWA3W+BC875h0Pm?=
 =?iso-8859-2?Q?xodapHlU7aJnA8BO3HkVW+XOpxQnMVpcLWBk/wiCV/H9cvYQAOTs9Y6sBM?=
 =?iso-8859-2?Q?MEK0+qTcJK51HCXMt4jzLeS3SvNH7+SQmYY1puF8aAYDSRSBZrp9PF5Nvc?=
 =?iso-8859-2?Q?9FTRg9dgLymgO45k29wvkuJJVtQlzar02tsHf90GpJrKLVSnXfKficXw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <5124D72B5B2CEE4F86F1CF50DAD77673@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dDike5KwL2GHiI//p4xjJKL0SuqAyI+0roW8LS9TwWAd4Mcf4eKdO7S66J+PopYB0iWh42o2yyBSQbLkr0OpKwVUBx60v4aHW8UWb1lvXkTpAeazp8q45j+hR12pMDn1xq+U3WzUGrSkZcoX3m8SUmOutoyt4oFSEWMXnwh22vMjC71kWUom50oshfH6W2YRipI2hvFFan5ZQNPmIcMJBfHhWXkCikFXgzxH39YXH34wu4hGBUDwd19sT8DXCAoUOb69bKcc2FqhNjCVeHrPfJWYPink8H3jupmXBGHmthBKt5hSPus/VU5FQ4UhRFODJGTS4oK1DbA2P6AWOSAxuLak+WHjENB9Ty4esobdfei64m9Z+mcy5+cCv+C5I0oax/CPIjpC8HmDhLXStzUhc85JVXSOra71v+1o/x8473RMg+yxKP4tTxhHJNGSpZjPjpm0xHIqUHNEK7iEUjCbH9r4dnUVwZ+xdiXShgVouNWTSlh2pvtkWnsXSx61KhJDwkfjUh/sGw2gK4muSJBZ8iZvPLpNFYXIL5rvrOcmvSOzF2F9qaDGYsUVixoi7JkAkjAh6DRE5rEIi8/fCN26S9I3j0UCiqEDqYtV35DKTJurjgIzhBPnDKCUgmthIvmU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8326.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dace8d74-d200-4e18-a79d-08dc3c8eaf7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 21:04:30.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GPPovrwFJHQRY7JAvfSsVTrEAhyfpWlGls+HMUd3zyZ6fdUX4xh5oUoi0hN4DgQb6mR4Ei5N3217AX13nmNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6398

On Mon, Mar 04, 2024 at 02:13:27PM -0500, Frank Li wrote:
> >=20
> > Niklas's initial suggestion of keeping u8 for the array and 0 as the un=
allocated
> > placeholder sounds good to me. Please use that instead.
> >=20
>=20
> It is impossible to keep u8, because 255 + 1 will 0 for u8. Previously
> Niklas's initial suggestion have not consider this condition. If u8 have =
to
> change to u16 or s16 anyways, I prefer use -1 as free.

Well, to be fair, my suggestion was:
"If we continue to use a u8, and offset the saved value by one,
we will at least be able to support 255-1 =3D=3D 254 iATUs."

But we have this define:
drivers/pci/controller/dwc/pcie-designware.h:#define MAX_IATU_IN 256
(Even if it isn't used anywhere.)

But as ridiculous as it may seem to support that many inbound ranges,
that is the max number of windows supported by the hardware, so why
not just let the driver support the max supported by the hardware?


We are talking about:
struct dw_pcie_ep {
	...
        u8                      bar_to_atu[PCI_STD_NUM_BARS];
	...
}

where PCI_STD_NUM_BARS =3D=3D 6.

And where struct dw_pcie_ep is kzalloced for what I assume is all drivers.

So I'm actually for your idea of changing it to u16, or even unsigned int.

If the code is simplified if we use a u16 or unsigned int (because we don't
need any weird if (val < MAX_IATU_IN - 1) check), then I'm all for it.


What I personally don't like with your patch in $subject,
was that you changed both dw_pcie_ep_clear_bar() to set the "clear value"
to -1, but you also need a
memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu)); in dw_pcie_ep_init().


I much prefer to have 0 as the default/unused value, because it will
automatically get set when you do kzalloc().
Seeing a memset -1 just looks a bit hackish to be, but I realize that
it is personal preference.


If it is super important to save 8 bytes from the heap, then I would
even prefer changing the MAX_IATU_IN 256 to something smaller, like
127 or whatever, just as long as we don't need that extra memset -1 :)


Kind regards,
Niklas

