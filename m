Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE42BA8D4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgKTLSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 06:18:12 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:21366
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbgKTLSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 06:18:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEUtfzQZb25Pxf6XNS+Qtc+9/lajwOfB+Z6V45SOsXNMzmFJk1e4B/J7TxGE/BFCv0XOTG8Bd9MNsacQ4xjQpuL9/tNnpZCiBitZtcjNNEjDY9xUAxBnZFol4IitU+QoRreZk0qRg851zWPUAeyIJ4OZgHhQA8K0ELZqL8IhiDit/LChf9vWPcRNktzeE6UZ3KjagzvMwkM3COQFrGs6/e6qHCBjaEIJQUE7Eo4NkWmGGhMJgv5RxaGVJyMT5FIG1UsZDFxRUd2WSz8BIfHIBmLhM6EMgp1h5K+yDjg3tAf73vIAwJn37oGTZIrAXz9jLygosXK2aFNcQJhtwxi2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EXeMocXvusfYdKt1kOEej7xLoUdDbyBuqq8eSAGUfk=;
 b=ROczNvmWXq6GZg9PlAt4n/ZprmatspEyo/BUPSATl8Ru7nkE4tpgt6KEFfG/GsrykF9Eg7jhdTcqu5vtnxUv/JdxdFqMecooXS0X/IgP62N7TONhp3lbiKMmg8BwfCwHa0ROEKxP0UJblksmGenls9Zx9t9mQNNQzszEIFryfY5SwqeJq0YfGKG2VLpfsq6wt35sLBuhe4UtCITa53ZttZVaFznbvJUoeXNdmQU/3mMVrahB1rHSvj+C/sX3SiYqjqQFl1Ajsnh8mbxPfuVPpMsJCHCLFuseR+6Of5OhPRRi2V9fPr8Z/Z1bzTMauEvFHjUGS1jnSdL2eu1Kxbi7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EXeMocXvusfYdKt1kOEej7xLoUdDbyBuqq8eSAGUfk=;
 b=DeyfmG9uF0CHC6OjxnNeyrWnkhn550VCdbzBKn7YnkqhBvOAE4ti1CK86j/30yDGq86/1a9qnERxZUDiX//tqfldb5SEKSp9wi7OBDn/yEEBovZp26DQDauWMOC3Wu8k2718vEO6TG8Z86WRUu1akgGHtvwoqpexxL1+7AkOOlw=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN6PR03MB3808.namprd03.prod.outlook.com (2603:10b6:805:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 11:18:09 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 11:18:09 +0000
Date:   Fri, 20 Nov 2020 19:16:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next v2 0/2] PCI: dwc: remove useless dw_pcie_ops
Message-ID: <20201120191611.7b84a86b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 11:18:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2d1cb7-66c1-40bc-691f-08d88d45f5fa
X-MS-TrafficTypeDiagnostic: SN6PR03MB3808:
X-Microsoft-Antispam-PRVS: <SN6PR03MB38087598E7C374594C131F9CEDFF0@SN6PR03MB3808.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsMqM8PQA8nYtpkxYXxuq5CI/JxZTGVxfS7xyWFPzYD7iVn1BLrH2kCdVBD0Ki9OWS7GZz6nFwJt8LODtLmkoJZA963ao2oFMo2ZC16EGogMA4cuudjDVkpjNIFs+lSE5dmj4byL8Kt5g9O6xwf1A2EGxzk06tX5AK6q7HhuFwWcvLf8wFV3hH5xC1yahn8x5PMufDgk7rgfjzwhg35AkrdB2oNMV99MXAGp+0KwlMecEbhMAMiZFfwkYTP37b2ywTcFUKBOtZm1zbEpxULo+xN/SnPa6PcfOtF5T6cnDyR1RJrHXQ4iTKoCF7/wZvm7+KXIwJ5EvZWr3jg/DlGM4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(9686003)(66946007)(4744005)(8936002)(316002)(186003)(478600001)(4326008)(26005)(5660300002)(55016002)(16526019)(8676002)(2906002)(6666004)(6506007)(86362001)(83380400001)(66476007)(66556008)(52116002)(956004)(110136005)(7696005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0WQ1bRl0Ly4ev6woZys6kOBL59MpRpGCICgD8SrLHi6+YIRpm8tco7nH2lsO4EhlU1iQnsmlYKf74b7LlMShXCwWzx4viDUDCs83O3fH3jogwUHDJ9DRfatEPJO4ijZXLdHnDf8PqZwjm8iiWVQ7241pBFM2alLECsqYuwgMH/6y0Gvv4RjysEwzQC2QNfPgLraHETXt3VHOOUlbhzf+foDczJL92N9lUi1+aPl/0mWVsXlOrXvD9Ef13RXYoorNsR8PgmMCgEQb6TBbZ5EdeRAk3N3OraTHBCyZ1osukCNgw0i4H9j7AWvhze/CBnBT77511ebiIacWzVtbZd4BizaJsBFbPfvr4PYK/OSUxxm2AZmw+NA6MKnXFMuF9K0jkgSCCUEeqtyzPRgRnzJ/MPjlLLizG8A/hxxE37yVE6z8OAF3YG1E4gi66iDi/YaexdwerrVqTJSq+dOpokqmWEH0UEEDkUsK0Nreith6GZKzTczxbz4nFBRzLcxCmRbq4DZR3PyaK+vZzEuHEQgbeQVpdfHOQp2SwdRwseD19SetT6XK2C30URXdJ67ksGeTDdnCwd+CBJ1P4iCNxsufiBk1s3kWVmGj9rLOfe6+WnSHsTXNodmKSRLWnbKMvn2wNlWM1gWRQC87BE6nplXqug==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2d1cb7-66c1-40bc-691f-08d88d45f5fa
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 11:18:09.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdfZKJB1I7fcEn3bNncvrn+QDB9IhARCUgSeQQh4xWiO7FuTGOsgECHzhJNJ9dBLuldWx5D3Nel7gEQv5OOy8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3808
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Since v1:
  - rebase to the latest dwc-next

Jisheng Zhang (2):
  PCI: dwc: Don't assume the ops in dw_pcie always exists
  PCI: dwc: al: Remove useless dw_pcie_ops

 drivers/pci/controller/dwc/pcie-al.c              |  4 ----
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
 4 files changed, 11 insertions(+), 17 deletions(-)

-- 
2.29.2

