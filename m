Return-Path: <linux-pci+bounces-4472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC6870A73
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDFFB23728
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6282F48CC7;
	Mon,  4 Mar 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kwESIvY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C47992C;
	Mon,  4 Mar 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579620; cv=fail; b=T2HfTshAzV/q23VLgDIq/mTGfhSwE/2A3PsIgMW/LGrfS44bB7CIwAhZnlkmTCKxanZotIIzGvtu7xYbCxv3KqHtM1JNXAYfILA/AHyrAdhwtIKp601CqRVR0ngTJ45pglhq/uK7lx+j+8+P6jEHdBnU3i9SpqagY8RzWQrQDKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579620; c=relaxed/simple;
	bh=iQTJcfATuecCU0mqi3WCExzmZZDKa4emUFnBjXmHZQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a7JXs1hkyK3PNpXmP5nCS1ynoI9OvDBqr9Izd/eObauvwcLPLeptza5c+R8bLcgXg+rCU+XsOPbwabqgNuURviKwZL2gbyV8L0JHnafbH8NKmuwox22NI2k8g1HdFQUYYGyLDk4q38lgvn6erU3XgUNo83HerLtaa4qE4+hwlAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kwESIvY6; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSeTwjUsN8s3+cUZ5xpSgydm7Jsqa6e7TejxJCdjIFfDrf86NQrUk5CtXGkrwos0dsqM5kHcyu/bnofodU+TJgk9PlzSY0PPiiI/+c/cLnI5o3CdHh+PliBc4cE73KanXVx6Lm562iqM4AfKAehjrkr/MmVSHio4QZfyQF91LqM0ussQbRwq7zPaFESZO+R0YB2DXKJY/Fy4imRupK75khxXK5f3iYfdIQCiIn/wVNSshLFhArPwE0p69wzPdy9gY+Y2qAegy9w6MQlCBQ2/Lqezp2JxBxrkdrX46zvz6uxjnmAyzeVn+6MLlcU5VSwRS2zzptETeHy+91GBYt30kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruo/okYZAc0FSiLgpkw6/N8IPxYuS2uUTBdHdDf3BoQ=;
 b=BkV1gJJVYNG+tQZHh0cRJzsrBnQex++YZhIVg0vKpPKzNhCnZtKONL6M62V9ij3W4IQqVPk2/b3jddw7LFw99N/8BFzUYY8Tgh+VCyeRYRzasSDgKhotvql2T+kzdtcQaPiVeo8vvljdEVEtkvQX/TpsKigyDyzkAcR64sij15fYqsAv0s5etEF5EqZGZY9syPRngBxQKfAuHafEy90xWzthOn8908YTL+t4EwE3PYPZvgueOPMZ2+lQeFw5+QWvji5CQRnc4LjIg5D7m02yt6Ycn3ETEwR4IfO13hHCLdAYonJ33EOdyLXKn0Lafs5sn3yR+Mw+bprydq50Te0QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruo/okYZAc0FSiLgpkw6/N8IPxYuS2uUTBdHdDf3BoQ=;
 b=kwESIvY6BaTmYObtBjfVyOmsrxads8jenWXBxc3SjPe6ifrQat08wY5ShUjR8QeHO5pOd72DNIvSdbJUvyCiJnbk/vUZq0gH0O3WJqsxbZwHBRAKyftZJJoQ/XZisZaOfYEbGQP8UUqN6BWo8vmMHBeaniFTsh6Va/mouCaot48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9357.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 19:13:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 19:13:35 +0000
Date: Mon, 4 Mar 2024 14:13:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZeYdV3xMWa0nbz3k@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <20240304084841.GJ2647@thinkpad>
 <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>
 <20240304181005.GF31079@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304181005.GF31079@thinkpad>
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f33058-72ff-4ff6-11d3-08dc3c7f30a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pTvuqVv7GTGwJ6CyKpNVz/ARLsan2zS1MAgg7Wuqv7tAQD98SPRic894GjwGtiF60w0hKCQuoaTlvGJO2hRwHPYveaKlQV6VQN4wy8Qfd95twCfj82pfmSYeEn3O/wSfpYUiONvuoixsiFYUJ8JZ265D4IZWn6NPcxM9LapcnsWQ50A06VuMEJLjK55p9M61d8pesLmIl4Ser8JF1SI0w+9Uq9tCYiCHn1sMECL7hLYQHJN6J0f7XqbiOS1WRCD4uJEEy1Np7S/bM/RUqzvKcV4aDZ9TRqK2yrFIG0GcDhC5tlej4GCHzc31jOqzGtdtpKhNmFEXjPKp7Zo/A6CBb8zr1x+nuueCrrj2w6ZtwHwK1pySyvO3AWcW2y6+4K9BzoHFDawXiW5wi3CcRyGzNVHZgcvRblCIXj6Jjz04uCzNX1U9wl7b3pT5gd83X8IIJBTbAHdPeZ0lQ40+Cf8kyIPoUSiOZPRdsHGnLCwoaVT+ToF4h2MLCuPQUp41IY5uGGaj4ULCY7VXLMqr3C7z4kjW591jT+9sN/43q8/4bGLeuvMpUcwITeKYduJ/YkVYp9KZn76pMOlpvWjvmrV670vAKgGzBfeRIkLPUmUaoqaKceqf2rmt8SiwFdrLsSMtOPAT341H+2BLPep5f41qpw1+TmG0OHq8buQdE6+oqhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9aVk50MG81eldyaTh2RENJNXV1RU83NStOeXVtcnJuNlN6cFV6Nm5kVFdy?=
 =?utf-8?B?eFpxYzFUYzVmbXk0b25lSHMxVTRzcU4rcVlOZzJ5b2dsTTF3WkRjWVlweW5m?=
 =?utf-8?B?dmZWU2VvM3FnVGRFTTFwV2ZlQ1FOSmdHS2pGSXZVd2dGMU4wZFBQTklXeXRn?=
 =?utf-8?B?MFQyeUNXcVVWb0dzZ0N5RGVsQVcrRFpJOVRyYzFhRkpkeUlwN1I4a2Foa1FT?=
 =?utf-8?B?VzEyRk13cS9uRHZYTHZ2WmJzT0lUdHpTNzZFZGZiTDZwSks0YnNKU3FZdEV2?=
 =?utf-8?B?R3AzK291RDM1bWJZTmxZbS9CckFJWnFEWlJpc1g3ZXcySnZmSXFxTFI1OFgx?=
 =?utf-8?B?ZXJ1ZkF0MURRK1Mvb0pVMXFRZ3lwZXh1dDhvWjRZUUw2ZXFxMGxETjJzUUlM?=
 =?utf-8?B?cFdMWXcyZGUyZkpqYVNtRk55MUdFVHF5MHFRbVF2Nm90Y01kdUNLSDlYSUlP?=
 =?utf-8?B?UFB2RVVPSUVxVmRGZk81bXAzT3kwTTI4WmhhWlR0K3V0N0lYUVVwN1dTblJ0?=
 =?utf-8?B?Q05UNjE4VFUxd2NqTXRmelROeGgxcGRUc0JzS0dBT1JMSU0vbDVha3RNWDU0?=
 =?utf-8?B?WFhzYWZRVlpQK1FjODhBM0Y0OFNpZmwvQmluOExCSDFhQVR0dDJQSWR6T1Qw?=
 =?utf-8?B?RjNZbEdHMWorYlpVZ2VZSkNFL09ER3dCT1dDSVd5WnZoR2kreXVVMy93UjNF?=
 =?utf-8?B?Wm94NGNPR1dFZGdpUkpRWDJEOHl0VnJhUzZ2bXBvNGR0Q0tVNGowS29BQm0r?=
 =?utf-8?B?cDJuNTRXOTh4aEhDSlBENDdLYzZ2QVVTVkNxb2xLN1Jqb2x3V1RRWXpKNEsy?=
 =?utf-8?B?TWt1TFI1clhUMVZtajk3NmpBTjhsR1ZMODZ5eE9nOTJmSVh0N3ZUbWpxeHgr?=
 =?utf-8?B?MTNRVEZDZmpaQmVxYzVpemhvTC9TVktLR2hpSXV2d1c5dEVCbWJRbGlyWlRU?=
 =?utf-8?B?VytCcjh0NWZxQ2ZlWVBnZm4rR2RQaHBpSnBrNWErVXVVQ2tFYk8vdXJlMGgr?=
 =?utf-8?B?WE1ZaGNlYmhIVE50TzN2eHlWREV0Ky9xYUtEb3RRalEyZmkzQURJMExUNjdP?=
 =?utf-8?B?a0RRSXhQaXNDc0pCNkZTUFJPMHQraGxUZGErUTZGZDAvOWpISXdRa3Qxc25y?=
 =?utf-8?B?ZWU3QUJ6SFN1Z3AyRjRnSXpHa1BOMDNyMnNrNWJ2MVByRkFteGdyLzJhMXJJ?=
 =?utf-8?B?Mm5tb2lRMlBYSHROWkJ3Q3VGVEpVcGgvVGxyYmtEcnVaSWVwVzNQZnZGbWlK?=
 =?utf-8?B?NlJPSDMwak1PSHVVNGxVR1dtemVQK1kwNFUzS1ZvMnNDVmd1VE9GM2JVazhx?=
 =?utf-8?B?bmdKcUViM0wvZnhUcnRmYm4xR0c1bjVIcVFud1A4aWcyTXNMVndGOFdpaGhh?=
 =?utf-8?B?c3RXYUVpTkNVZjJ3UGIyZnZGWjBTTm9ZTWpadHBHbzUvNHNwVjU4NXFLYjNI?=
 =?utf-8?B?Z0JjNnBXQnNFSTV1czRpaVI1aTQrNFllM3FoTVc2RThUcXpSODJ4V2gyZ2dz?=
 =?utf-8?B?VTZPWmg3aFovNGpTVDZvUDhUT0ZDRDlwajIveFZNRThjVUQ5bGw5dyt0SGsx?=
 =?utf-8?B?Z0xiZEVnMFAwQmVSNm43dnEwSVB5WngzUFVTeGdQZjhCbmYvcnJHdENJRmtD?=
 =?utf-8?B?aWNpd0NwZ0FkVHRQMkZIN21jUllmNjBLcVlDMlJHQnVHd3NuSi85TTM3ZG8w?=
 =?utf-8?B?UXQyVkJLZEsxZG5PUndGWEx6N21QTDd3WVExWng4Mi9uYWE1VUoxM04xZHNh?=
 =?utf-8?B?SEZweWVqVFlubVZYT2o2Z3ZVOUE0ZmVUUy9rd3daMGJxQW9KVndCYUxNMU9S?=
 =?utf-8?B?bVBSR2VQd3RjVDFTdW14NlVqRzZEVmhiUnc2bjNRSjNoTVhEUGFJalhaS1dr?=
 =?utf-8?B?c0RrQjY0UzdSUUc4dk1VcFA5bCtBKzN1MUh4czN5b005TzhoODdLN3FKbHZS?=
 =?utf-8?B?WVloNzFvT0tELzBGZnloTGNKSGZUYTc3aVdjbU5HTEJqOUdlWXZhRVF3d3NV?=
 =?utf-8?B?dXBOMHErWlVxc2JhbVZ1WEZZdGNkME5meTloTmUxbEZHSC9vKzRQVFNVMStI?=
 =?utf-8?B?UVFYQmg5RWNxME5xb0dqcGF5UUxuZTdhN3FRZ2J6SGVJd3lncTZZRGt0Ny9U?=
 =?utf-8?Q?1E2YcbDP6DyR8PJNPQoa7MyHZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f33058-72ff-4ff6-11d3-08dc3c7f30a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:13:35.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sje5akqMisoBwwKoPM08vYiwpyD4H/SCLooyQeITtSgAEkvDF5tM3RZh9otT4e25RBNhyYqwXct5pz9lkMrcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9357

On Mon, Mar 04, 2024 at 11:40:05PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 04, 2024 at 11:47:36AM -0500, Frank Li wrote:
> > On Mon, Mar 04, 2024 at 02:18:41PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 19, 2023 at 02:38:34PM +0000, Niklas Cassel wrote:
> > > > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > > > dw_pcie_ep_inbound_atu()
> > > > > > > {
> > > > > > > 	...
> > > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > > 	else
> > > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > > 	...
> > > > > > > }
> > > > > > > 
> > > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > > 
> > > > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > > > not allocate atu to the bar.
> > > > > > > 
> > > > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Notes:
> > > > > > >     @Niklas:
> > > > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > > > >     mail list.
> > > > > > 
> > > > > > Hello Frank,
> > > > > > 
> > > > > > Thank you for sending a proper fix for this!
> > > > > > 
> > > > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > > > need to change the type to signed, but either way is fine by me, so:
> > > > > 
> > > > > index + 1 don't match hardware iATU index. It will be confused because
> > > > > other parts is 0 based.
> > > > > 
> > > > > So I choose "-1" as free iATU.
> > > > 
> > > > A s8 can hold a max value of 127.
> > > > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > > > 
> > > > Since the DWC code can be synthesized with 256 iATUs,
> > > > your code will not work on systems with 128 or more iATUs.
> > > > 
> > > > If we continue to use a u8, and offset the saved value by one,
> > > > we will at least be able to support 255-1 == 254 iATUs.
> > > > 
> > > 
> > > Agree. I cannot suggest a better alternative. So let's go with this. But please
> > > add a comment before bar_to_atu assignment to make it clear. Like,
> > > 
> > > 	/*
> > > 	 * Always increment free_win before assignment, since value 0 is used to
> > > 	 * identify unallocated mapping.
> > > 	 */
> > > 	ep->bar_to_atu[bar] = free_win + 1;
> > 
> > This patch already change to use "-1" as free. Only issue for this patch is
> > that use 's16' instead of 's8' becasue max ATU number is 255.
> > 
> 
> Niklas's initial suggestion of keeping u8 for the array and 0 as the unallocated
> placeholder sounds good to me. Please use that instead.
> 

It is impossible to keep u8, because 255 + 1 will 0 for u8. Previously
Niklas's initial suggestion have not consider this condition. If u8 have to
change to u16 or s16 anyways, I prefer use -1 as free.

Frank

> Even though iATU window index starts from 0, the comment I suggested will
> clarify what this bar_to_atu[] does.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

