Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A8785A2F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjHWOPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjHWOPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 10:15:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00399E6A;
        Wed, 23 Aug 2023 07:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwlIInA3i6YfUKguwZkt5UyxPS9uH+UYISj2CYRx+zd/0way8W42zIDbIsizmO6dO0AnCipCoIjxUujMtJ5u7Zs4jLj+O3xf9DNs5kkQKTBqNovEum2Q5CL/BOyUjTIYQ33aWTWS3DOxi13Sbry50i2KkI/7cndPp3D4j00LMV5RoruKwFzKUIXuS20iCkgwQOpfJ+1xioYrFDWPHZokTdQFIpHSrQOA6wkFDEGdAnN5voBj3/DYnaMVwBt2zJKWdQErwdRbwAMcsw+i0ZE6FsEtKCsXXMROStg9gYcvU4oITPHBnQIKbLJ1EvvaJ/z+nVmKDTu/vtCieP9Tv1IePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyyiLBnEe0PAOD3rL9mNF7AwBfxkee76gDAuwR8OmZY=;
 b=dEY/SgW0lfR8IXX4ZzHIzweRExmeIey+5Ra8rk5HuN9y5aYbvPPr9V2lfu+xnirOHnGe9y0vclugJVvFI6EfDuF5qkxF1IUE3T/bRlSdi2RzcF4Li6HrIUkVeinVLxXTRl6YDNxZvMeWSnkjX3pJo1mODthvifFetF37CqMjRngnXO65zFgtjIX/eXqs1NrE0To9d9XnQBR5nWB+Xh0Vg2StTfpV5S+JPc+WAHdIxk5rfATF0UfeQ2KSw0bNaBgLhAS5DbkFY/+Y8XFtXZ6Ev2m3vXDqyv/w1kP3GFaQXi/NcexOtKfXxM7HPJNbT6Bj8yNLSyR7HdkWxyko+Ls8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyyiLBnEe0PAOD3rL9mNF7AwBfxkee76gDAuwR8OmZY=;
 b=ddru+TA8btS5/GPSy5qDKkn1LqnAG3NNLHBhoH3VS5/ee+GLHbvnA7nrU7LYXNwp1mVHsy7U1ePz2UF0s5IeoATCMjjZLLp0+IJVKLLKcG9kyDlbXXnAlPsnQMvYAaQORNCV3+jqrOkI5lQWegBJ1rxqJrHBF5bu3AzG/Rdlu1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:15:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 14:15:36 +0000
Date:   Wed, 23 Aug 2023 10:15:20 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        helgaas@kernel.org, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 3/3] PCI: layerscape: Add power management support
 for ls1028a
Message-ID: <ZOYUeEapJptpFwUx@lizhi-Precision-Tower-5810>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
 <20230821184815.2167131-4-Frank.Li@nxp.com>
 <ZOR5k7B3qRFEjPXR@lpieralisi>
 <ZOTGcLa4audY/cTV@lizhi-Precision-Tower-5810>
 <20230823075305.GG3737@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823075305.GG3737@thinkpad>
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: b57dac74-effc-43da-9752-08dba3e36b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+2TCjVE9Wels/V7nEGOL8VLca4oKjOIQBxWxQS4wiVgNm4wOaJlGwz1i58gbeqPPV4cFU+hGIb8clDo8VDZqyFYBenTHxigfzYAGreWqiQCcxaYfbqweGkEcKn7HPn4m5px8TrxXPukVv+ZwDqvZeGqrvYTG+N0p1L1Xp1OY2uxM61Vqxd5O/WkgmdmSTp+plIiI8hLdqUydriSoAyePeIXlFlrNnnQ7Xge6ef+JXsvlI0DckVxCo2yG2VZG4TpRQMZ3bOA7AUXz6wPJ7wlUXFqrFAzwYjcAozyIyXzU+clHJbd5dOxTtUPA5eFfBhJ2e6xl57WVISGUM7KS72cyqyagCt1Dt9oa2m/JcQSw7nvkcM6rWsQbKE7uRiQRL+I537rgv0DXlH+tjTOwv5oppP9cZDgTAsj9KkELbdteaCa6+q235lW95feWeuLLEXY36HX5aRBQ11RWIzSLk+xNdFCCPQtukVC6CeoEKvpVrmvvs/izaA70boVIv51Rc56TGauS6U/hZQAiObVC+cTRl8RhieL3BZJAB9AcE8bHHMuy93N2pXHsCu5hEZWvn+y75wO7Joo4fTtPyj/XdZCllLL3bhsdGaBcUufzqrv0d9T8tBJtH8QQLxq/WI7ArbM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(83380400001)(7416002)(2906002)(6916009)(316002)(6486002)(6506007)(66556008)(66476007)(52116002)(6666004)(66946007)(478600001)(33716001)(86362001)(5660300002)(26005)(38100700002)(41300700001)(9686003)(6512007)(38350700002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRrM3dLL3g2Mi95UzFNN2ZDUGYxd1krMWRhejViSVpLWTQ5Z29iMzhlQ2Ur?=
 =?utf-8?B?WjNPc1hiSXNhQ3hjWFNuYjhEN1c2d0YwWWR6OUg0dERUejFaMmZLUUpSTGVF?=
 =?utf-8?B?dDM4ZkowNUcrVW44OGxHRDFyV3AyM3dsWVZkYUF3Q0VvWm1LVFJtaTBQK3B6?=
 =?utf-8?B?U2w3dHhseTlINkpBaUpKZEttUkhmMGczQ0lCQVBRN1QxYVVPYXI0ZTgwdDBJ?=
 =?utf-8?B?Q1FBZW5aV3FSSlBEK3FZcU5FZWl1NXA4WXl3azZ5amFXY3JlNm9WUmZ0b0to?=
 =?utf-8?B?Nk42bjJZQnFWT0xuWmEwbzZJQ0VYeXpMdDM2V09IcWJKdEdCRzZuNmpIRUJ3?=
 =?utf-8?B?ZDRFZ1NORTI1akIxUE40YnR0T2ZDUXlwMitZbnFDdk93RERiNGFvRnRmZExn?=
 =?utf-8?B?SlNDelFvaEUzK1QzODF1RXdkbWw2UVBaWUh2N1d1S2ZqV0x4Z1V0OU9CL0F5?=
 =?utf-8?B?TmF2YTlxSGY1WTJ4Sy9IcGtPRlRtYStvNEpuaFNXVktESFZJNEtFdHcrUCsv?=
 =?utf-8?B?QnNKanBxRHcvajJTNG93Mk8yM2Evb2c4R1JHam5pa001NHpJOTMyUDQ5L3p3?=
 =?utf-8?B?eDZEZmQxME5TbDFBTG8xRS9yL1ZPTmZTQ3dOOENGVmZjbmhiLzgvRWt5OFpW?=
 =?utf-8?B?cFpIZUVQUU41SkRydzc4azRTWWJuR0VLL0c5UUFQREdSZFUwOGRLeS9pK2dI?=
 =?utf-8?B?WitBZTRsMWJ4UTNHQzNqcWU5ckhEUGJEWExNSGo1THNyZVhLeFpsNXdLWTN2?=
 =?utf-8?B?Q3ZHNlBRY09RVDc2RFNDUVpha0k4UjhRNUcvQXFFdUJRN3hMam5OeitzcE9K?=
 =?utf-8?B?Q2JOR0NJTUUwaHJ3OThDSVZBNkpqd20wS3pYV2ZCSmlTMU16T2JlTUltQi9v?=
 =?utf-8?B?QUQrY1NNY0VtbzhrTlplQnVvcmV0emRUZDA2WGFISjJVdnFXbEJhWG9kQ3du?=
 =?utf-8?B?ZXlzSmI0K2puTjg5Q0Z1UjN3bVdESTNWMjRIalVDbkFlRlBDbUM5bUhtNUFp?=
 =?utf-8?B?YUhZYmtBd2NBSEluNWttaTZQZnFzMUg5Q0RSZW9uNE9TQlJ2bm5OblJ2dHJQ?=
 =?utf-8?B?cDNSODJXZzNmWnBzN2ZRU3FtWFpkREZhdjVWaWdEMWY5c256OXFzeHhxQ3pJ?=
 =?utf-8?B?TUtFS0NEbjhCSjhWajFmYU9DWnFDRnJ2R0pSRGNPUlVGSEk2SDFlRTYzdGtN?=
 =?utf-8?B?NmtZQW11eUxZdnJkRXV4K1gzSkF4NWhKemp5MDQrSEFoZ3hSczF2Nnl3b1N1?=
 =?utf-8?B?WVNoUDRkUC9NbGZ6ajRlMDlhVGw3WkNiaGZXMnZZYUQwQ0ovRGFUWnBWZUFu?=
 =?utf-8?B?Tndjd0hITFA5eGVvYU95M05DOFVmc1pVV0hiRlhVa0k3NHJJZm1KdEhBak9V?=
 =?utf-8?B?eksvS29PVERYM2s4UjVTNjRlOVB3azJHVmRsMEpTNVVGRjlqMHg2b0FxNVdo?=
 =?utf-8?B?YkIxYy94ak8zYlR2clEwSjRpZ0lEM2dFemE0NExLb2I1dDZWU1pzeVo2Ym9z?=
 =?utf-8?B?dDhObklVV2VwZ1h0RFY5ZjlucTUzNzRTTXBhRk9PdjZWall3b3kwaE1LeXhV?=
 =?utf-8?B?Qml0cmxNYll2d0htVit5RWR3eENJMTB0TDY1dlZrV0ZLUUdDb1ZEUm9zdEFL?=
 =?utf-8?B?dG5JVlRzVTBGbkFCdGxMVHhocmMyVFJ6WnVhR3JrTlFrRGpuY1h1OHBsZ2xU?=
 =?utf-8?B?Sm45M1RsMHI4Z3grSGkvSXc5QXVieGVXdmJ0ZnNUUCtOSmRyTURvQ3lobUJn?=
 =?utf-8?B?NTdlbEh2bzFUcmkzdDBWTWVVRlF1R2NETTFrT0YraThHM1IrMVhleXZoODdx?=
 =?utf-8?B?b3UwMysyc29hQUUrL1FxRitHaVkrQkdrRHpzeHU2U0hUTDJ3b0c1SW9BZW40?=
 =?utf-8?B?dWhnb3J5OUc5M2paTUtWRzlyb0NTamwrWGF1c2xLREJyTTZVRmY5Z1RmcFIr?=
 =?utf-8?B?Ynl6RVRsajE2UXE1ck5tY3MvU29NZVEzeDZJUTNHN2owTUIwYjBIMjFpUjcy?=
 =?utf-8?B?WThwWWhteW5Nd1V4OENGV2R3UU9XU0NkKzZBWWxOMkdjWXRwTUMwSlNiUFFP?=
 =?utf-8?B?NGRvMnpYWFVsOXJLSkdoWjlWdFp5bjRnQVdkK0hNdzhlVXhOaEEyUFBiL0xs?=
 =?utf-8?Q?d35k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57dac74-effc-43da-9752-08dba3e36b63
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:15:36.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3PpgR+Vbxt/Q3r1z54z8T9p+TuttZh+NBlJ1bODFW5vTCTT6B+jOYxVSq6h4QTeAQ5SDX8ZNezkvO8oRPq25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 01:23:05PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Aug 22, 2023 at 10:30:08AM -0400, Frank Li wrote:
> > On Tue, Aug 22, 2023 at 11:02:11AM +0200, Lorenzo Pieralisi wrote:
> > > On Mon, Aug 21, 2023 at 02:48:15PM -0400, Frank Li wrote:
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > 
> > > > Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
> > > > common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
> > > > suspend state.
> > > > 
> > > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-layerscape.c | 135 ++++++++++++++++++--
> > > >  1 file changed, 126 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > index ed5fb492fe08..97b8d3329df7 100644
> > > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > @@ -8,9 +8,11 @@
> > > >   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > >   */
> > > >  
> > > > +#include <linux/delay.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/init.h>
> > > > +#include <linux/iopoll.h>
> > > >  #include <linux/of_pci.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/of_address.h>
> > > > @@ -20,6 +22,7 @@
> > > >  #include <linux/mfd/syscon.h>
> > > >  #include <linux/regmap.h>
> > > >  
> > > > +#include "../../pci.h"
> > > >  #include "pcie-designware.h"
> > > >  
> > > >  /* PEX Internal Configuration Registers */
> > > > @@ -27,12 +30,26 @@
> > > >  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> > > >  #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
> > > >  
> > > > +/* PF Message Command Register */
> > > > +#define LS_PCIE_PF_MCR		0x2c
> > > > +#define PF_MCR_PTOMR		BIT(0)
> > > > +#define PF_MCR_EXL2S		BIT(1)
> > > > +
> > > >  #define PCIE_IATU_NUM		6
> > > >  
> > > > +struct ls_pcie_drvdata {
> > > > +	const u32 pf_off;
> > > > +	bool pm_support;
> > > > +};
> > > > +
> > > >  struct ls_pcie {
> > > >  	struct dw_pcie *pci;
> > > > +	const struct ls_pcie_drvdata *drvdata;
> > > > +	void __iomem *pf_base;
> > > > +	bool big_endian;
> > > >  };
> > > >  
> > > > +#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
> > > >  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> > > >  
> > > >  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> > > > @@ -73,6 +90,64 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> > > >  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> > > >  }
> > > >  
> > > > +static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> > > > +{
> > > > +	if (pcie->big_endian)
> > > > +		return ioread32be(pcie->pf_base + off);
> > > > +
> > > > +	return ioread32(pcie->pf_base + off);
> > > > +}
> > > > +
> > > > +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> > > > +{
> > > > +	if (pcie->big_endian)
> > > > +		iowrite32be(val, pcie->pf_base + off);
> > > > +	else
> > > > +		iowrite32(val, pcie->pf_base + off);
> > > > +}
> > > > +
> > > > +static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > +	u32 val;
> > > > +	int ret;
> > > > +
> > > > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > > > +	val |= PF_MCR_PTOMR;
> > > > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > > > +
> > > > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > > > +				 val, !(val & PF_MCR_PTOMR),
> > > > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > > > +	if (ret)
> > > > +		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
> > > > +}
> > > > +
> > > > +static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > +	u32 val;
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
> > > > +	 * to exit L2 state.
> > > > +	 */
> > > > +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> > > > +	val |= PF_MCR_EXL2S;
> > > > +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> > > > +
> > > > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > > > +				 val, !(val & PF_MCR_EXL2S),
> > > > +				 1000,
> > > > +				 10000);
> > > 
> > > I can add a comment myself - please explain how this delay was chosen,
> > > any piece of information could be useful for a future developer, let
> > > me know and I will add it.
> > 
> > (This value is coming from exited downstream code. It is really hard to
> > find original owner and designer to find the reason).
> > 
> > How about just add below comments?
> > 
> > "No specific specification defines this timeout value. The timemout of 10ms
> > was chosen by the engineer as a sufficient amount of time to allow the
> > hardware to complete its actions."
> > 
> 
> How about, "L1 exit timeout of 10ms is not defined in the spec, but rather
> chosen based on the practical observations."

Great!

Frank

> 
> - Mani
> 
> > > 
> > > > +	if (ret)
> > > > +		dev_err(pcie->pci->dev, "L2 exit timeout\n");
> > > > +}
> > > > +
> > > >  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  {
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > @@ -91,18 +166,27 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  
> > > >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> > > >  	.host_init = ls_pcie_host_init,
> > > > +	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > > > +};
> > > > +
> > > > +static const struct ls_pcie_drvdata ls1021a_drvdata = {
> > > 
> > > I suggest adding .pm_support = false explicitly here, I can
> > > do it myself.
> > > 
> > > Thanks,
> > > Lorenzo
> > 
> > Thanks!
> > 
> > > 
> > > > +};
> > > > +
> > > > +static const struct ls_pcie_drvdata layerscape_drvdata = {
> > > > +	.pf_off = 0xc0000,
> > > > +	.pm_support = true,
> > > >  };
> > > >  
> > > >  static const struct of_device_id ls_pcie_of_match[] = {
> > > > -	{ .compatible = "fsl,ls1012a-pcie", },
> > > > -	{ .compatible = "fsl,ls1021a-pcie", },
> > > > -	{ .compatible = "fsl,ls1028a-pcie", },
> > > > -	{ .compatible = "fsl,ls1043a-pcie", },
> > > > -	{ .compatible = "fsl,ls1046a-pcie", },
> > > > -	{ .compatible = "fsl,ls2080a-pcie", },
> > > > -	{ .compatible = "fsl,ls2085a-pcie", },
> > > > -	{ .compatible = "fsl,ls2088a-pcie", },
> > > > -	{ .compatible = "fsl,ls1088a-pcie", },
> > > > +	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
> > > > +	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> > > > +	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
> > > > +	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
> > > >  	{ },
> > > >  };
> > > >  
> > > > @@ -121,6 +205,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
> > > >  	if (!pci)
> > > >  		return -ENOMEM;
> > > >  
> > > > +	pcie->drvdata = of_device_get_match_data(dev);
> > > > +
> > > >  	pci->dev = dev;
> > > >  	pci->pp.ops = &ls_pcie_host_ops;
> > > >  
> > > > @@ -131,6 +217,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
> > > >  	if (IS_ERR(pci->dbi_base))
> > > >  		return PTR_ERR(pci->dbi_base);
> > > >  
> > > > +	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> > > > +
> > > > +	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> > > > +
> > > >  	if (!ls_pcie_is_bridge(pcie))
> > > >  		return -ENODEV;
> > > >  
> > > > @@ -139,12 +229,39 @@ static int ls_pcie_probe(struct platform_device *pdev)
> > > >  	return dw_pcie_host_init(&pci->pp);
> > > >  }
> > > >  
> > > > +static int ls_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	if (!pcie->drvdata->pm_support)
> > > > +		return 0;
> > > > +
> > > > +	return dw_pcie_suspend_noirq(pcie->pci);
> > > > +}
> > > > +
> > > > +static int ls_pcie_resume_noirq(struct device *dev)
> > > > +{
> > > > +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	if (!pcie->drvdata->pm_support)
> > > > +		return 0;
> > > > +
> > > > +	ls_pcie_exit_from_l2(&pcie->pci->pp);
> > > > +
> > > > +	return dw_pcie_resume_noirq(pcie->pci);
> > > > +}
> > > > +
> > > > +static const struct dev_pm_ops ls_pcie_pm_ops = {
> > > > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
> > > > +};
> > > > +
> > > >  static struct platform_driver ls_pcie_driver = {
> > > >  	.probe = ls_pcie_probe,
> > > >  	.driver = {
> > > >  		.name = "layerscape-pcie",
> > > >  		.of_match_table = ls_pcie_of_match,
> > > >  		.suppress_bind_attrs = true,
> > > > +		.pm = &ls_pcie_pm_ops,
> > > >  	},
> > > >  };
> > > >  builtin_platform_driver(ls_pcie_driver);
> > > > -- 
> > > > 2.34.1
> > > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
