Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690D3A10FA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhFIKZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 06:25:30 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:7937
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234964AbhFIKZ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 06:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5vC1QAp+T4Hz6LrRZbIkp6j5lObBTyMIr2fJcdkmwYKy0mN2mAFSkqc42mBoSumu/iVhH5ELk16peg1m55I2qE3Gm51+XoDNANThiwyE9cNRAMvt4N9GaOfoQRWkJjjlvN+3S8WEjACRV2TQV+RDnQT+3lWjXkj9El8Bo8JtU4WcqW1ciZJZGqwafEDkhaXg0RHKfxm7D2C9AxLzaBb5zVSKzhYvjpFM7WxvKoyPSYpbixnq2Un0gIir97S+6KWwkSFdYokZrVCYNdJ/jGn0q8gMSS3Ap7hbHj2hMd4wsZZaFZq7aDuuk1rETdgHYf/kFnPgZPJTd7t3JnUWfO5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNgZ0CXdfo0MshCt9FKYslCMJRNjhTPIqH/DlnFVqto=;
 b=CIvIasj8ukvqwZpx+S6xPEz1ZN8OBxjqWdOKDJl2nl2ERtYouGTDb35/C3tI/rjAHkxjDa8KS9Tt3l+S9kDMTq+5hHhzNGP890pjrw5NZykuVZE5gS2a8+yQEg9W0uqLvToyv+Rq//mE7Zvu+JzmmYmq/v8C1vntgsSAmpk9Qykxtgjn6uXmNNlH0vfUMFyUh/K5v45uVQvUegMZrdGwJYlAeiRB5NOxaOJDHME8T3Uw90bQpWzwDVTGjSU1awqsc9R6WPnrl3XhCc6fcx/jmCatU0gtIHeydPA8C+ecTYrcFEuC8VI8v6oB4R2RxFY+p97ZktIOAC07HQxE8xhKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNgZ0CXdfo0MshCt9FKYslCMJRNjhTPIqH/DlnFVqto=;
 b=Hprx8TUR1pR2tj+FsPbz2/oLTDy0+0eKYNy8/tygAqgEQ/t5rmkoc9dReieY6BgHTpaG/9Fv95OQP9pAfoI3uxfaxEhhVQfiOlEspFy8Kd9oHTH5oI4XoZ1oBIiE9Zfc/4CeSvJvGCQ8Ss0FthKdOn0rxJcKlTAftbVkWEfaepO01e3AfKDwJTedowhtOU73ZvX8gRXmNFFi4/fgLf+fVSm3CtDSBN1Yhp7dr5DmvAeXAVx0DvhiE2wlz+VXwMZwfCqI/wM5oyPUBcnmhOwdNn5DMpyT9SRb6jdL43PF6S8JzA/V/I4S6XUWM208Ojhg7ipzdlC+V5joEAggHZg/gA==
Received: from MW2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:907:1::16)
 by BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 9 Jun
 2021 10:23:32 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c6) by MW2PR16CA0039.outlook.office365.com
 (2603:10b6:907:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 10:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 10:23:31 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 10:23:29 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608130207.GA2597738@bjorn-Precision-5520>
 <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
 <9b027609-a2c3-3df0-5e65-1f282f03cc5d@nvidia.com>
 <303946c4-29a1-4f5b-6a4c-be451ece20fe@nvidia.com>
Message-ID: <a80788e4-b0a9-b8d9-46d0-873b5cc6035b@nvidia.com>
Date:   Wed, 9 Jun 2021 11:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <303946c4-29a1-4f5b-6a4c-be451ece20fe@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ebf4cd0-faf0-434e-a42d-08d92b30a192
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-Microsoft-Antispam-PRVS: <BN8PR12MB294744D9D4A448634F033995D9369@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twTaFTMtPyr9iqmazbE3oqLofSdvj+pElNhuZ9XminYoT0q4JDBbk1XhGsS3WAXk1hr/W3g7we3+GdWxZWtMoA8XVaQmNHbel1DVUvePr5JpxZ/ZQZE1Cd7RhY4LI15Qe2zszofG/Lag5cFyvbzhhTezyqYuDkMUQbNPIDw3LtEXb0d/s+lTNEY3M8v54hp9A4Ru4pkSehRKSO2DKp9qAp6K0jiXdObAE9NnfGuFSnN31X/D8zPDHyWrAty6FxAx3GAVzwJUT1+GBcOndWMOrxhJs0EaWs39dtP+6n8/ss30HcjHfagyIzaLfib/hOib5V31zRor0Hyw4wu+mpQ4ekOMH5rzgMrx1S1f93Nxn0bOb0cqqRnHLvbeHFp4qBU7ZH/kx1c5tx5gL1y7RIyO4RATCeQKop9pg6uCt7HTEVG/blZSoYVBAWcwyNjhAh7hh/5xcPJ9qUaK8u3IFk49f5wxjQst05kQBBkpQp1Faj1MzOWpiq/4qHuELUOF5Wlhm/0Knf93/G6hMbPByshdqmQTDhUO4TptWvHK56hmIz/aRpNzQ/UqgqVxEZ5M7HSgmR6P4axjk5NLRAm+Lmiu5GicigjInmFOh3MPOkkvdG96L2GjH6ofBjioQhPaWoxBWvCBp+CHUT8Etzn6bUeslBUO0dQ5l5uAEI776YyNlGilBUDWpIUG1el2OFEqnDVU
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(46966006)(36840700001)(70586007)(31686004)(82310400003)(4744005)(2906002)(36906005)(86362001)(54906003)(316002)(16576012)(110136005)(8936002)(53546011)(47076005)(8676002)(36756003)(4326008)(70206006)(83380400001)(7636003)(336012)(478600001)(26005)(82740400003)(356005)(36860700001)(31696002)(426003)(2616005)(5660300002)(186003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 10:23:31.7783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebf4cd0-faf0-434e-a42d-08d92b30a192
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 08/06/2021 21:11, Jon Hunter wrote:

...

> Furthermore, I wonder if we should just move the code
> that is required for ACPI into it's own file like
> drivers/pci/controller/dwc/pcie-tegra194-acpi.c?

I have been doing some testing and the above works fine. IMO moving the
ACPI specific code to its own file is a lot cleaner and simplifies the
Makefile and Kconfig. Especially seeing as the ACPI quirk code is
independent of the actual Tegra194 PCIe driver. Therefore, unless you
have any objections I will send a patch to fix this by doing just that
tomorrow. Also let me know if you have any concerns about the file name
or location drivers/pci/controller/dwc/pcie-tegra194-acpi.c.

That will at least fix the issue with v5.13. If we do that, then for
v5.14 I will clean-up the Kconfig and place everything under a single
CONFIG_PCIE_TEGRA194 entry (which I can send out once the initial
problem is fixed). And finally I will remove the unnecessary cast in the
probe function.

Jon

-- 
nvpublic
