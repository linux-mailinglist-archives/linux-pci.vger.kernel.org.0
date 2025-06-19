Return-Path: <linux-pci+bounces-30201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF2AE09FF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174047B16BD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DAB22D7A1;
	Thu, 19 Jun 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z7FHuigu"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB020C480;
	Thu, 19 Jun 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345970; cv=fail; b=uR/Mh7IWZmpURJWCLKZ3KXBLk0/dXZ9zfqzEOLYg7OJ7OFMjY3YiwCrUrnK3yg5TiHBedcochAIc6yZ6xwbnFIkKl9FEysYsYO2Npxh0qrhI5XmglULVnQvHQp12AaJm5fQ5VqghdllvY2d4rgSzu/t2ghlRxMwziSucVJwsdOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345970; c=relaxed/simple;
	bh=6nYyrLBkjZn/o7J6EBBEvTG5cpgFuH5m/6nPMs8Ik8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W9nr6MxIkTgkX8ns0vQN2gvpTZy2+5zzecGJ5P2F2PH4J0UZUW4QOpbDM0JTmg1DWq3wpVBnNS0gqx9ipDzIBmsIm2gzj1SXGDrgfrYP07u8SItXuYk50JGDO3dTfysUn3KBuwwNWtvIOlXlfcRsBoe1Qvyv/E++sAoQaWAaOJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z7FHuigu; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+PQd6MZAPzA4HyqZi71pmwoNEdrBKCqj5cuRFEwuZMGzW9L43/FBDhCrec3F2v+ZOwLJVkQUvwdO79jB7ubI0VIrkupljNgXCJ8YWUxPoxEn7rxdJrRxMOJTENlEhrF2dPPJR1HJJVZaKLaAv82zlT5dB8liaGE2kOf9MpPkA3xG/efpNEGYl1rr/XVNMNQZfVYUXtkyvUgOfOoIgqgtd0UkVrwFPT5giu10l+hLi1XcUL3j4KBYjeWg+w0xW32QCkLDiQo6O1sNa8RclmgjMTOCg2oVFEiTe3v7V5LsCapAC5b9GhyU9S+cbJ0WX3ASF98IjzJym1p8JiBbvmqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=minngryfPQygzHEqzd6j7oM2vAMv3qlX0xZLJa5vjrc=;
 b=A5/8dwcvgu8JF54/O+VDZ4SHWiAKlvd6ocdPPMDDTczVnjxNnd5C7Mlpv3lSsuMG9mByZ2arwh8uTLIb4CaoGOUad52g02z5REmHPC10VLAjYVRseBf/EE3/MdXcw/2v9dth0KjEoL6AHimbCYZb5TXVjI/WdTfrQZUFZI1horryQNuBfeLpPNVBv9/yikvSu8XVCxUsXPbgRHGwVjQ5UurEFLiG0sn/Q4W4aJGGmt6Rnt5SWoOIEtwY4wblBAcqqU8+SFjywSw/xtgvEIeWes/aOD70REjSL/CdEEAIvnSTwJUS0fXjVLvQsI1ESZ8+x2H8Uem5yFguQ8J7HNPzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=minngryfPQygzHEqzd6j7oM2vAMv3qlX0xZLJa5vjrc=;
 b=Z7FHuiguPsxZ6V3dm/Ks0e/ZWN3pNvNvCqzZ2rz2T4hKAXpHF/i+LpjTfhXFfOWz0Zk+gi+6u5Ge8EaE9llyhmp585tkQ3AxUdbbemLmeOZyaqs6xM+DVzIgF/TQogF+eQl4sjj6RPDPA0zLiArDWf/E5PAYox8E/eSA8shomX8uSj+Y7oUXVFKTitFGRw5adwkJZtpDloKz29k3LnvKb7TkCU3CKB9BC3UzkP6NwpTbQb4KLJqU3mqtdmAe1k1A05IC44IOppE6itsZZs+goKeNTQ5zvk9WZoGLTNTYQC+LV1UKx8zIRy/t/0JK/oS1BeGpXAky/gNN0xSbjzFaGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7424.eurprd04.prod.outlook.com (2603:10a6:800:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 15:12:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 15:12:45 +0000
Date: Thu, 19 Jun 2025 11:12:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for
 register bit manipulation
Message-ID: <aFQo5sQ8HhhCH8NP@lizhi-Precision-Tower-5810>
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-2-18255117159@163.com>
 <aFOSIj1fimMwWCT7@lizhi-Precision-Tower-5810>
 <02c3d0b2-e97e-47ce-b472-4525e8eff68a@cixtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c3d0b2-e97e-47ce-b472-4525e8eff68a@cixtech.com>
X-ClientProxiedBy: PH8P221CA0052.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: baa5039e-7ad0-4fbc-4a83-08ddaf43be7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PboFYjhY/c9z0F7CGR/9WyzWloHH5zof0j3PSzZls+d8MWmU8wolhX7im31e?=
 =?us-ascii?Q?BvuracmSWAPhHCRJd29JUcloel7xJGbC4T3ufpL775SLLCzz6P0knflcT9hq?=
 =?us-ascii?Q?/idg8u/mg9Jsaejc7ltM8d3WMyk0UnIJ2ZLme0FPzeI8YFK95in02sqJflth?=
 =?us-ascii?Q?Bh5n5VX+aJt5v0mqHsP4OZPOnqbKJ9mOuPTcBwK1POJWJsyX0JEd9VKLayM+?=
 =?us-ascii?Q?DgWnvGwzVY8E8qXuePNfAZX2PBs98itDYx5ew7U7cOEhJKYE1tuSXVwLF68d?=
 =?us-ascii?Q?NzdtJSOEKfWoLdrtpNX9BUPJj/7Yq7kXhtu0fA7mjeD76orG1qiCwTXXwljP?=
 =?us-ascii?Q?QRKMAyZ5qvTIdS6UJe6IShDN0wXbb8oEgfEUbEoFLufIRizV10u3cx8lfxy3?=
 =?us-ascii?Q?A1H86CB9JRYuNJgQpU2zxq+Ss+UXCE04+Tc9/oLKIKieqDnJIbWe8xzh/1Rh?=
 =?us-ascii?Q?3UuSFFb/XwHIKxMfTLEtKEySjLDmlWKsP/rqBQHEAqvMfP4h2BByumghCqsS?=
 =?us-ascii?Q?CxVjh9+KqS61WpvOwRtDNj5DwKTFLRk79TmFM6VMxzOfvUcnrXklQlhLVREv?=
 =?us-ascii?Q?bQoFFxnc8gKCf0kIAkqYrMA0Ow7507asBmDxCy+WYGxxnlbdez7BASJb5cg5?=
 =?us-ascii?Q?r5mgeBvphFuhrwy4mL7YH+gPUCgRFiIkgh6IWv9fLa87tB3O18RQubq3My5O?=
 =?us-ascii?Q?pDEE0N/YZ/DhiAKvXviSFqXzD6KT6bSfFbDpLkbXMkZHhXvyYFfYUrjvb0U9?=
 =?us-ascii?Q?hyQmEramlCjYugVojdv3t1f6HnifsNIXFdiIoA8Yt2hTS2Mr8vHo0s0QPPNw?=
 =?us-ascii?Q?+nKHaHuq1bsGZ+PyCnUrcb7yz1ENqw4T+KEINpYCGdNyQIMV3D9yKtkvFfmQ?=
 =?us-ascii?Q?zQ2zJFvbBPZvgq8quFsShNm7UysgMBFf9vv+Li48xeAuzj2wIpyKedrfHp/M?=
 =?us-ascii?Q?C9o6/mPsqbOK0j/HfB3/+RyJgFKPh+Ensun+libFXjHzi2DpbnNU3BGdBWui?=
 =?us-ascii?Q?3+MZ0DRetT7h9yraCIzcWsWdZ1phV8hALd10jpT0lAwbFXqum1SJnp2Cq468?=
 =?us-ascii?Q?CzR4UDGKOmpNiDlzgCSg9Grqf4XHbxtblT/5DFQQ3P8HMPBCqNCM2ClO5mzv?=
 =?us-ascii?Q?eaO6xXTkeu/X9USGKytA07j33cSboIWbtdlv/WKofixOZSFL7HFqnSGVnK07?=
 =?us-ascii?Q?xUb4Tt4padvwgVhDkJeAz3FP8dKyADLeaYXZQq0J0oXrtLLJgAVye8DBc+uV?=
 =?us-ascii?Q?f/TlPRlDyzImo6f9tSpX1fwvn6mOTr1XhnLNs9U/qivG5n5Od9JF8pfROuqA?=
 =?us-ascii?Q?0gg/l70WZrA7fbe4DAOzz4gbwg7uoJ6DpFv9XQkgWC+hZG4tUDe4wgKtGZuO?=
 =?us-ascii?Q?Us592MdsbPT3X+7DNimVCP12LaN4T5BDPp9sXQQ+isnHY9FY99nPuBHDXWr8?=
 =?us-ascii?Q?fdhG3LcnTDlJpgtrjmQvXbM5MWL1BEB4+j1F87whbF6cHKo84/9qWMaHm9cV?=
 =?us-ascii?Q?+rYPhFfkZ+DASI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJbYh/xJ85Sf67dGCOKNhZWuwn4yGxuxK/cucmCgpTS42KlswGiKAuuUmXOX?=
 =?us-ascii?Q?L5Jting3j7T3DHgY+Ss3Rw+X647Wb/SDIVlu6KWuzUbMsJBOqB5Swvrmu0fQ?=
 =?us-ascii?Q?Xq2USXjKh+XXgh9jz+vOLGaMU7g8lUlZvAyGIxf8QMh+DxxVjVKdTgIi4XFr?=
 =?us-ascii?Q?RpU9HJBCrkizTrfS9MjLuzM7A7oc9kosrU+SOh1jxXf1Mmrsq3dXN8GbLDoC?=
 =?us-ascii?Q?dVaufydZ6nhFcp21+1YGtKYkTLwntjOeNbWXQEfi6OU0fAOtTepw7xfdH/qd?=
 =?us-ascii?Q?o1CWfmdkPHE71y8t9vp7dE0293OL7s7kfcOB1bW7phHMUvF5tU5JbqnKFl9M?=
 =?us-ascii?Q?jYnHXaiUysAUnE2XisNRj7vtaiGRiIZnSwfuk0LpwGMOH7FiRvgd7asR1zwE?=
 =?us-ascii?Q?rkcML/NpI8E+ptsMbrgByxEK7rYs59tLmJHYi5g/OefTt1q/aJYGDWR8UzDI?=
 =?us-ascii?Q?TDZxbArptAD/eQM6afsbPevw0y3q5YBf9qosaSIBT4tCz7R6OibOyWC42o+9?=
 =?us-ascii?Q?c37+Nx9PLUsjT3KSUh5aSCp9SK7av83ywXMxa7Pch91xQo2lU0NyLel2Ho06?=
 =?us-ascii?Q?D31/7TvnaVXsevhdtP7SRgevmy7dj8XhQzEFyMIGxynMQMMA/YUDBJWVFDg1?=
 =?us-ascii?Q?P4lrHfPTf7lNxXyIcIXlMdTFaU023UmBzcUnIXuPKIlxjxlAuRuaXYikjzvD?=
 =?us-ascii?Q?B8VpRrtdEeEgUXPSj6WEkq7uYLdFJhlLMGoEXDGKHItmS10eKipyLDql0RH5?=
 =?us-ascii?Q?EhHV9USbYT+asksjqmhVmaXbOVy+WsxCjp27Ol3Ax2zSpfeSLvp4bxNssdtb?=
 =?us-ascii?Q?xX0yIsloIvqD/dMF6pu+1U5NBnBThe1TjS0cr3kvL+O3QTih4ZmLRNarezxX?=
 =?us-ascii?Q?XK13NNw4ZbX0FBHXXQZwvg/eVLLBpwyFKyjQhOt6DfFG6TsuZmCoYTG3Kp1u?=
 =?us-ascii?Q?d15+wQAPQsrRQ3wp+6bZtf30WhuZwXthQ2o4bYFbHzAPpTbWJMNYa0/lPJgx?=
 =?us-ascii?Q?qUidjFVD/kGSFjDD4rnhqqWYkfLuJZul8usCU60RFJSzjNlNOibwFTO8GoRQ?=
 =?us-ascii?Q?Ha3M7LIhr8E7V4doGNXZeeLeyWHeDTHoo+0J4mT0LUAC5+Z7IGE/wqNq2p1e?=
 =?us-ascii?Q?D5jKaf1me0LOyS7rCMaTuqeawKRs7SnXa97F0XxZbhmMqT0WBGHnJ4vJRnga?=
 =?us-ascii?Q?zon/SxPDgliK5DLfNrSJBSITA0fcdCR2RSzNoUCihCw09IfBkI2iTSszBDnp?=
 =?us-ascii?Q?Dx2OziBLTp6HCeDKVR7Sm7EwaiIfr3zIZI4bA2ixsOhBxrAlYAM8vSafznqn?=
 =?us-ascii?Q?uqvHVqi2NfO2YanupuTtYvMF17Tewfp+JZGlynpd8ryFRv0IkUeuMLH9SWg5?=
 =?us-ascii?Q?WYMY9NM48pAJ/AocoaPz0Jbi0IamHWzi8FGwCdvqW/iGtPip6i/C0naWQxlY?=
 =?us-ascii?Q?QrzOCfozaVCSiFuzo15lvIteSoEAVXsrnTxYmhtYuFvdX0lPHDP1raOehSA+?=
 =?us-ascii?Q?0B90mXjXJCpLjRzyLYTz6E7Zs9iMvq6OSq63wq7EcbLQNKhYzp454KXCj29B?=
 =?us-ascii?Q?kB2uyfayVKzzvngVv4NqBj+ZSfGLjo2TX/Pg4SJx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa5039e-7ad0-4fbc-4a83-08ddaf43be7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:12:45.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/Gf4BoxUb6s3OSu/nI/9R8Sa+a9VvrV7x1y3RvOWOC/l3r7HUTyca51E3m4hy+5DJcLsb1lsiwrnG5M0tR5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7424

On Thu, Jun 19, 2025 at 01:42:05PM +0800, Hans Zhang wrote:
>
>
> On 2025/6/19 12:29, Frank Li wrote:
> > EXTERNAL EMAIL
> >
> > On Wed, Jun 18, 2025 at 11:21:00PM +0800, Hans Zhang wrote:
> > > DesignWare PCIe controller drivers implement register bit manipulation
> > > through explicit read-modify-write sequences. These patterns appear
> > > repeatedly across multiple drivers with minor variations, creating
> > > code duplication and maintenance overhead.
> > >
> > > Implement dw_pcie_clear_and_set_dword() helper to encapsulate atomic
> > > register modification. The function reads the current register value,
> > > clears specified bits, sets new bits, and writes back the result in
> > > a single operation. This abstraction hides bitwise manipulation details
> > > while ensuring consistent behavior across all usage sites.
> > >
> > > Centralizing this logic reduces future maintenance effort when modifying
> > > register access patterns and minimizes the risk of implementation
> > > divergence between drivers.
> > >
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware.h | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index ce9e18554e42..f401c144df0f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -707,6 +707,17 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > >        dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
> > >   }
> > >
> > > +static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
> > > +                                            u32 clear, u32 set)
> >
> > Can align with regmap_update_bits() argumnet?
> >
> > dw_pcie_update_dbi_bits()?
> >
>
> Dear Frank,
>
> Thank you for your reply.
>
>
> Personally, I think it should be the same as the following API. In this way,
> we can easily know the corresponding parameters and it also conforms to the
> usage habits of PCIe. What do you think?

You are right!

Frank
>
>
> drivers/pci/access.c
>
> int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
> 					u32 clear, u32 set)
> {
> 	int ret;
> 	u32 val;
>
> 	ret = pcie_capability_read_dword(dev, pos, &val);
> 	if (ret)
> 		return ret;
>
> 	val &= ~clear;
> 	val |= set;
> 	return pcie_capability_write_dword(dev, pos, val);
> }
> EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>
>
> void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> 				    u32 clear, u32 set)
> {
> 	u32 val;
>
> 	pci_read_config_dword(dev, pos, &val);
> 	val &= ~clear;
> 	val |= set;
> 	pci_write_config_dword(dev, pos, val);
> }
> EXPORT_SYMBOL(pci_clear_and_set_config_dword);
>
>
> Best regards,
> Hans
>
> > Frank
> >
> > > +{
> > > +     u32 val;
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, pos);
> > > +     val &= ~clear;
> > > +     val |= set;
> > > +     dw_pcie_writel_dbi(pci, pos, val);
> > > +}
> > > +
> > >   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> > >   {
> > >        u32 reg;
> > > --
> > > 2.25.1
> > >
> >

