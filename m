Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47F784436
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjHVOa1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbjHVOa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 10:30:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E14CDA;
        Tue, 22 Aug 2023 07:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAnmbLAqW9Ik628eW2fuMOBfwX1MuYVX6yxUG1AarcW/RvOGzrWWu7fgy5VWqjnLVQk5XB04F+UHTyy89eUx60iRRxmOpw4/f97sshcqAZqLQjVaPwXRiehcrq5h8C0iyOmYHtDqeRKlQXhp+R5sL0WhpUR6+fP5tGcHDvb0vS/jDSYwnMg/MWodZ9IhWC2kG+I36iEOK9hY4HHs40HSGAUUDZ4d/Qq0fKEN0dtd4tBsEvR504Djq3xGl3MFe5rTMnEXw4Owq6y/zfSq0CYHvlbuwM/hTCHZrhdXo2o+Q/S1+wXcHpXFreVuyL3QRC1089sFJsrOjCNzG1V24BvbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQFsDYydtbEyLNLcgqW4k+TmWhHH/wWibv+5Zz/yEm8=;
 b=UkH0nRS5pFuijSgwSWFRW3PMAXuI+XNo00XTydFoyce90vl49jtsfGknJl/w/Pm5O26TehD010PUhCQal4FavGzdtlZj1HnD0IHdTNHknCEhVvDNw9PwmZHKJUw/dJiKtc/IqbPMtH2bFNs4doePGyv458WZp4KCnczijHXi5Fcj0jVETYcHwTF3D5eamUyznnwMFgrtnatAOSGTZBIhXoCqJO7cvNOnmKtmuqssMQWotqMjE3vHLmAlWym2xTZZoqxF+ouUhMSP6DbpLF93V95hg+Ky1jnpNo3eLbBvVrpnUw6UCEd/6Tz9DiqL++RRmrWMrLYOUwEe+zkHcL1jRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQFsDYydtbEyLNLcgqW4k+TmWhHH/wWibv+5Zz/yEm8=;
 b=kpxj7SbNwh7sx8dHgtXuWTctyHiO+oYGg/YQbUVyTNZ8emp7uOq3ORbFNhYioTJpridArhY6MnHl6M8Fp1pHrOwPCrXTMhxG11jMBBv/dAdyNJQJnGGviD73gHV+rI3f/AX8mCsrZSg+ZPLorsMKE8MFad9kzxAqswMBcFscXRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:30:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:30:20 +0000
Date:   Tue, 22 Aug 2023 10:30:08 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 3/3] PCI: layerscape: Add power management support
 for ls1028a
Message-ID: <ZOTGcLa4audY/cTV@lizhi-Precision-Tower-5810>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
 <20230821184815.2167131-4-Frank.Li@nxp.com>
 <ZOR5k7B3qRFEjPXR@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOR5k7B3qRFEjPXR@lpieralisi>
X-ClientProxiedBy: PH7PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:510:325::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d664ab-fdc8-41be-9473-08dba31c505b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEoKH0hUPMRn0mlMcP4q19s/iorjVZq70NtPgfCbVB8ps3dxRHP2UEexNWfdcNSDkP13121rS3SS7TWQEvOZn77m6sKDwHKH9HibgkzE81s7PrtwDByu6p/gEV2QRohdmnWwMGwI5w5oUinntE50pM5sQER9JZbmknCLDTo8EOfHlThvI6mv7czARfeJRA8JsHeBqXbq/oeqKFnuZxB01+cXY1x+WDn/hzwA60prjfngqf8d4WKtjhiP9C6yBXLYbdEYMiolUmSidEZd5YTQy396OsE52x+xm9qklVp/ANgTROhPV7riC9xnQVMKomO4fYtswxEbdeDz40pSA70SQvsYNY52bPSNr89/hgGH2yo3FlzkjLdxCOZsdc60BZULhhHovSIWqszz9AHcwwM1sKJy26nZPLVzWZ/dAQFeWeXs22kseIe6Pap70nMmL/GQpkfxFSbTTZNdFpqujtNszcuqTQOXzq8tV/PluY3rqLIYGtcZ4yX+WOVlFuh/xtkLdxPhRor4wsyIzGZyn6uUKHFqImQriv2kNyC7pUFfgLEz0UvapwOhw8hQQ2DEZ5hemu5xqglFv4bMf1ys6SPTsf75lvEtLdxGq3syjjya3Sbg/yhUipIffle+WaazDPoh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdSHFev2MdSn1fqZQgA/qQyXwypu9dvipDTVpg645zsurYnrMzNOcW6cpD3r?=
 =?us-ascii?Q?XOTV/NAc1e08yrqxetBVpql/+clDhmDR2vQ0UzRTYtI96b250eG+KSUEZHhQ?=
 =?us-ascii?Q?62OJtmST3aWpa1PdkcFcjauHSU0CNrwXDJjJgSzCkVMiHKd+/HjbFf3ahxZd?=
 =?us-ascii?Q?nF9UYmLRj/LusXcomUnEvV7ishHMMhsRB07D5wJM56ZqvGrKtK+6EL/TSNTv?=
 =?us-ascii?Q?vvbIA/tdeAkn2Ggj/5HfVtleg4bh4cloQQOkM/8MYAsW6DWRfrzYhLSOnRI/?=
 =?us-ascii?Q?JsPibtV+37bGpb3JZyjyMicBuN5ly2P26okYQ1XyDdMnMqysYKCiLs+RkyiL?=
 =?us-ascii?Q?lyGGR9zt4reQkIDXvq6ecr9imEhfbMqsZa51eX2vTo/lc40UALuTcB5d4haa?=
 =?us-ascii?Q?2I1Dsuw2bgPrl74f0JsFiBHRZnzisABxT0RyC2CzO/ZxIElmj/7zGCNqS6WE?=
 =?us-ascii?Q?zXnbVeR++Tr7/gqNqti5Dy7YZHtlSLlzJoIGT/eMxCgSnTAW4K38vBnrXdFA?=
 =?us-ascii?Q?x2ZTnc9x1DecNkJ/JZkUfLWEW3r5AykdanQcyaLaiKDq1tFd5qS8/Dcx8wLR?=
 =?us-ascii?Q?ieolMOhvOSduVaRNgFddjjBg7kIVuD5fVHsytHG4qzbidbSgraF0vEHuVKRj?=
 =?us-ascii?Q?L7o4ZSUKXb2DqgKBFfWcFiMitLpoXzhBoWX5SlOQgi7rBjp2wEuEHIUNGJP3?=
 =?us-ascii?Q?4xzUTjJQGdZi47s5nA1vvct2usuIPvgzPDNJmQjIs3k3Fw0gYhmY5795Tfqv?=
 =?us-ascii?Q?deMK/P4xaCEFZ3TAUeaiAOmnWJWk8EurGR3ogQcN8QuG81gs1qO0agqPwqxT?=
 =?us-ascii?Q?QQ9SAjD8SYzA+gDKpm/17BMDJBNvBW81P8LUlz+F+91VqlsGhMYOTq36eCHa?=
 =?us-ascii?Q?JvT7hld6jSn0kinceEPKzHX6BEO+HAsJCG1B/tv1fc9u8qEMvHMp65Hpam72?=
 =?us-ascii?Q?ePEHFac+a9L84jMRuhEIYTagnyQ7jCValBWD4zFF9EAZHtZQv1DwWWjToHaX?=
 =?us-ascii?Q?JeLXgPeGN9j0c2NsdEQBGAwuundOSESq6wN3nvZCDkJRU8smvk1/UkePIMmh?=
 =?us-ascii?Q?Wm7M3ht+27A55y09WIM2rmOay1mSfW79Ef7ZOrhThj+a9iW5GiNWW+vIiVof?=
 =?us-ascii?Q?X9aNmVlm5L10zvh7rBMlodnDiwaWAMFAtHrue4mkMOogXSLDE/pD0b7ThXS1?=
 =?us-ascii?Q?W00H38LWgeMwnbHeN+5U+ny4+8HO7faI1TgZhtnbOgJ4p3HZktX4XxhtcMVR?=
 =?us-ascii?Q?2t7BSSPqEMokNs0/LtQDGAGMTatS9a+hQPyBJi9nkpLf5h3fKtATHfFj2kmW?=
 =?us-ascii?Q?nc3nrrSkNwbtYtCRS8M9P11jbiZWYZjs0gaPHx+kDX5JZ+KOpH1PwzFKfmYp?=
 =?us-ascii?Q?XKuDMF7T5WwkO71WAgvUBQa/UN3KO6wrXa9BGzjcNviUs/uLrKzm4BWVuAoa?=
 =?us-ascii?Q?5BTcR3Rqlk8ioMZK0yAtoMmTARgegOQF3AGunN8qr8mFxytMKANrLSOWdnwv?=
 =?us-ascii?Q?j65MW6w97qbeHp9fYPYHLNpRjJWRFqNC9XCKaM4Uv/z1VB81Iu20oul8VSZQ?=
 =?us-ascii?Q?4BN3cokPr/v7gPTpgDo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d664ab-fdc8-41be-9473-08dba31c505b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:30:20.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+d32e4TJRv7FtqH5wRQ7yeCYnClmqCB73Shys6y9nf3cJ8FaE0crJGceetaf7DzilM7capn3b2/KGv35XWMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 11:02:11AM +0200, Lorenzo Pieralisi wrote:
> On Mon, Aug 21, 2023 at 02:48:15PM -0400, Frank Li wrote:
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
> >  drivers/pci/controller/dwc/pci-layerscape.c | 135 ++++++++++++++++++--
> >  1 file changed, 126 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index ed5fb492fe08..97b8d3329df7 100644
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
> > @@ -73,6 +90,64 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
> > +	/*
> > +	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
> > +	 * to exit L2 state.
> > +	 */
> > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > +	val |= PF_MCR_EXL2S;
> > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > +
> > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > +				 val, !(val & PF_MCR_EXL2S),
> > +				 1000,
> > +				 10000);
> 
> I can add a comment myself - please explain how this delay was chosen,
> any piece of information could be useful for a future developer, let
> me know and I will add it.

(This value is coming from exited downstream code. It is really hard to
find original owner and designer to find the reason).

How about just add below comments?

"No specific specification defines this timeout value. The timemout of 10ms
was chosen by the engineer as a sufficient amount of time to allow the
hardware to complete its actions."

> 
> > +	if (ret)
> > +		dev_err(pcie->pci->dev, "L2 exit timeout\n");
> > +}
> > +
> >  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -91,18 +166,27 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> >  	.host_init = ls_pcie_host_init,
> > +	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > +};
> > +
> > +static const struct ls_pcie_drvdata ls1021a_drvdata = {
> 
> I suggest adding .pm_support = false explicitly here, I can
> do it myself.
> 
> Thanks,
> Lorenzo

Thanks!

> 
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
> > @@ -121,6 +205,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
> >  	if (!pci)
> >  		return -ENOMEM;
> >  
> > +	pcie->drvdata = of_device_get_match_data(dev);
> > +
> >  	pci->dev = dev;
> >  	pci->pp.ops = &ls_pcie_host_ops;
> >  
> > @@ -131,6 +217,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
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
> > @@ -139,12 +229,39 @@ static int ls_pcie_probe(struct platform_device *pdev)
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
> > +	ls_pcie_exit_from_l2(&pcie->pci->pp);
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
