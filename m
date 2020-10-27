Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5307D29A5A1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507900AbgJ0Hkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:40:35 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:13728
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507899AbgJ0Hkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F73n1QZ2FO1UCMk8925y2AmCcrHYcMADVaYxRINyP/BgFBEan0Scee8CO/fjj7uT8J20bruyIQntHnMngTEaJ4LkQlWTuOIkTcol88Ilygtmzu1he7LIMkrYJ1WKx7Si4IGfSE/NqZc6BiRxPyrpkwV6/6xw4EDlZ0wR4TqcB7d13HTcLcsZsGIGvC9OWmf2QNPkGlRximWUx0Os0vNOvF1670o7kIvOEx3azp/Ty4VsrMvWpfw29hcUn5u43Piq/hrpHOaonugrxLZC0+CXc9dMGtya4Kkb6u5nqEcBae5ompltFVnOx5V3glyifr56XLtr1zB4P40mL507BC/HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUB+9OuLCsnBgZUia66ih8NR0hfvkDzhENEJNUsxKGc=;
 b=fVvfQ2+8VqaLGf4AYHrUYT/M2AGpytzvz72rN/UsEQFl+Waiw6acTb+uQsRGKrZio5lZe1DzcbsmHg0HF74Hve38fdW0xGY4fvGE3X9WlLzaTaXm1nhtK/cUTbQfpRtmsLiqX/eofR54w9FtVML42a5TPD9icinmC4gvhfxiEplZRAhFAvGVokBucF6xTjdVnw5z58nHaoMU0YMu7uVMqKC80wUsi/mJgrHW7FCphkn4Jzicn47UuO4dgb04+2V2jjCmXFsUIL2JtFYYMDpW6Ccoob8L52B0Hn2D7IyvQ0Cav0les0hf+N3nCY0XFC1NWbuSx1evtlvvwnDmUrfiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUB+9OuLCsnBgZUia66ih8NR0hfvkDzhENEJNUsxKGc=;
 b=KothzSq5xPBlkOz4cJQmis+VS0HcPfDomYGGSvcqkpmLEf/rK8mLkdWfojfRichdW6AZPw0ov2kq3gNxmAmz9DbsfIf0OV5z3u/9bzL46u9iaJJrYmZTsnlt7A6ufAHU+lH4Ut1k9/bNGqgM8onfjVVxH2M71oXXx0F3fNg8jgM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:39:33 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:39:30 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 0/7] PCI: layerscape: Add power management support
Date:   Tue, 27 Oct 2020 15:29:54 +0800
Message-Id: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e08a333-f5e2-4301-35e0-08d87a4b7025
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33715DAF93F890518ABDA60684160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: togN5Q44q686fWgz+uWJlmRXvZ3JVrLNdzhbSx68rQyEJpLsEW81fxiyYCDn7QJFOa9FHOEQecfFFQRM6V+hfXywdI3YdAC0B4PU5y30MEs/FIdLFqIKdsfLC7qvcGjQdqyWBs6SBoLHP2+wqF4CykjQp9nwmSHiwKLi70ESY3+tcqcALOh29rRl6W62O0rt6mHrIKdcgCyjfwte7RcHut0/mLhIEsHZDDIt3aqV4l7E6QktYIesr96ktBIsmRGiuvHVAk11QSdkaolDalF5Haqs89BOD3e/Aaf1IhzvSXbphJHzkSL7n4Gn+LwiK0v1igT7iLpySbByQ4V+4KfUW/hJcEeV7RjDCoDmvncT04D485zXh0juzw7nCGI4b+70SIcdWfcoWmv+s97kKtyRRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(1076003)(8676002)(5660300002)(86362001)(2906002)(186003)(8936002)(6666004)(4326008)(16526019)(6506007)(26005)(316002)(52116002)(2616005)(36756003)(956004)(69590400008)(6486002)(6512007)(478600001)(83380400001)(66556008)(66476007)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7GP3Fe/S30ORDLgRzMnVcKiXoe0aBA5FUPMKTqbA03rYcxQ9VbpqRwVR34jcVnnMMqxRbTlMWimBnraGd6xZKaAXFCh8yZKqNOVrUo86Zdw4OXs5aUEgN1VWz5U0/FMJW7IDvqHXJQ9LTHaQZAr4xYBru0+O57YnefKkAwZdw7kqAEHSbCqz62NdnitPccFMNiVdf6VGqLVUktPz33k13tyg45weSKAepPkVYDvi1himLQk801O7H68fnOCfMQNm7VX0mexVCYcP2Jpo8AOkQxAD8gA0hzfsi78lNxG5On6cM+udcumn+yK0O4+09BWIx7TQhOovVLzwJKCFjDgJEkYFuRP/L6IN6pOZnUG/6WcInlvxnaJqF37hlUuFEi1Rd8smhx9EKWnRmF+C80caVHQlZnXZj6xUA7aiJbnTFOMn/4b7jOyEcpKwAwokdVZsNEsJOKznvIMIgTjynSLByZe3GtWnxcDDuavTmMtzLXK88bTbGChEHDhUSi0ERTM1Lc4fQNUTYGdLuXYWNShMW6miJ3ZlHKmKI+p7+rT0c4vNEjAjEHbTedzqqCdpuf3dDIg099Iwu1LUU6I5lrQ2UTVfZ3byAcQsRrvxNK3ftWXYfRaLbNZGQ8TyF0pNhVMeT2Ag0PvXEW4fLPnjDOGhGQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e08a333-f5e2-4301-35e0-08d87a4b7025
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:29.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7mLmjlSQ41/lcmgb1NSrY+WeL31b5qqTcg8vllfH+eDefzTfhwrFnn1OE8wWsyjwuzMdoKe3PKmM9Dgx0bIXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch series is to add PCIe power management support for NXP
Layerscape platfroms.

Hou Zhiqiang (7):
  PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
  PCI: layerscape: Change to use the DWC common link-up check function
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  arm64: dts: layerscape: Add big-endian property for PCIe nodes
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property
  dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
  PCI: layerscape: Add power management support

 .../bindings/pci/layerscape-pci.txt           |   6 +-
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
 drivers/pci/controller/dwc/pci-layerscape.c   | 469 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  14 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 7 files changed, 385 insertions(+), 115 deletions(-)

-- 
2.17.1

