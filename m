Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5443E04C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1L5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 07:57:06 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:54497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhJ1L5F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 07:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbPE+GYkGBltk824lcduFeK0rO4IX+FEZ2u1QUm96R8mA7ZP3EKFNNdd3TGm7gEo9Pf4hbSZM/M3RpCnVew8hXT0/CrQ6h5E2m8E3g7AYKD7bBkK8bf9kB4y9VcdK3U3QN33qF+E+iBa2/pi9FtXnLV9I/I69ofreKdWPDqy2+alImfXc4pdJvDeiZi8yR4NowP6x1Ojrv0Uk8DjrjC9JgMEi+kDUXBstzrjqhIYMrp1G8rN3aQoToMEdeialhac98t4VS5zFn+7ETgBzDBUAlEtzCDfbEz4xvl6creA6opOn9ZX00p4UBFcdQX+D4VuILoKZ/v/NBzGK2O16acpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s363zIfcY0ubKIH8g1/Lh5zYPiP1/GxWrz6PYqgMlY0=;
 b=XyXPMNake839d+W3NM7miJYjY2pmMLJAm/cKPOvkZjANRWY7TsdSuhunGEpwtEWvE3xwt3n0m5VF8zr1s0fsYNai0k1sAqLeLS09dvyWHRwGb+hGcU9l9UuUwV8hEenQXO0WKpd64kqIimQsHQHL2dQad6jJywdtnkbAMozm6aYfoqWf63UJMqFjjOAjewqCItIVYjAKSGlf50tevr42Iwzql6uRUYF/afPxNpV2vawF1TAEpBRvDo3d9ElwGR2GI7Al15UZZnu6N6J/wey+DT5QfUty69gMWbKI1Wc8uQJvh6Z1Ltm5XYsZ0SwNo7BSlsS0LNe43pH5XXFwU+3A5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s363zIfcY0ubKIH8g1/Lh5zYPiP1/GxWrz6PYqgMlY0=;
 b=gteQzvKrEmbBUuvQoHPF8fmXytDhRxAYJpt3E878DgyPN2bc9/aWUyFDCF22VlSPrhoMAF/KPq1LScpTdR9RbLu6xD5I0eoYsDsybkKf7G7SdMozyVUt4aD2uYAuEzgQHIUQNluiOB3hLUYNpTG5bPftUhO8xfPXNKPBMX4wbYKpJk89URKVks+KyHLXZ4i9aFg16ykbRKy1m/Mu5L+C/mqFOKAg6YUzMNiAoxBUVHO5A712TMnNckUyTwpD/fWZjSJDFTssj7SWOVFj95PAtNWI4cOZhJmuUIyhYXhtODFE8lyH2ncIvKqC4YI3vZWdo6mheGKJjMQhxGq5bI77mA==
Received: from CO1PR15CA0055.namprd15.prod.outlook.com (2603:10b6:101:1f::23)
 by CY4PR12MB1927.namprd12.prod.outlook.com (2603:10b6:903:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 11:54:35 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::60) by CO1PR15CA0055.outlook.office365.com
 (2603:10b6:101:1f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 11:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 11:54:34 +0000
Received: from [10.26.49.14] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 11:54:30 +0000
Subject: Re: [PATCH 2/5] reset: tegra-bpmp: Handle errors in BPMP response
To:     Mikko Perttunen <mperttunen@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <thierry.reding@gmail.com>,
        <krzysztof.kozlowski@canonical.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <p.zabel@pengutronix.de>,
        <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-2-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <397003f8-bf3c-68a4-828c-1254710f714b@nvidia.com>
Date:   Thu, 28 Oct 2021 12:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915085517.1669675-2-mperttunen@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f2ee112-6370-4d02-4350-08d99a09b62e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1927:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1927C7B8214D5897AF6A92BDD9869@CY4PR12MB1927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4jI/hcokdqlJqa5m4cyhk+jLf6tG0jDnCllC21uHNEPie1j5hRsRKJdMC274SZDfPYb/5w9Wh2m6yEby8VuVws1Kf4HJWHz4OqfprGhuE/yotrSz8nc83SvhzC908IPbf2rDXm/JiT6EjGLzB/r6ICaizzG0d2/r7epc1rCIsvHBpcGmEbcyC8tZHOD1TCSvfxxt7fgPWUX+KNwtcI9y64Ig7r8HH+noeQUEH8EiZ+BF1hBdcIaYGuxdCvO36Ir3iIoEYHCoknPbEK9E62UmVXxBp9kXg8G6xrdcF/D5s/xmvaW6gxt44i/yYaVRBAqGCngNUNQtcli8xQyKAWMjLeHmueFzSqcHfPBmmSoQaKy9Zhd54R1UK0O8LioiB/U7eOW/hOJSc/cjrf7ANT0TQdw8G8nfYdtEe+IALqQdziagHBFx3fNnOMCS+2T4cElLpdIvOO7dJDo/HxmPD56kDAkiDOHWkvZyfolq8OhBPgtCq+iVk5B05CcKbF5bkrWY7dUmgUJiWtqM4inGHpndnpnObz8yi6v6zwyvbP6SX92nSjstLoxeAJUtOJUl92Pr7f7IzvYFMSVFg7mmNXKyRtVnL0YI4g52Q0hQFn7YXyvDMnZqZiMCkb/9/jb/DWv/reHveaJ/T9i0Py/E2YAGfluNHODYKAZqob3m8IhkA3OCUwJgiLCZG2lnCm1rambyvLo14nfk8rlYzqnbCHdNJfIs/1n4uiWCpR0Ktm8wqJFFR2hUDsCdHqFsyMrcpGo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(47076005)(316002)(7416002)(31696002)(36860700001)(70206006)(82310400003)(4326008)(2906002)(86362001)(8936002)(7636003)(16576012)(70586007)(53546011)(36756003)(186003)(508600001)(6666004)(110136005)(2616005)(356005)(31686004)(83380400001)(426003)(921005)(8676002)(16526019)(54906003)(26005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 11:54:34.9445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ee112-6370-4d02-4350-08d99a09b62e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1927
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Philipp,

On 15/09/2021 09:55, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c
> index 24d3395964cc..4c5bba52b105 100644
> --- a/drivers/reset/tegra/reset-bpmp.c
> +++ b/drivers/reset/tegra/reset-bpmp.c
> @@ -20,6 +20,7 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
>   	struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
>   	struct mrq_reset_request request;
>   	struct tegra_bpmp_message msg;
> +	int err;
>   
>   	memset(&request, 0, sizeof(request));
>   	request.cmd = command;
> @@ -30,7 +31,13 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
>   	msg.tx.data = &request;
>   	msg.tx.size = sizeof(request);
>   
> -	return tegra_bpmp_transfer(bpmp, &msg);
> +	err = tegra_bpmp_transfer(bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>   }
>   
>   static int tegra_bpmp_reset_module(struct reset_controller_dev *rstc,
> 


I see that you have pulled this into the mainline for v5.15. 
Unfortunately, this is causing a regression for the Tegra HDA 
controller. We need to fix the Tegra HDA driver but this is too late now 
for v5.15 and so we need to revert this change for v5.15. Sorry about 
this, but I did not expect this to be pulled in so late.

Jon

-- 
nvpublic
