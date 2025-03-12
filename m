Return-Path: <linux-pci+bounces-23494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C6A5DECC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000C117A5EF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5617B24DFEF;
	Wed, 12 Mar 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/UeCwYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE652033A;
	Wed, 12 Mar 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789354; cv=fail; b=GCo/71MEP0c/1tubd7inFaBmDHftVfIYNxDOrL49S12lp4eR6qgvc1Q6ugf9cZZZ41QuZ17sJd3/0lWDvSH7E2ielXokUIRi8d4xio2uN527m1F8rxH1p+MDT3qAXk/z68EPtqbph+Oc3YjV3bl1t1IXRpvXiOzt58eOivZCVrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789354; c=relaxed/simple;
	bh=mNqElx9w16T11TDn11QVWhIFHT6sdwEy1Vu3yI5sh9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1w9yF7U6wgl2299RTmbd7SI2Q1os7NS0HvlXvyL7CsI9TXizj8A1taw84csxKmOm0rMJX8MoVf+7Me8Ppj9qdCy4EMpsutBoWzhhxUj7sKMgGVaSSDbgVxSf8G0PX5FdnBARI5U2VoZBpUINEuiChcU38A1nWDhxS9PJtwwIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/UeCwYJ; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/7nDfSgLw8cktLXu6kcwlgjnazKyFLG90ra0/4QyUfgb6WUWJs4w/pcKaum03Bp0+cQer1IExxifixdC/mQ7zDVUwmsiPjwqsGD85Imji1kY/suXfTMybnOwNe3vzM1MZaaWIcnZfNshk7J1XhU3rkNdlLhfBUdYnZO0JrwlTjHvkorCXrOg4LfzvKx8XDnFVsJBJ7hye1M9nB3I4uzkXl0VtQKfaNOmWzmRkH4FzFoLFWebJF/zTiYOXwfW96jrrZUkoDx0i0IYAoDdajzHYPWh64Ce02v1/jRaArklZSwFjdql7hHjQovw1VV+HruB0JbdqV5b+QYw4e25xheAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxHlN1XJI8959Xp6ydD23m4aeZuA2PlTvU+0reCVpeI=;
 b=ZNcF5Oyldegf3/o7ta6MAbqf3/uJSDIzguRkoOKL/SFo4MRtwVaP5h5dRKbtqG9KJoDMw0LjIMfmRxpADi4ibj0whWqBRwJcWfYvsCK2V4viZF2/1Ka7dF78Ane1BUVmzB64ubmwF2TSApuUSPj42vXyft+Hh9JyM2UF0mpY/D7nnhKLNO/ywh8L8rohOm8SrS5S72V6ltnz27KsiQ86kY+T+1PonoCtdW3h6LabOIPoBXltMZPDDjzKWgYpKq0xwbjqCaxspMgf2A1qpPwpawM3t/KC97OjQUaBAF8hMSez7ouUuuoer4xCXWeJDbeiTN1QNU+UcM2z8qYAxlVBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxHlN1XJI8959Xp6ydD23m4aeZuA2PlTvU+0reCVpeI=;
 b=j/UeCwYJaV0Uyv7UHs/U+oYIPGQFMbIsxOvNxH/hknHAcaZXfWdFufOGkFWe7+ZycTgtXVP97wN8/iK8XMema0eJ7TIRq3/r8tKAQN8+9px415Sge7xMYWOGzpfR2UBIkeUDuuOGfwDwKc7wM291gqIb6jM1VvH4xaa/jcRVBYtRRcC98KfsOEYMTVBNp5iXsOiEYikex/VNYh/9OAMaNLZdiRs5I0GgtvjHNrfmSeH3D1BqrSFbHRRXJ6vCScGCuUUIIxRdWn9n/Vw16eGpoHd6goQeogNmruIaTDZznNJKoUK6cvVBcWUQomlN0ax20A6Rhi+19R6sWbtC4Z8JJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:22:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:22:28 +0000
Date: Wed, 12 Mar 2025 10:22:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <Z9GYm/jp9VIhCEeY@lizhi-Precision-Tower-5810>
References: <AS8PR04MB8676E66BD40C37B2A7E390178CD12@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20250311155452.GA629749@bhelgaas>
 <DU2PR04MB8677AC699DF11D847AB768708CD02@DU2PR04MB8677.eurprd04.prod.outlook.com>
 <fcb5f09f8e4311c7a6ef60aaf3cb4e3f05a8f05e.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb5f09f8e4311c7a6ef60aaf3cb4e3f05a8f05e.camel@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 95519e5e-6c81-4f1b-c994-08dd617151bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjhqeWhoamg4VDFwa2xpYlU2VnluVFdkM1FTa3FodHpDRjA5eDdzWnYzL0pV?=
 =?utf-8?B?a0JPMHkzQ0EyL2poRDNNWXZ3dmVtVEVZRk9uZUVBTTVJQjVTTXpOcGZHRUxp?=
 =?utf-8?B?MU1sU05QOG5rVXdjOS9ZV0FnMmJQK2NYc3k3aEdIbHBjTDVjRVhzMGg2TlpU?=
 =?utf-8?B?WUdiQ09reFJQYUpHeDVqWU55M3NRVndmUWhxdjBYRENDUi9URjBUZm9zT25z?=
 =?utf-8?B?NjdxeHAvZCtwekg5VzA3UnlVc0FwNGg3WFpQS0VYMTFHWGVydnNLSUMyeFJ2?=
 =?utf-8?B?TGwwQmV2Y3VESkcydmVBSHlFemV3QWw1dEN2RkNHVUhHeXhvYVFYMjVwTnRV?=
 =?utf-8?B?Zm1qQmxHSU0rdXpTY0g1OHBxTzl4bnk4ZkRicy91bUhiMWU3Vm1UVVNYVGJq?=
 =?utf-8?B?KzFDRmg1R0xoZEFmaXhkYXByRVVCSWlSdG1qTW1iNjQvL2JXN2tGUHhzMWVD?=
 =?utf-8?B?Sk1jQ1J6NkMxU2dtc080VVJSTngyZU16SmRaVzV0SnFMQUNQMUdmWncxYm5v?=
 =?utf-8?B?SnRlV2dCWFJkbVJ4NzlYMzlEZGVPQnVCN3RtaUQxMldLQkZBbk02V0lpNjhN?=
 =?utf-8?B?c1ROUWpHMk94R0Vkamg5TGtJZ25wWlVEaWdTd0Z5cUNMQXJDNjZuOWtzWDRZ?=
 =?utf-8?B?MXdPWS9wMU1pOHJnSlNsWnBiQTU0NEFDamh5eHZ2TkJjanAvNHA5Sm5SeHQx?=
 =?utf-8?B?d2hROGFicXg5ZmZCVnFQM043WEJKUVpMMnN2THlLSXVDVy9NR000MDFWRXdu?=
 =?utf-8?B?Tk0rQUxwa25HeWNJY2NQbzI2OU5wK3FkT0Ztb2xOelFmamdCaDY0REw5WUtS?=
 =?utf-8?B?UDBoQ1AxN3FtbWhkYVhhSVZmT2dpNWtmZ1pXS2htd3ptancyZGp2eWlwZU9X?=
 =?utf-8?B?eUY5YUt6MGcramtuNmk1Nm1jRnUvckRvRDZOZ2xOTHBIME1lVlk2N0g5WFZ0?=
 =?utf-8?B?OEt5NDBiRVBSc0FuZXpHN2VJbEpsNDVkLy9UanRNTDd0TDgybndjVE90cFJV?=
 =?utf-8?B?cHRDY1gwNnhSRjJrL203eDNhZEpTWDdiME12OVg4dFZpZ2VJWHErSURJclpP?=
 =?utf-8?B?K3NKckMzZmZiRXorT1E2R1AraTlJbGNPTFB2Q1kyYUtoVUJFb2VSd0RzbS8r?=
 =?utf-8?B?MmZ3bUpUNEQ2YUZIT1FINUN4WUJKZTFjbDdscDFscjhlUE56SVdablFyMzVj?=
 =?utf-8?B?cy83VFA2NVlMbmo2MkxDZUNBMy9RNWY5UVhzVDNPMnlOWHVSaUVjZ21xVm1u?=
 =?utf-8?B?aTQyZzJRNTZwUElTY3RSN09hTGxVMVpRUkVFVjV5RWhBQkVpSnAzZlo2T1Uv?=
 =?utf-8?B?NHQ5dXlyc0x1aTFBL01NR3N1WVJNN1YrU1dGd0J0YVJwbHc5dTJ2eC8yaDN5?=
 =?utf-8?B?WU5GcGsvSno1dGw5Y0gvNEYxVEVDY2duQ2szbXM2MDhGdmxOY1ZDbnk0VlZa?=
 =?utf-8?B?YUx0MFpjdkgzZ05nNU9HUWgrL2Jqc2xVaWFBMnRIdEc1QkN1bVpGYnNSZ1p0?=
 =?utf-8?B?VUlzMTd5TmNpdnBoZjZPU2Y5ZDA0RFZkZFA4eWdRTU5US3hYWjNxN1FLK1BX?=
 =?utf-8?B?dllvQTcyMFFQVGRmbSsrd0IxNnd5aWdVVDJ3SzRUYzI3RDlDUEs1ajM3VTF4?=
 =?utf-8?B?SGRyZThGaGpSZkRJUzBtOVF6YThIaXJ2Q29lMTM2RDVETHppMVBFQ1lGTWox?=
 =?utf-8?B?cXdCOU95VGN6bTN2TFEwWjBSOFQ5WTZ0UXMzcWZONXFUcnRPSTFGUUprVWFC?=
 =?utf-8?B?RzRqLzM2UmtDV3ZhM1I4YWtSYmZlelRSRWZ3L1J2cnJLNWtQMHdPc1hRSEdn?=
 =?utf-8?B?M2MyR0IyWG5xRGtIU1YrTTRsbnR2cm10NnhraEM2a3BqMUplcTBHdWUzTDFY?=
 =?utf-8?B?WExyNitHN1VrQ0hxeHBMeDhISTR4QjlXeTg3OFBOUjBwYmd6eFVic2dPNnl2?=
 =?utf-8?Q?9mQ2gl8hWa9oI4nBwQWcKKpT2ItNRDB2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUg1YW5MaU1PS3ZHMVZyUnJIRnZUU3Z5ZE8vREdaZzVuWXVmN0JKRmNPME1m?=
 =?utf-8?B?cTVFbUlnV2VjRTZuRGZmTDdieHZJOVNPUUNqbXZsZHNrazZlRnp5L0laWk5E?=
 =?utf-8?B?Y3VWdlc1RHVtSUtoR240cHBTMzljZVFjMjNGcUZBcjhxdmRSY2lIWVBKMzhi?=
 =?utf-8?B?bmNldGdYS1lFZitKcG1IVTFtdTMyT0s3aHNRaXRjTzVzYk91YnFpeDA0UTQz?=
 =?utf-8?B?c3pMZGg1SlBxMVp1L1lGUlR1WXovTE83K3ovVjNzVDlnWGFCTVFCUVpNMzlS?=
 =?utf-8?B?NjRUUllyM3FPR21Ea3FyWmlWUUkxR3M2KzYwYlJaS3R4TVNRaEZidVNaSEJv?=
 =?utf-8?B?SW03WXZ6WEwvS3Z5SlNFUmZsSzBRTnR3VU05SmNnTWdtL0lJZFdpT1RKcmpP?=
 =?utf-8?B?RnNuWmZoeEhlVUxLWnAvZHJBc0tGa280NC92K1ZxQnVqSm81YVhLU1NyQ0JT?=
 =?utf-8?B?ci9KbEdiWU1EY3V3ajBvVXpITEJ3cGx1YWZxelBrVTJEeHA3eFBtdk1mNFpL?=
 =?utf-8?B?M0VPQmYyU1JHWjRoaGg5MWRRdnc4WEpza0JTSHQ1YndocElJQVNIa2tSdGJN?=
 =?utf-8?B?c2tKZkdZWXZKeDFQZDVrS28yM0Rjb05XVGxRRHF0T2h0b09PRlN6ZnRYOHpo?=
 =?utf-8?B?WDdLZUx4alRPMHk2YUFKb25seGRDbkVIUTFiaTlLbE1RV3FhTWxuc0xuVGYz?=
 =?utf-8?B?V0xBSTR5dXM5TjRPb0hseUFPMWI3dUdia2c0bGJHRWs0YitPNEh3Nm1ZWEF3?=
 =?utf-8?B?a0lQMzZVYjlXTEh1Zm5RcXdWR21RaE93c0F5L3hmZ1VRK1E1eElwSkxES0g2?=
 =?utf-8?B?VzFRdHE0ZGc1Z3VEQU9mR3dwUHdZcTNhcUZhWUFuanZUNk9lK2RkSnJzWHlZ?=
 =?utf-8?B?NlRLa295bUg3STFwckpzNzc1czBZVG53cTBCVU1IZDE2dlNjenJHbS9HTkFo?=
 =?utf-8?B?ejByR2pNQUhUWEVaeGIvdzRYaVd1aVgvZWFSNXg0SVM5ZDhzNzZSKzRqazdU?=
 =?utf-8?B?dGlUVEN4VHpsME1kVTJ4SmVQODYvSjJvZGMvRnJ4QUZ1T1Y4QXR5U3Y2MTlt?=
 =?utf-8?B?Q3p1MFV2ck44YVRGYmI5cEd3SVNsYWtQN1pjQzhYOEp4QlpRMEZGV0JJYmpt?=
 =?utf-8?B?OU92d0ROTG5jVXdTVEdYZ3hmUW55V2tjY0dvaXhiVXZKR0RTZ2VTVnNqWWdp?=
 =?utf-8?B?cmtPWTJlV2VNbkFvNXV1TGMzS2p2RWtncDQ4T2paZ0VtT3JoaWdEdS93dXFa?=
 =?utf-8?B?WVRzTlVWL0xiSXdXS2tVNXlzMEd3RG9ta254VDdpUmsxY2NDZGJUZS9XYjZm?=
 =?utf-8?B?eUVBM1Rzc2cwNW0va3VLbTl0dlM2Ky9ZeDFSYzhSdDlOWnFjL2FwTzdINHJs?=
 =?utf-8?B?cUVJL0dRS25GWjZWNmNnQlIyVG9YeVVleGdmK2tCL3pTWEdJZHZlU1hNZVFG?=
 =?utf-8?B?NVhiWWJNRDhTdUR4dWllN3JaN2ZMMTBzaHVpem53ZnpRc0xxNHBaZTFZS3lh?=
 =?utf-8?B?NmVFVjNmM1kvd1p0dGNjL0ZjUDBpaDJkYlFkQW9zMjFKQWVKOWx0aVMydVlR?=
 =?utf-8?B?ZlVoTks3cmJqZlBnbDdHTHZ6Tmw4MHhlY01Qb1M1eHBRSE1KWVRVT0Q1ODM0?=
 =?utf-8?B?SUFDSGFRK1ViWjV3Sms3V2RDbDFoTTEwVHJQMVFwSDdsaTJNaElPdktqTFRZ?=
 =?utf-8?B?cnRTdjh3SkprZTMwZEU3dHcwdWxaeVAvSklZZm03c0VDK01xaEZHNFNGL2RX?=
 =?utf-8?B?a2dxdi9NZU03SnBiN1ZWY1dWODVnR0ZlQnFCcCt4RWIxL0JlYnMvVTl6VlBY?=
 =?utf-8?B?Nk0xRUtYWVdYODFaNmhsSEM2Rkl0MkwwbTZaN0FTWGJNSzhjamlobWxFdFB0?=
 =?utf-8?B?MVF1ZkpiaG9sZGk5aGtxazVxY2owYkFMQlF4STZxOGhldjBKUGdCdStKUW9N?=
 =?utf-8?B?ZlozZXJxYzBjY1VadlJZNk85MW5vN2xjQjhFTmFmTmZrc1VBTFdVdHdRMS83?=
 =?utf-8?B?UmZWREg3ZEtQTy8wUnlWbkFBcE9xZEZsNk9UNDIrK0lqWVgyNnV5WW1vSVR3?=
 =?utf-8?B?diswZ1lTb2htSG44clZpbHl2S3JuY1dHaGxLTUpPa2hsbUpSaE1halN1UXY3?=
 =?utf-8?Q?rLNc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95519e5e-6c81-4f1b-c994-08dd617151bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:22:28.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeIBt6XM8EHk07tC3FauDOhspmot2k+/zremT7uJDNtvkoJDGQNk7ANJgVHguIfyymh6V/1pG0k60q650b4Ylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 2025年3月11日 23:55
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com;
> > > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.de;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > hardcodes
> > >
> > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: 2025年3月10日 23:11
> > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > kw@linux.com; manivannan.sadhasivam@linaro.org;
> > > bhelgaas@google.com;
> > > > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > > imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > hardcodes
> > > > >
> > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > Use the domain number replace the hardcodes to uniquely identify
> > > > > > different controller on i.MX8MQ platforms. No function changes.
> > > > > >
> > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > @@ -41,7 +41,6 @@
> > > > > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > 8)
> > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > >
> > > > > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > platform_device
> > > > > *pdev)
> > > > > >  	struct dw_pcie *pci;
> > > > > >  	struct imx_pcie *imx_pcie;
> > > > > >  	struct device_node *np;
> > > > > > -	struct resource *dbi_base;
> > > > > >  	struct device_node *node = dev->of_node;
> > > > > >  	int i, ret, req_cnt;
> > > > > >  	u16 val;
> > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > platform_device *pdev)
> > > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > > >  	}
> > > > > >
> > > > > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev,
> > > 0,
> > > > > &dbi_base);
> > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > -		return PTR_ERR(pci->dbi_base);
> > > > >
> > > > > This makes me wonder.
> > > > >
> > > > > IIUC this means that previously we set controller_id to 1 if the
> > > > > first item in devicetree "reg" was 0x33c00000, and now we will set
> > > > > controller_id to 1 if the devicetree "linux,pci-domain" property is 1.
> > > > > This is good, but I think this new dependency on the correct
> > > > > "linux,pci-domain" in devicetree should be mentioned in the commit log.
> > > > >
> > > > > My bigger worry is that we no longer set pci->dbi_base at all.  I
> > > > > see that the only use of pci->dbi_base in pci-imx6.c was to
> > > > > determine the controller_id, but this is a DWC-based driver, and the
> > > > > DWC core certainly uses
> > > > > pci->dbi_base.  Are we sure that none of those DWC core paths are
> > > > > important to pci-imx6.c?
> > > > Hi Bjorn:
> > > > Thanks for your concerns.
> > > > Don't worry about the assignment of pci->dbi_base.
> > > > If pci-imx6.c driver doesn't set it. DWC core driver would set it when
> > > >  dw_pcie_get_resources() is invoked.
> > >
> > > Great, thanks!  Maybe we can amend the commit log to mention that and
> > > the new "linux,pci-domain" dependency.
> > How about the following updates of the commit log?
> >
> > Use the domain number replace the hardcodes to uniquely identify
> > different controller on i.MX8MQ platforms. No function changes.
> > Please make sure the " linux,pci-domain" is set for i.MX8MQ correctly, since
> >  the controller id is relied on it totally.
> >
> This breaks running a new kernel on an old DT without the
> linux,pci-domain property, which I'm absolutely no fan of. We tried
> really hard to keep this way around working in the i.MX world.

8MQ already add linux,pci-domain since Jan, 2021

commit c0b70f05c87f3b09b391027c6f056d0facf331ef
Author: Peng Fan <peng.fan@nxp.com>
Date:   Fri Jan 15 11:26:57 2021 +0800

Only missed is pcie-ep side, which have not been used at all boards dts
file in upstream.

Frank

>
> I'm fine with using the property if present and even mandating it for
> new platforms, but getting rid of the existing code for the i.MX8MQ
> platform is only a marginal cleanup of the driver code with the obvious
> downside of the above breakage.



>
> Regards,
> Lucas

