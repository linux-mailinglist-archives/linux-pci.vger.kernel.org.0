Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3277928840F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgJIH4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 03:56:44 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:64993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732239AbgJIH4n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 03:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1azaWBRrpvbqIasm0FfeKTz7tAkycvz208c/4tbHb3uicsoV2t7W4z0S+ssdsqjiGcdQKU4/uDbWy3tkVVO6a+NJq1rhUA6XO0VsoWExXc0NedhxLH7wrPdBD2am34Tu/npvSzj6ayQFgjLIWDPLfR3PnV8Z0nxaAF4WrI6Mgi9vbUyw3b/xxsi2uCJ9Yu9Av7EVHKrXr/iBi5dTF9H7NqS9a5kfjZd1qigFsAT/T2vtkiEARcBF9ORbKXHe8UrNY60XxWIA0QBkE6EMv/6j2W2oUoY+SaCYzWpbxA15oQCJ5GhWB33lBJKE8y5k5EbL/DlbZnkw9/DtWlAMbn+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it498sSJxLGotkiY3lUHwEdRwd7dx1ITYgD80sa2CUo=;
 b=k/bWypEPWjXtxVUpEkcMfT/rRDrbCbEIenMfbUrNuwYGW4ONYLnoQ2o4UBLXy+9ddvGvcaBqlVt8DQXBMkF325e/6+kJ1hJPMXZXxRtwwK+LKeqj3V+7XnxHS9EVME9a+xh5A6n+SALXjhl+RXIkuzmoCuxF091x6wCoLBDh0IQYyFCaiFwJSgv3hJZANeG2FfVgeIKrZjhG2cMUicB44DUNgUFRgpiN+QWlp99r6XJvX9/aj/yiUGlwAaiurYYybFWqDUFG8q9nzgw8BT9EOmw75FOfC9+3oM2FRyQDQSZ6tBsv+J0AYfoo/AD1XrfbCHrYtCFmCyTRfBp2hCPVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it498sSJxLGotkiY3lUHwEdRwd7dx1ITYgD80sa2CUo=;
 b=oTUnpYMKdAie0Jh3DE9rkAnag8fZ2XXuD2O64yX9t6dKTDerM+no/GEdcA7/I7VYa8ODZ0uYBEUUBLXYbCHBpXmYFtcQRTxJQpa/c/5Tpbekqjfx+qGLDtfCVdqR4QYT99c80hACYyCS33ai1ZlEqscT0jMa4bmEIAcIy/D3JZw=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2683.namprd03.prod.outlook.com (2603:10b6:3:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 07:56:41 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 07:56:41 +0000
Date:   Fri, 9 Oct 2020 15:53:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20201009155311.22d3caa5@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16)
 To DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 07:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0631e0b-2b03-417a-b0b6-08d86c28dbba
X-MS-TrafficTypeDiagnostic: DM5PR03MB2683:
X-Microsoft-Antispam-PRVS: <DM5PR03MB26839A8FE016A199B61360EFED080@DM5PR03MB2683.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5bRzPlYydQp3nO4aPZEo5OQ+AWi3VhbCGN6Vg/q4YTRl3r/ESVf1SpK8FJWJXZyKwR7wLH5cclNkQoK8rEkzWqn4W0oKfnFN5E6NP01/kf6Gcmi7V1w11kxAKcEQAWwAL+xI3pzUMk9Nyt2/0BCTWaSit/nxlcN3590rcLgc4q2ryigFh2gINdOnJ4jJEC6nHEgc641JhlHuq/uFiMkRRc1XDhaLOSuTZMhpwNlyvzq8il5xsrLPNq02SgxQRhxf8dV/bRSxBI32LUA1fEH/6zB4xmL+sQQ0WoQbba3rWMPjvTU726/onU6NyPiBal0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39850400004)(5660300002)(6666004)(956004)(8676002)(66946007)(7416002)(86362001)(83380400001)(4326008)(55016002)(8936002)(110136005)(2906002)(16526019)(316002)(186003)(6506007)(66556008)(478600001)(1076003)(52116002)(9686003)(66476007)(26005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HQXc41+YNqOqUMX+faj+F6aBuw0/y40UjBWThFu0cRm9eQ617v0uNmiF3LURA1zKQP8XaVHWmojYgkW6DFBRVsiIBfJIS1BNJ/qtARZnYH+wNYErHsyrlDVJFn8zoEsK595+Al8pP6djTbcuDQL2qEudXyLlVuraZqgfMoEcwdF7gAtFRXvLWNNrQefHsxFW0jpJYBfxi+0b2Bd4oZzz3ZDnS+SYM7T74UvdKKLJRMAybwDsG6mIUe+tXcdp25grTJeWXsuHagZvsFIiBJIyU317eweWsBk78YBLA7qYGNsTxfRmHh0dBF6ISll7EMyxvlg8Dyp7HgKZr/xlsUBK3EF8p/Av9HnTDkF0eqKLMLF6AslzxjP1HuXCxIf2ESgiBmgFO6I5Kejode22zcy54637EPlNunTQMUOsJnv5/r7tgRE7s7W9Hcr+fH+z5wpT/j6JrbS18aYQDlzImDsvPyIQ04FIbPO2D+tl3zAcI7Drlpch1zaYyIX6Qudrf9UAT+ukCgL2dZmk5AFc25HGlTCa++IXdJJC3ln9JETZ49h/g0nGk2UERxCuhe15oa00HZ8LmqNxmDOWNNemifVPDPYfo4/Jh24k5Ii4rr2RqvtzFwq4Vlwt6ZPz47MZ6Tv1b7Ovg4ztHQjTYKc928Etiw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0631e0b-2b03-417a-b0b6-08d86c28dbba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:56:41.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPd2D2s7Nmq3EzmsS16rkEJ0x3wHdsLY+8pPdopNsuxrUs/gm15zGwU7wn7XIg8p1NBVFDqezvk521xOo/swIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2683
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
disabled, another to use an address in the driver data for MSI address,
to fix the MSI page leakage during suspend/resume.

Since v6:
  - Keep the IS_ENABLED(CONFIG_PCI_MSI) check in dw_pcie_msi_init().

Since v5:
  - rebase on pci/dwc branch
  - add Acked-by tag

Since v4:
  - fix pci-dra7xx.c

Since v3:
  - add Acked-by tag
  - change patch2 commit msg to make it clear
  - map the MSI msg with dma_map_single_attrs() for some platforms
    which either has separate addrs for dma and phy or has mem access
    limitation for the PCIe.

Since v2:
  - add Acked-by tag
  - use an address in the driver data for MSI address. Thank Ard and Rob
    for pointing out this correct direction.
  - Since the MSI page has gone, the leak issue doesn't exist anymore,
    remove unnecessary patches.
  - Remove dw_pcie_free_msi rename and the last patch. They could be
    targeted to next. So will send out patches in a separate series.

Since v1:
  - add proper error handling patches.
  - solve the msi page leakage by moving dw_pcie_msi_init() from each
    users to designware host

Jisheng Zhang (2):
  PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
  PCI: dwc: Fix MSI page leakage in suspend/resume

 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 35 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.28.0

