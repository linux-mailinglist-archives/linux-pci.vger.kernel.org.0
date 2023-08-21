Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A356782D27
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHUPYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjHUPYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 11:24:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8619E9;
        Mon, 21 Aug 2023 08:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py/KNI4NG6jN5dcTqahwhwFhjAV1uepROtXC6jMrXtS1gmGyX/p2+QwS+WSzvvm9vDL0WF8VsuFftI0pZC1DKtejUP9EAM9tmH2nFPV8wkEnMRKr5mZNxe0N44FTmM24cYCPKiDT0raE02zC6J3KxaXkD2cymP89oRHTzfDHlyerTWJrKrKwojze3aE9kyz341AP7+PIFmOMaTgV0gYEUvrgLEVSiFlv0eRFs10OViyMvOHNpsGoE8oehPZKuEKJeGOv3o/zrG4hnAX2iTU2X5SkFey/See1aMFIe14PvO7qTt3aW4g8QTvKNRsm37f7na35dUbmlPRptvH26eOBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwCFeABb07X7XRPAri9widF2bfVqybF848zEJt9DQ0M=;
 b=AO+ZQL5bbaQMguCAOYz7/fHbzxzEG6TRIWcz8HMuVPQRn9sQKIleosC/bfpXSZbATrLMkNlW+QrEIKbQeaQ6bYgulJEDeMImIONfLAOxtzrZmOLt6y1UQ3BafU+rKlQynTuxZ2hanJvrD3jZsPI8wQljP4LZRn7WQSiD2dAdsGnaLluXzMWM9SC1mVJNLlWqUVcXB625+OPna9AlxSNMU7vl8W7JNRb94XNx5omnXvYN4Yo44HUUOksXwAS9wsAlNgwYb+c42CWjecx5DYN0BWPML1O8DSjaO04q5m8dHLeM6yhjlc7h1nYG0fEOQf0DaWIGErq+PGDck9StngF6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwCFeABb07X7XRPAri9widF2bfVqybF848zEJt9DQ0M=;
 b=D0rfnTr5DCvkbiWe54zKCBax5KRcwkHGsWq9G3zZkaqKV6nuF0BCoUTUJZKpLdyKLFqdebbeR5KLodDOKxlBGQ4HlvkBLI0jlXjOgSJLquhIqbk9v+47v1Dpncc5RPnBlKtVCBTFMhQJW1bTaYvrJUlUIxgHSz69lMmOQ7CBnU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:24:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 15:24:01 +0000
Date:   Mon, 21 Aug 2023 11:23:42 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v11 3/3] PCI: layerscape: Add power management support
 for ls1028a
Message-ID: <ZOOAUlPEMWG4LrUI@lizhi-Precision-Tower-5810>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
 <20230809153540.834653-4-Frank.Li@nxp.com>
 <ZNzrgr3a13vm6Yqi@lpieralisi>
 <ZN6iarqhryMHmwLh@lizhi-Precision-Tower-5810>
 <ZOMecaueyN3cutUH@lpieralisi>
 <20230821103357.GA36455@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821103357.GA36455@thinkpad>
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: bace7f2d-cbd2-4d3e-e1af-08dba25aa58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lN1v5sGJAHylZTLdev8dqy+VlCeffVQJKNSuilO/BY5wcmD/o9J2bLzTaowCk+8szWcOqHucv855s8/hlHErQmq98M/fyxt/g6xABkyn8Lsg0xIOcbMnb6wr+s4FNkoztRjpHHYSoj0fLNaNldnDfU1LEu33+xbTHMauI18JCapNgPe6h6keIgc8FDNBTor7IEYxDAWTASJkh1WpsetRZxv83lGB9RSLd/szFroy5Fn2bzE7Ar9uriwpisVk4rVqrYoIeAO5LIL8xt2LdzaEdFT4/jMSRkw7ZgnXS5PhbxsijucfEHjdHONSQaQkmf6EQxUD3BAOqa2WYeLPhdQ9U9ecTIGWB/PJboD0zZDkabzT8nl+DKn3LNHqmaVnw+4ufH6zMQPWCHHiOuXOPtvhIj1TIjTWLyK7tTvYyYa/9MVM9xvAbHEn114p0lM65K9oxy8CV782M6/1t79Hp8L3aoxnI2K+0vur+lrcsXiE0R4BtZtNQEQ8sWKSgF8btUAGPRMYTz/PJZhH855rVjscpaEiZIY7/IkXU7ckW1fpL9UJAuwRAFF4T0mrlTGYe4ByjwfmvVkArQyrstVjy8I0f5h0dnVDnHDWiPTnwKZ0T7LCcDhGQ1O6UvmW1Dw6avHa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ExTFd0Z1VXMzBocTZ5Mmx4UUFwV0dlbkxaN0djd3k2eFJTaUhtRU9QUkRP?=
 =?utf-8?B?Y1JvZzZtVlFWcDltYVl0azV5dEd6TE9leXhtcHpDUWdqTkxzcU5Bb0wxbjBT?=
 =?utf-8?B?Q1dtVUJjOUdERTZraDIwNGg3UFY3dWlVRmVaaHpRZVFpSzdzS2xvVThMc1BH?=
 =?utf-8?B?U3g5L29LL1dub2N0enJmcktPcHpkVjlITXVLcXdadG5ZRFltcWdPZTlXMUpR?=
 =?utf-8?B?dHgyZUpSOTIvdTh0R1VUTzl4ZDU5aEhsMzl2QWNzZThuSXlFOUF6ZVNhK281?=
 =?utf-8?B?MFNudjBERzhmRTVDbXB1c2RyTThqcmREdmVBOFhOd2lFUjFaNldLaXRYeFg3?=
 =?utf-8?B?Uzg2QVd5Q3BxQ1pEZlVRdUlEMXBqSHBlbjdIVVFYOVJidDV5aDhQdE5UU3dV?=
 =?utf-8?B?aWJrOEFTaG4zN3hwTkRJcVNtMlFIMjMzRk1HQlZFWmN2Ymc4M2VRRW82ZUxF?=
 =?utf-8?B?aHMxRVVJSC9yZk0vYzdwcUxMdTVJa3p6WGRxbnl4WnlxQ0ZLZU9DcGJiL0R5?=
 =?utf-8?B?blNneEMxcGw0QktZbzhNRW9iU0VzcTNTVHE4cmVLcTF1NHA3TXoyMEsyUy9v?=
 =?utf-8?B?T0FYb1BTSGswdjVYZjBCMURvL3FYaUtML085L1lBNEhRNDZVV2Y3L0hQdnYw?=
 =?utf-8?B?Sk5meEdkUWJyK29MRThYN3dOSXlqdHp4eTJLdVpuNjhVWFMrTHFzV0FvQXlu?=
 =?utf-8?B?bk1sUVJyRDVjSjJyMlI2eS9KZHdWNml6Qit6K3BHUVJybzN3M0M1RG1yUGIv?=
 =?utf-8?B?SU9hS1BvWkJzTzBuNDFkVjhtZCtkd0FvOXZGc1B1R3R2ME5lWGIzek9NTllW?=
 =?utf-8?B?NkZWejlTbnJoRTc0WWhZNGwzaU56L01GMEdUVkZwcXJNd2VaaVpZSkgrcS9M?=
 =?utf-8?B?dFJESzg1Rm1hWEIxc0dndWRVaWNWSVljQTlUSlU2WFdSY2pDYTlNTVVPVU1H?=
 =?utf-8?B?cTVKNEJlakxaZ3pyaWZNazhvL1V6UUZSS09GanFqRUJYVDJ4U204VXhXeDFw?=
 =?utf-8?B?Y2h1ODZ4cGpGU1pOdmZHS0dpQXBQU0VBc3JULzZxSGxXMCtmeWhNUnRIY0NE?=
 =?utf-8?B?WjNHVzRxeHlSRjRBRlJtczFKTm1KQnpVWDhKYXl4MkdGOWZtSEdRaytOL2lG?=
 =?utf-8?B?akxzQ3pJTENhUGRNTEFuUW40N29SRnVHWVV3Mkw2L1Mva1lBK1d5RXByR3g3?=
 =?utf-8?B?OGlReldZMnRzWkdiWHg2eTQ3UHJCdm1iSGt1M2d5WXl6QVV2SFFTajhkKzBW?=
 =?utf-8?B?NXErZys3Q3ZjNTNkcTFyVExsNTJidHBOMjJzTzNsUUo5TzY4eHZWSzFTTWZk?=
 =?utf-8?B?MmptSGVuWVVsazhuOWNnUTFlZkFIVWh0UVl5Vmw0eEdWQmVMUVZGRVp0RGRF?=
 =?utf-8?B?SHRQdzBBWE0zMS9meUoyL3Q4NWNhVGdxeHNLQXByQldDMTNDSWorWXBWYmlj?=
 =?utf-8?B?MDZobnJvRGsxUXJEQlMxcndWeW9GM3JjL3BLS2tldHdOWk5Bbk9RZUZKMHFx?=
 =?utf-8?B?cTN4TDNpMTVTb1ZueVUwczhCaURDdGNOUkx3dHIwWlpLc05FMHhHc1RjcGx2?=
 =?utf-8?B?NHdrMHVobG5ScUt1VGRqS09YbXI0di9tOElHYWpJZzM0ekpjTERvNjFNWjV3?=
 =?utf-8?B?d1RTcm1ub21qUER4Unc1U1orOTc5ZmczUFZzd0FRRkFGYUM3T1dXd3pVQnRi?=
 =?utf-8?B?dS9abXBNdjhEbm5lMVQyVFM5cVBoSnlFeU9vRnQzdGE5UU5mUDJTNW5ORGRY?=
 =?utf-8?B?Y2RNOURVTVJYZVZmMmsyUUx5Ynp3U0UxaHZoQnVjekFaNHFMZU5KTXZXalRk?=
 =?utf-8?B?RHJpeGVQTkgxR0VlaEk2OTNrejM4R240R3dpWDJBTkIrQ0JMTUpmMGFXcGFL?=
 =?utf-8?B?YzFXNldiVEtSamJTc1JyN3ZZU0gvTUorNXgzcytVYThZdHNMb0ptUlU1Y2VM?=
 =?utf-8?B?V09MN0RZbGFYcjhiV012OXRvUkxtUlpSSUxyeVpRbFkyd044VEEySVVoOG01?=
 =?utf-8?B?dFNMWFZ1czBFM0JTMk53REN6aENpRDdTcThQTFlQRkVuRk1NanovYklYRzdG?=
 =?utf-8?B?WEhMNERiaWh5dTcyQWVPN2hVWlZkTlZJOWIvOE1rRWg3a1lNZ3VhSDNkSHRL?=
 =?utf-8?Q?uvDY1syAWUf6VEQZidgVvMaXG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bace7f2d-cbd2-4d3e-e1af-08dba25aa58c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:24:01.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RACZziD68an1RPHZSQOv/1KHozEr0G42CPPLDk+6ptxuVU1VYj+/lei57sXP2TUMSDKmgo1SoFokDTYXypOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 04:03:57PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 21, 2023 at 10:21:05AM +0200, Lorenzo Pieralisi wrote:
> > On Thu, Aug 17, 2023 at 06:42:50PM -0400, Frank Li wrote:
> > > On Wed, Aug 16, 2023 at 05:30:10PM +0200, Lorenzo Pieralisi wrote:
> > > > On Wed, Aug 09, 2023 at 11:35:40AM -0400, Frank Li wrote:
> > > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > > 
> > > > > Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
> > > > > common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
> > > > > suspend state.
> > > > > 
> > > > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pci-layerscape.c | 130 ++++++++++++++++++--
> > > > >  1 file changed, 121 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > > index ed5fb492fe084..b49f654335fd7 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > > @@ -8,9 +8,11 @@
> > > > >   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > > >   */
> > > > >  
> > > > > +#include <linux/delay.h>
> > > > >  #include <linux/kernel.h>
> > > > >  #include <linux/interrupt.h>
> > > > >  #include <linux/init.h>
> > > > > +#include <linux/iopoll.h>
> > > > >  #include <linux/of_pci.h>
> > > > >  #include <linux/of_platform.h>
> > > > >  #include <linux/of_address.h>
> > > > > @@ -20,6 +22,7 @@
> > > > >  #include <linux/mfd/syscon.h>
> > > > >  #include <linux/regmap.h>
> > > > >  
> > > > > +#include "../../pci.h"
> > > > >  #include "pcie-designware.h"
> > > > >  
> > > > >  /* PEX Internal Configuration Registers */
> > > > > @@ -27,12 +30,26 @@
> > > > >  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> > > > >  #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
> > > > >  
> > > > > +/* PF Message Command Register */
> > > > > +#define LS_PCIE_PF_MCR		0x2c
> > > > > +#define PF_MCR_PTOMR		BIT(0)
> > > > > +#define PF_MCR_EXL2S		BIT(1)
> > > > > +
> > > > >  #define PCIE_IATU_NUM		6
> > > > >  
> > > > > +struct ls_pcie_drvdata {
> > > > > +	const u32 pf_off;
> > > > > +	bool pm_support;
> > > > > +};
> > > > > +
> > > > >  struct ls_pcie {
> > > > >  	struct dw_pcie *pci;
> > > > > +	const struct ls_pcie_drvdata *drvdata;
> > > > > +	void __iomem *pf_base;
> > > > > +	bool big_endian;
> > > > >  };
> > > > >  
> > > > > +#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
> > > > >  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> > > > >  
> > > > >  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> > > > > @@ -73,6 +90,60 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> > > > >  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> > > > >  }
> > > > >  
> > > > > +static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> > > > > +{
> > > > > +	if (pcie->big_endian)
> > > > > +		return ioread32be(pcie->pf_base + off);
> > > > > +
> > > > > +	return ioread32(pcie->pf_base + off);
> > > > > +}
> > > > > +
> > > > > +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> > > > > +{
> > > > > +	if (pcie->big_endian)
> > > > > +		iowrite32be(val, pcie->pf_base + off);
> > > > > +	else
> > > > > +		iowrite32(val, pcie->pf_base + off);
> > > > > +}
> > > > > +
> > > > > +static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > > > > +{
> > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > > +	u32 val;
> > > > > +	int ret;
> > > > > +
> > > > > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > > > > +	val |= PF_MCR_PTOMR;
> > > > > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > > > > +
> > > > > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > > > > +				 val, !(val & PF_MCR_PTOMR),
> > > > > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > > > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > > > > +	if (ret)
> > > > > +		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
> > > > > +}
> > > > > +
> > > > > +static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > > > +{
> > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > > +	u32 val;
> > > > > +	int ret;
> > > > > +
> > > > > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > > > > +	val |= PF_MCR_EXL2S;
> > > > > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > > > 
> > > > What is this write transaction generating in HW ?
> > > 
> > > I don't think send anything to to pci bus because it was called before
> > > host init.
> > > 
> > > The spec of ls1028 is not clear enough.
> > > 
> > > `EXL2S: exit l2 state command. when set to 1, an L2 exit command is
> > > generated. The bit is self clearing. Once the bit is set. SW needs to wait
> > > for the bit to selfclear before sending a new command'
> > > 
> > > > 
> > > > Why is it needed ? Shouldn't L2 exit happen automatically
> > > > in HW ?
> > > 
> > > I tried remove this, PCI can't resume. I think this is specific for ls1028
> > > chip to clear internal logic.
> > 
> > Well, if you don't even know what this does how can you write a sane
> > device driver ?
> > 
> > Can you ask designers a more detailed description please ?
> > 
> 
> I often encounter hw quirks like this one and the hw designers will just say
> that "set bit X to make Y happpen". IMO a comment saying that the driver need to
> set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link to exit L2 state is
> good enough.
> 
> > > > > +
> > > > > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > > > > +				 val, !(val & PF_MCR_EXL2S),
> > > > > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > > > +			PCIE_PME_TO_L2_TIMEOUT_US);
> > > > 
> > > > And why is the timeout value the same used for the PME_turn_off message ?
> > > 
> > > I think No spec define it, just reused it. use PCIE_PME_TO_L2_TIMEOUT_US
> > > may cause confuse. What's do you prefered? Just use number,such as 10ms.
> > 
> > This delay value is misleading, it is not good to reuse a value for
> > a delay that is most certainly controller specific.
> > 
> > From this discussion I would say that having pme_turn_off() and
> > exit_from_l2() hooks is generalizing something we don't know yet
> > it is needed for all DWC based controllers.
> > 
> > It is probably worth keeping the layerscape specific changes in
> > the layerscape driver and from there call the "generic" DWC
> > suspend/resume functions:
> > 
> > dw_pcie_suspend_noirq()
> > dw_pcie_resume_noirq()
> > 
> > rather than adding hooks that we barely know what they are needed for.
> > 
> > Mani, what do you think ?
> > 
> 
> PME_Turn_off procedure may vary between controllers and is really required
> from core DWC perspective. So I'd prefer to keep the pme_turn_off() callback
> and leave exit_from_l2() since later seems to be only required for layerscape.

There are at least two chips that need use exit_from_l2 at layerscape
platform. I think not all dwc platforms implement suspend/resume yet. 
Maybe some platform need it also. Of course I can leave it to layerscape
driver. we can change when new platform really need it.

Frank

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
