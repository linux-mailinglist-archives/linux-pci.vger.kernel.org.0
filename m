Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683A07B2F4B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjI2JeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjI2JeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 05:34:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF622CD2;
        Fri, 29 Sep 2023 02:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX9E8xIM/cQirPMu+ERb/wXABIz/YADue1EV+sWM4mApJ5iuvpYWKL5eZrz5W3IgLOktOy+j1O5+1nnjOWTWVSOZ4sac/PEU9gPXA/9Niw2hrA9lvaI8NrtBv5xdNS7AVKbuxN5wA4oo7ZBLFeuQ6zSiXDsCzV8qWb0wRFtSxc0pGrVwC1FRM6SPjFh2IfdTOBQp4CFH6Ms8e3DwS8yGs2QbEEo6CO5EOhk8SPqVY4F+xugGpA2I40mVuxagFq4vz1lXz5liQbmXpGd55MIhkCoXj6pTN+9kG7FZU7DxRKhDO75pY5rQbFHV4loxBM/vGBuZfvmSsdnp6UERlqHvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq2mO3S0PU0fNKldEbNaK82ZdC2QgXy10Vy2cwzha5U=;
 b=Sbi+SsjmZLuzvCi4DEFB4OvZQ9nyXwtEi6Y8mYoa9Ehg4fMo0bKlhVbhus67UGJZe5ZYaG5jWBZjMxZz9UO6F4b8vDCzREhz9kzHtstHOve0/yZ44ldx3ZotPf/1beDsS4QgTyuU+pxcm6g8MA4GhXKKKEvGK0ntet+WkWWQ/dzNf6SeuqwiIyTJrSFxz81nO9ztYCguG1ebsrihSdoy967y5YM60o3HJGYC0dQyRnPs4o0kbn72oZcETILEO5s35srvtKClJtgaI+lbD8QBZIDDWPWf3tzw2FtnPg4cFr+jFdr5Gb2cEw/8DgqhMeejGbccA1UfvoBhbypQc8pI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq2mO3S0PU0fNKldEbNaK82ZdC2QgXy10Vy2cwzha5U=;
 b=WkIdwVjn5XI4IenYXTzU4z/6wqDMIlqwPszR8bldSv4i23pVvrLqC68TohlaP0L7Ve7iAn4t+w4q/bngsLemzyD4bIy7I9UVOd94yiP5Nct/h/LuHrWGbNkKsvEvH0ByxjbdADS6CzuSk8iDav16RLEa4LSWQ8sqqavwxiPtdzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:33:49 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3b23:4df3:c8f4:4585]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3b23:4df3:c8f4:4585%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:33:49 +0000
Message-ID: <f89afd2c-8870-077c-b4b4-368784f6d54c@amd.com>
Date:   Fri, 29 Sep 2023 15:03:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] PCI: endpoint: pci-epf-test: add doorbell test
Content-Language: en-US
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
 <20230911220920.1817033-4-Frank.Li@nxp.com>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20230911220920.1817033-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5540b74b-189c-4a73-351c-08dbc0cf2fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz7EsmQK5HkHVsQ3FA/R6+IvDvWyV24jfUbAbpPVfkhdP/5RD4HZ5DBT1xpq6fEgSaDi7Mdxwoewkky22aRH9wDahFxR9GCCV2qNY+l2fykU/cxGyNceojPZOu4e7KH/fAtQwJxNdPTZWSJNwWC5a9kFzy3iDESib2Wg+CmYSKA4VkxffprbOhKq9GXaLau4W0J7Mn23RqjcmtUzjaN6UH8H84tAlNXlHykRBWrSCwM2j7LKyugqEhV3W0OPPH3hi1xJGvCnLkymAzDHs9evaL7hJHutf+CE+5crfP5CjY/x+8ZllUuhct8cuZ/Al2XGAvS8ssnIiQEwofaXBKxZ9OJvmWND4Yflln88ZpiKZnYDzcqYwrL3YqU+Wc+IzIjEj0DYp5dh7vuCxSvdCJVpz0E2MJ6vZIniPrmvUJHkcVQOJ5GECbffcBzj7m8VbfafEX1kbFeIIoZdDbgA3AjwLdDnYO0UuG4M1vE8AWYdYR4EDCTr4KYyEEzTy704Xeg4cAIkPsDtf6m7Nkbt2jtNLzWaM+OWEAdLVog4L4N9rTy/I2ryiN7q6RSv7ZPWIMJ50+7HpwHB1ZkbnvTpZ62YpUVLyNBbHJa5ePtm75eMPsoycMGPo9jWX9V27vbu8b+P3AmU/LVLFQbQIxWWXUNfNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(6486002)(6666004)(6512007)(53546011)(2616005)(26005)(66556008)(66946007)(31696002)(478600001)(38100700002)(66476007)(83380400001)(2906002)(7416002)(8936002)(8676002)(4326008)(316002)(41300700001)(5660300002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVxS1FrWTc3TVBtMjNnb2dGU2cvbzM1MEVsL3lJdW5hS1BDbFIyWXNrRjA3?=
 =?utf-8?B?MG5MSGpEamkxMWl5SVJValF2UG9ZbHBTT0h0T0FwNlJGTWVpRy95UzUrMkhT?=
 =?utf-8?B?Y1lnbWt6M0loVzBTeTFoNTBVRGFCT0RTY0MvMmFnTlY0N2c4aEk3M2NObkx0?=
 =?utf-8?B?N2VOOEt0aUJRVEpHVTJOcmszaXdEOXg0djZzZ1Y4WEVOWE9FalhwK3FmNG5k?=
 =?utf-8?B?djJ2bzNSdzhtaHlOanl4S0tqcUtaTVdFRTJycWZ4QW9QV3pNci9kZCtDdUwr?=
 =?utf-8?B?T3JoV3h6Tmpjdnk4TmJudmp1eG5lamo1MnRxeldlSzVXd2tDSFJ1RjJHbjFH?=
 =?utf-8?B?ZkxCbFFZVXpMUmRKSFJWQWxjdU9hRXhFRTcyNjUvRmYzSC9odmhwQkVOMVFC?=
 =?utf-8?B?dEMrVjlvQ2EwNHV4cDZ2cFQ5Y0VXR1FmMGVqN2dLVXlhQ0NYK0lvK0l1dXJu?=
 =?utf-8?B?anFrczF0bWVBajQ3YzdVNUczUEFTSFNNdjJJSkZEWEdBelFJNlpaTkd6Y2Q2?=
 =?utf-8?B?cy8xUEN4ZTd6cGtsWUpvZFNPVnIxNUlpZ2tvQmNiYTdMY3NxbURSRnoxSmJU?=
 =?utf-8?B?UnJtVnpnZnBkQzBqS1NCMll0dkFzeS9VZ1NGd3dGRk50Ym96S3RHcGN6NGFj?=
 =?utf-8?B?eEZ2VU8ya3dBNkZmNFB4QTM4cEc1NlNYOXk5YTk2MmJWVm92cER2R1orZXpC?=
 =?utf-8?B?YnIraWphY290YllzaVlzeW5NOW0rcldYZmZlR2NGVjNsUVhzSlpzaEg3SFhy?=
 =?utf-8?B?QVpQZE9mcUVLR29tTlZKSWtWUVZOYjBHM0dGcG5vOFZmdUtqNjlIb0dnSXpF?=
 =?utf-8?B?TFhyakZET3JIS3IvVmgwWGZYVW1jekhYUkZSU3F5SE8xRDd1dng5V0RTSzVJ?=
 =?utf-8?B?WW84czVqM0wxWjBwS3o1alR6aVMzQUdvYmExanRvOU5uUTZUVlpiM05KNzdO?=
 =?utf-8?B?R2lYWXluVHNsQnJLa1QrYjVabStHeDg0Y1V2NFJQbXJJTERYeU5rODZNazV0?=
 =?utf-8?B?N3ROMW53TTJtRXFVZFJyenY1YzU0K21wK2NYUkd2a25BejkrQmxFc0ZHUytI?=
 =?utf-8?B?VXdOV3VJeC9BNmJ0a04zQkdZSUpKK3RBZ1dnNFFwMmorSEpPcDVBME4yMkRI?=
 =?utf-8?B?dWxwdDNmSUViYTk2LzA4VEt4SEhsVFl3M0Q0eGpjbnR0U0g2dDlZSWJnYXFP?=
 =?utf-8?B?T2FXT3J2OE9HN0Y2U2ZhS3lHbVJ1WHdsb284YzBuQkdWZDRvamxtQlhHc0Vp?=
 =?utf-8?B?WHZIMGdtakNhdDcyQ0p4RmxBcXdmbk9YajJabVhiTXRsTmxWa2xzanpoektK?=
 =?utf-8?B?cm55dHNRNlF4cGtURitiRVlIK0xCSU1KanExc0JCUUNiWFBCWEVNZTVYUjdZ?=
 =?utf-8?B?TzRDUlJBMHdMa1h1ZDJTcWpTcFZ5U2VBeWZlWEFoT2VkczJDcmxnbEJKOFVa?=
 =?utf-8?B?dE50UXltdlY0K2d2NmF4U0JwdmpSV0tUcjBJQkRQWG9CbUhlR0hjTm9mTXJs?=
 =?utf-8?B?ZE5FRkV1T2ZNSjhIQ0wrWHU4UDFNTEg0cHV1N3ljeWdCNFZzaWxyS215Mi9Y?=
 =?utf-8?B?bk4xZVV0Szg5WEVpOUlRbGFDaWIrUmtNOWVuWE1sdDh1NS9Sayt3aktONnpp?=
 =?utf-8?B?dElxSkliUmxUQjNFbjMrSnJLeXY4OGNURWk0dFpyVllkcFU0TlV3N2VDVlhz?=
 =?utf-8?B?SWlsUUFxY3NlR2VjYkcvMzZ5ZjM2dmJjaXJBQmxEaitmNEkvQkNQNnJLV091?=
 =?utf-8?B?UFdiSk1FMnNrbFF1TUFUUjNBQ1RiVE9mOHJBNENLdGg5UXBnejIwRHAzUmZR?=
 =?utf-8?B?SDNqMXlJcU1vN2E0ZW9ZTVVudkY2VEZxZ0RVSS90d2ZPeFBEa3pKQ1JxODEx?=
 =?utf-8?B?OXBiemd4TU5Ya1VNeStqTEV1VnBUVnhzemxzRGlQaUlyVzlWdHFVbjZxaGlE?=
 =?utf-8?B?UGF5RVJWUUdwTXFWaWU5d3BMNHJUMU5YeXAyRDVyVHREQUhXUHFhMnlaanRx?=
 =?utf-8?B?RTVlQjFJZStVY1Y4RjZSTzZJeHkyMXhVaVJtdEZjS2JiOVdjZFJIcXMvWmZE?=
 =?utf-8?B?OXlTY1BBZmM1aDlrU0RyUzZzYnQ0dXhyRnVDR2pFekNWYkE4QmhBckRpekhB?=
 =?utf-8?Q?rUsJOspAVYoSn3aDDC68iHQ4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5540b74b-189c-4a73-351c-08dbc0cf2fad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:33:49.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8cizK8KvZHzEGPewKL33g9OhnHbHX3LK81+yZQ1jY37edWxF0cDvOSttlh8RptAAxws7bJzA1DhWwWoY2RGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 9/12/2023 3:39 AM, Frank Li wrote:
> Add three register: doorbell_bar, doorbell_addr, doorbell_data,
> doorbell_done. Call pci_epf_alloc_doorbell() all a doorbell address space.
> 
> Root complex(RC) side driver can trigger pci-epc-test's doorbell callback
> handler by write doorbell_data to mapped doorbell_bar's address space.
> 
> pci-epc-test will set doorbell_done in doorbell callback.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 59 ++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1f0d2b84296a3..566549919b87b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -11,6 +11,7 @@
>   #include <linux/dmaengine.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> +#include <linux/msi.h>
>   #include <linux/slab.h>
>   #include <linux/pci_ids.h>
>   #include <linux/random.h>
> @@ -39,17 +40,21 @@
>   #define STATUS_IRQ_RAISED		BIT(6)
>   #define STATUS_SRC_ADDR_INVALID		BIT(7)
>   #define STATUS_DST_ADDR_INVALID		BIT(8)
> +#define STATUS_DOORBELL_SUCCESS		BIT(9)
>   
>   #define FLAG_USE_DMA			BIT(0)
>   
>   #define TIMER_RESOLUTION		1
>   
> +#define MAGIC_VERSION_MASK		GENMASK(7, 0)
> +
>   static struct workqueue_struct *kpcitest_workqueue;
>   
>   struct pci_epf_test {
>   	void			*reg[PCI_STD_NUM_BARS];
>   	struct pci_epf		*epf;
>   	enum pci_barno		test_reg_bar;
> +	enum pci_barno		doorbell_bar;
>   	size_t			msix_table_offset;
>   	struct delayed_work	cmd_handler;
>   	struct dma_chan		*dma_chan_tx;
> @@ -74,6 +79,9 @@ struct pci_epf_test_reg {
>   	u32	irq_type;
>   	u32	irq_number;
>   	u32	flags;
> +	u32	doorbell_bar;

You could extend test_reg_bar for doorbell to avoid using additional BAR.


> +	u32	doorbell_addr;
> +	u32	doorbell_data;
>   } __packed;
>   

Thanks,
Kishon
