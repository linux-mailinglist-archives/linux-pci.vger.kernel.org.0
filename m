Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10A36CB6C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhD0TDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:03:53 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:31092
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230219AbhD0TDw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 15:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSv274SYllKnCqEhp0y3u7MF8hutK3U/BBBbXgsncPNmEbdXgK84y388M1ZKKfGUkDx9O/q1Asu4RaV0poQQd+g3p3TC6EEHiuvoBPezykflIKSUEYdbsrzWdQrLf6k6DWQPJOvZaXhc9sQmLVGMzO+1PibHi33NqcdnjECp7F3uEIdvpVD0nxhkYdz0fFKkhpwIGJaT/VSVCeqCQpLhhXfpThxbWiDst10hqcy8f0dIYPQHoZz/xfytxuBzvQt2iYlf9dXCF5qVBEBm9pQK4PMvv4EFdaJ9IILRbpip4gHAc1nHMhwRJOgzSxnaTrX/lAdOuMfCSxLuDcmgfyWuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrDvKmMQ4gR/PuPRk9g+tFjLKN6THTZd3dTvleeJMVk=;
 b=J4uWldatSsdfP+eSrKC64l5r3Ja2ehhqqkxoE9CLEK7IsYh0qyTuGx9MmuR/8lZLK8/XXvBmsSI1HAnv5PVTFon8dAjjTsKUq7DKvBoLypwW8MMqhOqn/bQtLVRzNaKaGzhEuLdREdtjBnWick6nKAPMQApD/j+yQUBGszdEFJhNqLBpmvP4vS2EMJJnkSw02VntZz/arGMecNmps1moe0GQeJR6dqJpIxpgYhjobC19xGSe6yLE+a3W2xboaijfbuXhEBEQT6NMpR/jmGOxwMZqo6qWNiBYUrLQ/AYIu2/BIsuoZ+nJOnpQf4a5Y7DF8Wm80LXHGBsX6hvzxqvnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrDvKmMQ4gR/PuPRk9g+tFjLKN6THTZd3dTvleeJMVk=;
 b=PcWpKoCLphIcXjnffi748Bjbxi7QKURZacuVNb8Wy6x8HM4hF9XSLnodyPDDMOh43lfwAgIZbRATjlduxwqP4a8lAd987Wk0/xwo8q80hz7b08qUPGWnCuHkjXStyGSp0MFrX7cNfi2LLRekUehVnk/HZu8N1OZM7kILdjixkFfB0Fqcbk16BqIqbJOwqnz6d2BiSM2uMcryPB/J9RjsOJEIGWGMf4B/BJcn57isoxr32L67EnoIGMSxxibeUgleiZc8ue1fLqa1hEhnN2JGysOl8nxQ6P5IoGbIDdAc5rmwXKM20Cqm/WYGxXpvqr3qdDcHcZwzHVh2j1sEKg6JRw==
Received: from MWHPR2201CA0050.namprd22.prod.outlook.com
 (2603:10b6:301:16::24) by CH2PR12MB3782.namprd12.prod.outlook.com
 (2603:10b6:610:23::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 19:03:07 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::4e) by MWHPR2201CA0050.outlook.office365.com
 (2603:10b6:301:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Tue, 27 Apr 2021 19:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 19:03:07 +0000
Received: from [10.20.22.163] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Apr
 2021 19:03:05 +0000
Subject: Re: [PATCH v3 1/2] PCI: Add support for a function level reset based
 on _RST method
To:     Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
References: <20210427145535.4034-1-sdonthineni@nvidia.com>
 <20210427150515.vts6whtuxpkaztxr@archlinux>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <0d1429bf-663b-687d-f682-76bfad3be15a@nvidia.com>
Date:   Tue, 27 Apr 2021 14:03:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427150515.vts6whtuxpkaztxr@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f8f4cf3-94fc-4a35-9c0e-08d909af17bc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3782AAA3348BE91C4255C8EAC7419@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XELGZmQPQ+Ig4B7S7EfS60lP/kDD2l2zakPvKAETSQLYRT/8iHFwF85s5Aso8CIMzWZfmmQogflv68Ru0ksRqH/WEaGrXFn2qsvWhTGB0ZxcPJwbPD5uWfUMbojnAVVDH5okOIbkzDfEZcXDhU0ALN8UoFoxurONVLSRH/N55KhowTicgaAhX3KMTYXCUnx7UwE9qnpHnm64SGOaWomwtVUj1pcm56YnYTJ2qjYo72xv5G+RCLXTy27JssGopz4u/4xSCovFL2ttWN7PIo9LXboCd4vAGJ8UpEzLF6r+zRxR3VRenAZ1+TFC4E4Hr2rXYmlOtoIT5agywDQvxTQeMtiu0pw/1pCY5EyXD0AuSSg/E6SwECmaY9ckxauiHwz3RFuPh3ei8e+LulOuGKlYyrwnH3I2cqJTycPtUTRGShsP6okMaq1nq4oBL45SMwwoLmRcsWuUmngaQF1yuVnWdrToKbp0lYE/3AQgcRgRbxB93pjEWMZ7ao3K2BDcdP3kEBC0KMLtwjrP1IKJ/ZH9rqTbepChwxYKcwaLkpDLWKaJUJjcGW7OyOF4tX+7MrptWYofz4pByAmLBMZBaU/Mv2AN34xywAc6cpJiTqfcN5A+ZibWXNhoDbXpd19DhzoJu6ZjzUlwXwb/IP04byy7sst2Mno2RuoLoUIGGTgkKPZGWyrPNeG5lnfSXayVcxacYnZASsPHNQtGSRftX//edwT167XOcjLDfSGD4Um5OzAaQsUKizLgr4YC8FCHmLPgQoTcVlxydSx1e+Mes1u+Xg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(16576012)(36756003)(16526019)(316002)(6916009)(2616005)(356005)(47076005)(82310400003)(7636003)(83380400001)(107886003)(426003)(8936002)(53546011)(558084003)(36906005)(31696002)(2906002)(5660300002)(478600001)(86362001)(186003)(82740400003)(26005)(8676002)(966005)(70586007)(336012)(70206006)(31686004)(36860700001)(54906003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 19:03:07.0280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8f4cf3-94fc-4a35-9c0e-08d909af17bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Amey,

On 4/27/21 10:05 AM, Amey Narkhede wrote:
> Would you like to rebase this patch on [1]?
> Or should I send the v3?
>
> [1]: https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/
I'll rebase and post updated patches.
