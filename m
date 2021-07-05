Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75CA3BC1F8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhGEREB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 13:04:01 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:32097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhGEREB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jul 2021 13:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxsKmjZezRqTBRgebWP+xicNVh0VPuxFg+1rRCr5qNJbKXhCkWuPVUBV4qzOXkzUfM2yiQ3PBJjoee31O+DmW6Z/SVCGx2swC/Zngw266DEuMyGHYlRcVB6oQNIsteHmIuiWExqbhhOmGj/6N2D1S3fVIv0GqySowG4LPZ1gPGBXdr+eVc3Ctn48UysvzfmqtiBGGNazG5noLHlxSAi0P91cDHjI3ehCWTccb6UopMPMVYdmoSIXCE7Jf4cu5xYGrp/WZqzv5xC5MSVhjVFD3MM23j9EM+pdG/7nmOoyXPopVV9lZlCoDdevUxupekidzI/6OMbO67vLUdlaNchCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+ejE96/M3d0g142zWySia3tkz0u/Fkf/GhiRsLEMg4=;
 b=CrQ236+8ub8bzyRfkR/x1t8uDwRTRpREmJn8S7jzfvXN7EVMdP6yrh0lR2xpJq4p6xB+4eNE5UTjcHnEskQ2kMycFkr+3raPpGevbbSMV9HSC7jAxNpOg6istHFL+jQ/czR4LrQgkw1NxQLKXh51WiRkT5wsWF8GDNsTrdqUZd3OokKUepaQE4N1mLju9kPUWdYmro+nnyoLqC8KnkcmBSKL06rbq6hGde4hLPtkrFyX7J5gynIE0EeWj/poCObc+arAnoK33lUo29t+o+cAnURbqngYyDdkuN7QZk1s2v/Xt7hMJj0tAgn18BFEMYPo+FePXmRdy1TDIrveLaeLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+ejE96/M3d0g142zWySia3tkz0u/Fkf/GhiRsLEMg4=;
 b=V0/7QnA/J8muxHnWwI7KRcEBYzB2RJkLf2m4c/FD8keKDW4F91BKSYY9SifPZtZXu8pw87zUJzZ4Sca+J55W2yHttKWOGwta8kBUJnIy60TUcv6tUKfi1/AYeWQwz+/pOkERsfsSBf4dtnPwQ+/d19gaRTwn8Jc4Ka4Y35mmSOzhUJGOKnp/a8gDCLkeiR9vORLUuhsmCXLZhhDmZmleXw4hAN39na0JzaJy+XYKxwmblXK7jdrgC2uquCMmmJobvATE8j39Cj8CBHBs7fHqgmkExAnUikaVmUVAytEIgaczp4ltxCJUEyNmR0Em0FgNnt+LXqUzq6FQDnXDADct/w==
Received: from MWHPR20CA0044.namprd20.prod.outlook.com (2603:10b6:300:ed::30)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 17:01:22 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::a8) by MWHPR20CA0044.outlook.office365.com
 (2603:10b6:300:ed::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Mon, 5 Jul 2021 17:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 17:01:21 +0000
Received: from [10.25.102.231] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Jul
 2021 17:01:14 +0000
Subject: Re: [PATCH 2/3] PCI: tegra: Use 'seq_puts' instead of 'seq_printf'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <thierry.reding@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
 <7bdedb342b9221169ab085540cf25d1992e8b97a.1620148539.git.christophe.jaillet@wanadoo.fr>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d883403c-abe5-8f98-11eb-a70606040e0a@nvidia.com>
Date:   Mon, 5 Jul 2021 22:31:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7bdedb342b9221169ab085540cf25d1992e8b97a.1620148539.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cbc5b6e-c4f9-418f-e3f0-08d93fd68408
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39767AB4EAD100833C3199C2B81C9@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nm3IiE1CwZoGG9cLeRT8Bsg/bZVHvEmDQduz/vgTk8WlSBQuFx2VVrJeXTN8VdP9Tc68+IlXebPKHZ6gXJd6uEIRpySawNrIQ17dFjbkU4QH3q0+jQTzYI1eFWxY+2BIFIAwop5GsZsfjNKGYS2ul4c2WA0AI6N36b/QtFlNRDP3H4QMlpSgqATEofW+x5JWLV33vJaLRwVPQ54jV2hQSylTcig9rSIo6YHw1Vc9oQ7lI7twnhSAty+mJ4U3AxdeKo4gqcq8uzPRe6K5lqk4NsQp9BZrvleeawpQ42lkge7Dqb5FiJOov+GqVeaNA8Eukw+QQId8doaxf5brOvHFabCVxhEP8jNE1Cusu5uGzcBNA9oC0dVPmEZxo+McZFUfRf5yeMrXyAX6/WdpbgiCfQFqar9WxRkMPyQjR6uO3CWk2Ljm+j9Ogghb2OlxoB8j+VPLn2gmIDjjBYAqCxnsQKVoEqd5PZEgKfxLduHMyWPObM6XmtXHIiMVbov1BGWw6H3yWcP/8UXnOAqkfj0/mmcPQHVDcLQkqL1hNCa/Y35rI8rOx7VvlK01GsrMfTSVLK+UIlT8BOB2mmFT7RzDolVPpmaUXABBeJGgbI2b6UIan46GFDsgCNMW3p2kaRm3WfHzT+2rSgeXxs3WltRv0+Du2CGZndfiK7uyo063/3bssKTiU/MqbgefC2GYt7usDLe5R8yCgW3ZbFU5j8NNl+ZcWoAuw4f60JRH8/Y6fAk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(70586007)(478600001)(70206006)(36756003)(82740400003)(31696002)(5660300002)(36860700001)(26005)(2906002)(82310400003)(53546011)(186003)(16526019)(86362001)(6636002)(31686004)(4326008)(426003)(8676002)(83380400001)(47076005)(36906005)(316002)(16576012)(110136005)(54906003)(336012)(7636003)(2616005)(8936002)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 17:01:21.9262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbc5b6e-c4f9-418f-e3f0-08d93fd68408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 5/4/2021 10:47 PM, Christophe JAILLET wrote:
> As spotted by checkpatch, use 'seq_puts' instead of 'seq_printf' when
> possible.
> It is slightly more efficient.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/pci/controller/pci-tegra.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 006bf0346dec..fe8e21ce3e3d 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2550,7 +2550,7 @@ static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
>   	if (list_empty(&pcie->ports))
>   		return NULL;
>   
> -	seq_printf(s, "Index  Status\n");
> +	seq_puts(s, "Index  Status\n");
>   
>   	return seq_list_start(&pcie->ports, *pos);
>   }
> @@ -2587,16 +2587,16 @@ static int tegra_pcie_ports_seq_show(struct seq_file *s, void *v)
>   	seq_printf(s, "%2u     ", port->index);
>   
>   	if (up)
> -		seq_printf(s, "up");
> +		seq_puts(s, "up");
>   
>   	if (active) {
>   		if (up)
> -			seq_printf(s, ", ");
> +			seq_puts(s, ", ");
>   
> -		seq_printf(s, "active");
> +		seq_puts(s, "active");
>   	}
>   
> -	seq_printf(s, "\n");
> +	seq_puts(s, "\n");
>   	return 0;
>   }
>   
> 
