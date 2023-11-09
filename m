Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC127E62E7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 05:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjKIEpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKIEo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 23:44:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3B26A0;
        Wed,  8 Nov 2023 20:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyDcFOsw8UtM8yyUhwr7J8NyDq4drKlXaKvzBfAPoeeoyZBKd1dJ9e/bcyZmKq2bfiQ8iiVy/Gxv93/w+fSPWDEiJ8tIxI2tf31Vj8Mkkq7LtGrJUVqwvJuQmEIU2v6s5egs1I25e9FgfCnNNKNEYPLd/mpBuHsfKmr49z7OlrCQ5pjRej2Q+iwVcaxV+ClTqTZrI0eYa95Qpyn+7xyLEZm3dT/tj32ZThI5WdIeyF6T+mGVfW6RGwTr3xqFs+jq6DAN1WMOiWuxDsotPZeX9SPFezwhsYopBUQQWZSAaDgvLe+xvFHUKJgfY2rNHaEFJ7eKnEDkXfzf0JnZXQX9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqkKHxJZEDT3k7/Ma1frMxNW//YeT43ySMfRw3+MhMo=;
 b=UZ6Yij9gSin2I3NT/fjYQLz+jTYxpSfUjioNCgDb+hPyyW0n9UM/yIjddpbH9uPc3vu2zTaAyIOTAD1xXcZzuXTkymBerlmddXFnbTkohukccwZE1vAkGwHFKBLVfhX4K8yV7TjNx7DsAb5k/lNYLrfZvIWclJYoi5r3wnnoOWlifsLJuQds4dP7hUVgIYb4kCvpYT/QQUMN3YLXjy6GHHcRHRnRmPwNknNTICYsmwwldZF+8bd3uyfD8x7mOw4ikTMXoBDVibOdIRzYDx5rwR75wQ6OYCnDE4r2W4C61rU0nb+Qa7DjczmwxrTmv4A5CMMEXAxXZQh7oBrtkcFjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqkKHxJZEDT3k7/Ma1frMxNW//YeT43ySMfRw3+MhMo=;
 b=VezhVOnyPIr/uvWl6xnUgF13YCT+ahJCv0wDt20WKvlILbtfT9iXQ/a4UsL0bLLW61+tDw48gmA1WKLefKMnFmxhuNLHnt+zUOpAO8tbw4Hm7lYcBTiklmujRjXaZaRzc7VnAe5BrjvmeOwfkTqOqfvKE8e+sEQ0gDJgUypY1Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 04:44:54 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::83bc:6ff8:d40e:a7fc]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::83bc:6ff8:d40e:a7fc%5]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 04:44:54 +0000
Message-ID: <d3322eb6-8da1-9401-d012-1af3dbf33e8f@amd.com>
Date:   Thu, 9 Nov 2023 10:14:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] misc: pci_endpoint_test: Add doorbell test case
To:     Frank Li <Frank.Li@nxp.com>, manivannan.sadhasivam@linaro.org
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-5-Frank.Li@nxp.com>
Content-Language: en-US
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20230911220920.1817033-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: f76a7bfa-1f07-4a69-e7f9-08dbe0de9dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oql06c6frbkn5+gVeBcKu7W2aVFMePPNs7yYYXfbv+qb13KlSx0NUJorPTpt2tJFk3jrNVQqVNuHkdxf3u+wvYwg8vVrCOKoIjZ4Vk4iQ7Ohk84mTIQeMMjVD0xcjUzFpCW/AxSeTUA+qG7Yd2lrhkp2cfD/lgJ8IvsHKtJNXlhHj5eyFVRuG3w1yW2ijv61zhkyIMoVkYkkojI4jpLDLrcM9VGst7cwH9g34naDHxPjk23SoD1nQcH0F+enXEfD8JocvZGlsQAf7rNltwZwwMgjFYqOgiY541BXO9B1uNLCYna/yR7oMn23aTVjryWjLXg6ebDzlqQmmd0APAkfnVf+u9T2hOhiUwCOhzZullQlxki+NaBVF5SRQGgxjssCQFRvW6Yb5VqKj4hpMNl3/pDT+NE0GK9d02Vep+wvmnK6k2eZSdZxwTXukMMQvUYt6PcLyzXBSb2RMe59eb3bNGG0f97Nic41LtAg+BNGPA9C3Hq39Yzo5E/77QQCvSiF5WuIOfV3t17ZSgNvCTzv9vMgvFxAH6voAQCCSZHK0SX+sOR+Iexvl20eagMBDPtJtrFAPWSrCY+ewL+6NSGGVFWOb8rVVGYbstVM6haQALsQ8JzLdTz11QU/ihoPNUjDedrpKCKSBhwHjspS4o1izQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66946007)(31686004)(6486002)(6666004)(53546011)(6506007)(36756003)(31696002)(38100700002)(66556008)(2616005)(6512007)(26005)(41300700001)(66476007)(478600001)(5660300002)(2906002)(7416002)(8936002)(316002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdQY3Y4OGE3U2Q2bWw3Wmw5dmt6R203N3NBV00zOHhyVW5Rb2JnTlZ5ZEJk?=
 =?utf-8?B?ZXo2MlUxSVRrYWRQMU01bUsyckIvL0g5YnBibUZFekJxd1JzczZJQUQvY2hk?=
 =?utf-8?B?Q3Zod0dHWFNIcGNuLzgwTmw2VEowd3VSWGsvR2hMdDkzYWhwd2tLTHNoTDc5?=
 =?utf-8?B?YVduY1dWY01PUmFZSHBtcDBhbkdnN242TzFiTC9vaE5sK1JrLzdvWTRUaXRk?=
 =?utf-8?B?aXdORVVwb2Mxb3czeERCblZKcEk1cnpzNkZNQWI4M1FFODlUYXpTL3V4VkNG?=
 =?utf-8?B?bXhuTGdlK01ibjgyTEdJQW1ESkhicmIrMFd1TENmV3c5V0t2Z1J2YmdVanZy?=
 =?utf-8?B?cERNY3I0d1JBdy83dVRVaTVKd0ZneTVaTmppdzhhTk5FUWVzcHBzM0NnL1A2?=
 =?utf-8?B?VjJIeW8xYnlzNUlDTkZJRXRIc2tJWS9ZMDdHNm0vQUx4c2JDc2lrUVg1VEMz?=
 =?utf-8?B?d0VDYXAyM3pkT2hXYzJyejFQdmlHZ0lLRktlanpCYzJxbURneXNMZld2Uzlo?=
 =?utf-8?B?bC9KeFBrdlVyVXBHWXRlVG9ZWnkzaEw4blBPY3lXUlZWY3QvdVZ1NGlQQWRj?=
 =?utf-8?B?aG1MenB3bWpLTStRb3ovS0F3aWRQVkdmNjlPNzV2WTQreXRkM2JaNzROQTZM?=
 =?utf-8?B?YngxaXhTY3NxU3lOcDg4TDJFTEk4VkhUd05LZWxFNnlUZ0hwcmd0WC9PajhY?=
 =?utf-8?B?eWxYQ25sUnlzcXhuUXRsaFZ0ZjZEOWtBZ0ZBZlFBMGVvWG1BWDBzZDU0NUVz?=
 =?utf-8?B?NkNCaXJ0OHhPTElHTy8xdUxLWHovVFZ0ZmZYdjZNR3lQVzFkUTFyTlN5UXFI?=
 =?utf-8?B?bUkreEdwUkxaMXhwZW1PcEJtcklWNVdKVndzL3dFMmUwendRYlRlVGg4eWtU?=
 =?utf-8?B?dWFjeU5PNTh1TEp5dmV3Z0oxVC8zNmtvaWxpZnIwbVh3bHlreVhmcDVod2Rv?=
 =?utf-8?B?RWo2WG81ZUI1bW9VTFlwSHQ5MVFkS0dQd20vb2M3dGdBcVBwRHhVUDBIckVP?=
 =?utf-8?B?ZUlwc1M1L2NpK200NjVwZC91d2pUa2UwR29Oblc1VzNPVHA0NkRSUk12SlVW?=
 =?utf-8?B?aDk1TlZ5SnBDNkhqRDlBTkEzaTNnOWVkeHZaWDlVdUFMR2JieXFORk1kSDBS?=
 =?utf-8?B?N3QyVUQ5bGp5TE9hTE8zRDBwR2d5cHhGY1hkUFBVVzAwYWRKNDZGU1hteWFa?=
 =?utf-8?B?TzQ1RVh2QUVkbTI5UFZJMHhjMi9scXkrbnNVLzZYVGZUKy94WURpcGtBdFNv?=
 =?utf-8?B?MmxPZlkvUEQ4bmR5WlcxNXdSNVJlNHJ0bFFvbHJRNFIyQlFudGVZYTkyc0Zt?=
 =?utf-8?B?L3RLaW96VHd0UE5HN0xkVXR2WDdNanM0djkyUEJYS1FGM1JIY2xjSWo5MGRy?=
 =?utf-8?B?V0dUZ1RyV0ZZVjB2dTYrNFNTUlhUeE52S2FTVTBBSndFTXJsSnh2YnA1N1dl?=
 =?utf-8?B?ZEtjNkIzME9JVW51UzlUelN5SUw4MXZQdWZXOXU3TndxYVJ3WXdLNE9RbDJa?=
 =?utf-8?B?Z3lBTFJvQzRBTDZWKzRnZnRiK2FKVGhPSHdZVGMwTCthYWVxSitQSzErZVRN?=
 =?utf-8?B?L2kvU1lxQTBxTHZIQzlKWnNaQzV6WVl5VkhVNDVTYjR3U3RheHIzV2ZVRmd6?=
 =?utf-8?B?RUxpdXRmNWFnYms2Tkc2YnlSVWQrYTlxb0ZPbHZqZlVaN2tITE5UTmxtWUtW?=
 =?utf-8?B?MXU5ckxYZVNBTFZ4dVNzVzRXVFdUdHNFR1hUMk83bnhTOWVJN1JJNHJZa1hR?=
 =?utf-8?B?aFFBdVlOVW9ySFVpNGNpeWY0ZnBDaHBPNXdOem1UR2ZDU0FyYTQ0S0gvQzlJ?=
 =?utf-8?B?bit1eFp0UmpJZFVXK05UaW11RFN4cUhROHBtUW03KzJtT2cvb3kra2E4ZkZI?=
 =?utf-8?B?eTc0L3pYd3NWQTUzVWFYdTBYeTNYN25sdTkxbXc5QVhOSjMxZ2JpWTRIRnBH?=
 =?utf-8?B?a0ZBTzNLeXRTTEJMVzhKUHQ3YlI1MTBYc2RBNkh2SnJ1M1A1b2NjMVdremli?=
 =?utf-8?B?TUZsMXh3ZnIzcFh0UmVYTi9Ia2xONkszYWt6TXVhN2ZPNEQyL21mOS92MHI5?=
 =?utf-8?B?aDNYZDRQWnFadGV0cnlXS2hWY0J6cVFPSGc4SVlPWFF3eU5MdENObFQ5Mkpw?=
 =?utf-8?Q?2m+1C08HKQb6XS1AhjCFZvh1N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a7bfa-1f07-4a69-e7f9-08dbe0de9dbb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 04:44:54.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+3go+8Pm/MF8RgL7jz5WtOU7mYcdyJcDdd3YajlDTevacpXXhkKna1+ZYQzEosg9aMf/PP71vldLPJFUXbhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 9/12/2023 3:39 AM, Frank Li wrote:
> Using bit 0..7 of magic as version number in pci_endpoint_test struct to
> support older driver versions. Save to 'version' field of struct
> pci_endpoint_test to prevent reading non-existent address.
> 
> Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> PCIE_ENDPOINT_TEST_DB_DATA.
> 
> Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
> PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for endpoint
> feedback.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/misc/pci_endpoint_test.c | 48 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/pcitest.h     |  1 +
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index ed4d0ef5e5c31..ed0b025132d17 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -33,6 +33,8 @@
>   #define IRQ_TYPE_MSIX				2
>   
>   #define PCI_ENDPOINT_TEST_MAGIC			0x0
> +#define PCI_MAGIC_VERSION_MASK			GENMASK(7, 0)
> +#define PCI_ENDPOINT_TEST_V1			0x1
>   
>   #define PCI_ENDPOINT_TEST_COMMAND		0x4
>   #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
> @@ -52,6 +54,7 @@
>   #define STATUS_IRQ_RAISED			BIT(6)
>   #define STATUS_SRC_ADDR_INVALID			BIT(7)
>   #define STATUS_DST_ADDR_INVALID			BIT(8)
> +#define STATUS_DOORBELL_SUCCESS			BIT(9)
>   
>   #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>   #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -66,7 +69,12 @@
>   #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>   
>   #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> +
>   #define FLAG_USE_DMA				BIT(0)
> +#define FLAG_SUPPORT_DOORBELL			BIT(1)
>   
>   #define PCI_DEVICE_ID_TI_AM654			0xb00c
>   #define PCI_DEVICE_ID_TI_J7200			0xb00f
> @@ -102,6 +110,7 @@ enum pci_barno {
>   	BAR_3,
>   	BAR_4,
>   	BAR_5,
> +	NO_BAR = -1,
>   };
>   
>   struct pci_endpoint_test {
> @@ -118,6 +127,7 @@ struct pci_endpoint_test {
>   	enum pci_barno test_reg_bar;
>   	size_t alignment;
>   	const char *name;
> +	u8 version;
>   };
>   
>   struct pci_endpoint_test_data {
> @@ -713,6 +723,38 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>   	return false;
>   }
>   
> +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> +{
> +	enum pci_barno bar;
> +	u32 data, status;
> +	u32 addr;
> +
> +	if (test->version < PCI_ENDPOINT_TEST_V1)
> +		return false;
> +
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +	if (bar == NO_BAR)
> +		return false;
> +
> +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> +	pci_endpoint_test_bar_writel(test, bar, addr, data);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +	if (status & STATUS_DOORBELL_SUCCESS)
> +		return true;
> +
> +	return false;
> +}
> +
>   static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>   				    unsigned long arg)
>   {
> @@ -760,6 +802,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>   	case PCITEST_CLEAR_IRQ:
>   		ret = pci_endpoint_test_clear_irq(test);
>   		break;
> +	case PCITEST_DOORBELL:
> +		ret = pci_endpoint_test_doorbell(test);
> +		break;
>   	}
>   
>   ret:
> @@ -887,6 +932,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>   	misc_device->parent = &pdev->dev;
>   	misc_device->fops = &pci_endpoint_test_fops;
>   
> +	test->version = FIELD_GET(PCI_MAGIC_VERSION_MASK,
> +				  pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_MAGIC));

After running BAR test, the value in MAGIC register would get 
over-written and this is bound to break.

IIUC you are also not handling the case where BAR test would write to DB 
BARS.

IMO handling the above two is important than trying to find whether the 
endpoint device supports DB. In the worst case, DB interrupt would not 
be triggered which is okay IMO.

Thanks,
Kishon

> +
>   	err = misc_register(misc_device);
>   	if (err) {
>   		dev_err(dev, "Failed to register device\n");
> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> index f9c1af8d141b4..479ca1aa3ae0b 100644
> --- a/include/uapi/linux/pcitest.h
> +++ b/include/uapi/linux/pcitest.h
> @@ -20,6 +20,7 @@
>   #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>   #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
>   #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> +#define PCITEST_DOORBELL	_IO('P', 0x11)
>   
>   #define PCITEST_FLAGS_USE_DMA	0x00000001
>   
