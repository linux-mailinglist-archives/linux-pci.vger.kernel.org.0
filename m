Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6744FE7B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhKOF5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 00:57:22 -0500
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:61729
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229915AbhKOF5U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 00:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4R72tv2uAL78D00o9d90im+PRzRr8csUhiVu1BfuAyK9PLGhFDRs8xbF+7SbijeDreQyZBMVvF+TTWJtFVRehn0oCdbfmH2TVmnyXDTfDnE8kQlrJZRps5ZhVoHDcddHA9fwYXwRyc19ncqhEAnL6oVS/jc81PInb6IjWyLxRIg/TT2Ug+lFbAsECULciV6JQT4Q4tisMm4mu/DzRpP/diiOlJHPqQxvwPrYgdZrYOU2oDBqCdjlRx0gKBSQUMVl6oIQ+HHcN8U//Hd+QjUnQq79JEQ8wi4ujo7XZ6L3SaonxpXowluI8zYOZbZeXgRZ+Jzjb9OrCWYHFu7qRc1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2ljAByOm5fPSJ9HPdBYq65RMjCGd28IU1hvYzcF6ig=;
 b=O5kcn8nGER7VhQpYHTohR7AlmdplnhoAQMYsPlcaHG/ENIDI4yZj2l9p0ojkI9kBENxBgviX8NWqi1ftCYAjP4ilsS5/qX/MPYlCiOZY1MvLsXDq1qVnteHVXm1nsPKyQLKv82rYHsCYqVD5/mJEHzP/8uJ41UcHplsau/fDBelUxOkJUIzC9ujq37MsFR8QRtFmE08lx9d9DkHfcVf2S9SYu9yXsvq3MCotfIXznqb8gxB+uBlYg5Bp3MtMvrwFL6WA0yqpSWCdEmuJDrgrKAicJIkRJPdGlpfOrXLyqX9DYvHX9Ze6T1U3KKVoAuKRmguEfrnt70O14NnafsPWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2ljAByOm5fPSJ9HPdBYq65RMjCGd28IU1hvYzcF6ig=;
 b=qqhzA+DLIgHX4clk7wXyZv8FLfzXexyowejsn3pL4xCSmA5WxSlafyLYq1SLXuLw+sFDJddAGA/1gamOdMoAXG8r+cQcpYXbUNbTOh8AnNW+OAHk8tP2HpYVOkipqXQ5bkhcKcMtYm4T0SlcuwN2D0bhhEgwU9Hke+aeJbeCNjshH53d40pgkhIlwW8KwWSJz/58u8hPsb6pvMWuj2LDS13CNNYM3RJqrgXYRyV2LMLTtRDeDDrPo5ALEdHH7EMO7y/3YzUqkRJx/Aa//Fq3CHLz2Hy17hU0Sh7o/1DdE+ndGEvhaPzjldFyVtDk4Yaxpwc84wVRtFjWy/D8H325Yw==
Received: from DM5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:3:7b::18) by
 BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Mon, 15 Nov 2021 05:54:23 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::eb) by DM5PR13CA0032.outlook.office365.com
 (2603:10b6:3:7b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.14 via Frontend
 Transport; Mon, 15 Nov 2021 05:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 05:54:22 +0000
Received: from [10.25.99.100] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 05:54:19 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
Subject: Query about secondary_bu_reset implementation
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <okaya@codeaurora.org>, <hch@lst.de>
CC:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>
Message-ID: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
Date:   Mon, 15 Nov 2021 11:24:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95819d04-0694-42dc-be63-08d9a7fc5fcc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3031B50F8485DBC6553C1CB9B8989@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oemTQ3m+dUQw7rzpMuQdAb+icymyzH+LO5HPRvtUKIi2TF4HHLK56h+GHuzO2OpVg6OU07S02hMiAVwC/wkKY+qgt32RGjwU8lH7Zhx0LGTR7r/pQoNCn2wVQkGeIV4B8BF7OyEIFt/x8BVI+VHdMftRNg7z5kHBxnMp2cOfLmgI+Fyxtc66323Q2YmdlWVZUBjldFYPLVdt1td+KaPzNL0BnLtmTyE+5A6tqv/gLkNen7xv5EONhuuvMf8FPDpzZJ9m76E2Vnmxs/RhrR0xs8b2F2wy+MaG6Oz8ISEtnR8bS1BU3cWd3L/T5Bi9Ep801eogUInJ74x+bE+NtLgfkalzCsaScZ+TEAglw9/9L3Fwirwne5bKj+WnMK14XAw3psf/8djtgPN3Fy5JST3Ar0vCo46nmDL0OevcCtno7gOXEI5FcKfKEz5B3bBShGLaaYNm+JH0VtSfs+JkFxWXmK+qfFv4ixlmkGaw9jCNY7iP5vyCc7FJxLEqXKoxFTdf7ycunVGIv92zaFNq55bfurWjXufWuhuBqcqyont4xFf/RYf53IDvZ5SBxzDwrzkKz00afUzSkC4X1Su/NC+uRTUnjuUznS96mDjsKIKJvLWOOw0RaRrr43LAaH6tW2835yQUqKLipV4fQpCYLzeNhPvXkHfVr0mr+gjhyvMRHv0iQvI3pENCF0lq+QKPu1lihN15msWUuO27aUK2k58SiAOX2rtDUzAU/zm3vrEei+w=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(16576012)(4326008)(8936002)(316002)(6666004)(186003)(356005)(5660300002)(26005)(110136005)(82310400003)(31696002)(508600001)(83380400001)(36860700001)(16526019)(31686004)(54906003)(7636003)(2616005)(426003)(47076005)(70206006)(70586007)(2906002)(8676002)(36756003)(336012)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 05:54:22.9447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95819d04-0694-42dc-be63-08d9a7fc5fcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,
Regarding the below commit that added pci_dev_wait() API to wait for the 
device (supposed to be a downstream device.. i.e. and endpoint) get 
ready, I'm wondering, given the 'dev' pointer here points to an upstream 
device (i.e. a root port) because the same is passed to 
pcibios_reset_secondary_bus() API, how is passing a root port's dev 
pointer to pci_dev_wait() is going to serve the purpose?
My understanding is that it would always get the response immediately as 
the reset is applied to the endpoint here (through secondary bus reset) 
and not to the root port, right? or am I missing something here?


commit 6b2f1351af567110cec80d7c067314c633a14f50
Author: Sinan Kaya <okaya@codeaurora.org>
Date:   Tue Feb 27 14:14:12 2018 -0600

     PCI: Wait for device to become ready after secondary bus reset

     Setting Secondary Bus Reset of a downstream port sends a hot reset. 
  PCIe
     r4.0, sec 2.3.1, Request Handling Rules, indicates that a device 
can return
     CRS Completion Status following such a reset.  Wait until the device
     becomes ready in that situation.

     Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
     Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
     Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dde40506ffe5..0b8e8ee84bbc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4233,7 +4233,7 @@ int pci_reset_bridge_secondary_bus(struct pci_dev 
*dev)
  {
         pcibios_reset_secondary_bus(dev);

-       return 0;
+       return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
  }
  EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);


Thanks,
Vidya Sagar
