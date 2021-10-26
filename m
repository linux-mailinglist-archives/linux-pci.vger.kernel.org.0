Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5423A43AEC1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhJZJN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 05:13:56 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com ([40.107.3.135]:53222
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234064AbhJZJNv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 05:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEIvAiPZ4y55NwsQVdAhLgrma2IBLkLaR4ug4PHQn3Eh7Sz2Hhs+5bcyrpbZIVjRXR90MyYdMVM0ed10aC+8Yn5Lf4Bg16+MDdyr+nVioiKUthtHgoyuKjCQyhOgvmG5b4Z/GIxmxVnNc0bdi+Udn2M4/JVcuQsOeJjqxaYNDxo4klXSFc17BG3AXfTfKLkdbWXYRZ6KPLGPKLYIvoHzhdGlhta3oSxpMCKp6Gznh/BebzuUoYZCvvGGoM9w7WVRbGSgcaCN4L8cCtW18mETcPPlvs9MI9uYRw1R89gyNXcUIGjOiT6ztGJXRqAYMpY+DXZHvZuQs091X+s3RmUidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UPIx/+0xvVlnmDlzZHEO/W9aadCg3EqSTQq4tOSfew=;
 b=l+Vb1KBvXREk0qDa9DXHZeFY/hGHNzfc5YJ9ZFiSHE5k6Np34KjmyAsYqdovtoARmtlj43t7l+885DdDBD03BpiOw6eIoiQCmkoPCyMr2+J+Cdtwhdg6uJp2tlS7UqphpxgvWADzBuZW+iQPfKbmLMK2oCDxRfUKTNBQugU97L6stx/CskolGfGjAsny7fzwok04ZB4/t1Lc9beyCgR7ZR7xpLkkUSw+H4ae6LU7StAJ3/GRtkEUEZkR2olFvT90ucypL2ALUs9h8jmWApUIw6yVQs6oAt+7vc5aGpjDhCZ4SBSVvDz2mXLCEnQna+f23ZWpiD7ZF4Q5em6sDUkbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UPIx/+0xvVlnmDlzZHEO/W9aadCg3EqSTQq4tOSfew=;
 b=Wo3dI0r6Wzwt0IQ4X0B0zkJBE4mV3CMTbSICJ70dPfrofhHjjUGEDtojcfpK8EvDSUH55cwpxnkH31LjyWYjNYBxm3ECMJXX3SzDEpfckUIWlgukN8th7BVcE/xk+LTHFTQx27XzggG+KqJ4VDkd5tTciRHCPhgRgRQay6HPppw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DBBPR05MB6412.eurprd05.prod.outlook.com (2603:10a6:10:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 09:11:24 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:11:24 +0000
Date:   Tue, 26 Oct 2021 11:11:23 +0200
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
Message-ID: <20211026091123.GB87230@francesco-nb.int.toradex.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026085221.GA87230@francesco-nb.int.toradex.com>
 <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: GVAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::17) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by GVAP278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 09:11:24 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 2FDF610A3730; Tue, 26 Oct 2021 11:11:23 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a097a4-f32f-4f2c-bf19-08d998609588
X-MS-TrafficTypeDiagnostic: DBBPR05MB6412:
X-Microsoft-Antispam-PRVS: <DBBPR05MB6412A2D381BEF772FFDDC894E2849@DBBPR05MB6412.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vz+wAIq9ogRvcl62LrU2/H98rBcTA4bD2kh6FbZhfh0hOYjmpk3OQtRKtm2ZvKTkI6LsWlHYPZIEzncxLm5DvebcGSdlnGsrHfaje3QiIR8pcIPfn0A1ppVg3jveaicCHKhtH1T5XZrEYuTPJEcAcjNviGcsiaN7qtRzgYMB/YOpPCaCZsINFNH35P2n96m23lYbZTy/BLmggFGC1R8W41RSxTlanRfZl6ZKyQKUtPNGKK/R0FpvXe9Hw4MT7nhsY59kyuOaDg1kAjyTmwNsXXExwG4Aa16yCW9Bp4fqpQvWAHThs1NCKSjUcEB/LFwUuznpQBI5dHDaqTsypOXR7VMMUhTSuNQMgz/BhfakDe9xswlJq2Pg/8Px4tPp5mJSt0F7JRE+VVlsA4HZr/3CLu8gbdwTR40JtnNLqv7S1aa6v+N5I7meMXcWIgdhW+NOIHXdqC/njFipitPfrakiMYQiRzdm3Bh+jkHwfb5+XuK7xrXeO5xKEY8uhTGwjmXB7aGRk4H0F9qHOjtmIXKU2/DnR9vakAKvjVGDzQu2qk4OXFTT5ISJzVgDNvFx30FscY6yCExCA0m4x6nS4+9/7+8q3LXiiqiy1/RtggG/Ynv8H9TjkVnKQAPknqzARmZi1CuNlKEbj+H2rH0QafIgnVJgVMraQcH9vl/pWvVZvqUSglkdFdEXFQfmV37QFQOE2P1Y17XjDKxFWGiAziNYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(33656002)(66556008)(66476007)(8936002)(6266002)(38350700002)(2906002)(42186006)(186003)(38100700002)(66946007)(26005)(316002)(52116002)(1076003)(86362001)(8676002)(508600001)(4326008)(6916009)(83380400001)(44832011)(5660300002)(7416002)(54906003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WL0OKTKBLpNRzRxhQwWOeN4F2Ww1u12kj9X1w8jbFgBs1AYil7ualmcZ5iG?=
 =?us-ascii?Q?A46jXjrbSeSS5+zTP4NYw5Z8/365JqdkDmKglDM6yWaYSxgJ4xxtC3mdtlV9?=
 =?us-ascii?Q?spLEzlpm0lSqdb+RImEfIAzD58qWSF84Z6A4gqEjtxle8qKpn8SaRna0gcvb?=
 =?us-ascii?Q?/p8gjIZqgE4PmZ0bx5Hrt8lw3hk6BHDAgm9sAlg3P+HaNbK7QVchyuvoAzjU?=
 =?us-ascii?Q?cwvKKgMWmEsytcxijbsB+IIp/PqBCCO0PTCgwgZYKGa2jM3BfXcH8bUxWNHB?=
 =?us-ascii?Q?bZuXCmOpyf8dxgfc6UEJrUm3N4XnPyIVJ9HKzMh0iQ9DGaV/fftPbN83+zCi?=
 =?us-ascii?Q?Fh/1X2CtU9iHu1vbZMHvtcVut10C3/uw66sJVDvoRhJ+oEw1F8j6emQE1Z/3?=
 =?us-ascii?Q?QVTgAuU/srRaaqFUYkKhVhLZ0pEvnMoR70e6t/HzJBaisM/mEbtXUTRrRYhv?=
 =?us-ascii?Q?p3db7VdC4GcrWoN4gv+oyFij/GAYFGIBvCCYp9krf8UExd5lZw0T5PdPAQ+0?=
 =?us-ascii?Q?bhJVg1XrunplPDd2iUl5M4hGCBy8yn4QV+IMxNwjj5j9QC2K2UPH33pXZcdQ?=
 =?us-ascii?Q?j1Vlk2DUto2EqPCpC6TxZzKrO50TZdb9krv6fGFe+KFvPvpFoeH6nksdbGRx?=
 =?us-ascii?Q?cq9rhRuNKnJt6oa3oy1uOoHxieyRxg0ptkbRCFUMYkR6aY09ZZ6WBtaUSxKR?=
 =?us-ascii?Q?WoK1hB4hCzU8dD11L/C5kzBQU4wF59MuhT4jwVqFzCcmM/QM1fwLNFL2RT8q?=
 =?us-ascii?Q?LcD0Xwz0BvUQH4sZCZ1JNoHogwWwfY4RM6s4fFw3wf3yfpuZNHdNGp79M5qp?=
 =?us-ascii?Q?KTlQK5P7G6yER7xqBtvw+wrpfx9W0UpBYM0kWbd1FnDrax/4StfZ6H8vI6Th?=
 =?us-ascii?Q?2Kz235FUspl3KjCJdJwAXNxBLa4hPFxgvIW+PVO51hMiVxl5yD9pDCd/F3Ag?=
 =?us-ascii?Q?cY3l0g8MQylyrVCBTdJFlsYkY0NdEpMJ+TEFicVmyr1BZZLuH8oGULKW/awu?=
 =?us-ascii?Q?lzOYmHAkUqNu1aTJO22QsXoH7XMVwLZ9Ra0scsH8+7yYWCfHCwbSoEiDsDaE?=
 =?us-ascii?Q?4A/CsUfZ+qFnOA6xkLzww4ZqPGYDK/Jd5dyLnRHK4wy/aNR31y+pAyFm1zRU?=
 =?us-ascii?Q?2KmogehKZFLzcVlwqbPEmKgCdLaTGRGnfICTFH10eDRIqllHMq9h8cJBywSH?=
 =?us-ascii?Q?qgfM5B6fN5BLSfHAEvxNu6p9yymUMFz+FKjm9hJEMS6t4KtQ3kpymxIqUIJw?=
 =?us-ascii?Q?65qHN4VLg1Cs+PDImqaz2QVKtdS+g1CFMitl3z9ZPxCrV0drNDshdKisFrI8?=
 =?us-ascii?Q?6DRNTB4RwkWxlxT5A1a+7Te/mW+C7gft6P3w2Fe4hU9hqNvyjRqUpW73uVcT?=
 =?us-ascii?Q?9IKpc0dSvM8VRYlJkdZu30K88zFtDdkbQbjZLdlw+TDr6raFVhxBAnUHmyRa?=
 =?us-ascii?Q?ua3e2UNzyMo0TSYZtiFiNjX51qRMQkcufJonIscum1NmDzXS/N/zEBbbe2wM?=
 =?us-ascii?Q?ylFaTPVEXx6ShnztinRfYzFfaUkoHIAcwULNQFYQk8xMyObLphsEduH29UMI?=
 =?us-ascii?Q?HG8WpukZJhm7f2Tzs8Tn4OCsE1ZppAuumsvwINIPw5o/Rz5nIRcMj3+LSU46?=
 =?us-ascii?Q?GUsG1zUhS5Oeb5clbpN76JN5quAUq1Lenlv/rFdHdK+h0vBwev6idX8uU9w+?=
 =?us-ascii?Q?dJys2U16hFeDE0xM9y2/WkwXXbE=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a097a4-f32f-4f2c-bf19-08d998609588
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:11:24.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nj59zBuvSbKZ3GzgRR8bGf11cSyok1weZ4ZU82bdstehbsGZbg7T3ntljJx48Huv6bk6JjtRhDoFC9UBOI6gzdenJMTTl3tG3q2kZfWkACE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6412
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 09:06:56AM +0000, Richard Zhu wrote:
> > -----Original Message-----
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Sent: Tuesday, October 26, 2021 4:52 PM
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Mark Brown <broonie@kernel.org>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>; l.stach@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> > linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de
> > Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
> > came up
> > 
> > On Tue, Oct 26, 2021 at 02:18:18AM +0000, Richard Zhu wrote:
> > > The _enabled check is used because that this regulator is optional in the HW
> > design.
> > > To make the codes clean and aligned on different HW boards, the _enabled
> > check is added.
> > >
> > > The root cause is that the error return is not handled properly by the
> > controller driver.
> > > I.MX PCIe controller doesn't support the Hot-Plug, and it would return
> > > -110 error when PCIe link never came up. Thus, the _probe would be failed
> > in the end.
> > > The clocks/regulator usage balance should be considered by i.MX PCIe
> > controller, that's all.
> > > It's not a general case, and the problem is not caused by the regulator
> > support.
> > 
> > Hello Richard,
> > I have one curiosity on this topic. Does this works well in case the regulator is
> > shared? I just want to be sure that if the regulator is shared everything is
> > working fine even if the PCI-E link is not used or not coming up for any reason.
> > 
> [Richard Zhu] Hi Francesco:
> Actually, this regulator used by i.MX PCIe controller driver is one fixed gpio regulator.
> Refer to my understand, this regulator is not shared by different devices.
> 
> Up to now, it works fine to power up the PCIe slot populated on the HW board.

Isn't this something that depend on the actual board design? From the driver point of view
you should not silently enforce such design requirement on the board.
Am I missing something here? Would be glad to you if you can clarify in case.

Francesco


