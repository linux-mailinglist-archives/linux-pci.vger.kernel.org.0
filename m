Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98A4B5187
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 14:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354196AbiBNNU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 08:20:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiBNNU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 08:20:58 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2091.outbound.protection.outlook.com [40.107.24.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600BD48882
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 05:20:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3clfY8G7NssaiztE4+vJu6PcJ6Bo8KOBYuSs6HTW3kU3H40SbWlJUSSaK8ryfE4NBMXWuXjH81u0gBiq+4qK/IiDKaCrXd06xmXzhm5+aezKPTtLfKVqL1x3NOW8V7+Y7dpwhP91iJiO04ciIpr4SEVE7cFTQAEhcqvJNIrsQ766T9C63rr81njP+zAj/bO5sqQUSNm50TfhpOCVK0mKwHG9J2DvshTLIdZ+wHG/tN+oWA9ubnedWojo6QieEMSNRHBc7sFRMd1G06RcIFMWCZz42I1Nn8SOVD5LQS0HRrxQKYlvsimGVu/vL+wbLahW7nrOZoY6EGKjYG6yd+EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZNzaWmO0Kcv5KewzbGIjetoX165Tt4AjFX6737mLHo=;
 b=OSkyGENwVohxavczJVM4vGuuCgygVQ2c2d5GMTfxUlkUpSNzuy80qdOup0jyK5Hb51BZgBjUS2lsLT8BWBnk2E2vAZFr1H8p271NPdko5k6VsA+RAWW6xo0G6rhuXRSWVYDMd+Q2sWktZLXD3jim/kz8Bk9JAMl96evN4b0rRgEOrRjXQ9Q7gixCYsuxKOVWbxk0jCGIXLXLScgUf8bAtWtKDuaI8JQqiBFnk+oZsGv1DmomfrFybadDwS6rfoeoaVy5gBW/AuxUxIklcP7sySHY41qAx36omRMha/FOtBSjpPt5n8ChqyEnnulM0oc7UjYRtQSQvtESM5ESSab0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZNzaWmO0Kcv5KewzbGIjetoX165Tt4AjFX6737mLHo=;
 b=f71T/fCJtOqI6KGmS1rbjM8I/dmTL0frbMHFG+VkWWzFEZvC/PQ3F6tlpYg6tNLyMVAyC+dvT7HWJ7bdyd1Gx6l5uEV6nl62slWULYdsPnj5rSTyJh4LRijthdM63xRhfMLKKX46diGaOuLZz6M9mxbpYpMYbVjGQL/QnzGv83U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZR0P278MB0684.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 13:20:47 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%6]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 13:20:47 +0000
Date:   Mon, 14 Feb 2022 14:20:46 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220214132046.GA87171@francesco-nb.int.toradex.com>
References: <20220211152550.286821-1-francesco.dolcini@toradex.com>
 <20220211181824.GA718271@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211181824.GA718271@bhelgaas>
X-ClientProxiedBy: GV0P278CA0057.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::8) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efc0715-cb25-4851-52e7-08d9efbcd03a
X-MS-TrafficTypeDiagnostic: ZR0P278MB0684:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB06840F59F1EBE018CD36F8A7E2339@ZR0P278MB0684.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e466LF52F0pQsJo0D22AqHH4B0nVqj+M9siWmq6Lz/ESiAwdhV3CN0kFy97KBqW0krpSSj8l6mipBgimej+oIz54+FNaJ9MpAcFbrbU4VdQTvfZdRFToBEA60GKpHAiz9n3JvIH6LwOZlc4EXAW6/viheTc99CYpseY3ornVPGgMlDmqMohkXpSaKNYzRvV3HpQgv7didbsAvHJ0hRUClS8APabV3c3NFIXNZJyjNcCNq2ClbRjW+PylKmhaa4gfm5PiJnqjmPmVs7JcmUJQROrqQxSj7mGot6vDnl+84lE/Ehft462ko4gut2sPXEDs3BUKlVkXrl8rx9DcUIUQ+0/R2igwBnIjOu1Esy7jgWANvt+5B0Y2THiHCk5IBcPgxNBoP/8jUYVeXIsIWCHNRdxVhLK8pxE+IIt5ZB6eZ87qMALVckZKADZxBfMJy/X1UrCF2BvQS2FHAAZlFiP5sLCw7PqmcnWUgcW4mfrQdXFcPUfyEcPfRza609b4IVP7/uYx8PQM8kMrpS9xNAnJZZAyUD9UUhB9wvo4nYjb7o6gzL/0tvezhlf7LVe446nUC3Q++4MrjgZSRxviUfybXug26BxqEkV0QkLybBKV0TuzEenbxZMcVsiXqk4Ya6JhXPzkyLwVQcaUHVG4HMTy63Efy/vZ2ZrZDY5joVWEkApUQiwtSNThql2V7glSJ8FdtwZQH3cfK5nx0tr6IY8fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6486002)(6506007)(6512007)(54906003)(6916009)(508600001)(66946007)(38350700002)(33656002)(66556008)(5660300002)(7416002)(8676002)(52116002)(38100700002)(83380400001)(86362001)(2906002)(44832011)(26005)(186003)(1076003)(4326008)(8936002)(316002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27PYDaihdIkVEIkVsBQhC9ktGY7uEtGyNGbeJBInjotGN4AscSYlZhdNrY7l?=
 =?us-ascii?Q?JqUsZRzQll0rFrTKZI9oFaGlUOsNack3w56h4yPLPOEyFnIBqtF6Z5icM3T5?=
 =?us-ascii?Q?oujur8EaC4MRRR8jaCxwKxZEbFt1Fn2O020kJU6o7OdR5ez78cyEFk8E/LCu?=
 =?us-ascii?Q?jwCPKdhqYHhzH5r9bBPaBdzXevokHz32c32C5G5b8KXzhWBVo4YbEFdFYVTn?=
 =?us-ascii?Q?0EMGWzvU29OZuVtycWTZKou9wEK7kosIc4MXzeUmctJYSaYelNnXGqbNzxfG?=
 =?us-ascii?Q?GUCQ5hrIfgNdtLnPTiqVQyJ++sbUpHSEU9GKnY7EuSCf1j1SWuKGvbQiC4IW?=
 =?us-ascii?Q?CH+EwufReh7R3T/VZBHeq1Gkn8I3VAUxKlUQAxLM2X8JXTwP5afxvyyVgPIc?=
 =?us-ascii?Q?AWZcaEwCa80WXS09iqFkRNDxhZsLKBT9qRxrRfqKo+pqVxT2IJ7rnooQRFUx?=
 =?us-ascii?Q?eKHfvjzjd79pTuKbf9OHIuzAno3HYIecd4qlDqmOw5xGzdSo31JF4dfMUX15?=
 =?us-ascii?Q?8HrCO0NAChnS6KGk4aekDa1Fcmmw5rsP99APYWfBS5VcCQocE+YcDtuCSdNK?=
 =?us-ascii?Q?fIDH+eQJ9i/dc23ruYNPcDckSwENnjuser8bG50W00O/LSFjvAWg67im7SEZ?=
 =?us-ascii?Q?EEP83wMsxIJv/2860cKlIAwB9z6wb/MNak68FHOzU75FUs6GLS2NgZK0+Jr+?=
 =?us-ascii?Q?NClbgQnU47x22PSz7PIZ410EK5kQ4/Yh8IGDl9YLCk/zr3yy02QidfPuAntO?=
 =?us-ascii?Q?dm/+ybVEjKdEaxnE6Tte/M7krg0Gu5ISetJrgJ1RPiOC6WFXinqyA7SJL2UR?=
 =?us-ascii?Q?pNVhcHZWrNyoqv3qFa4zhKO5nbZVFqdr1G/rdgREBlHeh2HuridwMfyIBUbW?=
 =?us-ascii?Q?R3L4NtbGloJoDzlmkvoKFKox9fh21x+Rhv93hIHZh+IJ/VJSW+edNpI+VWRT?=
 =?us-ascii?Q?mYz8SlmJy6uFD1k7tA2LWQN9psCyJfG5pmrw2tbhb2Hy1WxlvWBnM/jGiugJ?=
 =?us-ascii?Q?MDQPKr0F2pnU8teRRZu6sC2L4jrl6ku+78t0GCbRVCYRL5McyhH4pjtd/lcr?=
 =?us-ascii?Q?NfxHaZtUtyhiHLzdcHpUfwTjgch14F1rCh8p/YcYbH6T8WV7L70G7MSXGyZC?=
 =?us-ascii?Q?HwNxDF8PbLIM/bCKiT0lmh3XH4gZ1T82YEID+06HbHen3F6mLv4h2NPna3PV?=
 =?us-ascii?Q?RrhrwBy5VIEPvWuvN1WHL7dF4gbnWE5Wx/wq5Gl321kfM5wUapFMqwKDmsTn?=
 =?us-ascii?Q?tue+izCvZyg4TcL+CgcB5UV+tr3eieY27KwZBg8pifQ42X2enFBQ1r7L/xcX?=
 =?us-ascii?Q?Q5coeJ/26Md9hAATaeKTTZZUZ+tweDQMogCSpcy4HFqZrr6FSdLjsJ+pSll0?=
 =?us-ascii?Q?XW6wtcQnua1LfsG+IvtIpIYSxJJI0k6xDvkbyaHgpgMk3oyJBoByncz5ASbJ?=
 =?us-ascii?Q?rYe9iLmSIP8sKLDdqjZhgQoNrpe4/t+ms2ACAAwF81XyTEohzKJDmSbVFYfE?=
 =?us-ascii?Q?4fBMJBjWafUeoNqpOPl1KGSCXLRsVj6g+83NsA2rY8Jepg62sO9ihrJQbX8u?=
 =?us-ascii?Q?Xu02e9GBXO3nbe+ZTRVms8mdsCMrNDjUJtrSaPisxvsRg7HmZlt3VKqxB1v1?=
 =?us-ascii?Q?hGgM1HmGYKHJxkXRUGaSDLwGeOkYfOrF15KCVOO8jcWhLvQyQmy2IseCoTLL?=
 =?us-ascii?Q?TLe4qQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc0715-cb25-4851-52e7-08d9efbcd03a
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:20:47.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ0N1YcFozzI4/ci6LydHKrfd8ikSzp4USlG1EA/D5XmwWikygPdp7KuaS7DTlzvQkvCmT5gXbtyqCa/K4542q6WcdDVWM4t8PqWnGousF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,
thanks for the review.

On Fri, Feb 11, 2022 at 12:18:24PM -0600, Bjorn Helgaas wrote:
> Mention spec rev & section here, too.  Someday we'll consolidate these
> with #defines and identifying all the delays related to sec 6.6.1 (or
> whatever it is) will be important.
I added all the references and will send the v2 later today, however I
do not have access to the PCI-SIG specifications anymore, therefore I'll
mention the one I currently have access to (I did not copy the sections
you mentioned just because you wrote "probably" and I had no way to
double check).

I guess that this should not be a big deal, since we already have
different version of the standard mentioned thought the code with
reference to this topic.

Francesco

