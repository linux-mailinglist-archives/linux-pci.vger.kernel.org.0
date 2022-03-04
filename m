Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB604CCF37
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 08:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCDHqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 02:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiCDHqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 02:46:21 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2117.outbound.protection.outlook.com [40.107.24.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74B194156;
        Thu,  3 Mar 2022 23:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzqfNUB0DjXDNVPGCiZYIbKpgyl7piefSnBs4sHSHVWOLom+rIEakol+9wY4UKqKvqdNfsIKcwEbQWdnTKH6AMWT6YI4/aAkkqa9UN9w2JqVyD3sC2S6Cr5f6f769NKnHUe5L5mReJBly6C9UbIreR5LLGWRlDjL8pWepJLvayFRl95MoSwQacfjSmIL2cLKO04IgrOHE9C8ql2FapXPrRIgLjKmIHy4QPrQfHN7ksVnseDjKfoKejv+j0mU/s/jMIB1W5uS08bmm920Oc+F7MNa9skOvIS2B9B7dJEvgkW1cUqpKPPpUUvhArfjBOOEhpWgPoyQl8ytYTqFCoJV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuZi1R44wF2zZTL49/ATnsoCKfCYjt+Zk3MgmYrs+Y0=;
 b=PZYcPx3Jzm8E3vNZvYvU1+vbVzUOOg4Gsirf7htNN3rFCXykg1aOqFg8lOVqHDWLa/UU1ke6OI/RFzJjlkuY5MITuWOpJQkEdbPwYATiATvjdBovBEXKd8n8v1LSWcRxXvBNYDc8eMy0xtRRn9CataQpvhLdyjhEUdWTHjN2DyYB1s46TSWcOja7ckHdOXNTfyp0zZRVpy93nfYZLz9Wnm60JolenGVcDGx04/1p6zqKASePrAks0qmHpVXOFC3G2IDbesooetWjAJfeXpYwDQIEKZ6KkpcxOmp9k5WPj6Mr5ve1qnDE1xYJmgYCWTgHJjUnGXPhg6Sk7Nl9R4G8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuZi1R44wF2zZTL49/ATnsoCKfCYjt+Zk3MgmYrs+Y0=;
 b=E1dp/8Tp7Aljxp7mUF/m0g5rO1H6ss6iJAUth9pCzM6mxXTlLj29+L7Jng4tYqc3BemyjcsHGlu8SA6MdKwKyJ3T5F2xZd/mGJrZ0H1GiIeexG/n9jzPya9j1ZJpRhNwRe/u4anQrULgIUcn0UNanJJKwNzQVqovBkhBCtejWhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GVAP278MB0565.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:45:31 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 07:45:31 +0000
Date:   Fri, 4 Mar 2022 08:45:30 +0100
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220304074530.GA1164950@francesco-nb.int.toradex.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-6-git-send-email-hongxing.zhu@nxp.com>
 <20220225094301.GA2171975@francesco-nb.int.toradex.com>
 <AS8PR04MB8676418087498F9CAF9849FD8C019@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676418087498F9CAF9849FD8C019@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: GV0P278CA0025.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::12) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 980f813e-bec2-4709-cd02-08d9fdb2f561
X-MS-TrafficTypeDiagnostic: GVAP278MB0565:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB056565AF479555C071E0EF12E2059@GVAP278MB0565.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RUGSuYDpoOCUcxv/7L1LC6dbD3NvfgiaSLVdjiXam2LSR3hUqBZFovcNRs8TLZIwy60yiimlXwIhhjezeq/07wcpYVT7UJhmyMq68x+5RZuE2sp58edpbubDICUEr8xl9UB9fVq2HEeoN4QOy36gHemVL+owS+Esddmemjpd4rMU/aXmeQeW4D7uf1bv6AnIqGG/jJmCKXwnCW7whihXwGK6EqtmRgVe7XZ2kidcOoLZQ+cvGIFiT3hPvS00srREATPDgLTRZnj1N4Jo2pzjiZT7ei/yWL4ag65fYaCUYVSomQxyPaeeZnWJWmZP7D11S1JbrBrh5y5YPMqPHAjDZPl4lBwZAHDxxZ2YQm5EskIrYzAmzGzf0h/cjX34R/hwn6zqHaVdOi1rDuuD5WcbKZTJY1orf1Y7gC5QkikwlZsrXarBONO3I9NzFSdBMa8zxEkdT4Ltq2A+kcvlkQP13Y6uJMHoqC+CutbwLatDKlYFh8mNvIIemrqXEaPI8GDKY44CPU+kL/cCa4swULAopRSG/4sheY2BSdu580Rgr1ZHjKjmMBgBqx4B97pWYLAlZPWeGTv0etxCNmCSuNJwG1hecHBhCRnV8RbKnaA77UwWNkCMBLl/tDH1cIaLnePyea5h4omcGFsquyyltKz0cwkbh70StjU2e0rKZHCl+/G6h9wCTeiS2c3r8SUMhJwWb/gS6OXQoo4QADHkvv9VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(86362001)(7416002)(508600001)(5660300002)(54906003)(6916009)(1076003)(83380400001)(6506007)(52116002)(186003)(6486002)(316002)(26005)(66476007)(2906002)(8936002)(38100700002)(38350700002)(66946007)(66556008)(8676002)(4326008)(33656002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qodQKHs3tKwufAU7xKihCiQYGpGUgcNlsoqLUxo00a5GEbNtJlTK2wvickgn?=
 =?us-ascii?Q?Cco8CgatUwPePP6/BbfNIwcZA3mGML7DgCl9E3rdzMRekP04gGxU9NdnZG02?=
 =?us-ascii?Q?6aH2jLfutxnkTpld/tHq6fwZrrlqyB0BuG5PJUw/98l49haSYlHxnyUmC9PK?=
 =?us-ascii?Q?83A2qKa5fBAL295y8YAj9js2UdroFUBFKrE205Lm64TzGoJKmgCCpLQXLeM7?=
 =?us-ascii?Q?RSBq/l9BIFkCD/ZpFyKQO4MiMdzB3/SFjgGNCsdNLB6ldvqan6IEFI2wFCJN?=
 =?us-ascii?Q?jEBjRWJ4ch+OYthfnpyFkaLUHUJi7g6jX+7qToenajubStsbDoJU/+yi6EpF?=
 =?us-ascii?Q?Hm7BVQgtEttgD6MGpy6qCWOswvuWEJQ3v2faPf5sv9KVa3KlciZF5Y9RPEWE?=
 =?us-ascii?Q?vKIFq5KKAqExSrIeNDZfJa6RcxcaXCqr6P3xaQNPw9fIvY64O2wmkf2OqHQL?=
 =?us-ascii?Q?xHKLj8NS3YByPJ+2TOPB9CpzeAGzxsyLaDdNLm1FcUX7K9ui2ql8vR6FIYYY?=
 =?us-ascii?Q?vEpcK1ZZWxxKsVQ2gM5QTR0cyg+lqxstRORkXKDC+eIrRVdW+bRqkiejEcHb?=
 =?us-ascii?Q?5o6Laru0+l8uGYU4n5c0QqIZO+DCGHG9W2HePfV2V0c09LoDSh0ngWn69hBB?=
 =?us-ascii?Q?iKEObOCzQ1UJMg9v1UQ1ehCpb9qwqA8fqsBKDRdWO6pbRklLO63BHcYfyrEJ?=
 =?us-ascii?Q?e7oQIxZRga+g0FpPygPfiYxXNFC3F0mMqup3WUBUz8Sh8Y+0hpbAlwEXAVZJ?=
 =?us-ascii?Q?PEuTYxYxM0wthCBsEuxVRTKXytCAWIAJRukNIYBx8PK0grRfnt9swCgd15vd?=
 =?us-ascii?Q?9UkKlMcvw5036l5fV6IwsDaIT+Hqxvf11n257VXtI7gd3BHQXPyRSrIuFJ1p?=
 =?us-ascii?Q?v3UVwqRJHm5hc++PzdN3tg4G0DSC5Bh9guI1DBB+poEVa+TvcTQzG2KDZsz+?=
 =?us-ascii?Q?aQ3d8dhWWnAmfIusd2Pd8HKXkgoVW6HSX2GJS5dpPAguXJxN2DNGjA4HJgeZ?=
 =?us-ascii?Q?5OgwS48USGdAgrjU/NnAnGifxUa/fy5bsZdc3Ehw0cJC6GPRoO/OMX9oLPtf?=
 =?us-ascii?Q?NFOZMf4hVhO0mZLCYfz+lXICykWnfOUKfsBkrIetdW+L8Oih5ZnyZ0NCXRkq?=
 =?us-ascii?Q?/nJZhAvbL2oRT76nyd8M3U5UPsIqJH274xUPJdYjzBoEQ7IsASomkTWllSk1?=
 =?us-ascii?Q?z1Ec1cS+1cWnuHu22nIh6o/JIsR9FH4AGYOcHpOvaAelvRA+uzV1MuxuloUu?=
 =?us-ascii?Q?zatL8DLmN684L9iToCsqvofUGJx/zeEKvsGYrYFy0epATqEYTTtQPLaIagtP?=
 =?us-ascii?Q?+FnWQg7zPg1cFQdozu5d6l4VXf2nTC4z7amqBUGDbVybm7lrJ8CVEqbejwkF?=
 =?us-ascii?Q?QGqQIbKjh56OBavTQMMCMhJJbW3bHX1OekXKvpjLtxRdv48plF1JRsa6jP8o?=
 =?us-ascii?Q?x4a266qTh6+Tt5jJDw9jqKH4NPzqrb2i//5Ms6hIR6jWhyd0gtQoNO8Hgr5r?=
 =?us-ascii?Q?xb9S9L/SIZp4Coa6Q0sz5TA/76UCfnNFqQcrud6csf2tZiwoGy1bCcre7oMy?=
 =?us-ascii?Q?nThCuxAMgu22hJdRxNbk9RHr05KnmfCxmy+ZATtNSl+oy9Aj4c6dg+Nng9vX?=
 =?us-ascii?Q?IHMbHRonz/iPMk5dEz6vRYzwyvZ/1jwHi4k/u8laso07Of1/IDvFPVRTJDdp?=
 =?us-ascii?Q?st/Dxw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980f813e-bec2-4709-cd02-08d9fdb2f561
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 07:45:31.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D00t8aGcYylmHYo1JUmym8/1cvVIW6cMDvOAfBWpocugyrIv58MDaAZiKRlDAKmwrpOU6/36ksdOP5CVJQtrqXDOPrcRV1cSG74qQl3N7QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0565
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 03:43:03AM +0000, Hongxing Zhu wrote:
> > 2. We are playing around with vpcie during regulator during suspend/resume,
> > why? We currently have issue with suspend/resume when a PCIe switch is
> > there, with the final effect of PCIe being not usable afterward. I fear like this is
> > related to our issue.
> >
> To my understands, the VPCIE is the abstract of the DIESABLE# signal.
> Refer to the Chapter 3.1.12.3 W_DISABLE# Signal of PCI Express M.2 SPEC.
> These signals are used to disable the Adapter's radio operation to meet public
> Safety regulations or when otherwise desired.
> It's reasonable to assert/de-assert W_DISABLE# signal during suspend/resume.
> 
> > What about vpcie enable in probe, and vpcie disable in shutdown and that's
> > all?
> The W_DISABLE# Signal is used to control the radios on the Adapters.
> I think you can do that, if the radios are always on in your system.

According to the binding documentation (imx6q-pcie.yaml)

  vpcie-supply:
    description: Should specify the regulator in charge of PCIe port power.
      The regulator will be enabled when initializing the PCIe host and
      disabled either as part of the init process or when shutting down
      the host (optional required).

This is how it's documented to be used, if this is used according to the
documentation (and this is happening) what you are already doing (not
changed in this patch, you are right) is not correct.

Abusing this for the W_DISABLE# disable is new to me and does not look
legit.

Francesco
