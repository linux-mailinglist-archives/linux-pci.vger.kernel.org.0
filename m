Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66A4B4530
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiBNJIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 04:08:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiBNJIh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 04:08:37 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2124.outbound.protection.outlook.com [40.107.24.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5059A72;
        Mon, 14 Feb 2022 01:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lePVFCUnrBBrUDYtSCA0qvvAPN0O46BrgkYT2WHIOZtbpVwjPsmiF+Oq2BR4oagQS6aQNk/NzOPCi+//YVMvSGrhrv5MEZoKWOrKC7D+y1yFo7i1soVgNaO7GeipL1MkGAKqp9ikucHEcKx1pKfvyb88i9t15Agkzr/UMCrcSGHHGbi+bEdz2F6lz+gPDsTc4PFsimKXY9DAl3iVm3l0fcjw2VVPGtfzNHD7toqw5UCjQetf5DQNSg3WewamQ7BsHqYOqiQJkMCY09cKF32+ERRbSlMItrwvPk8942W6tQzuedptPgLXBz+6PFYZplT4gMFHp+//UPO2EQiNuIUF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQG7byX+f6YKNXPOeBCsPMUrLJDu7rjuXgZVpVaAcPs=;
 b=c6JdXPtWzxzkqyGSE9ba2/RTBJZ4m/rMzbyV1XQlByZFOunU5Hx0wpja9dWOeh31A1hyn3lATkaOQi2pq4leSOkv7aLjCb9Y7zMI7sXCFM0D+B/wzd4ttwgUDYPCENygnero1b09X4f0XtLmNgwwPdIeXq+Tqfw+jrMMbMC5TX7attKp94PxZ231ae62SwAbfDzNyHwIJSwf3Gm8PbidiLHv3PVIj3uICLWXaj6tpPX7vxIq81whRsIsslRaAYq8Ll0/bNo9XKRzuqYb1cZHtjgOh/PAL5OkK0KdRJcB2+ckDvhxU2Uu1ZL9ohppBbOO8hLFpPF0NuLHzbYHX8cCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQG7byX+f6YKNXPOeBCsPMUrLJDu7rjuXgZVpVaAcPs=;
 b=oWM9S48AMqbcDMxXTLVedP+1RcGj6JzPHQQrUBrxxYz6Ze+hX5gJi+/6ZXWuN6llNszClMv6nhWsD+sQrO/ELU7o5ja2PmuVh2hsy63Oe1Lvr/m8v2E3AiloR0ZSEIKNPMhJaAgX/Dn1YY9cUtm7FX/wcD2Z5cS2FBaG8Pm9+38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GVAP278MB0645.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 09:08:26 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%6]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 09:08:26 +0000
Date:   Mon, 14 Feb 2022 10:08:26 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v6 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220214090826.GA7063@francesco-nb.int.toradex.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-6-git-send-email-hongxing.zhu@nxp.com>
 <20220211162758.GA287827@francesco-nb.int.toradex.com>
 <AS8PR04MB8676479F3B292252F3A7406E8C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676706D379F3B66D486D2358C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676706D379F3B66D486D2358C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: GVAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::15) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1095a2eb-8795-42da-87f4-08d9ef998f95
X-MS-TrafficTypeDiagnostic: GVAP278MB0645:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB06456F5512E6579D438AF8DBE2339@GVAP278MB0645.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xFeutEI+GEB7BJgkzCrpgsem0Rx4r95wTTWrF27Lh18XNA1b5jAgZc6v37CxaUltcA1STkz/lwLurA27YJtEiy7wymJlZe2ilFzuTKZHFwEAGvjeK2ypauCAUwb28uxpMBsTVkt/plk/0HU+p88tsCEsOk2hOjofi66py+OojpyWnvKBlffRp07nBNn5Pzgq4Tk04HwWRUcqTZYG4aH1frs3GJ8ikGH4DuPMZBt0ztKw0h4ZxZwfOwWh/9kzMn1nv5UpV9k5Sjq0GoCll43lMgf2VaeDVp6MyqfeS3NVBZWlHDLKglOnI50EUGaQRi8RCLx+RgDWxfQ8blouP67LVf60APWjsKBL2YfhtiXamom/8QMEUNsCUPeidn1oUyjt8oHQ155zYwzvF5KuosEkIhnAimUkMI3mGlPwyIEln0eO+uphuMFY36VUu0TU7HbUnBFn3k1ifz9NcaJBnWIwuyAWbbxKFgnpvQ9gKjLDoQ5LUjYb3YWr0GIkst739d7ro7+rjvlYXxM9SGoBl0BaUPcmsAhn1Vc9NgGhUb8BLzDdZ/Gs2JG1P5Pn8w5QGBwAUYz5oQg19q+yEQOlZHft5AAuQvwpg8kaVRXvQa17ozoJokuXWBWOLayGi9SA2LGg/B2Rujdv1AvwwC7GM0W/2Lq1HekDdn4sPA1zrnudZHbkoPj58Vmd47ziuovduK6kyz5T+XFFFPEz1bAr/7VWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(26005)(1076003)(186003)(6512007)(6506007)(52116002)(8936002)(44832011)(66946007)(38350700002)(86362001)(7416002)(54906003)(4326008)(8676002)(316002)(6916009)(38100700002)(5660300002)(66556008)(66476007)(508600001)(6486002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9A7rUG82kba2sllfRfzF5YJsnn0jCfQmniES0D6GeoL53MlPAs6dSRrTlxn?=
 =?us-ascii?Q?GC4yGm6wgIWI2JgTOddXzVoagTBhEKhFvPOc/CyxjjC1XLocA330yjMx3dVR?=
 =?us-ascii?Q?YbJ/W+nQRbWy/vefd/gygZLJJ3do6DniebUWJgPiuDDNW3iLXbE9bkNZP9BB?=
 =?us-ascii?Q?ku+3KZ5ceDibKXaxmhXpisA/UiyEdbaD4OB4yltIo//g/E/lQ2cWYhkbUInt?=
 =?us-ascii?Q?FCof4niYPCh+ajOID9rotOZ5A7UbVHJL3omdroVDzY07xN3DpahZ3Nc1N3Mg?=
 =?us-ascii?Q?6sRU8YOZa55ziqQ75rh3EPtWZ6Iz+GsBGU4S52a+RWCsROLKD2I9M0BE7FB+?=
 =?us-ascii?Q?F5rNBugyAoJQ2gIM5E7RoxP1eYOYYjgybfNLlown4mEsHhjDQ9yyE0lzmL13?=
 =?us-ascii?Q?PjNpWnG0PxU1hUEDFPEryWzcuGBFnn37hnB0nJuTv0YE8U8PbjEGrdBbtjVg?=
 =?us-ascii?Q?d9XZw+I0Gi9ZH+cN8kH692/O8cNgO9U2Ryn9o8qAEKD+bwaHMftpamvHhl/w?=
 =?us-ascii?Q?703/5BMH8RPTY+CTgJ4gD/+n/0qSzjlX6oh3n4mOMO7XmDKS3OuEFTZHLLq/?=
 =?us-ascii?Q?rmxI3glC8Pc2PA0k1ybk4i6YdjJXSupn7WH/1tAIgL4yr0Xpcmt5ZoK/HyUz?=
 =?us-ascii?Q?7j8Zio+N0MWXtmsVlHuORvcTgKjynhcxnAC+ymUaoSJuR65q49jMTRz1UU0/?=
 =?us-ascii?Q?9UQwI6lvL/BlZ/DjuztbqCLVI6PjtEF9q/9d0tG2oHesJi8Kj4i8CClpfDRy?=
 =?us-ascii?Q?eI8L9zT0UX+ZzttY48O4w2gnn4jo5rjLHum8z1NkrfGjt8FlEpI20Jc50uIx?=
 =?us-ascii?Q?J1XcJp48ZEXl+uhJLjjn1rp+vIVXwdGRV07DYcSXZ9XBRMPkXCmdpFINkn9c?=
 =?us-ascii?Q?JPPur7vhy1UEXQrwefR4hyB/KSFr0I1RgS5aUvC2Ty4b40YcRxfqj+wFTKis?=
 =?us-ascii?Q?Q/suyDKC8vAFNnV/mOWwRmIyi4kjsybH/tW0ljqtYdkLF2wJxefA4lASUrxN?=
 =?us-ascii?Q?p9fpRmJykdLzaiAaJ0nQxVOEEhTHEWcGEDvRt+7016+jS0+ClqPMvgJkXfms?=
 =?us-ascii?Q?Thpaq7ppeLTQrvB4AhXQ9MYK0oR3Yl4jz332VLFm/EJQCit8qHEYQxPrI1En?=
 =?us-ascii?Q?fqJj2xw6qYCRHhtmpmGma04fJEE67ShBgIXIqoJjUBcMthRRdv/NujJp3iSP?=
 =?us-ascii?Q?5lMy9CY5dRhVifAuf8dlttLQeSTE1CYjdn0fqm3K1bMZQQwAk4S08dlJ1NtS?=
 =?us-ascii?Q?0dImfOUIKlarbW2KHOy+syf6NvT5HunLPfNzuPwx+DBY1f1H8JP3wX/yp2wo?=
 =?us-ascii?Q?xHqTsaC7rvbBIGJeIa9kAes+Istgr+XuSG7/EMIFXJcEBCt7FIFlrbKtMyoz?=
 =?us-ascii?Q?6bZM4WHTGknL7utt97cYSrq/QG6dckyZWJP0lgLD93+qF4fgC6aq8OAe512z?=
 =?us-ascii?Q?RCPrHHSat4vCKnEeoJhHhs1xVs9LADG6szNYBdQGkYS3pD7zu0fZjaxSskXA?=
 =?us-ascii?Q?/mK31Vq4L7Mt7ZLxUykktvPFM5rat54nWK9hBHSbqk7Qpuw1Pb95hmySgdE5?=
 =?us-ascii?Q?y/wJzKnzeZ/jugEoBghY83tixZPimnAjU5QZwFB0Bgcvn4I27hLMDYQNRY0o?=
 =?us-ascii?Q?VVkVO0X2r7CR37BkJg8sKogQ5EuVEeZbgYfwM4Egmpt3n+jY5Vj6HqC9RDVE?=
 =?us-ascii?Q?O/b4+Q=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1095a2eb-8795-42da-87f4-08d9ef998f95
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:08:26.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOZLFIFcx4h9rInaAPHWOA/umEAtYURkgc+anG7e2Nc/lzO5erbvLJyv9QTRg77xjd7khty3cCbO5hASCAsoAb2ezdK3XpBxb1vHKjidIpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 04:52:25AM +0000, Hongxing Zhu wrote:
> > > This commit is not just cleaning up the regulator usage as you state
> > > in the commit message, this is removing the vpcie regulator_disable
> > > from imx6_pcie_assert_core_reset().
> > >
> > > I would not do it, this is called for example on the shutdown callback
> > > where it makes sense.
> > Hi Francesco:
> > Thanks for your review.
> > Do you means that we should keep regulator_disable() here?
> > Okay, I would change it later.
> Hi Francesco:
> One more complementary that we can't disable this regulator here, because
>  that the regulator might not be enabled at all.
> 
> But in the case of suspend/resume operations, the regulator_disable() should
>  be invoked behind of imx6_pcie_assert_core_reset () in resume callback to
>  balance the enable/disable usage counter.

Understood, please do not forget about the imx6_pcie_shutdown() path,
having this regulator switched off there is important IMO.

A small side comment on the topic, at the moment suspend/resume is
not working correctly for me when the PCIe port is connected to a
switch, after resume only the upstream port is working correctly.
The issue is present on the current mainline driver, but also on
the downstream NXP kernel. Not sure what's the problem and at the
moment is not a priority for me to investigate.

Francesco

