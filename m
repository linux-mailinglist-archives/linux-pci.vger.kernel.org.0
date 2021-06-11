Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA423A3ACA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 06:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhFKERV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 00:17:21 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:62817
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229562AbhFKERU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 00:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL21axWwXbmIY8q07BdWxhtZY3MfkNd6ybUN/yzG79YUAds34xTMz9VOqOVNT7QfViXofx1Kag2vJ+4+TKqdoJ/yfuDglWKXJvs9Ht/sI9nubrDvU7HCSJiO/4q864fGuhMpIy7WJKmLqiJJgC5kq2D4d4opaToFM4v3wmfUTBuo9jekCpWXdRXe07jcOmbIw2rJO1QVXimqmEE0P6kYWt1a+7ySpXJ5Fa8491FYI8fRgx2dMPEBXOwIH+gjB1JX8b7d7AfzFBtot0W3E/jbtCBScZocHbYulEP0OwAD5iDieVJy7CGJzRQ11tONL5hDQsbgA/bnGnmYNhzbPHod6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jBon8kfUMNtnzY7TnD3AdpQdWYAfvX+g4lFug6PeY0=;
 b=GjRrzXwSs6NCMEjZO/tYlQpiG/0BX6VVDhs05oC7YR5heYPssoMPCX+NWnmpcOH59+8vodd0FW4ZOb1nLbK8goxnz/YrE98M96Y6MsYDXSzDdbOSI9/f5KbuD4lNnrgUEe6Y4NJlFlF2/bBubGNZdRj6+E0epFwXnKklzDAvi0idFeDZav7ImDT5Cun1/yCIthH9qbe1IrsQa9bilnpx1Zrt87zsIeijDzaLAYERD3oPv5IjdtlQ0LCw+0Vwu0V6E+NNVOc0tCXJUh4Rsi8+czXwlmTr2bfmK9npbLQtquSWEJRO/GG+HTACYOZcurdWYPwXPJYnJPK3ZgyKNlyqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jBon8kfUMNtnzY7TnD3AdpQdWYAfvX+g4lFug6PeY0=;
 b=cIMEFkECcp9Uk2zEFIaF6drxlO4Wb/JD5vrMvYXOzDrsQ+GvuLTwDwGbnoTlIobAr57ofM4LY4hNqTyL9iOnZJDhJKco7akdJAHfAOeCJkcMpLjFIJeyFUeIbktQMsWXPczZYiHR7syMRxQ9064KEIezq459SFnne8W6GZgsoi4E0utNg2jDzix5O+xGivILjWWK10BjpjXOtgR/uTprXhfR5CAnM6HECx1+nhZy5t25V9vC4H4XiISjch5arm3ju/UHxWGvmJYK4lXG6JleTr6bHiEGV+5q04hjVxGKUBD2PecXEKWtRrZt3Ga10kyYCfFTfynf5rqnZr7Ehdf0DQ==
Received: from DM3PR11CA0001.namprd11.prod.outlook.com (2603:10b6:0:54::11) by
 SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Fri, 11 Jun 2021 04:15:21 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::3a) by DM3PR11CA0001.outlook.office365.com
 (2603:10b6:0:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 04:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 04:15:21 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Jun
 2021 04:15:19 +0000
Subject: Re: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210610235319.GA2796526@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <e5dc115d-2c7f-80ff-f217-071d48c8bd1e@nvidia.com>
Date:   Thu, 10 Jun 2021 23:15:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210610235319.GA2796526@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24fdb1c7-5ac2-4f06-05a4-08d92c8f87a7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2431A6674AA4892206552F07C7349@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt9yxbRxVwqfb7c0Zq9t9CGc81BjK2J9R69MT6hqvf1MHPPW2JoOeMFWrWhcICA2NwUacAwehnpsBEApeaUAp10yZmpOzMeuBhIDT+BTWWOiUQj9UAsCrDwS1LgnVLGJn7uH3kXb2hLgBH0IhNImb66/8dEhdeirKGbtzeB35vw4GUicmQC4RW9lPfZp5JZio3QBC9r6puRQq8cKXSoiMBOu/L2HL2uVVKfG2hhKlG+cX7Z6C5xk1mB8wRX2kmZpFw+Gnl8cLNrb29H2lLnf8vGYBrjFCahERnUD4AG+9LzmfGaEyzv8hwsf8YZjEJ24pDkmEJwtBdvqESydU1oCLU2iU8OfSfphRffsGxl6wTzk5DnDcwF8796BtQXOiPgC36+4FsSvYyRpfFIZMtVJAw/JM9HUbeEu7smMlhEZDVVRViLQw9KnZb9fVc79EiYGq8uMgmXgg2QWkph8mt3hH78ncpExbRD4KxgErWeyMR5j+8fB5tDJz1yEbUQ3GyredsOrO56eXNhlCcS2OVxaGkKp9uxjEvdPXgWOuRFtyl+F/acYtfrXDJ5/RiFBgMmxRC0pZO48PpXrLqCj6BkQpANei0zSDQ+IifHaQ+Xf+0ROdqrFgY8Sbj3nRxoHJBvHtFgC1bsagBfMjKxJJaiBLoYtZiFMYf8VTra6D6zYXOSBXX1SthQXGA7U+shhD2Vq
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(31696002)(7416002)(8936002)(186003)(4326008)(336012)(47076005)(36756003)(26005)(53546011)(8676002)(86362001)(16526019)(36860700001)(82740400003)(2906002)(16576012)(316002)(4744005)(70206006)(356005)(478600001)(54906003)(2616005)(31686004)(6916009)(82310400003)(70586007)(7636003)(36906005)(5660300002)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 04:15:21.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fdb1c7-5ac2-4f06-05a4-08d92c8f87a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/10/21 6:53 PM, Bjorn Helgaas wrote:
> It sounds like there is no actual dependency on the platform.  So even
> though these GPUs are only available on certain platforms, if one were
> to move one of them to a different, non-supported platform, SBR would
> still not work.
>
> So I think I'll remove the reference to "select platforms" since it
> doesn't add any useful information and might suggest that SBR should
> work on some platforms, if you could only find the right ones.

Appreciate your time on code review, providing better text, and picking patch
for v5.14. Please let us know if any code improvements or suggestions for the
remaining reset patch series to be considered for v5.14
 

