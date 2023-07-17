Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2837565D1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjGQOHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGQOHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 10:07:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66518C;
        Mon, 17 Jul 2023 07:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTTo8Pn3df0Rs9/Do8cHeKIzsQxclSP1TVvhPtL94qkchc4p6mIZWNPnGdgSiEfKlrxtUvHE/42q0NRfPX+ksCqy2e4n5fgsoe0kxKVBbkF5QZsF1KRVner/TUZbHMqZz19mCn5oQ0HDSGT7jG6e4udcwctQbAuiwlhpIToB8hD1rHto660GI4wmLWNqxsLo3MvRc9McxIeqoYs+kxTEfqkBMATecrxi7EFMXikliGc7tXK46z6yWQ0c7bkarqNiMCEAN+i8G3luOJ9fnd3gkIjxhTlhleN+ZSKM59orBpNKmyT7KkRtsaTXdTn+72JNigqNxb2VJaLlyVtDeoqM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9OQ5xnPKY1KWFbRwbp8EJtxzi5p9ygpr0ZyWA5WiYY=;
 b=FgDFxdWCMS+4kQtw1uDcwsilaViHR1Cz4zbE6cIB0yQsGKu6FRgA0XR330yjNgpFfSk7JFzbtK8FWt59w+kuUQZNy4mlZq089dpKXdm9tVrLL1/aP2FLZ9EVRp9whkO3p3EjO30rrnMvLtOI8Lo11oxgFX6lQp0juQ+DJOjlNE23eUVbvCBOPXfP4D9q9bYnlMO721pYZdmHjZn1NlI1Ti1e13r9S/ooXexbKZaWSaGBbf9Xu7jTphg6BLuTBWalgdvnWCpo2UrZ6woXgtQNZ6ug76CqH6S9dWdRJHb3aoVPeV/QdYATA22ZT2+QScqP6gkTJQwDPkfYW2wcQl8VKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9OQ5xnPKY1KWFbRwbp8EJtxzi5p9ygpr0ZyWA5WiYY=;
 b=KxNPTW6ZUIi8QL/XI9E/peUx6OThGzB1hewG5BrQrznkFjfG6aai7jKGbncBBWsswWuUqkOSd+Mknida9Ei24drNkaVNrbo5MIG42ctbGp8KZwchS7sBWa9GAA3pSB1dfQhM0kNl/P+vdnzgkYYUM+7b+9s4R0h8soSkIbz/OQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7607.eurprd04.prod.outlook.com (2603:10a6:20b:294::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:06:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:06:54 +0000
Date:   Mon, 17 Jul 2023 10:06:39 -0400
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
Message-ID: <ZLVK7xX7kPjNaah+@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: c32c2a49-fc47-451e-3df7-08db86cf1373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiwG9ZwnS4cI0fdpWpJOogSaqFIDLXE/Hm70CYbBoutB0NwWxaotG2HllLGfWuXXNCanvzk584fv4NZp0ts4SdB5kTYLtt3PLdK1gjP9Mnug99R1+x9z2PVJrYlwD7xf8sv0GYnGL36tJoWs14/RbcnRyw8adEGGQEwVjsmKZTm6BheoKdQ2wWrRC4j4GuUeuyobcCsWoiirG6TbjNRYF9leYIQlGCY8SLK5lDzwH6vb+KJHgQ3zOU2VoqKurJn2guN589U0LjDtFAy/3SqUgPepHE9/a5lGK351CWYFDaabJSoM2m98i/hVDitaf1cu3qFFkNbJB4FUiwMOTbC0hmKvPUeWlwRJ5qjOMNOhcnPzoRQ09n7NwgU2SkNfI6aq1+szmUgz6ZJS+ATlvXfi8hN/707XW8hBHXTmX6B2tlfh7INmtoSgWEX+B7CygXFChaIaRKHmCuXyyxHt79ZtLGNHHNWmPmIKtzHyCAjJyRpEODY2wpM10H0HmCVjzqxJO17L98EgrCh7SqEvlcqQrBe99jqbA7Kn9LVcv6p4ZJcOhxkPwhwVzOFboA3nfEP0QWbL3QHivBrcUZgejvpO1BbUDkjBAGnh5TsrTgUX/lFG5AGknx9RV0HtEr3Yg3yl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(52116002)(26005)(6506007)(9686003)(6512007)(33716001)(83380400001)(38350700002)(86362001)(38100700002)(186003)(8936002)(8676002)(2906002)(41300700001)(478600001)(7416002)(5660300002)(4326008)(316002)(66556008)(66946007)(66476007)(54906003)(110136005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUyE5aGFt34Qxkn8zGUGw95WVeL8NX2MEV+v9NTkhciSZy6fEZWp3Ol104N9?=
 =?us-ascii?Q?fgCTiJz3iNkz0YnLwdEFa/kEB16+Tjv1RLBYDyu4iqQvp9IIl6qckISwWMJZ?=
 =?us-ascii?Q?mq+rAR+svA9O4dsMv+2Cql+RpDioaeNo6eQdqwvMe9AQAEBQFvMTVkuXrYI7?=
 =?us-ascii?Q?uJd7O/QSU+yGBDKYBB8ti+OZ97lt/BOZ0fSEGVAmQ4fzGGNRIK+2DmG61W2D?=
 =?us-ascii?Q?zx8iQOPQKLOYbN3Q00SXopwIbjuxeBd1bf3VCsejnP6IPXOaaTJ6n7YhUoj0?=
 =?us-ascii?Q?9sKFeZSEtcEu9BprzylIVnyx7Ub0IOsokKLxQ9rxrTPHIMnSLP7JbGsFocxg?=
 =?us-ascii?Q?G6aLibMS+9uMhKdlA6Uf0ctxFQJjfhSrz6ic8csaUgJcKXwZvWzgKEbp7UvA?=
 =?us-ascii?Q?DBQYdIgGZ5GHkXvT09qXm8jeTu+YIxxid3Ap9tugJh+thN3ebKtkKxumS+tG?=
 =?us-ascii?Q?GwEwUvwFzVmnOxkRCphgikEkSdVOzmVqqzBZaaTrBNbpCOH9fXmHSwncT7V0?=
 =?us-ascii?Q?ifHW3P0dKqqLomHBIPKoelRB5dp0yi7AIHJZAPisTpJydcbHpi0ml3db77uW?=
 =?us-ascii?Q?lnUWm+vPjvw+e6iPRCrmXBSL76kfcJOjUUezFsgKJI2w2CSY5+qFv1zcWkty?=
 =?us-ascii?Q?IAoXIJjKv05i6TI/NKwp+I8FAq+mpH2LNBvQiWXEAQOyd0WuGEnYQDDf3kbC?=
 =?us-ascii?Q?EI+TkZUvtn+GIVDXB2G9fpWNF3ZouIRZFOAuC3cQGUIkZhjOSyp3cfEKqaYk?=
 =?us-ascii?Q?LTnaB2V8OdRV+Z2aamJY8e9EgpQ7CcEHRKev88utVhLvjUskQL7fPtmRWPpr?=
 =?us-ascii?Q?xCIoiamCdPOgSofXfRKUQ2mo9J+Fe4qvKdoAxhC15nPdW2XO713ThvmIKilP?=
 =?us-ascii?Q?EDtLxJ8xt9Jgd1uWLXv/+rDWSy3xAZpTb9rb8WkBKggdNRMU3Gu31/PU6fNw?=
 =?us-ascii?Q?5gCHrRvaPZ/MZ7kWekbnBdHKEsah0aWd4CPzmccm5QNCQG3jYPPDB2vxdREh?=
 =?us-ascii?Q?NPfbn77U1qcqeRchbZ6LeAzOQIHp1AXL1MipFrQyKw2aS07WdKtpZiBt7QDN?=
 =?us-ascii?Q?Tu/k/H1IYOjq09i2s+c8YuQnBfUTc/WncioBLuWYGnxD0r81En6Mo5lLQWRI?=
 =?us-ascii?Q?cmkptVlD7a4ecBh5AFoltDLa8/vgkvfffh1SQdmIBvG1GpG3yVHznqTfC3dq?=
 =?us-ascii?Q?6tdB4lppKf9jidfC/zFO91/5Cde885P2Q5prBwQnWvjJZVjVNRtC/R/nKH8w?=
 =?us-ascii?Q?YskeX3cUce2lV8s+rZPCKdK3rtneAIIbxFXgh7kXDoNn6W11KLrZyM5UVxN9?=
 =?us-ascii?Q?5sXr096lj7HkNfYPw9fbZppdMPfMeiVRutXExmzx7vgHFEIvHl1BTNIENAed?=
 =?us-ascii?Q?bZk2ngZ4eNdv4HNiLdvaPvqkvquk+hYYKVuHh1BUNCBwuIPKyqfqIBjYl788?=
 =?us-ascii?Q?LB5/FSlnut8bsMVze1Jw2QCygXc6bGUoggLt7rAm4eISQAmAMXrg8AbxZxMb?=
 =?us-ascii?Q?XX3M49YvqWMv3hQ8Gn6LYwvTTnT0c6j38dW9dD2o7+Fp+jxHPQqL1OjmeCrK?=
 =?us-ascii?Q?3MsWlFSI1l84eXp8R1Vv5U/mtb/NDJH0eI8sFded?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32c2a49-fc47-451e-3df7-08db86cf1373
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:06:54.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYjnzGyZLAhOaIGOuemwBPZWsrSt+Ll8qAoDuGa0Qh8zEvB4plx9ZMMik2vL1M9dHjWb2qDq3KyR4Gdv+6mbZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 12:17:25PM -0400, Frank Li wrote:
> On Fri, May 12, 2023 at 02:45:12PM +0000, Frank Li wrote:
> > > 
> > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > 
> > > The key point is comments from Thomas Gleixner, who suggest use new
> > > PCI/IMS. But arm platform change still not be merged yet.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > 
> > > So I still use existed method implement RC to EP doorbell.
> > > 
> > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > and update this patch.
> > > 
> > 
> > Ping?
> 
> Ping? 

ping? 

> 
> > 
> > > Frank Li (3):
> > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > >     controller
> > >   misc: pci_endpoint_test: Add doorbell test case
> > >   tools: PCI: Add 'B' option for test doorbell
> > > 
> > >  drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
> > >  drivers/pci/endpoint/pci-epf-core.c | 109
> > > ++++++++++++++++++++++++++++
> > >  include/linux/pci-epf.h             |  16 ++++
> > >  include/uapi/linux/pcitest.h        |   1 +
> > >  tools/pci/pcitest.c                 |  16 +++-
> > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > > 
> > > --
> > > 2.34.1
> > 
