Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78877E5B0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjHPPyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbjHPPxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 11:53:36 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D42708;
        Wed, 16 Aug 2023 08:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M35YHVHW+x6BC9y/31RIgFBUzKPo68lbHpSUYgXGiJano0ZSwisOyIL3wGU49DByFhwQ14gfPIJnF/sUB6cDJSZXRDeaqo0u5T8K/26NsZ3RyPPomYif8WJYmYN2mvi+Um3yMVqi0CfCDo9xsFBE8yVu8aTYSbiFsv4sZgkg90t0WgXQgbmInEJw0iKKZCbgbqnPLsxKHNVJlr4B1VnYmJoeBfE7FSPu/2D5rFlzY1o5SQ01h9JmtIq7nTiUe9TwAM+aa6BrEX3j0UnSYGWXnIDbFbWXOb55GJkJHMdaInpbeVGhNDpZJkcBifaD6xxwB/JSm0V8OBoPTddoRWddww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d391qkuOlYAxy95a7vc3ORlEjt147k68OrXsMDzBgxo=;
 b=lSLgZdGD5zHpOFcKJ/GO43+FYkLL4kN/M30m4kzREclnyWtYXmZu5zlpxg2WZCLIa/jX5Y3aP6aUWvpZAnj/bwwqvaT8ox92F1iADFgtuKutoYwcr+gCBEeY6cwygdfBUPQ41PsYOr8VJxCTazNpoTdgvBaeGO81QC6AveQ+adIlIv8qkahRWVDhBWXkJbhKse8h/fRSPGdVShXrhD5SPC73O0zbPY+p1h40fGYmG4H6LZi2fJA/euMgbNdavMuRjLhsBMLGbcKtWB/S3sVzUbHhSAeiflUMFv9mX7zOra+PDu671uixIbqWNAZCjQBWAbP0El+q1wRkrtCtAbAoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d391qkuOlYAxy95a7vc3ORlEjt147k68OrXsMDzBgxo=;
 b=dcIfsRQMY2AjVQmtGqFvOnBsazxsIrLXU9epaNXzQDqjl4VQq5GdiD43fcGaBscvkYsp+35hprJ5GgFJ3v1YRtkgSk7S3P/Z2Opkp8arA587QxqjuPtpFZatvTqmVnjIl8Qw29qAbjU2wkkOU2i7BbASAO6z3a9+CliiIBpRNjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 15:53:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:53:32 +0000
Date:   Wed, 16 Aug 2023 11:53:16 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, imx@lists.linux.dev,
        kernel-janitors@vger.kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mani@kernel.org, markus.elfring@web.de, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, robh@kernel.org, roy.zang@nxp.com,
        xiaowei.bao@nxp.com
Subject: Re: [PATCH v4 1/2] PCI: layerscape: Add support for Link down
 notification
Message-ID: <ZNzw7MPF00t3i3bn@lizhi-Precision-Tower-5810>
References: <20230720135834.1977616-1-Frank.Li@nxp.com>
 <ZMfN9w6ixBFBmof7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMfN9w6ixBFBmof7@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1d7cca-28f8-4013-5457-08db9e70f0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfYMjMMxIQ8RGs4mb1tHwD5D40nEGJDgKjmeO5rDleZ284Ok0ARZzrfgKX7ID0GPEnDNh1x+FEYYmVUtmjxQ49cAPmwGieTiFrAchUNbPT/+1et4XSYGikLdnG/ri0qG6dotmZfp4BUHMFIgirLgsmwmmTBWuvpeFxEjlQ/rWhkYNEyS2sPGpc17w2g0dhpyZ3Q3UaIM4jukT06+aEztU/vLU8o4RAQygw4zviKPrVmUpxnWONoQMXrKtV8txWRta8ZeHT5yH/KnNbjn/YDOhT1OO2YRB7nVKZCk0Jr+Z4/9JHONXz6H6kJON2nwaL3eRoNCGitdCZGT7aekSibu0eOgWM/QMCcQqNISkSbJ+KWOgZ7eR3SV1n91e6lR7yCFfM1+h1OqcaHAdOXBh2o+h11Sm4gJodnhUAfBrV8vSU3POqkxk4gPUOlZxX+XTqkNb+vL1XojEUD8FLgo5hies44wKnuef5KUdTugwFZxUNWCOIuxRtOhhvoKB+DiF8WXWJZmc8+EK9K+uWFf+HTy4AoxIb1YN9gcaLGr8qHWrJ88qaCQT+CterbMllJhLyqNZheTmx5c96+90NENj827XsZa7TjQoU5nMlEXqt6PXGqvAjLuhq5vtoZdkvPtgWYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(15650500001)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(52116002)(6506007)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xa8991cvwjolQB7qPe8SJpwu6RgYk39N9UkNL4TcnoWTDn8+aWrS8MylDiP+?=
 =?us-ascii?Q?aNxOLH1cHGyH63uKOK4FXfwha/YIDxFhl3Zu3IRHqm9D4zMtaKqomFGnbej7?=
 =?us-ascii?Q?cjEvlrqDUxUFrma10qRtEEDgFOEXayOfGK3El4oBIuCL2IY1TAKk8YlX7kdD?=
 =?us-ascii?Q?/QDu4QUbC8S+BXW0Z1heqdzXFYwUh5oWJg+wCwndJYr38XXRN1uUA/ZnSi32?=
 =?us-ascii?Q?Wh3XOQTAz8i9sGSQBlnSctZbeWPvQ0rzHrqQ7blJjcndAGQL5EUMjbfCKceY?=
 =?us-ascii?Q?CGedZaIyI4gnzLd919ydkHuNCw9T9yoEMbkXPFyeIBLYRmGt34ZNa3S9O5PP?=
 =?us-ascii?Q?3BBpcoc7hFXXZ/fQL1FQGG70eQgat8zfCtXS987+P/JkkvFTAW/KbM9sQGpe?=
 =?us-ascii?Q?UA/EG0yceGYR1inNFsUPLEJH5oAvUWYNZi9Hsu3VdtTfHJHoQtw/71XBLnZb?=
 =?us-ascii?Q?PpzLFJQoZ2dST9GE/7br278FN3mDiGt6iT9ZSPte0d0un85rllxhkF7au+oD?=
 =?us-ascii?Q?pFIl+/cT73sdJxDY0QIIGHt/D7nzqj1wabuHW0Ea0TwbmC33fa9yZTxfjraf?=
 =?us-ascii?Q?19W1zGRJXnG9An8bo67j5atlIlN8NBvtmumHBzqTHrUKz85HGJi+2cTBebRB?=
 =?us-ascii?Q?dPlmS99dTlQbTVwGdsp114Lycg272+Nt4Ff9pHCmBlpDgKLilvx5M9EtgRVK?=
 =?us-ascii?Q?KmXAK1f9wVa/WvJmv7mXIrhlfD8R91YqefrK3lVgRVuvadrL2oY4/WBF4FH8?=
 =?us-ascii?Q?+dKpRNt5ofRWExBCJ6Hy1fx4s/nrpWCUUVdbhaNgqrbId0OCjIGPh25GIj5P?=
 =?us-ascii?Q?ht7gdlC4MsO87iGn38GK0kQTzXQd4f+32pEXxl66K2ZONMScEPlRw76iY85z?=
 =?us-ascii?Q?o/pLsHJAGK+fwY++BGYGr3jNvK3FL5p2pyM+tqJv3878P11ar0n932fLP1lX?=
 =?us-ascii?Q?gibelHmh0IoQ3xT3msHdhNRNNr6iDe8kA/TsFg3swMcsBDzeOP2ZtdyNP+UG?=
 =?us-ascii?Q?vc97Q05imgYOp6HIjmNkoYZL1Rp2ls4JUOLWMTXwx97H8eY622J5knn0JtYh?=
 =?us-ascii?Q?uQBZerpTMHwH2jMSiYN0wfNj4QtOEBNiG0m4+Gml5ds786DtFyCKMMjEhIVs?=
 =?us-ascii?Q?jx1ohyUZCtWLelVk3grqWSTqwmBKm+XQHl3Jq8n8amFK5+7kpJKhRj8WWgmQ?=
 =?us-ascii?Q?nSltABoiX47T/FXBbzwJlJCY3BAEqR26ZeT7hvdemO8mSUTE6eSlFo3irV4h?=
 =?us-ascii?Q?j4sRoGDG442VxFNsl1EHl4Ze0pY8tNKey41wB2Xn9JSotYV0NnIGanDX+2l2?=
 =?us-ascii?Q?YxPnpP3k5QKrnhLcgVaumPuTZgGb7N8j6HAdEL/KAGnAVi++NncKf+wnDcax?=
 =?us-ascii?Q?8WflbGeARjlpFWziR4oPdco0F/tH92AFlRGlwIa5DSl/N3mavGNf2VnW6Bg1?=
 =?us-ascii?Q?g06n06jLQZclseDJuB++4SiFgMmzwp44Hx2/D6iXKuei4nZYw617T9SD7aHJ?=
 =?us-ascii?Q?VHuI76YxacTRnfc7YlLuiPzXkpQZF0J5b+criNHXGkso2OTZHRqo/UhEgQsY?=
 =?us-ascii?Q?EH8vsmoLtsnDiiz3KlwnPLxJPJExbgP9GCAWrc4x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1d7cca-28f8-4013-5457-08db9e70f0ca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:53:32.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31rXa89BWZeqPf3Qu6vP4tOMO4pJGHWF0DzhKr2rJ6MRo8XfSjxzNJ5CX6x6EK0jI/8Gm6jbFMC2IbSV5kmlDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 11:06:31AM -0400, Frank Li wrote:
> On Thu, Jul 20, 2023 at 09:58:33AM -0400, Frank Li wrote:
> > Add support to pass Link down notification to Endpoint function driver
> > so that the LINK_DOWN event can be processed by the function.
> > 
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> @Lorenzo
> 
> Could you please consider pick both patches?
> Manivannan already reviewed and only impact layerscape.

@lorenzo:
	ping

> 
> Frank
> 
> > Change from v2 to v4
> >  - none
> > Change from v1 to v2
> > 
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > index de4c1758a6c3..e0969ff2ddf7 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -89,6 +89,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
> >  		dev_dbg(pci->dev, "Link up\n");
> >  	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> >  		dev_dbg(pci->dev, "Link down\n");
> > +		pci_epc_linkdown(pci->ep.epc);
> >  	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
> >  		dev_dbg(pci->dev, "Hot reset\n");
> >  	}
> > -- 
> > 2.34.1
> > 
