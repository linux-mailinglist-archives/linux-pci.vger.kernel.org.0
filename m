Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF115FA028
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJJOYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJJOYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 10:24:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718C73906;
        Mon, 10 Oct 2022 07:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLBburZa26CMRORE5uGifU4nY9REXdwqKiEHwRd7CKlEeJb5QGVq3XpuVEqJGpolKKc9OZWN5AepB9TurGEOoJC2yLYinqAAXRjoH1dzvI2sIW2JFKTOjenp8pwd6zgwwQyRzuWWyQdasIO/QLTLZ2AwgmtvF7vUzkOl4ee47oeHK0HGwGCUOln52KrjC+I0o9w68jOuk93qsG4sXbHpYEljB6FYn5AgNzSjDReeVUUgskqx8iMdD80qQII1BO8+1Krcha/C4sTuUqNZ4P/QhZWx0QwYBOSzn1UMFhkMlmSBk2mj0O8n0pflsYkgTpleeNHEzyn7uC0SlBKkkecShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQh3PUnZ/FsG6KqhL4+FEjTXqSGerAvb1V9cIyTstXA=;
 b=EtHBoIYWvUlmTPhlU6XIEScMcUkyurlcGznY9W+MkW1Z9OIeBLdVdrgRl8Jqu3IH0Qaw8ba2CX2KlbRS+0qKSC9B7D1NUZxZJArOVEsaQO/+RtnhJj2Plfnh5XlCkcljfP8935qdvhHGqEWUIU8UDFkC5NxLZIXijYCFpXtEp32V2rBmIey6A6ifqFyWUDKQMOD/EF5Z1MZN0gQrKBwrHy8c1tjYxrT9y/V5ZCpkNQHjSOWmZ+9ScZqjU+2iqwqYIuPzFjo9yUwf0bTyz3tAX899PrXge58wFCRMIkA8LrGePnLcxVY3m+8pRuh7RDLeGBn4V16mJ2+wIkrBcePwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQh3PUnZ/FsG6KqhL4+FEjTXqSGerAvb1V9cIyTstXA=;
 b=p9xDKNuUjtkuJeykU3CHAveCilnycB/uoG2hkw2lf2LP5cWg0x8KX8/8R4ewie6HIzoOSWlhdAD7NbdXCbO6e+npIUcQL1fQII/U7Pvzq+bTP7Q/GnyI54QlzfBaW8mp90x38ejO6Mq6e0WmWbWwGTI89PU4/xoZYL2F93CtPdnWY6wJ8yF4s7a4zgU2goZXRC68m9+QpHy73FJmRZsBnazKwiKQFF8HvGkJW42UIJwX16ncbMm72bFifUSkKZlcYBNyxB5cGIVon+zzQM2xa0cF+b/N+igb0+Ea310fx4/Cnm2PYxKzyLHR3SiCfK3q2pb4d/ADgWYkZhWtL76Rqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 14:24:03 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 14:24:03 +0000
Message-ID: <5ec4b46f-2590-bd34-f6fa-e4e2eeb38b7b@nvidia.com>
Date:   Mon, 10 Oct 2022 19:53:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vigneshr@ti.com
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-3-manivannan.sadhasivam@linaro.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20221006134927.41437-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ea70abd0-5afa-408a-6f9a-08daaacb1510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeCqOyEwY6b/Jds+kw+pco/vl5gAQnWz/eEhHZatjV75lBgEkjVDf1lgWnqO1KsSIzM62PYfwH5FBB+ffV449OFm83UvLbmwV4H+OUowsqjHB0qC5i84ANad0GaStDkY/4s0IpcaB44alIfyS321zEKXFsVhdKclHUexa2CdoInIaq6rF7Yz2igD68wkv0uOrxKiveDMszOb71zYDoWSA92VSIKgu79Q1lzK22iyfMNtjuzV6ltwZAe5TliKU+S0E+1ySO2OyvU+SSHuuGWiagIIeQcEUvhCY9o8kxbcjZTOYwy5s49wyuqgLc8qLPhNIV6yMxL5fLbyIafsxuI/HbJ4JMFHXeTWn6MN/oRgIml0v3CS9gGv05x4hb/lsGt1nRRkVUMhiitwxCnL0VOSoJvIC6bXMSvHL+uEnbIAvTcFJ+4nwY0gp7AT3Pw0aHiUqGUygpskKKl1Gh5EZ7NuX9Mp3YCj4jm6lzRQ3wLbVka6ISoiUI0iOioDec9IYR0Bi5PEXxW/zZpTwP0ZZuu9IIBC0FFKBUEZuOCAt77LrnpJFwJFJk4gBxAY5qYAAruyhtI0ZGkAfXQDFWrfMVzfxf2IT3Fq7YwOcvO5m7QjRj7Vqso5unl2wQ6/HcDrybkPw/ElpgR0ETuUWKAg/jdvWNDmdK08BqW7OzP4iRr5dJo4n/M9oenUDuTRcQhgvsvWjBlfBQVdcAPAcHlucB2Z+BgMS4koqeomeyzSCQEViAO5lL77i/4gcV+k4G9kbBeUt4HC47A2Gnh9OSFAYXh+/GqgOrtkaBkEr4dFD2FEI2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6506007)(2616005)(6512007)(26005)(6486002)(186003)(83380400001)(38100700002)(31696002)(6666004)(86362001)(478600001)(53546011)(36756003)(4326008)(66476007)(31686004)(8676002)(66556008)(41300700001)(316002)(5660300002)(8936002)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxROGlydVJiamVEMklLams0a1NjOUlPM2pUdm5WS1F4ZEZja2oxNnVXOTJw?=
 =?utf-8?B?K2F5a3FvajdPTXdtOTZEdGN0ZnJ0ZU05SHp1eG82RHQyWmdHckxoK3Fkb1Fn?=
 =?utf-8?B?MjZrVCtOWmhSL0ZYdmpza0ZNMVQ1NDFRZytMUHBhU2ZOQ3F0L3BqRER0ZnBa?=
 =?utf-8?B?QVNNQkhQcm1DWWpvYmZKMmRONHNRMzk1MFpzcEk2ZVlQc2lMTURKMzRFUUlp?=
 =?utf-8?B?bEREbUxJdE5Bd1gvU3B1L3ptMUdwRy9UcTliQnBUMkxCQ253MlpwMlFNSmhm?=
 =?utf-8?B?ejZsV0trSEM2UVVxbVkrdmJiSnZCL2tud29PNVVIMEFuMVdyNm51cmhaRy9P?=
 =?utf-8?B?M1pnOHVoTVdwNDJiaGtLclZQVzFhNzZqT0ZkMDc3dXl3TklDMVB4OWJBU0ln?=
 =?utf-8?B?MTJpSHhTNFlrMHlHdTVjSVVpK2t3SmEyYThOWUQ0R005aWF1V2l4TFF6dzRp?=
 =?utf-8?B?elpSQU9veEV0QTZrVG9ubDFiZEhWVk5zbzB3OXdXNWw0bkJrZU9CTncyeGJj?=
 =?utf-8?B?YnJaME5qcC83OHZ6dUZYUzRjaTR6dGlxZGFzNVFFN2R2TzhwSUVBRVdMZU1T?=
 =?utf-8?B?Yjk1NEJjWkZSaDFtMzFId0lHQ28raENOUHgzaU56L0lsek5MVnk2QUZxcUxY?=
 =?utf-8?B?NnBUZFd0dVdmVXdvZ1Nuci9XZFJSVmdvSnRXdmZXT3ZkSG42TDFIbnIvSVp3?=
 =?utf-8?B?Z1RGd0Y0K3dnRy9TWmFpRG1XTWJ3UUdEcEFnUmJWQWIxUVRaWXo1b09XRHZ1?=
 =?utf-8?B?VkNUS05NK3NESUNjQkE5aWRiQnBQYzMxUVlMUWh1eXV1bWlTNjJGdlVYRVNu?=
 =?utf-8?B?QVZ2dVlGekRzaUVYWUJGaDExeTZRMlFPMDR2UmY2UURJeXJCNXNZTjB4UWxQ?=
 =?utf-8?B?OHZjc2pqRVhleTVEcmhxRW10WUp5a2RYaG9nLzJicTQ2NDlPbjY5WGE3cXpX?=
 =?utf-8?B?blNIMzdyOFZVR0d3SGV6ZXZSdkRsVTVtS3BUMXU1dmpyb3hWWFd3YTlYZFFP?=
 =?utf-8?B?b3JSM2x6ejhnV2hjSXlpeGtQd1BwcDgybTg0V1NYWGd6dWZoMStrU0NvL1hE?=
 =?utf-8?B?WmhzaExoa1h2dThpQjNvWGZkWFhkWVJLbmQ3Tjc3MGNkUXF5bktKZnlMSHd1?=
 =?utf-8?B?a3l1bVc3MnFkZ053eC81OHQrcmlGNTh5c3FMMndXMytLSEpINE5IU0ppcjRE?=
 =?utf-8?B?OW1nWlpabVZmaVduQXlQSm1GNTB6YW9ScmY2VFVoRmVSbmlOa0U5bmdqU0lu?=
 =?utf-8?B?N2x1bjFwV2xOZXlvdUt5UGN4cEJkZXI5aFpoeWk2TTVPK1MwTnRHTDd2dkFS?=
 =?utf-8?B?eUthYUZWQ1lxVnl1WFNkb3AwR0Q2ZXNaNEFnQlBWdzBtRU5FeW1Bd3VXMzFt?=
 =?utf-8?B?a2hqNW1wK1FpY3hEcm4xQ1N6UkQ2bVBXalJVT243UHlZd2xHQXdXOGhtZ2hV?=
 =?utf-8?B?WWZxcXAxanRmODRvbW5PTzNPZEdXYzlVNVhuN1AxZldSLzc0cnlrRzZ3RHBM?=
 =?utf-8?B?TE1CLzlqUklXVHpva0lKNjJHaWlYbWd2Wmo1d3ZOTWFyMkZGKzNpVTcvcEJL?=
 =?utf-8?B?M3dyaHFLeWlza3hKTGdycTQ3cjQ0VlJaN0R0OGdYUjUrRU1md2FjeGYrRTZi?=
 =?utf-8?B?R0x5Y3NBRjBJdngySE1ZRjZKdk9MWTRYVzIzWmNQb1BTOEQ3ZVg2UmxXVEd0?=
 =?utf-8?B?SExKcFVtcVZvMHY4RnFXdmNaSVRCVWVtWXV2UktFMGJzMDhrV3c4UFdYNmxx?=
 =?utf-8?B?V0ZzVy9JcXFPT1l5SFpzTW9yclBOMHZ0aXp5MWswTFJ2bVQ4RFBhU0VaSVFz?=
 =?utf-8?B?TkZvZ1pzN0x1cmhIVXlRTXYwTHlLNjkzYUVXY1Q0WHczbFlLNno2ejZJOUdn?=
 =?utf-8?B?OUs4UWh6R0JlYkUwRUQxbDZVUEQ5VkJyejZ0V2RLWlhUTjhOK2lNVkVSTEdN?=
 =?utf-8?B?QlJSWEt2ci9NTVZGMXJPRlNQYitTY2pEVkRDZm5VMTlxUE9OL2hJdUFJNmtz?=
 =?utf-8?B?WWc1RDRMWURLeHNoZjBxdWxJZ00xYTVkQTdWNVI3NXBjZGZzTDRyb1hkK3FN?=
 =?utf-8?B?N2VIWkFwazFLbHJVLzVyb25uUFI3K0NaTmhocGZaMXJwNlUwblFMeW5hZTE3?=
 =?utf-8?Q?spbwtfronJGn8KgfiUTzezDME?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea70abd0-5afa-408a-6f9a-08daaacb1510
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:24:03.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVt1us6Cv/94r4noUY/MNOHc5UJpXUZ7Q8aaexPBpTWp4p3tzCSK09LR8Ter7uUlcJlqBjXsvdnpOQnGKbXW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,
Thanks for your change. One comment though.

On 10/6/2022 7:19 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1b6b437823d2..6a487f52e1fb 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
>          struct gpio_desc *pex_refclk_sel_gpiod;
>          unsigned int pex_rst_irq;
>          int ep_state;
> +       long link_status;
>   };
> 
>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
>   static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>   {
>          struct tegra_pcie_dw *pcie = arg;
> +       struct dw_pcie_ep *ep = &pcie->pci.ep;
>          struct dw_pcie *pci = &pcie->pci;
>          u32 val, speed;
> 
> +       if (test_and_clear_bit(0, &pcie->link_status))
> +               dw_pcie_ep_linkup(ep);
> +
>          speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>                  PCI_EXP_LNKSTA_CLS;
>          clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>   static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>   {
>          struct tegra_pcie_dw *pcie = arg;
> -       struct dw_pcie_ep *ep = &pcie->pci.ep;
>          int spurious = 1;
>          u32 status_l0, status_l1, link_status;
> 
> @@ -515,7 +519,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>                          link_status = appl_readl(pcie, APPL_LINK_STATUS);
>                          if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
>                                  dev_dbg(pcie->dev, "Link is up with Host\n");
> -                               dw_pcie_ep_linkup(ep);
> +                               set_bit(0, &pcie->link_status);

irq thread needs to be woken up at this point. So, please add
return IRQ_WAKE_THREAD;

Thanks,
Vidya Sagar

>                          }
>                  }
> 
> --
> 2.25.1
> 
