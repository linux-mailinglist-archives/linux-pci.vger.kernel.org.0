Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0249D72CB4A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjFLQRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjFLQRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 12:17:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A2118;
        Mon, 12 Jun 2023 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWkf4CchhKOsHGMmZNTtEoLVJIw4HYc0NzcqWKMhMX5htPDDGFU2L9DeXroE7B5IktJF5iVMnUsc0H/gTJmIJTqgiraqr4hSkwwDxLwC//qeCqH0/rG/fN0tIE86DDt0XtxSnfLUAiyfH9rEDfCdfD4ECwC7j29Auc1BlU+h9SK8xdkMvJYemFnefNihZN/6FpGnGrxQbeHBQcbvcLVzxlyBlA1qXZbtpmEGw9TQRdker5+eaqIra2WW+K3Fb6lOfKN5YB1bz1JZHodB3sU4kVsEjEmSd4VR1u89aBqjhDrVIaZw34zTLcta0SquyHFSJjT3NW1Q73EFQs844xOyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QIocaVIciX4e7LM4z33tjRZAyZOTGT8mZ001d3bMxY=;
 b=S3Klb8InCHxB1fHvOvQw91VXumxcXDJBItBaU7guxh35ZSMPkcKRLHa2AcUTogescQbKvZURIj5D3N+Gpn9YpmMVHC8YXIPNTkQyU9sqOXUXQCGnxlh31FYiR4qpsr3xjBiYo8Ve+NaV0OmIuxLVFE0fZQZAVQDNkAxWYERlM6M76+HK0/ibovxYyRU5S1onnl93eKJJ3E/QDt8IM6OFtDQ7jZXkfuQCKFZCtlNdFS4DBavJxexVw2VGqu2nXUg7nBDW9heT5uVq0wSTM3XgXggZ5Sg/UMpYRz998MHu6Xqd+jCpMR7f91KkY8b9ZPNTsnQCJsw/XMMX/6DZuL4zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QIocaVIciX4e7LM4z33tjRZAyZOTGT8mZ001d3bMxY=;
 b=a3VF1W/M7T8VdbrxtAm2MAxR58kR1Lo1E03FLiXbMhAG5fW2svG1gru8k/JwNWWKFT+i+UfIO/OT1g4qPG709dganZlkynrubXoVjvDHEkDMLagXpJszzCsbPJPUCJHVR8qA1ODFIKPjUpKjRqwxKSV0FOvrnilSq/FxYAiYfZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8852.eurprd04.prod.outlook.com (2603:10a6:20b:42f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 16:17:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:17:42 +0000
Date:   Mon, 12 Jun 2023 12:17:25 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4593aecf-3905-4b4a-b364-08db6b608c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30YnIGEm+8tbq4Ba3QRJIaG3vzpzSCWv2jDS+F1LOgK8wBhN8G2b22jFnr2V3rQYuoJS7C5MxEv24JAvydTw4JNEIXIf1CffdxUKliDA04hNRL9Uh7kO8PLrD+twOMIuxpiHZ/1ptqEZ+b7flHlos1Bxo3QepwkFkC/Pp53y4qhiIGMAom/l8o7JJFFxy3eRgJkdiM+ZOQOtZIm57slxE7Z+/Or0wAzao/FXgLcKhaAI/NtWIvSM/PivUoVgnOdEgg4+mgwqd44htT/12ZcbWD/bXHIf6pu54crt06eiVsJ7NZkxESrkRga6YrHqF1Hri2yxh14nn+OlHsZF5KVi072D7FwYa6kXKYD9wjvpTH9Tb0FWPLhUPL536ioGVpyAIl301XQbkbLL4awAa3s/Rh3zigZZaubI/EVqTUUFime3iM9+o9n48k4Ywz8Ng+kDgO+YwEZvy3olv9rRv+EmQi1nksJjIv8ZwxSfWOgsN3S7SuMy337s6rFrb+UuSwjF/Bgug5anGfMa04J7B2YFOKIFvag9KOh2VCGmrxejH4ZNopKjxU9fGvhSeSAN1nEnQeSbjqtPCytmKyXCDqA+ZQOf95uykQ/FuWDsG/XNVmuCwsoIbF63z2Fo1wri2yZm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(5660300002)(110136005)(54906003)(7416002)(8676002)(4326008)(66946007)(66556008)(8936002)(41300700001)(316002)(186003)(2906002)(478600001)(66476007)(6666004)(6486002)(52116002)(9686003)(6512007)(6506007)(33716001)(26005)(83380400001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhuvW0598AnPiqELE/F/ENd+HDjJ4pgPa/yAiJf8t64tg/TBTVI8QXjsqne5?=
 =?us-ascii?Q?X441C/3fXDKFK/by4OZwP6qUtozTZCLEAX+z56/09IJIntANylfJTONfAETk?=
 =?us-ascii?Q?JtWWB8uyBwnQbAX8YGJd9oITna3mFRaR+gx6p/8PPu+4H0FJPP12DO0hQr67?=
 =?us-ascii?Q?C1YQKbiJ40+w+x6ihGvLVlFOLygz8Id0+8w9+3FG3S1JoKVQlL8bShkLrUWQ?=
 =?us-ascii?Q?JL3bvrsB1KUL6EE1uke7z3UsMALI4h7YTpnYuTQYD+PZzMdiSIlHjJqyYfo2?=
 =?us-ascii?Q?Mv+QMydU80hPs0qO5z3iAV3FSrptVgI4DLE3PZfKbucEzSwPYpUSuJuHJ8sN?=
 =?us-ascii?Q?H5yjgP97TNvakYUtQWKlyEpvVNHP19VIZsQ2RGixiG6fpDfFaINILZxHHcZ0?=
 =?us-ascii?Q?AsMoy+vrDsH1n8sQn71jTW0I56bn97hsHDv5ZzgctUzH5SikFE6rnEw8WALz?=
 =?us-ascii?Q?6ihTZztozE/BdTsZxp3Hd/UTCLMGJo3Z6UF+9jTPrXw6kptFmNiVnGD75Fkn?=
 =?us-ascii?Q?MZEaP5dmRbbeDdL3MzUZNGoMo7EU657oOASX+qSIAx8rDdXkDJKCcWFtl04X?=
 =?us-ascii?Q?DnneLj6jUYa/BSHOLYXykpdFOZIkECN3WdCYJym/AOBESu6Ne1weewPIrh9U?=
 =?us-ascii?Q?bUv9glSJwgBL4iCaQPthmHFclNi6VInM6gNH0cPYmRfdE0LPzpLypwbpBAoB?=
 =?us-ascii?Q?jXX1ZA64a3zrsjMGn7/+5xdiC5D6e9A+pMJEsXQbXGRpMvGpCBvwnvmVTXAy?=
 =?us-ascii?Q?qm6XRU0YivLxZQSSpeJuig/AQLR3FV4vF0FhqVbIBmTOj5TcOCcH3yJv4NJK?=
 =?us-ascii?Q?Bjj/J3+vMPTQ5wkTsjmFVBkWNnTqSFdEiRCwETA7lCH9uY+AP/wTY5lRa49D?=
 =?us-ascii?Q?GPRMHoGpa7RB6/yCBDIKZ+go5+4IUjOhE+pe6IuAh+NJMMrF+lUfmdl4MPz5?=
 =?us-ascii?Q?GI3yJJVkiiLoKRK8tPtImC2m4PJQoJk6s9FuCalLsbLwUlLvqtRgzM7vfJEl?=
 =?us-ascii?Q?/hbpCrkyrAx5SXqzS23aJUty4GCP/K+/UT3oQuBgMs7oqowNkeaINoYsnEVZ?=
 =?us-ascii?Q?iQyL1ZtZtp5bmAc6vZ80tcp9azUDwEOg5AWkypaIvEzsu6bSxwnCSVNRokqI?=
 =?us-ascii?Q?LiPI75SmdQ1wn2iW81aoHDJLl84FweaM+phlL+tBTF3CyUHx494WqdDKZP10?=
 =?us-ascii?Q?+UtmH5R1xUgitSrNwU1jvnNG3ocfCDPBsKRCqEG5qHpF6rFE1pVvc6D1jv+k?=
 =?us-ascii?Q?kuSkUf1Scg+BO6QTZZzXbwxI19GuM+sHCO5C4UQKXhhXcxj4BaQbfz1TkcCC?=
 =?us-ascii?Q?+XH+kBikH2MqP0JzaWA/rE0699YJtBozlfCPgMijV4E7WKsF7lxYIbQPgMsf?=
 =?us-ascii?Q?PtJpUdmnQXcTDwPrgv+VR71oXW+sgtOfHEvtYe0syuzrx3+xcQXV2gQZxEjA?=
 =?us-ascii?Q?2vb/oa+d/Dv0/7k2RZcn5Q9cngeEMjuAa/chehgIaQSLSZGZw9DMF9ag33tk?=
 =?us-ascii?Q?CJICZHfqsjYGPWEczE4z5xLqP8mryG6GZRJJWng3muFLBIvrGK+pbIC3m4fx?=
 =?us-ascii?Q?1gWoLNcLgdyhOK/YV/gX8Ka+UwF0nlpfmtkOMqL9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4593aecf-3905-4b4a-b364-08db6b608c1d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:17:41.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In37QbCbfH2WeV9CeYoC0C3NGqTYAZ7KMZe3Ab3/VU4HCaFl145gTAkf+rthWQtSEjfqdUmy4oVrC2shkUcAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 02:45:12PM +0000, Frank Li wrote:
> > 
> > This patches add new API to pci-epf-core, so any EP driver can use it.
> > 
> > The key point is comments from Thomas Gleixner, who suggest use new
> > PCI/IMS. But arm platform change still not be merged yet.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > 
> > So I still use existed method implement RC to EP doorbell.
> > 
> > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > and update this patch.
> > 
> 
> Ping?

Ping? 

> 
> > Frank Li (3):
> >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> >     controller
> >   misc: pci_endpoint_test: Add doorbell test case
> >   tools: PCI: Add 'B' option for test doorbell
> > 
> >  drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
> >  drivers/pci/endpoint/pci-epf-core.c | 109
> > ++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h             |  16 ++++
> >  include/uapi/linux/pcitest.h        |   1 +
> >  tools/pci/pcitest.c                 |  16 +++-
> >  5 files changed, 182 insertions(+), 1 deletion(-)
> > 
> > --
> > 2.34.1
> 
