Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2A3A14EB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFIMxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 08:53:32 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:22568
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231193AbhFIMxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 08:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odIyGJESRvkwAv+EmhBe7VFDqfiVhi5F+ybccBLpgBLcS8LUcT2fTsAlJZcMhGUgt4kXNV/PHSbl1tiCTGwFWBnxV/+ZxcuBELjcS7oc0au7i6wxEdJLq+bHrzEnLDNr53MNmEvKtny/x4faRoEYMRM7TLp7IIc8oBbrye4LSrO2yQXoEIVE/K8SdcBgj+uGQl9elR8y5QCO2GFoMi4HN81/8sY4rTjpHW7JtwkRV4ZFPURYq8/cPQdRT8y2maMTOp/ivRgMOJPVI0a6G0nQjdAhoiE4tD6Ap3ST012+g0odrwnZWUs4IddX5r4rFUngu9jgyyR6NDJpC49eSPD/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4SShi7Re6p3evOqjdphuVwLj1nJOuW9qLJ4GbEy8Yg=;
 b=UJSHEbBYpuG5VZrUIgPC1I3zkdT6H1Y5nM+/ScLV3jCR0DGAVpLyFFR+Aj/YgaibogROcrYf0Zy329j3/6IaZNM/k2P5ts77jAnKwJjLXt2bmGD4aCgO+EtQkrHZTR3qLHp3nVgwpE872w8mK/MYkIivdI3QywW59pPXyLe/YotmV11cFVM5nOXUI6HR/bgFf/0M/nDAq6RPU1EeNUbjWEy9QkkHgQE9YMfkaL8nKgvyaX7gLKGUvOq0gpQ4XXLWJHtPGEtPE6Nd7xXR+CpMKb+3pcEGxeDYKW2AqCY1b0G+c446UvIF3PCNxtd8g5JMK/xfTAlEFW5vuZuGjfGn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4SShi7Re6p3evOqjdphuVwLj1nJOuW9qLJ4GbEy8Yg=;
 b=MPwASSHNuBbqnjZB5K5Z32pjxr1y7Ydzt6m0fU8d5XL2FzakAldi71LSu9GFi3X+Um9BYuSeHui9yMyQQP9yFiFuUoleqp4c4IcIYL6xz4H2Q+t0AKsNtoNBRsFozVx4YSXqRmE66wF1OBSIH2zt3FeUEynnGPSLjUmWrZTnfwg8lkaUdZ+8H6jIgqb/Ygb4/YycMDuXYCkBiMO/7UONSQ2s9QUxDmq90JBE/RoocGN3mSx4KbSuAhNsePVgkaJ6xIIrnACluxbC6Yop5V9WdkoFpbQNlF4NYedkR4GPfa1gpPus1DgCp9ygZqyMAzcJOPa5A0zDM4BIjrTpCS1wJw==
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 12:51:34 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::b3) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 12:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:51:34 +0000
Received: from [10.20.112.58] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 12:51:32 +0000
Subject: Re: [PATCH v5 5/7] PCI: Add support for a function level reset based
 on _RST method
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210605205317.GA2254430@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <8c736ee2-82ef-411a-ae4b-26b5b7e40610@nvidia.com>
Date:   Wed, 9 Jun 2021 07:51:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210605205317.GA2254430@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe641d61-a11b-498b-ca17-08d92b454fda
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3759F02DD721B57E87D99C24C7369@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/IUAA8IZNau7XhqpZTCxTRxrUs2ZUqoDBYz843PvhqK+6674NdUg3+VRLx5EfUtqhDMxke4swI3WWcf1l1O70e66RZjzy2nP4VeXEvPpdz2fEzdVYJJj/w1ZCW8u1Pi3WtwwgeTA6uYBnOIu9Y6bv93O2dk1eLPHpExIZoGjWr6j/G5UV/24vSVNJXvNaYnPn+lI/zHuIJqyAWwEdfECD4iskVn4awSv2xLgA3AeThmIIwh3Ea6P9lTqof7EMrt/pigxCgzI2b/rLbEiaj9aPI3OISciJDRP1VVDrGNpyett9qRcYvS4LorH4PsOk4+Ws2/KElLZLzxt2MpUC62RSbBhEGDM5OytytQPsVy7ydTXf/giz7u4cegMjb7AV0/XJztyXjjnser0HGRqeQ3NmptozB72f8FwtevwfmCo6RZnhe+a6/McrSaifjk5LCIfxM95lybnD9nIZ0gOxTLYtiwiJDTRRV6zRZcubh/OLH7+Sx5UUryYZXhluIMf4GIhgzsIIzCk8a38a/ypV2Uz8g2V2rm9iQFtW1OCiRpTejVWP/01SL4V7kgI13TDgVVv9RFN8JGDM9IR10kE0tQL/QmQ/4Xib0j/eYUSFhJdUGeWrpR85yYhnzn+pGveBiI4cpXUTTJQSlYbkBOzVGw7c24ywjYF/+KEhTcMTNVdPXNn4F4jC4ZP0DTcjh3WK3U
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(16576012)(316002)(36906005)(83380400001)(36860700001)(70586007)(110136005)(7416002)(16526019)(4326008)(186003)(7636003)(4744005)(54906003)(70206006)(2616005)(36756003)(426003)(47076005)(8676002)(8936002)(356005)(53546011)(82310400003)(31696002)(82740400003)(2906002)(26005)(31686004)(478600001)(86362001)(336012)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:51:34.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe641d61-a11b-498b-ca17-08d92b454fda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/5/21 3:53 PM, Bjorn Helgaas wrote:
> This is a little sketchy.  We shouldn't be doing device config stuff
> after device_add() because that's when it becomes available for
> drivers to bind to the device.  If we do anything with the device
> after that point, we may interfere with a driver.
>
> I think the problem is that we don't call acpi_bind_one() until
> device_add().  There's some hackery in pci-acpi.c to deal with a
> similar problem for something else -- see acpi_pci_bridge_d3().

Thanks for pointing to reference code. I've added a new patch for setting
ACPI_COMPANION before device_add(). Please review the updated patch
series v7 'Expose and manage PCI device reset' and provide feedback.

-Shanker

