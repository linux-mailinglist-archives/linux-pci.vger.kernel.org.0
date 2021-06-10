Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E513A34B0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFJUSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:18:55 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:56801
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229961AbhFJUSy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 16:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzJv69/9dvhgQny/s8YvHa9YNZj+OYV1qSQ4VPoXkyMou68YxOKzmgIh0d7Y0qN+vpEhrXwjvkf70ZY7s+7zRNHhvxkKucgr1j883MTmWMxdjR2HJhTO1sIiaw350TEtIpVSrQoO/bq2bpzdmSxDF2bEOCBnxjoaJPIkgCulDH7Vgnx7PVvA06J3FBIT/uoBT9nfQKaEDjzYUH5L4jk8PU5bwSA3CClW6TthGZEeEpUCzR0oH6JdPrMisTSGxzrVhm+muHbKNbH/uF4sdvRC515CkXUDnuR1hETu9y2uzexJP3YpU24VBaI0vRatI5uuYOqhMMoomPwAh0EwStiWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsgnWTuO7uSGqLYZ6YC+PCezngTTpCXcd5QqhUaTrLQ=;
 b=QkmZjlh/iMNlo37epaDhrD+utshIcipnawgqMZ/ScVDoA3NQWqtfI3h3rsudM1XXVqT25or/o4XFRoVXAOZuV9KEz6uOOM0kJ4VY2cosS4cFI+RKuciiDEMkf7NOjHvAYOGXV3k0uBQkbFEMfXjIqpWbBxTUdPM3xIAbgNHfqK4iFGSgyh2c9ZDITJdysnFm0ZW0SdZvD53e/YFMCe3wTBVHP7yj1etukKmNlEZ6H1UiQCVLE5o/PPczyLey7L24f1TnLuXZ8p/UhojPUhuwS5YTpdF5VN/n+esIOdGe6YIZKOGo3YJSqLL867hZFHjCNyGSvTg1lJQwqZT6zvwpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsgnWTuO7uSGqLYZ6YC+PCezngTTpCXcd5QqhUaTrLQ=;
 b=t/C7q9LSwN8Lacs/F37J7RmIKProA+8LdLP7OdM5uJEWRjIG73q9rPf1z5YP/+cWsJV271JMADtZTMVhrI+RB01RdMk7l481x94F1mOIm8JBU0tviCdRe1nEgIK9yzClPN9dOJF/EXMuP/9cAWRtSdhuyIMtGm6R197Xk6F15EzkDQ09yvRIWnaujDFDssFfa+0wXguYvu4o3qDLc+YHdOU63iPjSZCnKrBycvlKL/E/SMqjh2GXTRcR6taH9YAfAixrw7+eCRHUfrizL8TDR7sJPddzm/iT4Wz704LHMMRkku+pWH5+QQFw4h8O7SQoQ54FKqKuv/BpQspj1fNJsg==
Received: from BN7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:20::18)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Thu, 10 Jun
 2021 20:16:57 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::20) by BN7PR02CA0005.outlook.office365.com
 (2603:10b6:408:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 20:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 20:16:56 +0000
Received: from [10.20.22.154] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 20:16:53 +0000
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-5-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <71915313-b95f-059b-e178-d358de4ad1cb@nvidia.com>
Date:   Thu, 10 Jun 2021 15:16:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608054857.18963-5-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbedd467-0451-4d58-6e9a-08d92c4cb204
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-Microsoft-Antispam-PRVS: <DM5PR12MB190022267C9B1D3DCAE31489C7359@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMCaY/mxztUStegL7kmR9/kuNaCsN4Di92eJ8++u56KVIyUtgWW+M0n1kUi3dpud2kOm42jW8QzfeiRuqtxpWwRl+TGaSPplZmcnyRx1Op1WaWeDYJxm6wiOfAnxDzjkOolCmizwTXGj6HKrQ9upIK3c4LeMyv+0rtnHA5me09ZUtIFSUab0ggyUWr/h3SAk35Yh+EWmemcP72m6y8HBPF4wuNvKyZmQ7kS82JHW4CN0SJEtShh1rMXWXEyIkRcSi/lZGrHWx0O01frgrMSCKKWC+QVDLCfvkVXvBJX3y7fyyOdJeSNXT1Ox9hT8lHNtYl0IU3fBDyz/FM6i71ZR/AZMc43LKLhA2G+dE9Xq4pp4wjO/pOyDhdS07Q0T2vvfNbzD38eeDDpgfJXY5OEek2GwKkfDgKcPI43XvuTnXqjp4PZlaqN9sjDLo1IzSB4fb3ZjzChivaq2RGQ3AemDpb2YM2M9Swy8LZ1Xc9WE2Iqy910pFDQWtlc4n06fb+zGeo12fr3j3NEd4OydzDmQ11p46hQHh4QJv0YVtGc6Yy4eNvFT1mm/vsg4q6If7vf/STSGXdQdpN8guFsTFi4HT0inhLUICY7y09la/RiS667H4o4adJMxWEyQYyrp3xPzlVFOlMreckDZU+ISKd2wf1V+RjWPEFCHllCcVWXJ65MnAKYL2tuPVk3mx0kMMeZB
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(53546011)(82740400003)(4744005)(31696002)(8676002)(82310400003)(7636003)(83380400001)(54906003)(70206006)(8936002)(16576012)(70586007)(5660300002)(336012)(316002)(356005)(110136005)(296002)(26005)(4326008)(426003)(36756003)(47076005)(7416002)(36860700001)(31686004)(478600001)(86362001)(16526019)(2616005)(2906002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 20:16:56.2758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbedd467-0451-4d58-6e9a-08d92c4cb204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/21 12:48 AM, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to
> query and set user preferred device reset methods and
> their ordering.
>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
