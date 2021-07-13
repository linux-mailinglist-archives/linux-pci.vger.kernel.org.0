Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151E13C67AD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 02:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhGMAyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 20:54:36 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:42368
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233545AbhGMAyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 20:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcO6HJHW18tWUYKzH3ubqRP3ShM16l+ewKNI6iYECnOyRkt97zBTEWGIk6E1eeTvDiBVTL2MBmfForyggWzf7PFawULEqujdYGhGY0W4y8wbJ9rOcOoR1EQR9p8xhIEDXFiZxVB8RoclsBWfcgdGp4a3iKTxnj8aXnSovXQAw1M9AgBcYn8B034T1u+VfsdeeKwKY7N7FY0iwcx3cZMTvR3M3bSdX/VELrMv0L0KfYI5xJ/KC80XwmIj2lQ6YG6AnZUT6qbgE9Pcb48nfZo7lbTYwLAimjs3LxaPSCXX26psj5j8tQYM2/djwyfJTaK5uIFzTtF/ST2nyBG4vyT4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ATnBftd5xJK6qDNpJi1tSPdBmaqt+BWYsW2ArY8F98=;
 b=WjXqy6xYXfb4bHX0G2e01JSafwFTB3BTiEQtWhiu+YlgypQVKkDQiF566LAK2LeSJ7shGjT0LaOVRWO1g+GLrTqlGwhdYAjg7+6bboTbEX5S92g4ShgpDLspTIb3ticuseMk701tDiqAYEP3YLiATcKvoUMlZ5pASEX0/efdwc+YYioLUpqiMl2kVjw+xr39Jku7g8nx8APzunJY2A5Md2d6qPKfKAUfkGGZzvfUb8WrnweJ2/iQKB8Ar19sLvvG2vhz44b/VOvltZrvUhe+dgzTKN7iDS0kXIDMwGI4uTastmDF9ySNM/ndo2EV6ylyo7gx6CWYvDAkn0Z2dTTNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ATnBftd5xJK6qDNpJi1tSPdBmaqt+BWYsW2ArY8F98=;
 b=BBQzgqCQIJrpqDagyCSxdzsiZjx/7f3blcERRRd/KeUVZ392CGGnc+MnLANEE8OlTGf68yRayjcYQs/MVoZV0GT+MuppPA5UMissu4GUvMVefNNG3V7R9+WrUafvKWhBiWv6McV/5j0YiimcDfMKpHaLTpTuGH97BD7O5enwU1US2b9BBg2CH2RSzKaOUi48VzGmfx9Gbad9x0JsOJlYO0zW+N0heyOwg69Mqqu6ImwJlQXPyoaYkbSbmuesoUnzTK6fejeNoRYOl6SpwpbeRUxlJN8CI4XO6E8tXLEsVTCP7NBNApMJUeS9pqRaCQn3nA2mmwdHzAoHwit6bJxtwg==
Received: from MWHPR19CA0013.namprd19.prod.outlook.com (2603:10b6:300:d4::23)
 by BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 00:51:45 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::ce) by MWHPR19CA0013.outlook.office365.com
 (2603:10b6:300:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 00:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 00:51:44 +0000
Received: from [10.20.23.82] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Jul
 2021 00:51:43 +0000
Subject: Re: [PATCH v10 7/8] PCI: Add support for ACPI _RST reset method
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
 <20210709123813.8700-8-ameynarkhede03@gmail.com>
 <20210712170920.2a0868ac.alex.williamson@redhat.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <e8f0b236-dfb3-c9cf-4683-c43e8bc0c0b4@nvidia.com>
Date:   Mon, 12 Jul 2021 19:51:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210712170920.2a0868ac.alex.williamson@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3f6b56-5883-42b0-0a0a-08d945986320
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4742A3081B84A156E6B6D53EC7149@BYAPR12MB4742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRbEJaYpYjZg3Zcuh7F9ndAGz5JY5VVa6zCpt0YhO9IfkAApOjj3cb9eoT+mjpTSvKkJAFoCNx+7a7vGPF5D68SBYPfovuV8+suYym+QdrrHm9WHkL5nbZjHQt+fxD6gRpkuphGt0C7Ks0APL8GDvV6Qgc2kswYjafb8QY9K3XQBoJbPLk2wmhM3EB+gPttowo9ka24WuE6muolgq1PRiOX1/BjxEE1LCSJNZc7uAWPLhzbmBjLgUwUJLk/EOuLTLIZVB2v2OMDGIjrn81/gE/Rae1gkiNr11IzbIccOdyEoCvHbFcS+u5F4Yah8d2Rm+hSQwwx4cP/B+MUo5ByUPTbna27G7vjEDv4c7G+OSOqo4h0VO2FocpRsijZ9reEVC83ne/hq4PtWITMquhavyj7VuCEhRvDMWTYq0xbq68+9cRSrtrIMgnBYmXrS0Ao8chxbhhK95YK6Lm8Mi0RYePAuvkxsZV7XvObTBBSDRnbvtrb0YlgsB8+sZtgXpH7behAUSrJhgD1W5dwQ23mdgRK/CNB9hcwcmPTLdTLjNbqBBqBKeBCP7hsqp8yLZcx9YGR9dFnbFZBCCzYxt1EdACxGwYgCmcbAD9QocvgrtbOm4vkr8199TmgCAaZIiFJ0QfOpLI4LZHXem/0wD91nGGqNnBGGwWdm068qz96OJGNb4vKGyjDhpfMV+wwiK+CRYydYojCdK5AfEVy/xonMEvnnkiZIJCt2rGwAj0dnqTL67JwziY6f4579zZfWfHHZVII9XfJQP5/yLMtUTlYw7w==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(396003)(136003)(46966006)(36840700001)(83380400001)(7636003)(53546011)(6916009)(16526019)(356005)(31686004)(36860700001)(2906002)(4326008)(2616005)(296002)(54906003)(426003)(70586007)(186003)(8936002)(316002)(478600001)(5660300002)(336012)(36756003)(36906005)(70206006)(26005)(7416002)(82310400003)(34020700004)(16576012)(31696002)(47076005)(86362001)(8676002)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 00:51:44.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3f6b56-5883-42b0-0a0a-08d945986320
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4742
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

On 7/12/21 6:09 PM, Alex Williamson wrote:
>> +/**
>> + * pci_dev_acpi_reset - do a function level reset using _RST method
>> + * @dev: device to reset
>> + * @probe: check if _RST method is included in the acpi_device context.
>> + */
>> +int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
>> +{
>> +     acpi_handle handle = ACPI_HANDLE(&dev->dev);
>> +
>> +     if (!handle || !acpi_has_method(handle, "_RST"))
>> +             return -ENOTTY;
>> +
>> +     if (probe)
>> +             return 0;
>> +
>> +     if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
>> +             pci_warn(dev, "ACPI _RST failed\n");
>> +             return -EINVAL;
> Should we return -ENOTTY here instead to give a possible secondary
> reset method a chance?  Thanks,
Thanks for reviewing patches.

ACPI/AML _RST method type is VOID. The only possibility of failure would be
either system is running out of memory or bugs in ACPICA. There is no strong
reason not to return -NOTTY.

I'll fix in the next version. Is there opportunity to include reset feature in v5.14-rc2?

Can I add your reviewed-by since no other comments to this patch?

-Shanker



