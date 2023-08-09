Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6367763AA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHIP2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHIP2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 11:28:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7CE7F;
        Wed,  9 Aug 2023 08:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcRV/CAQ4QTBsCBAHbiFokA9L7F44Ip8CZttG2OyLJf4GOBJ/pwd0UPuf260+5Eh2GVbFGykSYgL/4z5PVAcAF1HyU2TDXZtud0INn+pP8c7UBYPLewhpBsSxtRWWR43h/82NbFE0Oynh5mrfCIX0SMymTmUutadQdGGbSEd8Us5pmBZe6gzn00rmyg4wxkF+f95G4on01jkk0Lpy5wOINlwtImpseLkPZEA4EZXebEHfQ0o/2EzTB4OMgZjRHFZ290Ih7pP5pusgnOh/OJgWQqOjvDC+FM1vvMyNNJ+OVI64ZJEpVBP1iQ09kQWfnE38KSsaGrMJjNJV3BVK76EBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl88XdbWEvGoZCrnC3m0Z3Hp6vxnDQc9nLQCFvK9S3M=;
 b=j3CQaCr01X8pqYiksDs2I5mYbsItBjlcyT6ptXrojcjizcx5Y1tphO2uFFMl3gnA7Ru3RZ4VFCJnXFWRJKvJ8Cwl/KT4v4JlQQfLtDe+JCZgklWFjkBE0r9VFnW1lzdppoV4CatzdVMmlvlNE2NCvsTpTwlTsM/QplhpEDLATYRFq/lSbknauirw+Ib+lQ2tXZtvlXQdW7OzUI2sC9+xRck9DtJqgwXj6rdcSziuMYG+hqL0GKzNZ2JRKEuW7KCqmHX336gJ+WCnMLniAMlO2rtWZH4G83VM03xFDD2GX8spqgY39//1VyPIXIWoAgCdLD4dPSu539ZgexJLw0N72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl88XdbWEvGoZCrnC3m0Z3Hp6vxnDQc9nLQCFvK9S3M=;
 b=lTh+wA5XXhzfaTJl3Izq7Ni+vujuT7GFUPbC43f72Gw8FzwMRu8JSeF8eCTaz/prXdYzudYRdy6vXiKrEZnd7RX9kmnFEH09xh3MSi4XAblI96XXYlYp7qhh/5j+ZMPDjJrK+Ll/+nuNeNXPn0uUkQzT+e1OEOuxxEsuYZMMBXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:28:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:28:19 +0000
Date:   Wed, 9 Aug 2023 11:28:03 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     helgaas@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, mani@kernel.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v10 resent 3/3] PCI: layerscape: Add power management
 support for ls1028a
Message-ID: <ZNOwg6En8e+epmGR@lizhi-Precision-Tower-5810>
References: <20230807165238.569297-1-Frank.Li@nxp.com>
 <20230807165238.569297-4-Frank.Li@nxp.com>
 <20230809061604.GC5348@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809061604.GC5348@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GV1PR04MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: f78db721-2f22-4ec0-f0c4-08db98ed426a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl4UHSGAoL/m5g8sd6E00wW6EufwczypHGi43A3UmutnmYEgicOmvH7sDE+LyowFO2BxIKsHZK3m86vMjSwTTYWQ+i4Crl8S0qtRYY/TSEKRNoKdpmb88UJrjshlb0OWGp1s4Hn2vdNtaCKF1eODV9f6AUwc6oAapdwHVq9cdfqOls2OPzaelrj9Pc8hjCF4AS1a5qffywPXdsGM5sIKwpslUFHbzFmq+Q3KZdx8QG7KyGbxpDmzKT9GS05neRYho+A0Hlfc4sCrAJjJbNjNETXvmHFp5HtFPrnSlkMJjRMk4AEuOXetpy/8pnkmjCLz/00mMP+8JpPslTpM/b2C39PJFAJpQncR8JSOcj8+p9LAHyOrlu3kuiDWUnaiBewDLq4qPvw/0fEECR+iAm24paxiwg74yXXafOB9YayHkGNhfl6N4T0AbPnKwyIrkfO9e2r6c0CX/qUO0+r088ZavlrdeqBbxBOB3nt6Wp19fFD0T2CbHz64siVYCJS7GI2l8T3owRoiwSWkrBwZU4Wl8JrhLe+7tTrloFmjFaxQmVU64mm6SGSViY2IY+lpSoXeRhTUVDZsy9RzVy/tNyfbCEWyq0lWCx0GtAGmudaUKgi6XcDVMEnCYfMpWpiN5k2AlUqNX1yaLQHFt8zHwjqRMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(186006)(1800799006)(26005)(478600001)(6506007)(6486002)(52116002)(83380400001)(6512007)(6666004)(9686003)(66476007)(66946007)(41300700001)(4326008)(66556008)(6916009)(7416002)(5660300002)(8936002)(8676002)(2906002)(38100700002)(38350700002)(33716001)(86362001)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hwL0pRM0FicDVScXZEc2pQTUdJeTVjOWFPLzJNVlF0aGpnVzJ6dnp1RHZG?=
 =?utf-8?B?WkRySkZZNkVUSnhNamx3amcvcy94SWpxcS9UVnYvak5BMHJWTHl3UjNCdTVM?=
 =?utf-8?B?aWJSYnBWZE5TNWhGcTN0RkJVbzdjdk91dTJ2a1VYVVRaek1CRFpUeWZOMkFt?=
 =?utf-8?B?NTFYTE5xbTd3eEVZbzYrOGY2SitaRXFESVZJZGJwdmo3K1dxSGVwR1YreEEr?=
 =?utf-8?B?S1Q5RUttSXJjMnEvUHRFNmkvVkxtbzRaTjYwRDQ4Q2lzRzRTZ0NETWVQUXh5?=
 =?utf-8?B?dEx5bTROKzZzck52a2s4OEtmckJ2MFhPcmlIWGZRRE5FUklhaWFtQnZ4WnMy?=
 =?utf-8?B?WlgvbHdrVGtHeWx5VFRxUzlPakNSeE5KaTR5b2tEbHU5bWwyM041NzdhaWpW?=
 =?utf-8?B?amQxSGNJbzdiSWkzNFgwMXF4aklRM2RDS0NjdjJHU2s4YlpuUkIzV1gzZDFx?=
 =?utf-8?B?WnlicktSRlpXTVhWei9wcS9iMW5VTG8yRDdBaWtrZHQzQUpHU0xqeGphNVdY?=
 =?utf-8?B?U1V3V0tEL1pYbGk3VkV5YzBlNVFJcFg2WEVDUUVNWXB3aTZtejdZOWtodEVk?=
 =?utf-8?B?VXd4YkZubDE3VlpqOUdONDdvdmFUNG5sN0M5Sks5VzhtQmwxYVBRMEpUdGRx?=
 =?utf-8?B?RTRGNXkxdkh2eXloRlhqdG04MklNUlZpYVdSYnlDQ0JHdkhxNWdVVzlsYkly?=
 =?utf-8?B?cy8rekcxTG5tME0ycWhzUE11cGJDWCtUMlZxY3lqRm1rK0dMS0FFd25MRWJs?=
 =?utf-8?B?ZG5HbjFmdnh3dVY4NmxXZFZpcVFqN1AzWnRuVXZ6Y2lHYjd4Z1U2cDBkRzNw?=
 =?utf-8?B?ajBOeXZvRWlKWjZPdVVtQTZmL0JpSVJwd3drMzJZdnVjQ241VDlGLzdtbnRw?=
 =?utf-8?B?QXk1RWpIdmZwdHdPVjA3RHVNbmNIZEVZLzNpdGFFSlpwNkZ2c3pWY2o4a2d1?=
 =?utf-8?B?NGNqdG52NVM0ajkvNUVpZldLR2dBWWpyZVJvWm5Sd1VRd3RhdTREMHlFbkpt?=
 =?utf-8?B?SlRXa2tYK1phT1hnY3J1ZzZoT3RVQnluNXIyaU15RTRFWEZsQndnVDdXajFI?=
 =?utf-8?B?M2Z3N0YrUFFTMUJBOUdhTUs0ZXdoQ3dUb2xiOHllaWJ0K3VUMzlNdVVmL1h3?=
 =?utf-8?B?MzJka2tCTFVIcEhxTEFKWkt6d2drQVlXNXVjWHQ0YVRuVjZLUkVuU3EyZCt5?=
 =?utf-8?B?dHFQNW5ySTBacUs2STVhQytYTGRnOWRUSWhlRWpxQ1hoZXNjdFJXRkNneUht?=
 =?utf-8?B?UHl5clJ3RnZNalk0M2NLb2wrM3AvZEtWeGdrWWdNWHNWSXVnbUdiYklrbExY?=
 =?utf-8?B?Y2R6ZERDL1JpNm5rMGx1YWZNVTBUUUZyaFdOM0Y0Y0ZtY01Pd05ZSEdYbytD?=
 =?utf-8?B?UU5mdGM2RVRZWVJiTjZOeXdoV1h5Z3pmRDJaNVJDdm1VcXR0NFFFRlBiS1hx?=
 =?utf-8?B?MDVYL0V6UTgvMjEvcEZJSEowTkFybUJzZTcrc1JUa2ZDdjdvcjhuVWRnbDN4?=
 =?utf-8?B?M0h4eFpEdk43VzlZeGMxNzNicVJtQjQzd2xtQ002ZzJFalFEbWNONXpwbWNw?=
 =?utf-8?B?bkxUVUlmZ2lVUW1FRW5rR3VTY2ZPMjA3blIrMWQ4SDg5MlovS1I3bkE0bU81?=
 =?utf-8?B?em9LK3dGdDVJb2pvZDNibEhMVXZRZWZoQXE3SnhQcnZ3RUxlUkVyaHNEQnFF?=
 =?utf-8?B?YitkSFRDK2ZRd3V2bWIrWXBTY0xrY01iZjJNTmFCSTk2WEZTRFp2SVN5NU1r?=
 =?utf-8?B?R05HRGpIN3p6N0tLYk5DS013SHlqRUhJbDhmajVzUEZuQjg4bnU0VnNrd1NF?=
 =?utf-8?B?THVCRlFiVkxNcXorTGJHNHA2blJwMUNxOWt3YjF5T2ZGTFVweVJmNWorZDlE?=
 =?utf-8?B?Y3pKdUppMnZabVRPeFlSUkpPZjV2MVJXUHZ4SnBUSHlsQmRTM2d4aDZHYmlS?=
 =?utf-8?B?LzRlNGgwOTlCdmZucThOMVRReVNVNUIvQmJOaGRUdnM5ZlgzR1NSZktXOHl4?=
 =?utf-8?B?SHlxVWxxbXpGK05JTDlxRWZvMTJ1anA0MThLT2wyTmhDUXVrTGF5RVlPSW01?=
 =?utf-8?B?bGlZK1FJL0w1S1g3RVcxNUE5bnVzM3ZhVjVzUHY3U3JGZnVJeHFwT1BXUTl5?=
 =?utf-8?Q?9V5B/MHhm3V80YFVzAMnksITQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78db721-2f22-4ec0-f0c4-08db98ed426a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:28:19.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBeSJNOFEZYVSlvHlqnyonHU3V4Gb1Eq0M6aIEhlYGGSE6CPgGlteT1WeMjTCEuvHZab51Al1aks9s/aYtpQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 11:46:04AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 07, 2023 at 12:52:38PM -0400, Frank Li wrote:
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
> > index ed5fb492fe084..7586aece769b2 100644
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
> > +		dev_err(pcie->pci->dev, "poll turn off message timeout\n");
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
> > +
> > +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> > +				 val, !(val & PF_MCR_EXL2S),
> > +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret)
> > +		dev_err(pcie->pci->dev, "poll exit L2 state timeout\n");
> 
> I specifically mentioned that you need to change this error message and the one
> below before adding my Acked-by tag. But you just added the tag without
> incorporating the changes :/

Sorry, I found I forget run 'git add' when I run git commit --amend.
Change just leave in local tree.

Will Send v11.

Frank

> 
> - Mani
> 
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
> 
> -- 
> மணிவண்ணன் சதாசிவம்
