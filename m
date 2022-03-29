Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513044EB6EB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 01:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiC2XoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiC2XoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 19:44:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89B1B53BD;
        Tue, 29 Mar 2022 16:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlmUaUydhWSyBU5TA/JBBgWpKgY9QVEqaH046X7vhEmf5ok7jr/EO9EtH5W6Vx5sUcq5o9ZcqxYqqRigkGXCceKroVhYgAXGrhzrTtECSwcX+i8of34qyTzETRflwXseTBOEuGgeqHVJN0LsqOn/R27ZyzsC8z1BjJCxTR0nZd98daCnWRrSPZIs3kd7KJkkoziyWschg0oPwhoue6x0L1UJIM2KZAhDfahIt+fJFeT+EFOYjtRLmgF8N3sa1W3CmgJgB4FEvkqM/67SEYfJmpIupYYcrZJdqwDt/8N0rkCGRUJ27ROCUdsNrvr05dZ9u5O+U5wJOldBCaaZAw0adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p8EApKXufUwEyS/5dpEOHF0hv+bRHQXp9K7beG85Po=;
 b=hmFus7BM2o3X0C0mbBSQiYS0k5KChNrr3SzqR+QK50XmK6eikLn6I8mZ3AMXJexViQoq7iu+dqMrBKoLhnNdH+jF0rCfvDyIRsLs9I5dc6PMiXOgdC1QpxdctIWu3BcpYh+EBZVFgGUdhQd9JzAMJlHV7L4gSG5jdYjKSPH87s5Cir8KVSdcEVxfI+YO4RBgT2VXOQeAgPn0bIfhEpzU+2+PFTCDmiFMj/fpYJzxKkj2zNSrxaDjB0wgH6Z6X8I6oLp5BvIerCu/9rk+kUI5mslWzoZ0k645sf4V9gjBQlqLe40Ar4cRXmj+x32AsHWi76zBUr8GYYy9JStQ9F3+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p8EApKXufUwEyS/5dpEOHF0hv+bRHQXp9K7beG85Po=;
 b=JLczOXQLxY2DO6mc92A3WY8fqrCyB8stnftgJ0UM1qc12N/aBqKEUg2SKtEtepHTp910XGsiS6GtYtlqnE6HsYP2dkQnqS0Q9SuLxxzUYyKGoWg3kcRZ/AfvUD2BehYWqjMLb/L8H8/AJKoJgDNrmc7kkC3xnIDi29B3H8fXU+EjSNcyAPLuj+QgMAtF3oyFJ4pkqvMGgApZpwK1m/VRbT7GTIWqkGnSflf5XpJ9iGYjBpO8GQlxvc024TjOfB/VXn0U72iiO7Wsk5wxNsG91PqPZKpf5otVcA9qMmFIGHtwWgW4JkhTPJBgODJ+7MODGul/YeuRrVwkH3kgA7Yz4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 23:42:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 23:42:21 +0000
Date:   Tue, 29 Mar 2022 20:42:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V3 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220329234219.GD1716663@nvidia.com>
References: <20220329104321.4712-1-shlomop@pliops.com>
 <20220329104321.4712-2-shlomop@pliops.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329104321.4712-2-shlomop@pliops.com>
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20bca188-e4c5-41ee-6eb5-08da11ddc48b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4996:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB499655A5C68BFC7E63C8E257C21E9@BL0PR12MB4996.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aublWTIqfokkYtLC0ZuDxL5mKxiIK8+lJif9qNTruapFse/Fmf4ULP324tZzIpwi1tr9LB9muXLWVNK2TM0JKd/2RG5RTkmYBUMc0aBn/8TW1ZI0ujmwzdK0zfEqsiGx7Quz4L0rGzf71wgl7GSSrBU18VtiFqxam8PJd2abxf6axbGJZH2mlLEoROCcb/DIwgmwqb5IRKi65VKT02WZI9i1nljX423SWGWubl3GzFla20S0ZpBU4kV2DaaUUxcFjegyQwEYO0kSKm4bAqqExAVgPxrQhho2eqyW3dRTbbRTNlwSBfeOl0AdNYC7sgMzQ3WPTisCTEGnyaDyOQlzJdkmfxqd/y0jJ8vzWulSISrnuSA0tYldEZnV6KQ2t8KlI0H9LdnewVoegTM/lM/s/UyGIBRI334ZF9DPpZ455lsNsQOcgQXEFPr2IPfyZ2pj9HxWAx0JTrzMynFgmAndJsMGjJyGkz3JorDA2n5zDp6urN++53L/nFjoeIlW5ipCqsjK3rZA6HvTUH6jvXkt+mlkdjbqHUeduzR2XbaifAGC9h5bavr9GTnQrAI3idDYF3XJ6nbMoL0uuM+6ZbfDwaQfyuYl2ubfXW78YlO+bFNp4KYboSpmsQKcDLpOTDCfU4Oha5KHU73mla42YN6AHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(508600001)(66556008)(66476007)(38100700002)(66946007)(316002)(86362001)(6916009)(4326008)(83380400001)(6486002)(6506007)(5660300002)(6512007)(8936002)(26005)(2906002)(1076003)(186003)(2616005)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVHGDBZdTELXf9ujfHkbnFRUiu6nNsJOWJjS4g2+/aEpD9Z/lCnUx3oB2zmS?=
 =?us-ascii?Q?TVJiWTtMnAVHGe8UHXPyuKqE/A2nhKop5hiV3STDVLwQkkPbQfGxH42/L3v5?=
 =?us-ascii?Q?Bb/kLKL3vpkNVqsy4iFOezt378jbtLJCECE9u4h0ogTHloPLjZB1zRNqgUZK?=
 =?us-ascii?Q?PaF2r8iv82CRDllCLEc19Wv3MqCc+VIO7bximqFK2EnNSBxqufZX6u7qm6+x?=
 =?us-ascii?Q?DK1v8G4qAa68cTXWGsrnm9ycPHGcZWL6A2RyTCZ1nQnqAmOOwzZu7uRk+RkC?=
 =?us-ascii?Q?x20SSfXTU0+0W9TUxIlHMDvTZgCfIx+nszn8Iv9L0ldTDiD6EW7J1ChfQHhZ?=
 =?us-ascii?Q?HUe5oG6+IV4L9QG/5i6Ai7qmzBWhPmTunmRlHFmRrMel+fqkGMdEuypM0fb/?=
 =?us-ascii?Q?A7djHluvvTyYLlkSd8JzhwcaqtEos3QMkV4fy9WX1cpZ/eW3YMLAxcyRJpfN?=
 =?us-ascii?Q?8Rk6fASu18Je8ZW/YLjSlRcVkhH3t/A5pJWnEzCwEh5YTYFNAqtLTyr9DopU?=
 =?us-ascii?Q?lkpw2q2PIMmn7l2TLkPHQnMjDw0GBEbUQesGp8hDiPjk+NSj535iPVZcqdmD?=
 =?us-ascii?Q?HE4uWYV1h4ddPcYUcF9ipRChWvasDZ5OpVAgxOD1y7VvW0mGWvHNNZMFAlhW?=
 =?us-ascii?Q?iju75sgyRrnVlsUSH2y0waO8HdO1hbSL2q8IcX5B+e4lMhsSyDgt8/YbBhjn?=
 =?us-ascii?Q?0vRQQe8bypVVhLzYd5/H7tUYKAsTNSBQwBHpBA1BRfbjPBYpSLiFvG2gihNQ?=
 =?us-ascii?Q?S8q0EwH18PF7IjZTuQnu1HS34zxrWSBpA5AqZvI46DrHraxy8++xPhWSqUQF?=
 =?us-ascii?Q?tPGwCaQ7P1Vcwui2Jhw35zu29ZWIPbfSHXSZ/LZSOOq0JhlkRjShA6FAyy4E?=
 =?us-ascii?Q?OKoHMjRYlMql42aiP6UrWGjBPsZXmE46BR65JrOblv+jNZmYgjadMlsbRtdm?=
 =?us-ascii?Q?lKlzk2yAecFFUMOSngjpa/74v/JjWzaZ4ccFaQvc3hw/DGq9U+sVLARTQeIN?=
 =?us-ascii?Q?ca/GsYOdVckKe/ugrnd6JRkbhjSnTCzjytbFa3KaVmJgrKxTgAZOOsiL6w7B?=
 =?us-ascii?Q?WUTgGvRr3e7Wz361+khNS700mUR5FDnqvPNtxVMpbacotAdyWenbk6P0eU9H?=
 =?us-ascii?Q?RfMxv2vCE+TgH1M44eO+ujjJ/NIbyvR0k6aoR8rv24GWItJOISDuTtjQWkCR?=
 =?us-ascii?Q?wzTFDQeEd2eqvgUpz/1T+1QkrnN+QyG77TokQLt1jAXE3hbBFl7HvYuQCfyh?=
 =?us-ascii?Q?bWQa1Q+8vndl1Cv3tSJDzn8EoB8V22X6HSWDjQCHnWdXrPmrbrBSPZ1nzngi?=
 =?us-ascii?Q?RF1h+GHe+ZaxFkmqN6ma4Hs2XX60GsaIR3XKycnVUiteTV3vHrDq1n568EWa?=
 =?us-ascii?Q?XNBjnEoXk7u9ZOhK9Tt/cP5MKt0I4MT46m1lJeKk9UP0StzwRreIfdte8nCK?=
 =?us-ascii?Q?QQNfWTM2HH/dNCjeTnRL7i9Ehc4C3EzNY0i27jqxCEDHMfBe9MvONVBKp+5L?=
 =?us-ascii?Q?aYhONtxx61jlf193d4bi2FCBZMkBDDv+zQycSKSw7xZEj0XonIQrsj328hfU?=
 =?us-ascii?Q?IO/+k+cnRugcewJKcUom0pULLIEhFSsIt9H7r0fQ3BJCLJFsrCt/LHlSJxJo?=
 =?us-ascii?Q?u6zNDhJ/hGnbB1wu4sgRoMU6vf5P7aLF9Y5e83TZkO/IO490ShNy40k2SeUA?=
 =?us-ascii?Q?DwzD4f8672lEqJZ8zS7ttFE8Wg109zksFaqxfqNYly6O8M5NTlXlVSOObq2E?=
 =?us-ascii?Q?BczTfwZsmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bca188-e4c5-41ee-6eb5-08da11ddc48b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 23:42:21.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldIeTXrIJ5sOGFP9sYh1mEaOpt5YXTCrqHFRp3BpG8tGxdy5FVWvmYt0YgSonJHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 01:43:21PM +0300, Shlomo Pongratz wrote:
> On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")

'in commit' and it is expected to word wrap the description

> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are ports A, B, C and D,
> and if all exist they will occupy slots 0 till 3 in that order.
> 
> Now if for example device 2030 is missing then there will no device on slot 0, but
> other devices can reside on other slots according to there port.
> For this reason the test that insisted that the bridge should be on slot 0 was modified
> to support bridges that are not on slot 0.

This needs updating to the new test

> 
> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>  drivers/pci/p2pdma.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d2f..c088d4ab64f4 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -307,6 +307,7 @@ static const struct pci_p2pdma_whitelist_entry {
>  	unsigned short device;
>  	enum {
>  		REQ_SAME_HOST_BRIDGE	= 1 << 0,
> +		IS_ROOT_PORT		= 1 << 1,
>  	} flags;
>  } pci_p2pdma_whitelist[] = {
>  	/* Intel Xeon E5/Core i7 */
> @@ -316,15 +317,38 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
>  	/* Intel SkyLake-E */
> -	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2030, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2031, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2032, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2033, IS_ROOT_PORT},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
>  	{}
>  };
>  
> +/*
> + * The functionality of thisunction can be integrated into
> + * __host_bridge_whitelist function but this will make the code
> + * less readable

This comment is not useful, explain what the function does or delete
it

> + */
> +static bool pci_is_root_port(struct pci_dev *root)
> +{
> +	const struct pci_p2pdma_whitelist_entry *entry;
> +	unsigned short vendor, device;
> +
> +	vendor = root->vendor;
> +	device = root->device;
> +
> +	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
> +		if (vendor != entry->vendor || device != entry->device)
> +			continue;
> +
> +		if (entry->flags & IS_ROOT_PORT)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /*
>   * This lookup function tries to find the PCI device corresponding to a given
>   * host bridge.
> @@ -333,6 +357,11 @@ static const struct pci_p2pdma_whitelist_entry {
>   * bus->devices list and that the devfn is 00.0. These assumptions should hold
>   * for all the devices in the whitelist above.
>   *
> + * The method above will work in most cases but not for all.
> + * Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
> + * Consider on a bus X only port C has devices connected to it so in the PCI scan only
> + * device 8086:2032 on 0000:X:02.0 will be found as bridges with no children are ignored
> + *
>   * This function is equivalent to pci_get_slot(host->bus, 0), however it does
>   * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
>   * sleep.
> @@ -350,7 +379,9 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> +
> +	/* Intel Sky Lake-E host root ports can be on no zero slot */
> +	if (root->devfn != PCI_DEVFN(0, 0) && !pci_is_root_port(root))
>  		return NULL;

The name pci_host_bridge_dev needs some attention if it is now
returning a root port.

> @@ -372,6 +403,7 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>  		if (vendor != entry->vendor || device != entry->device)
>  			continue;
> +
>  		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
>  			return false;

Unnecessary hunk

Jason
