Return-Path: <linux-pci+bounces-17090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FB9D2D9C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580D21F27047
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885D1D1F4B;
	Tue, 19 Nov 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KFARJUTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA931D1F79;
	Tue, 19 Nov 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039800; cv=fail; b=cu8khN0zmFNwvdlSUHoGXzHytLxQeRG4EPTz69nIzxULFrtH/6Hzgr0k+RPl61hSg9ol7e01ECO/Rdonw5VfA2rC56PEwwRdAP6+bTAn9MI1nRqStU0ZmVLDe3PEgz+KLYAbc9nXN0rDOjJ4oqmijpnlt3MqluTEfqVa6Q41BI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039800; c=relaxed/simple;
	bh=aZrGyK8j20DoyICIBq55xS5QUdvpcvmXC71UnQ4JICs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDSBfXWs2IOamqxT3PfhkjdKgFtB9yN3dlFh869ujlTVc+ROyC42qof7EO/BwAfqDm0o9af0aX5PzdQWEkONWI5/+Y2pzjRyv8Tmdj/U1GXYFX7B3ho3RmRJSVawrbcxXu5vX3FkF8kkb4njgMrh1XM8Jc/m+2RNwKZP8UMOg7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KFARJUTl; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOR7QqoAZY2ONrgo0BDT7tbvgMRexatNp/X4Skm9kI2F2CKM5YjbXCh93nRZ0ZuRvQY8/yy3gtV0sAx/KvGeJ4LWavOJUudPTrpRTcy4YInWXEWEVZWSg8PTAwYFXiz/nJ+/yl1mPX/IcfK+TSkG42kcy3I63BQYypiieF7VGRHDmyBA9CYEHNSv1VNrymmFOExndd+Wt+/k+oc3tNzNlEk+8Y2l4roYxLGOkiOt6pLyWfZbGWVQ7KAjX7XH89pDaJXdW8Q7D3WnD53gEZpSVuifYdpibek2k74VUsImJJj3B5zGTtJbc3YdMq25bqZ9mOFiqTb1qK7+tJrtaTqIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYCanwXhKoDJbqsSW77qjjOrnTmnfTSPpBgyRJUOFGw=;
 b=HuPLex2CPKe78reQe16R28ifOBs1O6eISEH8X9inn3arPZa7fzBLZfHYiYAa4OLbPnclQ6Kzw20k6yv6QgLesFHpW80KrfK1TZ8iTR1kGQGlaA0h1q2OSBtFAIdTPKEcJEwALGkpdwI61K2zEBC93D5dj3Bjh6MC6f66+OExoGMUKexuzg/YiqbCgsYJ/A7xtCu5jtG61gFayPTD9XZMoobvWldV2Xr+g24GvJ3MbVvg2eJTyRqdr1j85mefsrE4fREBaj2MUeVSH1csDIGgoFsTIeDG9q0B8/73dueGM8tiVyhfPFqhzvIwrEpgvmU3f8owaH0V22Eophk7KjIIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYCanwXhKoDJbqsSW77qjjOrnTmnfTSPpBgyRJUOFGw=;
 b=KFARJUTl6fP/vqOyZDNB/TkJK/E61sLb311TgjOboSB+gXKclC9Wvq2y/QjooHVlHTcSz9ptevL4DwVj46D8Pwx0Q9oMFm6C3dZT8cDdXFu6J2edCT0t9kxw/be6fQaalDOxlr9rKa2YNn4DBUQHDudvrMb5nrHPVqieJQ1Cj7NJky//jDT5J/igtZoLd07UumOci92i0gXDps/QVytFLT3XSvV8WhVdZGR+f4/ECX6kdpeysCcNVvcCloXiR8zHwKanj8uWIp7aOrxTtFaIa1egc1mCnCvW4k9KuZveN8UqBZvrZgBmpF1peO0Dm1WeRtSdZTfT6vBI20LmiwujXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 18:09:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 18:09:55 +0000
Date: Tue, 19 Nov 2024 13:09:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZzzUa8Zs3qJiVPam@lizhi-Precision-Tower-5810>
References: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9b905e-22cd-49b6-cb8e-08dd08c55ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpVVhFYdikT24VRJ4N+Yq6gEGjFlp4UN7y9NQndU3+JXjXyXvxGxfmyLXy3p?=
 =?us-ascii?Q?VnCn2Ue2FDWruC9vvxEd7ooMaY6j0rrxZgyMmDDwQgWzFUbaj8wQWcyOvSbJ?=
 =?us-ascii?Q?on7w6SQBcauk/XQsnyMJf6ksvStJwWU2haLhWcxDBRXZgvLJuf1lRsKPfNtY?=
 =?us-ascii?Q?uNwJ7lysQ6v2Ldi6vC61uG0Ic1Mu6HFhkwKVnDF0tCqdK3Qi35RmmJQbgzJO?=
 =?us-ascii?Q?EI1Tb3gWfx34PhYr5bO0fwcpyWzZSv/nJwm4qJFOzdtj0Nf27cvYv9zj3H3E?=
 =?us-ascii?Q?DOeL+hi1G2di1MArhsMVDwa0xBzcjqUQrfh8JUgCEtCd0cMrZIklUdQMkSRS?=
 =?us-ascii?Q?Kf9z1lqbBhkrPYmm0oSGv/h5ZU3aDpvXxoKziwDriKjpKPshMuoSHVVfdF0J?=
 =?us-ascii?Q?wueXxLcF2HU4ZETraAidToRDcslcQbpE0CIVuBzL2ECxHWuhEhW9tymU0rTC?=
 =?us-ascii?Q?o+8O2wCKfaKHuXUFoYZYRpeYuHWfblRjtBXdJ/z+fR4wt5xnzu1VRdlN8Fhb?=
 =?us-ascii?Q?4u3JEc9PVL8Q5zHc9LTVcD6u3GSGd5E9Ax7mqk5p3a6dr4NEHqUv5zX7ffFa?=
 =?us-ascii?Q?fhTEhVmfGuBxC58vThZxnyAupXx2O90BG8lYOFdimUgfF+pXqXro5HFikcjH?=
 =?us-ascii?Q?GvxM/qS3NpI0ToP4t0ygchXx7JyY1Pkt2jeAWeURT9EzS8AtdDohmJpQ3dPq?=
 =?us-ascii?Q?CBtSl0vuBNtVMMmla7qHCtazICus2vmdOD29GNho8NaN7+PZGX5EiuFFmazm?=
 =?us-ascii?Q?dLx9XYSZ6GUSMemv6PpHyECXtv2/c20VxjO4rhtomvmtUUSoDOFlllQdmdeu?=
 =?us-ascii?Q?enJEijtecDCsOHKVfd7aJ7uwT1kyXOHIpIbX2as6T+vG3RIawCBttlPGcC7C?=
 =?us-ascii?Q?J06mp/SZ0h9U1Be/5q0drEV7fwDoXoCAlidMSdQaE+BIvNGjCCF9fKyXAynX?=
 =?us-ascii?Q?Uigh6oIvC+ED+mdopLzomh51lSLrP99R46H/qkh3KojGNUbhEhk8bDxyJ7kx?=
 =?us-ascii?Q?lLsV46qI3Bc6mOUeoR40nDC3Lrz+L+U4c3Pr7Xn2q35t7Ct3DqcTrl1l52l9?=
 =?us-ascii?Q?Dqfq8YtReir3RQE0zHzCHEfb5aJrjNMshwk1o7KCw2+JdC2pSE5lSD+NGU4f?=
 =?us-ascii?Q?5Evr8/MF757s2SmGn2FFMzAbf9pTfJw4Hb09X0go2l8Q8cyDGL6ArL5VHHgt?=
 =?us-ascii?Q?aXsn6siHv43HJPv8K4IziQhFsfXQHxyvNCu/hnOV8x+hBenXmWI2noFH4gNv?=
 =?us-ascii?Q?oxR96XZj9sU0ovL7tAxhK80c0s/zzg0JIwdBWXItZt9JBFHB4pPLi7wR8sN9?=
 =?us-ascii?Q?Z6+rzcZKXe/Dpt1JZLrdPItKDV1mPhHTBkBIomYHSpNSfOCnrH+vXTfLGLpQ?=
 =?us-ascii?Q?R2O7DZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSFYPIHInK1POhd0MRPw4axd2u1qXkvatoLCkvOjKlouyE0skkJMYWzTPtbU?=
 =?us-ascii?Q?nLHXejssLUw6FpDf5E/zaOvj3iLzCuWUs3enYsNp/RMNdnrCVSUZ8UBqpvnj?=
 =?us-ascii?Q?jX7uI6JtTLweihQa++EwFuofoGxUwvC6fRT/l1Txo8FU1nyiNNjCKSNZIQSy?=
 =?us-ascii?Q?cTxI7KVKQBcAzNrFN8pKQfjID41bfABBhG6GubrKQ2s4MJB7KsCMKzaQ8i8L?=
 =?us-ascii?Q?+1dPoQVlV79fW89gA+Ilv38ZHPBzjFbb/n2+HjfAGdwkO07xHK2JnrMceZsV?=
 =?us-ascii?Q?typvgJPA/q+uQck39Y2I2NiyZ5Q1d5DpYLr0mRUhWx3WiJ4Xl7WgNuyIwGek?=
 =?us-ascii?Q?S0EUrTxre9ukbCFhSPLbC5kTMtDF129+kcyGRduOhitKQhkagyNfpkumEH8s?=
 =?us-ascii?Q?33oZuYKLpkBeniP1USCNztgQdYSni7sa6gJffHSLVYpErEaK/lu0VGK2TNjo?=
 =?us-ascii?Q?4hQQWK5XOYe4rrsf0YtQq6AEE/gc9T7QoC1z8DghoyIiNDxWKeoeJwWQBr7W?=
 =?us-ascii?Q?Kzhqs2NxgnFK6f+k0GZTTlQK+cHXXYp1a9Z664L6DY14A0mn29WPH0h6CR/G?=
 =?us-ascii?Q?9bikO+H6ktTJ4d3xpsNKwYVwJsBemeifPvNI1rNUeJpsaCNZzXplp9HOPbu/?=
 =?us-ascii?Q?4qNEA6ojxS0Odh7sqOlSjcIpKkP80/g0b4CA/AteaQZMfyaiMs6+n9XztKuj?=
 =?us-ascii?Q?frmsfypKrTv81u5K0yP47sZLBtR9KNer9lv8bPWbg6kRikOoSaL7r3E1Anoo?=
 =?us-ascii?Q?mBzGXBLx63a54G8Qj9IkaV4BNmbNgHwTevDM+nCYWUSmAbwWYs2AkwYNqNYR?=
 =?us-ascii?Q?JYw6O+4uGy7RWoNlLBXVms/3NNrprpWKLuWA89k3lWEOAJseP8xKFW6WDumn?=
 =?us-ascii?Q?z+nm95H3IX7Q5RYBrJTJibdJury14kZ9DI9tadUGl+ZtY7P0FG0uIgGtCdKv?=
 =?us-ascii?Q?fGZedlPSQ5FBLiki4K9lQUQIM8IwAcjznRfeJnSHA+S8LvN2ymCyW+IkkBhi?=
 =?us-ascii?Q?NbzBrDmJs5x8ZkBoEty7RX6WYORqLGcmK40UlH4BpFZnNwSYVtF1N5PXqjz8?=
 =?us-ascii?Q?/OSYDboWDRVCrVrEJYk1s+DAgXEY8SX9uT2FCOU6jjlOKjb7J1oxY5dl21XQ?=
 =?us-ascii?Q?5XVyF8ljA+rFgqw6QqcG4JFT4myADco6RSfgF9jyAuvVmmjRoEezpofw/Bt3?=
 =?us-ascii?Q?ES8vjIYkmNWCD4ckNDxMCEYuly9i1i0YyxmeacwSWGP3EHxFYEoO5eTyYOvE?=
 =?us-ascii?Q?TNd0FwBa9iMBsLYKKLUdppArb34mhexYEyDoRfIb/35IiAsku5oRgiXIYJU8?=
 =?us-ascii?Q?E8f7dVwZXRej6YrRCUO5WXNZPdWQcJhnUT6L4AK1HrifD2oIbe/y/QjzPSr2?=
 =?us-ascii?Q?63lyx927K78n76634PWOLUvblR4gJs0tAdlLjzUJTRUp5jaPVOHIB2lWiNZU?=
 =?us-ascii?Q?kO/nKR/CGL2Wl9lXkjKsVniwdrTjUtEyKXG2SeChQBVtUh8a/qyT92mp1TtH?=
 =?us-ascii?Q?v0hiFWHW541A5tBEN5b7n40P+o/oBymTtFYcUW3tkQqvN/ouzkAW/V8baopv?=
 =?us-ascii?Q?kOMaehlUhlqT5fpk+OjVIty3mbHD0EdRZBJrc9m+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9b905e-22cd-49b6-cb8e-08dd08c55ed1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 18:09:55.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2kgKdEFZ+mhJ3BjlG9I25C1/9gGPDticdI6Efy0al9xMFuIAOGcbsxEDoWRtkTa41Gzd9mVncoxBpDkoZnLyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873

On Mon, Nov 18, 2024 at 01:44:47PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
>
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.
>
> Also, when the endpoint is connected and PME_TURN_OFF is sent, do not return
> error if the link doesn't enter L2. Just print a warning and continue with the
> suspend as the link will be recovered in dw_pcie_resume_noirq().
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v3 changes:
> - Refine the commit message refer to Manivannan's comments.
> - Regarding Frank's comments, avoid 10ms wait when no link up.
> v2 changes:
> - Don't remove L2 poll check.
> - Add one 1us delay after L2 entry.
> - No error return when L2 entry is timeout
> - Don't print message when no link up.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 40 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 24e89b66b772..68fbc16199e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,24 +927,28 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>
> -	/* Only send out PME_TURN_OFF when PCIE link is up */
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> -		if (ret)
> -			return ret;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
> +	if (ret)
> +		return ret;
>
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
> -	}
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +				val == DW_PCIE_LTSSM_L2_IDLE ||
> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))

if true of (val <= DW_PCIE_LTSSM_DETECT_WAIT), which means not device
attached, 'ret' should be 0.

when ret is not 0, means, link up and not in L2 idle status. So check
'(val > DW_PCIE_LTSSM_DETECT_WAIT)' is redundant.

NOT(val == DW_PCIE_LTSSM_L2_IDLE || val <= DW_PCIE_LTSSM_DETECT_WAIT)
equal
(val != DW_PCIE_LTSSM_L2_IDLE) && (val > DW_PCIE_LTSSM_DETECT_WAIT)

Frank

> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +	else
> +		/*
> +		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +		 * 100ns after L2/L3 Ready before turning off refclock and
> +		 * main power. It's harmless too when no endpoint connected.
> +		 */
> +		udelay(1);
>
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
> @@ -952,7 +956,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>
>  	pci->suspended = true;
>
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..bf036e66717e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>  	DW_PCIE_LTSSM_L0 = 0x11,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>
> --
> 2.37.1
>

