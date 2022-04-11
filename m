Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3A4FBB7A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiDKMBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiDKMBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 08:01:43 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2138.outbound.protection.outlook.com [40.107.23.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CB1B7A6;
        Mon, 11 Apr 2022 04:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSu7rbp72hQlFDdvxaLPoI47hxLdL7cvBnZH54c/ap0s7HWgfv5lvuGjBkCPuBddHUeFHpg1s7ffvgqQ9T4xvIB2yae6P42WvlxVJ2DWwGrp+7UAS7r8eCsRz2rnmEubT6vEjSayjFtoZURLKq3d+sYuqRMHnsLHkuGV0qp9bqsLRegV0lzv+gXi2NoNXto2sNPcuE1Onwp7pAdNIcS7wAMfFqRG2Ak1WTJQr6MYgPX/FamnqhvIaHygMaWh36oAdQouJotu15aOcmB51EUbR146NWoCJKdbedKcbx713Uh7lIAibuUWaHIyCSsR5dH3p5+djqCdXsAgOQKfPhNF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCjUSQxKMr/2JUyBkpnOinXGIH/plX7A0sTuqyfJkPY=;
 b=OEZk0gFRcJOx1R//inKLfZrQzdDbjd2vtUIBGggsqYc2Pn31q4Dppt8nbrTH9wGvpDfcFk5+jFmvtFHV/r1udZmQR9hGCPPRt0+Hwsi9GWg2tP2uVtWt2Ouek3cko0EWrX6gt2Ri0oeKEZhxikP6XmGFb28vy+HTpdxgZPqht5SZFTaxOt6KRxc21nk0VgCaD8Cn2FUfmyWi4GS+a1umPRKvbSHDf/FCc28DnFDADpazTtY7l/QPIQtFpDYl8zHIQ+zJM7U7vslXlOKXEcv7+kdatoSuqjtaUPVauDgwl0OW4sxT23oiUshsJnQlZ1AnBHaVy8o2b8DZi+q2+sk0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCjUSQxKMr/2JUyBkpnOinXGIH/plX7A0sTuqyfJkPY=;
 b=jHGpRk9HqDxq3Sgig8UIVfsQ/iswXx++K4yOJFUFADvCvsQzMwASLleIOzUcTVdpHymFlSV9SeJLqqwxXBD72hykynW/+3+weXBDtOvf0q6XPGn7y7nzwi44D6aKxf9aqTNC3MJZQvWQMRd0J8LWe+QnaiaCt/dGnMQm2Ni2Htc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0249.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:30::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 11:59:27 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 11:59:27 +0000
Date:   Mon, 11 Apr 2022 13:59:26 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        l.stach@pengutronix.de, hongxing.zhu@nxp.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <20220411115926.GA20890@francesco-nb.int.toradex.com>
References: <YYCOTx68LXu1Tn1i@fedora>
 <YlBFa46v5NtWxGLt@lpieralisi>
 <YlBKyBtbxMpvauLv@fedora>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlBKyBtbxMpvauLv@fedora>
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b619175-3808-4c36-da4c-08da1bb2ba3b
X-MS-TrafficTypeDiagnostic: ZR0P278MB0249:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB02492FB27A9758DD8D70038EE2EA9@ZR0P278MB0249.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKlrSTfF6NXd8NBJHbcj6G7pWB0RhXKkOGRPLTw5zeC6S+wqJ4FlmrdBTXhT9sw+8BsITmidPqFbChMaoq1wyj85FAq0frcyT5A9lHuxxBX9yBtt9jeiEbNKYTbl/OoNBObtO/KA1HBLAzhI9Fb9/8vx5wbu3tX9M3qK6Pg/hcD/IymfmZ5q5fTR3eh3gqzVZqjAgNb7Ub/g/vbQLfSXJg5zD+pL68X7doKK+KT6BSKVWdiF5G80cR6Nix+3qPnM2dr99r3XN401q+vYM4IMPfiROiFYuJJLtatr70jFnFtomyB4e4iaWh+jeKQFI/+0GYY0E4d/6JQhiMLyhVn448xx3fVdPKd3QBy0sern5vUl6+s4huD4sY2K5Fsq5Q9b/wVlFdHyGnzVUkybGcgVk8Rdru/RHvBnqsnq8JAH4eyFLNnqZ0T9tEgwzLAjQE3sR8GC5U9baoWz/xPvXGd6sfaqsuniJnwJsYjn2OFusnFyNhbPDCOJC75sPc4qanbLAiN5vxytp5VjMnyH1mil/rndJmT6ynyBhdMqYWLq5nmlm9u7Xy267y/olKx6q60zY1y3Om7Fqxv9rpcz0Bb75L69jWG9PW0pHg+orjbZnvoqtlE42Sa57q7sFsY9wd8lyXkb8nar+f9YsoPJvHvLEH6H3irEZpF/2bYptlgVsOpLNqC/8ANtoFSWzvWhzzsLWpwxKiTRU5uu9+o2lRcU+MBzxlAyn1CMyyKqWf/WOGhM25oam1/8qUZc0esXI3hTj58e3IwoECG4JKk9gknWn7CoRSQ4iJAxpDQXLlAJZtrGXUt0ZVy6QyFfs0fSIfnc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(2906002)(52116002)(6506007)(5660300002)(44832011)(6512007)(186003)(7416002)(83380400001)(26005)(316002)(86362001)(8676002)(966005)(508600001)(66946007)(6486002)(1076003)(4326008)(38350700002)(38100700002)(66476007)(66556008)(6916009)(33656002)(8936002)(354624002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GQhxQYha2X4fLK27stc2Zpza1QqYQ/0O/tt381M5/VkCZg08/OySqQaDmS?=
 =?iso-8859-1?Q?SozfN0o7PE0ag03RJI5MIsAd0dSLr2dXxDDJ6LpAFqbYjNxnmEx9WqaLsQ?=
 =?iso-8859-1?Q?rI0/XKi7I0bMLybI85VYn2vVLOYJhs/kOl1XGvR6iOEmRdaXzajm28LjVi?=
 =?iso-8859-1?Q?g+GAbSG3XUX7M/WZlrlBXrpGwbvB9HsL5/HLfnG0kgWu+BZlAvIKBnnrL6?=
 =?iso-8859-1?Q?VJJURPl1HwCIir8EOEanNnPHl1hmrxzc/x2jCpilxZTmH0aAKGk4UbiJaq?=
 =?iso-8859-1?Q?TJDhZ+eu0gdvMZGla3pZHLToHFpKBIV82erusoJb5kPgmYjDJFzW7pwATR?=
 =?iso-8859-1?Q?rkRuo1F7Ns6hmUC8MRwK0f+NDRE8/hJkTFeSbrbvCjNZ5WdPveC62vZpbo?=
 =?iso-8859-1?Q?7Dt2FeywC/OS4X96SRquxf7bw4ozAuQMdiBX3O+Z7zYDQUy6oG4fE+S4er?=
 =?iso-8859-1?Q?n3MaM6pVXspJkGznWC8R3eC1Hvmp+jEmligZ7tqb1SQJ7A4pJnzrOjlPuG?=
 =?iso-8859-1?Q?13Zw8EfG5iGi5iLm3MLK4hbbA/N6vmP7K8GRjKB397MtwpDMH1hSqVi5cr?=
 =?iso-8859-1?Q?xusz36JDPVTlZNyhr49EVkhYa5MD3YlsUHaxoPZDkX+k5WOe36jGhApnV7?=
 =?iso-8859-1?Q?c8C3NhAgs4SbGdnkR6BE4pxpvSbrFrFkRq3UFQ3YQPjIbbhMVY4NLCPqTr?=
 =?iso-8859-1?Q?cUbim209Dycp2dkiBdpxNmrdUHLXzXDYbouPQnJpI4p8t2q36gTkYhk7QS?=
 =?iso-8859-1?Q?xOr2xghyY3dQJCOLbUQghXkhwm39+cpamczVjw5S60BX/IG/EFmG7i1G8E?=
 =?iso-8859-1?Q?WzWg2qJu8v3ljEgmuDNo+HwXCcs1NesKnZwkEEfvmQGZOdcu/iNUAMpO0e?=
 =?iso-8859-1?Q?moOcV1C4ZNNtRMrIFU8xbhaAEYqmcQXEc5c/xTEc5CHtCMmxWbtJ5Kp6rm?=
 =?iso-8859-1?Q?wxieUW8O0QFm0tnSCwnoZ9/1wMAXKdT4sofK0f/7L/idhISXvkSwWH1vfM?=
 =?iso-8859-1?Q?r4lpq7tnB95V3u5/heAqAePw+FWqQ69ktD9n452V7CzMSqiNjiOowjnlCs?=
 =?iso-8859-1?Q?vVNW3V8187BBlCOYSdwZy1mQ349eqH3u2xQ2Yx1kkW4HdEOIzu64xlRT5s?=
 =?iso-8859-1?Q?mkKod5jbscldNLO1awqcUFk0rFGkBNG8RutXL7mcwiaB+tcdjCZl0N+m25?=
 =?iso-8859-1?Q?FlkCIvB4sRgQ+XO6Q7lGEpRZxI9u1jsaCxVXAnFBighwQDY/qE4nzD/PwD?=
 =?iso-8859-1?Q?BKhDnIzmhv+tSOWqFDjSCsf9TZY2IQ/iAjnfmmVQN7Y56ZVCIUvUksE4kz?=
 =?iso-8859-1?Q?R/PFHe/s+++MiFRYw/XTv/mPDlWmVDeTnGWs/HkZwUdom3Wv4sFSfEnR0M?=
 =?iso-8859-1?Q?dR0sWIWFNmAFvkKZZedVyFJHRP5eDB/UpE/l2XW17Qv6slxEoVi4cx0OxP?=
 =?iso-8859-1?Q?OhY3n3OZzPu7gm++4RP/9Z8nd3Yxt/0zQ/BvtXI0o90dpjvxjkgTsJakNA?=
 =?iso-8859-1?Q?k3NwW5IeupyPfA6fv40LislOcSwwL0id9UbiqQZuYZjGQcIl0x6P5ZdLVv?=
 =?iso-8859-1?Q?Z5VH0XpcwbyBtjLh0yLSmhVIa4lftrO7LeHQi2hMAJ2hFpK4n7o6nIrHWq?=
 =?iso-8859-1?Q?EXy2AJGN4YM/OXlL2cooD6rdFGeIeP5sbgdayY8OYmYWjacCC6/bJA5Zr+?=
 =?iso-8859-1?Q?y0r+MwKIK4BO/DmnfVJMRe/EE6UvvIEGyMnlOmY1tAkel7Lq6lFBvnrTOE?=
 =?iso-8859-1?Q?HCrBKkH3ePcemb0Zd6JBxIKVN+Wl2eXlL0NbYH1cGpz0npz7LWsUB+Q/bz?=
 =?iso-8859-1?Q?Jk1mRBEiPVb/pZwYZanKXdp8Ojs2UMqhkpSV1FmF3bsn/aiDC3xS?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b619175-3808-4c36-da4c-08da1bb2ba3b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:59:26.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwRq4eG4sDx9SA8bWCT1LELHaYynoXdEgfsBaaNXUGJJ1E/yrLX4cON016gD8jH/Ow1ovsPKO39hVohuE6FGXn69IPsz0JsNHHPraOuMA+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0249
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 08, 2022 at 11:46:32AM -0300, Maíra Canal wrote:
> On Fri, Apr 08, 2022 at 03:23:39PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Nov 01, 2021 at 10:03:11PM -0300, Maíra Canal wrote:
> > > Considering the current transition of the GPIO subsystem, remove all
> > > dependencies of the legacy GPIO interface (linux/gpio.h and linux
> > > /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> > > 
> > > Signed-off-by: Maíra Canal <maira.canal@usp.br>
> > > ---
> > > V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> > > V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
> > >  1 file changed, 10 insertions(+), 20 deletions(-)
> > 
> > Maira, Lucas,
> > 
> > what's this patch status ? Please let me know.
> 
> Thank you for the feedback. Since I sent v3, I didn't get any feedback from the community.
> 
> If you have any feedback, I would gladly work on it.

Just for you to know that it will likely conflict with
'PCI: imx6: Fix PERST# start-up sequence' [0] that is also still waiting
for some additional feedback.

Francesco

[0] https://lore.kernel.org/all/20220404081509.94356-1-francesco.dolcini@toradex.com/
