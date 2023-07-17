Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB06756C36
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGQSgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGQSgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 14:36:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99182E5;
        Mon, 17 Jul 2023 11:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaHp1TAoScKVHS2T0n3aOEQA22MdBuznCYst5fYiuc7QarAzhh+oWcbkgU0Z1/V5G67OepynC7QZp9EibCrwumt9eNcUtmEB/K71rW8fZr0jaUy0Afbf4NKCjKN4r8jEHQ3bSkqbX6TBRHFMg6nZLa1SFu9B+fkSygnBuhr2vDuSU6I3wI01MaMR1fyvy3l2qyXYBRvE75gQHEc0gvZqrHtBF1E9NVnwQB+iCDxynXt0/aHh7egIaJeSCh0OMrLQlJiVxfDShYHXX0ozUuejKlQq8Fx2PMCwJg+jf6E4xdS4pEfAoPQCgXCLBhzWvSaB8zR+bo0EIFsOAyYp0jUvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/Exr4CBwcQQPFLxTOfk6DCRJh4vSdBTP9udqy71/T0=;
 b=TvaNpbApYRou0avmWLfLwOFR6He+988ycbcuzYIl6/2oK/6tr1hGqS6EyS1TAQUy5wuP8nVbAxKYa7hoqI3ldU0FnNhnc0tL9t7e7gsKrc8lNfbNPuDoDklNXowzFEq9fE5G+42hckrRu+1J5PQUzU6L0eYCL4Q80GkaTplEDfDD8dk04ODmuOc/3/W/aQffLaoo/2vc+pJePV09mFyXxce049d3Sy4Oixv9ejc8qzK70avgzHl5f5hCUSQlKe7blhruvJuKZTd5pjBC2ykWOhIwnfUelb9TNtPZOy9H11U9MwpcMW7QfeW8/FBYepJhurPjHuifS5u9ugaX29QJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/Exr4CBwcQQPFLxTOfk6DCRJh4vSdBTP9udqy71/T0=;
 b=FKRsQ7U1FMHIoAaudc2TEqnnEpGpcZHorw/WKKO1es4LuylEqcQMgHPVfQ4/m/iF+IMt1H9gOP/+8kUXuL6KaQsCgaCosoaA8+jfUIJ1QuLov/VWeKJFCALPxN1uo1W6vSNyqQIJz/GjEdG4vbR3k1dOjoYaSuPUeZpLAUifAWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:36:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:36:33 +0000
Date:   Mon, 17 Jul 2023 14:36:19 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717164526.GC35455@thinkpad>
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: c681b8a5-b743-43c3-296e-08db86f4be5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mAdSNZ125wzMJ5SkiBCmUeS8KltMCOlVn9gJJHMvNNNDSyelGFrhd0obCtawD09s7AnF3xTTrdjBMtWjJb2IPrSZZUnE7AbbW4oC4Crs04wGFXhaaGtaeOdoLgBptTw20I6zdHKC1ljXOctAHS/ZfFycdWXd7CxDUwGGyHEfoNXX0a8KiXn/BsIJOcRlFpgCtfRL/04oWyYy2TtxU8E/muT15mNkwSpUHAmE4x1+KLO4FawGm6hxHUm1TePOLBaHF2rTrlayVNSye1JDoi6QToRkzfZbp2Dkmli4TUUW6iwANZ1LLSPyxrZqXmCP2vUMKJKPaHO5tBx+h9zt28E0miS/x5G+Vy/tWBOGJAG07xIG52zKSzSPpBH5fjZMmZu3LFj/9HiAiRep74DoXMHz7cYqT/j0XP0Jf9aAQ/5kXq8jXhkkNaNf7TKzGinlKaPqr4YKRA/at1LV1EU/y0bC8zm15SueoDof4Vy4qoxkn4CRLrR9o0RwQHVbut3CzsFfHgdIecVkuSXWnww8h//ZBVNbiSWQYZX74RecCnvWS3MyPVTuB8rfIV3JtRaHAKJUBMdm4bIL9yGknbGh4nltslLz2lCACdbZNobuc9x/caYG3RsoPC+ElTaOt9aP8cw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(7416002)(86362001)(2906002)(33716001)(15650500001)(6512007)(186003)(83380400001)(26005)(9686003)(6506007)(38100700002)(38350700002)(6666004)(52116002)(6486002)(8936002)(6916009)(66946007)(66556008)(66476007)(316002)(4326008)(41300700001)(478600001)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RQYnJuR2hHWk5hM0w1bGlqQ25JNUxsZUJsdDhGTFFXZXZmTXBQZFdGWWo3?=
 =?utf-8?B?cjZKTXQ5L1QvbzRHeVBhVm1xaFdDb0ZJM2MyUklRdU5sc2xncmhWRy9jOVhE?=
 =?utf-8?B?L0h2NnpHRGgvZnVreml3RTh5cG9ycGZyRGx4d2ZQOWRmTlMxV3dWaElYbjZw?=
 =?utf-8?B?ZDhFUHZ2K0VrZFlHTTY1Wm5EanNmeFJtWU5KTVllaVM1Y2xIZHNYNlFFVDBl?=
 =?utf-8?B?UnBEWEdINVkwMHBnYkptV0ZRZmVJajRLbWZ2SjRmUUMwcDJzY3dnS2toR3RO?=
 =?utf-8?B?aGZ3c2k1MEJvWEJSVTN6K3d5RzBGZXlxNDBRZ2I5dFp2cW1TVmlFUFNmSGFL?=
 =?utf-8?B?MTZtbTlOLzM0VlFqRDRyV2R3UXIxYjJUWTZnbThGZC8wVWIxZ3pLaHUzaEtz?=
 =?utf-8?B?NGVYcnVWa2NCVVBMZFpWMjFYRkFSR2dNZVc1MWFUNFAxSTFYdUZBaENVOFB3?=
 =?utf-8?B?ajFraTBCdHRqSkpEeVQwWGhKeXY3dTMreGlqa1lYN0N2SzNadXZvMy9NT28z?=
 =?utf-8?B?aHpreVM0SXkyZlIzZDRTNElUZG95ajgwMFRkazdJU29XWVA5SGJzcUhlMEx1?=
 =?utf-8?B?czlDeURDNFYzSDJYcjRIeU9tRGZ6UlM5dnFITk9uR1dmaGo3bGQ3N0hzZ1pS?=
 =?utf-8?B?MzQzQ0FDd3hIQ3haNHVhOXVnVndQMlZuc3RWYTRxRWtpRWJBSU53UjVCTlkw?=
 =?utf-8?B?dDBnUkh3a1pOVjA2V0srczQxTmlLZWFJVGR5bHUrQit2c1pXWmVRR0ZnYTMr?=
 =?utf-8?B?dU9OVUg0ZmlISkhnbWtCZUtzeTZGaE4wdUFrTUU4Q2tOV3VJWW1kMlQ0TU1l?=
 =?utf-8?B?Uk5tbFg4S1NnenAzYU1SL1JXQ0FjMURzd0FCYjV5TjBvQ3hqcVYrOHZ2TkdX?=
 =?utf-8?B?eGdEVTRkenVmNUxZRjQ4L1NxUDFzOWd4eG85SS8yN3d1TkE3MUU1djluY0xo?=
 =?utf-8?B?UHNaVnNacHhGOGI0L3ZqdXBoOEtQamRkWldMWW9xRExsOEh0YTNJdXZDckRU?=
 =?utf-8?B?V3Z6cWwrczlzY3pTYmM3S0RuTHlsV29vdTh2c2tVY2dKZi8vbHcrZHRPVWVD?=
 =?utf-8?B?VEVQUG5rOHVmTDJwcTZkWURNaXpmcTd1b3NlWU5RT2ZucytWN2tJYVlPR0Zy?=
 =?utf-8?B?QVNBVC9PQWZpeTdEK2p2NkNGZXNGU3FodklJdEJTcjJWYmpWR2tuYnowWXhq?=
 =?utf-8?B?d2lMV0diZ3paMU9VSmhOSXBvYmY1MzJVZWx5d2F5UnQydHQzeHphaGZHb3Y5?=
 =?utf-8?B?U3JvTk1tUTcyYnJEOTZwMlFtL2JIUTVyQm1MOG9mZHQ1TzRrdDlkNmVoUEZQ?=
 =?utf-8?B?WW9rR1lnWTNBOFo5TzNiYWhsM1F0Rzd3eWcrSi9vSUw0RHRjbEFzRjJIN0Y5?=
 =?utf-8?B?SGYza0lZVkpyWWozZ0p0Uzg1R2tHelZ5dTdrcHE4TFhvY21ra2pWeC9qZm9u?=
 =?utf-8?B?ald3OGtXaTFmNTNOUDdCU3BTYUFHb21wL0JRNG1qQnFERmZQb1VOS0s4K1kw?=
 =?utf-8?B?b2cwS0VIakNsQTZzdHl4Ti9yUXViMDBpYUx4MDM2dlRSK2Q1aGNTeXlBOU1R?=
 =?utf-8?B?RTJrRC8xS3dZM0VqRWJtbDFOS0dYcUFCaUI5M1oycERlQk1GVXpzNVJMNjRV?=
 =?utf-8?B?ZEg4NW9SenZNYURQZkRZYzZMV0dMK1JUcm1WdWtIVzE2WTJBVU5PaDVZaW1v?=
 =?utf-8?B?bW80a3dPbVpkUUkrMlhYQUV5c0dtK3RhUGoxQkdPYmp5T2NCdDUwazVmVTdK?=
 =?utf-8?B?Y3pxOGVLbWd5aCtDU0xhTHg5ZmZ2TGs5ditBeTdZdU9velRBRmpxeEd3SWc0?=
 =?utf-8?B?dHNzdTNXVy80ZmFwRSs1T2dMcUN6dXY5S1dkYVlBeXJVbGYwMFVHOXNrWWI2?=
 =?utf-8?B?dXhRcjJhd0lpOGxMRXhGT0wwNEMybXpMamtiZzNCeU1Lb0NidnZQeWplc2hB?=
 =?utf-8?B?Z1NFVjVZWEVLcDFyYVJBc2t0TTcrUzIwNS8xc0YwMjZYTDlYMTRHZW9QU21O?=
 =?utf-8?B?ei9KRUFJOUtnYUlwV1Y2K21RK0d3ckNQVmxVL2RlQlpwT05DMGh4dkduK2pq?=
 =?utf-8?B?WU5BV00va0VsZ2JvYUJld1RrZ0pob1JlZGo2T2NkM1ZiZ0tyWElBV01Xdmli?=
 =?utf-8?Q?GxKM2ud+ozuC9x59MWhOqFPoz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c681b8a5-b743-43c3-296e-08db86f4be5a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:36:32.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxmRiGu7MliC5v57Hc03k7x3qZyeACg3vV0IDepLEJC64cr2ag3+pPNE/lLbBlfBZVkEZSjr7ZKCT7FBIob9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > 
> > Typical L2 entry workflow:
> > 
> > 1. Transmit PME turn off signal to PCI devices.
> > 2. Await link entering L2_IDLE state.
> 
> AFAIK, typical workflow is to wait for PME_To_Ack.

1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
I think PCI RC needs some time to set link enter L2 after get ACK from
PME.

> 
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
> > Change from v2 to v3: 
> > - Basic rewrite whole patch according rob herry suggestion. 
> >   put common function into dwc, so more soc can share the same logic.
> >   
> >  .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
> >  2 files changed, 108 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 9952057c8819..ef6869488bde 100644
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
> > @@ -807,3 +808,82 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > +
> > +/*
> > + * There are for configuring host controllers, which are bridges *to* PCI devices
> > + * but are not PCI devices themselves.
> 
> None of the functions applicable to the devices. So there is no need for this
> comment.

I copy comments in drivers/pci/controller/dwc/pcie-designware.c.

/*
 * These interfaces resemble the pci_find_*capability() interfaces, but these
 * are for configuring host controllers, which are bridges *to* PCI devices but
 * are not PCI devices themselves.
 */
static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
                                  u8 cap)


I think it is reasonalble because it is too similar with standard API
pci_set_power_state();

> 
> > + */
> > +static void dw_pcie_set_dstate(struct dw_pcie *pci, u32 dstate)
> 
> Please use pci_power_t defines for dstates.

Although dwc use the same define, it is difference things. 

> 
> > +{
> > +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > +	u32 val;
> > +
> > +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> 
> Please use PCI accessors for accessing spec compliant registers.

According to comments in pcie-designware.c, it is difference concept
even though register define is the same as PCI spec. It was used to
control root bridges.

> 
> > +	val &= ~PCI_PM_CTRL_STATE_MASK;
> > +	val |= dstate;
> > +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> > +}
> > +
> > +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +	int ret;
> > +
> > +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > +		return 0;
> > +
> > +	pci->pp.ops->pme_turn_off(&pci->pp);
> 
> You should first check for the existence of the callback before invoking. This
> applies to all callbacks in this patch.

Yes, I will update.

> 
> > +
> > +	/*
> > +	 * PCI Express Base Specification Rev 4.0
> > +	 * 5.3.3.2.1 PME Synchronization
> > +	 * Recommand 1ms to 10ms timeout to check L2 ready
> > +	 */
> > +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > +				100, 10000, false, pci);
> 
> Is there no way to wait for PME_To_Ack TLP?


Suppose PME_turn_off should wait for ACK before return. 
Here, just make sure Link enter L2 status. Hardware need some time to put
link to L2 after get ACK from bus, even it is very short generally.

> 
> > +	if (ret) {
> > +		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> > +		return ret;
> > +	}
> > +
> > +	dw_pcie_set_dstate(pci, 0x3);
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
> > +	dw_pcie_set_dstate(pci, 0x0);
> > +
> > +	pci->pp.ops->exit_from_l2(&pci->pp);
> > +
> > +	/* delay 10 ms to access EP */
> 
> Is this delay as part of the DWC spec? If so, please quote the section.
> 
> > +	mdelay(10);
> > +
> > +	ret = pci->pp.ops->host_init(&pci->pp);
> > +	if (ret) {
> > +		dev_err(pci->dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
> 
> s/ls_pcie_host_init/Host init
> 
> > +		return ret;
> > +	}
> > +
> > +	dw_pcie_setup_rc(&pci->pp);
> > +
> 
> Don't you need to configure iATU?
> 
> > +	ret = dw_pcie_wait_for_link(pci);
> 
> Don't you need to start the link beforehand?

Suppose need start link, it works at layerscape platform just because dwc
have not full power off. some state still kept.

> 
> > +	if (ret) {
> > +		dev_err(pci->dev, "wait link up timeout! ret = 0x%x\n", ret);
> 
> dw_pcie_wait_for_link() itself prints error message on failure. So no need to do
> the same here.

Okay

> 
> - Mani
> 
> > +		return ret;
> > +	}
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
