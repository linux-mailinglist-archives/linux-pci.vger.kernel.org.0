Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83843AE60
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJZIyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 04:54:51 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com ([40.107.7.101]:17045
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231404AbhJZIyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 04:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaR+/2AuGS2x6X7iauBG9tsQN8NMHxNsxGJQ30OXvRhWTNVSmTrSb7Z66ZenBgJhiKrlRLLXQg9Dhpv8k/O/1WdH5vlkxBBrU+B1tu02uK+E+2IPKfsFX7hu5aM2F+BtVoZLocShAimn+3oG84CsbMSdMDsrvNAa8XmQKI/fVAqPSZ1nR1F+v2JgvSDiGjxqFgL5Z3A+XDo9EdnETYvDrG0pbSTSZXvYTn5eSecKqMudV8CLIA9n+llVBn2L1t5XZEMciwfmLp+Fji4ZwAnswrQeAszYnLEK+jNDyWHVgYe3GAzTsm933mVRylgyt6MEfg47xw+0Erij4n3EGUtn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnrBUrSicPV5gZjGJ5abugqoUCEUOuzXB9oT7iwHJhc=;
 b=W4eaprJ2vUVtmjt7V020I/qRQcFvPQc5bLHQh0PzXiEoXBGtXwJztCVJOuOe6Vgv5yRGXSJ2eFQPZfa0cORGunJd2lHknvfwXFoUsPDjco4FxVt8Sy1Xu1QU1m2i+3hv+D0rK61mE38kvZG7qZi9XT32db/PHbOxYmZxJgx/6nzHAR5vL7RiXNfqREe6PfEvGpp5Dt+uSCbSiN9LMfh7roc03s/QHwnKtl2igfmdn33Wem9kIcsq9c8wps2msaPZ+yGXZkW2JDTVPPkWhCqQzLQtNETTlgzocUqZjHoM5xMI3k3VyeOxIo1mIXXxDqTB9934AKvp6htoLDYDgStheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnrBUrSicPV5gZjGJ5abugqoUCEUOuzXB9oT7iwHJhc=;
 b=q1XcOsgcp33jidpGHBFTzWVBvBuWcERJLuaLAVmUXH0G+hKAN2z7CS9IZ+aYLuIanm+G7jwjBNnNiiF+yiOkQKT7DBHtJFBgXTqhHV4VE08n6xCeidkMaN77Iba3Z/ojYSoVoTt1PdGCKYmvoK+kZJn+8ai5qjY1ClvH/6Lm2tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB9PR05MB8298.eurprd05.prod.outlook.com (2603:10a6:10:23d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 08:52:22 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 08:52:22 +0000
Date:   Tue, 26 Oct 2021 10:52:21 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Message-ID: <20211026085221.GA87230@francesco-nb.int.toradex.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: ZR0P278CA0102.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::17) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0102.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 08:52:22 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 5F38A10A3730; Tue, 26 Oct 2021 10:52:21 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9b0aad-dce0-49b9-e758-08d9985dece1
X-MS-TrafficTypeDiagnostic: DB9PR05MB8298:
X-Microsoft-Antispam-PRVS: <DB9PR05MB8298DE3599918D2D966D1515E2849@DB9PR05MB8298.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl8nOKTd2yeXbIxrmfYX3RENOGU/mM+OkAurYH4OYAycPyf8FOnSuJ+kWYh9jbg7k1Mwhfda+ufs+qxkAsR1h1GWpw8RA11sJZr2pdQeKh2Utok7mvksxHWTKHCKpCg+IR0GGzEsmoNn9Mi2ycgVeJ6uFdKTmYjfkHK8Rd7qjd9Mu8w9QynLWnW0CVLyM35zo6yi3DdFnrZB33T+Viu3knmzjJ64BE8dgsdwCCuHqq4pz1G24J/fDV5YgN79WNFoyNkzSn99yLf8p1kjM5efJL15sMtWzAe4jwOL1W49O4l7LgYgmLvZmt7WHJS0VFUF/TvLMnp9DpyvSAlFTJ9V+7GxSCNJwg7oK+jO9K5EdLqgg5ZlpZTMIaKT1X5BpzFz+bZ7r7800cgeAhtOmC3zGA5HHZQfvpeSKM7lwAxVjAbEy1X3SzMlRV+66K6K4/KonCS+EQJr0dsH2VDzdQgcohtWMpTElegOgrfyhxmJxLEmQVfvO07EqyRu96AgUmGiT/es/vDAPA37YEQfn7ruh3PMCEPTm96FAvPZiwL5WHva7goszoDMH92Z519dcGU4pMSiuZWd1RC8NUeY8TFrsW2gZVH/X+hICiFID09heB6P1XzsG8sALuBNa6dYPpqKNPlIEVi+44OIw7XYFtbHAvfbaz6g4NOXJovaAAJNR3EvMZqbiW3tOa+Rh1s9pcd32UY3rvKsgRLzpo/cqI87gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(33656002)(2906002)(38350700002)(7416002)(4744005)(38100700002)(83380400001)(44832011)(1076003)(54906003)(186003)(508600001)(66476007)(86362001)(26005)(6266002)(42186006)(52116002)(8936002)(5660300002)(316002)(66556008)(4326008)(66946007)(6916009)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZw2rhPHtSEvTvdiBQtCst/AvAnNMPM+QQPsAltlz1JBc0SlnMNYNFhZmacF?=
 =?us-ascii?Q?w2kh4jT1kek2EOQ8RfLpyf0/VfYx24TsPQJEN/bK0GKFooZWFzTxeGjDw8QN?=
 =?us-ascii?Q?1kgTx2DX2RoZ3Zitt9xjQfyN3diaAPMQMuOhzxd+Sb39dUvz+BSt2Kx9nwbS?=
 =?us-ascii?Q?WVPr2vaXejsqWbw9vROndhC4g+eyF64/MxZgjjNvrirHjRht2qG863kX+zUa?=
 =?us-ascii?Q?LOQd1awtHWN/2bWPMXU/lyoKQ7BUn4eBesN58rQvzDyzJIx2xJgijnB7C6tJ?=
 =?us-ascii?Q?QBnbbxOaTYY6ywAJNIYBEh/iaRrsS9NIcKkMlg/E1x2WH1yE93elmsDRpwO9?=
 =?us-ascii?Q?oaSeTLx2zLWCbCKEYWoi6SZacSNLaDFw9baOcI5moPMTDRrPqYRJ/qp/nUps?=
 =?us-ascii?Q?gsRSBjptcLTrJfQVwlffTu2aefK7cz7fxB/J3ilbB+eabD6x5sBF7w79uuep?=
 =?us-ascii?Q?lrGdYj5EQiOdfzU2AddR1fMuUzQ2pohsmzx7i2+yEBDOuTCgwPDHCpnbnpAS?=
 =?us-ascii?Q?Gab/saeL7NKhX+J2xOkpqHwqr2vkPIh+rjBCVOqP85+UyuEy+0Mt+oTHTPrh?=
 =?us-ascii?Q?quYy05Rd/jS2uBKMNF2xw79Ut++wvqkKJ7ZoZXYSsyN4ZV02EnfeByjjKF9U?=
 =?us-ascii?Q?/fiQ2vscVGzPQf0FRIh0o1VV9BmmgrumuwYdhFPkfykGlRx++ksb3WIpdzGB?=
 =?us-ascii?Q?LwN6UeWeSGcbW1sfXCaGYp2Ikjo5e3D/MHcXZf0cFEjNHMGaGjqTy/oKRUo3?=
 =?us-ascii?Q?/TwJV830jRiqkd+2/IBhi1uUa+quP6MZkRlxlqmwu6YFd7/C5alVxbVNCJ4A?=
 =?us-ascii?Q?FyIy78vY8v7Oy4s7/V1l3tm3kFs/AEVf+hZFyxG4GEQhuZ8rNUOKyx1qTVo3?=
 =?us-ascii?Q?9qv4WG3HNHJ3PSyBKwu5bFiLjOdPVpX5KaePHIgeJ7HHm+ishevgP5FzJfwa?=
 =?us-ascii?Q?u9wEPlaeq3tPIZ8SgJ9KJfPHJrt9bWxLX5ZKkJidBLe35kDx6Mw6XyIv8qqI?=
 =?us-ascii?Q?amUKkh/a0RMuBBbpK/LVOfJL5mMLVkapKylBH/28+9PhUHDbjwF371i1V8cr?=
 =?us-ascii?Q?Qjsj+SfYISlsr65myEOYRCyQBc47JXDeD0KdQvPCp0C7EGICNnbXvryTvFGe?=
 =?us-ascii?Q?ZN9OmLIpz5SVX4zifPZMcF6VQZ4N+y/EtexoceRL+uiWNDuj6gyPJlp1hhNP?=
 =?us-ascii?Q?UZdP37ILERIWL1A0wUwDSYiLVW7p5hC2HLrizBX3KvVbcrXp/9HF1m9b25av?=
 =?us-ascii?Q?vowq3SCYxZkC49yYx5mIMTeF2OR4fZedYul7HnzCPydj+kLJXTJf0f4awCm8?=
 =?us-ascii?Q?6xE+UwQRT13ASLC7YpfpyZYUL/EBBgL8JyRqsq0214dhetg8FE59eryf0v5z?=
 =?us-ascii?Q?5oLkr6RTXpTR2dXWnc/MUElYFPdOs/HLsjvxgKhAo081eJzg7ZkwiBGPP4/V?=
 =?us-ascii?Q?u4rc46D7vMWwKm3GHwI7803Rda2eFy4040KKBeqPM3QZHMkjbUgRt5yhooM0?=
 =?us-ascii?Q?FFStLwC+aczD+EROi1fS8pG4qiHTcTn8pH652BiIxjBBRTXYYcetHniR8VjA?=
 =?us-ascii?Q?lFjLl8g3BJUpFW6CKZYfjw8PrT5yNSelh6XpPLNgT6L9R7NWBzr10rh1mNjS?=
 =?us-ascii?Q?kYCpb97AjTc0g5s6NltaHig4M+Jg21lQykv5+BW4X5hLt48bsp3vsk25AQFG?=
 =?us-ascii?Q?W68WCR2CwIZ+Hzrk48dZAqwvOV0=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9b0aad-dce0-49b9-e758-08d9985dece1
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 08:52:22.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW1GRISOX0BBZfJKsC95DK0hhVRpjZXOhJ9T76ILxs7wFdE/EoUV5lrQzTGelGpKX7JdYVYVrASC1Hcz684VWGEaET0SWBkk+EMzERiBmGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8298
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 02:18:18AM +0000, Richard Zhu wrote:
> The _enabled check is used because that this regulator is optional in the HW design.
> To make the codes clean and aligned on different HW boards, the _enabled check is added.
> 
> The root cause is that the error return is not handled properly by the controller driver.
> I.MX PCIe controller doesn't support the Hot-Plug, and it would return -110 error
> when PCIe link never came up. Thus, the _probe would be failed in the end.
> The clocks/regulator usage balance should be considered by i.MX PCIe controller, that's all.
> It's not a general case, and the problem is not caused by the regulator support.

Hello Richard,
I have one curiosity on this topic. Does this works well in case the regulator
is shared? I just want to be sure that if the regulator is shared everything is working fine
even if the PCI-E link is not used or not coming up for any reason.

Francesco

