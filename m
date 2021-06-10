Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C83A34A8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJURn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:17:43 -0400
Received: from mail-dm3nam07on2060.outbound.protection.outlook.com ([40.107.95.60]:65409
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhFJURn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 16:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnDlpdGcmGF0FzCGqMP7FcGaAidtb8eWMUfiWlgAv3J9LS3OHEc37lRb2R0ApwBaldbWFOT6a8TXPnbtpBOEj/n9sevpuqKrlfPyls9ml7276y9/FnyAzhcAL5G1Y/R46OO5aIVbLMXrB045HQq9splGImlZGuKYTWX6toJeW1aPOxJ31Igd4XvMt5S5hjFpi2u8/Mn1WUf26Gk3XRl7dA1b15ETsLLzqAovPSWzifM2U3pdf5eSmdvP9FdJjc9C+nKgxZIIfF8jJyS1+GWYCNn6dScn+ggHBL4AeI0kvD518SxccPJy5vPiaBLaH8QEGVKYnGtOmYOd8NB5TR2RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7xh70Q8mOLhkIfEyYUQxOXDKnTw7Z3WkeT+Gld41D8=;
 b=k+nWO9faKwa0p82UwDd4kdDkuBZaOY4A/141gJDYOnKlAruKukW/a1OvTEimz5xjsDU1K1ZcZu6a9Sva9subatpgTjFyfVuJCr5W7rnq6cFfIA4QkwE+qHMRF1K4UaTwnm9r/8p0dYUyQ247y85HocyyTSpyhgQi6A0w7YoVKk7GejvQSkoDH4/Y5zvNwPrYRad9jIMV/Fd1avNlFkqVOd/xAIyU+AfHMSuzOGk/aNDB70qiD2e7oWJRTm/OtSsZRfpB6lGtCijK+7ESq5t5Kvs1NcA3tjFKyGvGzVFfJhFt2D98pww5xoszKTS5t9ewHmcLMR88bs/habsxENAbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7xh70Q8mOLhkIfEyYUQxOXDKnTw7Z3WkeT+Gld41D8=;
 b=FoR3NN5Z2HcG2tQYYLBlB7HO0fnhbqhbkywBbQSebIUEB/YaJpht47dUc8VkCLZL9D+d4TXnoXnYXhA1HUi17jPhixa8rnG6w1KYdtwZF2s64+SoPVEDUJ1xDh8QDfWPFK56NoF15QH18P8paQbDQwydNufuOFEUq3KZtFGNF4VYl6lYkDmJgpcig4vbW1U2sKCEr0jJVRIAwF41TDAK5erkw9gv+5m9RjIp3umUcfGQz46vX5Um9ADGwa1EumrfoqqULObV8ttqOuCh+sf7BidWr5BJtvq6DZ/r6HK1Ks2lXnFa5z8xiw15tz+y/5cGtUe/j6BUrb2lcZxg+K9PbQ==
Received: from BN0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:e8::26)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 20:15:45 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::7d) by BN0PR04CA0051.outlook.office365.com
 (2603:10b6:408:e8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 20:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 20:15:44 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 20:15:42 +0000
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-3-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <44cfb22c-7f08-0222-d84e-91e462c5bbaa@nvidia.com>
Date:   Thu, 10 Jun 2021 15:15:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608054857.18963-3-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ddaaee-f7dc-42fb-5661-08d92c4c873a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203A6826AA3A25ED6B41BFDC7359@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/FNIW9/t7N6yPPB6K9HvG241n5seA+Rf+Na5Ryfr/6SQOEtYAk+5OElivI8aBEdYYv/jwu6FB9zh6f0akAQkjehw/Fr814PH39pdeJIMK+iKOX9+UdlG2+uY12WHvDqD1W34XufigvC7bqSW2GDFwHcpJq6X5wakdc97az132wp+mQLNclnatwFRjAbx7mahXju7LGlGcrGmf3KTLcKe1/RSdrDv7L/N8+lqng0Sf9RQ/eF9Zs8xPspzO9MRSXilxW/1dz0LOE71Gh2+9AXsV73rMLhVwwS9ZzUoIN0j2P1EEsx7xaysNMAq0dN1w1wqO0jqBSVTCnQdlnsk/hn0pjVIMcHuYuIrguM3ll2HioFfSdBfOgicjF6HXYF6FkKVLcnin5urY/JWE8rc3LHTN8VgdX6cdPwc9niO9sv1WnbNstdjfk+WilhntOKJpx9UXErF0pd303l4WbtwV+ygohWfDQ9Sig9iiOSEi5+lyEZkEkOLzS5IXN/AHJilFoBvo9BQke3KXgo/4yd79wp2dhv/q5KaJKef/ozPHHEbPJxUwvKMMVAfjZDpT9kQGrohGtrSNT9Q+0DP8A+POu3WHPXiJ8w4WEIn0rZAvOtAkkcH7vS6U6AKmlLiRiqIjkX77oot9Mdu6BFh5mkK9OX4bOEsjwLlAgT+lstoVNc8OXZcf90w6N7kJCXXNwlyxIc
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(16526019)(82740400003)(8936002)(26005)(186003)(8676002)(4744005)(4326008)(82310400003)(70586007)(70206006)(83380400001)(2616005)(31696002)(426003)(336012)(356005)(47076005)(31686004)(86362001)(54906003)(16576012)(2906002)(296002)(316002)(110136005)(36860700001)(7416002)(36756003)(7636003)(53546011)(478600001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 20:15:44.5610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ddaaee-f7dc-42fb-5661-08d92c4c873a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/21 12:48 AM, Amey Narkhede wrote:
> Introduce a new array reset_methods in struct pci_dev to keep track of
> reset mechanisms supported by the device and their ordering.
> Also refactor probing and reset functions to take advantage of calling
> convention of reset functions.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
