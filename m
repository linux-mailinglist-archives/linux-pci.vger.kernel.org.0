Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1D3B34A8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFXRXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 13:23:17 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:47539
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229573AbhFXRXQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 13:23:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7ukIQhqhXhLYaFsu9Hw5Fm/YxKLt0j2BEBGIp/VzzD9dJs/vLf5EWpx/E2/Uw1lshxhQmDPa8PshoARjn684GO86KqK0/CFlFksH+0W0olM7M9tYP/w8nc+vXAXCBPgCTMUPMl4in43V6VX10sxqfeVmd3CgfipXCP+PCCPI9Q8WXSMqGHXD4Ms2mVKdbph+RwKeHxw8Hdd+xXGD2lWOpWXCthO2b/L5G4xzzfGf7LO3W2NvzNR8fd1BLvXPRSVvKEjlrdmewr4AnuNsSGa4IjJZ6leGekB/YzdNRtPr5PAQ/GNa3S04LIFqtjxPrUjSV5m7f6yR4yM1U3sf1LGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIT0a63A3Je0pvZyvVZObOmkFpOYGdDhMiPj18uJ7Xk=;
 b=KVBh8uHjHg3LqejbbxaBs3rKH0TVD8l3kBDr2Sf6P48oY0xC/sAryvjPfZdyzsc7xVLOrIYBLA3dQcSviMUrAEgdHKRFcJL3JXuYkkvQzAaEJIlAcS45kHkNcIKXebfS0oBC3yKwR+SBUDVpZocB+q6dB9ZjH9t9F/xgKbqu7fpiFgI4sBH+9ug3rZpxlnx98tEHBA/tzLcNQZJfyGSyP4WJibqSyrgnS2pc7/FWYD1KfzAnQMdCaIBfoec45WLVHnR3zHOoVyV7hBlo/eWLligFiHunNjGjc+6qW3AYzWUpTof8I702oInS2NQEy6WLCqKkOWTWbeyTEMWqJibhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIT0a63A3Je0pvZyvVZObOmkFpOYGdDhMiPj18uJ7Xk=;
 b=jh9k30W4YJkjWzwGdGuKnfZwsWURr9JElOIw00zknRFPeGRXMC4PEIvvSjfJhO1w3bU4xiZAfTjzrpTItLJOuYLFGbW0S+ejus1cBKwK7w0JXFEqhTgoChNVeOsJkXi8M9yL32OzIF0Qu8y9HvthZqkyIakjIiHTqFtLP2n3Iw4jjWDipT3zOKv4zTU569pi/v6ozvAd2Bdw0IWrAjMV8gxGkcQ4A2l2lM1Ick/sG2ecj46jhqRkk71juiMrlh1rh9jD5nX70tI4OZf1aYWAbtor0j4CWxIWqC46w4tTuUeY01RuxAJIk+5Ite6g15DaMO7DMh8EKSWEWbq5g7+4MA==
Received: from BN6PR1101CA0012.namprd11.prod.outlook.com
 (2603:10b6:405:4a::22) by DM5PR1201MB0139.namprd12.prod.outlook.com
 (2603:10b6:4:4e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 17:20:56 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::f4) by BN6PR1101CA0012.outlook.office365.com
 (2603:10b6:405:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23 via Frontend
 Transport; Thu, 24 Jun 2021 17:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 17:20:55 +0000
Received: from [10.20.112.135] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Jun
 2021 17:20:53 +0000
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210624165601.GA3535644@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <6659e61c-f9ae-4450-53ab-75b76a9f3c5e@nvidia.com>
Date:   Thu, 24 Jun 2021 12:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624165601.GA3535644@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f7115c6-86fb-480c-8410-08d937346d30
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0139:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB013906099FF6A96CC49981E3C7079@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxN09LwyFGRFGa1BrJJIuNsXRX3K8TXA0vrSN6Pk5tYX/uZ2iEFhP6SQyddLPolmN/z1D1+6eqssF8Z5+Y3uN2Un2gDEg3Ni++xyO7QjuaotO3Y8p7XtBBQwABZRwDdLbqJwe5d03p+Ya0GZEnrOnDT3Qh06UIHo5uTQ3pMEbpfZbBCsjS7BIB1Vutu276yjSwrVUJeEfEUL3aIOjEMudV9DlLNDUbnGmq/uwkrKgKo1CTY2bYGX8nQFnVbACzPD5WuopeGMcTfw4FMY11TNXqw33yRvrrWJXsem4vUIcIuKJUHy+/T03C+g/eytwWzN3+IQiC2IQdEX7gt0WmRTpgtPrBR5Bcv54liKidgjjg0tTblsjeRCjLLKY4II87uGfNlmSAOhKjcE0XLHQPIT/iI5HQvNwwr3pppjcWFXDKX8HxOG/YrPmdv8GFfVD3/B1nHIm3Ilbx1aJ3Py7t3gZ/MdW+ltuNS3vg6gzgODkb1Z75utp2ciQBPLetABTZDf5C0J/IZYgOrUv8B7Dq4XfEi2iozhk/+VGtiC0lM9kSDADIjxuilfIbnqMI/FB7fpMPriBu/1+Ba5Z1x8VgeJnSi27ZUX4j9ix8tKLzgRrLouAfB6+QTVn2fVR5kw7i1kPQDdtzGGvHviwEohYrtERqh0PVaQa9VbklM4+3u+gioatZ8kfZfRSb9Uz9XZrtCHKLZrtIK/gvrT0U064DhaMP8oS3CcjxrloSWP75sRoxO22WfIui9f6pb34hj3WXDd
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(54906003)(110136005)(2616005)(426003)(47076005)(478600001)(5660300002)(8936002)(7636003)(36756003)(356005)(82740400003)(31686004)(83380400001)(8676002)(296002)(4326008)(16576012)(186003)(36860700001)(31696002)(7416002)(53546011)(86362001)(2906002)(70586007)(336012)(36906005)(70206006)(82310400003)(16526019)(316002)(26005)(3714002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 17:20:55.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7115c6-86fb-480c-8410-08d937346d30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/21 11:56 AM, Bjorn Helgaas wrote:
> Why does the user have to write all supported methods?  Is that to
> preserve the fact that "cat reset_methods" always shows all the
> supported methods so the user knows what's available?
>
> I'm wondering why we can't do something like this (pidgin code):
>
>   if (option == "default") {
>     pci_init_reset_methods(dev);
>     return;
>   }
>
>   n = 0;
>   foreach method in option {
>     i = lookup_reset_method(method);
>     if (pci_reset_methods[i].reset_fn(dev, PROBE) == 0)
>       dev->reset_methods[n++] = i;           # method i supported
>   }
>   dev->reset_methods[n++] = 0;               # end of supported methods
>
> If we did something like the above, the user could always find the
> list of all methods supported by a device by doing this:
>
>   # echo default > reset_methods
>   # cat reset_methods
>
> Yes, this does call the "probe" methods several times.  I don't think
> that's necessarily a problem.
Agree, I don't think admin/user will change reset methods frequently and no
side effects or performance impacts on probing multiple times.   

We should support enabling partially ordered reset methods and restore
default methods either by re-probing resets or remember supported
resets in pci_dev.

