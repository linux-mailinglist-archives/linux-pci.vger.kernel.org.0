Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904D4B07AE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 09:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiBJIAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 03:00:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiBJIAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:00:51 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2109.outbound.protection.outlook.com [40.107.23.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C661088;
        Thu, 10 Feb 2022 00:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYOMA2kdJ112oc9FS9TbDQlk8RtOX1OJuOKQCMH3pva/5OqGOD8tWk3hovM9vOwN86k4k42Ajk//xJuAgXQham2CInx0US1K1QSLKbBVe4m4lbFEM0avgnIEmZWPDmdkvC8wOoNBaLpO1tXDcG+9M/tUnTX+r19RMoCCpGSTI8wAfh8IzA6Fs7mCWLkYeY9hOJW7U41KaBtXCmMqXgB9ErvWj64Th63hvVoo482Pq6x312rVfPPchrMEmKNyqk6wt3Q8tTiKxge1eFIOa/LHOTAqW4Pfy/BtXdS5oP9RCaeENhXtvJRBmEsXLniQzulaKf0gWd77K5z78jYydOoCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbQIHYlBPwJpfv+usN3i9Q1/QrIz8M06t41r34UXOoo=;
 b=Zq3p0XlN/+oFiQ7JSVAkdgP3kvBZYHosPojyhqFp6fWy0GzQxZ2H4Ylyafbk6X/nAJO6IIoTlormqJGkXCRpouFvuOgYrULAWsCQZ4X6hbn2uT7ixuq0a4OSRzri+R95LHNsa/4s8D7orUA0ugqymlYwriwMq4YfMxnbv44+Jkf8jyXH03Td+TFBmXOyjzZWft3w30t6vfRnnZrYVjNR9dlNlk95wduyf6D2Ojf4x/r8H62pdBKQ/GEhsHXTUPBH6dcd7VQUWJKV3LvdNj+qKykVwGCqr4uQKlrbrqJky1Q20iHnrgCvf1dModCzaMuBxUH2ych2H7zxj1+FmN+WFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbQIHYlBPwJpfv+usN3i9Q1/QrIz8M06t41r34UXOoo=;
 b=Mb3GSpOCC3PPlFnaKuJ3slvJ4WXdqBCt7q1jGanJ2D652dDxikLFR+ZV31WAv0F2rBr2ldpv/Q8M8Aw11rCwbOz+jKefdaW6phZk50anx0ZhN61mCAlIK9V0UWBHOGtE4ZnsE1WY3hKBzqiGyB1LzgyOta4GI/Si9vCFGwQ4CEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0430.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:00:51 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 08:00:51 +0000
Date:   Thu, 10 Feb 2022 09:00:50 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] PCI: imx6: Handle the abort from user-space
Message-ID: <20220210080050.GA7275@francesco-nb.int.toradex.com>
References: <20220131075235.787432-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131075235.787432-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::19) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd283cf-10b0-48a4-776a-08d9ec6b746f
X-MS-TrafficTypeDiagnostic: ZRAP278MB0430:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0430EE666130791D7995C98DE22F9@ZRAP278MB0430.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOxDyN6zYMB9DcG/cCm+R9rsS5UmMf7Bv8wP9JtJ0qWt5uxGGZKSVGKf4dSU4Xwh2JVyIwaZd7zdDbtnTNNfpWhl1g1c/Esci6/zwlsNALQiV7XSzEboQRc+ye8ZsZPdTQHGx2le5wHtx5n6IeIs9xEeHRCqyRajDqnNPW3nwXc9SxKYRFRyyuQmbVfVjGd12h40p7l1APcwCncPTCSgUmmM0GfBIghDpV0hy7/rm4iYq6GFXSqc0yHA4tKpHvynhDY8lht1uxMaXMqGUgucR23XClP+93Hc8NUE4S2/fQZDAPMwLdJcu7y8Aa3cfHVsEbANDJixMiaJPaBaY7UXYBjUzU2DEI1H78Suvma9K5ckdlCTLxyJOdMhLgyKbn+c7j0d1jaSU7tTcg7PG+gVHLiXBj/Fn8N5VHH0ypo5zV8PYXTFTOXwoNfBl77201xUZL3IKA6PTnMkpFCBcFk5/+47+aeHJ5jAWlCEEkPZgZiubDfMhHQ7nKPcC8jDJ4nG8ll7bxz8jEU57TEddlnMORwk5NcJyqyDDNOSabzimCWVP8mO6xVarr941+AgFcUbu0suEcMXbpb2ornJjkXj4awzGp/+5vSW9N8fBhiInx+JSI8DErz++tioldy5xDhGHxdueuxAMejIv8kNxGB5ZA0sNizWbAfIzdb+wbMxUaC1IEy2AYcVSAcBEaDRQwjcZ0N//VZTH8G388LrodiA8r9RlrgwvR65g1iYz7zwLCmc+sfJe2BF4WYAhnE8vP/RZBeWJbDaXU1s5vTiulZcFlh6ndBF9elxk0WVAmhEbuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(38100700002)(4326008)(66476007)(2906002)(66556008)(8936002)(38350700002)(66946007)(8676002)(4744005)(86362001)(7416002)(5660300002)(44832011)(54906003)(186003)(52116002)(6486002)(83380400001)(6512007)(1076003)(26005)(107886003)(6506007)(33656002)(966005)(6916009)(508600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PX9fCX+2gA7IBBonGuZOpmHNozEV8mfPzq76sOYCf0D4n9y/21l/aveLSuUm?=
 =?us-ascii?Q?YdRx8sakhiQ+XJTzjOz0RBAOjgHBOHEarLMmG1rrFqLmsGAUI4qnqPNI8Ugo?=
 =?us-ascii?Q?spaA0RlTiKgzrAaMzegGCJcoCLmFm1Z2sRV1ajoJ5/UhpmVblytxYPO/4K+n?=
 =?us-ascii?Q?vgq72c4Z91vpyO3j9ik8ScXAEjIEmf2d0PuZxaXkoiFDY+w2AWBWzcsnhSOT?=
 =?us-ascii?Q?SpLbIhTkU03vET+l9YkjXSEceA8YMG8/XzcT01Vd2BDvtsRwxnaaER2/sTJg?=
 =?us-ascii?Q?crM+vqpqmPNShnWfghWgY4NbSMKpCCy+ng9Rv2T99ds5V4Hd0tUZFbdqvOir?=
 =?us-ascii?Q?I9tBfGj2662PDg1H4c12roFYyz/hnlXLYcvQ0t4EFDp7HErvLInGcjAX0DtY?=
 =?us-ascii?Q?Dnd8u3f2zFDAmhp6amVjV8VIIy19b1dNe4hkQ2V0i/uEN2J+PbUEdOt+6XOa?=
 =?us-ascii?Q?lsd+CArSxZ6XoLOP8/wPaKTW5h3gHoheA7pj9I9GCxZql1q8YD7ctON49L3W?=
 =?us-ascii?Q?gV2ulK02miQiGfxd3c+XAZV7qh+uztT9zxPyIJfdS1UPLhn59boiI/o1AUuB?=
 =?us-ascii?Q?hWJNbJMIn/KUAID78QQHvEhcILtgRernx/TfE1FrE5/fFIKpTENruR5u72wf?=
 =?us-ascii?Q?P+M77r0mSq78o7grYwSw+cQ2J5a+BMSojVntA5cIQP8globFtXVvquy/WrsK?=
 =?us-ascii?Q?JMhWrzuSzV7xuMZTlyNqzSzvgpsNbdqlOVb3bydNzPxI4/dDk2+LQKcPQqsF?=
 =?us-ascii?Q?kY1CSzudgVV5C9Q61zh58K+5xyIYS6TrJCKywQVOLhLhcZ6vxzEBvTWGi5PW?=
 =?us-ascii?Q?apAeLAhZY03QopXDoxYtUvkrLxgV9lJ99s790UafI7FYJIBGyAvf9DBFZlov?=
 =?us-ascii?Q?0oT7lB2jiX8TYTXWeKYocD69sHN7lVc0lfbN8iZhHt9f1hrjveg0idslwlhh?=
 =?us-ascii?Q?JW22XCC1jkn2y+hDxQcEy0B2FgB+Q/mOk+YHFshhT4VeLMUUYmlp9u2KtF21?=
 =?us-ascii?Q?lT8irVlJjHQTUmWOfKbKqfQMuluYtBhQDYPJLCqybnQ+IraeSXlwk4Y0m0cu?=
 =?us-ascii?Q?lV9SXasdheset2DFuw/q6c9w8L3RaAB7TFxJOFWP3bMLA8IolsMu/im1C05S?=
 =?us-ascii?Q?qQRwc9CcQRykFo5A/zYljgS8Lo7m0v5aR8vTNfTilzKjmLTJ/uzw5y29tD9n?=
 =?us-ascii?Q?jaGtCxaTUhhdA/OuWXZc15Kw5dVarAm6kBY0O0ti7v4sybUj0ZScW6djgClN?=
 =?us-ascii?Q?XTHV7yIPrmz5510yNICN5q/Y2TKZhUMy0Ano+T/0OFp08ro0w6W6QPYzBz35?=
 =?us-ascii?Q?xkJWxZfNLClko8AeDUYDLmd+NSXxmsMjoRvhIu1kW4Pw/pBszN+Cf+RnN4MO?=
 =?us-ascii?Q?zgYW55poYEzcRJBzoDUnHdHLbpuFGZPXlkxh0c5SG/2WLvHlsSxcoshTAPp/?=
 =?us-ascii?Q?fF2kowwWjH6zOLYx6ESeSpPaqVQeuyOqGFFI2KUgo+SwcWRQNECLVlMseMkz?=
 =?us-ascii?Q?3eR2XSKup6DGmDWanokT5Iylyp+Zdy1fcpHNN2ecjuAhWJwW3rgeYyIRrv6q?=
 =?us-ascii?Q?p6r3yI/vSbGsGpbJJeFXTpCFJ9TD2zktPlmC9CvhzZ5qONSDsV/aAbaScWp4?=
 =?us-ascii?Q?MqIAGz4Xlbq34HlRd74bGWzCMk4dVSsCN7MCEg2BYW1KppFAJ7QNEjrMgH9x?=
 =?us-ascii?Q?PwwmjQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd283cf-10b0-48a4-776a-08d9ec6b746f
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:00:50.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjKi/oqwtjmLKassfyKFamOrtqL2W9Ytm4358Zw1c4xyBXrDLV2BGEXzRFywcn9PeA+peoCQiDCH0gu8LHepXIxQI6eSWMhE3pACeqyDBtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,
just a gently ping on this patch.

Francesco

On Mon, Jan 31, 2022 at 08:52:35AM +0100, Francesco Dolcini wrote:
> From: Jason Liu <jason.hui.liu@nxp.com>
> 
> The driver install one hook to handle the external abort, but issue
> is that if the abort introduced from user space code, the following
> code unsigned long instr = *(unsigned long *)pc; which will created
> another data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.
> 
> The patch does not intent to use copy_from_user and then do the hack
> due to the security consideration. In fact, we can just return and
> report the external abort to user-space.
> 
> Link: https://lore.kernel.org/all/20220128082920.591115-1-francesco.dolcini@toradex.com
> Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
