Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64D7670F4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjG1Ptw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjG1Ptv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 11:49:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD17E0;
        Fri, 28 Jul 2023 08:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS9V2D5qYR0LuU1QRM1OUl7UIkMkS2rYo38P2b5gWpbPlW6nHjjpb1r8703PKFkGYJnBSqDoq2QArY/jr6unP0bHoEDF8c2H/Neml14zzGJQBPiabheLbmcxgqhXu5W+QxJ2LwAuNv8FXBI4t/n5tHuTlQhtNXCb5VwJvzE+D8+vJKOvNsuQg0pcT3kbTnFfbdrS+a7Dl8gkaqvY1MppWIYVgimOGeO3IeCBzvs0fjUUjlo7+Dq3nPqhyPFVFrAVZ5eIyYxSEoSQWrauOdy5RYRWchJDz1sTaNLa/NrcPP78nGiZhvZOaVRqffr9FvQgCl5VHT8jdh4azuTouorY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDIfjQNXS5FEMRkQGzG0lDKTtsYYWcF7A+BSHR0eCio=;
 b=F0Ldg1bKvYE1CdKHJ8Peoo5typQNDuznjuUHtktP1JbTQXYvXRlbVaIRJyjopUlE5INmYfHD4lK01CaTXkZOu8SgDr2JoPys9kySgwFHrGrJd1zzJqlQXCO9BLKlrnS4PQLLsx9O1BPClfbJ3pL4CE+rvPSpJSvYWaERKpQrUF68Uz3tIyX24fw2/YTja30Zf8CfPoWCjgbw87tNwFe5mEERO7Wnat7mFV6BzvKwd2I7XvjF14wDx/nt0TQuGvVmOXPlVjbjAuZx9U1YuFLiS541LdtI5Doa80hU02eKlBOEdILmvcH54aToEN3IKJ/L+uaFalpmSWIl+KuX0V3bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDIfjQNXS5FEMRkQGzG0lDKTtsYYWcF7A+BSHR0eCio=;
 b=Iao7ccbRLSsWchHPZnZ9fdIJoFOPz4OEgnzIATyTp4kNGW7Fs5d+IkncZ72n2x2w/VdUvUhrQ70/jdWG/CaHovf/CtBPnn5cw7+fCzuFBGOt+QIwFTGgvzE1A4OPTvXGi4bmExMVBUrXJuUvbfz7CLRzSiL47LeRwO5zB92+HGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:49:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:49:46 +0000
Date:   Fri, 28 Jul 2023 11:49:28 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        helgaas@kernel.org, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mani@kernel.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v5 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitionse
Message-ID: <ZMPjiBYQV20N5kdu@lizhi-Precision-Tower-5810>
References: <20230724215830.2253112-1-Frank.Li@nxp.com>
 <20230728153238.GA4719@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728153238.GA4719@thinkpad>
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 434baf2d-71f8-4a8d-a9c8-08db8f8244c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBVi/TWNL8rcnee8CBjEiryvK4uF9YFcEyOBZtodw1UPXQdewK+l5PcaOwP96WMJmqdKa+LoMe02LtfmRxGTnPfTE2pYq3fnz/eLTZ4CbufwO3RTSRgV8QmFCzFmp24fJGy6zkE5wlH9sK8yrJjl9KvPRkhXhejXmaLVzwYGk/pSOEglOaENPT3cd7wlNeNgO6oC1ylbndXUiK8GgEy6No+8+47pqsfyScijHtMfSqxP2EvF7K2ZeNePO0BZ13km+v4t1nDPQg2O/0Ef3ie+uJJL0B8gK3ijAJfPgnvoeoG1hI/N8CCIvQAXsnaRJVuoDN8BtJ5KhedPMtia7ELq8d7KfIFSoai/z1wXApsSomQeFTmt/IXWbEI/PSS4aPEmbGv13gVpG6jkmI5DXK7lvD1HbtPriLWzajueLHI1W75H8Z52W20Cv3yAm78xnFicaQVVkdkoR/zQYFn2IGG2BIQUFo3LyF1AGsaP648W3zarAwj/IdZjcZBUKq4Js9qC9x616b5Nvro5lKDklF7U54fONdNXgFS90pi5Ns+TTjOkp9kSy3CwLwUmsp5sowS+uFaCWRKBiJJUe2b+oRntqbh1ZkKb/k7rTLCaDTg+EZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(86362001)(2906002)(15650500001)(8936002)(8676002)(7416002)(316002)(83380400001)(38100700002)(5660300002)(66476007)(66946007)(66556008)(38350700002)(4326008)(6916009)(33716001)(186003)(6486002)(26005)(478600001)(6506007)(6666004)(41300700001)(6512007)(966005)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRyRGhzVndURHo3T3RGUmdQZkdJQnhvdWRGNlRuZE9HL3RJb1lOOGdvTzlw?=
 =?utf-8?B?UGlGMGpPaFE3TWJtb0cxTjVrRTYzdWRSa0FrRVdZbGIwUzUyUG02bENvUVR4?=
 =?utf-8?B?SDNXSkV5WWlnMXJhaituZ0lEVjZxL2lORHZWdzhBS2hndGhsMW5DMkt1U3hF?=
 =?utf-8?B?MEdjR0FhcU55QnJ1Z1NwWFJUSFN2M3RKRFVwQ3kzbGtKTXd5SEwxejk5NjBx?=
 =?utf-8?B?OXhoaThyNy9SRVVmTlhlejUwUnVGWHZtR3lhZU1JOXVOMTJRZVBoSUhzTkFo?=
 =?utf-8?B?TE8xRWVNemo0M0NIdkRSMHFzaUlVakRvVDhZLzRKRExVS2diQ2lJdVZHWjdW?=
 =?utf-8?B?TGF6KzlpNGNLdnVTck9nMndqUmF4RW53cUFPUjV5eUJkMGJNTXBQVjljYzNI?=
 =?utf-8?B?UmhoRC83bmMzL3ROR1Y1c3k2VitJTDZqajRCRUh3N2VQTm5JTHBQcVpRa0JH?=
 =?utf-8?B?bFY2NE9EZ1VPaDMrOS80ZE56VlVGb0JYMnVWdmlUbDJYaGVqUkJZR1hMNjk2?=
 =?utf-8?B?M1FqTm5kc2pmeWdobzFuZmliZTh6YUthV1puM2Z3elBtcDFrYlVXV3ZBUG04?=
 =?utf-8?B?a2c4c1VnVFpUQjY5MitBY2w1dE4vS3NPKzNGR3lpV1BXL3NaQ1c1cTdyeVVX?=
 =?utf-8?B?ZTRXck85MWdkY0xYem5RSlFHdzlIL0pXN0RLanlGNHRlYzZ1VURvMkNnaEhF?=
 =?utf-8?B?Sys0cUhmVlpRTVBrTUxzODVHWnc4VGh4SklMT0lnME5DWUNoSVlrQzRvTUZQ?=
 =?utf-8?B?SkNHMHFESGR2R3pUZk5kSVlwdU1Db1Z1Wk42dzFnLzNFMzJFZURWTnc3dlJR?=
 =?utf-8?B?T3NXZHlFMjFEVmdjWTJySUVibzdtTjR4dUlUbHBnSjR1b1RlWjE0dld0UnZo?=
 =?utf-8?B?c3NUbjBIcm1EdWdYenBvZTRWZVVITEJ5OWxReERjVXVYSERFSmdOOVJIcVJa?=
 =?utf-8?B?YysyZzF1SytEa2tKazhRMXBLYUxXeDJGYWt5dGtZMzZuSTNQcWxOOFB6dmlO?=
 =?utf-8?B?c0YzNXNMSjRRbFJHYmlPYjY2OFd6UC9qZ3I2aE0yRkZrcnlsN0RBQU1qOTUw?=
 =?utf-8?B?ZWlXVmp1WnFqV1ZCMkRFaDF0c3ZpTUIwOTdJL1ZlVXhlNFI0bzd1S1lISDV6?=
 =?utf-8?B?bTErQnRid2dITXF6MWVBbk5GQmcvaXVreVdROHlwQzBFekltU0pVeEM1czRO?=
 =?utf-8?B?R1pEeWlTWDRNWjgveTJEWE9RbTM3YUlwMHJTSkFlbkNzSkdqeE9ueTBVUVBJ?=
 =?utf-8?B?YTA1bzNrY0hsMko5R1kyelgyVEgrd1ZLZlg2V3l6dit1cmpWL05uYVlUeTZM?=
 =?utf-8?B?eWFKZEVpaFVVaUxCL2UyVlJMSmpGcFNrMjFBMTdTdVA0OU5IWHRTSE1OZ1BG?=
 =?utf-8?B?SmxlOWhtWHRXTlU3anVSY09Cc0VLSWUvbS9kMitWdjNxbnV6REJ6RzVMcFpG?=
 =?utf-8?B?OFlOKzBlL0YzVlJIeUFnY2RTb0tQWE85enNvWUc2UVJjVlljTFRmSmptZDlx?=
 =?utf-8?B?TlNFUjRHcFB6cU44eUJ3dWFZbkZ0TUk2TEQxK2QrQjluSDlsNUhBKzlMWmND?=
 =?utf-8?B?L05iak5HeWxuTU1FUC8yTmpxWXFKaEswdGU3MjBWbFh1RFN2N1FuZ3VheFZ4?=
 =?utf-8?B?aHRQdldOa3JPVHNCeVJkUE50amd6UG96MmhSU3dNVk9lN1I5LzE5NExnekll?=
 =?utf-8?B?TS9aUFJkQVZhdENIOWc5Q1N5KzVGUzZQMlhUOUhFcTVHVWxsQURCTzd0WFJB?=
 =?utf-8?B?aFFjMC96K3M5WDhXU2dkdThHUGdMWi91Zm1tVDhvVFZKQllEUUVPSWRaeUkv?=
 =?utf-8?B?SFNrODZnUzNuQk9sQ1lYU3RsUVRUNEx6MlRFQVh6MVl0L0tlOVN1T2doOFc0?=
 =?utf-8?B?OERCdnZhVXhScmNzeGhyV2xlYWVXS3RneVBKSU1ZRGlnRXZwbHBaUHNiUnpw?=
 =?utf-8?B?a1BuRzZ2YTAreE13ZlRETi8xT0FyUFlXM3N4eHFnY0h4M3pkaVlzTDN5MHdk?=
 =?utf-8?B?TVphcTZhd2UzT1lPVFBlc3lJN2MzMlhOZDJWMC94WGJTc0o0YW5PSFVkZE9l?=
 =?utf-8?B?cFNQZ3JkQ1lIMktNY3BSbnRLeTJqZkxuK25sUXZCeXoxOTRpQU9TQzVZeFVa?=
 =?utf-8?Q?cYQ6dFKnFleQxtVSKDkhzrCML?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434baf2d-71f8-4a8d-a9c8-08db8f8244c3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:49:46.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLrYwp4HKNw6mW3KFUoaQYOPHjj/zRoowuQJX3fj4nyk0xI7PHpbxAd8ZP3q800sGPHiNKrCYcYOBrpOydTHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 09:02:38PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 24, 2023 at 05:58:29PM -0400, Frank Li wrote:
> > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > 
> > Typical L2 entry workflow:
> > 
> > 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> > 2. Await link entering L2_IDLE state.
> > 3. Transition Root complex to D3 state.
> > 
> > Typical L2 exit workflow:
> > 
> > 1. Transition Root complex to D0 state.
> > 2. Issue exit from L2 command.
> > 3. Reinitialize PCI host.
> > 4. Wait for link to become active.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v4 to v5:
> > - Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
> > Change from v3 to v4:
> > - change according to Manivannan's comments.
> >   I hope I have not missed anything. quite long discuss thread
> > Change from v2 to v3:
> > - Basic rewrite whole patch according rob herry suggestion.
> >   put common function into dwc, so more soc can share the same logic.
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++
> >  2 files changed, 123 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 9952057c8819..031e1f9c0d0c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -8,6 +8,7 @@
> >   * Author: Jingoo Han <jg1.han@samsung.com>
> >   */
> >  
> > +#include <linux/iopoll.h>
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/msi.h>
> > @@ -807,3 +808,97 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > +
> > +/*
> > + * This resemble the pci_set_power_state() interfaces, but these are for
> 
> s/interfaces/API
> s/these are/this is
> 
> > + * configuring host controllers, which are bridges *to* PCI devices but
> > + * are not PCI devices themselves.
> > + */
> > +static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
> > +{
> > +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > +	u16 val;
> > +
> > +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> > +	val &= ~PCI_PM_CTRL_STATE_MASK;
> > +	val |= ((u16 __force)dstate) & PCI_PM_CTRL_STATE_MASK;
> 
> Why can't just,
> 
> val |= dstate;

fixed a build warning.

Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

> 
> > +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> > +}
> > +
> > +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > +{
> > +	u8 offset;
> > +	u32 val;
> > +	int ret;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> 
> Just assign this during variable definition itself..

Do you means?
	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> 
> > +	/*
> > +	 * If L1.1\L1.2 enable, devices (such as NVME) want short
> > +	 * resume latency, controller will not enter L2
> 
> "If L1SS is supported, then do not put the link into L2 as some devices such as
> NVMe expect low resume latency."
> 
> > +	 */
> > +	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > +		return 0;
> > +
> > +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > +		return 0;
> > +
> > +	if (!pci->pp.ops->pme_turn_off)
> > +		return -EINVAL;
> 
> Can you just return 0 instead of failing? As per my comment below, if you move
> the D-state change before this callback, then this won't be a hard requirement.
> 
> > +
> > +	pci->pp.ops->pme_turn_off(&pci->pp);
> > +
> > +	/*
> > +	 * PCI Express Base Specification Rev 4.0
> > +	 * 5.3.3.2.1 PME Synchronization
> > +	 * Recommand 1ms to 10ms timeout to check L2 ready
> 
> "Recommends"
> 
> Please use full 80 columns for comments.
> 
> > +	 */
> > +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > +				100, 10000, false, pci);
> > +	if (ret) {
> > +		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> 
> "Timeout waiting for L2 entry! LTSSM: 0x%x\n"
> 
> > +		return ret;
> > +	}
> > +
> > +	dw_pcie_set_dstate(pci, PCI_D3hot);
> 
> This should be done before initiating L2 entry as per
> PCI_Express_Base_Specification 3.0, section 5.2.

This is for root complex bridge, after PCI device and link to L2,
PCI Host can be enter lower power state, I think it is just
borrow 'D3 state' from PCI.

> 
> > +
> > +	pci->suspended = true;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
> > +
> > +int dw_pcie_resume_noirq(struct dw_pcie *pci)
> > +{
> > +	int ret;
> > +
> > +	if (!pci->suspended)
> > +		return 0;
> > +
> > +	pci->suspended = false;
> > +
> > +	dw_pcie_set_dstate(pci, PCI_D0);
> > +
> > +	if (!pci->pp.ops->exit_from_l2)
> > +		return -EINVAL;
> 
> Same comment as above.
> 
> > +
> > +	pci->pp.ops->exit_from_l2(&pci->pp);
> > +
> > +	ret = pci->pp.ops->host_init(&pci->pp);
> 
> I don't see matching host_deinit() in suspend.
> 
> - Mani
> 
> > +	if (ret) {
> > +		dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	dw_pcie_setup_rc(&pci->pp);
> > +
> > +	ret = dw_pcie_start_link(pci);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = dw_pcie_wait_for_link(pci);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 79713ce075cc..effb07a506e4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
> >  	DW_PCIE_NUM_CORE_RSTS
> >  };
> >  
> > +enum dw_pcie_ltssm {
> > +	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
> > +	/* Need align PCIE_PORT_DEBUG0 bit0:5 */
> 
> "Need to align with PCIE_PORT_DEBUG0 bits 0:5".
> 
> - Mani
> 
> > +	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
> > +	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> > +	DW_PCIE_LTSSM_L0 = 0x11,
> > +	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> >  	int (*msi_host_init)(struct dw_pcie_rp *pp);
> > +	void (*pme_turn_off)(struct dw_pcie_rp *pp);
> > +	void (*exit_from_l2)(struct dw_pcie_rp *pp);
> >  };
> >  
> >  struct dw_pcie_rp {
> > @@ -364,6 +375,7 @@ struct dw_pcie_ops {
> >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> >  			      size_t size, u32 val);
> >  	int	(*link_up)(struct dw_pcie *pcie);
> > +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> >  	int	(*start_link)(struct dw_pcie *pcie);
> >  	void	(*stop_link)(struct dw_pcie *pcie);
> >  };
> > @@ -393,6 +405,7 @@ struct dw_pcie {
> >  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> >  	struct gpio_desc		*pe_rst;
> > +	bool			suspended;
> >  };
> >  
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> > @@ -430,6 +443,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
> >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> >  
> > +int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> > +int dw_pcie_resume_noirq(struct dw_pcie *pci);
> > +
> >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> >  {
> >  	dw_pcie_write_dbi(pci, reg, 0x4, val);
> > @@ -501,6 +517,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
> >  		pci->ops->stop_link(pci);
> >  }
> >  
> > +static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +
> > +	if (pci->ops && pci->ops->get_ltssm)
> > +		return pci->ops->get_ltssm(pci);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> > +
> > +	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> > +}
> > +
> >  #ifdef CONFIG_PCIE_DW_HOST
> >  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
> >  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
