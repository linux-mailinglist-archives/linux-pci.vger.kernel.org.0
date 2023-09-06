Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3179346A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 06:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIFEZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 00:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIFEZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 00:25:16 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0612A;
        Tue,  5 Sep 2023 21:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksbsvlW+dQrF6EIidb9K9kRbRpYhS7j1se9wlmV2UEp/Cka/W/Bxg45a+ftM8Hl+QzQ6F9tp3dsHNqGCeqqGP45k45QKa1OD6VEp858joFKlgFqsvtKawGZGPtPBQEyAMhpnGMU/k1OpmJn3h9tkRahUq52kXCInZQzzA1XBKgogOtXbThr110ukBuxF6Me36LNiUuijgGV5h+pvhNt3kZuCuUGmdIh0LUCE/SZYHoLq/Ht1U5LZLcVTv0uuWNGuL4CLAIlbB2cChUQ6C2J+NpaIUGPLY46Y75Ync/OGsZnFAiNZ/luAzPzoztG7YVKGpqdEHMV1+aMiHVicuW+jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar5zUTzdHaX/glf2euK7Hqnque/l1g+mO4vU5IODlFw=;
 b=AGoUC5P8mLFTjnyH3goVeMHMN52suLCa7GjYTrRV5QUjzeBg5rrFI56fFSn/5trAQYt40hzYCSiM+1EmFoRg1A6I0lXhwLsR8MgClx0Z7yRFfoNprg+LoPNvof+HUHC9B7kLuBWSy46YX1Ai/P/zouh4FyESQLnOR5VkeLCQ+bsqDCdJWECmx3O8CO0JC5qYK5OlvDYvhFyc/9TOz6LWUXkMXEDrY55Ou+BcGHnKnbjO+nqPTvKAGzic4JX4UA3WAbA6cIXPtjPrSYUt25S+uLDWpc5DUdnbGQyQwuesxlf+cmZwmgnrlN3OqM43WTNh5udSy4PvhfMfZ/98yZPyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar5zUTzdHaX/glf2euK7Hqnque/l1g+mO4vU5IODlFw=;
 b=CcQ76Z440bp4+GKaoTAxFgt65OoYUaG/2exkoTIlhmQKfKAl2X+5jM0i9i+Og7kaDZkudDeF0fIUM5ZlP99J+kdonAirV8g1UskqSnUXFLSBoUiRKl0LDtoqKKPhXLJaYzKPL/GOXwPWrT9yWSgQSSpgMtuBauaG5O3z8Ng+hVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 04:25:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 04:25:07 +0000
Date:   Wed, 6 Sep 2023 00:24:50 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230902045328.GB2913@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d32b0f5-7d9c-4a68-2c78-08dbae91400f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACMRNTcssYt6CMVcykEB/OTmXlS0GCn5syyNuL3eD08L7YlA8+aFwbuvUwxQdBObm+zr8Y1ePl3BAdWlIFiATavqjKJrdmJxDhyI6HziRboqJw67gAVpa9Oagv4RlNMiAL/ddDpLJZUBM2snb4t+XTbZu2GuhgL0OYmQbTEsAijQVplAcpombc9yz23CVTb57Df/6X/+0mBMZJq5igvvE0JL3iStWaQYQY1QyQoEj5bBokiGLsvmtMoE9BWeGsKf+sGhl+NEfYnvipLBp7wGOYxOBPKA3O+sUyt1pzIp/2F/4YjI9ohyJaJxIgrFNSiSNUVOwg4rsByLasluFNK7bsZp79GEcuYW2Pipk5hFTkxn2nDZav7OV8qa83GYrMYmvyJyiSqrAN8RgBoMhhyOjtKt2MRHa1TuMZq3wv3TDBpajbzGTP8fsENdCL0Zq8CtiTXqHDg/3sbj+cdVWcF5OLjfWm6GKk5e6yt6W/P/7ad8AWuAU+s54/fW9tiWmItCADSijf5nDXGqWZCuUczSz7ET2jS7XwMZO3OVn9R5+Nmv9sMX8uP21byrKFb1HD5FPKMnmVnBRe0QVTad4B8Wt5fwVevRqyP1HtWzjt/xzjXXsgiMnrX4PgMNdEBCPV4/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(83380400001)(2906002)(38350700002)(38100700002)(33716001)(86362001)(6486002)(6506007)(6512007)(41300700001)(52116002)(9686003)(66556008)(316002)(66476007)(66946007)(6916009)(4326008)(8676002)(8936002)(478600001)(6666004)(7416002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitBZmZuajZBYjFYTmRzdVo2bEpIMER2cWJOVSs2UGp5OEhlQTBBTG4yME1q?=
 =?utf-8?B?cWs4bzI3VzQvUHNoWityanAyTkFlNG0zeWgvZGtVVzJMMWc4YXozd2hqb0Q5?=
 =?utf-8?B?S2xrZVlrOVFtMENISXB4Z3cwYUo5V09wNSt3WFlnV3k2TlUySGw2NkY2anpj?=
 =?utf-8?B?bEhxOW5TdlRmYWFzTVFWdFZaSlJENE5XT0lvUm16N2tUWDFKS1B2cVFvb3Vz?=
 =?utf-8?B?RFAvK1JNTUZ5SlUvUTRHN0laYytGU0d6dk1IL1QrZGF2VERUWU11dDhRU1p2?=
 =?utf-8?B?Vys5UTRGU2tCaSs3RDZTMkprRWRucGo0OUJwQTNXWEdudlMreVhGbDdQWDhr?=
 =?utf-8?B?ZHdla2d0MGZSNUJqU25CODB3K1dmSHJJS3lZZnZaZzUxeloyOVRBVk9VYXJa?=
 =?utf-8?B?VkdiSEREWjFMeHJpNnNnWHZtcDNadlBNYVN6L1dLVlBvWDdwdkVjRFYvZklD?=
 =?utf-8?B?OG1LMjZoZjdONHYrbzdpclZvaFBHSjVqQVpVY3E4K3NBZnRka1RWcGJ6RmRF?=
 =?utf-8?B?cWxRZURMWEo3a01XbHpHODRQa2NvK3RaK2V3T00wbGN2MHdSeVdTcTB6SCsz?=
 =?utf-8?B?azJwQ0toYlFHa3VuZzZCL3B2SkpkRjQwb0hwZkduQmdvZVkxWEdaa2E4N2w5?=
 =?utf-8?B?b29BK1plL0EzQUtIU1BqZUpBRVZ0OFYwNzhqOGlpdXVPWEpsbHpCdHhGYzB0?=
 =?utf-8?B?eThvTWJUY3JBQ2dqSkxUb0FINXdndzRtWUtPQTlHeTJsRG4rUXI5QmpYeWNH?=
 =?utf-8?B?SVdyb0Q4aXNLSkQwcXdmZk9FNlFPK3ZiZmRyZ0kxSmw2cVBNZllyN0pDZFRs?=
 =?utf-8?B?dXFFdThseUFsUVJ6TnNTL2kxQTlRTERiZGhlQVdRU09Wakp3TkJuMVh1SFlw?=
 =?utf-8?B?OTBPV2FSNUQvR04rMTFHRGFISXJNZXFwelJwU051eDNyeHlLaGxFQjNnVUpq?=
 =?utf-8?B?ejFka0owdEhLL01NeGRYSyszRHdGM1VHRVpsUFVhWVpxRllKS250MFpjNjNR?=
 =?utf-8?B?MkV5bUxydnVDWWRzRm5tYXdNM3UyaHQyZUhSQ01OQk0rRmRWTXVrTUFpcTZt?=
 =?utf-8?B?NjhwOW9OVWovVWVFczlmcVFxUk1qQXVxdDN3T0d1MXRBUXBDQXFBNnpWWG5H?=
 =?utf-8?B?Z0VmOXMrWXBoNEFnS0NMUE0zSXZIVnUvSFhuWjByTkhaZTNSN0xCUGdRV29u?=
 =?utf-8?B?UW9DaCtIMzZDSmFINXdqR25INS9rSWcwdVhCVGNKY0pwaFRCcWxFcVFvbHor?=
 =?utf-8?B?S2IvaWlJKzRMTktKVmZjTG5wd3ZQUkVKOHluS1lUNmI5L0NRbFlhcEw4K1FS?=
 =?utf-8?B?NEFXSUxBaU42eUNpYUV0dThoRUJXN2tzU0dMU0QxT2psTm0zNld0V3dtVnpm?=
 =?utf-8?B?dzczYmZjY1VkaDF4WXYzWmtxSnZ2WndsRkFXcWRwZFVTVEwrQmVheEc3eWc1?=
 =?utf-8?B?SFR5N3hldUNsWU1scXdOVmpkMnJWZU1nWG1ibXZxVmE5clNTTnhkMFJCdGdy?=
 =?utf-8?B?REppV0h0WjNoV3h6SGE3eHBqQ0JJc2ZaVFlyTXZUQ2FQTTBqbWFKelNCc0xz?=
 =?utf-8?B?eGZyRU1IamdWeFJYV2NvanJiODdBTDlKMmJEYi84cjd1eU5iZlVlWUNFV0tw?=
 =?utf-8?B?KzhNektzclhwNko5SHN5NWpDcmFWUFRYWm1BR3RiY1B1MlM0WHdoak1mL1VY?=
 =?utf-8?B?SE9JcGc0clRRT1BrTkRJbmQwdDRpR2VyZ3JuTjV4OWZWdm10NDFqdnhFMVFr?=
 =?utf-8?B?R1JNc1hCYjBRNzgxb28zem54MTc4Ym9HdldIZld6ODBrTDI5ZDgvNHJFaGNE?=
 =?utf-8?B?VnVjMVk3dEx3MjdBaDNRclFZMU1VNFZjNEVtVmZLZDgyeWdBOHBzVzlvcXh6?=
 =?utf-8?B?b0htMHk3a0F2WVAwMlNmZFZTUHZFRFczS2V5S2d5dUhUVWR0SVRhVUZZS1cv?=
 =?utf-8?B?UWI3M0hzSHN2UEZWVGRvRDBHYUdHcTBlQ0ZQYmVCa0lWV3ZQQis1RVhiNDRH?=
 =?utf-8?B?UlVXaWh6b05YbzJYVjJzb0VBWEJJRitYN0lOYVdSTzZoYXZHVjFXakF2OE9o?=
 =?utf-8?B?bStaNko5SXA0Wlc4NWpOTHlXTXVoK0FzdFROK0RhbXFYenRlWG42eE9UMUNh?=
 =?utf-8?Q?XdXYH1KO1/Biwk/+Le9mc6rfL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d32b0f5-7d9c-4a68-2c78-08dbae91400f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:25:07.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqkBlcZq7Oeweybm3AMQHuQtx+5gNixB+3/zOjb4MG09OADWuHE+HJBXxaGLRLYMAVp1ld/73fuzUL/BL71xnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 02, 2023 at 10:23:28AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Sep 02, 2023 at 10:22:25AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 26, 2023 at 04:34:34PM -0400, Frank Li wrote:
> > > This commit introduces a common method for sending messages from the Root Complex
> > > (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
> > > such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
> > > by the PCI host to the message address of the platform MSI interrupt controller
> > > in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
> > > an IRQ at the EP. This implementation serves as a common method for all endpoint
> > > function drivers.
> > > 
> > > However, it currently supports only one EP physical function due to limitations
> > > in ARM MSI/IMS readiness.
> > > 
> > 
> > I've provided generic comments below, but I will do one more thorough review
> > after seeing epf-test driver patch.
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
> > >  include/linux/pci-epf.h             |  16 ++++
> > >  2 files changed, 125 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > index 355a6f56fcea..94ac82bf84c5 100644
> > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > @@ -6,10 +6,12 @@
> > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > >   */
> > >  
> > > +#include <linux/irqreturn.h>
> > 
> > Why is this needed?
> > 
> > >  #include <linux/device.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/module.h>
> > > +#include <linux/msi.h>
> > >  
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > > @@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> > >  
> > > +static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)
> > 
> > static irqreturn_t
> > 
> > s/pci_epf_interrupt_handler/pci_epf_doorbell_handler
> > 
> > > +{
> > > +	struct pci_epf *epf = data;
> > > +
> > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > +{
> > > +	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
> > > +	struct pci_epf *epf;
> > > +
> > > +	/* Todo: Need check correct epf if multi epf supported */
> > > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > > +		if (epf->msg && desc->msi_index < epf->num_msgs)
> > > +			epf->msg[desc->msi_index] = *msg;
> > > +	}
> > > +}
> > > +
> > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
> > > +{
> > > +	struct irq_domain *domain;
> > > +	struct pci_epc *epc;
> > > +	struct device *dev;
> > > +	int virq;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	epc = epf->epc;
> > > +	dev = &epc->dev;
> > 
> > "epc_dev" to make it explicit

All other place use 'dev', I think better keep the consistent.

Frank
> > 
> > > +
> > > +	/*
> > > +	 * Current only support 1 function.
> > 
> > What does this mean exactly? Even a single EPC can support multiple EPFs
> > 
> 
> Please ignore above comment.
> 
> - Mani
> 
> > > +	 * PCI IMS(interrupt message store) ARM support have not been
> > > +	 * ready yet.
> > 
> > No need to mention platform irq controller name.

what's means?

> > 
> > > +	 */
> > > +	if (epc->function_num_map != 1)
> > 
> > Why can't you use, epf->func_no?
> > 
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	domain = dev_get_msi_domain(dev->parent);
> > > +	if (!domain)
> > > +		return -EOPNTSUPP;
> > 
> > Newline
> > 
> > > +	dev_set_msi_domain(dev, domain);
> > > +
> > > +	/* use parent of_node to get device id information */
> > > +	dev->of_node = dev->parent->of_node;
> > > +
> > 
> > Why do you need of_node assignment inside EPF core?

GIC need it to allocate a MSI irq to platform devices.
I think it may improve if IMS support.

Frank

> > 
> > > +	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
> > > +	if (!epf->msg)
> > > +		return -ENOMEM;
> > > +
> > > +	epf->num_msgs = num_msgs;
> > > +
> > 
> > Move this to the start of the function, after checks.
> > 
> > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
> > > +	if (ret) {
> > > +		dev_err(dev, "Can't allocate MSI from system MSI controller\n");
> > 
> > "Failed to allocate MSI"
> > 
> > > +		goto err_mem;
> > 
> > err_free_mem
> > 
> > > +	}
> > > +
> > > +	for (i = 0; i < num_msgs; i++) {
> > > +		virq = msi_get_virq(dev, i);
> > > +		if (i == 0)
> > > +			epf->virq_base = virq;
> > > +
> > > +		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
> > > +				  "pci-epf-doorbell", epf);
> > 
> > IRQ name should have an index, otherwise all of them will have the same name.
> > 
> > > +
> > > +		if (ret) {
> > > +			dev_err(dev, "Failure request doorbell IRQ\n");
> > 
> > "Failed to request doorbell"
> > 
> > > +			goto err_irq;
> > 
> > err_free_irq
> > 
> > > +		}
> > > +	}
> > > +
> > > +	epf->num_msgs = num_msgs;
> > 
> > Newline
> > 
> > > +	return ret;
> > > +
> > > +err_irq:
> > > +	platform_msi_domain_free_irqs(dev);
> > > +err_mem:
> > > +	kfree(epf->msg);
> > > +	epf->msg = NULL;
> > > +	epf->num_msgs = 0;
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> > > +
> > > +void pci_epf_free_doorbell(struct pci_epf *epf)
> > > +{
> > > +	struct pci_epc *epc;
> > > +	int i;
> > > +
> > > +	epc = epf->epc;
> > > +
> > > +	for (i = 0; i < epf->num_msgs; i++)
> > > +		free_irq(epf->virq_base + i, epf);
> > > +
> > > +	platform_msi_domain_free_irqs(&epc->dev);
> > > +	kfree(epf->msg);
> > > +	epf->msg = NULL;
> > > +	epf->num_msgs = 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> > > +
> > >  static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
> > >  {
> > >  	struct config_group *group, *tmp;
> > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > index b8441db2fa52..e187e3ee48d2 100644
> > > --- a/include/linux/pci-epf.h
> > > +++ b/include/linux/pci-epf.h
> > > @@ -75,6 +75,7 @@ struct pci_epf_ops {
> > >  struct pci_epc_event_ops {
> > >  	int (*core_init)(struct pci_epf *epf);
> > >  	int (*link_up)(struct pci_epf *epf);
> > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > >  };
> > >  
> > >  /**
> > > @@ -173,6 +174,9 @@ struct pci_epf {
> > >  	unsigned long		vfunction_num_map;
> > >  	struct list_head	pci_vepf;
> > >  	const struct pci_epc_event_ops *event_ops;
> > > +	struct msi_msg *msg;
> > > +	u16 num_msgs;
> > > +	int virq_base;
> > >  };
> > >  
> > >  /**
> > > @@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
> > >  void pci_epf_unbind(struct pci_epf *epf);
> > >  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > >  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> > > +void pci_epf_free_doorbell(struct pci_epf *epf);
> > > +
> > > +static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
> > > +{
> > > +	return epf->msg;
> > > +}
> > > +
> > > +static inline u16 epf_get_msg_num(struct pci_epf *epf)
> > > +{
> > > +	return epf->num_msgs;
> > > +}
> > 
> > I don't see a need for these two functions as they are doing just dereferences.
> > 
> > - Mani
> > 
> > >  #endif /* __LINUX_PCI_EPF_H */
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
