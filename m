Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA1544532
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiFIHzF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 9 Jun 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiFIHzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 03:55:04 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 00:55:02 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 477B32E4
        for <linux-pci@vger.kernel.org>; Thu,  9 Jun 2022 00:55:01 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-zuiVCqnoN1ucz7FCK5gIjA-2; Thu, 09 Jun 2022 09:53:09 +0200
X-MC-Unique: zuiVCqnoN1ucz7FCK5gIjA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0055.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Thu, 9 Jun 2022 07:53:07 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 07:53:07 +0000
Date:   Thu, 9 Jun 2022 09:53:05 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Message-ID: <20220609075305.GA20630@francesco-nb.int.toradex.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
 <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
 <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
 <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: MR2P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::13)
 To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f45fce-795b-4826-7ff1-08da49ed171e
X-MS-TrafficTypeDiagnostic: GVAP278MB0055:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0055B50E7E3139AE93F2A7F8E2A79@GVAP278MB0055.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 6qzeXLICmbujpvmO2mIemDnfSGfeu8iARt7ttfhIj4/f1sIni9YMu9al6HMHwufvHoYHjx2OF8ysIHtPXtJYbhV7SLstUl3vCzmuZCKjqWPMGyehYNLpOQCIwl01yjXNxtbPwnNLAihO69l04qjWRETrgCARYwSHRQOp1UtnAArLi7JU39CCUBBYqKTUblWH4aSDOGHu2l2ghzzJyyOvyN/TmrlGX0Pr5lj4+N+NUvAYLjIwnOSF+I8jXDn6kL7cEhe2FxT7kl8MU2eS8F326a+raxN9ajmaAHgaD2YEUfpwhIcyRd1YeEgWbKExLxg3RbfsAzjNsSVD76tKsgbpTQe1uK+kyxfmhhflXJduj/W4mP3bHPC1RSjXvc31waaR8h2OWLZqU7V1yJKzjuGKyUDktCpcuooPLxPu7g3foxZsJ7TY26amNXmWxuBXck5KwUWoFyJZKyMui4t+RtpQXwQLNd4LM8DC8q3FYTvCqsudwoqM5Jym48CWVDlbiNsbBDJePIVIXgKMFwIgoBAQV/UToASDncEZnRW8bo3E19vdTHWkiqJTNFVVYCI8KVDLp1tGlsLdIRvOqW/K+RPurSzYTgtw4ZTOyC0HpVnKmGawYXKWLyjARr4ifs+BzFhTUJbP5Fx+iLSNUfV5uIy5oKRzY7s554OlvjkW/M610/7G4BSo4ryno+b15TvDmylxOOdyAxb5EiyhVF3sjxr5ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(396003)(39850400004)(346002)(366004)(316002)(83380400001)(44832011)(5660300002)(66476007)(7416002)(8676002)(66946007)(4326008)(2906002)(66556008)(6916009)(8936002)(54906003)(508600001)(6486002)(38100700002)(6512007)(41300700001)(33656002)(52116002)(26005)(1076003)(186003)(53546011)(86362001)(6506007)(38350700002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhURATuq5WBfJYv8p9qTK+kGRhl8/hHvr3FQofgaKVTiMus+ATxyH6uQ+K1W?=
 =?us-ascii?Q?rCPBGm4mGyufRoCM6Av7D1dGc+tAwAMm2QmiSXrStfI6c/4xvkn0QIZYrxJl?=
 =?us-ascii?Q?C+6YJhZHoLBfk2AnWmEs3QR4UAPQbLREuQ3+HE5YcYK8ByDnxeOUdfiaTYRe?=
 =?us-ascii?Q?9IPFCBYMLu/44Gcwx44MyPj0lWdd4bQHMbLH081QtyXYZLPZxrHM65CZa1xO?=
 =?us-ascii?Q?CPItqgX1divqbT+jgz2kMezJ0h/BaKj7qHeLzrYf4BjzjQAqVx6B3Fzz4WYz?=
 =?us-ascii?Q?NRvqNHh/ohgjx0MjNvFs//FGrJU9rFz3EpqmdFD6eYLUm7QSmxLRmyh2sDYC?=
 =?us-ascii?Q?CHtloB10GfTnzol5lWpdcmcg6RNwISMfxGbx4pZKU5nhYp66zWKwRCfe9Xiz?=
 =?us-ascii?Q?RcJv/3yralQgfSSd9R8fCZ4AyqOpzmp9URQokf3ei2g/4bUNUkValxHoGz8R?=
 =?us-ascii?Q?Jh2XHTFLDTY7X48fRQaQ6cv4bRmXNLC5PJ7OFuyjuU/Urbdt/6BStZcA2b2f?=
 =?us-ascii?Q?YabL4GKtkCfj7VLizpTs8kegQCwTE+DGY0G5Wz3himuMe3excBfb51awqi8K?=
 =?us-ascii?Q?Th2lxPiKqtnB6khK8kJamjlnoJ9Ru0FEgqgzx6AhBdP16tBbljUqrxc1Bapu?=
 =?us-ascii?Q?1LjS5nhIxq67K4U19aBVzGrEd1fz12y3MhAtm0tEXgn5EsIgO5Z4N9727av2?=
 =?us-ascii?Q?0j2mqKam1Q4OmJQ3gX9Hp58kYRnjuGzgkna4rIgKw4sD9SYZf9dlYD5fK6Am?=
 =?us-ascii?Q?FvsKlo3WMVZr6yAticP14kZbxaDZpuFODcTjmsDOeRJJaaLGJ3MiZA+j+fJ2?=
 =?us-ascii?Q?p4qmWr94tsh/9dfYyqx8wAXpzg514jWAc7CCBbfpwindx+hIVM3MYZ+qydyy?=
 =?us-ascii?Q?kQM4h4h3kZsHHfgC/OpQMpc5lmDVadssXyBRYeSKpqCxXYV2iGVgbcBik80Q?=
 =?us-ascii?Q?/OjhrmIa58jICjUxu35/UDF1Evf7/t9szZH5bUh808g1H3H6cPC3xn9sHC4+?=
 =?us-ascii?Q?amMcvliWhXqnARVlh1RrNdfypndLENT3EbeWhJqd/ISitkYZb0TTooH7zfr0?=
 =?us-ascii?Q?ujLPEgWF1zPJO27yFxaj0CaFNDSAwDqaagKyZyPaPxR2B/BThkGtS80As2Ec?=
 =?us-ascii?Q?8XI2b/W9e9n0a1YYtCqqewrFRLtjMNdzWbKApBFUjP2bxsmtPLFQND3R/mqL?=
 =?us-ascii?Q?FfGiAUKnXepUKWFtmhW7lQAkXSZS6G4+7WGa+MXnlv8s5auu2b0AGPqQi7Ox?=
 =?us-ascii?Q?8rtyEy48ZQeVoOl5VhAv13pz/5BgRM+SeYJ4SKjGi32D9SkxtQnbI1PygTUJ?=
 =?us-ascii?Q?/krE1xxv15g+17Mywu1KKUNOETbwmxcHHLY8Tm1gcb71WSHIvUsrCBGR1fGi?=
 =?us-ascii?Q?xBd/MB1AmmmCXg4S3xl+f5xfFTRDGvNhlZpiYLizYwlwUnWxzBDLYWEINvKM?=
 =?us-ascii?Q?eivVSJnZZowo06NEMZgHqzgPhtGreduWBz4Xb38wPpR97+yq7iq8PP3UL79i?=
 =?us-ascii?Q?jL/8g15AGOLyK6z86aafLr5wny4vthdC25OvmA5kFkb3J03j+ZqUD7ot3RrD?=
 =?us-ascii?Q?sG7wuv6iafMCex3OR07ghsb11wbGdum8RDikc5TiFzxRaWAzQgQs/nY4WfTH?=
 =?us-ascii?Q?PqAJjZy+WDfD8qS+YKQgaV5kpVsSDFtTxounpE7cQoDSSSXqhTVu4d/rzJgu?=
 =?us-ascii?Q?bZ5jssaYm9ZTDrrsTVqHooubrHfavDGEMSCsr8LPfY1tjBKQ1XiXXEZG1WIN?=
 =?us-ascii?Q?n/rcQdfO8VOmgmIf60tXuGfCRv8GSq4=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f45fce-795b-4826-7ff1-08da49ed171e
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 07:53:07.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FK+78i1BCAlneeLWn/HbwUMIDlNXk0dj63C0fV3DZisOK3FhguoAFNknz7N/vpZnbni9JE/+2gX0Tw+HS/3mnECWR1167IK/DUeHtLPXJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0055
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 06:17:46AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年6月8日 15:35
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; bhelgaas@google.com;
> > robh+dt@kernel.org; broonie@kernel.org; lorenzo.pieralisi@arm.com;
> > jingoohan1@gmail.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after link is
> > down
> > 
> > Am Freitag, dem 06.05.2022 um 09:47 +0800 schrieb Richard Zhu:
> > > Since i.MX PCIe doesn't support hot-plug, reduce power consumption as
> > > much as possible by disabling clocks and regulators and returning
> > > error when the link is down.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 3ce3993d5797..d122c12193a6 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -845,7 +845,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
> > >  	/* Start LTSSM. */
> > >  	imx6_pcie_ltssm_enable(dev);
> > >
> > > -	dw_pcie_wait_for_link(pci);
> > > +	ret = dw_pcie_wait_for_link(pci);
> > > +	if (ret)
> > > +		goto err_out;
> > 
> > This adds back error handling that has been intentionally removed in
> > f81f095e8771 ("PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails").
> > While I agree that disabling the clocks and regulators is the right thing to do
> > when we don't manage to get a link, we should still allow the driver to probe,
> > so please add a "ret = 0" to this newly added non-fatal error paths.
> > 
> Thanks for your review comments.
> There would be a long latency if the link is down and probe is finished
>  successfully.
> Since the dw_pcie_wait_for_link() would be invoked twice in every driver probe
>  and resume operation later. Each dw_pcie_wait_for_link() would consume about
>  90,000*10 ~ 100,000*10 u-seconds. I'm afraid that such a long latency would
>  bring bad user experience.
> 
> Here are the logs when probe is allowed when PCIe link is down:
> [   55.045954][ T1835] imx6q-pcie 5f000000.pcie: PM: calling imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x8 @ 1835, parent: bus@5f000000
> ...
> [   56.074566][ T1835] imx6q-pcie 5f000000.pcie: Phy link never came up
> [   57.074816][ T1835] imx6q-pcie 5f000000.pcie: Phy link never came up
> ...
> [   57.182300][ T1835] imx6q-pcie 5f000000.pcie: PM: imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x8 returned 0 after 2136334 usecs
> 
> [   57.182347][ T1835] imx6q-pcie 5f010000.pcie: PM: calling imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x8 @ 1835, parent: bus@5f000000
> ...
> [   58.210584][ T1835] imx6q-pcie 5f010000.pcie: Phy link never came up
> [   59.210831][ T1835] imx6q-pcie 5f010000.pcie: Phy link never came up
> ...
> [   59.318313][ T1835] imx6q-pcie 5f010000.pcie: PM: imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x8 returned 0 after 2135949 usecs
> 
> So, I'm prefer that it's better to let the probe failed when link is down. 
> How do you think about that?

I think that recently Bjorn mentioned some concern with this approach,
and I agree with him.
I think that the probe of the PCIe root port should not fail if the link
is down.

What is the reason for such a long wait in dw_pcie_wait_for_link()? Is
this slowing down the resume process as a whole? Why called twice? (I'm
not familiar with that part of the code)

Francesco

