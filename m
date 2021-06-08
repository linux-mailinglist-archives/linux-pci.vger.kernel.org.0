Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF739EAEE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 02:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHAqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 20:46:53 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:42369
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhFHAqw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 20:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjzSZZY/vYj293iaAajNGDl70FIIlf3gxBo+yk3uBMBFqYRv5p9UCtuffikC12xjXehTlGWEnvfaXWTTc2UPJBjeQR2Jv3Apr6ODEioVeA2Uv1bEyWWmSffevSMu7j/Wn0NxazxhqwFqAClqmTwQIa+jlUPpb8n7ye0Fcl6y5VJbGtVqt4o7FYyW3uIVsYlqXleyn0sOU55Oex3jHNUFb2Khjd1UNmC5LhpQ64feSy2BBF19JzZ6wy0trzxIJyyAhsnfbREJWuTsW7lDhQd2U1XBpAXg/oJNlseeq3tJXnT+KcrZWn2WeGXwHWWcBU6ClRIy3wHIidJIYqmCDOLu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juy7dq42uDrNejm3+AqfrAVtjkFq+TECM+dqMFjUD4U=;
 b=CFzqu0exqIaUBmu2BxAXBEH9xRetIzVVCOP+gAK29o6m7B1WnNEG5KJfxUZDx44BO8vFlQp2dRC/E4onHD89Ywr3g0/+ZQg5FY1B4Xv3PIhwUNcLtF5KFLmAVFt1RVTKsZCMUuvqs2E20Otp5n4Lb7yDWnLQljmO48wxHGF5l56hhnl7WijuDKuiM/3cUF1eCU8ml2piv7bssVjCRqcF4P+REVyHIpHph71d88i1usu92+pr0hMI/NgTJ2AuUEzDNYld50drMBAJuctwPImtQAyMrI2ySR0/OsS2GrD5jXUdodhpCoHQ4gKe0Vp5lTwB+0RaWB0cEPm2vwG0UbmV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juy7dq42uDrNejm3+AqfrAVtjkFq+TECM+dqMFjUD4U=;
 b=Vfik4jWBPnWgrUzxBlrhWpTkS7BdbybOE3tUghNd73PXF1ZxDbkp7g7C5+ailBC0ByYLXdyucv4B4zmuCRTD5lwWNvn89rk6Fev4ygsOdVzcY6uPazNiJjQ5RnTmUEU54lb101IDg1Fg0t/zJw4W69oAbwIZf06DlTbXq1zc7v/TVvtdxO5WI5NqcWK65oLYDCGOVeY1qs+n1ylA2kmdAXSXnbKuwgraQCsQLKUFN/ylQRPKaUghs6R0vleWmqUfpXTCFFCZ61ORj7wQHn72usT1fWR85/nQ4585ACKi0P1HaCp1Z0PK9CQLQZXAF+ofpGORIhLOxbVD+KdeGVgc6Q==
Received: from BN6PR11CA0039.namprd11.prod.outlook.com (2603:10b6:404:4b::25)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 00:44:58 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::56) by BN6PR11CA0039.outlook.office365.com
 (2603:10b6:404:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Tue, 8 Jun 2021 00:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 00:44:58 +0000
Received: from [10.20.112.58] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 00:44:55 +0000
Subject: Re: [PATCH v6 8/8] PCI: Change the type of probe argument in reset
 functions
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
 <20210607182137.5794-9-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <c3181f83-24a3-9dc5-dd57-abfdef17403d@nvidia.com>
Date:   Mon, 7 Jun 2021 19:44:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607182137.5794-9-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b46d56-42fa-4a5e-7870-08d92a16a46c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4187:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41879F8A18001FF68F6CB909C7379@DM6PR12MB4187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjyWOxkHwozw6ddOABT3HdwAbX4gpbBE6wJfbTcXwj0UheIfeqKDKiHTJbAFvYPiyUkcnOEr9tfpnMte3AMbII1+Mt2ha+gD+JFKk+fiM+UvdUv3oahw++R7NgbEKhKSKHyB6Ev1M9ZcjFdhr/6rkrCAM5j/Vt1DHuBNzOBDFUCbLt35pThCd1mGcTLEnmMEiBKdZP1kwy+tULS9jo3+3QYw6Pr9Znn52hZVP6rC9UlUaQzGcjQiM03+vKOzZEnoAb/KUAZtwwES6+0CmryUCc66c/qGxMEIpczW527ALuLLDmJ9Ubu7OvpwDFCo1P5cmmUelhhc1tHnDnohHZ/LfN1CA5nmGptu3728Hl+qhayb6s5mMS2bQ6sqO8LZk5Yo092vy3pPeeb3Tn2rnRmgkyQxNeGYXiQ2889VR5iAfRA/suQi0vJXFRd+I3/Sc7ylh6E+kAndMII/dl+6fU7FaeFpW6DbDiAahOMrghzwWX3pw2iiHVR8Z2fAzH/msrUke0+Dwf38B8C467lBqRrj92b8mPmYtq1LDLTMD+NVqDhumnikVVCI28NWjEDNgpu6oyJhlvtC2o7lxOaTLzx/BsiRw22E+2+u7zhiLhx3Ip8Q/SpE8ZUM7KP7zttVKr4aMkumzNqWd5SRLT4+Fgo+YJ1B6YlaxfdRVnqWt6t+ueFUvw++RPYAgZH7clnQ5jWt
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(86362001)(110136005)(16576012)(316002)(54906003)(36906005)(31696002)(82310400003)(31686004)(53546011)(4744005)(8676002)(186003)(5660300002)(2906002)(70206006)(70586007)(16526019)(8936002)(426003)(336012)(36860700001)(2616005)(478600001)(7636003)(36756003)(6666004)(4326008)(356005)(82740400003)(47076005)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 00:44:58.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b46d56-42fa-4a5e-7870-08d92a16a46c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

On 6/7/21 1:21 PM, Amey Narkhede wrote:
>  int pci_acpi_program_hp_params(struct pci_dev *dev);
>  extern const struct attribute_group pci_dev_acpi_attr_group;
>  void pci_set_acpi_fwnode(struct pci_dev *dev);
> -int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
> +int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode);
>  #else
>  static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
>  {
Prototype mismatch, build kernel with CONFIG_ACPI=n to catch this issue.
