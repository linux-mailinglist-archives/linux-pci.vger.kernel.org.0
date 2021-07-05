Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B43BC1FD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGEREH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 13:04:07 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:45696
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229880AbhGEREG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jul 2021 13:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAclg/tCOk9BLji8wmL7hjiSRM3wu0rbndOb7xqGlIGSS7XggeFrQDAIoL8gBpgJdHgfiejycIG0bijHsnLW6SPrgOqi1rcKmlrZG3um9CZwEEtuygaZt9JfxjYkkcw04oroukQ2Ac/t5u5jNcBOqQzv2WYbtpPOswqqhUT7clplLkyz3M7EXZDzXP55RT9RYBQ0pBO5jyVmrMLYiG1Nrp+nD08isWbLQSqRqAhzTN0nMTX3e7EnpejXU9UiqzN4a37aY4+/hJjBIRcg6Oj2ZpXZF8QgTn4L2aw07foxbxL0/5nfyUbq5iCWiK7RK2Ka6nif1LLHtaXRetVcAiSs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqPUGSuwLk0H4W2uEEX8huiyjNBTnSry0ZFveMVS4G4=;
 b=XW9GQMImgQ3KrB0b5/PUsZGG60QpQozKYYV3yPeAi3Dov43qg5RD4ipcxJsS7B8mer9BAcR2GAwF3mXsis1juyK3FZ6hQNsvumhz6XTrHMnrrI6MBW1yQkwmen3UUWiZyodC4GLZzEOpEgnTKDuHRrusf5EqQve36GrKNHZhJ5WCVM0pbRk6HCI0vZnav5gU2LI6xgNn/H7laJT/jVylkq9u5OGI0zinQQ5RiLuiQjbf1KlTyGT1Y01E6aGz/6u1Agi56EMfAyr/s2oWpgx5vxfmscjgxI0SbSd+bjOCMQnMGf9lC+OggxhyZrWBhZo5AqS2TYMCo8jB5Ws7PeDDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqPUGSuwLk0H4W2uEEX8huiyjNBTnSry0ZFveMVS4G4=;
 b=Hri5M9H6aJa8vSKXgxn1TqQDOqxPS79nGmQbdCCI453x6RU22nZYx6/lcIK1R7v2ti3NH2qEj+ZIdplPWP4SXNQ/t8SPwjKHv+0HX0Vdo0desVmNKRW5XaqyFxmTmMldkY0Md6E2shNogoe6KCs2WBC6K7Xm8IexFwDKOpwbzYJquWTELHSZ82fTTn86MLctwLrZVKRP9wt5xvymFN6x7v5k5CYzCxAkVekyxwQwvw4bJtDOlRfnby6Nr64LTlHDk5XYNZfBnFcFNDzdWMq6IPw5VaN4Izudbyc7EnuV0quOlfNdlKhfFGIf3gZi0RGMww4UDKvU4HeJIquGdVg5oQ==
Received: from MWHPR20CA0030.namprd20.prod.outlook.com (2603:10b6:300:ed::16)
 by CY4PR1201MB2487.namprd12.prod.outlook.com (2603:10b6:903:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Mon, 5 Jul
 2021 17:01:27 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::40) by MWHPR20CA0030.outlook.office365.com
 (2603:10b6:300:ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Mon, 5 Jul 2021 17:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 17:01:27 +0000
Received: from [10.25.102.231] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Jul
 2021 17:01:24 +0000
Subject: Re: [PATCH 3/3] PCI: tegra: make const array err_msg static
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <thierry.reding@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
 <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <24d4b0f2-d8bb-c730-4c37-a8a7c4e07a08@nvidia.com>
Date:   Mon, 5 Jul 2021 22:31:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9222dd72-fb44-4ece-500a-08d93fd68738
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2487:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2487C6965133CBC4909F9C15B81C9@CY4PR1201MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1V4B/Bs+87S/GDrJDrYRpgME+NQEakLpLKZX79mOiGuO6/oQJ94HPmskdL+yZ/Yo9rEswK+farithlYM7/hnoZXwJ63Pc2u17dgfIZ0dPHUaT40U1F4gfoSAFrFEyF0utrp7JlgZCxDh/3xA8T0UQayqdfNJ8vPhag5KWX3xsIvH0cYFJbBif41CjQzq+IgFPAt0QgkshF/yOkbG6/Zosj6mgJoqThorfi9TmOQtW0sRQsUf+E4Taxhp2mUQVrXE8exumbtd/oGG47uYh0CdUSSxzKSK4bAFy2uHZWm/+vstM4g0edGirRiHbw2lGXxlQ7SjnCuu4hQvS2+QPNCfTkksb5epJ0w3gd1YNxdeE5FuZ09zwOfxM/IhGU3NDlH5muC3t8twaWfJlULX6qFNwMOgwTGYHYDofeyK5QGGeDt7TReYC3ESeQpS4/GWk2Wl1j2Foa96JDMs534/m6x32Ck/cmn4/JRXeqK4XqbINUbNH5VzzMHJevANDBRSjCS1U1MbyUqAqrDWnpWkV/R7khFbnbdmSQmZUJpU6Oymf/k7lj3nsbn6gKGqtH6pCyXrEgKINkuGe9vnDmu45WaSa5zOYgTxqHjzc5nDnSf5cb0yPBwyd9qkgH5JWA6vKAHk4b8ClsmHgFe4SS4VG4K2DXo0UmDXuC85fKC1VH2Rh11qSULAxRKf2PnrrR68k2UWuP5zcgH1GgYStWfM1g/tGoA1QlWF1BTHHoExb58GYE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(186003)(31686004)(83380400001)(36860700001)(316002)(478600001)(70586007)(47076005)(26005)(82310400003)(6636002)(5660300002)(70206006)(2906002)(36906005)(16526019)(36756003)(336012)(82740400003)(7636003)(356005)(16576012)(2616005)(31696002)(8676002)(86362001)(110136005)(426003)(53546011)(4326008)(54906003)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 17:01:27.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9222dd72-fb44-4ece-500a-08d93fd68738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2487
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 5/4/2021 10:48 PM, Christophe JAILLET wrote:
> Don't populate the array err_msg on the stack but instead make it
> static. Makes the object code smaller by 64 bytes.
> 
> While at it, add a missing const, as reported by checkpatch.
> 
> Compiled with gcc 11.0.1
> 
> Before:
> $ size drivers/pci/controller/pci-tegra.o
>     text	   data	    bss	    dec	    hex	filename
>    25623	   2844	     32	  28499	   6f53	drivers/pci/controller/pci-tegra.o
> 
> After:
> $ size drivers/pci/controller/pci-tegra.o
>     text	   data	    bss	    dec	    hex	filename
>    25559	   2844	     32	  28435	   6f13	drivers/pci/controller/pci-tegra.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/pci/controller/pci-tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index fe8e21ce3e3d..b1250b15d290 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -764,7 +764,7 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>   
>   static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>   {
> -	const char *err_msg[] = {
> +	static const char * const err_msg[] = {
>   		"Unknown",
>   		"AXI slave error",
>   		"AXI decode error",
> 
