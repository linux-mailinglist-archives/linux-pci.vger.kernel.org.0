Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F46787852
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbjHXTBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjHXTBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:01:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030951BCE;
        Thu, 24 Aug 2023 12:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5YID0RQWM8HBYkbRMiEyE1/vFv+ZLJ4a5m9AVWg+Gnnxn7Ayuj9BJPvv1PoGk4t+qMSbm+nD21R0eespfqyDpkQLHqlT83ZNju2ert4o3X7ifnfIlEmm3H8BGSITSiFU7PrmJURGRYiF+x2gBxVflHAsjcR50S8rJWUr1HLfoHwJhn8O315CzK0iqxHqntmOwYRdvxTni88pEvhQjoWd8pabx/OJJBS9UhFF9S9Y67V63OiGyJpVCe1fG/s+xtk2l6qLuz5Fq3O3vSVfXrvN2YMcgHgGz/E+Ih/01kNBTs/OfNU2ImBKTNhYAT11Xq7lEuKAR7XCxd5/N7plNvyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL9T7NwWO7l2JB7m2fFJb3CYzqYVl/uoOP21Vk2r+lY=;
 b=FxVEnOngExikka1OueOWHKBLi/lpreBJNh66VVh6IrKIHhGEbgi5qgiXvFIVWYh4+RXTVhAK9dRR8ZL5Os10AizOWTAwVpJPElnahfXW34H3EyOM/rjfHggujvzi1zM5jE8HzINaT7HNkUFTlE0HWaFOZlbhQRVfUI33pdvz0mf57+YN4jYyditpTO+0Y8W10HNvJGFvqsAkq9dD8AOHT15OtsR5XaKnpbuvWGtv4MJ4KiAmZkt5SEWnwCBs7RRV934fvohirfT4B3SMF3Fu4buySjguDrY/Y/WWRlbmjb7NkoTb+6EmdqRJr0inYaJ1yF4CbreecSH9bDCo2XdjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL9T7NwWO7l2JB7m2fFJb3CYzqYVl/uoOP21Vk2r+lY=;
 b=lHoldhJmP2cft3iAF98qdIzJJ+OF3Zl/AWvVWeQoh/0Q7h2kGeCjKny9ZuRXsqwFnO21D7257AQAgu1CzS3r7IbboNDgfRVXLohQbGhbSjbdoVUsO1MwjSQafREcRMhK9GDgRBW4lsf6mDZrav0x/c1e3g4dkCBekEL4jjyN66k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9477.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 19:01:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 19:01:44 +0000
Date:   Thu, 24 Aug 2023 15:01:30 -0400
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
Message-ID: <ZOepCkqSnUmTdGHX@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
 <ZLVK7xX7kPjNaah+@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVK7xX7kPjNaah+@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fddd50-2eef-4927-b081-08dba4d48efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOJjNhuwIo4tGF212aUHbDJja5Gg2dhCK9CedxvoV7BKUlJVfV8kt70ib/hDMP7dEAIhj/Uzaclf2Q7ppAMwVWR6yC/FKlz7FHOBk1RsHKDmpf95GAbTE74s05IRQ1QiNWjKGRuUdA/rNnUHx6K/BXlpUcltQljVibn7XBwWTKVPkexA8pjSDsgd9/X70UnPv8ee/GdQymJlFOJPTvBEsAOo2i+tFzOv7zE/IAY4PBJjuTXUF+hqrGTzZF7tI3VLiMl/FsrepgIU7BRysmJmrsx/JZvc4hxDhxZ+B/5D6f9mA0mThFuwkgE2SyLv6kcf378rT5AfsH2c5G7mvbX/HLszQCEeWSRkz5oafDyawA8irzWkDnaay7KPzFtlMt5QxDlFwGk/li5cMuBatk+LimpvBJ1BchWc6d6LFz5zONe0ZE6BCLICfVoen308zFxIUCth9pqC0/kfFmHqj/e4KdhA0K+uaWocX2TV0GRHqjq5v8a0rE3s6TUO2lSEauJiqslspGFgw+fhWs/nkzXVUvfoCF/5i4EDz/QAgLb0CWGcGiTdSuU88jVzsT/y2JSF5leNePIsCDVjzMKmImEf7Iy0VPzKZ80txOqzpxWTJHjm0klnFFmCWTh2wCKrlIoN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(5660300002)(8936002)(4326008)(8676002)(83380400001)(7416002)(38350700002)(26005)(38100700002)(6666004)(66556008)(66946007)(66476007)(6506007)(54906003)(33716001)(316002)(110136005)(478600001)(41300700001)(52116002)(2906002)(6512007)(9686003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbCHERB2t17Yh8fASB2woDylN4RvJ2RUYHzFJidw3IzDxhC+HYiEcyiixuOB?=
 =?us-ascii?Q?mKLlcHe0ISPLb0+P5dOAUVBfPUS0zn+fl7WZxyniK70/+rM9+upFEeeQz1B/?=
 =?us-ascii?Q?6ETX3EHIXvjukuNEq3qa3+ufEBYUdlmiKleCwHlyoqvfDdekuiDKbq4I8uLZ?=
 =?us-ascii?Q?1oIMWhStSSt8eJa0luzf/F1FvKAmLZPXVaSD56fn9eBw3juKOBR2M4c94ymX?=
 =?us-ascii?Q?Yfjzqi+llUXAp+XLlSYkC+jPqatObKtaZq3FDytKBSQKWwQUWAN9PLYOXuXD?=
 =?us-ascii?Q?JWFjOVt9o2WsCuBYoKox/Y21C55nxqlhuAZvhw6STN0uI+SxGt3JQTnywtQP?=
 =?us-ascii?Q?0ec3ejC+EYy/FiUdgBGtDRpJdsOlE0ELIJ/blziFIkNbB3MTApYG9OEmsZYg?=
 =?us-ascii?Q?z3XNgv+qPasWxp+0HiAKFK/njQlhBdYHeJkPQyuKmkL5txB1HGowkZr9IRrs?=
 =?us-ascii?Q?dnDA8f6kpOLI1PzfcxJIpOksQow7FARiL4MQlerXtGtaTMd7PY0t8YlPwfyU?=
 =?us-ascii?Q?AN95tY7FQRoFL80UVYScZly/6W4Ej8N6raCHW+Gnff1NOd1g/pMQR8MEeQdc?=
 =?us-ascii?Q?jDuj2V52v6A2Rb0yJaBme+PP9vmkWbEniC4e9BvUnfB7pk61tY+qbifOynCY?=
 =?us-ascii?Q?AxFRkb1eZpdqsUVzwBVJXxvDzG3iHHunWEW2CpVs7kBwpXS8rVD/+nEnbiXO?=
 =?us-ascii?Q?acXlucwrGKVumlBtdm57iangXkQUr+w3iPOSJ7755ISGUk/iz97URtSjyL4f?=
 =?us-ascii?Q?+KgSqmfeLSXM9zS5hZ97LT/i2GYIlDTp7z+sNtUU01Wp0ini8Y159tlcONzI?=
 =?us-ascii?Q?XToQAWKT6su249ovlow02lVVwYCMAi4RQWNgwuGM5WMT0Yn8XBvJXU8EEava?=
 =?us-ascii?Q?kTrCgbPLy/eOyit5JO4p6JYkD/DOiFLp1Rcm/TT7kYMQUSm7Ajxg2vfzGRkE?=
 =?us-ascii?Q?lk8vBnxxEoBi6R/A0w1zCMx1GpCpnXhbD21gWVFmy91TnZgHKW2yrEcbTRCE?=
 =?us-ascii?Q?o0FU7m4bOduKNGz97n8ePxXJ99yvkxomftC8fgPt9FhX7z3lkVGtw5fAUYls?=
 =?us-ascii?Q?iHehqiBaGyLj5nMvjhLG0FD8FoHG4A3aa2lZM06i6qTunNPapmxlt11Z2pZw?=
 =?us-ascii?Q?oIaC5WpfLDTvqDJiqiQ6xwFLUf5rdfIyNZIM/b2WEtJkySZf9Y0gRU9cdbks?=
 =?us-ascii?Q?etSuyumDnZNfCa3uSxh4JAyf1Urx0CmnvzQkUgh2rPbEfSREPKn1SxqA7M2W?=
 =?us-ascii?Q?Psa1MDuvQaqbLvMt8kPvtzKQ1Ix24OHilrqrVZvwDx8bGJd1a7CYY1J6cdSg?=
 =?us-ascii?Q?HvPCdZSfGWDhGtewvuHetrgLHjia3PoO7TT4c73dg/3LChssF6ZDrUgvjId6?=
 =?us-ascii?Q?meyWTfFsBCCpI5Q/qdnPvcGuQXtzsJ/HnNcmCMy9gAoX/ErseSxx4pqgDWMG?=
 =?us-ascii?Q?ywCyTf6Jy5kGBUTLDh8S+lycK20+BN8zPuBuB9Z6meCtoe7HszWJYwGJkcQz?=
 =?us-ascii?Q?C0yDgUwC4uoCU87E6gKPm34/+FSpFiGh7fwQyLMsFhcgo3S+tmxWGNsJDdmf?=
 =?us-ascii?Q?sjrV4BSbfL/siR8mkulsA7z++o86ckTDiTXUyf5V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fddd50-2eef-4927-b081-08dba4d48efb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 19:01:44.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6FgnfEuLhH0/XHO8ZM3JDZqzGOiDxC11Xn4oYPs/m8xD3Iz5MackjP5fPL3qBZmPQNc8ZiSHtTSYAAmjgCfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 10:06:39AM -0400, Frank Li wrote:
> On Mon, Jun 12, 2023 at 12:17:25PM -0400, Frank Li wrote:
> > On Fri, May 12, 2023 at 02:45:12PM +0000, Frank Li wrote:
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
> > > 
> > > Ping?
> > 
> > Ping? 
> 
> ping? 

@Mani
     Do you have chance to review these patches? It provide a common
method with GIC ITS to implement notification from RC to EP.

Frank

> 
> > 
> > > 
> > > > Frank Li (3):
> > > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > > >     controller
> > > >   misc: pci_endpoint_test: Add doorbell test case
> > > >   tools: PCI: Add 'B' option for test doorbell
> > > > 
> > > >  drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
> > > >  drivers/pci/endpoint/pci-epf-core.c | 109
> > > > ++++++++++++++++++++++++++++
> > > >  include/linux/pci-epf.h             |  16 ++++
> > > >  include/uapi/linux/pcitest.h        |   1 +
> > > >  tools/pci/pcitest.c                 |  16 +++-
> > > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > > > 
> > > > --
> > > > 2.34.1
> > > 
