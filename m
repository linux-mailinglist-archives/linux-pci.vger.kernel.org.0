Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9E37F498
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhEMJAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 05:00:24 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:10977
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232332AbhEMI7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 04:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABMR82ry4g86JUH4aPiveY0MrZrPm10D7YCd745paMwJP2LUrdAQyXG52Q88pZKPJzTM/zLEEGaMfybrJN6USoRU7/gTwoQeYhu2LdJ5Zab+KNyN226Dfx/3ry8krS9ehOArOmBFDLKh06BBR846ZR3miFZS9lVXHS2L523migtnqWNKIUfNW78LUoqT01g+iWESKsfT0oReQe2UFd/pDzgXjsD/xnSxaZBkmdOJGawKeuAmKsd8ePHFmhRY9gYXRPknoprWf77Vpia9VdZtbs3Gwg1RQn6p0Gbvu878iCoiSwQ+Bc1ckOJUU+zDAHmApQCscxXqKTPL0RdOABRNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdJCSry0Xkb2IpmcHmWqk7Lho9topd+p5C/1Zeb2WSg=;
 b=D4UeCKI1oYYWx4fyVfJLqpO/0Qyo7Hl93EA+HsWyRyIEFZkIl7I1xlgfBPnnF6BgLBSYv/feixbsH4QYodIWuho6BmNChkrefqjisMkQtPbZMCjWEtSBCrYWJmmK3R5dqR3WrsgpBY+rJX3IARtXt10k5H6u9YAJVBfda3d+tS7U+wFtfDbjiNZasrRA1CxJwexL/fNHUIBKaAkiPMv/GJi2y9EkGWXW3WUpnwOgV9aoY8KTz2FkBhukb/K3ojhiVL33W5fQFQ/AJ1zD24PRfDag/aSkZnm2xBjeTrE1rj9mvNrMz9hx/9FbdWBSQkaTH8F3DnwTAbyg4tw4K0lxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdJCSry0Xkb2IpmcHmWqk7Lho9topd+p5C/1Zeb2WSg=;
 b=fnKV61dO1mGHKV6JB3VcHgZzHiKGWZlW8Ay6CTxCiApgQuwXGVhvjkRoF6ezEM3guvMWipJrloLXpjQaBKimKvkFViKGg/Kz6TZyEdagf8KCghGjl+ul05DZ4T8cIvOtBErSA5qQ93EOsgmVGiyWvUktmGXJHd3KftuRZRKuXnorF5KpM/qwjDxXKVRd4R38ER+jsYEqK60SBW5oUCvP3EtOGQY1KiVAuSLWXTAMrXodmDOPw4DFHAICLcLSTdb/o7RaLXUtd4bofTo/bz1cngtvgBL6N3sjArPgSuW08noNWdN5oPa1CgiQ7VRMRsyq/D/r/sR7VV8vXI+dImnNCg==
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by BN6PR1201MB0146.namprd12.prod.outlook.com (2603:10b6:405:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 13 May
 2021 08:58:38 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ba) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 08:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 08:58:38 +0000
Received: from [10.25.74.214] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 13 May
 2021 08:58:35 +0000
Subject: Re: [PATCH -next] PCI: tegra: Add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, <thierry.reding@gmail.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <241d64eb-44e4-a838-a07a-8127c189a1c1@nvidia.com>
Date:   Thu, 13 May 2021 14:28:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfac91a3-78a1-402f-0c98-08d915ed4c9b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0146:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014610B0CD1589B9956D014EB8519@BN6PR1201MB0146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzqQQIR1UDtq399FoxXq2qhlTLat9burzVUInRNCNI2fQDPeUN5hqWo+wr4YhvMGamWiiSwUqYZG/j6JhyG16vH+yoCV+YRGJp5Ww3w6CbLkHf2u9crW4GVEPAi/qWOSLEXN/Mg4c2iPc73TdvItWuVelxd/MXhoZy4b2UQA+SAGX4avFnPjdACAntkNbsN+QB0T4FThuqCjqVsfHauDa+eAsCaneUITxeXC4REVz7F43gdizA0xQgZo0VtUsrQoIHQ842cku6uzM9g9CwAFWnn0GctzoSKGaSqktGz/+enq+FndR3D20g5ZQLpOvBDiCcueookpiZddM3e/SYyEGdxD1db0bIB0NLnQdp9FWvInknu7CSAf5Xvt8Cl5n9JOQ+RcHgx2F81bACYEMoU0U1HlIcGS07nn7jbG1lkmyYj7VWtGboqDGTUEgygJC8io7v1JJ6WlnJT6mXrKr5LAQR4NCrqJu/sfpbQ4qY0cd06s+fVyRPZnrlwgzOIDshW21c6IT6IwoMdt4GVZzPsFOiF/CHIVuiI4Cs3TmEGZ9egxxAg/ONSSyWqnaw7Deg6dECe83scE2XVpMchckygohQe070wCwvBiKnlbC/NERK/y71ndMEhw2fU06v3D15JtZ5hi0Y9rdEiVYCunPm6rf0VeOlYlC5Q39HVokHRbDJ5ehgDhxT3BHdOhkWukOi9u
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(36840700001)(53546011)(47076005)(26005)(8936002)(36860700001)(110136005)(70206006)(2616005)(2906002)(70586007)(54906003)(356005)(82740400003)(426003)(86362001)(36756003)(16526019)(186003)(16576012)(478600001)(36906005)(5660300002)(336012)(4326008)(8676002)(7636003)(31696002)(82310400003)(316002)(6636002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 08:58:38.5198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac91a3-78a1-402f-0c98-08d915ed4c9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0146
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patch.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 5/12/2021 9:37 AM, Zou Wei wrote:
> External email: Use caution opening links or attachments
> 
> 
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   drivers/pci/controller/pci-tegra.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 8069bd9..c979229 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2539,6 +2539,7 @@ static const struct of_device_id tegra_pcie_of_match[] = {
>          { .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie },
>          { },
>   };
> +MODULE_DEVICE_TABLE(of, tegra_pcie_of_match);
> 
>   static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
>   {
> --
> 2.6.2
> 
