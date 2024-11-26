Return-Path: <linux-pci+bounces-17370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D19D9DDE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 20:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1F6B22166
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778316F0E8;
	Tue, 26 Nov 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAIBjtrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D81DDC2B;
	Tue, 26 Nov 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648055; cv=fail; b=g07IOuH2drCE9i1AWWmStuL6M+wLXRLSpBAuyaRwDwIndWOtmpcfXoIkynJ2olaYVJQO/PXQ5T2RM8g3+QkSjo7+aW1x7hJwEEOlZiJU5Omn1HYJjYeDGeYzyUmxl5OUHlHHyyaAXq5KuL0kIkkYrDdAbZhuGw2BgUQexfrBFh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648055; c=relaxed/simple;
	bh=vL2rfZTWi+3DmcdHa/rKmvCZ/I4ERSrxUDQgbhnmBRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbk+3Y5tXlDp9f3Mn0QO8t6Cy+8BzVOExkDoJZVXOU53oD9w8MRWGnuDgJ5X0o99gDKMI/PN7e+zqX8mDyWTFJXGjwc1UlSfRqbI28EVI+DBnjUzxpDmDdGrCV9nzfBO33RfMtIhGXin+Y37zmmI0aWkcFnevHoB0olt+w6Y4Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAIBjtrH; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuFja1cflMJbqapsLFgV2HzzoqtDUGrp/zQ3RYMsLNhFgF9FqPvx0IgjVea9BLvn0ZLBNFhPbw8mQGqXvB19JkUH81hqzfEwyFJAE9aBUhrvMUmazZyyMEgU5vMcshl+m5uPE00bQIKniySyoW8+YW5vUVXYYnC9dHUx7WFhkF4uda55QqTzK81UE35CjLciAEpX+JntGEd5jVhQzguHecQ4z3KkvovHZSiBWHd0+7eDtscTvhShS+J3xIvKDZn7Cq/eX0Fb439vr4XxSkM3DZ92PK90nhiOABNyCJw6mCfIbG7tkhU8cjo8xUq++E+vKkn1MU4ZnMDMMS57ijhC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzCzbllZ5SY0hIbPtfcSdTm/1wVfi+K5Rxs5VsOwI4k=;
 b=av/jTIBFGFu3t2ri2TelB/oy764TLOF+0TAJ/WZlQaFyHMNy0xxf9XCvW9IK0cqQy+DQoZfKoQiDS4PjbVPXN589D4HCX0Y/pSI1QlvYlJ8E51ZYAH25IW1dHWrvCIiHYIgKP+fJeOiUehxld7EEB9Nor+5V5F9RM+CLTTAOtL/73tJpoVPM/Yefp6WwYUYxJg69EHKXTNQV4OhOFkZIWVjvwhza9pe3rq8fYMMPGH/MDmjW9Y7nnidwP5QGUYDYqeNnBy+ONNHCxT09kiNDZmQE1HU2IETmmoSXYqsJXMr51gr72e/s1hVF6T0JD4vdyLJG7/L/arIiewiMTbKWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzCzbllZ5SY0hIbPtfcSdTm/1wVfi+K5Rxs5VsOwI4k=;
 b=cAIBjtrHV/yKdEEp0o6wHZ4nJ8Vq8nevcrMrPgxKCUqPlB44IHaYCLcYeEP/lfIYu0hPoNCc1KXdfKGWimhPTNYdsu7N+4/f+ThEYi1UFl1GgdalS51fzKRt45ez8qi1pPXiiiEb19HA0oX0nHNaLkPwaZ0gw1t21hy+1V+hhW4GTOtnMPPvKHu9ssCLjPz+UPj8aEoFloxrUnv3jGRwqmrKoKhK/b+DVBREA9E+fQQkFXnJlY5nOcIrn0umOxEliI3Df/mJlYNtXvkfNgZdGoAIKf3i1qZ2ooRcUEA/uhJwaAoWrKsBPEGkieLmfB3/nPoaZKzJ4+mGxbhrPS6ttQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 19:07:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 19:07:29 +0000
Date: Tue, 26 Nov 2024 14:07:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <Z0YcaXU4LiR+kD07@lizhi-Precision-Tower-5810>
References: <20241126073909.4058733-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126073909.4058733-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7a5c1e-be13-45e8-b1af-08dd0e4d92a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zk8ZCl8y8WFRcJKLjGw8uln8kXmI3i+4gw4WpsXhHcV/sYymyicnb68S5yNO?=
 =?us-ascii?Q?Esg86mpE/xqBqMdaSh3c8leda2VyIkgv+A0CijgYwf+dby9fMXOaG/1yVwf1?=
 =?us-ascii?Q?kvKkjYK5cp1QTBLJFj+2+xJt7W2G86828TJ6wd40rUYTzaRKlVv/Aqsx5w6b?=
 =?us-ascii?Q?bHK6noZdjxO2EJNTlyrVXit2s54fcPHJ/JdtGduCzcjK2iMR/SszmWzhvGIn?=
 =?us-ascii?Q?UBV3z0F3GC7Y304ovwmt1/w6Hn7Gmk8Lx8SrRvHMDPTSdwED/DuW748mXriS?=
 =?us-ascii?Q?v8dZ++8kNs16ieu9lP9kBTygaxJb/o4Z1z55ufnsVXgoLETU1hRGXr6p72Xj?=
 =?us-ascii?Q?y1+RYutjLSrJH9ZjBi7ZYKhG0d6oq0rMPhv1qkexbyXEtA+bL6ErLOzt+hS0?=
 =?us-ascii?Q?WzS1RTKlcR+ThJaLyQdKQbl5TfWqtBVrSBYxjc6t/nIAXp5cyPfe0rZQ9bkB?=
 =?us-ascii?Q?U00jSGhyT0FxOJrjoM8heP/9ANX1C3Yidd9vFJE1fyau6mYtSdWzQngefwrP?=
 =?us-ascii?Q?sdz2YO34WtTOdCJ+QKHZgP34epHGZncF3N1cPNKPu+fu7Ky9qcXH/lLvSrLb?=
 =?us-ascii?Q?8xKaGwqN0EKRfzE+Kb9qDhF/0G9sEO2conkdHPOhlxSrAdzjPcYytrKIcW02?=
 =?us-ascii?Q?4hCABn8DHGHLmGQ/PV9IS+XBLgsAxq3efZzrR+qzgElZQcUC6DwI6hhapymx?=
 =?us-ascii?Q?E/zUa/uK4RxAcT2/Fq6N7Hge7WhSEnHuNQCpH2jjzM0tBB+9lnKIe1HCmnaT?=
 =?us-ascii?Q?joB2VVKmhx4cUUsIxg5wpUwKD3OHozdu13XN4aQgElVzTyIglFCoFmsKjaJv?=
 =?us-ascii?Q?GXL7C0fFuHykXExjFHFpPVsUdB62Y6J20vECzAkIdAfCIJDb57Pgk0ncSlmr?=
 =?us-ascii?Q?oK15zGFFGFB+Dmm8xqywClLJUcNIXCYZ5wohnYAXIssrd12VnmMcIArqbp0g?=
 =?us-ascii?Q?wKqsENG7kQ+wvULOFOvY7Cl4icOfVI1VxQAGKn02WHVXnSVwx1Y80jWthUtk?=
 =?us-ascii?Q?DQA2uWh/jMeJBhqcXk5YzhWAWN6XuwCDnc1QGL5O1t8ocrixDk5adlEk7enA?=
 =?us-ascii?Q?SK8Gss+hh60f5bFY2fWBklKuEPlGvYCa8dBfQPULThYmNYgRP6ZblLouFQ/O?=
 =?us-ascii?Q?B64KW/9DjliAbiGx//Ex96y+NwJ+ht8pUGC6tZJxytjZxSz/fDK9d+TeKQwC?=
 =?us-ascii?Q?An2P3H7eLs9j2/V6v83dsMmftJfVw/m33jU8HkO9ekkasgzUJD+DiCFSlqpb?=
 =?us-ascii?Q?5cxW4y6AWBSBV1T3iDvEbgF2M+VCj/W7Bo5hN9fpi++bu/yhSMdxtZsXxWMl?=
 =?us-ascii?Q?MsWP2YujdqlmMw0Id/IdmufFas4qKuEX3chzzn9yK6evKSqMLyhSbcCWMhLa?=
 =?us-ascii?Q?nKFxFmPU0E1cE/ZTreRpI/pXBbJ4093qNEPIVgdUTZtA5lgBHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JS3hQ0oeCsp3W+Utfq91rYVl4pc8UlmvR8qDipnmMzHAPMleL6rbjM6FTiCk?=
 =?us-ascii?Q?C6/HPwCTi28WEk9Sv4sWBSVQTKAl+EtpvHB1OsEPnZ8sZP8XjtNA6sYlGp7v?=
 =?us-ascii?Q?j59YfuChwcwfYcsMiEOV4M4B9skcyGuRqRyoWtT1V/dfg184dXWEUMIZXy0P?=
 =?us-ascii?Q?GnKqccF+v+37kHarM/7n8V2PjdM35haG7T1abLLeApfwRLByvgbiWA4vBY/L?=
 =?us-ascii?Q?DpI61CtoHSwBOERz2OW30h/h3Qd6/92Llz6XlMZxsscH7SRpUDUeYaJXp5ZV?=
 =?us-ascii?Q?sdpDW/Sa5hL8zUTIxF7Rum8fwhZJAU4dRR7WoAT0tt/PJ8mwkavDtHXIKh/8?=
 =?us-ascii?Q?WIqsQvc/ODs0NUQqAZQfacCvhXeNiLgXER9iBb4yG6bHmRAsviuWBOSFWPmt?=
 =?us-ascii?Q?W5EGQdWyM5/D7tjaEP2didHJjiJtgcQtuJY8Y+5lbBSKbN8Q67tgSg+JypLt?=
 =?us-ascii?Q?3hr27iGs0fpSHTl7ru4BGfzs4LGT1Bnd0zQ8D4gNrxoLxb+3FEppHO3rO3iw?=
 =?us-ascii?Q?HAHFoBy5pM5tYe9kcSllrSikoFnE+2NG/SbyWXr2VLlOJX4bbT9BE0nwDQGZ?=
 =?us-ascii?Q?UGeDv+HdVj5ApVYw10EAc0o8+q5BNBsJawJcLD3zbrvq4jWN/QyBGf3vjr8D?=
 =?us-ascii?Q?NtqKkxhiIM+EZJZTLZ/2N91meeMESErVFX1sMcBjiwitdl+se+zWHwwWcYSI?=
 =?us-ascii?Q?cS9AUzk/QX72RzxxfbgRMiE3abH1yuhYNQO14pA7TOjmVJms/Ea9vCgPCrgt?=
 =?us-ascii?Q?bOWJoqCBdo1+162W7aOs/8mLAp9RQ193jQwiNmu6GWCe86mPj/7s+5X535QL?=
 =?us-ascii?Q?33iYDxLJ/BW2FKoIT4hHw4FkACZPoR3+HD1AgDoO8yGPj19Tk5H18Ow0nn6b?=
 =?us-ascii?Q?LiQCUlI9GHWbB6lwrMdHZV2IFIAZhspXJdP2ev1ZaT2SjQ8vJ7RNutq5LDge?=
 =?us-ascii?Q?9TGsfD0hSFgDxgW/gbRfPA3He/yh7VNl4IYzOBBcUyDm6rpXK4Huc2vYK3AY?=
 =?us-ascii?Q?nJnF3F6f1pUp0wxOGgfnhHJMfraaT5FeTFqWkfvbEYeA2/oFdI1SOv6I38iU?=
 =?us-ascii?Q?ZEYn6VUa7IrFY1Fm6h4LWy7ibvJByCOUYd5Ow6K3Ncz89mMgluuuEU8K/LVE?=
 =?us-ascii?Q?DZBdFgiKmTmhxDoVeN7ut5iCn7uQKTUv5sZQD/NgVvPLyW63QxSb4oaNu3Ae?=
 =?us-ascii?Q?zXrfgMsuaLUG3AWegayD3YhOeuATaiQSYVYsxjFZr3PSiWr9FWgA20TJlgiu?=
 =?us-ascii?Q?y3MqtgJ8YLQR3XG5ZmygcSFPPX/WI84Q/TU3YTgN53Z3idnnZRwTMTM06lAe?=
 =?us-ascii?Q?tQtSFmZENib1TkHetFR3GAsBVDxmTBoOg894Z/SySsfHbXfQ2RaZL+tnJKks?=
 =?us-ascii?Q?Ot705bszbmTJusc08GE9tn8JVacH77VTmyK84T5pzjlAp43lkCdrVrLeuHN/?=
 =?us-ascii?Q?KHeShHgmSmosXo24UUsPq8OjxoB0lGmm5/8bEZsTHE8supAsW7KyqbpPo6ji?=
 =?us-ascii?Q?RJ+8KtiIWTk80GOJiOE6o84jL3cSnXR/Xf0X90QQ8gLj2xRqLGgPvbaU8iTz?=
 =?us-ascii?Q?yxaCdjTKO0+tknHLOGej7qjn9m/1UY4PyBcL5ZKc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7a5c1e-be13-45e8-b1af-08dd0e4d92a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:07:29.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy8wfPbELVeCUhownw4RsRtClBg/SKHNtjXF+venr7rfPQTbrAUdc8w8UAAR8UO89wyyzJIkph48NIiXuCiqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115

On Tue, Nov 26, 2024 at 03:39:09PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
>
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v5 changes:
> - Remove the redundant check "(val > DW_PCIE_LTSSM_DETECT_WAIT)".
> v4 changes:
> - Keep error return when L2 entry is failed and the endpoint is
>   connected refer to Krishna' comments. Thanks.
> v3 changes:
> - Refine the commit message refer to Manivannan's comments.
> - Regarding Frank's comments, avoid 10ms wait when no link up.
> v2 changes:
> - Don't remove L2 poll check.
> - Add one 1us delay after L2 entry.
> - No error return when L2 entry is timeout
> - Don't print message when no link up.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 24e89b66b772..bbd0ee862c12 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,25 +927,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +				val == DW_PCIE_LTSSM_L2_IDLE ||
> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret) {
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		return ret;
>  	}
>
> +	/*
> +	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +	 * 100ns after L2/L3 Ready before turning off refclock and
> +	 * main power. It's harmless too when no endpoint connected.
> +	 */
> +	udelay(1);
> +
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
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

