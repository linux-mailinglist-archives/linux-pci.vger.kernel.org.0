Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E23A34A6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJURL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:17:11 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:21505
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhFJURL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 16:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVbPRjFcxNB4th9jO81+9xkj45yWKVvzMyeOilZfm+eVZwZRb8lMVs8wrh+IXZxH635Wo+I596kJ2+4UgUNYhOBuEki3ribKcl8qTDxZLxme0qZjRr/8Np35Kg1mJMWFg12D7c9gPbZqR0GMaI/h82EcK7OVeqMNHiGjwQM1TQ+bXc+7lP4uNEm5C1ekymG8+VTEL1VtDriDt1vzQDubm5/B9qvnmC9Xf7WKnyLi1Mb9lM+YZNjABtpI8mlzxqom2WQSXEQObT++Rc6c9Lik855855LJpGMMgUBQP9lDNGASEqLtjTCX2osHFBxQbi5FhlWSFmE4Kzw2MWlCICWNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1nBRBOMALqFhBbkWSFGVj29MhBmNcrnb+3JSocW69s=;
 b=B4WCsPPOkIoyANqB0OmgTPF6stmeMHZf8CiCoe17mGeiJGM/ZfxQOD03go0o4iORCG7TCjs48Vmk8tS5mPhGRD9HPxCNn+ueiBt9B4XqRoMkuXciKsdVu5IRFgyYHO8bMKouInOEdgUmbdhwvKCWaUuYdLgRCxibY4ehYA8dSZ6cPzkgj0ppKoeacI05SfuZfckIrjtNDnO32I3E8vbDzrSayqLyZ/0PNyXkbnxNA/LRJrk5tp+SOZbjwKADeMi/eWfmu4ZnXgYP+Eq54Sk4jQIUBFs/YxOd0NDrnBFcZOgqgu5RHjwGm9BTJstS3hb7veJjngAnbsgTa9aJ3HEn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1nBRBOMALqFhBbkWSFGVj29MhBmNcrnb+3JSocW69s=;
 b=W3temR3kZLMJRIIoH5eQ63kwGYZ6ZBpjq7lchi5hJuG7VJfjXEMSiHyfIsxkvcs+jeFIpcuwQfRsJct9ppzcs67AGPp+6AODfHvShsMm05EI9GJyKkRv6hM0JwTZQsRmA8HOjMbnR/tc1CxjXjDCRJ6+wj8UiwqmGs0cDZ4O+Lppk0Re0ZJH21jkYWuYstvjvAqZENrwu6jk/+TnKbmhsuMHkTrCvvJkE1IF4a7LEsTxJ4nypfMoIlVuLAwA8jDFhedWINGHH2BIi3ESKXJngdgD+DBOxTmlA9ob6qmaef4ufSwJc+PzDvOQvovdamxRMOFnwXvn9KXo+53qEkhWEg==
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by MN2PR12MB3709.namprd12.prod.outlook.com (2603:10b6:208:167::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 20:15:13 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::28) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 20:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 20:15:13 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 20:15:09 +0000
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-2-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <17b12772-a636-9255-7d9b-a89139582b60@nvidia.com>
Date:   Thu, 10 Jun 2021 15:15:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608054857.18963-2-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd727172-426d-4c6b-a431-08d92c4c7489
X-MS-TrafficTypeDiagnostic: MN2PR12MB3709:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37096285D88B7DBF837AA932C7359@MN2PR12MB3709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ks4KcqmdfgiPGw9iya8LN6lb9Iayg0yZBJcxsdTxjPoCiZBfVWoZ9aHtUHqN9d8ksR7EZ7V0q4P8uvMe2LhdLduaoFtXbRWrI8R+PegXd8yJT8Wg9xw11XQpE8UZFT9NwNhbpNguQOe/5UKx+f76HJRijc+5WFfkThCQcbxfc4YO6FU7rESmmijPkg7FTZoOocxuYSaakDs93WAe8UkwFFXTPlplbhvDBlVuneH8nHWIp/Aa10SrqNyOnBoxsb8V51EPtiWoL8KdklX00049CxnSOsaK49k8R9KJGdulyHtsUVHi0R+InSZwfYCuTc6LDljQ3sxgN1PTf/bAIvu3MPeWERnFYJkxZVhp4qY/OdhH5Q7512oN+WjpNY8C0o1HvlkRN2usXlrJbdic8SVmfwGHWmsonDvk+1J2K1Fmae3x6n+pFAy427CINBg78MtbnZP0Pc6WIw90qiWmE7/NmrP63uwNr7NB2KZDCep5JqPFLnHIegoIXLkZ8EZ/JeKbcYKO8iZKcXSFR3lDRyMLQFtnwkV7ihumvDaoCrGw+nP2DoL3uwZIRUjCsuc7W7SL8mFCJ9xrK9SGkwNHiEc6uK0hvG1bqU0x7iDPnqgUH1a/FuoB/SWpzJSJUbiYGvh+sm8m1mQz59zX+1fa7AZYED5xSHwT/gTPA486Io6mM9Jewim+8/CoBg8SXAzxrf6q
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(53546011)(4326008)(31696002)(2906002)(36860700001)(7416002)(36756003)(82740400003)(186003)(31686004)(86362001)(356005)(2616005)(16526019)(5660300002)(8936002)(8676002)(7636003)(70206006)(296002)(47076005)(16576012)(316002)(36906005)(70586007)(478600001)(110136005)(336012)(426003)(26005)(54906003)(4744005)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 20:15:13.1121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd727172-426d-4c6b-a431-08d92c4c7489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/21 12:48 AM, Amey Narkhede wrote:
> Currently there is separate function pcie_has_flr() to probe if pcie flr is
> supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not.  Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
