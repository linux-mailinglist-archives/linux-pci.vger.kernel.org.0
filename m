Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9D76EB5C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjHCN7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjHCN7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:59:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6F199F;
        Thu,  3 Aug 2023 06:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0AHTOTNtSHD/gYKMDgM5EO1n0K3WhENa34rCG5xZz6NRl1tvZWADi1RpyyOmoF4ct3P40P/C3VwGjq9CJLk2agI4ZuvV3swtidJTK86C9llNfkQbadTqDzqnc1KCFT8RT8imzDRNavlFg0/GzkxzLpJIxD1Jjil8kQeVoYoK7JGPfjV0w7KNTIQ+ecIg4VIfjHB0QJIqAWYwg0MXE1hqMQI6ba4Mnblr6C3Fb1+wD/MAKauplHP75iycHOsLXTmJYzccorZXgcjVSL0azo0/pJTZFY1sHP28luyGJVUr14FX6uKvzs+Me7NNZUmvnZaKdcDPpmZkmgAhyiyx1LRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioc9E7uHiDEHaj7wIdZCIn5nTr5ZH0rOpyoLZwy2NcY=;
 b=iA20Mph8GmpDXo9O018HFStjTPnMzZCkvE4KWb5cWDu+/B59nbpBsHOsFbQhUk3p6GM/mTFXfn4CQThIZ02bUAEHVZJ6RFVyKJ1knnxxZvIaZ2A0yLaZBtGi8IgBuRYg4RXP0q77gW+hj5ig+2xmPkKYiUYxPL1bllmIWLhZ2p9I+IbkLLbwp2cr4AEPumgZD8fLszKOvK1/o5sOEmov9Vxo4Rr33yaCTfxg7ARG6224r9J7senvwWibEdvYF8/tR6NhIw6hDYWki7JcL0YPl8s3cstbHcUlCBMgT1tODtNGFqJgECANPMuFKT1ijLaLrsrRAErmKVPXmIPDKwqOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioc9E7uHiDEHaj7wIdZCIn5nTr5ZH0rOpyoLZwy2NcY=;
 b=kwglGhAL2mQ5RB0KK/GAHTnh6YEle0miPmGKSe9J7v1SvJcFk2sO0Dj0oGgP8y6SzYkw4e0QMAr7Xy8JcMkbaAdu4e1VEiW3oHq6XJvtRJxXIUAHZsXbOpcpgrdQzOLQ9jnl/fU45GZdHKP/aFF30Dk72EZgNddTL3+0eeNnxmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 13:59:10 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:59:10 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2 pci/net 0/3] Fix ENETC probing after 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Date:   Thu,  3 Aug 2023 16:58:55 +0300
Message-Id: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f65821-b0d1-4c97-ccde-08db9429cf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2NdSvVjf0PCb+3QAMXmDBUnT+at0cyT/cfJzed14dTP902SUHrE3moVZ+a5O3OOpnFNDmbEcw+zNqEW2zKE0i3UhHeWz6k2GNTPXk5Cyu7d5IZAMpLAXLI22vI2eYSz18W1WWFY2Jv+OXlFH7A2SWntjBhO6m4Y3kHRDmuOQDc21dlowZLS02yLPmf/Hr/Gh3am/0a5/twkT0lT9ewVQa4M4Hs1lL90fNqMeSDuNug933gKAzmD0PUu2k2ryrTf/ECfoaekfo6tu6R+E0lT0AqITvH733QRT+F6+5wshZH042WGyhIf2z3cl4oR8ypS9zWPP6CXuTybgvpb0kFooEWPf7hs+DhqAw98Tc6flq3vqJG0fp9+9hgoLpvPrS4W2pw8Buu/P6Wa/oCYrBxq9lY5bNBgK+gZzWlZIP1qzlZqmVfx/ux8K9LAh9VjQozClnd4uMRHIyqegGjn/tdM/Y2XoxX1ky2ah62TaN9+pbaK/fn6wo4OFAD/iamVPD1VBTWaTY0JcxD5To+Bhx5OAshgFDn/kc/0WZIH7F0uS/Od8SEkvvUyiRpgDCnGOfvV7iJIzymWhDgwQTsc/DQHqQZQ18gNok8if/TfgHstML4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2906002)(44832011)(2616005)(4744005)(86362001)(36756003)(38100700002)(38350700002)(41300700001)(6666004)(6486002)(54906003)(966005)(6512007)(66476007)(316002)(4326008)(66946007)(66556008)(26005)(1076003)(6506007)(5660300002)(52116002)(478600001)(7416002)(186003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2lTYLNzdGCYMSQIiFsKI5ggNn1OQnmXcBpZJPn+Gjs23DtX4WtU4ec/bnZx?=
 =?us-ascii?Q?iO9zX+CPmAddTfgsiKraNstXNIAQyrRhKD4iX0H8gzJycVJBLWtOcUBnxFgZ?=
 =?us-ascii?Q?03XN/C/Z12KwFodZYIfQGUdoO14hzZceS1M8ELnmnEDyRFLAq37IrlLwESTN?=
 =?us-ascii?Q?QA014gGmiQZaZtsJnTnUjbb3fv5addjlZ6VutxF6E7KD310wC0XDlwCE673Y?=
 =?us-ascii?Q?CfNfgvYQbSe+SfjwDibMrnnwL4PfPHqta5BFBfz9qzwmoUlmvIGJniyf35eA?=
 =?us-ascii?Q?NOlg1eMFIvvxOtZ9IgGnX/IXMYMW6mCI7FVGRNOpi4Qbwat8RG1WrabhTOz8?=
 =?us-ascii?Q?pfAGvL6P5r6fhvPC/qrhZp1ROvTmoNISfRAiKoyS1BS5HIPrFP6psNj4+uDm?=
 =?us-ascii?Q?LC2QdVUg+SynBkDjQrvhzf4kWJclL4bREoz5QWZk+IHVzc/+C9LUryVlGq9V?=
 =?us-ascii?Q?cNfuFWGoKQYzdg11J4p2ARihwwaO7LQh6qaIln9sQdy0692yvHh34D629q7Z?=
 =?us-ascii?Q?dFummxNzSqbA6v/qijBV6kbft3WrxEw4WkBDPuMJM5PXBsyvpkCYYZpKvLjl?=
 =?us-ascii?Q?8FC5cm5erC8d88VF6VpkHezDaLph1NCXedwq9s5+mQ2JgC7ncQWBh3qLKFmU?=
 =?us-ascii?Q?fuWIH8GH9Vm2i5Tbsb/VbuqqHLJvPYexMFbmsBBBBEaz3dV8EKGcycmViGks?=
 =?us-ascii?Q?zPUjjB2p3RaiAATcAYrbHuWWbuZJr41Zw7APKmoDZMsFFFHoYf8lG0JFtnsJ?=
 =?us-ascii?Q?qjuKr5JmFIu6NWSZlAS4cYFUDKAKb+SOxGNU7omktsHSI6VQa4Nm5YGZsDLL?=
 =?us-ascii?Q?LHOmZZX+wwlhm6bqsYuNEU2VBP5jEET9pVS109r1eqtNjPKR+2fzXpPo/UYH?=
 =?us-ascii?Q?D0ptVKfsCl7yYJQ4BF6BQKq3iegNdyQBYGE49vRzNQh7E4j9AAE9vxpfy2dC?=
 =?us-ascii?Q?CTGGVZh+43iy+8ARWlPwl9N5zeHRAFf4TyQhRklnq7x6yIX+q8YxDAXMFHq4?=
 =?us-ascii?Q?ok8YKxxPVEvEmOIs0//EK2M2TjsMO8zVs+2dNge5EGdePSPAJQGhlTYtvQBV?=
 =?us-ascii?Q?ZZf8ohcBI8uVqD62hKTZXHe9h9mNExF2Z29co1W54aOKh06BRRlAP5e9OLWT?=
 =?us-ascii?Q?YSS2Fjy4Sfe7mJyBq2M0G+HXdD5v6dAdU4ZvXhTMcZfwprLvb5gR1aTCnrq/?=
 =?us-ascii?Q?gfv7R0d7jeZnQyU1SOLeEsGGdOW/3Q3WEahWicFRJN6w+6F+Pn1QLVK2Vwwz?=
 =?us-ascii?Q?x7NoFmm1yvBYFO6phT6oKfmBXDDlrVSgo95UISfs0Q+BZwT0JUsnLEXT45yg?=
 =?us-ascii?Q?cpQwKVwyRzf+p/Gbdg0Fi9fjUozXqsnJ5XU4O/ZxuJULiRek//0SqnRXziSJ?=
 =?us-ascii?Q?cW8XKCt6SUoSHu9hMjrAmn4v6uE9bCoBoKV4IieNkLGmjOkkp6aeLrXLKW/x?=
 =?us-ascii?Q?hO/EoTRoF7MC1YdMabgVoeAN9+TbwdCgpRGZ7lQxBt8w6WglyYSyQWzgBV3u?=
 =?us-ascii?Q?2bwNcGrdW9y5wgbqcIHrLC32GFFdWXHG63VZDovkNUWP5ac8ymosAdiZxUuF?=
 =?us-ascii?Q?nlzRJnPXGN+kxuv1qqH6BdekovKfAwk7bJxLb1bYmG2XyjpvYD7gfc/SJVdJ?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f65821-b0d1-4c97-ccde-08db9429cf68
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:59:09.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeAK7H/8xGXQKfKepLwQOtk972pF0hPns3fbLJyNlJFP2UjBsAWVMKl+DMmxMzL0IHnl9zo4uX55JqEjrE5Ubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm not sure who should take this patch set (net maintainers or PCI
maintainers). Everyone could pick up just their part, and that would
work (no compile time dependencies). However, the entire series needs
ACK from both sides and Rob for sure.

v1 at:
https://lore.kernel.org/netdev/20230521115141.2384444-1-vladimir.oltean@nxp.com/

Vladimir Oltean (3):
  PCI: move OF status = "disabled" detection to dev->match_driver
  net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
  net: enetc: remove of_device_is_available() handling

 .../net/ethernet/freescale/enetc/enetc_pf.c   | 111 +++++++++++-------
 drivers/pci/bus.c                             |   4 +-
 drivers/pci/of.c                              |   5 -
 3 files changed, 74 insertions(+), 46 deletions(-)

-- 
2.34.1

