Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8D2782EE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIYIjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:39:39 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:53760
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbgIYIjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 04:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9JoB8AE20SNpLsRryyjAY1ssDV65SHxbpR0EzSuaV29IrZKNgqLh5lMD2mqTptuGLOJnfZNl24zJtnGPCM0tNz5kO144l2wcHPamliLyCkcPfcxBWo7+k3YStYy3xcQDXfLSSP+3eaPb3TrpVvdDwgH8L0FK+cJF5BvpWGM23BB4KIgS49166o1wFHSnRkiLjAv/0Iy5b1UHTwvABew8DsVbhtvI+o9jqPXGWJcocXvWbXw6vxaKltSFZMl76+UKK7GjZK/HeHoXhv8pMQmNecxLIIhXyixPLnHKCsVHZzdRMtDSV9w33Ir81oUpvfzrF4su6tvOmbu/f0fjr2aMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRS8+AnwQMnDRxpQgH7h6prfzI/vFwqRz8AdrNj3+w4=;
 b=YxrD6fy+qsreZD8ax/NCe9GkFSmFftNUbvmW9gdjXNtCHXc7Z/NGqN2gt1Rku9X7y9k6/E2ZhadtwzrDU871KqBhwEbacJXBpQAwwmkpBpKFtZbzyQW+tVZmILT5jEnipftc7E7Z2kj/W4FYygqK8SqLEfpRBRZ0fCBq8aYdxGEjR2M9WVi96YPtCxQRMgIaS/Q6yAWvE/TMTZklkTJgIshD24gILjiaar5fBZ+jaBSBCWMEQLL1lvBUP8Gf/DwmfyUq8liNHJ1TF/HKftuB4GtB5t8ayGCgIaUyV6B5O2/AqyitYge1ps9jk2sV6AOWDzmGkKDALTKvWWhSEec68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRS8+AnwQMnDRxpQgH7h6prfzI/vFwqRz8AdrNj3+w4=;
 b=jt0tOYqWR6Amt0oBVFLRgA2sv/4GzwcGHPG6g+qL0NNy0ORoDSoIbfvdJ7gMnKdYePGbvXQHsJNr34Me+R+TqUYcjL90jTawjTxz6BxVoNE+xT0B3tekLcFu61jV2iERu1G0XE0KKb18mVOtNRBnOnHbB1oeGDpp2SO8j4FjH0U=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4697.namprd03.prod.outlook.com (2603:10b6:5:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Fri, 25 Sep
 2020 08:39:34 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.028; Fri, 25 Sep 2020
 08:39:34 +0000
Date:   Fri, 25 Sep 2020 16:34:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20200925163435.680b8e08@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::31) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0019.apcprd01.prod.exchangelabs.com (2603:1096:404:92::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 08:39:31 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d249cf0c-4e61-4f6f-ed69-08d8612e8711
X-MS-TrafficTypeDiagnostic: DM6PR03MB4697:
X-Microsoft-Antispam-PRVS: <DM6PR03MB46977CBCFD5E7391CA48995EED360@DM6PR03MB4697.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Kemh+7ylM9Axe/Nj6LaUQUhnZkJbKbeBXn60bYuKHiohjKIqjwax9vVNK9PtuZXzSaxqOpkD6bY6MljfKzpBrrtzOeAC10vGnXe658fwlfGqZwW3TtF0iv5TDD7HOqX+/b+ZErjRsXeatc59O8b3HCrxfd1B4lbcOx9+eHUT/p/LZyVcMFBLzUh4OzcQQtao3gvTe449SIdN1B/ZigGMfk8OqJJVlQtLGr8xzkXVh4WFiJv0Q0fvjOBF3h1FHRW+tVxkMT4jrPUR/UzV6t2ZvA6suKZQjTziWnkSKn9QNIYwHK0qhOwlWxQNUqAmbKWL/QB5Yw34uuvz9f9WwKFvG4ZnEFQRbIV4rSCnkLWlJ7WwMRaBd/fYd67NTuUL07z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(6506007)(52116002)(110136005)(4326008)(478600001)(7696005)(83380400001)(26005)(66476007)(66946007)(8676002)(1076003)(956004)(316002)(9686003)(86362001)(8936002)(66556008)(5660300002)(16526019)(2906002)(186003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VTCqp1XBWJqLbFTuTE45XiQukE/CWQUhtDxY1idneR0La/DyUxqyKY3ZSExyf66zCnNWwTnJo2Bht/fd5v83zdaQUuN/SUTqGfhA3w21nqAcZQvRVMSm36pJnqy3PBnhsGVABP7sdCm7bwYzD2GZMMMG0ufNcsmIhDHsMP1n11pt8WQiI3gZTQjOIoBhu7K+ZayaBQ6/wGXlCmEYQntn9bcBn8+ztr8PN+G34wZW4GWY7Wu/x5Vfh/5/Ngb9wH2xx4vwkk+Nc2r7ct1Ec8FTZDQpzbBtgo0K6L7fwW1Dh0e+6jL8YUwhz9+FjAqkWHN/Qbu3Snds2mpOoeuYpfWb3hx01fBIHVrMwb7YKY1iOpmr+4mqTc+BJfN65vm49mQLU1LrCP/z4B9ZJBOHKCQjvCwI3iJlyZ2PZn3qCpip3Yp5bMW653MoqHKwSZBhCpxaIjyQNGnEnnnpi8+a9PX5wueJ7j8WB9pnyWa/NXxXGXIZBV38nDrf0i4wEhcI59rHYDyT9UebPcDTtaVMEpyb724A1SZk0ElYPr/tW1W+uANSBzhJAwluE1bV9lfMEmNjTp52QJcWu1o+U+IONjnSZ1/kzE4RL8Ef5XTxw8jyTI18Ms5JLxHVlsjOxUZD/UTKtYlJbxqtLPlxNjwaPpeyDQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d249cf0c-4e61-4f6f-ed69-08d8612e8711
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:39:33.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQCH0Ophdy3rHEDjqPvMpammP+P9ebWSXUxGHQUE3QtgsVPDSE7GBFky/347Sh+uqmy0DDI5cxG2ejYLiao/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4697
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming is MSI is
disabled, another to use an address in the driver data for MSI address,
the side effect of this patch is fixing the MSI page leakage during
suspend/resume.

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
  PCI: dwc: Use an address in the driver data for MSI address

 .../pci/controller/dwc/pcie-designware-host.c | 24 +++----------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 3 insertions(+), 22 deletions(-)

-- 
2.28.0

