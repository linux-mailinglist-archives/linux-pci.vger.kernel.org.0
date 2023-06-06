Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2E724B5C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbjFFS0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 14:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjFFS0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 14:26:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A23170D;
        Tue,  6 Jun 2023 11:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nny+LDiDRuqVpFYxihzDFa9zKg7IWFzlUF/+MUwE0gRON/eNl1Cwvg4VJjRGSAIxi80fyQFDfFdk4A8I0RA7JpRPZJlhjBwTHJ8phXJ1Da0xYRQp7hIvhieLS/Lp1A1kLQe28auOomiB/JrybUkPTHmUUBSBW7l8OacWnTA2y7MmmNJDaecFIirkwRescCwdmV/7F1ubDYHTzyw1IYOVFN4HMYDpd0l7eP6OXpVg2bRCy797mW83UlXNLasQJRxDBV9T0Pvt1Ga2CN6hW5mpFD6w1J11FuRShWQErDjid2dGq+V0LF2NQ6vdZTx/vTooMTAgNwx3Nk5zB/qPwFgtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvwVSgfAQs0YiV/Kbmk3qNPOdYbHnbsai1Oaf6C6kyc=;
 b=XPROE2nQRHHKd9cF+cqoByMQ7h71NGFSI/hKgSwLUxx/WufpCmaz9vIrm1RdXxomnKBOi0wvgTgnkLYUiEPdmgTCab8smQtGgWSGgPTFZK5y4+LMzbeKvPeFrkZs4df8XEHdZ7zzMghwLFY6rG1ZSPbKxK7xK5mQ9SPFUpADyFOuKsiSrdk8idzNPiAZ/+pgUNHk2gl0kH/9a6ssuzD7YZCbuerStkj3X5unHMltXPbL7Bx6aEe1YwSkNE0hjbJ2/HxHBow6aUcLjI0M7qKidoztlXx8bilH8pkWsveWJB5ydSEU1Ys0J7NIYnx0rBt+xa0QR07E9uTiW5wDMohYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvwVSgfAQs0YiV/Kbmk3qNPOdYbHnbsai1Oaf6C6kyc=;
 b=JXzcnitL24q8AnOrJj8gRbo+1A3OQpTg1lnfdJtdfppwaEMcCEttsmUpcUmLfn8SFYjvNF0Jy99V3QRx41bvexRTUi2DGI+Dwia7BCy1bG/8XfTY/yZ7mijeF+QV+X7EJU+lI7HyLkrccSM9syIbnPQ7tvl8V3fenfyZO9NTBK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 18:26:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:26:35 +0000
Message-ID: <598b2c2d-bfb2-da5d-f8cc-7aa1fac4c410@amd.com>
Date:   Tue, 6 Jun 2023 13:26:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230606162321.34222-1-mario.limonciello@amd.com>
 <CAJZ5v0gzfCXmPm7Jckt02FF_PJY8VJPPUeoE0gb8twbP+M8CxA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gzfCXmPm7Jckt02FF_PJY8VJPPUeoE0gb8twbP+M8CxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:8:2b::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a24b33-a407-417a-1426-08db66bb8f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCiCU92T6EjPSaEl8AWc5CH8YXD1ESpIAH89eTJ2wngQdnV7vB9tb4BeK7NavTMUO+VI5byBdwWnJLaluJ/mtuAPUtgrFnnTWg7ZSF/VK9qsg8Kp9v644gGELkM7jSGW6QOv7IlPTqN07ne7wO7g+ORVjhsqS2jn9M6FJEy/qCNfYHjDr11fyFXTF6KR615RlRs2LhEhuNiJMmO/1fteR6Nsb5fgCarnzF+W65yCduB3LnbhSJS4aalbuU20OrdC8SwxZ2iaMe8Ul97YxAbZhGf99tytlreLW/iMaXe1yX2/cJ6qiGUddDyeipWD8AKXj7YR3ABXjWPgh8hzRB9ky1FigWf+qGy3EKk9GQObCTJlgawcm550Oj2CZCYEO49CBIwIFNw0ERmGvVk0Sy90bfgCic9M2DeW4sKezyB6zSNUlgFHIAw4FqQWJw+0aS/2Lil06ogM2OhhsbMWHOn52tDH9wla8oFBhwNHL05JcfahH4pXcUg09bCjSJ6W/Mh9jougdISaa63v3xM0E3lfblZVs6OiEWtR+zOeRrbo6Ebmwh4gmDLkCVdVVTJh3WdESHsy0KZm+BJbSNbxF+ubnUhy12vMJse7bkn2W7IlyjhsHrMz7icnP0aTCL060WTkN71OCxX+aOMlO6wIB1hE8fI2eI+2htaHIAR0w2V8DnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(186003)(110136005)(478600001)(316002)(8676002)(8936002)(41300700001)(66946007)(38100700002)(4326008)(66476007)(66556008)(2616005)(966005)(6486002)(83380400001)(26005)(6506007)(6512007)(53546011)(31696002)(86362001)(5660300002)(2906002)(36756003)(31686004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U253bGd6cXFUVC9jUnVseU9waEpwR1dENVByb0Nvc3haaGxsTDVXRXIvNFMx?=
 =?utf-8?B?TFJEY1MxeitsaS8rQ2JDOTkxeW5ic3R6UzZGN0xkMGFsWElEVGd4aDNqN1ZR?=
 =?utf-8?B?bFhzUkZJZmxLK0hvSVA2d2d2dDk5TTNkQVdGOHF4ekJLLzdFQThXYVFPRTJo?=
 =?utf-8?B?S0RBRUtWZHVxaWJjdnVtNko5M0prdndlZUJ3UzVqTll2bnlWNmdBWXJGbmh6?=
 =?utf-8?B?VEt5bnBpdzF6UHRZYnVKS2FvRjNrM3lKYWVLQ1lkWFhBSGlWWWk5VU4zdjlp?=
 =?utf-8?B?SDlUdUMzR1p6SkdHMkEzbEpnY0VhekxVK0dHSFRkU0dtRGxJUmxTQVdaSVdm?=
 =?utf-8?B?Z1pUYjdFajU2dmV0dmdYdmlzK254VVdVb3BQTVduMXRMNWNOZTFlYlBlTjRa?=
 =?utf-8?B?c1Z6aVdPY2t5ZXVtVnFpS2dGUVdwZ3YzWCtRYlViNDlVMmFBOHQzR2RtSCtu?=
 =?utf-8?B?NjRTaHRkbFNTZnpoUGlLSWdnb1JFUFZIVTM4b3pyQ2E2NEdXQ3lhQzFFaW56?=
 =?utf-8?B?UkZCUnQzOXMvT3hkRGoxMUxEcktMQTltWHA0K1FGOFpXTlQxLzUzZXRVU3Vh?=
 =?utf-8?B?cTRIUzBMNXhUK0RTQWsxRCtoY0hEVmNLaEJnejVqY0kwZFVUUEEvN2phRmRU?=
 =?utf-8?B?V0xaRlJRazB2bFVzU0FzTHQ4WjBsTkJpZzBtR3g2eEpyZnlacE5ucHU0dm5O?=
 =?utf-8?B?K1VqRkErcEo5OHZ1VEpkVWE4ZGpUdSs4dDVtZ0FxTUR6N2RIbURLWWttYkND?=
 =?utf-8?B?ek5jRWpzbDdZS3YzMFplZVFHSGZFVS9IbTNKbXhMUXM4QnkwUTdlMkpZZ2sz?=
 =?utf-8?B?R0lyN3o4YktLZ1RYTk1OY2lRS3lNdlVIUXVDTzBoak5KenNON2xlWWRieFVO?=
 =?utf-8?B?YjN3ekxuQzI0R012N0p5d0lNWjJPdXFQdzBWWHBVMnJRempUM1ZicTB5azkv?=
 =?utf-8?B?MlhqaGtuRjlFZDVjRDBqTTIzR3VjSEZoSjBnRGs3ci9PZks2K3dGL0ZuSDVM?=
 =?utf-8?B?ZTdvZGxPa0w1NFhzcC8rc1lITEhrcG1hQTZmNWNTdTZneFIzVlJpRFU5WUsw?=
 =?utf-8?B?d1crbC9jb202VDhhcjIrdWlXWEhuVVZUMkFQNHB1UTZsS0pmeUxRWXpKNVAz?=
 =?utf-8?B?WEdEUDdjb25idGl3RmxMZHgzK3BQYVR4VjAvS0NxdGR2Ym93b0p3SG1lZ0hU?=
 =?utf-8?B?ZFB6QmR1d2ZUZDdwcnRpcXpSL1FCd0ZGc05JdDZiQ3lGZmxDdmFCR2V0V1Vr?=
 =?utf-8?B?ZWt4cWd0U1NvNDlOWkR2NWtyTmNKZjZZVmJYMm02MXdRT1hWVHRZZXFPQWhW?=
 =?utf-8?B?cmJhWlQrejBLekorWEYzb3pCS0hWZnBEOFl4ZUZ1bG1YaUhaaFRrWkE5dEpY?=
 =?utf-8?B?Q1B3VWREUFZoVllxeWRZcGpucGF4ZU43TlVPSnBJb3FHcm54c3VUWXc2MmUw?=
 =?utf-8?B?a0xDZmNYSEV2TVNRZkVsVm9haUpqb0QxWUJvclVhTStncEdmTUFQZnBGWHJV?=
 =?utf-8?B?aGF1U3VGSHR2TW54SHVXVkdVWFBkVnFpTVlhNitQNzlpSVFsYlp0VmEzSGd6?=
 =?utf-8?B?b09WcFJVSlNjK3hzb1R5K2RaTndTSzkwSUM0SGRzM1UzYlV2aHk2Rll5YXkr?=
 =?utf-8?B?aGZ3NkY2ZENqbWdnNThXSEplNjh0S2VMYlF2RkEzZVZYSVZBWHlzT01NdXVu?=
 =?utf-8?B?ak13Y0ZJNW84WVZnTXhtRmppejBMSnlHdC94QlpDNUppMWtLQlNWcDdhTGxu?=
 =?utf-8?B?WHEwNnpsRHhzYTVZYVArMTVGWUduemI4WW1LOWY1c1c2dVZwMTNXWXNEQ2to?=
 =?utf-8?B?WWZERXRZRGZDQ1BwNjJrZ2QrNG9MTWZFQjBJazhEYTQ1TEpoa2pnL2xHSm16?=
 =?utf-8?B?ekYxc1lLSEwxblJKTzhLeW9tVHJLN2JiYVJid1BUY2JhN1ViOGFvMHhUaXBD?=
 =?utf-8?B?NDFzcTlwZkl1ZXFJVDEydGRablJ1Y2VmTUZOMCtPd1lzbWhQV25iNGdENUtj?=
 =?utf-8?B?NEJwT2tuL2lxam9Qa0lqSmF6bzNRcUpXWFVWaE9CS3FFbkx1U1ZEaDNLTjlN?=
 =?utf-8?B?eHcvV3QzWHBWU3NucVBTN1VDdnVWWit5N1JObDdzZ0hjenFZQ0ZEOTdqdWY3?=
 =?utf-8?Q?l1peotGb/LpWVGkOAB1fln3cL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a24b33-a407-417a-1426-08db66bb8f5e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 18:26:35.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlBVQidGBEUA2vFC6RN6z5+kDIDAq0W0cKEkQum1W2Sq9bRtno2Fz98oVfXo+t/LnFk6Y11/NzAZZpu5jUc64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/6/2023 1:21 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 6, 2023 at 6:23 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> ASMedia PCIe GPIO controllers fail functional tests after returning from
>> suspend (S3 or s2idle). This is because the BIOS checks whether the
>> OSPM has called the `_REG` method to determine whether it can interact with
>> the OperationRegion assigned to the device.
>>
>> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
>> code on the availability of an operation region.
>>
>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
>> state of PCI devices.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Handle case of no CONFIG_ACPI
>>   * Rename function
>>   * Update commit message
>>   * Move ACPI calling code into pci-acpi.c instead
>>   * Cite the ACPI spec
>> ---
>>   drivers/pci/pci-acpi.c | 10 ++++++++++
>>   drivers/pci/pci.c      | 14 ++++++++++++++
>>   drivers/pci/pci.h      |  2 ++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 1698205dd73c..abc8bcfc2c71 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1209,6 +1209,16 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
>>          acpi_pci_slot_remove(bus);
>>   }
>>
>> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable)
>> +{
>> +       int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> +       int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>> +                                   ACPI_ADR_SPACE_PCI_CONFIG, val);
>> +       if (ret)
>> +               pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
>> +                       val ? "connect" : "disconnect", ret);
> s/val/enable/ ?
> Then I don't have to remember that ACPI_REG_DISCONNECT is 0.
Sure, no problem.
>
> <bikeshedding>
>
> I would call this function something like
> acpi_pci_config_space_access(), because technically it is about
> allowing AML to access the PCI configuration space.
>
> </bikeshedding>

Presumably platform_pci_config_space_access() below too.

That's fine by me, Bjorn?

>> +}
>> +
>>   /* ACPI bus type */
>>
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e38c2f6eebd4..b2f1f603ec62 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1068,6 +1068,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>          return acpi_pci_bridge_d3(dev);
>>   }
>>
>> +static inline void platform_set_register_access(struct pci_dev *dev, bool en)
>> +{
>> +       if (pci_use_mid_pm())
>> +               return;
>> +
>> +       acpi_pci_set_register_access(dev, en);
>> +}
>> +
>>   /**
>>    * pci_update_current_state - Read power state of given device and cache it
>>    * @dev: PCI device to handle.
>> @@ -1645,6 +1653,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>>   int pci_save_state(struct pci_dev *dev)
>>   {
>>          int i;
>> +
>> +       platform_set_register_access(dev, false);
>> +
>>          /* XXX: 100% dword access ok here? */
>>          for (i = 0; i < 16; i++) {
>>                  pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
>> @@ -1790,6 +1801,8 @@ void pci_restore_state(struct pci_dev *dev)
>>          pci_enable_acs(dev);
>>          pci_restore_iov_state(dev);
>>
>> +       platform_set_register_access(dev, true);
>> +
>>          dev->state_saved = false;
>>   }
>>   EXPORT_SYMBOL(pci_restore_state);
>> @@ -3203,6 +3216,7 @@ void pci_pm_init(struct pci_dev *dev)
>>          pci_read_config_word(dev, PCI_STATUS, &status);
>>          if (status & PCI_STATUS_IMM_READY)
>>                  dev->imm_ready = 1;
>> +       platform_set_register_access(dev, true);
>>   }
>>
>>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index ffccb03933e2..78961505aae2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -703,6 +703,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>>   int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>>   bool acpi_pci_need_resume(struct pci_dev *dev);
>>   pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
>> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable);
>>   #else
>>   static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>>   {
>> @@ -742,6 +743,7 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>>   {
>>          return PCI_POWER_ERROR;
>>   }
>> +static inline void acpi_pci_set_register_access(struct pci_dev *dev, bool enable) {}
>>   #endif
>>
>>   #ifdef CONFIG_PCIEASPM
>> --
>> 2.34.1
>>
