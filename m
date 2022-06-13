Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403775497C5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiFMKVX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 13 Jun 2022 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiFMKUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 06:20:42 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFF86FC
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 03:17:18 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-yYJeCvqFNeC3c_16aEaG1A-2; Mon, 13 Jun 2022 12:17:15 +0200
X-MC-Unique: yYJeCvqFNeC3c_16aEaG1A-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0223.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 10:17:13 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 10:17:13 +0000
Date:   Mon, 13 Jun 2022 12:17:12 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, robh@kernel.org
Cc:     broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v10 5/7] PCI: imx6: Turn off regulator when the system is
 in suspend mode
Message-ID: <20220613101712.GA20538@francesco-nb.int.toradex.com>
References: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
 <1655110538-10914-6-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1655110538-10914-6-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: MR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::33) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763b0922-782e-40d8-c3cc-08da4d25e26b
X-MS-TrafficTypeDiagnostic: ZRAP278MB0223:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0223C73A8AEF48B6973EF486E2AB9@ZRAP278MB0223.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Vg2CAPYW3ymHcXhSA0A91/6QE55HZj25mVlZsG3CvluhnilgTuZ/NTRWS4woUQaFg/2nRkMuexosL4QhocxhXZslwhZacJCk6NfeIGCBy6vFi3RF95AsEw31azPWqtj2thDrMR6Ikyl6LWHPYeK2eue4jjYSj1Mj7LVrqhrfBNOHivNQ2W/W+7QTmXYksl205OlCyvweNsEOS92MaY/uoqd6Ui7qYoB7hCxMAoa9jcgnufq9dn2/sMbILHXmT52ej9FuBnQrxTLThG+ZiDKVslwP+xP0r4WQUQiUCJH7PPHfu5BFfAnQXY9ghP3Lr+A2vxT2xm5CGtzMiiC6mV/+jv1G63DSniX4o3SB9qHPr8sleEUDI0y2c6PGJKT3ddhIuNwHIjqDEn5n9ZyaJzMy1g+XAH+mrHhG058+wctqRxS4aK8Lp70YiCNNZAcVVQgXe9lTD6j5op0JoLnWAwLVOLVlObpht3V76n3/7WGEmkyWy/C3lFdAgzY6M+Z7XYYjarXV/cA6ZCixbStdY8O3mFCYM8qNcTt3iQRDx9PO5gjCZt3dIWOn21mxXbpMXwF9oDy3Bww0C1isSV+5914mSIXOyrScrF7KVrSRjkzShNBsNf7NpNHnf2VzuwI30LAqLVXIVs0iEFem4aZNhiPQfiCayngu7hI09upJY6SofIcWTWgxyrngZcQSYLo6gJs4sMjT/cX8uWMStb614rAeYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39840400004)(366004)(8936002)(6512007)(6486002)(66556008)(15650500001)(33656002)(2906002)(38100700002)(8676002)(86362001)(508600001)(186003)(52116002)(4744005)(41300700001)(5660300002)(26005)(7416002)(83380400001)(38350700002)(6506007)(1076003)(44832011)(316002)(66946007)(66476007)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4VlI591WYg+1FfvVyaQx6qS3zALb7YqXh9sJu3B53R4r7W+FeG6xHqDrXs11?=
 =?us-ascii?Q?A2TiRTXIkrQD7NWGuSEv669VY9uLHA7PJLpJqI8w8v/nJJrCl0ubhze3A+1g?=
 =?us-ascii?Q?KzWlKwwt7Pomd3rWzuCix8gPkSjKgIXAJYzuPQMQSrK+SNq5DratNcOxS5c0?=
 =?us-ascii?Q?cYoTF9gphfaJO5CIYZ/M56px2xDVRLsXkSYbrVAI433e8/7FYvdgucYhFGNT?=
 =?us-ascii?Q?4ytj/Bs2UwAz8SIl71j6CY+lNajhvR7xrp/hIk5Lc+O+JIarbiUswdx/jDFr?=
 =?us-ascii?Q?cnh6EwIM0sW7LcHBjBK0sszKC1Ym6jaEEL1Otnss0gkTe9ng36iaMa6jeCnN?=
 =?us-ascii?Q?KTIlzW5Z+V2WoJcx0bVt7uwHJs3IjprAtoQoC+YFutG0w2A+PHBF8cs2aOzg?=
 =?us-ascii?Q?QB82G0xRXwzpTEwypI4rBIYhUBCnPu4dGJ4TtOmiZkI6jRMV703M+J10ufIc?=
 =?us-ascii?Q?ebLrT4ahLKpFDj61cG3ATJf19WISH7edPu5575B7xeELdn04PnBF8SJWx7bb?=
 =?us-ascii?Q?mkYy239OVEQXpB0xN781GhicGTwtXT2dwJ6Ua3Qhml+Gnd904GpYilB91vDl?=
 =?us-ascii?Q?/ldqRZcrxvbvqxoqWjWqUV6aeahskfh6nmCn7qDQytmGXHU9H8+Jq3sLxdgb?=
 =?us-ascii?Q?eSq9e29giZuSrYTzpbj7kA6J9B0SnzDI0UXBwQ0SpPkL+fCVdZ1BMgVVCrGY?=
 =?us-ascii?Q?bkXV9qmgBxRPS7bWOffsm4YrnukpLashjafJPnEEwiKy5S5P4gWlnQrMWbS7?=
 =?us-ascii?Q?SLoxBeno1oNncFjweFLWEOed3zis5nHy9AFTwTiY+gscsPOIY/jCSnaxIopI?=
 =?us-ascii?Q?c4zwXNrNTiRGy2Md2zn68K16/RVP/vQcO3TNzakoOa1t+NhH99FbcGoONG/z?=
 =?us-ascii?Q?XosdEuDO3CSnOWkTJPg3sdwIjrg7LMDLC8uMs/MUKQf1hc2Od4K2S5NMicqu?=
 =?us-ascii?Q?Bs+0+xGsuvpJKlBZr4LWLQdaWYILgtQMUC+OBQDu8w0yutMTEyjIRWiDJ6x9?=
 =?us-ascii?Q?9a+POjVaRjwobGFCU1tTmCevmZ9/ZhHynPX0/y4NW2mkT8O/ZUWbd3pvAlpZ?=
 =?us-ascii?Q?W4eaZxQA5PIzIAnZMjFCLDT9g4XI7djpJImXkz24nCThH+rd2fOE6gdBpRjv?=
 =?us-ascii?Q?Hywo+K90pVCA52y8ujG77ZVuNhymWVQocbw97p4rw3A1oFTWhDiKDhZBLjgm?=
 =?us-ascii?Q?a3arx2Bvt4b9FyiNVpNHludyovj2ZxxROsmKq3YLi13tv6VSpCPCWdPAZjeY?=
 =?us-ascii?Q?HIFxeS/35+nMcy9pZ+6ob4K1G42vfhQfm6Ht/J8rWRC4mrW/iYUGmJxBtId4?=
 =?us-ascii?Q?glwBnPBEgVDnxKV/UFhZmHi/+q1/MiB4KFQa35U5TgiIUm7u5Ab9ndyyoDoB?=
 =?us-ascii?Q?ozarzouHXe+fJDqWKWjIS7HBBTfe8EvNZL8KKvc6S4YAaKU//ZZRzWijR2/N?=
 =?us-ascii?Q?9vJX/KSPY/1IaWKiyBkkT5bFgo4X5MD+4v+VohvOE6eGvUQrharHZBrLz7ES?=
 =?us-ascii?Q?znNhvIORb57SdP6NnF3Z2mB6LrjDh/vVdyxJN40lirpl8Qe9ZTXrC3D9cN1q?=
 =?us-ascii?Q?xFbodh+YOUXZRRDy7hMt6xRk1/A0D3fm2T2Cc9CSQINjTw9504zmfLoLGCQD?=
 =?us-ascii?Q?E4JQ5ZCmCCB/b9QoEMr/fB421zMe9vQ8XE5l12NXXKKs1TwAF+7k+49wOr+T?=
 =?us-ascii?Q?gvYwczsU4Q3QcuqL47oTqaogDKGzwIDbKWCSuJd3jXnVHd30mryRKcrmJBgj?=
 =?us-ascii?Q?VEkZVoz7SnZy0qhfayY+p30wY5CANtw=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b0922-782e-40d8-c3cc-08da4d25e26b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 10:17:13.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMGpOyuf8LtQ06OWla6ptR9BvGW/SN26cYXDKl5jbbkuoAQ8/GimVWdEaBv7lgL4OKjYmM6TjgnLlN0sZpPF8MaybFSnVsl+yBf1SHdxJ9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0223
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 04:55:36PM +0800, Richard Zhu wrote:
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> Move the regulator_disable to the suspend function, turn off regulator
> when the system is in suspend mode.

According to the documentation:

  vpcie-supply:
    description: Should specify the regulator in charge of PCIe port power.
      The regulator will be enabled when initializing the PCIe host and
      disabled either as part of the init process or when shutting down
      the host (optional required).

Is this really what we want to do (remove power in suspend, enable
it on resume)? On our boards this powers a PCIe device connected to the host
port, that sound fair according to the binding documentation for it.
Am I wrong?

We do have issues with PCIe not working anymore after suspend/resume,
wondering (I did not have time to properly dig into it) if this is the
root cause.

Francesco

