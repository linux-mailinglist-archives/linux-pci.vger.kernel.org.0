Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0508B73AB3A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFVVLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 17:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVVKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 17:10:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179D1FF9;
        Thu, 22 Jun 2023 14:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoF4CgDhS++UB4PMzKiXmIkCKRFz0hknpgm1ZHmi2EdPkBVUKrxOb0cjnzjAZU3dkEo29E6sQUBKcJ5j8wx/yH1l1upAyPBsQT2vOYAsm34Ga0Xnq6yipt02z3qD6xXBrki3l8+eoBchscLWzhRb5wRm9k93GDg9v6qpw+dh75KpxezuYeNPafsOICi5GexUlwZVB4p8t9qR8Qo3vM40A4xH6OXYYAAUUxIIZ4ywgt2a5AsmqOuAR1mPDwExsbYtCTabHyTGFIbDzTR/T+TyJhpHjpAsY4r+K33AgTb/e1UXE06LWOLGeGHg+DPNOLR0PNpmE+fquGlazCYoL6QgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYMXLu7gOTSYpx8nLEAmdrWhQsCV9WjB7M9/Fj/QOsc=;
 b=OpZgoo87WXbwbDQm6YyBfpfkD/FNsPeffxXOm9e+4NWrCLpHImMHY//+9AEKlZgsaXeISVyqQjVN+H8NDShVzyWmT1Qj0Ky8sP9NwITDRr3+QH26zZ7ASJTq7g0b+ZzYMMyPBvIQsqd+HpbHtWTWL9wxcHdYafZMiQ7gRkR2VlvH6MV4iC9n7dCNuNRmVcFZxlBu+NeUPOaG4JWQBTyaki85wrPEM3FbzjC+ezX6kJI8FLIMFpS39XWnhAn6lFnKBwKAZ8FW7VI4w6CreZturlzMrQa+bsxfyHi5e1KsM+V5JoDg8AOWfbrt7eDzR3kFXrzy5mpdtMidcee5PGiZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYMXLu7gOTSYpx8nLEAmdrWhQsCV9WjB7M9/Fj/QOsc=;
 b=1uEmZLiw99SwwpWw7fBMKWNh/REasAUdVQevvmfljYT4pIhiCavl9pHeb6ecBgxrvFaLuWZVxxfOXuz8WOqanG593/mx+xcxjVUSyjRf08KqVwaJySP0PIjIzxiva9CPISPDIr1dWuKY2FUj8OTVx6WA/Ie8OXEuwU74t3lSh8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:02:13 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 21:02:13 +0000
Message-ID: <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
Date:   Thu, 22 Jun 2023 14:02:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230622063105.GA624@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 757f814a-d431-4d85-06c7-08db7363f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODuLC9l30hw/j5iFlZOf2Uj/bc/8+NWuKQaujDk3lsYiw87/VO7mOsR/JaxdhvFg2MsU36ZR8NhQq/phVM1jSj/9lw43z3YFzAJCuvpZKAlfhIEH3C2yOfkHN05cNEqgpn66XiwIgENPmHznZC/1VtMonzORyza4pS32VQyyvs5FHM+P+/b/o0DhQLbWWHHbOwNKynCQfiM9/ORrMdAABjN470Tfnx/mK5CcNkyx7vnPvM3Ph3zSa9Tu2XwceBxvXPwgxKOIgYC9RwwhMVz9jixzoDvDSSVSKHi714qVrP+5y4OUOiFklPaxvGm3IUl94yOh0pmgwBqTOtlL6hKZGutpjJH/kW5Qxb+ktQM8iji+gaA8wsIKjd9TlKmf+BO1nlyRIFkOmiPCKVVhAdJJvC02JYnpf7H17/HjAvNgybPPZV8HRciFg+dDYKxweJgf3aYJRW4ajXy8gIQJ5ASCWSiG6/VWVzMNCt6xmjesFF6/P+ep+nowUVQEBUG7hV2Yd2+PuHHk0y+7whPCm3qKGyVduy7VzBmg66zRh5lo7YQ37aXv8RCJMqF15pptdki7t80JHm+7NuhJYBhSC19qboUTynGslJBfQUOTtbWi+b6MN+KPrkTmxcbGRXCahIaMRSx3wRLN1WQCZ/qq60Dt6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(31696002)(6486002)(316002)(41300700001)(38100700002)(66946007)(83380400001)(36756003)(6916009)(2616005)(66556008)(66476007)(6512007)(8676002)(8936002)(6506007)(26005)(186003)(5660300002)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JHaHovdmhXNCsyNElxSytwNGRKcEVJOW5iRDFiUEdIeUgwaWZXSHM3cHlB?=
 =?utf-8?B?c211NUhicjJXODA3OGFNSFZjVGxtNzlRWWZvNG9mdnlnM1l5U29xcENoKzEz?=
 =?utf-8?B?NTlUZjU5K091VkZLZlo2bjVLNExhZmtEZkZRN1YyQ3RIN2pWM3plVTlIclh0?=
 =?utf-8?B?ZjhNY3VtWEpvbThWNVgxbjNuckxxL01vYXNJY2FOYitmLzFLcXVUOVM5V0h5?=
 =?utf-8?B?WXB0cFlYWk5iOGhkSk41aEFBdHI2bjBNSHZLOGd0UmJ1Ni8vT1ZwVFI2TTB1?=
 =?utf-8?B?WHNDUVVDSjhHRWxveDZ5Ykw5NlExV2FFSDNsTVd4ZHRwK1ZaN0hiT3krb0ZO?=
 =?utf-8?B?OXBCUFhOQVNoM2ozUDd1YVBHSlp4eURIQ25lR1lJVUdUMk92elYzYk1QcVRZ?=
 =?utf-8?B?M09UMEdBRlpYUTYvcnhTOGp0UDZ4cHBqd3FqYmJvTGU5N1BWSXYwemZRcWR6?=
 =?utf-8?B?M0V3VWwzZ2dlcXdoOTQ4OEhCRGxBMDF4eGJSVC9GaUYrTW9OWGVPV0FyNnZC?=
 =?utf-8?B?d3lsYUtOaEx1M3NUZC9XaTdqaStvdEFLb3hCT1YydVB2ZllaUFQ0SWhXZFFO?=
 =?utf-8?B?UkJDeXFGQU5GMW5KQ2drczI2UnZGTUJ3RTY3VjVnTy9PVE5vU3dxUjcvNk9r?=
 =?utf-8?B?ckgzSmpQdFlxTUlTL21KYTZ4WnBaZGxtQTZ0ZzExWTNiVGdIa2JCQTdDcVNy?=
 =?utf-8?B?T25LNk9Kclo3S0paRWU1dGFCMGpWNEFQUHBzeSs0QnVNdVNvUTVjblJNUGZj?=
 =?utf-8?B?QWVPbUdTZkJuMmpTYkd3emVlbDlPYlUveklseHp0SkdpN0NmdlRuSnc3N0lm?=
 =?utf-8?B?dk55MGN2b1VXVVhrcEh5SEZEaXdvM3ZwS2duREtLOVk1bU5nWFBZS1pkS1Z1?=
 =?utf-8?B?UVNBdFVGOHZkaVFDV1g2QXZoUEZYcDRpTXh0dlgvRU1BOVhFdFlwVHp4Z2cv?=
 =?utf-8?B?V29FRE9uOXBxcW41d3ZpUWJFcWRZcG9vTXlTZDZuOVBmU2k5TDdJY0djZ3F0?=
 =?utf-8?B?U1UxdlJ2U01KUlY5S1pwZzhQQXllR3ZtM2ZlVXQwN0l4NFRjVCtpRzFTS1RI?=
 =?utf-8?B?ZWFrc282VkVwL3JpM2lIL05BRFFjclNtTzlaK0VhRENrbHdQSDErY0pRNUV0?=
 =?utf-8?B?NWg0NFRKRGtRZzVsL3BhaUY3UFlEY1RpZDVPZWdqZFBZZURWUFhBeWtaY0lS?=
 =?utf-8?B?S1p5akk1Tlh4RmViTDZPZFBrY3RXVWZGQXFhZXR5dmVhRCtmM0phT1R5Z2dB?=
 =?utf-8?B?dGR5azhHRUZoOFF0eUZ0YWwrdXBUUXRQcWtDSW5FQ3dhVzR2anZmNGgxS0Rn?=
 =?utf-8?B?Z0lNd2Q0Rmk0SjFzMXRvTWlabEtUTDV1Z3Z3RzVLSm1CUnZPZWMrdUlqK21M?=
 =?utf-8?B?TEd3TWtodkF6S2p2cUh6aURld28zSjh0SEVUVFpmcktrd2ZKb3NxQWVYN0Vz?=
 =?utf-8?B?bHUxZlFKUENLUktySXczeWFUeGZDL2hncjR5SzUxN2NjUmlwUW9oUDRoclEw?=
 =?utf-8?B?Ym1XZjl6N094WFMrdDgvMk9RNi9zWVJPZDdaOXRvQ2hiaDJrVnFZOU1vUE5E?=
 =?utf-8?B?Y2JzZGpqVnA0V2JSRWQrUmVvcW41d1NzbnJWYlo2OUJOSUU2NjUwSWlXc0dM?=
 =?utf-8?B?TjFERnNYUSs3MzVGbXAzdUNhRy8rK1BNak5JMWxMWUR4bWFuRU9vM1psbVNq?=
 =?utf-8?B?Wk5Zbjhta3lRTEo5SkRkOVpvaUtyWDhZemxqWTlyQXprOUh6SFJZSC94a2hl?=
 =?utf-8?B?ODNXUm5MemMxQ0pPaG12SjErUUp0N2JYR3lNdmR5bTYwZ0V1UUhVVzlPK3NH?=
 =?utf-8?B?a2cxaXFISEhyaEtyZVhiQm0xM3pFaUgzRE9QMmRCdVk4YkozRGlRekEzdjc1?=
 =?utf-8?B?SWZrVnUwVmlFNHJ0aExMSEx4L1BvL1RHMHBSZEx4Y0dTWURrZm1iVDIzQXNx?=
 =?utf-8?B?bmtJQVFhajlDN2QzKzVWQUo1dXZVcFNvVUxzTXRvV0dlR0NETzd4alEzTDVu?=
 =?utf-8?B?TytMcXl2N0g0R2pKTEY4Tm1CVzRrNWhCSlZabFpkSmZWb3kvb0NKalBnbFdU?=
 =?utf-8?B?RmtXcjZTVmM1V3h5STJaa2FXWXpRa3UwNWpxY1lvRE01dldYYTBucmxWbTN0?=
 =?utf-8?Q?Y40MGlEi2E41vGbuebbNMr6gN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757f814a-d431-4d85-06c7-08db7363f3f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:02:13.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7PiE56VLfGFEpUcn8bcNQ1GqHRbcgubPM/ACttO4AzL1QU6531epZyS7eueM/Wi7dZ2v/i+69z4CAGZwZMxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/21/2023 11:31 PM, Lukas Wunner wrote:
> On Wed, Jun 21, 2023 at 06:51:52PM +0000, Smita Koralahalli wrote:
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -102,6 +102,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   
>>   	pci_lock_rescan_remove();
>>   
>> +	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_DEVCTL2,
>> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ |
>> +				    PCI_EXP_DEVCTL2_TAG_REQ_EN));
>> +
> 
> Hm, this will clear the bits while the device may still be present.
> Note that the subsequent pci_stop_and_remove_bus_device() will unbind
> the driver and may thus cause communication with the device.
> Can clearing those bits in the hotplug port hamper communication with
> the device?
> 
> I'd recommend avoiding that issue altogether by clearing the bits at
> the end of the function after the call to pci_unlock_rescan_remove(),
> so that negotiated state of the hotplug port gets cleared after all
> subordinate devices are de-enumerated.

This is a good point. Thanks!

> 
> The commit message doesn't point out that PCI_EXP_DEVCTL2_ARI is
> already being taken care of on enumeration of future subordinate
> devices in pci_configure_ari() and is only cleared here for good
> measure.  If you intend to configure 10 bit tags and atomic ops
> on enumeration in future patches, I'd recommend omitting
> PCI_EXP_DEVCTL2_ARI here and clearing each of the other two bits
> in the future patches which configure them on enumeration.

Would it be fair to just reuse pci_enable_atomic_ops_to_root() for
Atomic_Ops configuration?

> 
> You don't need braces around the "or" operation for the bits.

Sure!

Thanks,
Smita

> 
> Thanks,
> 
> Lukas
> 
>>   	/*
>>   	 * Stopping an SR-IOV PF device removes all the associated VFs,
>>   	 * which will update the bus->devices list and confuse the
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index dc2000e0fe3a..6fbc47f23d52 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -668,6 +668,7 @@
>>   #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
>>   #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
>>   #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
>> +#define  PCI_EXP_DEVCTL2_TAG_REQ_EN	0x1000  /* Allow 10 Tags for Requester */
>>   #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
>>   #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
>>   #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
>> -- 
>> 2.17.1

