Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB87A1E09
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIOMFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 08:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 08:05:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B103F4209
        for <linux-pci@vger.kernel.org>; Fri, 15 Sep 2023 05:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIB0IMbriysHjr/t8EzBZ077kRJLpaApjLO5l55a/pK72F5+ehHge62Kg/AgIJwBkXEv8YIlhVMAdF3L2i8HArt3VUATy6lzdjODqc3yF+d9zZ4RjekZxAflUcv+Nlw5Ljg2fYgT4N1ND5jmNBEaUzg8pcjslRkU9SZcYjw0GkGEdJK5CbabuMZZYl2gxatFukbfV7A3VnqsqNrN0P/Oa4riTSKw2D624ixjG2JxdCrinTlZUbTDtDd/r1EQCpBXxuXArclgOt13HZ2cwKSRNzsDijFv3PzYY5dxWAwywXxp1SyysdCuX8IcTgb31EUYOtmRVvI1pTT/7ge4Eoowfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDKIllUExeY3iIrgG2EbXIHrVyvNWRQfolTqU+i/BEk=;
 b=X1hfBxVZAW8Y9xN1XX+9pSo/fCFLdo7hDIcpBf1ybKWW0uLYVTxauAh0VDe7DL/PUpgPgaxC/ZQKdI5+rGHigLsBScJi7d4OEHT0ve7w1FmStUgmjPoG/lwxJxFAMmOFw8PvEl8vD30c+NESxEJj2OlD8XF5YGZ9bku1DmEn8FPby2950mBuyVaJ4KZ6LctHvy+crBM6qjcEEW7yx09vuk48yh1b6zwiVNdR7weIxcqkYPraKHiBxOkj4F+WgI6GQlGBd21GGMrONsd4qBQy4o8geZ4H0KgNz6L7Jtjg581hkE1idE8rhG09oEkIP3TZVKj+Ka/MG9ViXGgfIxsdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDKIllUExeY3iIrgG2EbXIHrVyvNWRQfolTqU+i/BEk=;
 b=tfur87nP7N2uOeiuUspFgpxfSolJVAWHm0rOzonPgpo0E7mmebwiq3SNDzw3drFjhtTP/VISv2p6iQZzG5u3WqI63Mk9EUHlAQu2PSAOh4kCZvODDi+z/dq8wztv2bWry2TIFAj14BKiQznRcZS1Bty/eQ31bl4OFNgdmX1IbFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 12:04:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 12:04:14 +0000
Message-ID: <5a562f6b-6e4d-42a1-bbc1-08f7f3279dfd@amd.com>
Date:   Fri, 15 Sep 2023 07:04:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230915023354.939-1-mario.limonciello@amd.com>
 <20230915023354.939-3-mario.limonciello@amd.com>
 <20230915070802.GA5934@wunner.de>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230915070802.GA5934@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: c201f9f1-b12d-4171-af7c-08dbb5e3e154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46aY4hczR6riGzctQ94nuBb8KjP6kEfYjEq0shSFXHcqOxU0NCcniS6eCJuNTj9Yh6SShA2T5Z2KwwSZbnK6wpCiIHrEElW21YCw5lVpSMUvmOrCeTyGPQiy5ovd3ASvn5jdu3Q3HwREOhY4Xciz8TxV77XGgs0OEZwcJf2yHUwxoc3y5X35r57qrXF5Sxooc9V7wqwrNfkyU7pg259PLV/9ZbtE8B7Mkl02xZoDDcTqlnE4rFBQYVEVzLeN7cIyuwLlA6W6vmFtIwWcZoLcaCQVZGT4glz4YJ3pmOz4zFxNUOMm3Axn/t0IxtRhgPEinElqnTY8WTVta/LzEcJPtuyhgYWGj7QuJTVL7jr5/wXLWnzVJm+LvlOvEME8624MtrJFr0tpLcUfgbLhvSczr9gelX3NZIwFtT70muTx9d7Jxg22WbYXiG8PS3K88beMdKoi5Qc0FDMI6XjYOpL4P10j3CnC2fz2CrBKalIB+8hfdkkLOBuUWEvi93IRlCtxRAT3C8WH4MeCgIxL1qH8YfktGXgwKqOWBdVhEp1Rhu0Vg264uUAdw7cMdi3Fg4hBH5Q25hkSmNw+/WlDT2Wz0f+LDrTltUunA8uNusl692xQ5tTAE2A26ttSu5P9zoDtMrXkbS3++2cU0CQHtZFp6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(451199024)(186009)(26005)(2616005)(478600001)(6512007)(6486002)(6506007)(53546011)(2906002)(6666004)(4326008)(31696002)(5660300002)(8676002)(36756003)(41300700001)(86362001)(66946007)(66556008)(66476007)(316002)(31686004)(54906003)(6916009)(8936002)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFc1U0lmaFIrNVpuc2FYaXFwSTVDUnN5S1hmNHNyRFZIUnNNUUtmMEtnT2Ry?=
 =?utf-8?B?MER6blQxWXFpakNtZXF2Mi93SEx3dnl2NnR1YW1KWUhHb2VGYWszM3RZMVRM?=
 =?utf-8?B?UEoyUnU2WW5CNzk4VGRDZ1laV1IwSUZ0V2ZYVlVDZUJXN3RrZHFGbDJ6UGNW?=
 =?utf-8?B?SWdpZlRoU0hvZVYzOG11ckFtZFNkZ2l3YitSeEdlbGNmekVvVmY0aWlyMU81?=
 =?utf-8?B?U1FqdlBxS1lVQ29RckVyaHdMYVBPVytWZFdQZWZrYWFOWjc5WXVoWmxDSXNO?=
 =?utf-8?B?eDVTLzJzU2J1NjZ4Y29HTC9JbzNCdlJDVENWT0xQZ1d2R1VESDA0S2gzbGFy?=
 =?utf-8?B?QkpFSFVlTWczb0Y3aUsySExYWGJjU20vYU9lL2dMdmMwQ1AzN2hTRDZFYzBo?=
 =?utf-8?B?U1FrampONDZvTzBiZXB6K1EzK1dDUXFPQk9sS0lRS1dlRnNtWkhMZWxKeDgw?=
 =?utf-8?B?Sm1vWUV0aTVjOUpubUt6SUpna2NMd0tPTFVZaFJJUnpWblc5Y0dtQ2o2MzZT?=
 =?utf-8?B?ZXhCQTgxZGhUMDlYOTg2QTI5RUlhd01hVDcxOWJnaERlQ2ZnYXpKNFhZL2lq?=
 =?utf-8?B?a0dUTzBqVkw0TGpOWFljZ0MzWkpKWXBoc0RwQUlKWFNKOXpERTJ5Mm4zbEpt?=
 =?utf-8?B?cVpTN1RtNlFUMmR1eEhUU0JEeDM0NFRieGl4MVBxZFhnVDFod3IrYnp2blY3?=
 =?utf-8?B?RFNCWG5idDdaelQwVVRIYk5BWXVyaHJ0OXlyR0tyaEk5Wm1lWW1qRlZMdnh4?=
 =?utf-8?B?ZVNGYU1Jb1RsTjFxYzA4WHRnWmY4QXR1ZG1PYUVDcUJsalF6UnNobXlCVW1r?=
 =?utf-8?B?QUdYWkZsQUFudzFNM01JZ1VXU0dtNmNXcGVKVW9jUXdyc1VjSTRJeDBVTFRz?=
 =?utf-8?B?aFFtSE5wNjF6SHRJeFZtNnp4eFZSTVFXUDFzMytMWVMrcnM0dzJydzRzMnlU?=
 =?utf-8?B?RDg4MnNVSkpORmpQMWFlUzMvS3lpbWFlWndQUlA0a2xueHArTnZlWU1ublVk?=
 =?utf-8?B?V25ib2w0YW9lMWhZdnN4TFR3UmZjcHB6V05HMStsQ0FSbllTNytVUWFNa01R?=
 =?utf-8?B?d2RNQnVQNzJCdnU3N3BpbWxCanB1MGl2MmlKczhpcVlpbWw2aUlTcldwSUpV?=
 =?utf-8?B?UEk3emYrMnFvcUZTTTJ5TGt4QjA5MWo1cVJoWmtzbEs5cEZ2TXBwRUxLMHZS?=
 =?utf-8?B?TDdhSzBsR1QyeFBCRXY4Vi9vVW96b1BFZjduYW8xTzlyZGpGY0FlM0pEZW1v?=
 =?utf-8?B?TlA0aXpqbjluU3V5YnNSTmI1eUc3QWdkOUYzVlovck5Eb3MxWFNGWi9mMXli?=
 =?utf-8?B?eWpoemJ0NHU4TnUzTDNjRFZEWGxCQkprNFpvTVRLWjlDakpWMjlNNkxaTXBr?=
 =?utf-8?B?Ykk4ajhLckNnQUh2c3kweTFVRm9ZS3dGODR0ZHJHUjFJK1I4Z0NLNTcrRkxj?=
 =?utf-8?B?cFhQUlNvczVaajZOYlc3dUx0eTFBYnJNZ3d0Rm9hNHptOWpOSUhVL3pYRWYx?=
 =?utf-8?B?MktFRmF6WDIvbkE1M21Wd1IyUzdqYVR4eWJkWVA3TmdPRnFmTUZqeHNGWEFD?=
 =?utf-8?B?c1dDNjZMcEl0UHlUWXRpams0ZCtRSWZXMHZnWC9wVHpoQ1QyOWV3dkhxNzJi?=
 =?utf-8?B?UFpLYXJMLzRRRC9iY0R2YksxM3dkbVo1Zk1Kd1h3L1J4bGc5SjZ3T1hOMVV0?=
 =?utf-8?B?Nkg0SFlmZU5vMlZ4QVVuUHRFS211cjNGMzNJVjloUUNQY01uWi9nd2JlbnRH?=
 =?utf-8?B?QW95Vk5CSWJnQjU5Vmg4NEtNTThRUXNYWHFEVDBlU1VXVzZTRXJvN3dkU1c0?=
 =?utf-8?B?cUpEaUdIekViUVJKYjVFMkxueHNxQUFGbUdxdVg4R216Nkc4ODFWRTUwR1cr?=
 =?utf-8?B?UEUwRkMyV0x4em44c280MzJ1QTFUVlpMNUZsYlRHTG5uRTd3L2hteWpMeHY5?=
 =?utf-8?B?VEdobjNiOFVveFphMEdrTks2azB5VVVkYlhvalJKK2hqVDQrZHZCMHFzb3ln?=
 =?utf-8?B?TkREcGdUQjhDbnZQWXJvWnNvVlRpbzJsaFNxWnpNV2R5QkJYSGU0VkN2bzBk?=
 =?utf-8?B?WlhJQmRacVhmMHJhMGRVSWJROVlWYmZYSkM1WU5nZVUxRGsvcHQ4bWRVcFFs?=
 =?utf-8?Q?lRfrEFiDyzCJWybyMC3MehUzz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c201f9f1-b12d-4171-af7c-08dbb5e3e154
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:04:14.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzgTsarnYNiYqXD4NGxnstEbH41XRrWadQW8hnQ0xpdmV9bMW/9HWU2csCLCo5sAbbYbNwuQlp8S/FvmLQBwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/15/2023 02:08, Lukas Wunner wrote:
> On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
>> +static bool child_has_amd_usb4(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *child = NULL;
>> +
>> +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
>> +		if (child->vendor != PCI_VENDOR_ID_AMD)
>> +			continue;
>> +		if (pcie_find_root_port(child) != pdev)
>> +			continue;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
> 
> What's the purpose of the pcie_find_root_port() check?  PCI is a hierarchy,
> not a graph, so a device cannot have any other Root Port but the one below
> which you're searching.
> 
> If the purpose is to check that the port is a Root Port (if the PCI IDs
> you're using in the DECLARE_PCI_FIXUP_* clauses match non-Root Ports),
> check for pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT.  (No need to
> check for that in every loop iteration obviously, just check once in
> the fixup.)
> 
> Thanks,
> 
> Lukas

The reason to look for it the way that I did was that there are multiple 
root ports with the exact same PCI ID.

The problem only occurs on the root port that happens to have an AMD 
USB4 controller connected.

