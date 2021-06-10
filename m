Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287E83A37F4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJXfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:35:11 -0400
Received: from mail-dm6nam08on2076.outbound.protection.outlook.com ([40.107.102.76]:12641
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231218AbhFJXfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efO7ddMMbLd+Y8XHKbiIQnoaphxd26UqPmG4nCXWGhXwP22bmeOGJjWK+QfCHtlCQZm9ySWhv7nzK9k8Nygd533KCVJTvKOPnK+Rc7l6XUgtmX73qLkTpXuoIU2xN6XuGIwvaz/QKM29VeTi79OwbXhCWDZIOGbuFd0xU0r3A7VeP01l/qVG9TFN1hf+lboxGweafUK0INoQl76cpVvdbZ1rEJhy8yEZdWmQ7cRMfKGB3OhA9f3K5l7HRml85QwSonhg0Haot6hVbvF8qsg5zM3zcFfkS8MQmHR6SCRd3Xu5bm+bTIFz3HRyN/bjI4xI4b+O7OjttFmkBi/rahLAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS9qnth8/H6LWFuu6n9IwAnTDfLpOvONkNOAJYCbOf0=;
 b=Sz4xfRvj2hX8yhQ5I5GsabbVFvpXhWLeHi8yNyV4B4oOS8WgtuORc3k5TmzNVJLpC25wkxvVcSnReJY938k4cxeo4zQAe2N8XGF6dPByrRyrgBYjQTeRiJbjnmXEZ5nWarWWjyeONEyoHULbiXoUiXdQ2kHEsUNTz5WEaJhv5YDzk0eXRWl9W2+Iu0eRCle1msZG/i/o4nYrZJ/z+hoE/fB9zzAKO0CTnBCOgye+Sxk9kMgUH6jZZLsc3j+aLO8dy88r83uQ4rc3dhQq4cYvetH1F2bebwAXZFCMoZzsnzGOqNuau9lw4vdNe0nVccNY6vKtE9thxt3NZAhOjf60ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS9qnth8/H6LWFuu6n9IwAnTDfLpOvONkNOAJYCbOf0=;
 b=Eoyd8IYorP74zvYx580ERuXMXbtCe9NyM9l8MwdQASBrXzsp+28ZMJII5jmyTlFo1yNSKCTBIoCq3Bf5lhixjMaMzZBw3b3XdQka7zlHN0pgh03dcOl5AWXzizDg80QPsJlEWop503720vB1mEo4AOz99lBO+Os4UcCORnpPuJmoVvOnk47U/lnr2Al50N1NggD5NegEaelt9Uz/l//wWaHZrSef320knjFbGD2zFLWV7A7u19wf+mOsb34HkTm0azrqmoEaaNKxXucLUxgo7TRj4kJuIOiMbF/fm6PRzvdLozBWCetcXi37FeZAFFLyTrS/hWT3mYkW9dxPqxfj8w==
Received: from BN9PR03CA0910.namprd03.prod.outlook.com (2603:10b6:408:107::15)
 by BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 23:33:13 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::53) by BN9PR03CA0910.outlook.office365.com
 (2603:10b6:408:107::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 23:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 23:33:12 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 23:33:09 +0000
Subject: Re: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210610231615.GA2792521@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <ed3490f4-ea6f-1c3b-7831-d75feaa99cdc@nvidia.com>
Date:   Thu, 10 Jun 2021 18:33:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210610231615.GA2792521@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c7c0cef-1de2-491d-10de-08d92c681d1c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1124:
X-Microsoft-Antispam-PRVS: <BN6PR12MB112419B05311AA3000666E86C7359@BN6PR12MB1124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/wkufbBcrkeEJPKPTWs/W9uJTCx52GElheCvRZExPDUQru3b2LF4jPCXZDAMbCl9UiMcg/YIpbgvJr2zOfMyNGEeU9N/B9SZAuWAjLFYeDRwzv/czxFWsyDWFyLwvMbVM0NWZFxMUO29vR5XxmfVZtIs8ZdhCNWP0rzKndt5OEcYYzCGeNtF6DDQxSyKRzbsqSym1vyly/314gNFhlMOmNhND9wS8k+Cm5Vs+vXnCtdpp6PMUWSYqKHWl9P5YB8rFm44MPY+pRLzPeQXkU3HqzMsc7USwTouR41QXJbc1yop50dKs4/TsTuHOD8lzVwyVHf+VwKjxAhnAK8l++RAQ5Wi+vhMoMDuFTE6IyPeMoWj1i0fxMU/qhriwKHxtHkALNddnb0hUaGzIr2JiJaF7+jmqd9C4ugv+gEHEA1UxFb1HcQFlueank/5s+nbEZxRLdhTqToyMEU/fiQ1kvEQXKG/gaTNkUqB4BsYRnxqH+ppZ4zXer59mb9qVbu4tCyOO7nays35IYuTKxzmUps/SHSOd2gLu62ni08sleUgNCCzrUsnf8/kmJgbYQD5maX5oLeBzTTSBiNgmYKzkd81y/LmHogf8b+5c6228S7kBFw925GmTy0PLH0wcCX+QncpK2eXmm11LVicZQ/BL3tXdfnq0w2afxu2it90jZFQ0OgEQ8JJAoNQy7ADmY1Ja7+
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(82740400003)(36860700001)(7636003)(8936002)(26005)(82310400003)(4326008)(2616005)(110136005)(2906002)(36756003)(47076005)(86362001)(16576012)(316002)(31696002)(53546011)(426003)(478600001)(8676002)(31686004)(16526019)(70206006)(336012)(4744005)(5660300002)(70586007)(7416002)(186003)(356005)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 23:33:12.4496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7c0cef-1de2-491d-10de-08d92c681d1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1124
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/10/21 6:16 PM, Bjorn Helgaas wrote:
>> Triggering SBR would leave the device inoperable for the current
>> system boot. It requires a system hard-reboot to get the GPU device
>> back to normal operating condition post-SBR. For the affected
>> devices, enable NO_BUS_RESET quirk to fix the issue.
>>
>> This issue will be fixed in the next generation of hardware.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> This patch doesn't seem to have any dependencies or particular
> connection to the rest of the reset series, so I applied this patch by
> itself to for-linus for v5.13 and marked it for stable.
>
> If that's not right, let me know.
>

Yes, you're right this patch no dependency on reset method series.

