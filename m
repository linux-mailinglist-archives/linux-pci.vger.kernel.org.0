Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF07EC50F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjKOOX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 09:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbjKOOX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 09:23:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE582101;
        Wed, 15 Nov 2023 06:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf9iZJPHICdRceNdmRUrkwH7FvbdGMMSVB/6zKIRClKS39uMhIIW46SoReBhhKRqUSCB9UymKYeCW+iEVixhjXYm8Jo9GcAB4smZhl3NU/bGxLyRNWKL4TLwT0Ub4lB32TposV0pXuABTK5rkOCr6V2iCXW/kLAhfIALIr5gz07rpYMvDgvwswP9TdFQH5LVKJeL97C1y+sVXKpZ5x8zKqeqMwXGwCd8pGivaNvX6+r8rpdZdEDfdx3y/8wc/diLyx1IowELbvPbIt5D1YLEKvcjNNXPJK5WzxJZ3dcIzrxlLXEn3ETTorscaGGDzdXSo2ZuXECwxNA0h0+o5Ql4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4fJKQYvFc+801jtxv8Gfg3APZz5DQaTViwHTNk22ZM=;
 b=ZTSoP4adPKV1b7ErcrBS2MBBY15WNYu2oqwzUvuEfNHYJxt8AexxYvu09e+TENHbCXNyD88apz0V3QET26FABwMqqe8Ym1fUL47jYFq8FC3aqlPR2PFQXTtBuom+q1uUEl9XFIrw6Qn7hYz8Yxtk53hltcxPYIymH2g13N/HID3eUUG/M+2dLg/eZNLsbWemhWAYmf+JAo90mHa6UsL6Vh2uQMOV48PZkufhahgDz+b+7L/tdQX8o/d9rzVDkrQ30QyrrqlFTRjZ9bS3kH8ebQFnlj7L2pFtDXDoilnxRw1pSFetkaTaB/DkAj3PHY1c1lNQkVMMbykzTOjVfhO0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=amazon.com smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4fJKQYvFc+801jtxv8Gfg3APZz5DQaTViwHTNk22ZM=;
 b=PRp0UfcZ+/xyZPcnD545wiZO+JiAz+2bWDoYTtDelCmQqKY14ffjfCsxe/EQux4JAD3vGIhavl8sOaQpOqPhvBrTyfuoKbGNx7Yk+WPIK0Vbum7m12FDqyRTkVPnHKBU0IbgKflcjL6gHCJ7Uj+3mI1nlGRraD2i2KBx/c4ETzc=
Received: from AM9P193CA0025.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::30)
 by PAVPR02MB10413.eurprd02.prod.outlook.com (2603:10a6:102:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 14:23:21 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::fd) by AM9P193CA0025.outlook.office365.com
 (2603:10a6:20b:21e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Wed, 15 Nov 2023 14:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 14:23:20 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Nov
 2023 15:23:20 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Nov
 2023 15:23:20 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Nov 2023 15:23:20 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 40652238C;
        Wed, 15 Nov 2023 15:23:20 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
        id 3BADB62829; Wed, 15 Nov 2023 15:23:20 +0100 (CET)
Date:   Wed, 15 Nov 2023 15:23:20 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mani@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Jesper Nilsson" <jesper.nilsson@axis.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Chuanhua Lei <lchuanhua@maxlinear.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Message-ID: <20231115142320.GE11805@axis.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|PAVPR02MB10413:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f5948e-abfe-4eb3-642e-08dbe5e66b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQOWxFcdwgVHk1pj3wVzgjfhHtsDtq0ZLxfZB2l6j2Tkb/0HgZOJxnYP5Rjloxo/mrdujjI7tbzuKVd8qBrRXA3d9xdyd4l0noe9ca/Ri0vvT8+1owASNS3E50GSBZnOn4BQBXw+/4uRTiATgEBk3pz2JkC+sjcJ/UTtuIxZhf0nV+ctbBmpZCdZeAlfFPLbDbHAbfOt05iCGyZm9E1pHiF4MEDHuaA5wqZhmV7Fn2gyPS/gptNT2J+bF+3jyOe+QPf5BK4e/S/d3md/C8Vmt+6DSjvoSIDcmmMb8I2ZaUn0DORBHAxuiqn+ayx2IF+x3mxTRoL3LlzfiD70H56d0msARFW3K9bVGvhx5BlaRFAI4xB3DpBxrdzNVUyIjPnExQIP+lX6PFJWK0dvRTzV2RWdgrK+APRTg2Mixble6pAF/d/WsB1iYUkDLWMwywSUAG0FGUiResepBAwTqbtRv9QQPi6G0Kk1iQGL3tbuJD9wvNxN9Yyh+egSx1NzgvMEoCS/oY2hhH/8G2Vg+dXUBLrV5k5WTaqfG+hb6PVlLbr6oYrA/QYJlStefYyEcRkcRRtn/NutPk6v3fP5dezWenCNccDlo4nsTz0D62Cn00E3G7HX6caXsnjldqZpGFyVineIlpZoxHT5SAvRaRbTZ7YbwXBaZtxf1oic1ZGuvp/3OdVkyXZbZhb1ot4InKqqYD7s8k/nBnzEvvr9365p8IWVN2d7Yr4cQozg51+/AWmTXCX00GhEfQyBgRwpn6U0pxSXFE8O7w5IRQyYayNgJw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(81166007)(36756003)(356005)(2906002)(36860700001)(4744005)(40460700003)(47076005)(7416002)(7406005)(41300700001)(5660300002)(42186006)(40480700001)(8936002)(8676002)(4326008)(86362001)(70206006)(478600001)(70586007)(316002)(6916009)(54906003)(6266002)(426003)(336012)(2616005)(26005)(33656002)(1076003)(44832011)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:23:20.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5948e-abfe-4eb3-642e-08dbe5e66b63
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:51PM +0900, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_host_ops indicates that it's for host
> obviously, drop host prefix from the struct.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
