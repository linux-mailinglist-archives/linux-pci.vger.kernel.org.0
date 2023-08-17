Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89A780136
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355813AbjHQWnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 18:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355817AbjHQWnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 18:43:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0226B6;
        Thu, 17 Aug 2023 15:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPQ1GaV2ZEf1OSZdZ/gNm9EZ1rt1k/kBNjkYgVj5n4CI1dCuQiGRZbqm5boZyFHGGJ5f8B5kmrg3gWH6XHHmq15nAIudC7G1xVwRkvv6bCyfrHQc0kDDCJFkFLkWNqk6Fb6YJxHTlLvIfPK3RaVM59jGr3pKt+tHDEORkQrUfTSFZzJ6orK04m1vih6BSpIJDf8kS3zXZ2Egta/bl7QkjqbGF9+FlhQrbHyowdEWM0H8LpVej6cggFl5QM69GLu6F5Eq9ijaKrZhsk0Z/pB2QEJnoNYx5z0d6XdZjHO6ml32zRaUaIc2Mc+6X+/lYP3vOkQTwgSRxPSRjSorexDHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TvfivQbpGm7vNLjt+APDhQM0khBO8KZWfnXptWtQO4=;
 b=Zzmuhz47HMjg/+jfbKCHDJaALyx7ysizZYhFcv2k3nrFy46qhp5DXfMDM3QNlsSfmOMPiVP8sELD88B/8y530fF0PRopFDJ01rHkzY6Yjuvf9r09J8RSJDZg04awbvB5GPxlAclcrK1l0O2XGESMJFxd/FdCpaVRtR5Bpz5tqVL4w8XjWEnNMW7FpVUr2VAKqiugrzjmBMuEb1AI5PMtufv2W8Xnc9hDq56c+DNOrSZRharyll7WZ69iPrYDMmDxtyoT5DOl/BYwlqXFMQh5zCniwT9YFXiuYsSE/SU7stsNd1BSz/mavdGVSR1J9Pr2CgmSFjOupauU81CxYA/B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TvfivQbpGm7vNLjt+APDhQM0khBO8KZWfnXptWtQO4=;
 b=grOjPU2Y2SlgpxUMC/aDXU3nOgMToJCPIzF49yAbKvhinoDNxbu4gKO1hdadTvZ1jRe05fGCVmo1QNHYjcBQ0WDu0lXkEhdX0bTS1blJiMOjvrs6yU5HlqQyKowbpFCQlrHQ/bsUs3vuCidNjhXjIcmwvlq+P0UrwF21mFZUNI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 22:43:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 22:43:08 +0000
Date:   Thu, 17 Aug 2023 18:42:50 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     helgaas@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v11 3/3] PCI: layerscape: Add power management support
 for ls1028a
Message-ID: <ZN6iarqhryMHmwLh@lizhi-Precision-Tower-5810>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
 <20230809153540.834653-4-Frank.Li@nxp.com>
 <ZNzrgr3a13vm6Yqi@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNzrgr3a13vm6Yqi@lpieralisi>
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 12731747-d12b-4e8a-13fc-08db9f735413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OV9FPnTRDhYMVMkpeqpVfS8H6pqT8DtziSfoVjagfCQHl9KKjd2N3U4RChdOLuhTwkGEODYrpfEZl3L3x2lRPov9ZDLOoYP3NzcApNvOrZnf+dk1EdymXIcBt+arFPMMB7t/9y6Ivc7lQ+E6kw4mbPGp4QdHTXcDCfdPDiEPF1nhJ6rzQqtrd07mfx/e9aAGBLjWLwSafipB8+x5pPcyGB5iPE0lBasiLux5gS+gjzOBJltaqrNxQ40yn4VxXEaHgCGde6lNyAmXoKLqm+HF1CaYa8stEzdtYG1KSfJddFaxlrC96gpmDoOfQpuXqdSKyHzQ9Oc4fCclARdN6J7Lyj+CRDpAFGHIu8UssabpCvy+ZC94U6gshTNqmueX+iUX7emVgfOm1vllnvaI1lty41v6i/3fOKsiPAvm/uoYw6yjCiN3iQeVPYyNC1fWqoyqFkK4h3ErwsikWEcBVmKhpZ+0Utout3lZ2K5hoUB3e4G5mazk8qfyd9COSt16yhvuZU1jr2Wv5rS+uWiHOIQmOR6iiQBe9qNflmF/m39Wb/3xz+P9NsU63CCUq9miFshHNGaVxD9XqvyjzAIwf/hT0OgMniAqYAbyFTc6vF7yxiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(66556008)(66946007)(66476007)(2906002)(5660300002)(41300700001)(316002)(6916009)(7416002)(8936002)(478600001)(8676002)(4326008)(6512007)(6666004)(52116002)(6486002)(9686003)(6506007)(83380400001)(33716001)(86362001)(38100700002)(38350700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z//SKEjmip1/cVJTxx4h9vZg2R7H8QpthvofhlpVIUwN2elJYK5m48HoRI3w?=
 =?us-ascii?Q?4OfE0FdeT+3Pe3vj2GuENGU6uyrK5558fu1HWLoMrYnlRTgOAyYTnhnHWi//?=
 =?us-ascii?Q?00oZyl9JJTaK+dYpPxJSmcfuYqjvsZ4L70+v3tdUxDFxgFMlHsQPjbRacXu2?=
 =?us-ascii?Q?v1mhkyrx886ye+pOcsRdjS9LDOuiXNGz8SVm06LHK4use34ULP719pISSGgj?=
 =?us-ascii?Q?xqCPQDHmCxGfvzI/EUYq4XZJpahpLBLSY9r/q+nshei8T6zSXnhDP6ZkdT64?=
 =?us-ascii?Q?VApgzdu8mFHL+gqBQss62jEHWIGM2DsuTlfz1dKb1bnH68GytqkzUJFj8ev3?=
 =?us-ascii?Q?V24keYi607vSIRTQbCY7CT38cxNiEBpwA+F84DtCzQxihFOn/NSRPOBhxbAG?=
 =?us-ascii?Q?u85hua6d7gBhf17d6EESvIdwwlZ3MqL0FUp4YRHtiTm8JgHot5TT1oeY0Hno?=
 =?us-ascii?Q?Ph+eBaNYrqX/ojZNwJtzN6qo3RrxF5W3zBGeNRhv7hlYke4gQQNXx5ab6QXy?=
 =?us-ascii?Q?EHzJn0Da0H9JO8o8FCG7LliL3Axe5+OBVE+sxx3AHdohptXsegf+r8FcrDSo?=
 =?us-ascii?Q?1xZzVS2Rq9cPQ+IHtNDyA9m3ktMHsocNKLTfvMIzrIxSSKrSzX8na7DUqsH6?=
 =?us-ascii?Q?3ej4dQDxlxOtxq4YJd/UQExzzNWNEDfhEgJINMx9vgNt7qAvkCDzkMceycYY?=
 =?us-ascii?Q?Wse7cTNALsYbCrvgDj4Xhv3Q2PjNBdZiSXKM+qV0t2N0qBhQ582XvMDCPARf?=
 =?us-ascii?Q?dthwqWWcr74nk186YKcwwpCZQadW6zk/b2JJ3N5ZrEHx61E4sHI4td2AxQse?=
 =?us-ascii?Q?x7yCOnI6Y44JKMe9+aVC2NG6RiPkJ0B/ygrMDIhtHk63Pyb0sOKUzwD1hsBi?=
 =?us-ascii?Q?QIYt3ZFoH/6ok2bU7zB+Qn4BQ05eXg5Nn1X7Z0PZvCb+AkuAtGcg0OouF/KE?=
 =?us-ascii?Q?1+p3ZN3ljHUJJhQBmBqloEhGO+Y4JJ/ng60RBgJSXjXUomzBiaIoiYzKtz1T?=
 =?us-ascii?Q?0wXveu6sZu5qGClhoIraivPGswWYYOhubP22+mgH/he4RcSiGmIaRLOfnCJp?=
 =?us-ascii?Q?SSyO0TTM/qsN+t3xvs6pzdfH0gFXuteOmq1zGpKIMZ/l2uUAngEuiEFannHm?=
 =?us-ascii?Q?Wn+mMhlVStg26pKHKg58vfjpXe3W5DUr/u7Cbpkd7YW7W4cmmlcnxgNrWQo7?=
 =?us-ascii?Q?3QkgQdC59tNIdZ4g8sqnern3FFvk9XEiuCaqh3FAK7qQGhU+3wpptTJebdqu?=
 =?us-ascii?Q?mpp3tK7Khg4oLOk4jJKegQdcNdTswPW1ilPfeu1DPmFafmyWDSlkNwdkwO+/?=
 =?us-ascii?Q?0lE7PQiQ9vn73lsKDJZiirI7+0jteIFp+FMvMMAObsGWM54EOYEqUUCsfKrE?=
 =?us-ascii?Q?qrjaVKThI1KqHyh+nUHGv+Xho8+QoHKrVXD7NyFtnkZaSnLImhM9dFRaR+7R?=
 =?us-ascii?Q?xIDlom3Lt+KYJuWtyFQQLCpYlJu8rTxgnloNwYhzqF+n6Z7BCJZKO406Csab?=
 =?us-ascii?Q?alxCcZusjy14K0VVocEqyXtklh36B9cTxAG5oG1XynzGnk/Npx8ZuMIhWQ2G?=
 =?us-ascii?Q?l9E/rFTQ23uSmgPTtfE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12731747-d12b-4e8a-13fc-08db9f735413
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:43:08.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTizbBaCrVGkNtAIeFcvBjTldIkVBvO+W5Eu2N6lKXRTdeCMa1LDFdg7O8V4H2w20aEmER2Oh9B2FabGebgKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 05:30:10PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Aug 09, 2023 at 11:35:40AM -0400, Frank Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
> > common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
> > suspend state.
> > 
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-layerscape.c | 130 ++++++++++++++++++--
> >  1 file changed, 121 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index ed5fb492fe084..b49f654335fd7 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -8,9 +8,11 @@
> >   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/kernel.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_address.h>
> > @@ -20,6 +22,7 @@
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/regmap.h>
> >  
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >  
> >  /* PEX Internal Configuration Registers */
> > @@ -27,12 +30,26 @@
> >  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> >  #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
> >  
> > +/* PF Message Command Register */
> > +#define LS_PCIE_PF_MCR		0x2c
> > +#define PF_MCR_PTOMR		BIT(0)
> > +#define PF_MCR_EXL2S		BIT(1)
> > +
> >  #define PCIE_IATU_NUM		6
> >  
> > +struct ls_pcie_drvdata {
> > +	const u32 pf_off;
> > +	bool pm_support;
> > +};
> > +
> >  struct ls_pcie {
> >  	struct dw_pcie *pci;
> > +	const struct ls_pcie_drvdata *drvdata;
> > +	void __iomem *pf_base;
> > +	bool big_endian;
> >  };
> >  
> > +#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
> >  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> >  
> >  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> > @@ -73,6 +90,60 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> >  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> >  }
> >  
> > +static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> > +{
> > +	if (pcie->big_endian)
> > +		return ioread32be(pcie->pf_base + off);
> > +
> > +	return ioread32(pcie->pf_base + off);
> > +}
> > +
> > +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> > +{
> > +	if (pcie->big_endian)
> > +		iowrite32be(val, pcie->pf_base + off);
> > +	else
> > +		iowrite32(val, pcie->pf_base + off);
> > +}
> > +
> > +static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > +	u32 val;
> > +	int ret;
> > +
> > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > +	val |= PF_MCR_PTOMR;
> > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > +
> > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > +				 val, !(val & PF_MCR_PTOMR),
> > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret)
> > +		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
> > +}
> > +
> > +static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > +	u32 val;
> > +	int ret;
> > +
> > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > +	val |= PF_MCR_EXL2S;
> > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> 
> What is this write transaction generating in HW ?

I don't think send anything to to pci bus because it was called before
host init.

The spec of ls1028 is not clear enough.

`EXL2S: exit l2 state command. when set to 1, an L2 exit command is
generated. The bit is self clearing. Once the bit is set. SW needs to wait
for the bit to selfclear before sending a new command'

> 
> Why is it needed ? Shouldn't L2 exit happen automatically
> in HW ?

I tried remove this, PCI can't resume. I think this is specific for ls1028
chip to clear internal logic.

> 
> > +
> > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > +				 val, !(val & PF_MCR_EXL2S),
> > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > +			PCIE_PME_TO_L2_TIMEOUT_US);
> 
> And why is the timeout value the same used for the PME_turn_off message ?

I think No spec define it, just reused it. use PCIE_PME_TO_L2_TIMEOUT_US
may cause confuse. What's do you prefered? Just use number,such as 10ms.

> 
> Thanks,
> Lorenzo
> 
> > +	if (ret)
> > +		dev_err(pcie->pci->dev, "L2 exit timeout\n");
> > +}
> > +
> >  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -91,18 +162,28 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> >  	.host_init = ls_pcie_host_init,
> > +	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > +	.exit_from_l2 = ls_pcie_exit_from_l2,
> > +};
> > +
> > +static const struct ls_pcie_drvdata ls1021a_drvdata = {
> > +};
> > +
> > +static const struct ls_pcie_drvdata layerscape_drvdata = {
> > +	.pf_off = 0xc0000,
> > +	.pm_support = true,
> >  };
> >  
> >  static const struct of_device_id ls_pcie_of_match[] = {
> > -	{ .compatible = "fsl,ls1012a-pcie", },
> > -	{ .compatible = "fsl,ls1021a-pcie", },
> > -	{ .compatible = "fsl,ls1028a-pcie", },
> > -	{ .compatible = "fsl,ls1043a-pcie", },
> > -	{ .compatible = "fsl,ls1046a-pcie", },
> > -	{ .compatible = "fsl,ls2080a-pcie", },
> > -	{ .compatible = "fsl,ls2085a-pcie", },
> > -	{ .compatible = "fsl,ls2088a-pcie", },
> > -	{ .compatible = "fsl,ls1088a-pcie", },
> > +	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
> > +	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> > +	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
> > +	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
> >  	{ },
> >  };
> >  
> > @@ -121,6 +202,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
> >  	if (!pci)
> >  		return -ENOMEM;
> >  
> > +	pcie->drvdata = of_device_get_match_data(dev);
> > +
> >  	pci->dev = dev;
> >  	pci->pp.ops = &ls_pcie_host_ops;
> >  
> > @@ -131,6 +214,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pci->dbi_base))
> >  		return PTR_ERR(pci->dbi_base);
> >  
> > +	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> > +
> > +	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> > +
> >  	if (!ls_pcie_is_bridge(pcie))
> >  		return -ENODEV;
> >  
> > @@ -139,12 +226,37 @@ static int ls_pcie_probe(struct platform_device *pdev)
> >  	return dw_pcie_host_init(&pci->pp);
> >  }
> >  
> > +static int ls_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	if (!pcie->drvdata->pm_support)
> > +		return 0;
> > +
> > +	return dw_pcie_suspend_noirq(pcie->pci);
> > +}
> > +
> > +static int ls_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	if (!pcie->drvdata->pm_support)
> > +		return 0;
> > +
> > +	return dw_pcie_resume_noirq(pcie->pci);
> > +}
> > +
> > +static const struct dev_pm_ops ls_pcie_pm_ops = {
> > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
> > +};
> > +
> >  static struct platform_driver ls_pcie_driver = {
> >  	.probe = ls_pcie_probe,
> >  	.driver = {
> >  		.name = "layerscape-pcie",
> >  		.of_match_table = ls_pcie_of_match,
> >  		.suppress_bind_attrs = true,
> > +		.pm = &ls_pcie_pm_ops,
> >  	},
> >  };
> >  builtin_platform_driver(ls_pcie_driver);
> > -- 
> > 2.34.1
> > 
