Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB653C8510
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhGNNQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 09:16:56 -0400
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85]:2176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231587AbhGNNQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 09:16:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLgkuMz5QZf0STSIuvrILFKx/s9JMgNcFVwcc8egFS1IM0NE1aar9vaxNSEbcjdF3V92uxqbJ/MQYPsizinZke5nvI5j9vE9hRvVuiKlimqsivJnIPSQtxOPUcTyAAzryHFOIEX8NfC7hIPVZrzUgaUW4EOoRppeYnyt93xIWAs88vzB8anN5p3iO8X6tVGKWp4H183k4UYUExnbLqSeUrqsS7T1AS1pzhe5iNT1GtT0WjLL1hAIErduBoU7yccqcv1vVWM7EkMsAtMeIZp5ewKbKQ4KUX/i1sdM0Yf8rVz7EfGtNf4QtBqHgC9JpGdwEV0mlEfHCl/VWCX6IoE34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geh7wND1n385f7AAlChbGX/XWJ8u2NSB0aEjWUyfm0g=;
 b=CXRSJsszgdbyAzUpNLIbrfZd5tVgZ/wwlcZu1VPm9KUjiNcsdWytP2vTNFGkabQo4WvgPsOjsIaW2tvuBkpqiH4l+YW8F4GdxNSnZ+nUoHXm37Lx5H4o73LD66lWOGmuldDUyl6xtbwQJticXx8TzglJGy7/Z88vsofLtEeZYRlDA2zMHnoXiTF/RkdrT/KGRDYGnvuKcgaE66XLf3t0yIf2xoOY27A8Va3CEFlAy+7mlyuUHP+b64qkDfryih3YQaDEt2NH9k7ZGUOBscBWmoE90SI0rPMFPoM8+i55UthM+5lKM0LXJvfBnFyA/+ocCmAs0dCXBnVsoma+/F9rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geh7wND1n385f7AAlChbGX/XWJ8u2NSB0aEjWUyfm0g=;
 b=j7aeDl2P0rvntAK9qJy+J+Lv27U/XpEwQ8EI2Gmxp7gOxXC7rZ8P8GBSetCXk9aGmvfBE0XLeGMSJqNJLFF4WFgBrM5PHgYV0WBTUP8r4sP7rqJETPYRuPnu3ZMBZ5LjLSUdGenwj4DEMV6HVW0QerE5BubDin5/48YVBDWptkYMs9+oWP1O5PlrOgGxbpt7WVzK/Oq3gKiWf2ziyTXt5DWuIVSgK3vUazdjv3UALojkcA6j33X+Qk0YDEJXRYhD0S8LKG8xAdCyhziGSviqUE7VgGjF8iwaM0yl41aqssRCZ7DtFnDwsBLGvtwnlzrYZlIOSsBgMjNdmFVMi9Z7kA==
Received: from BN6PR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:405:15::19) by MWHPR12MB1725.namprd12.prod.outlook.com
 (2603:10b6:300:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 13:14:03 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::93) by BN6PR1701CA0009.outlook.office365.com
 (2603:10b6:405:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 14 Jul 2021 13:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 13:14:02 +0000
Received: from [10.20.22.246] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Jul
 2021 13:14:00 +0000
Subject: Re: [PATCH v9 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-3-ameynarkhede03@gmail.com>
 <20210711164241.GB30406@raphael-debian-dev>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <442b4405-f434-55a6-cc7f-d4f29c211eac@nvidia.com>
Date:   Wed, 14 Jul 2021 08:13:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210711164241.GB30406@raphael-debian-dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eac2d56-a3f6-4cb5-4c7a-08d946c9402a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1725101F56C74AC198ABDB02C7139@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2XwM/lU8I2xeyW02T47vXcVGFXypZTMsPA4YhgtRTulD5CKiA5PCqCS+bMdgp+sn2mRkXAmzFCEMWr37RvkkxzVpOUumPEa1X8tYNn1pzIYLtt007QXrVcxtUs9ffof7S61b7d9PyMDC7WAIB2PhvI74oE+G//v9OcUVk0i07j+7OzeBaHGMqAvpM29x7RK1zSbIpjZ9etDQBpNAl6g5qI5EBr+/oK4ovD1Gv3tgscmD2Uc6MId0O37rmbE/BltzoLG8jDDr41Gu6sXPwMLCSrbX5nahhMkGLlG7sftAKS7l2x099euliUHWi2/fX7/xieDz468EIl+O4yE9IFlW8ruyqZxxzl7O0VXcOzL6OScQYH4ohrIqgFWmlELVCIXJbaoBkwucb0dTyL2IkCSYLhfEF5OyGoiYqHFmc3EskeMhbU7gIzOszmAlaNgcUFjlAoWKNN4CiXa2TAWQz+9VJhwy3FldMF0jGVBZvDSfpa6T7vJDnfHyTaUmgUZszZaIAPISak1qHuOc9SX4SXsf0Bsh/JjlBhU5uOvYw9qf0R6dqHLFv7zIgUp6KIAQWXPxvIey1AKSCiYLDQJtRJyympVawhLEPe5Epxlvk/3na2iT93M9abdjDyyk6zTcaKO51dPHYJV2ljuLjgfGk+iuj1iRdgW1WTeD+5EPTu0/TxNiTaq+XIIsDWE00ltFbpax5HyCZo9q8Pwqlg4xl0lK/S0aj9gJVt51B/5ZTeZ3nrR4cwkXF0JTKmQJNmu68fF5wLRdnjlu2oM6olEfAwBiw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(16526019)(47076005)(186003)(54906003)(70586007)(31686004)(36860700001)(83380400001)(31696002)(316002)(5660300002)(26005)(2616005)(86362001)(2906002)(7416002)(70206006)(426003)(336012)(16576012)(4326008)(53546011)(478600001)(110136005)(82740400003)(36906005)(34020700004)(8936002)(4744005)(82310400003)(36756003)(8676002)(7636003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 13:14:02.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eac2d56-a3f6-4cb5-4c7a-08d946c9402a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Raphael,

On 7/11/21 11:42 AM, Raphael Norwitz wrote:
> On Mon, Jul 05, 2021 at 07:51:32PM +0530, Amey Narkhede wrote:
>> Introduce a new array reset_methods in struct pci_dev to keep track of
>> reset mechanisms supported by the device and their ordering.
>>
>> Also refactor probing and reset functions to take advantage of calling
>> convention of reset functions.
>>
>> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>

Please review the latest v10 patch series.
