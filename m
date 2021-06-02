Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84BB3995CA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFBWS2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:18:28 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:40448
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229724AbhFBWS0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 18:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQKqr+1dtlS4U7QqHprpEKJBsOav08mssYRIjMvx0nBlOL2+AS3/E3u93NQT1J4fc3qiwYOGnymSBzJ8oQAj8OHtN5XqIKTdgRSg6AsGU4vZhWzOUp4VxRGPTVfJp1pZ9rMdsGvtZzBVFVi4bwcBgmtc7cv+2JrHmncLx5cJnItg533J6sIU+vfFDv4c2xG6s0DlCFGQrcoWOvqK5jQtC47feLjEVp6QDZTjJFZvjfYi2e85yeSVSnUMZYdLVeusWTYERiqsc4qfmY43e5qZMY8tAAfdM8bL42E90DqzmGluzLeZUruhG4hyqqe6UBmpTnnwBUAPh9klQ56z2kwuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8p9R0phEtX58gmd7nTBYEYJJ7WUnVHpvEiqV6iNprs=;
 b=MvwgL733qwgPpgX73qlWm4ojPlKRkbF135xlYfSzYfdYYNed4fZMZwttudsmoa36GY5mmK5MKc5OnXmCceE4fy3hB8fd4HGQIJbEBPWebWBV+FqoNmvdvMQ3CBB2tM8lOwUoTOiwt/dzF+LJwFcL0/VSLpz6ekgrM6QSgZVh19291hT39AgiSEfjD/238O0JDY2uoduehYArKigtge6dVY9J08gXmH9OFINf3sPhRf3WEHjJLR4Aq4invTNB9LMdh5y2WtFGJctg0duUZGkQ4mIlynylbBIHQ0JykSU85hu+fWcmFPYg52VjYI5o1e3n1VztGZO2ZnK5mvdPo742NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8p9R0phEtX58gmd7nTBYEYJJ7WUnVHpvEiqV6iNprs=;
 b=LGNniwzWEevCjduEJZ5iZaswnadlxIILux9mQvJFzri3KjfI2nRKSqp3QcXznhVYSui6y6BKKMjgihxoXRU/UN0CUwItlCXWfvdcmU2iaMdlNZuF8ltdM+kzjJMbVbbbd3uSS4mi44HP7GTxr9NryL3iAL56VXI9rABCFijv4dEnHmR3i+pkad3lOInGrAYSvuCbsRgd2HryFcxJH7a5UjI39S7sjNmUj2V/UTtYVwAnketmFFFyoThKp1hHPPaiMj3qIyBBx5SNa1gqtihf2nK6raTep5nCq/YkNi187dSYoY7ZjUbWn8gSFFV2RNHXag0EElBC8hQ4r7pjHJEadA==
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by CH2PR12MB4807.namprd12.prod.outlook.com (2603:10b6:610:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 22:16:41 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9e) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3 via Frontend
 Transport; Wed, 2 Jun 2021 22:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 22:16:41 +0000
Received: from [10.20.112.58] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 22:16:39 +0000
Subject: Re: [PATCH v5 3/7] PCI: Remove reset_fn field from pci_dev
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-4-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <46d2cd78-4bd0-9f11-b079-4d02018178a8@nvidia.com>
Date:   Wed, 2 Jun 2021 17:16:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529192527.2708-4-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 549c27c6-7bc4-4199-2a88-08d926141923
X-MS-TrafficTypeDiagnostic: CH2PR12MB4807:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4807BFFCBE8A14299DB2A7E2C73D9@CH2PR12MB4807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqtuX0mfUDTEpkssKzUyTJr7Ed7WbPaeLwN6LBDI1s2sT1UBcEaxoJS1hgR3a7dbj1ib8nEot+fUvoxxthQV177X4nddKYjg71+ZwdknQm1IlQb2UWUdUBzbKA4eiXTLsOJZkSXw2I5qskhEk1d50WMbWdZL+nLzysDCkqRBPu0ch09MwA5FcrS2bKkKZbQcRucRh/5+HNpbzotQ+qSfSlN9u6Fwiz2bJhWKGy9pQQkwem3XsOHzLNyLIOnzKKPH8AApLepaHBeR77bN7kFt4phIb5RQmYt955xai8Uhjf+gAGxw9vjbytNz/h/kOovtY2KziCtWVUryhkPxxFw0kxTH5kwbg5NwtZuwblvEBI/7J0Dy0PBlghJof37DUYPCafy4aKPVZ4VXhtxVjG/3sfsYWMe123BHdxdzZkU9O/BsPnSdNb2zdnl1NHDBvNDIL1rrmxPIOjtFDZJLOgtvZQkcmlpyUJz3xxvGFug4hm1Ys97c3ObBkDofDs0v8SDP/+mOhuhzoROglMb2XdbbI6vzi2ruCpjNXKO+Uaj/0mFBMXFw/sIEJzV/BwncKVscPc5oo3iiZ1u2XcA7rgCGmzwM47AiVbQL88UcrKQ8uu7avZQfXw2mu5AlehvS6Zn9xZh34ZSPWud32BH35F3PIVHN3wVab2ISlQ5G6Cy9hZPKy0ta88VMkOFqTFV76wvd
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(8936002)(83380400001)(2616005)(426003)(82310400003)(4744005)(356005)(86362001)(316002)(54906003)(53546011)(26005)(31696002)(31686004)(16576012)(70586007)(478600001)(70206006)(7636003)(2906002)(47076005)(36906005)(336012)(82740400003)(5660300002)(16526019)(186003)(8676002)(4326008)(36756003)(110136005)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 22:16:41.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549c27c6-7bc4-4199-2a88-08d926141923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4807
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/29/21 2:25 PM, Amey Narkhede wrote:
> reset_fn field is used to indicate whether the
> device supports any reset mechanism or not.
> Deprecate use of reset_fn in favor of new
> reset_methods array which can be used to keep
> track of all supported reset mechanisms of a device
> and their ordering.
> The octeon driver is incorrectly using reset_fn field
> to detect if the device supports FLR or not. Use
> pcie_reset_flr to probe whether it supports
> FLR or not.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>

