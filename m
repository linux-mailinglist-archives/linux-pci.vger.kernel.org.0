Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABB3A203F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 00:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFIWin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 18:38:43 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:62176
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230151AbhFIWik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 18:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRRK1tBmfI3p/MvsJwzl5KiUWN3X1c3yklNO01kS723TPB9rih0J/waiOHBLZ4i4t+QqsZnTcGl3tHp4THjUXfUNnPHi453T4tA4ZFLRWndyszTCHvCw2YhzB/dKyOcCnLVJPmBXySKpnDktTT/jLNDnVNoT8iCrd29ips/Vehmacv7guqIQf0HqkgPF7huHvylBq0R8wLL9Hyuf+vsQ4OuPF9p175CvnG3zzxmq/51/toj/cl9fsVEHMTXNLl6LsWmVSewXcXoV4HzpURzXrQx2qOkLUbkG36ZMXsYJWxf86ZQ7uPRLmvU7sgY+4J5uIkYfIVBSNL4iV9yFcHZg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1/ScQ9jbnHUpU/6SCd63ou6Z74zXB9C+k8pYZ2Oq1g=;
 b=QUmLzqK+hUQm05RABvq3HXx9jTvyyK5Hto+G76ysKBDr13aP4RjCOoVWe1JKGWU7z2xrKdu3LPQDzQrNka6+cVAHbqDTVo6PbpJit7tCYe2zkCnOt4AJ1F/x+iLLwZIDvnS2ffKwkg+9AK9MEfkoPxr/LRosLJGKE4q0Sx0Lh62CacwC5Hb1d+ZrvtveNFs8xDxYjM3VsWu+sppM0vHmX36Adlk8lLBP1M4YIBVEVDOLrQxPUtuNhRUDEv28yNAx9j+O/jTRVGHPznaUnU3Sai4Yqm5mRaziDrkYO7dozM5UTHX4BhRLCYge6LD3PiZz3XnYAHfpPb2MUaB/FMlz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1/ScQ9jbnHUpU/6SCd63ou6Z74zXB9C+k8pYZ2Oq1g=;
 b=BgVR10MZdjlVF5gXgXu1aGM3kXqfOYjlM6w+/dh/jaTuNmlqaqMxZfhI50dVx8yfm+4vNi1+EHX7q3w0EZQtnCR1saIPzvgeRudruIPKskCjjyS3vXRPcjjBxqqA2RqQ0i+ukwAVCqWC0lUIgIOxCbX0BpjU0vzBVAMSOMyRCYgIdnEh1yfy0y8TZ5D47yIbCxUwKy7p81Gy2REa7KQ9TocCoLucdZFryIOHr1Va2J4BNSpYuwQJozyXnFJzxzSZ8X1bSsjfGOZtrOvDHptoMkLtOK4mRHxRDiabP7+iV7VpUJRawgMBPoEJciVDL9tDb2E/wzS3ICcMnTppV8bgcg==
Received: from DM3PR11CA0016.namprd11.prod.outlook.com (2603:10b6:0:54::26) by
 MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 22:36:44 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::ec) by DM3PR11CA0016.outlook.office365.com
 (2603:10b6:0:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 22:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 22:36:44 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 22:36:28 +0000
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-5-ameynarkhede03@gmail.com>
 <20210609215724.GB25307@raphael-debian-dev>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <712afcf7-5a46-8747-2fb1-ee167f406847@nvidia.com>
Date:   Wed, 9 Jun 2021 17:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609215724.GB25307@raphael-debian-dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c3517a-4ad6-4180-4592-08d92b970f1a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4288EA5806C3A1F4DDCF86EAC7369@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu9QW+qOAxiOM1MezKZ6bnUEa5an3rgdrISE76BM3blb3CFs1eH02+aFI5gg9nTsxutxG38q9tnkMMuUjOCTa9AHKILepLP1cKb41GtIVJeGrtgeHqwlXux+tuFsGK3Qj2DCZsYWELGUb/On96XSoteiwFkveP1FmPFkKB/YLsYq6H6Lo6/6ELXyy1l4xUkDvFKhYolyvZwoPHb36aWDoWhLUeDhrA9VVMZvJJNdytfzeU/bfVn/D9Hk6lc0Ln9ECgYUNBuSXQdVKb2oZQXd97kmFY2vP8qVuccEG0/PYXOIYgCT9VWAtoPg9O+cQYS9Lf7wHLV9S8gMEjGs7Jrw7kl0eYVBfoRrkxmCHE9ZH7EGjtUhy8Zxxs3Yga4+pxvcopnOWAliBWS2A6ZbX3QLbsx2O66rUHn4uHbqQ7w4AQwspuNETUV+X4+MA2lmUlQHTCDy9UAFjoTKznFSZA93XkKeEt0c3U+oadwpisEBHFSLWzZ5vGN+piBZru5flhng/RbhPboPa7E/TS5vDr71wD5Tm87kWmjK3/sCQnKprloQylZETzycg/8KIV5Hsrhc4SU/3jZomRDX5yiyw4dRJizRASl8nqOmMpdtfY2g3k6IYJxwLoyEbmdk+i/pwRQn5Oq2cuwJF7RK0w48W/Vez/hXzmN9BzmWVzRShcYPCl+IDLk5lc+xL72pjX+OdStk
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(47076005)(70206006)(7636003)(16526019)(31686004)(2906002)(31696002)(8936002)(36756003)(186003)(26005)(478600001)(82740400003)(36860700001)(426003)(4326008)(356005)(16576012)(53546011)(54906003)(8676002)(70586007)(2616005)(7416002)(86362001)(336012)(110136005)(5660300002)(82310400003)(316002)(36906005)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 22:36:44.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c3517a-4ad6-4180-4592-08d92b970f1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Raphael,

On 6/9/21 4:57 PM, Raphael Norwitz wrote:
>> +static ssize_t reset_method_show(struct device *dev,
>> +                              struct device_attribute *attr,
>> +                              char *buf)
>> +{
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +     ssize_t len = 0;
>> +     int i, prio;
>> +
>> +     for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
>> +             for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
>> +                     if (prio == pdev->reset_methods[i]) {
>> +                             len += sysfs_emit_at(buf, len, "%s%s",
>> +                                                  len ? "," : "",
>> +                                                  pci_reset_fn_methods[i].name);
>> +                             break;
>> +                     }
>> +             }
>> +
>> +             if (i == PCI_RESET_METHODS_NUM)
>> +                     break;
>> +     }
>> +
> Don't you still need to ensure you add the newline even if there are no
> reset methods set? If the len is zero why don't we need the newline?
>
> Otherwise looks good.
>

sysfs entry 'reset_method' will not be visible if there are no reset methods.

