Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3CC4FBE44
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiDKOGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbiDKOGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 10:06:21 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E5B4D;
        Mon, 11 Apr 2022 07:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA0C2VA7ipRh/HrYs5MY8qz/ZgVOTrvH1lLwnLRBfUkFmRpCXMVwJybjWmfQ9P9mMfdxoJT0aWvLBcgOq1w/a9B3M/VSbnIlrW5F/pTftI57qU49OvzusRjgCfCLIOab1KX+4BUPUl3/aXEl4hSCSXr4l85Sj19AxMIm8Jrmto03U+xLJEhUBI5P8QrAMapmQdk3qet9ZXIh0jZs2HWzKCgYnMxPpuih7jJtG78Mh5hqLs4bkub5sekiFa/jKWezdwuygY2jyK/mOtR07r59A6VW+I6Josp4ZUu19SP77ZTAci23TbCLng+A07P/eWLDukS9wWYnrspgprx31046Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22+56ZrfnAPSZsJ2Cjo0o63ujteEKjifAhhaWHEZ80w=;
 b=TnFw9e15KrJBsKSvZBT8eKpFRrlTfsW1QraCGyPr3M+4kZY0SLpB3LndV+70Xrv/T9iOf2w0COJimpqTORzhBisW8LDbfsGH8MW44s8bpqkPyJgCw4Ha2F9O3ygbAKdCFKM4d0hhbTSgl+jnPHSwUZR8p3RRExDzOnBRx19NJSLpCpRrYuwDbJBsixXDgBSm9xjOk5UhOLYoYcwQRilJwcvrnQPMkGvkW6JQFftGKTIDVht4MuYuace//qzYuAqMV64itrWi21svQ4uvP7DmP8TvZxreZX304RhWi05p7YflU6eIRAPyHab5jXT5b9AguLZsPiSsHGjXcwsFjQ63Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22+56ZrfnAPSZsJ2Cjo0o63ujteEKjifAhhaWHEZ80w=;
 b=aHZgyDDsEzIwmidZYkwOg0l0+93Fi0Aqbkwn66l3XCU8gmvGwPDdi0LLRjEsALOnrSrskHuijWyisbOvkr0pPs5xUiiTbeSs3D8XZefIwIgF9wTRgcgyahxFjvQutUbp//63414zx5NQ8JZ4lIenw3YLaH7JYafjDE+y6FSoXyjYgqsMYxPiH/+GbNYNo0NjfB33rGU7dEps2+KHsxuV4zvm59jsaS6mkp/02lqOOPGqAVJirJZHQQPUGnFTnCPNQ1R2rHwrHUkQtrysL6oOOEkFkhZJxVRfAVclj2HN3rLSS65sjsup3c5p0B1aAycv+O5PnMG5pyDnKiGjKAnNUQ==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 14:04:01 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::28) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 14:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 14:04:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 14:04:00 +0000
Received: from [172.27.1.57] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 07:03:57 -0700
Message-ID: <92621dc1-5b9d-8e5c-acbf-fff3a0ea0fd8@nvidia.com>
Date:   Mon, 11 Apr 2022 17:03:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V7 1/1] Intel Sky Lake-E host root ports check.
Content-Language: en-US
To:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <andrew.maier@eideticom.com>,
        <logang@deltatee.com>, <bhelgaas@google.com>, <jgg@nvidia.com>,
        <helgaas@kernel.org>, Shlomo Pongratz <shlomop@pliops.com>
References: <20220410105213.690-1-shlomop@pliops.com>
 <20220410105213.690-2-shlomop@pliops.com>
From:   Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <20220410105213.690-2-shlomop@pliops.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd38037-4545-4967-c3be-08da1bc4213e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1430EB9CA8EE3D8975B275FCDEEA9@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqK3sH0D+fNuTh552VcqBPKC410Q8Q8Zocw+pbR3vPtB102wSVo4qW377NkS4BiUk1NUNhelqUZcECULgZuzAYijLI75nMv+/UAXrT6EdtPNUz0UGmtvTzFASEIMm8ZvQZVrJcUyBCH6G9tVtkhSibKus0Iyuyaz8CczLny8JzecTOaVC9ubQq7qeruv8dJVkEwMnCN+fXPehZ36DR9PoLOucSiPg9PxsmEuTRQDN0Na4wRZg0nFDIQ5mhxGY+mZX0ztqz3i2/ITbopog/TVLghMbz1NIXXw+x8XOZfE7AAaDVj9B4YmrNECbOnSNPE68T2EGZ0FCqzpGVnCL28f4U/7csTH6iGL/1lXC9cmMlaMSrkUEtweou5LtGujuoaXXQnulZhq/hx0108aGfkVdLUEa/qNjbcuG2GFhKMdBw03oEsoW/3toKCXbbNpmtfc5BYStlaCfO6KuFXpzomzlFHRS9RJ2zq0LFHTFtNSwnwyae+ZL3lolVOnhqkUySvazEN72I8A4n5/UTRy2GYYCbT8hHSrNB4UcWeE/XruPnyeaIEHjArLDjjy+oJBLbq2NBs4P1zb8URvAfaTKFD02qaXGTQoq4jC0r+QAvzwCxT5Gj00q96WZEbSTBqiMqg1HbN0iqf4ae3dzCiW37zXSQNbuk9m8oaCl2KOFJwjZF11/CME2O1fvX3ty/9KS/jrUGkFty4PYxrYBC3AVYM06+XExu5AGyqpxxsH1rXIBQkWoKzHcFpGAxejnds/zLCA
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(83380400001)(54906003)(110136005)(16576012)(36756003)(40460700003)(2906002)(316002)(508600001)(31696002)(8676002)(81166007)(356005)(4326008)(36860700001)(70206006)(47076005)(70586007)(8936002)(5660300002)(16526019)(186003)(26005)(426003)(336012)(82310400005)(31686004)(2616005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:04:01.0554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd38037-4545-4967-c3be-08da1bc4213e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d2f..187047be83a0 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -327,15 +327,19 @@ static const struct pci_p2pdma_whitelist_entry {
>   
>   /*
>    * This lookup function tries to find the PCI device corresponding to a given
> - * host bridge.
> + * host bridge or a root port.
>    *
>    * It assumes the host bridge device is the first PCI device in the
> - * bus->devices list and that the devfn is 00.0. These assumptions should hold
> - * for all the devices in the whitelist above.
> + * bus->devices list and that the devfn is 00.0. The first assumption should
> + * hold for all the devices in the whitelist above, however the second
> + * assumption doesn't always hold for root ports.
> + * For example for Intel Skylake devices 2030, 2031, 2032 and 2033,
> + * which are root ports (A, B, C and D respectively).
> + * So the function checks explicitly that the device is a root port.
>    *
> - * This function is equivalent to pci_get_slot(host->bus, 0), however it does
> - * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
> - * sleep.
> + * This function is equivalent to pci_get_slot(host->bus, 0) (except for
> + * the root port test), however it does not take the pci_bus_sem lock seeing
> + * __host_bridge_whitelist() must not sleep.
>    *
>    * For this to be safe, the caller should hold a reference to a device on the
>    * bridge, which should ensure the host_bridge device will not be freed
> @@ -350,10 +354,19 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>   
>   	if (!root)
>   		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> -		return NULL;
>   
> -	return root;
> +	/* Verify that the device is a host bridge or a root port
> +	 * It is assumed that host bridges have a 0 devfn, (common practice)
> +	 * but some of the entries in the whitelist are root ports that can
> +	 * have any devfn
> +	 */
> +	if (root->devfn == PCI_DEVFN(0, 0))
> +		return root;
> +
> +	if (pci_pcie_type(root) == PCI_EXP_TYPE_ROOT_PORT)
> +		return root;
> +
> +	return NULL;
>   }
>   
>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,

Thanks, it also helped our system.

Tested-by: Maor Gottlieb <maorg@nvidia.com>

