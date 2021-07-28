Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F993D85C6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 04:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhG1CFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 22:05:45 -0400
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:28636
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234187AbhG1CFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 22:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqHnOzkzjj4enT4Dh2IjCCcVSgpATdcYOPDjjOYTeMzZQf1M6h0lYpP/546Qu7L7bxnYRfI0UN3t6v47zy6gxL6Vln5wfgII9c8dfpgFmvbv6/YxHxl3rwBEbnKDjYW+fSYggRJ9D/M4nag11RQwOaqZENHR7zc2fb1OB4VvJOUs0pdXXbyJ3ljUAwIOowcG5bn6ICWY8Y1lxzbRmZp5PqZF8RGo2hZ70sd3hjCv1K58jfd/AdU2ND9UYBa9eGRITSP72vVYjrV8FZOPhtmFvNXdbyuJDB5MwjNoHRi/ROeMWPHwk19Sr/ruXNaJMl7Lnwupa2PBhZ/jwBJakmovXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ej9oFiKGyXNI/rMgICYfI9ewpqgenwLL9yuwY14ZcM=;
 b=WYbHu8MxWQy7GSj/WKxwXVKvbFz0b4EAGdUEiIiif8XHWj833M1LkNnHybA9DSyBtQdk3hy0MLrBfqaTCk3Iyica0xzMhGR0f7NzzdCnSR/0xMYtaEiF1/n+KkrB8VldNFBIarry3QZgHQKGMMpgxLE+mg70egFg90P51uq41n3Ggg39dXkqZGNVQBNX45kFZu0w370Q1oDBr7CMxcOrJXAoVJjqVSkMdmxAxeaPxkIYwIGdWx9QZHMm8LoodpnpjyvF896YESKMTbjma7bqpW0UziDtGJPCgOhHoR2BR9O5HjNKVeveBUQLuIUD1v46a7AUcrbf/0+R2/liH8LD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ej9oFiKGyXNI/rMgICYfI9ewpqgenwLL9yuwY14ZcM=;
 b=pNR+8XeaGKlW5HZtVw/eYm831eXc1vLnkz7uRyRofcHYvr6Q5+RoJhYJaW/hm4uwVVyWDDQmG0x+AumXupcwN8RFWtXnGtpqUL27RxW1PRyNV3UddW0wlCil7liW1YF3p1HH+j7WnXZ42vi5pi/lcMG/9MNaJp2pyA4ajws4LW0admSArzF+q6Ow4bTP9e8sjU5qiypbnsAOiUrQNdSiFM/yS4QwxpYzQggxrdp1vffr2a1vEf612nfOxubml59lW6fSVsF9keXksmWVJHXGi1+ML8mNWPa2Rh7M2aXbateZG+AFcPfYhvOi5rOleaUsyffBpOYY6NUw+c4YIN4Ltg==
Received: from MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32) by
 BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 02:05:41 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::fc) by MWHPR01CA0046.outlook.office365.com
 (2603:10b6:300:101::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend
 Transport; Wed, 28 Jul 2021 02:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 02:05:40 +0000
Received: from [10.40.204.204] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 02:05:35 +0000
Subject: Re: [PATCH 1/2] PCI: endpoint: pci-epf-test: register notifier if
 only core_init_notifier is enabled
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1627429537-4554-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1627429537-4554-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <ca4291c9-d80a-1c31-797b-2a977199af84@nvidia.com>
Date:   Wed, 28 Jul 2021 07:35:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627429537-4554-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67e3e72-0c15-49ac-2f58-08d9516c3368
X-MS-TrafficTypeDiagnostic: BY5PR12MB5013:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5013A8412DD14D64F26CA375DAEA9@BY5PR12MB5013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eeC7m/ghq9y4cGP053ERb1kjXxJj40DAaESGMZHggIVGKYh+HJbRIV29gp62fqS0aYpdle/T2RPm/zFyS8zEstlFXyKYiDNeZqW4hZ7e8h4JgqCFbNXRPdOYQ50kCTfEHvD5RdWjSymG1kY6Mj5MmgdWd3TW+L5j7LmqeTGqObp0zBCYUx+Izo1wEWePK86u6wHsw4RbEUy4y2eFSgkPKe96c7EX1zNwdmsvm5qMr9C/K9Kp4V+SrKMwdQqwsiOwY7HCATrJOQZUiqLctJRAio3ebiEWV/LJoNGlSaVUVZ0jdLjO2gyQtMTIwiYG39KHPtz+a5+wiMJ3kA0faxRoy4bgWVC0/Q7ml/eu09eMzXlVpSnVlqeVKtJFlkOjtDZHJutNHSfWlreCvhOatGJ2Z0VQxQWCQJEObrcWFxIubUyuUGDqn4OJMPuP2k8UbwBAenhHHzW4rZov744Ktoqeg/s9++flSzKc16iU+ZiH9WWddfiL/+1K0B+Kienz31MonvQlTiYV3b3bxojWiAYGa5UfsaOeylkm48Z/1PtD82ynz47M77/D2+XeWgbLxgaqnqkDqMObbMSMq/Ivotw7ziMom/L9+igr1y0pEHxyX6erLo90K+mrSFHL8qg403mu9WkUJZ4iUHQlHDO4a+0MfY+wgH2YkS7KxWzsA4xOctHcEYXz/Rxa/m3Jz9xIPO8MjjQ78OEvirkTak4JoqzkHoonezxnPDx97X/PyYJsRE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(70586007)(5660300002)(82740400003)(16576012)(54906003)(53546011)(36756003)(31686004)(426003)(16526019)(83380400001)(36906005)(110136005)(316002)(4326008)(31696002)(86362001)(70206006)(2616005)(8676002)(4744005)(2906002)(82310400003)(478600001)(7416002)(6666004)(26005)(356005)(47076005)(8936002)(336012)(7636003)(186003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 02:05:40.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67e3e72-0c15-49ac-2f58-08d9516c3368
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Acked-by: Om Prakash Singh <omp@nvidia.com>


On 7/28/2021 5:15 AM, Kunihiko Hayashi wrote:
> External email: Use caution opening links or attachments
> 
> 
> Need to register pci_epf_test_notifier function even if only
> core_init_notifier is enabled.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d2708ca..73833a4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -864,7 +864,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>          if (ret)
>                  epf_test->dma_supported = false;
> 
> -       if (linkup_notifier) {
> +       if (linkup_notifier || core_init_notifier) {
>                  epf->nb.notifier_call = pci_epf_test_notifier;
>                  pci_epc_register_notifier(epc, &epf->nb);
>          } else {
> --
> 2.7.4
> 
