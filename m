Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FAC573C4A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiGMSAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMR77 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 13:59:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696E286FC;
        Wed, 13 Jul 2022 10:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ+pH0TpAj90ZbWaOC7HVbBtEdzr/0tmkSsasprpjDWkkQ2Exc0JjIe/A6/H8LOMmlGhXYCl/lNVP6u/8L5nNnmrMLaEzQB0FR8EzUxse09MbUwN7pHiFOilkmFf0EXlynfvOxu4Pym5mRMCEH9K8z5mv0xPqFwhr51yKCpNUwfKTRYocslPNlWXLknylN4vB4nmGSbAoU9t2KXWQlBGKD9NGZxrLfoVZSkRsJPnvBK+xPVVhD5ViHVXXvkBewY9PbCgkVZGJz6aKSX8A63JeX0YmV8JSCG+j75u8azRXLRindU0jRP3xhTYYmIxlhdFDjFmGPyVkkPf90vQymG6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLKV8VOj1R0zbp/TMd9CmmTYHRVONAPcHKu7KeJxsCU=;
 b=WEwbbWl8aq91eDYBtHjSBsW7+HQFTPt2u6vxxUaajXqQ8DO3twjHc+gol3nAG7QQujzXXQ9VLNDpMGUrafwhFfM3REh94fQ58BAQlrfJo6etE87SW2LG7e6q1b448iz/OWN+CI87nqseBPLgBoJJXw8BIDKF3V95wL6ygSKc9lqPLWPca5HkikUGlgRlSBX7LUyAzxT2MnRSBzdrUkmR+UEARDJidLpih5PuRPgvK/c3hvg7AaHdjatHMyy6yulQAJES/bxWsbO9RFlXNK3Fptt2VCRvTCmPr3RVazFsmD52NeTzyZyKGCYkEziNcD2BJ/HdekVF8ToKufIhjtdRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLKV8VOj1R0zbp/TMd9CmmTYHRVONAPcHKu7KeJxsCU=;
 b=t32Az+VtfibQ+b6IxhOmuET/gDwc7cgJLiBr2zUnuxK8M980Q3C3budROqnWTjcN+kfdjLV1CQ8GqpLFf4O0PXGyw8S9CL8tJ3v99uXn+mv8k4j0xEF1MpkbHX7rRb8QMad9o3TgirSJkymc6nGv/an/9+oL0mwxFyY/rnrR5Vdw3lNvrN0oKmChHbBgK8mr4NFqemHczD5Em3TcMVE51HN7E52W244QUqjapIT6RuaUphK7HMwDIG5gD/bEMHxGZktO63B+OI9tDzP/GAyj4OWQwFvwst+ZFRW/ya7UM2l5uHlJ5URgYTau6ndZg+wEeM73if18iI9kV3y5dkGlkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Wed, 13 Jul
 2022 17:59:53 +0000
Received: from DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::6c29:e869:e4c3:e547]) by DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::6c29:e869:e4c3:e547%6]) with mapi id 15.20.5417.020; Wed, 13 Jul 2022
 17:59:53 +0000
Message-ID: <73afa23f-73a0-81ed-c194-fbbd864a097f@nvidia.com>
Date:   Wed, 13 Jul 2022 23:29:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com
Cc:     benchuanggli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220705060014.10050-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220705060014.10050-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To DM6PR12MB2907.namprd12.prod.outlook.com
 (2603:10b6:5:183::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa6307d-91b0-485d-11c5-08da64f97cb3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtaqMTnlQML0zzltp1TUfNHxCFreHzhtNGDCwdB6HbvhtXlVCTVOyfjChHWxvRQPRztnnreYCo6ZTSOzA8xh1xuO/YKtV71mSqEFUeNLU6dVIKUyk5waXNoy00ACcTbVl7gAqxljVlw/uMWIxHa/vF9zTzk9qXwEXF8uYpYmj3UdTv9nUpr+DDqNkUnvmveSEJtWjzv/SGPiyfKPdeDYPDlm9fVo+OFPmmXPxE6InETRXMenp6J1OBZIz8tnXbkZ0dZnW1n/qy9iHaZ02spgGpTYq56/7kll951o1luBjCrUQHH/mhbTkAo7Aqz6hLn7j4K9xAB3c5v1l/FQDJayq08NgDBrZaF9e9Apu7ql7HkEtPC1l7QyosM6qSAHAa6SqshG2SFn2DOIB6na/36rChY7bMelMiBfGRevTZz4k5IOiwpRKMxugvng7n0G8WUxjpbDNyV6AJalS0KvObqr8M/xdT0k4yh+jWQzmJghGVccsTuqZ1m/f2ppwhMb7BkHOq52q6T6U29TmXE35bQjObKQIrT1qu0C5HA1EoyTLcWuRwp0EBNGPs/fNvE4d1LqUDkI12oyOnOV9J8V/W15v2inAECFdd52pRAEWkIwmJp0kQkGveFEEp1lK4A1BJpbtrMT1Cs0yROKul7A1arIboZXImechJxxsdKP78hrKWHg/syrwGLQXikyz1DM2NT2c/SzxgSqXNWJmfLGLdVc2XpyfZRvL8eSQOPmTeJtfx9ShxQChojYBbQP+ekTiTW0Y+HTgpB/XQCRbfyZGxiL7t/oeGtaQkuZMlj86SK/OJf0igsH6SYwGvDJQFjUG4paPrVbCj0kcSHxvzcOsH0d356i+pwOVTwY7IBmIFGuQJAd6QHYCHc8lu4Zehj2oMDRPq75FFIlhREhYWfDpVuYfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2907.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(36756003)(31686004)(2906002)(38100700002)(5660300002)(83380400001)(8936002)(7416002)(15650500001)(86362001)(316002)(8676002)(186003)(66556008)(66476007)(4326008)(66946007)(2616005)(921005)(41300700001)(6666004)(26005)(6506007)(6486002)(6636002)(53546011)(6512007)(31696002)(478600001)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktVaHRnalVlSngyUmlBbElDTGpZd0xaWWdEdDkwck8wd1R1ditEcWVhUkVB?=
 =?utf-8?B?NG5SM1JmMGNFUndMb1VWc0VFam85eVdQaHF2UXBWaEFDTWpyMEo5MzBUdXZO?=
 =?utf-8?B?K3Y4eVBYK2xZb3NxMFQrMWVqR3VraytVZDBqVUxWSDBVSXpiL2IxNUlZWnAr?=
 =?utf-8?B?RXZEa0VBWHAwd3Q1ZEFWVHpuUEN2aUQwNkxzc3dsY216Tk5MSEZBQzkybTJT?=
 =?utf-8?B?Z1IzOW5SbTRxT1hZbTdUYVhEVGxxNzV3Qm91a3prVmJJbC9RZ21FTmJ2OVpC?=
 =?utf-8?B?bmp0MENKTmNiSGhERzgrNEZUMEZ0NElRSzN2T0tZaHJ1RGxZVlJHTzRTQVcz?=
 =?utf-8?B?UFVPd1JpaElxQzVUZncvd1VxL0JNaHNZRG10bEVVd09MQ1ZhcVZaRXNqWTZp?=
 =?utf-8?B?dGIwY2dsU041NzFaZ0pFMXlRaDBjQWV3RXVKZnZoNndlVmdKREYzZEtzQ3J4?=
 =?utf-8?B?ZVAxWVg0YWtabVhaR2hzVGtnOFFFMzA1bVVsRVF5OFg1SFFhclhxRjVOaTFP?=
 =?utf-8?B?cmZPSktzdmhpajVwNHFuUlFuNkJISTNuRFBQWm1panNMQjRsaUVuSEFFdDRp?=
 =?utf-8?B?dHRudExacHdndHl0OXdUdlR3SldJdE1uV2VrWGpaMllEU0VNazRHazNPV3pJ?=
 =?utf-8?B?ZVJkR3FXamxWZ28rNnhaQ2FDVFlXQUR3Rmh6SFVaV0Q2amtKMXlBUzdlSitO?=
 =?utf-8?B?SWhZOFRJVWxGeTNxM2ZOd3V0Z0JZZmI3cndySnUraXJZN0hCTWZhS2hBeUI2?=
 =?utf-8?B?Ny9jbzBzbkRRUnovcjVKbFNva3MxL0xuZjAvanYyVkwxU0RicUQ1akhZZWVs?=
 =?utf-8?B?dTJ3SWFkSDhzNGdpTFlPRlo3NHF2Q3JabHM4QnVsY0dFY2ZzdmpCQk03M1cw?=
 =?utf-8?B?SEFvSXBEUFJzb3E2cDJkRUtwSCtaZ0o2R05oczZsTmtxamxQM21ZMmVzQW82?=
 =?utf-8?B?cjZHTnV2S2xWdHFzR3RpcXN0QnVPRVN4YjcxcGpuWmw3UmpyUEhZN084YnRZ?=
 =?utf-8?B?cWo1NUw3S0tTZkZwWThENGQveWNtNGczRFE2SERBaU9Xa256TVE0Nmx2WHlu?=
 =?utf-8?B?cHQwcDdHVXh3QjFnMTlNUkhLaEpENGMxYmFwSG5TdWRJN0NJZnBDbWFja3hO?=
 =?utf-8?B?cXZLeC9CVXpqZS9vUFk0ajY4VTBXTm5ESkFwdE1WUTZBUG9xelRjYTlpVzlZ?=
 =?utf-8?B?UHcwWDg4ZWhnYTA4bm00TkJVcVNhQkcvSVRvVERJRWpoUW1kbmdabEtpcVR1?=
 =?utf-8?B?T2VvOE03OFhaejVXeGM5MDVXc1FBMzc5OWVFKzh5VGhIUkt2bVNGMnpjRXF2?=
 =?utf-8?B?L3lkZDJPQWNJOUk5ekNVL2MyZUJENXhZa3M2TzhsdE0raDJLSklUZFdmMG13?=
 =?utf-8?B?MUllR084ZEVKQ2xSV0tZUkVhakYyM2Z0K0pSLzhEZlh6MVFpMFlqNnRBQm02?=
 =?utf-8?B?Mmh1ZWs5NWxXNEZubVI3YkpNYkRpQXF3QVROa2RGaVZDUnNTU3ZJVjRwemI2?=
 =?utf-8?B?ZVpzSHNMUHl0bU9rNFEwaENZRnhQcTV6dzd1RXVYR0NrbkFhMldsNGRqTlFF?=
 =?utf-8?B?enk1VVNlK01JWEN0ZmdML08wQTV6a0txOU5xNDdsVGE5RVFzUy9qNWJ4S0ta?=
 =?utf-8?B?K3ZvQjJOYXlSMTdNN2ZqNG0xdzEwZmlYN3RZWHpab1Axd3EweVFnWDlKM0tw?=
 =?utf-8?B?QnFKbm00UEpJNUpnNWRGcDd2dWRUTVVTS001L1dwMmo0WW1taGhRZE5SS2Nm?=
 =?utf-8?B?Tzd0NFUvdXhJK1BHTlJRVHIvYXhGbWUrOE52cm5XeFJhUmpaUE1UbEs3NWI2?=
 =?utf-8?B?UkxGRG0zU3dvTk8zbVJ6ZlYxaTVtWkF0anc2N3YxSW4xcGl4QlBHc0xJYnp2?=
 =?utf-8?B?T0lXR2tUancxeVBVWGxtU1RZdUYySkFYUXorSWdGYVNkTlA5U1luS1hNdE53?=
 =?utf-8?B?OC9KaGhXZWdZY2hLcTk4SnJnL1BZRVkzdG5GMWU3N1FhWkVOcmlyZGJIb3gr?=
 =?utf-8?B?REg1YlVOWDBPK0UxZ3RhcG40dnU2bjVBMTU1UmxwcldvMVYvRmgxcUNwNVBS?=
 =?utf-8?B?RG84cWR6ZW5yclZpbzB1OGRWNzA0TDQvb0NEMXlFcytsQUlINlNSR2ZhZXNL?=
 =?utf-8?Q?TcZNZ+vw3YZwabPuWgTrt2pDj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa6307d-91b0-485d-11c5-08da64f97cb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2907.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 17:59:53.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvYn2Gsh/GwoWFXNEPMf0x+bpLoYwUdTr1RNoGkKbRRjaO2s7UthgRm+Jxax/yiEugosvri1YsmI8LUMBGkAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
@Kenneth, Could you please verify it on your laptop one last time?

@Bjorn, Could you please review this change in the meanwhile?

Thanks,
Vidya Sagar

On 7/5/2022 11:30 AM, Vidya Sagar wrote:
> External email: Use caution opening links or attachments
> 
> 
> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to L1 Substates
> configuration being lost post-resume.
> 
> Save the L1 Substates control registers so that the configuration is
> retained post-resume.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
> Hi,
> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> on your laptop (Dell XPS 13) one last time?
> IMHO, the regression observed on your laptop with an old version of the patch
> could be due to a buggy old version BIOS in the laptop.
> 
> Thanks,
> Vidya Sagar
> 
>   drivers/pci/pci.c       |  7 +++++++
>   drivers/pci/pci.h       |  4 ++++
>   drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..aca05880aaa3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>                  return i;
> 
>          pci_save_ltr_state(dev);
> +       pci_save_aspm_l1ss_state(dev);
>          pci_save_dpc_state(dev);
>          pci_save_aer_state(dev);
>          pci_save_ptm_state(dev);
> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>           * LTR itself (in the PCIe capability).
>           */
>          pci_restore_ltr_state(dev);
> +       pci_restore_aspm_l1ss_state(dev);
> 
>          pci_restore_pcie_state(dev);
>          pci_restore_pasid_state(dev);
> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>          if (error)
>                  pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> 
> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +                                           2 * sizeof(u32));
> +       if (error)
> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>          pci_allocate_vc_save_buffers(dev);
>   }
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e10cdec6c56e..92d8c92662a4 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>   #else
>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>   #endif
> 
>   #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc..2c29fdd20059 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>                                  PCI_L1SS_CTL1_L1SS_MASK, val);
>   }
> 
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +       int aspm_l1ss;
> +       struct pci_cap_saved_state *save_state;
> +       u32 *cap;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state)
> +               return;
> +
> +       cap = (u32 *)&save_state->cap.data[0];
> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> +}
> +
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +       int aspm_l1ss;
> +       struct pci_cap_saved_state *save_state;
> +       u32 *cap;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state)
> +               return;
> +
> +       cap = (u32 *)&save_state->cap.data[0];
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> +}
> +
>   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>   {
>          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> --
> 2.17.1
> 
