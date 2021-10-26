Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBC43AF75
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJZJvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 05:51:16 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com ([40.107.21.115]:9280
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231963AbhJZJvN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 05:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8EoJU1b+PwyfM+WrgCwoBjpEPqYMz+mxkJGoolJ7bJwWq1u2nGKsj3V+hUKS/2zCnT6Wob1ubQrQK2j/9mcD2vYrhkoQ08kTpkDCaaZfIBGjrwPoHAkIcIjgnaYFqy9sMcHU5LCRCVYHmagmYkcn9J6usJfu3NDIXSqfIfT6041un5fTs5wDNrYlhBuD7NvjLH+RX+HUhr/cNTVRUYXhsGdiaRESXnu7J6PouWq9nKNVVfRFLNtGOk7mrI3pP3oXKIGy2bK5372if6oHbG4AZxQuNzFzq/PiGHlB4hnHgt76CLbsU48mM8jkYY5/VoShQUg8UTtKCTQQVwwAopjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC5xKTxdH4SSUFQjVfdCZnxj76pY+vnRHXdliTRrUns=;
 b=OiuoR6GDJW7F1V5AY5WqjSE3yf8D4CAPgbS1sBlVjQ+ixQYgTExW8ZGgCPfEcgRD0WgxlxLBl1HiK360d32wBdApGdYKOLH+wTnKEjp6bpy8I5wRwb9AplBB5U8nbFBGfOan3oXrExEwA7oyLurAEVTwtRzeFH9w1nPJCGwBnBPDi3QO2mxCtcoWhrpP9vV2EfTBNdQaaOrLe2Ft5gsL/MSGoi744bAKlBDnaWMBsOs3hurNirjb58HTQfghUTq5Ud7ta/nUSNiWZIEz4laEayN4eV6LBimDggr8ojl3DRVPkoD8fXOXZz9qkcxaJnaxRi/iMfDepVeV/nMFHSX+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC5xKTxdH4SSUFQjVfdCZnxj76pY+vnRHXdliTRrUns=;
 b=JfBFmajvO78SljwFQuV1P0GhO7Ixtil9Iab7pP2roGDGqhTEyJXA0Fm4uzSbbN4lM0L/M8OSaqpNY2PkAKDiiIj/AWKEWtjPsvITq2QRGtkOYMcbkKlxZ0hJywQJKzRMd2gHIsANdLXlKPXKCoi+7OcOaf8tYhcfFGt5w984Yu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DBAPR05MB7448.eurprd05.prod.outlook.com (2603:10a6:10:1ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 09:48:47 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:48:47 +0000
Date:   Tue, 26 Oct 2021 11:48:45 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Message-ID: <20211026094845.GC87230@francesco-nb.int.toradex.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026085221.GA87230@francesco-nb.int.toradex.com>
 <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026091123.GB87230@francesco-nb.int.toradex.com>
 <AS8PR04MB8676A2D17A859730230CFBAA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676A2D17A859730230CFBAA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 09:48:46 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id AAEC710A3765; Tue, 26 Oct 2021 11:48:45 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8154ba1-360a-44d9-5b2a-08d99865ce4b
X-MS-TrafficTypeDiagnostic: DBAPR05MB7448:
X-Microsoft-Antispam-PRVS: <DBAPR05MB7448E7BC6EFF5908FBAD0D68E2849@DBAPR05MB7448.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFu+GVuryqTWhFDLTKSG2ujsYdgQdVhHvPCfH6V5aScf09QQXzhEZrBPIr5WnsLKt465aJfWUI+0l9q+24xQ7Rt3noyerIf00w5gT6dc/qyIqI9qBTyaI7CaxbjjW6+DdIg2Vvhh+/hQs53vIBUr1iTxeIR0AMTStgwq5ksKiMkVB88AK5MG9mmoEM8mQqcbC7LHwbXHUcS49vsdinijWcFU/lnS6PQXNWH8VEvPja5P8Nj4gUKzRnk++vHw1lQA/LYkkfF1Z5AmQhytA2Ob2mWv1Kry/4lgTG7EKXWRJJ7GKQRd0HBU4BmVBrfVhak191zfb16J18J076j+3QlK4HOKOlaQPH+cCJv+i1ukSojW5jSHjYuw8bvN6Nq2Em3BRlJzdLTQN2khebv0iBRxNqmbr1GpcRob6QmkOgF080y/f4EarHCxdnvqKsGh7cDW9gfmF/SOsrPBhwNzI5mEvMkl+gyLD0UMa8FjVUSv7JS8Y36g8FDJwlGaDW2x25yi+KGunU2Vxrv4EJVZkPJMmqMGxtrbDBWvaT2bZgqGkwa3egMaJpVmqN4HxgxRTMwIne/jUfvmEMJ+jlMH4Et8WCoPz/lyKOhzjNdq2uxqroC36qwUlQQwzZki7so9yvPlcAFMjXx/2RLZ14q6cVad0+9DAVDnmQgTbSIdJfYcAdJUmzYiDSP5OWzhuiI46+UOk9XCJwcFYIg2g813tr0Osw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(396003)(376002)(136003)(2906002)(38350700002)(4744005)(86362001)(26005)(38100700002)(66556008)(6266002)(7416002)(66476007)(8676002)(5660300002)(44832011)(33656002)(186003)(8936002)(508600001)(316002)(42186006)(52116002)(54906003)(66946007)(6916009)(4326008)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S6kpHdQtXgb4VbiMoqzrN1KNrpumE7vBLYQ/IgATPRs0m7C6MkNcXGMQ7xVl?=
 =?us-ascii?Q?A5lJ/xnH2bZS08rHBAZCx9K6o/16BnnKUFOCvnj6W7mRKXy16D/8jqfegLb8?=
 =?us-ascii?Q?mrC1qQthVy6i7Ixc92mDgLBhcgQb/7ggmbHUk0QaxMI1lS7RaJ8uSHka8j9/?=
 =?us-ascii?Q?0y1MAPSaORbjMYE4Tlw20tGlPDeA8/lQ6TZcMHKWYpjW5XY9T8KCLa15Fbv8?=
 =?us-ascii?Q?zxdZ2AcVOJM3P+0vTpqPNo73Bbu4cXfB82wGd5q0HzyE4Vwvj78FmO3WDREa?=
 =?us-ascii?Q?CCjmHvhl6xq5x9nSiXtIzl8+1YdchfI/vvt9rvduLg5xqUqSlG9LdrbWHfKF?=
 =?us-ascii?Q?LqYodCPW9IyrGqH3cRXo5+nsTgHMhaoEAe2fNXkQ9ezg6Jz2wbVuWrNWMOc+?=
 =?us-ascii?Q?lidMPgqj1eFXc5nLiqDp/hmgt3r4WKP4B2F+TLTYQfStf1YlBaFzgaXgkIRW?=
 =?us-ascii?Q?fARCeRpC+lxicM5ZX3KTvL9qRvu9Qvxp89k+sqolSjek7lVeOODkY+3qirnK?=
 =?us-ascii?Q?aETu100/HQ+OO2HCc2b7Dfxd7MykYUo1GEGawffrieMSkswOTC6KagsV5xRZ?=
 =?us-ascii?Q?6C9pIzSIJ2PNfXShyyvc2y0vZq0MRwJcwVlrcVv2/p8lqfFT0pr57jJyc6jN?=
 =?us-ascii?Q?e2IkHYQ+NJat6+jbKabwJnPc/okb5i1Ee+N8ZjG/8SYVPClP5a/hPu+Z8Fve?=
 =?us-ascii?Q?EhI/yiTTPVx2Y3E+T+Fi5E72WQYBoh7vT80FytdVNOG+1lnxDKKzvYTeBrZ8?=
 =?us-ascii?Q?p0t7lrTSnaqGYldeO2hOJFTozBNuS+91En6JwJfoXJE4kTtf8rbz2MA/1OKB?=
 =?us-ascii?Q?73Ig7/587x0wmyrk5wQnhES9GCGFPkrbaShfCwZ/Jcl3M5nhY8GXCBXXRTW6?=
 =?us-ascii?Q?+wUrr/ncz6ubwdzirdUTNVDeQgK6/pGggITX1BbtQYfftfandcuKgGIdJTWd?=
 =?us-ascii?Q?fegLiao3ef+aqVfDP3q3AdTNylCCWEV+Xv/izGmmZpYBNagMn1tIbcC34fJf?=
 =?us-ascii?Q?L9UDNtQmFCpr/6/OMQY6g2JSzO3EMP2pF4N26CT/qGUFP78IBhyeygCo/+K2?=
 =?us-ascii?Q?rtf0RBuCFpr8P0F0kQWTK0XZ4Kplcfo0GmsKLvMFAjmhO+tujFvmZtXMR+MY?=
 =?us-ascii?Q?xOm//GxPXy05MVyMT2ShK/DsloAfUgGE4fCAEFD2p2vNqda5R561M1hy5Dhd?=
 =?us-ascii?Q?ZpalDlIxgc5nX94FTxlrSgOcWD55jesuUWMmc9DFFdpdpLPzJPd4Lggr1bt2?=
 =?us-ascii?Q?3wiV+IX3PZom5GgD64Kium25RdbZsfKVbITBgRr6enEclAdTIA/gyJB+76JB?=
 =?us-ascii?Q?nObms2KTztzmDHlj5SGaJlr6hUd0S0Cei64Ij7ZA479NveRHgG/9E7nOuSq9?=
 =?us-ascii?Q?nPuIbf8lDu40GCuvOmP7PGSTFtkZShuPJjWA2sl0MofA/vVHzH7eKlv2lve2?=
 =?us-ascii?Q?fqHQIz8hHuep3o/Nn800+wjFCtyX9GQnzEBArl7ecZTmsPqb38Q1XLByZNxA?=
 =?us-ascii?Q?k5g9hlVfG86AOBMWJsRIPqbGBB9hoA65ASxeRjMF3sXiXl9YeErf/ehq48iJ?=
 =?us-ascii?Q?ihsxCzZHqEMkclZyAvFIPkzs2ar1z0oQhYebIz0NbNIWcz8eM1Zsqtm+j8Q0?=
 =?us-ascii?Q?eSyg5O8oBUSLZtJ0mffnShpqd/9O4IGvlhOeooTnMmF8Opqdj/qzYjLz2qHz?=
 =?us-ascii?Q?M6ovYBgPDuEY2TvM+oboqIs2/go=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8154ba1-360a-44d9-5b2a-08d99865ce4b
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:48:47.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wF/LaDqqbH16ke1vkXp1P4nfy9KlP39eXRMKrJkh/kjzTFS7+oes+8NiPbQUo4vVKW+SkciPjP2HEmxwyO299NQeb/JikNgsUKR5SIVcNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7448
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 09:18:39AM +0000, Richard Zhu wrote:
> > Isn't this something that depend on the actual board design? From the driver
> > point of view you should not silently enforce such design requirement on the
> > board.
> > Am I missing something here? Would be glad to you if you can clarify in case.
> > 
> [Richard Zhu] Yes, it is relied on the actual HW board design.
> This regulator is one optional, not mandatory required for all the board designs.
> So, there is one _enabled or not check before manipulate this regulator.
I think I was not clear in my question.

I'm asking what's is going to happen if the vpci-e supply is used in the
actual board design AND the same regulator is shared with another device (to my
understanding this should be just fine from the regulator API
point of view, correct me if I'm wrong).

I'm not talking about board designed by NXP in which such use case might not
exist.

Francesco

