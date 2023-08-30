Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9C78DB34
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjH3Sio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbjH3S13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 14:27:29 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE7198;
        Wed, 30 Aug 2023 11:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFmM0U5K/re/I72JvB/LIivFyhvdS5jOM5qjFqKT950tBGn5AopJPmmS15krhbtArYT4RwF17GPsmQylXEK4h8nuHTFShen001BQWMYY7e6S8MjFDWgToaNWsLvneDTjVg7eZmqvanskzuKMgK1mr+EyRMyI3KW2OHH2bn9bYnSDRuf/+h9grOz+AvzwcO9dGpLJGIiJH4t069q8XhSo0s21xdrJDZqz8FWs7G4iLLpA5ATbfKwkeWMP263RVovQkNgMEkClsG/CY11kwmomZkhnzO8p/ZkJG2GXSk2m5OrVO6GO3b7amzchaKxeehuBD/h62yoDWko0nHZHGvmvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnP7U9jS81eVV6fyH48zwT6sfcUWwvbka9JYFNwBrok=;
 b=VlAO8GhLh1UmSZqLpTHqUMtXLjBfZZ+k/S1L3s7uMGILQSR9w8aRT74v1g6fkkrU568NeCpZqNP2t4l7um681KcawOsQTNvX7eh+5C8ISwilX5M3/kgpt6sB+KQwXYY/BEeC5JPZPfi7qLL/cyic24mWnIlKfbR0wQcfXOu/QIwigHcgm3VAXJUv4IJquepSiGvE7X6ZWh9Sy7mFKJ9SsPXZlGIAr3W281C3h0mBRY8S3W9ou2PinbEbsYNoHHgEg2RtRBaJXldk721aMzVVNYM5zO9HUO6hBC2o10lP8GXL1cYf5HlBQcWHt0pNkUfKh0KndjWr+NF27JbKEYr++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnP7U9jS81eVV6fyH48zwT6sfcUWwvbka9JYFNwBrok=;
 b=lPxVQy3FQFp2KHe1ZzvItHeDZebciQhsCvGrbMnlpR9vqcBq45ecSy81wM4rUg/m8Jsi4/KUxCT5YuEKWUWny/4qpvh3SIO3OfLH+UoT+7XBU+KfchbMMz3cYGfBb+7imTzSPx7uokXNFtt0KGkh06sHczXwSFj8hlD47cRuTKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7693.eurprd04.prod.outlook.com (2603:10a6:102:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Wed, 30 Aug
 2023 18:27:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:27:21 +0000
Date:   Wed, 30 Aug 2023 14:27:05 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Li Chen <me@linux.beauty>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZO+J+eg3TbvEKIUh@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <877cpdvv6i.wl-me@linux.beauty>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cpdvv6i.wl-me@linux.beauty>
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: d35aa1ca-a8ac-4738-336d-08dba986c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DMbIqRmcB78tEAE+eft/f+8NzN8l3TffjsD2RPz6LTL1c76TQESxeopOhpoQ6mdlGklCfP6fgIXcxvToUm/Ll1y+lIQNt8jOCm+diPIWZHV86H/L01JUcE5tfeQMnIBXGpbqBEqw5Wg3yP9HHeffUhsMJ7hwEAh5TsuSKq6XGxd21sOkyq0hLA5gZYv30jZN4oA9Zj08JYTn/6y2PqLNEvGDX9zWLbrki64dslFXD7Tl4y0DYdxEbmt0A6d1IHXZPj7RD+MKrMe+zkV23kPuag6L2kuGGJjYX+SrFmKdRUzhSfaFHA4CmFEB+pOFuXDPepHzSBEAppayK3c+bbTlF3bIQIGGmVKNnEDOOdj0NfUTtqfih793X25LhWQHg3VOeWblVXZsWt7/Ja8TA1cU368cgeod2FRG793+yW45Pbx5XCQ8rhUJgr3lgOv5pLTZ3WRE3yIgvW+UwYC2jXujuWSTRyQKnjLYNvZoYCyBMSxCLzr8x04gYMkfsKUKqr6+tXOmGEqacFTMEXC6NkVn7TcBFH0Y9bT/V1ANl0w6HbyffK+sh6a4C7p/vJdHINbWisei76y3kb2cBtgw0V59Bbu2Mw1/CGg5x4f5M94boenBzPWG2/HhKV6bJQNNo+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(136003)(366004)(396003)(1800799009)(451199024)(186009)(41300700001)(7416002)(33716001)(38350700002)(38100700002)(86362001)(478600001)(83380400001)(6666004)(26005)(9686003)(6512007)(6486002)(6506007)(52116002)(4744005)(66946007)(2906002)(66556008)(6916009)(316002)(66476007)(5660300002)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C2ZXriP3Z/hVEadtqx3S2/lORO+D0PHSpnOJwSCek63cK3PaSSEbK1wMBoNg?=
 =?us-ascii?Q?3uaQm8xtYtweJr5/iCoyrANgbgAyWr+OZ1O3qAoifwonwITBIurAI+ltOq5q?=
 =?us-ascii?Q?fl3HgHneNrmBKKETp3mthJtskWIQ+hWxb/9a/vkZ47mkxE7WFBvXguftA72U?=
 =?us-ascii?Q?ubH5VC7K7h2haQnZnc8PNOp9SCAOCQlQngF/ykzcxvRd69nv/asLjD+Z38A3?=
 =?us-ascii?Q?ryEOfD+vGLnBOh8WqJ5OfDdUqxht4wEA6mNN6s29rnwddgdkOwcDVsnWZfS0?=
 =?us-ascii?Q?/dvxvDijCrja/Seppy/yAfXvtHTf+ANQe3jQqqBpbFbzGtTOD4Uzj4kqv64F?=
 =?us-ascii?Q?b0hrPqH1H8rFQEtVWCzDPZzAoyZ8ow7bKXlgOb+qojLa1VCUjvl8ecwkxyaY?=
 =?us-ascii?Q?eG1vEpF1Eg4riRtK5hAwq7RTykNnbtP5sFYGYpOywQSFpqyNs0O4m+Trlaj8?=
 =?us-ascii?Q?MOYqHTMZovpoDD6Co3bkEjNW3nKdr9rt86FAq0rWei0pPKVI8VXabxOiJXyI?=
 =?us-ascii?Q?eyBTS771/2RJI8OqHH/F54KHZCJh+utxyZJDvAZqXBYV4nKidI/rrwJdpkS6?=
 =?us-ascii?Q?bRNydpiyMR/E3CHLv8rtvUDSiuhyuaoe7/VQxQ801q+vyWYpy6uCAKA2JLxp?=
 =?us-ascii?Q?SizZG3cbUa+mNFFWWZ/xE8zLOlIERccB3EFFd5nbpeDm9fbFub+XrOkvOHSa?=
 =?us-ascii?Q?tx2Vq2P01FbyZZtf+HP2Jm0k1XZBFCPUUKv5+2VpaqapXbuzsVsqeX7qCzBx?=
 =?us-ascii?Q?od5mE3Mk+vvzBwm2oX9P7k91fD5jhRGpVd1Si+f2TfM34gXhL94/v+XMqdDb?=
 =?us-ascii?Q?0q4638HEuFlQ0U5G4NgQtGqXgkrYTvLxULFvgbAceuJi5Yd7BiM1XITnG0bI?=
 =?us-ascii?Q?u1t5eZnCLRxqq0c6m2esogvjmhVJ46Fe/oyWLTkSSFtZWfU7g9wIq8NztIRm?=
 =?us-ascii?Q?j3HGspCfhIhayhz12Ft48ATLTTDEqxHBi72tZrOyuxMr6FV8NKargJGwVvxM?=
 =?us-ascii?Q?A8mt6sIfZA1qqmxLFEDsDPoQ9ayEurkS66OFZwxBc7Nxr8/BmEs6MCF7xvME?=
 =?us-ascii?Q?E65DdG9AhwfVO3sZQGp36Sq9BzG/k5d9qs2lRn54TIO4SBKT2gUb2hQGjoFW?=
 =?us-ascii?Q?JhRokhH6HY3oZx+tTEM3Knw8+AcnUU5q+sLam2FKLlMIOkvDLDJzgMCbAA4Y?=
 =?us-ascii?Q?qIMMjWwAGOclsNdWSPjge8apmfwK3AO65uMXRuphbGncdVqPaot58DeNd+E3?=
 =?us-ascii?Q?6Qm5MUiXvCAHMf/GfaeYWy5cfZeEsxlv6r+g+HBsLynkmE40f51hZytIwQob?=
 =?us-ascii?Q?6bkUZYr4/QMUs5JmgDP6Vr+OvhvYteGLj46X2pKhwIC9hoTPG2IWWFC2YXIw?=
 =?us-ascii?Q?y43GigAV1iL3QqpPy1ck2CsBXCcv0zCEZ5RJQLdrxYll/2BXQXnpRIK5nh8l?=
 =?us-ascii?Q?z7tbyqRwRo6W325/273SzPZbIjqOROLWaPt0ebT0J0n7cMeX1MZSznAlB4cY?=
 =?us-ascii?Q?TWPf3QSgFUgQu9aTd48PMrRZF6uSTXloe8wYyVQbHCjocPNz1QXp4oSc7ahn?=
 =?us-ascii?Q?NM51KqQhz7s44P88zVE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35aa1ca-a8ac-4738-336d-08dba986c000
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:27:21.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lM68itc1bBGiES5tBibXwGTfB1QmPALrNaC0Gx5YBENzwiKmG4Ew4o42wVamv7T/28ib68veEdnX7OFRPO/qsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 30, 2023 at 03:36:05PM +0800, Li Chen wrote:
> 
> Hi Frank,
> 
> Frank Li <Frank.Li@nxp.com> writes:
> 
> > drivers/misc/pci_endpoint_test.c | 41 +++++++++++
> > drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
> > include/linux/pci-epf.h | 16 ++++
> > include/uapi/linux/pcitest.h | 1 +
> > tools/pci/pcitest.c | 16 +++-
> > 5 files changed, 182 insertions(+), 1 deletion(-)
> 
> It seems that you forgot to add changes to drivers/pci/endpoint/functions/pci-epf-test.c.

Yes, let us wait for mani's feedback and Update together.

Frank

> 
> Regards,
> Li
