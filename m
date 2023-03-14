Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0D6B8749
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 01:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCNA5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNA5t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 20:57:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97F87DA7
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 17:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci8A4/dzXSnwUWnZDKkxitGClGruFeo+LZTkAR72jLcpG50MGFcbMgoq8ErQ9vV/cinMPNRyHOJLkek1u1T7h13Qv7UOoGBEkThOZIUq3qH9Kj2xt0TAdo6I+hUuqRCuIXUdrRnR78AX0KqPHh2N4mlYAOBBd1+eD7CrzJbDqizo3snqAZnC3Y6XcML8PKEk9+q5CVNUlRhbWdXWkbyMsYowgKKrbZAyBOsCh4bP4xL7lT+6ZNjMhssaxnAiQPVCHg431Xoj/gO1hZFz15MKHxRY0Jz8Rkg3z3zshyQD7r4oZ0sDIWXaIMi40Q/sE42924RMIdgmt581JDSrniZejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvI53hra0HaG3/d0Hh6fth40tXAzTTTQjKUgYRIw13w=;
 b=JJ1xvQx/g2FldFauT6WMFDVDDQ/M275ISK4RkTujl+oilkopQ5dwFtb1Q3xVA5MdNJQl7soxn71u9FhxQmwlI/ZM5P8KnwzIO/0OtnLbnz8AeL/e8ismPYFCeSTkkrt5EStbssFVNUDUjhVgJCCCmRIfUgZ8U4qOKX46bFTzzoIa9C6mYZONtJtRBrimb45J/nWndUC2005vDVqOunW3ENBRHPqoXc6BcykQPkLZ5NXc5/vNb8eDaDvjJfZk/8ztyFHOVteNgwYg3hJBQtbDRZnsugPYSNtzec7JTDVWBmCmK6o5BMRPiwYHY58Na81cW2WDKldSbittnEFX850Mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvI53hra0HaG3/d0Hh6fth40tXAzTTTQjKUgYRIw13w=;
 b=CSr3CQdcJJYOhgymLJeWTUYjMy/u/CvH87M7nokr48gKzctVEmDI76KAWnAY0O69P7xgB5clBLvNZJIMBd3CaCprdvWPDJjmZY7bUZGJ9sDG69WnZoo5/PoDFnmI4xP0DEQbA5i+XGkuvpxqY11sWsY614QBlU2aizUz26lsZ/QBRofvOxSM3LzmF3fcPtuhNU2dW4uzKLqtD4wBixc8/KVHElrnQ89jkZKtLPxnyAsZqlWrRLlDZdYxDXOXlMcdQ46AogQr1culx3j6avo234gEiZFlCZ8/UxPLqLF+XBAaiqbIBOSLaIM2u1+xfZdLLZrIS+tp0SxOVNCl15RoIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 00:57:45 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 00:57:45 +0000
Message-ID: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
Date:   Mon, 13 Mar 2023 17:57:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, linux-pci@vger.kernel.org
References: <20230311082220.GA3649@wunner.de>
From:   Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20230311082220.GA3649@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 77afe452-2ca7-4c57-f389-08db24271f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xjrwG0W45jOeP5eJBW6trTzJUEYA2JSZW+yDVrsShc8H1YpIs8n7ZrKOOcDSgWKv48LPGX/6CcjHHvcyPY36gPV0e1f9lE4dkclYLBp2ZckzKEKn47LkI3l37SFhaPFe+8x23RpqEhAo4PUcL+DmNjM4PO9vfyqNRTIeqrhIk8QV3scMjwkWDlQntEo0+5D+Kw32qaqWl3Bj0LD5uqDrWoDIrnvf2X/wGxJ8A3er3/SuKpcvGPsLMMSK9n8ymUbLT1VDMf8fPcP5CtjPpW9tjUy9OWC5K5DsPs00yRUukdLbUekfM3ha3iSCD7EVfLellcRBfLHnxGwaCICZ7A9PzIES1bJsR+0/10HxeDMn6XmMNDKaLEt5G+lWjzsv5VNqX20+IdeCpqtT3+46XFxVkMQQ1RJh3aQGhyTGXDQYKYRZtuQPMqhECpnDvtUtRFPvUEBKtEFfvCXwI4tVeSnHSTAM1TH3Y7rC+J8Nb8qevjCp2qBQ9wBnwU7wDEY2KP6mBv6Q74gRZ13nDoo5/g3eU6vpWVoUjm2ZtIJ2t0Eh8IgQNFXNP3UME+7GHySkor5FaL7v3H3Fy2DO0dgO//JkHJJyPg2eNXc3rdwvbfTcc7s6WdLkmjIh40M7poDmJyzIf7jr0eO1KhHHlURvzst0+7qLOkIuS5pWiUmzS7sfIdqYgsBIuahm4pgUH/UiO24tUz2X1pQ49Dd1Vggw0wWYzr5Man4jwd4A4/i/+IlQUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199018)(31686004)(66899018)(110136005)(36756003)(316002)(38100700002)(86362001)(31696002)(53546011)(83380400001)(186003)(6512007)(6506007)(26005)(2616005)(5660300002)(6486002)(478600001)(41300700001)(8936002)(2906002)(66946007)(66476007)(8676002)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdEanB0ZTlNcmpkSGNxSGFVMVJTeUtsYVhzSTRHb25KbUFEcFFtSzQxQWM3?=
 =?utf-8?B?V3d3Wml6ZCtQSlZrcUZldkFkcmZVU0JZSmppcGNYK3BaSVlwL2tWa0xGNnZ6?=
 =?utf-8?B?cks5ZTJheDFrOXduK1JoQU1Fb1hIQWltdWk4RHRMdWNkNTFGYSsxRmlnQVJl?=
 =?utf-8?B?YXY2cEw4emEvMFg0R3A3UUdLK1BxbDhBVlJQajB1ajhYSjBlUGk0ejViT2pE?=
 =?utf-8?B?b3VRTzhuZzhXWCtFK05qdDdXQkI1K0ZSOU45UnQreVBxM3IyWURCcTRiTTJQ?=
 =?utf-8?B?MERLS3NzamNvaEd1Y3lWOWlNS2RGQm1RV09BU3dqblhBZ0M5dVNsUFJLZFBS?=
 =?utf-8?B?MktjUS9yQmQrQTJDYnFrMnB2OTJjMlJMZUNTd1FNNmxXUXdUQjJhK3BIT215?=
 =?utf-8?B?YUM4UENIMUFNWjRlMmtXcUNEajlDMnkrYkhaOHZzTE0rb3F3cUV5a2JkZklK?=
 =?utf-8?B?YzlZeGEyOGJOeXlBd3YrRkJ6WEVqRmFMK0htVFREc2gxL1J1b1FlWk5JR1lz?=
 =?utf-8?B?M1hFeTNiaDBudDczRWZvZk9icUtXdHhEMHRPQjFQU1FvMFcwV0FuMTgwbTFn?=
 =?utf-8?B?S3lNdnYwcldDOWJwR0tvMmdWMGYxTktKdjZMQWRveWU4YitMS3NDZkVQQWs2?=
 =?utf-8?B?STlybGZFMTE0VGNYUS9DNzhkYkUxd0psWGZIMTdRcDhNdWRmcFBNQnAvbkFE?=
 =?utf-8?B?NHpONkgxVXRJWUxGRnhPeXpPa2JhUS9EYSt6TE85NzFoN05FU1ZZVVJCNEIw?=
 =?utf-8?B?YVN0MXZ1ZlZYNk91eDUyM3M3MXZYM1pBbnU1c1YrbzR1UWdPSmJKZW5KTFVH?=
 =?utf-8?B?QXNmTmZsc0d6bUxGSFBEbW1ndXpDSU8rUlE0Q01IeEpNRWljMC9PTWtKSjc2?=
 =?utf-8?B?UTNlM05LdmpidVpWWkY4MW5GL0dvS1JtWnAxYVNCa1ltWXJPbUNVOTVxMHlH?=
 =?utf-8?B?WnhRWUlBWi81ZDBidlZEWHVER0ZhWXZwcWlSMTVwRjcyWjN0cjFRQ3lCRDBn?=
 =?utf-8?B?czRhNzk4Qk1uVk1nNlo5bWdMbU9abVozNUxrNWdLb3ljRXFTMUpXaTZ2dmlL?=
 =?utf-8?B?cU9OaFIwTGpPTXh6TExGUEZJaVphTVc5NHFoQkFhajEwbFROWUlyVmtWdUph?=
 =?utf-8?B?QmxQazMvYzlqSXMzcXdVOFRRMHlLcmhxT05aaWQvYWthUzdsdlJSbGIxYWhM?=
 =?utf-8?B?MjFQbzlqK1kxbTM0YTZGbW1qcHNXUm96VzBySTMvNjEzSTlXQnZodTRkQ1hR?=
 =?utf-8?B?bHNMYkJESVM4QjNlUG9HTWpGZW1lVUhFOEowVHo5K3ZYY0tYdkswenZJK1Ir?=
 =?utf-8?B?TjMvVTF2T1N1ZUl5UkZjdUd3ZldZUElrY3VzWDdIdEpXYnRRdFdjSWVNNEVC?=
 =?utf-8?B?UjVrbkg5TlFiM2krZis2MkJUSHlxUXBWMktLeUxLUEFIMHZ2YVdqd0RwU2w5?=
 =?utf-8?B?QTloSE52NkxWcHlBYVhleW0wOTNWM1BseTlUa3d4VGNZVlVCUTl6NEhoOTN0?=
 =?utf-8?B?aWt3U2l0V01JaHY3UVJ5Uy9rUm16bFkzMEEzdURoL2ZpSUg0RGFPelhkdjFZ?=
 =?utf-8?B?M0FjL3pXN1pybVRrV2RTalQxVG16U1JYVElFSHpqblg3My96VUdyRTBGNmZW?=
 =?utf-8?B?RXVtRDlCVHV5QlpYZWRtdk1MR3k3ZmdSTDBNU3RpSks1cVdjekZsNWdZYW9M?=
 =?utf-8?B?K2x1VXBmT1BZcXR5Mm9qcW1NZFdHdVk0TnhCN3dTNElVZkNrZ1M0Z1N4ayt0?=
 =?utf-8?B?OUdxa3hoTUo4anQ1Mkt1SG04amlNMzZTUjhqMjhxVWdOTUFBbFpWdDVuSVBP?=
 =?utf-8?B?YVRPMWlkMFFRQnBkSEZ4d2VHYXovU2VKdDE3V2hqSjVFd1NMYkRsa1UrYlJM?=
 =?utf-8?B?cmdZcUJTNHFZWWloWDNySnR1T25KY2gxM3RFbDBxdHQwWUowL3BqditKclIw?=
 =?utf-8?B?TzQvUjMzSG5wMzl4N0x1eWhoK2NHMjZhSmxaL1V0Y09sNE81d3NpMGdGQWtQ?=
 =?utf-8?B?VTdON1JyMFBEV29tZ1hUckxrUUxPelRoV0FVZ3BuZVF2QnpkbzJianhlb0lN?=
 =?utf-8?B?U3RzY1QwM2p0MktYNEFFa21ydFhHRDJFL3d0bENVWWE4ek5wUUV0a0tRdWMr?=
 =?utf-8?Q?F3VYtUx4VyWKqu+7FOe6LwS6B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77afe452-2ca7-4c57-f389-08db24271f7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 00:57:45.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG4G6oxGDcVaGxZvIYAEbkW6cAGfNALHe4NGTE2cvxO6yIvDbdFT/biwrLebB9e+adwxCGCLkODK0dOXiCxYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/11/23 00:22, Lukas Wunner wrote:
> On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
>> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
>>> In the log below, pciehp obviously is enabled; should I infer that in
>>> the log above, it is not?
>>
>> pciehp is enabled all the time. In the log above and below.
>> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
>> link down/up) and not in others like you noticed in both the logs.
> 
> Maybe some of the switch Downstream Ports are hotplug-capable and
> some are not?  (Check the Slot Implemented bit in the PCI Express
> Capabilities Register as well as the Hot-Plug Capable bit in the
> Slot Capabilities Register.)

All PCIe switch Downstream ports where nvmes are connected are hotplug-capable
except the boot nvme drive which I would never use in my test :)
For my test, PCIe switch Downstream port is a9:10.0 where nvme ab:00.0 is 
connected as an endpoint device.

# PCI Express Cap - Slot Implemented bit(8) is set to 1
root$ setpci -v -s a9:10.0 cap_exp+0x02.w
0000:a9:10.0 (cap 10 @68) @6a = 0162

# Slt Cap - Hot-Plug Capable bit(6) is set to 1
root$ setpci -v -s a9:10.0 cap_exp+0x14.L
0000:a9:10.0 (cap 10 @68) @7c = 08800ce0

# Slt Control
root$ setpci -v -s a9:10.0 cap_exp+0x18.w
0000:a9:10.0 (cap 10 @68) @80 = 1028

# Slt Status
root$ setpci -v -s a9:10.0 cap_exp+0x1A.w
0000:a9:10.0 (cap 10 @68) @82 = 0040

FWIW, after MPS changed and issue reproduce:
root$ setpci -v -s a9:10.0 cap_exp+0x014.L
0000:a9:10.0 (cap 10 @68) @7c = 08800ce0
root$ setpci -v -s a9:10.0 cap_exp+0x018.w
0000:a9:10.0 (cap 10 @68) @80 = 1028
root$ setpci -v -s a9:10.0 cap_exp+0x01A.w
0000:a9:10.0 (cap 10 @68) @82 = 0148

> 
> 
>>> Generally we've avoided handling a device reset as a remove/add event
>>> because upper layers can't deal well with that.  But in the log below
>>> it looks like pciehp *did* treat the DPC containment as a remove/add,
>>> which of course involves configuring the "new" device and its MPS
>>> settings.
>>
>> yes and that puzzled me why? especially when"Link Down/Up ignored (recovered
>> by DPC)". Do we still have race somewhere, I am not sure.
> 
> You're seeing the expected behavior.  pciehp ignores DLLSC events
> caused by DPC, but then double-checks that DPC recovery succeeded.
> If it didn't, it would be a bug not to bring down the slot.
> So pciehp does exactly that.  See this code snippet in
> pciehp_ignore_dpc_link_change():
> 
> 	/*
> 	 * If the link is unexpectedly down after successful recovery,
> 	 * the corresponding link change may have been ignored above.
> 	 * Synthesize it to ensure that it is acted on.
> 	 */
> 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> 	if (!pciehp_check_link_active(ctrl))
> 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> 	up_read(&ctrl->reset_lock);
> 
> So on hotplug-capable ports, pciehp is able to mop up the mess created
> by fiddling with the MPS settings behind the kernel's back.

That's the thing, even on hotplug-capable slot I do not see pciehp _all_ the
time. Sometime pciehp get involve and takes care of things (like I mentioned in
the previous thread) and other times no pciehp engagement at all!

> 
> We don't have that option on non-hotplug-capable ports.  If error
> recovery fails, we generally let the inaccessible devices remain
> in the system and user interaction is necessary to recover, either
> through a reboot or by manually removing and rescanning PCI devices
> via syfs after reinstating sane MPS settings.

Sure, that is understood for non-hotplug-capable slots.

> 
> 
>>    - Switch and NVMe MPS are 512B
>>    - NVMe config space saved (including MPS=512B)
>>    - You change Switch MPS to 128B
>>    - NVMe does DMA with payload > 128B
>>    - Switch reports Malformed TLP because TLP is larger than its MPS
>>    - Recovery resets NVMe, which sets MPS to the default of 128B
>>    - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
>>    - Subsequent NVMe DMA with payload > 128B repeats cycle
> 
> Forgive my ignorance, but if MPS is restored to 512B by nvme_slot_reset(),
> shouldn't the communication with the device just work again from that
> point on >
> Thanks,
> 
> Lukas
