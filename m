Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A957CAC38
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjJPOvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjJPOvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 10:51:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E618FA;
        Mon, 16 Oct 2023 07:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLV99L2ZUbb9on3+785Cx3RAPLuwFOr8AtCR+Dh6BCXb5DRq9TPej3ghs+8A40I3LJP5zq/xSY2lSM46kHkuSKwb5C4N1G9ckMixCgX6Kydy711Z6kFM037Tle0xClo4hCkuPC+u9QQJSVFn5MI3su7s7vpCrNy5rRve8yefxqzZJtPYvdcT5sAQ9Vwb6X6coU9XN2fF9JR+cpGuh2Dj28ms+WO4NSP4B8/T2csXyCzKHdg3tqXVYN0ZaQjxuEppztgJIKZjVMUoCOw7iPeTs9tNPa1BpVIpFqHLCvqqEfzS1dTvXkKWcVU6bupZ5mRiT0XZfM/3rPyxbsEcghryVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUKYQ7FMpF1VMgPFZFpCJdlZckGLoBEqjgcocEcG0vk=;
 b=ioZv5ywWoYLoGrPgowLHNUfPPs8xAQb7jNSsgxUqgDqQDsj+2CgoCXalGLnpYnH1exhcyRy/FVvWNOXv1JlhT8Bt96xVPfDjj+hk60Hk263AKzp0mjwCQTi5FWCY13CQo2cYobC8iSNRrim1Y5E7NxHKbxN+LfGB5+jUQ2PryFI3zMO+BLqEC/3QIc1Dz17tdnMoc83F30f/63k/UylVuIooWN+cO1i+bUZCtw1jTz7Bk23A2sQQ71gCPvftWu4fE5JVK4agrgjiEIR6v/byBvMsX3hFQcyCrzw3fYm3kfWN5gidW7znQbnQYOXCGxbd7JVJnNZUBmsTrkm4SYkStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUKYQ7FMpF1VMgPFZFpCJdlZckGLoBEqjgcocEcG0vk=;
 b=WtY9iA6Yc1OBwmHxoy+hNEwxNEvka5ezfaSI5lvGMi3VxVVpYqcW2Ib2neieoVJ/pElq/dFBKdYTlNMJIgYkiSWz8T76dx8D4XxvO0s+kZOeiYorobex6yJBMYmFD1MA3M0CdTbX5AU4pLfbN2spbUKEg8Oth6R85PvbWVXkrvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:51:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 14:51:09 +0000
Date:   Mon, 16 Oct 2023 10:50:58 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZS1N0jgGYfmMsgrJ@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
 <20230930090249.GB3564@thinkpad>
 <ZSVd5GN7lJUfdF8L@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSVd5GN7lJUfdF8L@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0c0bcc-03ad-4018-7f22-08dbce575530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHDWD6KFZ/xaGAitQyao6sFFBFqhNgiFoxEyki8tATD1H5J9dEbDAx72seE/987BbXssyXB3UxpaOUhR2BZBIrPqgNfphg6GVytI4JnodhBdPduIqrSOGDWK2tA3IBwIWvlQD8FiX5X8/eyM29++C9D8q04BKtjesUgcK/CQ1JasBQk6sI8q4tsDA2ZWRiW44VxXVIYN0o8UeXQADVnP3pNq4RQxYOwnFF7f7aJrj7vp1gF4J0SIlg0rRtNwwpADz8SPGhb43iR8eBJv77Fh4s+zvHyTp8Z3Qo3APDm386Q8+Pl608TzNDDzPTwxAtqHGqGchJqwyKmMHjNSyR/B7neylKfBh+er8lqQaddUo8vuyEYsQXYmxpnWLWDOj/CWipt52C7R/W4iDjXgq9YL7vTratD9ZzUyVbSmC0ugUh8dcrBB/UuYP7zt0+9MWNbUccLdFlkiXFOMIxcQYqa8zYEQ3hAOAi6r2Eo0vQGcW3c3BQ69o8AN5FO2bX1YF+a2nfTCBJUvI06JyJ7036mgc/jRsACMQsGQqzDOcnyrk9aKQHRYpMzmxmgsFobOHhJbXTnJWdQqjJ7yFcta8kRZCPARMaqzJgPgoFnI2FPNwwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(966005)(6486002)(6916009)(66476007)(66556008)(66946007)(478600001)(316002)(26005)(52116002)(6512007)(6506007)(5660300002)(33716001)(8676002)(8936002)(4326008)(9686003)(2906002)(7416002)(41300700001)(86362001)(6666004)(38350700005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amdiQlVZcCsrT3puak9lbnJBUTJ5cjN1TXNNdjZhck5qMzkvVjRtZlVVdGZN?=
 =?utf-8?B?RXhkemg3ejA1bnVGU2NyT2Y1ZUY5SU5QYmdUWkpIS3ZIdy9iOW12bmNIK000?=
 =?utf-8?B?bzFIM29mcm5oOG41cnlWeVpjUVZBbUJJRmZRazkzZWlVcklwNkhOVUJMN2JX?=
 =?utf-8?B?SHFJWDI0d2x1U2FaZlkvWXdmdEE5RnkvMmEzSUdIYlA2cGJUYnNpTU5LZUd2?=
 =?utf-8?B?eVZHUzd6dG5HblZzdmMyRjBNQS9paU5KTXFsQkNIY1hwZmJFcWdaK3hMeHZW?=
 =?utf-8?B?Q1paZE1lbHdaVkdGV2pwcGVHZ0tTOXhUOTQyMXdhZEFvVGFIUEUxUW1DdVcz?=
 =?utf-8?B?d3pQeWthVjQ2WWRyVkRuajNUS2FkOWRYcnNicTh5MDlSYU5TWVBValBIUnZn?=
 =?utf-8?B?S3M0czY1QnRxTnljTzI3eDF4Snhna3dOYUtEejVhSjJzbWlBYUdNUFlwWnpE?=
 =?utf-8?B?UCtvcnlNYno2TWJya3ZtY1ZBSVV2Y3R6bWpDYUFuTlFLT1MxT0NjSWV5ZG8v?=
 =?utf-8?B?b1h1SHBvSkdBSUx0K3cvRHJrOWdGQVBvNFNqTTBEb3FJcmRnN21ET1FKQWFH?=
 =?utf-8?B?dWFsdExJOEVsWG0vN1ZiU1BzVTBYUm5RdldEYmVRSjJGdG10RnhZaTZzRE82?=
 =?utf-8?B?MTlhcGU4MjloUDRGSTJlZndGYkI0UjBVZDB3MzhMUmNGbWFSRm1xUFB1L0JT?=
 =?utf-8?B?VkQxZ3dqa0laTU1zdGlPeVZoNk5zMlQvTERhcWlEUGlaNVUvQ0g3ajZUc1Fs?=
 =?utf-8?B?OVVaV2xCTDdrbU5wd2JINHdybXgxbDI3VzhYVFc5NUlCV3ErV2U4dm05cFdo?=
 =?utf-8?B?cmFhQ21aMVBheE96SHlWQ2x2bUNyK0prOUZTYXliQ3FIOXpjL1dxSnVaclpT?=
 =?utf-8?B?dkpLWTRuRFhDOGZEazJHaWhHY0RJem9VRzVMczY0ajR2aHE2VXFsVmR3emxM?=
 =?utf-8?B?cnFCS2lIbGdGVXhYb0piY29JU2xodytqZFFhK3BiK1ZxYkt1VW0xMTBDQXc0?=
 =?utf-8?B?bVlNQ2J5ZUN5Znc0YkhiRFhLTGI4YmJYSVhyVDlza1I4UFVWNHl5UFVJcXZ0?=
 =?utf-8?B?Z282RXZPamtYRmNXZTl2akhsUnZyck5SOGYvaVpEWitaYTVpbmh3UzBsZ2V2?=
 =?utf-8?B?YThFUGs1UERoZ0JDTndIWDZXcFZrRGVMYjF3RkJHT1dTQ3p0dEN2SWs5cXVE?=
 =?utf-8?B?cExpMEVVNFZxNTJzN1dFTG1kbFhnRWd1aklnOWk3ZFBEWnN6Z0ZPQ1g2ZTFB?=
 =?utf-8?B?U2FUc1hQRko3OE1mamNLU2JNYUdmWkVrb3NqRGNndldtd3pneWpvZU5wNG14?=
 =?utf-8?B?QnE2OG9vS2J1VkY3Ry9kSkpLM2FUTDNLM3ltOGFrWDExVU5UanFDaGhiZmZ1?=
 =?utf-8?B?QjFUTUdIOWFIdDZVWnV1bmxvbzA1c3Q0WEdndFJCSk1SUFU0MWQ1cVhLR1ZH?=
 =?utf-8?B?UUlkYzZxR2VZRURpejVXbHlXd3VxNW5GSUVyckFwZzZhNDRiVTRPbGV5UUZ1?=
 =?utf-8?B?VUJzdVhraFJMNW5uc0dGRFFzeklPbVBDZFUyNld6NXhBdURnRXl5WFBpOGhM?=
 =?utf-8?B?cDE5S3ZwNHFrbUFhWDgxRlNaSXQ5WDFkK3FFUEYwUk1jZHRtbGptcWtPdWQv?=
 =?utf-8?B?UW1SQzJpeVFteGMrUmp0Unk3MnBhSDcyaUplZUxjdFo1cW1SRWNqUnVPWS84?=
 =?utf-8?B?RHdSM05kL2wrU014UUpIc2hTUXhGamtibk5YdVprdGcxUDJBSTdJNkVNSXBu?=
 =?utf-8?B?NUhUbUJmVUYxTnVLUlRTUGV3V1dCMGVSRnZ0VGxpWE12MEpnWVBOUXYzTTJJ?=
 =?utf-8?B?eWJ0OXI1NHoyZlhkS01LOEg0TFFOS2EvNTRQVkIzL3hWU3N3M2UzTS9IUllq?=
 =?utf-8?B?eHcyWkV2NSszNExZZUxNN0RxYldqajVJQ2lTRzBENXkraC9OQ091aEsyTnFo?=
 =?utf-8?B?VXFGaWFEYWZPNlNqckJkNWpBZTN6YjB0ZHlHV0lqcFhrVUI3ZlR0YnVpS0pH?=
 =?utf-8?B?MVFtRnUrTThua3Q1anNMejZZZmRXdE1BMjJtLzEwalk3aThaelozaTJjbGh5?=
 =?utf-8?B?TndhQ3lCaHQrdWIxa3VPNzJULy9GdWRNa0c2NUJ0SlhkTVMvZDNVK015UGVu?=
 =?utf-8?Q?arh4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0c0bcc-03ad-4018-7f22-08dbce575530
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:51:09.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFPgsZHfnfR8uNiCRXhnDp7woaAad6cmi41cLvGCdqFIjYbtd2rXv0R/w42obJOi2+dJjeQj69Zo0rDPtbF7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 10:21:24AM -0400, Frank Li wrote:
> On Sat, Sep 30, 2023 at 11:02:49AM +0200, Manivannan Sadhasivam wrote:
> > On Wed, Sep 20, 2023 at 05:39:48PM -0400, Frank Li wrote:
> > > On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> > > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > > │            │   │                                   │   │                │
> > > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > > │            │   │                                   │   │                │
> > > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > > │            │   │                                   │   │                │
> > > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > > │ Controller │   │   update doorbell register address│   │                │
> > > > │            │   │   for BAR                         │   │                │
> > > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > > │            │   │                                   │   │                │
> > > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > > │            │   │                                   │   │                │
> > > > │            │   │                                   │   │                │
> > > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > > 
> > > @mani:
> > > 	Do you have chance to review this patch again?
> > 
> > I was on vacation for past few weeks. Will take a look in the coming week.
> 
> Ping?
> 
> Frank

@mani: did you have chance to look at this?

> 
> > 
> > - Mani
> > 
> > > 
> > > Frank
> > > 
> > > > 
> > > > This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> > > > 
> > > > Original patch only target to vntb driver. But actually it is common
> > > > method.
> > > > 
> > > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > > 
> > > > The key point is comments from Thomas Gleixner, who suggest use new
> > > > PCI/IMS. But arm platform change still not be merged yet.
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > > 
> > > > So I still use existed method implement RC to EP doorbell.
> > > > 
> > > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > > and update this patch.
> > > > 
> > > > Change from v1 to v2
> > > > - Add missed patch for endpont/pci-epf-test.c
> > > > - Move alloc and free to epc driver from epf.
> > > > - Provide general help function for EPC driver to alloc platform msi irq.
> > > > - Fixed manivannan's comments.
> > > > 
> > > > Frank Li (5):
> > > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > > >     controller
> > > >   PCI: dwc: add doorbell support by use MSI controller
> > > >   PCI: endpoint: pci-epf-test: add doorbell test
> > > >   misc: pci_endpoint_test: Add doorbell test case
> > > >   tools: PCI: Add 'B' option for test doorbell
> > > > 
> > > >  drivers/misc/pci_endpoint_test.c              |  48 +++++
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
> > > >  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
> > > >  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
> > > >  include/linux/pci-epc.h                       |   6 +
> > > >  include/linux/pci-epf.h                       |   7 +
> > > >  include/uapi/linux/pcitest.h                  |   1 +
> > > >  tools/pci/pcitest.c                           |  16 +-
> > > >  9 files changed, 373 insertions(+), 2 deletions(-)
> > > > 
> > > > -- 
> > > > 2.34.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
