Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F23CB9B2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbhGPP1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:01 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:11265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237326AbhGPP1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjD8W6H8GvwBsZ8F/RNMfV50de1ATFgYK3a7fQJwoWGRMk+MhMt57xNVO6AfGYTlqxJk4+1aD/+NznVRzr205pRmnbaLJAkiKuFAxF4FTh9HBB2z/E+CXQhElapuTS+MUgz6aH3Y45OimEAvEQ1dlaptxIJRC10cXGu2nMK3VQwceBTFzXWKWD9h7/bYbksii7MQFzWpoxdK55hEUXONB6Wk9m5zKpxGHho7S6KJiChPvplLOJyLmV259Sx07j5ejhYDufAkbrqTD4sb9ZnNo8y6h0vSh6AaAiOTBHcXikiO5IrA8djX0ESmX4NdybAr/fy4pOB/8F/ghrnFj1JdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OYhtCdwjD4BxxNQoR4UOpZa6IIt/N5JxQFmld4CmCE=;
 b=AFJnkNhlYX8KqhhSZcFUm0iEThvpwJjzzaZMIRng0aOM7Afy/wBiCq+hWDgG/lEd9KvQ4OSldeQY2qAaoicgfGFTAoqAcUrU3AlRbE2cB1paYf+ATfJcD6/tHlrUNktWaqPdRLhmxVIGL57o4AUQ1Y/MBtjMqUEn76CFYP5ppTR6Ropr2ZQKn348fKuGXeBogfHyqqswd092m1nupzNkoRO4f4Bzv9MbX6JbioKLo8S9z9VY9zXzvzNluLdamCgCWCLEcMbLtdve80PbcBkRCJG/QAAa2f0yKDxDifeyAHWU4/P+VLLc33yJnSFL8PV9WT7k0XZ0u9oIoEbEUZZKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OYhtCdwjD4BxxNQoR4UOpZa6IIt/N5JxQFmld4CmCE=;
 b=b4JCizk2Is/lFuCe8QRBrvatZlJEYHqysPyuvr27JLU8mI3Yi2FQgCL1UPNP+FZfrYz7jkKdI1fiCVNTY/eIJVc1kx3GYlDU4s+m7a29bQI41IZD8xzMT9kDLodAEDAlngDQEXb6yLinyOpUwbV4VueALJ+vFFuG57zGSpYc8UbtcFP5oAqk4QONG3mXf1JM/SBZ5SH96ybnCSh+AaEzpUhll4BdfoiOttC04+1ftWXK90Et8+OQ3mUgW1D6K4KIIDtrKvVNc+l0lD9Pl2Ar6Wu9Y1trpkv0QjIdd8Iw0FeJpNdtGNN0OO5hIt+R3pe7MviyfTgCq8wnVt3hWDmuvw==
Received: from BN6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:404:65::22)
 by MN2PR12MB2990.namprd12.prod.outlook.com (2603:10b6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Fri, 16 Jul
 2021 15:24:04 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::84) by BN6PR17CA0012.outlook.office365.com
 (2603:10b6:404:65::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:03 +0000
Received: from [10.20.22.246] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul
 2021 15:24:01 +0000
Subject: Re: [PATCH v11 0/8] PCI: Add support for ACPI _RST reset method
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <ab901d2c-7f4d-f8b0-20d6-98c96a1eb9fa@nvidia.com>
Date:   Fri, 16 Jul 2021 10:23:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1abff9fc-4653-4e9b-9577-08d9486dbeff
X-MS-TrafficTypeDiagnostic: MN2PR12MB2990:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29907C0D4C40256DC5CEF9FBC7119@MN2PR12MB2990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpUYSeam2S+8Ch38yngAV04LTVwtXJfMohg5JQqtJXrFkmalfTlz3v/DAg7P99mzP3xoqaQiMzzYtRnO6I62xahN1NulqVyp2QsY6dnZuJH2Ashl81ePwBsCkon62ij4ATzA8sCQCe2kN9hJX3w/zRNOqPf7feCeG2iOLtoWVRn2LliDAoeSexBnwKaNZwISLjVCgsgU7zaE9Oo/hYW4Ex1YEwAGqHjJ3/VzssS+ljhEc+/PWWfL7p2JccTQInl4tQM8Ku4l+RltQ4VnQ9S2HlP+tkCAuVanDzNnyBT3Y2tJmnlpBoDy1FOa7ua6yfqlOn9WJvmhdBhPUWG8CUB2eq4zMyumAwLk71s1Y6+dFD32DcOim9gkRe8EciuqTI8eGqpfFz9HZA7nVqaYUR84bOZzt5u7Sc5zfnHWsLvXO/vNjK46oacEjR+7b4rs5ZQ39UXPLVAAYn3gKptAEfva25B02NNEPE6J/THaukFRxwzRdglXJ8HxKpMxYbWTuU+v8BQDxTUHJFHqSoInHUIS105zZ7yo9PpYACRzNbwmtJjQXCNSybucLozrk1aYa0+szb1US44Wd/0BNnJzVAH+dvHTjEWraS+CRGi6YsudAduLBaXWpGhtO5H2uNVj4MhORr3jVx3S/R9BMmH98IoWoV1VQkNv/CGHm7f1egl0Y1Im+X5n8h7RvJLh/WcRTqq6vthyXZo4iDAr0Kr3KnjV/5iHUvlEvinmUZhkRGX913jyKxiH3gNVyNvDg1zvsy6BZjOB7BzUDeoIL2IEnPwezQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(36906005)(316002)(16576012)(86362001)(70586007)(336012)(2616005)(4326008)(8936002)(34020700004)(8676002)(426003)(2906002)(70206006)(54906003)(47076005)(26005)(82310400003)(6916009)(356005)(31686004)(36756003)(5660300002)(7636003)(82740400003)(31696002)(478600001)(16526019)(186003)(36860700001)(558084003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:03.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abff9fc-4653-4e9b-9577-08d9486dbeff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2990
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/Alex,

I've posted v11 with the incorrect subject in 0/8, please use v12 patch series for review.

Thanks,
Shanker Donthineni

