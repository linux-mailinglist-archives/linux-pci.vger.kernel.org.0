Return-Path: <linux-pci+bounces-29564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A734AD7817
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D0818818EC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BF298CA6;
	Thu, 12 Jun 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CE4TMKc3"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A519B3CB;
	Thu, 12 Jun 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745158; cv=fail; b=jbhP1pyJ2UOvbT5AYeQA5tXzze0uvAOP7t65xd/+sCK95PlSrZs9KKaCzcUhkE3HEpP2HGjkaDPppbgbxdAmO7u/Unukzw2T5qZtyLe2E6zVygmJkcQeBNmH6XJed4ni8aNnCAXnH9dX5nFZ8YyztvDEuUIjWleTRlFv8gl8oWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745158; c=relaxed/simple;
	bh=nYBDSOmVGDbFHwy8zn0YO3gLsMyuBn5/uu3dw6sQFvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKX0yOoK4KVjWVMv6275N2l1i52J7uZ850xfCHoqv1AL07sxguu67BTOkgIVba9ar22U6fLvCFWQ2wqGiI68iHC9SE1CPvA8AY8POlbJLXfcbpZ1oAFR4AXd2KVDp9kqk2o/fgTnWHS802On/+8lPGK09S8ZnVKslm3tYsiVBmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CE4TMKc3; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4wg25YetUxl5naWGoVhzfR+gBK6rK/0Uiztx9nzaScRGuC3hXSLexcE81cHdAA4wxE8gO3RMrX6j40RqGfKsDlm7lENSGCiLnjcdT9lOfzHhWQAFXS+wGTYnW/aDJegf11NPNhlMkZk+UcS3woxQQzO+4ghUF7rwBuvwdrGUSmwLH1a4NBYLZlRPKbbBJzPiNchRwtENYVZ3HvOSS/QKO2Zm5tAg9t8cHGte9rwvwuO96eSsJO7UZpekhVbQFpN/Q8eZwHYLv1+rOS6bsqCk2/gCaShrXsFOmLNpvKjJYRQ+sDa22PkIE1SEYiNr/IVA8M8K76u77KRmn/afWbjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCjB6KYCVM9RE8jKoOVz3rXS+N2jDrZCs8QM+98aGzM=;
 b=cTlJCZFVfWlIV9Uyh5bF5RUJ1G2/6yGohirtpjZk9pEtcGM+UzgA86JFugDJcUoVILPoOvzTrdl+G9qos5Ms0j8qOcfjYugvXRtNYAvGIPq7AosCaMrVxFNJNivRvH7qjXrdTahtMaU6QQEebbQd0yWmu4a7zS3bh5IQ4CuVmmGl0hZbJr0+GxkS/lmfXmvRra8b8R7VaRYIZksnub4RcS990UJ4Yy2xNGwLP2Kd64cRqtHecCNuPFZD6Gp9mmo55ndp3Z8pgN3+iLbJpt0bqmvJ7VSda7pzGCapKoidxHncbFlemgxGDQQdUIlYuRacn26v1QDRcEvj2XmAzps6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCjB6KYCVM9RE8jKoOVz3rXS+N2jDrZCs8QM+98aGzM=;
 b=CE4TMKc3SZxoakUcXr12OSElzL2SWB/bFUiWbYyqQ2AbQgnWp2dsvXGW5uhgtShSt1tUIF2WR6fNPAQ53/E/xlMNlbVoniQqaTzUlNbA8mh7rqwOnm54IAz7Q6Kf6beheGWwBwmF/KvxdfosRIUBMe0boMiuoqtpxQHGjEWaw/dljSC2JW/J6WIFGaIE3VZ+Yn8KN8qKgQiuPHC5rz5Fy6adGOl0380cvXAkr+HHIKjKIzkjQCQlE57U7Zxw0hJa5V3oIG8MHGqp51McpqhSKT0zthPfVK3ID5mD96FuHCjEdFbYylLjjbOZ0VCVj8kNiFLiae4rDG7YJvh9mrvE9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 16:19:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:19:13 +0000
Date: Thu, 12 Jun 2025 12:19:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 10/11] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <aEr9+NQA6o0ypSuy@lizhi-Precision-Tower-5810>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
 <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
 <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
 <aEr3nGCqRuyIwA37@lizhi-Precision-Tower-5810>
 <az74rxjpfahjwmz7fg5agn47org7arpblariuauujhovkaieha@d6r2yp23vqan>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <az74rxjpfahjwmz7fg5agn47org7arpblariuauujhovkaieha@d6r2yp23vqan>
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e484c65-e384-49ad-aab8-08dda9ccdeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1dSZ3BDc1RhYU5BQlRLVVhTQU9GSTVUK3VxMmU1blBhUTA1QlNtVDZFNXJT?=
 =?utf-8?B?V2pTa0pOZ0JYR3lMVHc3T0toWDgrVmVmNDNaUHlBZEh4UWpoZ2dnQTNsbENr?=
 =?utf-8?B?TE1tTUJjQUNBbm81dWtHUTNvcktYb0RWRnhOUDdqNXhNOGJTQVNvb0wzU0o0?=
 =?utf-8?B?R0dpZmNuV3E1MlRacnMvcy8xS0NzNXhTOUc3aENGYWY5aGh0dDg3K2U1c01s?=
 =?utf-8?B?ZlQ1M3JlR2YvYjE4YTJKUEVsMC94Wm5ZT2R1M3U3bTdhOCtRVHFucXVrT2NN?=
 =?utf-8?B?M0JpVlEvelZNVENMKzBZQVdSZ1lxckJFR1daU0IyY1pqRmJ5eFMyWUJBRFc1?=
 =?utf-8?B?aGlHYTBCNGprdmZhOHhtVFhXNThTb3ZHeVRFWlQwYm1FdVVCZE5IcUVuQlhj?=
 =?utf-8?B?V3lKdlFITkpzUUI3NW9JRjYxT01aWG90eXZyZVJ3TkRvUFhkRDF6MkMvRHV1?=
 =?utf-8?B?eDVaVEpFN0RaazhkYTdwai9hZ0FoR2ZSWnFNcWFkQVNzSXFUTlIrbkZWQ0ky?=
 =?utf-8?B?dDVxREVwUFhaWlBtRWxRb2lMNXF1S2JBMEFZOGJVdVVIbitPcExUekRYeFNR?=
 =?utf-8?B?WkN1bjY1SXlKMHBTL2VpYTJ2blB1enhjS0JscTRXVUU1V3RBU2V1eWk5NHFE?=
 =?utf-8?B?M2JZSEpOL3owbTE0V3BrYnZzNE5GYlJtZWMzNlN2UUV3QVhjUUs0cC9SdUxC?=
 =?utf-8?B?VVRVVUMySzBQSnNDRTJhOFp6dklwcnA3OXJIaDZXNGQ4eW04WmlDZlBLQkhQ?=
 =?utf-8?B?UnRrRWJuWlJaKzFlNmdSd3Fvb3dsNTc2c1ZKU2I2bWJRRjgwNzVxZ1l2cGdN?=
 =?utf-8?B?MWN4dTFNYkJDUVpMaXIwMXdOSzRJbm11cHExZmt6SmVKN3RpZThQUERjV1FF?=
 =?utf-8?B?VXZwMkh2TWc0Sm5wVEVTSE9FYTI0dVg5dG91bnVITzM5dzlGUGZ4ZFJ3bFEr?=
 =?utf-8?B?RUtrWHhEajd0dUY4SjdHemwySWQzWVpsTkNidU5PSjhzd3pJTXpieFBKUkhm?=
 =?utf-8?B?Yk96TGdpN1J5V0NnWnF5RStua2RyZ1EycndCbC95ejdvNjF0SzdMck5Kek5U?=
 =?utf-8?B?TlJBcGhEZTgxYmQ2U0VVMGs2L0l2WG80QWhSbHE3VmViWXdaRUJrbXhKdGdL?=
 =?utf-8?B?djdIM2xPZmRoSG9TZjBxSVFoSDgyMk43YWRNdnoxM1NUWUJWbnFsbzBmdzVZ?=
 =?utf-8?B?OGNjTlRkdGF0WHgwOVlxbHIvK2pONUJPd0hCTGwvaTY0VEtWVExTcWRKd1Ay?=
 =?utf-8?B?RTYvZ1gxRGtEdE90b3N1NTBvZy9LQzlndU5TMG9tMjRhTTJRVXMreWZUK1lI?=
 =?utf-8?B?K09OMTlVenYrL0hRTEl4ek9sZ21YaDVjeGJORzFKNW1sNFNrKzRLU3ZBWmVH?=
 =?utf-8?B?NjdvMnN0bXdpY0plUmJBNE8xZ0hpWjE5cXFBcVFWVlVCU01uZC9BSVNzcDlN?=
 =?utf-8?B?QUNrZlFReURLQWZ1K2FqdC9SeEZCTGZBb0hldWpBamEzcHBSUU4vSUFrS0V1?=
 =?utf-8?B?elFTYXAzeFRVYWpkMyt2eVNsYVc0bkdvNFNJWThNYUM5OUsrQ01hWDdCRGdh?=
 =?utf-8?B?OURMZjZTSktJVUlPcEhFcTM3YTh3VnZObzd0LzI1U1RqbG9KQ0NMS2twN3h1?=
 =?utf-8?B?VTZzK04zZG93M1JLRzcvV1BtUWYrekFaZFFObzhNak94aGxldzhHR2IxbjIw?=
 =?utf-8?B?V3JPZEc3dzlCRWYwcGNiQVRFQTRmR0R4OVFNZEp1SU9VRWRFZGJqMDNzZFJr?=
 =?utf-8?B?c2wwak8xaFpzamthYjVEdGhmWFJkcm1nTXJ2YXdkRmpJS3ptckdlOWU5VW5s?=
 =?utf-8?B?Z003WkZQS0lKMDFkUVFpQ0pwNTdRYWQvbCtpTmdVeDlsWVUvTjJDSEtnd0Jk?=
 =?utf-8?B?ZHBsN3M3eXA5bUMyNFJvSHhPNEkxaVFmMEIwMGE3eVJhUVdiQ2pCWkloZFZY?=
 =?utf-8?Q?ebc0xVjVEzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE1qcFl0Q0RMMzZKa0xIbWZVTmpDY1hoekJJUGZmbmR1WW1GYVQwRHdsWkJu?=
 =?utf-8?B?a3lXZkY1bXovdHY0eWdhUy9TcnI2Z2hRN1hIbDZ0b0JsQ0JZMEZVeCtOdGFY?=
 =?utf-8?B?SDJkQkVNeG1rRU05VEpNN0JJeGVSZUUrVW05RlJNSGo5WTR2STdSVFFXdlZx?=
 =?utf-8?B?aWZkb2tFbitaQTgvZ2x1UUtMUGN4Sy8zek4ycHdiY0VxY1lmU3BFbUZQR2dx?=
 =?utf-8?B?NHM3L3hDOVUwRzVtRkJ5QjZJazh1QmlkTnRUdG9sbFFKY1NNVWREM2VGUlhy?=
 =?utf-8?B?ZmFnZDZ6aHI5SjRNVThxNFJpR2JIeGtVcmx1UlZBQkh3OVMzQmJtcTFGTG5i?=
 =?utf-8?B?cU0xeitPeGdEd2Z4djJob05TNFlXNGRVbUN6N1BSWlc2NENZVkswSldMeUhB?=
 =?utf-8?B?UzBZcWZPWmNKWkFkTkp5S25pTUEwRHJkVTRqNFpwellNMWh5cDdIcHdCaXI0?=
 =?utf-8?B?a1JPbDNKOFp3YmFNa1NyZnFXMEIwZXN4VXZ0OGliUEtLY0gxN202cVpQWFZ3?=
 =?utf-8?B?bzJuN1VMVEJ6NTJ2MzBSbGRwc3hDT0NJTmFFWW1Eck52QTByL052N3B0a2ts?=
 =?utf-8?B?ZXZxNy8rT3lJanorYmVweXpNK0tHWXZiK1Y2WHlWcWdJbjVOeEVnd0NUcGQ2?=
 =?utf-8?B?UVRzNXJBSnFqbXlxYU1ybWdwcDBSTXhXbWI2b1RmZ1ZsMTRYdHFhbzFEK1lG?=
 =?utf-8?B?Z0tDcEtOWXJVRGlTV0FBQTRxY1dzeVgvbW9jOGR1M0FEVzVnc2tRcnBSZVVx?=
 =?utf-8?B?RTYzN21WTEx3R2tBQStUKzdpb2xpREpKQUFsY2pPcGQ2WnZDVkhpQURqdmZ0?=
 =?utf-8?B?aTl4VzkyTXN6Tml0MFJ1dHBkT0ZDc3YrNWJjU09VV0tod1l6eWdoZ2grT1FK?=
 =?utf-8?B?eDRNellVeXVIMWhWdlp3MGNJUGJjWDh3dGVjTXlRSEhqeDhhQUVMTWI4NWFp?=
 =?utf-8?B?UklpWFExYkk2WTVGMDduOSs1T2FOa1kzTHFCbWZ6ZDRtV3prVndyUHMyTlJU?=
 =?utf-8?B?aXAwTGhwRVdhOXdRR0FnQ05lZHVmL0VqZG1xNis3bXZROUkyMlhEbWE2WUo5?=
 =?utf-8?B?bWIyZ005WTlyb3NRWnEzVnZyU0l6ektUUlAvaGQxSmZNOGxKWThkeVVDV2dP?=
 =?utf-8?B?MFA0UGovYzRiOGZPN2hnTnVSVEhBQzJvRkRiMzVqRDloUC9rcDRTL2JtM0dH?=
 =?utf-8?B?VXVqRjZ6L1I3c3lMa0tKMEYydVQ1dDNKSERHWFZFd0Vmb2NWeXNObFNMM2hm?=
 =?utf-8?B?cDFOckZvMXZoYXpvcG1pR0pIYkJkdDBSeTQ0aUxRb201cHVzZklSUXRWRTFj?=
 =?utf-8?B?d25HWlhhc0RMNzVnZ3BwU2J3UmtGcDlCRTV2dm1tWDg4RXE2aU9xY1FCbFVq?=
 =?utf-8?B?SEhUQXV1RGxjL2MyZVFXOEwrTC9LMno5SzI2MkUxcGdXYzR6QVFiWHUwazdK?=
 =?utf-8?B?UzhPVFQ2bGY0VFprUXozTWNjTFVjYUUwTE1ndExJdUVPd1JDblpERUgyVUxq?=
 =?utf-8?B?Z1lVRVE3dERrZVFrRWMxTnlIUTdqZjFQaTQvVTBya1JnN2Z4aEw2c0liVjdE?=
 =?utf-8?B?bnBDbERadHlGeDZXUytaeUZBRDU2TlpKcUdNZkRaVnc1WVJvV1M2OHBLM2ha?=
 =?utf-8?B?L1ZNR1JreWJXYS9tYytVTHBuai9yNVJDR05UaUxiZmtDQmNubjdOMHgzMXB5?=
 =?utf-8?B?UDZTdk0rN2gxSHl3dUd3WHVOTDgvWmNIN2trWVM0YXhnNi80YVBzOVF3T3BQ?=
 =?utf-8?B?TStRay9LV094Ynp6bmd6TStlMG9YK25nYW1LcFFjdWEzTnpKWnc1cE8zSUpB?=
 =?utf-8?B?aXl0eHVQRVUvdzdrY2d2SWxZZGhwWVo4VHFSSXJNSytRWndWanRjVTN5TXAw?=
 =?utf-8?B?bU9nYll4YWpSbTcybWZzZ3g2ejZvMlF2c1IyUFdIaGpXNnB0ajRyeGRFL0Ru?=
 =?utf-8?B?a2luamt2OUFLb1FQM0hkUG4ydlp1TFBCRmtxRmhZa2Q3NE12OHBNNi9iOUhh?=
 =?utf-8?B?RURid2RDSUdndEl1bHcybHpERUtGUnQ2YUJGOG5rdG84Zy9Zb1k2MGYzZ3VJ?=
 =?utf-8?B?OU1WU2lFVE5zZVByeFFEMTJSZUVqK0lDZWVHYkpDc0ttb3lIK09pYzkvb0Vn?=
 =?utf-8?Q?68aMRak8N6NbLniPvAhj1Kqa1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e484c65-e384-49ad-aab8-08dda9ccdeb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:19:13.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qukWrsMt6py1r1jOpLQtrIA3b8JM6fK0GZb8bY0eOmE0CLBshn28WVGKBZkJukYep8ntBDkQKw+oi37mnj1X/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

On Thu, Jun 12, 2025 at 09:38:32PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 12, 2025 at 11:51:56AM -0400, Frank Li wrote:
> > On Thu, Jun 12, 2025 at 08:16:03PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 13, 2025 at 11:38:46AM -0400, Frank Li wrote:
> > > > If the parent 'ranges' property in DT correctly describes the address
> > > > translation, the cpu_addr_fixup() callback is not needed. Print a warning
> > > > message to inform users to correct their DTB files and prepare to remove
> > > > cpu_addr_fixup().
> > > >
> > >
> > > This patch seem to have dropped, but I do see a value in printing the warning to
> > > encourage developers/users to fix the DTB in some way. Since we fixed the driver
> > > to parse the DT 'ranges' properly, the presence of cpu_addr_fixup() callback
> > > indicates that the translation is not properly described in DT. So DT has to be
> > > fixed.
> >
> > This patch already in mainline with Bjorn's fine tuned at when merge.
> >
> > 	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
> >         if (fixup) {
> >                 fixup_addr = fixup(pci, cpu_phys_addr);
> >                 if (reg_addr == fixup_addr) {
> >                         dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
> >                                  reg_name, index, reg_addr, fixup_addr,
> >                                  (unsigned long long) cpu_phys_addr, fixup);
> >                 } else {
> >                         dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
> >                                  reg_name, index, reg_addr, fixup_addr,
> >                                  (unsigned long long) cpu_phys_addr);
> >                         reg_addr = fixup_addr;
> >                 }
> >
> >                 return cpu_phys_addr - reg_addr;
> >         }
> >
> > I have not seen this "dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");"
> >
>
> This patch is supposed to add this warning and nothing else.

We can forget this one. Can help check doorbell patch if you have time

https://lore.kernel.org/imx/202506101649.UpwblcVd-lkp@intel.com/T/#t

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

