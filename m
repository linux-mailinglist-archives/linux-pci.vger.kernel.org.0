Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9567EC514
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbjKOOXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 09:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbjKOOXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 09:23:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108B2182;
        Wed, 15 Nov 2023 06:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap5AZvSrwDY1tT3BlgCTfzJAPLNWcQ1olgkmWSWgckf2XAfCJ39/ebLyxkj6h98PzcDF5hv9t4/tDLEZTsXc2lfHfKjJmpThi1fBX/41qXl60h7VWMUyB9KLX0UpXy5+FmVOFLw8C015ajs/D59p1PF570ndblDjztU0pCbKn/SMam7CvQ+mdZOA0oVFvgk1nrqTtggC+9pjbeaFAF/PDqUs5TUdwhz/KBKF21HflIRAt38nFt06pmhzpJSiakuPLuoEqoLaeLWFrfy4qcF7dxbTKAkIbcANPFp5I0cHL5JLAVboAtLySy50g/eQONRk9aYhPmO90KNJ5Bo44R1GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGoI2Mgf+UY54ConOBCPorYel2RYIo942o41yyq8wKo=;
 b=L5GOrkV0OuJVV33SgGXQWiNF9C61S5H58RpZ/v6DyO1L6zEmmCD2J3Iqq9tiApy5vIk1HYVlnWm5Uj0Rx+h2pJsAyt0Xp2HBbZP96Q17X+vizdMBs7x58P12FhuM/f18QO9XhRsB4KNjPHRTnEwAIniz5sLQEtqwCn03wB6cRauCqGPCDdrDLu2/CwxwS1kyHvczj63g/y1rO7zGEzw24UpcZI4CU4u/OvS6GoSTRP3iFpZ6tG2hTjbg9Ch8nNsrLJ1txMieTgTHFfQTW96cIR/LWKJuU/Xx5Lpat0CSqmGCtb0KTaFmdaLNacM0tm9x4VNZhmwR898nyAmok8zoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGoI2Mgf+UY54ConOBCPorYel2RYIo942o41yyq8wKo=;
 b=V5qXkvdXsA7DNKLeTpf9A23Bhya6U+1ntWK6hrnyINey4NvN+p5zUhv49RghybfSpAiIhy1G2u/zNR07GipsxPoZCUxbQQO6yldOtIcP/O/bh1tVYh4frR4x7vFcwc9TMpPcSbHSumjpMXSRsVpC2t+S2skE6NBZrYs9+WgVFZw=
Received: from AM9P193CA0029.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::34)
 by AS2PR02MB8791.eurprd02.prod.outlook.com (2603:10a6:20b:552::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:23:40 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::a7) by AM9P193CA0029.outlook.office365.com
 (2603:10a6:20b:21e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 14:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 14:23:40 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Nov
 2023 15:23:39 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Nov
 2023 15:23:39 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Nov 2023 15:23:39 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 97FD9238C;
        Wed, 15 Nov 2023 15:23:39 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
        id 9612762829; Wed, 15 Nov 2023 15:23:39 +0100 (CET)
Date:   Wed, 15 Nov 2023 15:23:39 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mani@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
Message-ID: <20231115142339.GF11805@axis.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS2PR02MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 74831a17-d3c7-40dc-efd4-08dbe5e676d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI17noIvJ2cKlZWSOQ/E0Z/Eft+RNF+MMz4XI8u5juVfIxZfdQHtAlaWF2Wop6xJKcrmo5vhhoFry8EeSl2ZQmPlEMRnIbP25/qsNzNxoeOzoqsHf1C6hH0CIt9Rb1r5Dl3r9zBICXfYgEyXzBth3z0vAOSWTInhVIVqVnhv5m3eS/abpVrwTXPlS0/Uto3vw3CEdR75UvrYa98HHvZY2X8jPMp4ljNFWRORGRXFhKHc3RkdHPQEFCdYVoOW1teoWuw1P8jgGun9pEw6f+hycqdvgiaHoklA1XvyNksYuO3TDOAk/nEaWcULAbzq5OLglfs6HYjs37p/COOfO/LRXvRimjNlQErFDz7wyRXeUQhTOxOuoTO6D/6rFopFdvda7foAMPcq8qRtQ91oeZ0x9loRnawc7jpdANnxf2CI6xfZLA5acMimZuwMbUM0sCa/xorYbF20scSFxuKw+iJoYwCGGeFW82IoeHUMei0nM+UsCqm3gDktbSvYZ9ch+BcIY5RgLtwXmH1ercts+3ddCmMFVAYwlus9fyBQqhrJnd4+dsOsRgB9A2q/6AoXCi+gKuGHSfjxPIo0qGyVUjpXhN67vzXI1DtI+dMhIb7dR5KbTJxmq0hG/KSf57rPccAEyJa5VaRqE7e+iZAqXj1dWZeX3KNnzk1UmtwJPPTsS8iy/tk/CF0j2kfQFHaFwymCdg9lgSoz14dgwtm2Ki50jph4aZTp6/hOdvB81O0jZma9Y9FV36dAp0H8poe6Lt8oyqUmsWQJveUGZ8mcJaQqI0GYYgJPLGKU4430lzDkRP0=
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(6266002)(41300700001)(2616005)(26005)(47076005)(8936002)(4326008)(7416002)(44832011)(8676002)(5660300002)(316002)(4744005)(2906002)(336012)(36860700001)(478600001)(6916009)(70586007)(42186006)(54906003)(426003)(70206006)(36756003)(33656002)(356005)(86362001)(82740400003)(81166007)(40480700001)(142923001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:23:40.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74831a17-d3c7-40dc-efd4-08dbe5e676d7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:52PM +0900, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_ep_ops indicates that it's for ep obviously,
> rename a member .ep_init to .init.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>


/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
