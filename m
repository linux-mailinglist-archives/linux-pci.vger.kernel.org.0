Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F972832FB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJEJQ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:16:26 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:63998
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgJEJQ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 05:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErR+hzTbhVfsPwPC5l7xcK0WhpfCf+AjwDuZIp0ridc0NM37Ok/hnjrl18jk7NnWvV22kpioy+jr/GxhUtA5bZbXYRfBjMhsosKz+d3WkYqvrJP2jN/YDvL9fp9QjLWHobOkYmtun+Kp+eUbMUy2XynR2z58VwFE22CxgI5S8Nz40zGDshlq+NHHxxY2nlRn16v1YNS4YtJDYDS8R9zvZSx5z1LGNW5iq/Zo7SafOVDYnsRHd3YTTaf9X3iRp7kzCaPKBSboXTO7qEMU9BjgHt8lzqkQjGhyXYpZSmV2eKBVKYjkPA4qMbHpv4IkHyAImagrIU7XRdZm/1Sc0tDwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEPfIZpaoOPBJOy+x6w9JF5nh5k0AGs+Z4AhvgdBQLc=;
 b=nUz6xn5sTaKHQpC0RRckBIvkF9QKFRE3ogyTV82zjgA/GK5yvVpwR17H4EYrB2O3FALdG2EUMV5prPQFMfobtwHYRmRLYZOK3An/+GXRfe++mfebhzc+85rURub9COJMK90XJe62Qb6XioSTzqt9DJdbkF+GaE2rnC1/R6+9qmgf4LhWb7y5Gg5GpFnpSxsqiyNUDowO+lw9rUhPKJ14v0unEY0qXPLWlD67WYj9dkNybP0tErvLnYp9P944QSK+F0X1LUkoCWuEyIJf/OtO4XtJHvRYUmiRYm1kavyIsV4mv9+G67sHsB1NFODolV6FBike1ALW9/sz7N+P3CzKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEPfIZpaoOPBJOy+x6w9JF5nh5k0AGs+Z4AhvgdBQLc=;
 b=M7ghYFMBD40ZR4eisO08iwov5R1ae+OGzd1ypikgm+U48vvTsGY5BKJXxeWdr725Kyd/9kb1CIUvcrWJn57J8CqCorLJWR7ypUFIi6mWzBR0Y+6fQ/Eh3oURkVyZwyT49vQctFKhVdbcjZfSURu1FzLHcvHB9zsNKfO3IxNsNi0=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5560.namprd03.prod.outlook.com (2603:10b6:5:2d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 09:16:22 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 09:16:22 +0000
Date:   Mon, 5 Oct 2020 16:56:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next 0/3] PCI: dwc: remove useless dw_pcie_ops
Message-ID: <20201005165657.0fd31b10@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0070.jpnprd01.prod.outlook.com (2603:1096:404:2b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 09:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9296379-d199-428d-fc04-08d8690f53be
X-MS-TrafficTypeDiagnostic: DS7PR03MB5560:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5560063A8CFDFE4EEBD036CCED0C0@DS7PR03MB5560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nx+x/nJdE2mzKa4MeNTcU4PyHmz9N0m1NQvaJzP5gcEaMurQOcfwMjL1HIfucU0iMxO7bqzeKfnl7jbL5+P7ziyePpjUx5gk+txHBHA0ioQKTHoa2sCw4ZKG8MExFP3maEGmgj1JMXtgV6OSZeVc+GGMBRRRH8jIrZWcPjvpZGFDGp6ce6OR9+sDJzTGH8DMFQO5ELy+3SrDB1/Pk/uhBRrTCCnjZAo/UGSmW+UidgWHn4CpWCsGzhG3SH4n5pyAnEfaGzNEPzRD0ft28ymk4mKTbezsnbiYi+68Zby06QXGDIgYTx93Ho7WM24Eu2ZdTl/z4AwMn9cpb9aGPtIOJXhPNhN1oLqJPW3Dhhq/mf3aF0EPvvyZG8yjbKM3glZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(376002)(136003)(2906002)(8936002)(9686003)(16526019)(66946007)(66556008)(66476007)(186003)(26005)(8676002)(7416002)(55016002)(83380400001)(4744005)(1076003)(5660300002)(6666004)(478600001)(52116002)(7696005)(316002)(110136005)(6506007)(4326008)(956004)(86362001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Zrqi1vu5HPXYVA0DkLno1ivWmcOvIGmhKsDyk2fGVi8YulKRzhVNtA03MIUu7SwptajGiFpEVMJr7H6WTOO0wjsdZDAkO9HCLaxqiw/kaKjPnhim8B8GUtZ5nxy/+GCpnINyPMpjffwA2rUR+crxNdbd9S06j5FECaeT5OTj4vR2VcpSklzhMaRadtb/qtLnK2+qKUdA0HmsdA7evNXgEOv1IuGovZtbrNY3FRtJtLq1zfnrW6ViPN60HhD0KALD8eSwg6rEgoETxWAWD9QhFi4F9OruoB+YIzPuSScbHs3POij6/sVMwrDVqhKVRVZzHg9WL/vO2DYHuP+/UA3HppUrALxk5hsPF8A2rXVdO3zGBwIOJP5kNgEom2Z5NiS+px7c9suS7hnERAvLeXmg4FU30CNwTAmpNE1spHWDyJYmPjU05tX/UqLH9pdbYxo+SU5eFWeIetxLUM8hscsX6e22pGomthVK8BlXCz/iZL5f8FxPSodESHDomctLNDG7yb0Gh/y41Tj7GJDDxOxl3ahQOMFMXWbOyEwFvaEmTi2ycAU/le/7pT8rbbs/NStaZeQmVbnVq+jvGvp7op8jXOomQPz5JkSAIv1tL77TIgw4+UHUeLVYdXKfiVOpeZ0V8/Axk9EVcoSwWhO95l610g==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9296379-d199-428d-fc04-08d8690f53be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 09:16:22.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkNXXQfV4dWz4cc7KQFSbPpSMcwZuPzLVHhtXaBfLKOAYz8p4JBYWTTRHZ1/qWT5pOm9D1J5lyK3GH12WEN1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5560
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Jisheng Zhang (3):
  PCI: dwc: Don't assume the ops in dw_pcie always exists
  PCI: dwc: al: Remove useless dw_pcie_ops
  PCI: dwc: imx6: Remove useless dw_pcie_ops

 drivers/pci/controller/dwc/pci-imx6.c           |  5 -----
 drivers/pci/controller/dwc/pcie-al.c            |  4 ----
 drivers/pci/controller/dwc/pcie-designware-ep.c |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware.c    | 14 +++++++-------
 4 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.28.0

