Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90E77A97DD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjIUR2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIUR1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 13:27:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4141FFF;
        Thu, 21 Sep 2023 10:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMAcQmocii2rTWZsVqijGP6oJdE169P/OA7cZesley5EyUJWbr1po4rnAnkqmjfoTcHjP56WUVxEFB/hacNwb92l3p9TlT0TaFXkPHQ9qEEkVT+LjQ8wMyKUEntbcu+SooyoFeX9EoXfWIifhAPUCmPThILm7pOc/YoPPAtKRFC+drwiuZKkqmej/XoQpxzmcph4ccbZC3t3nEUxsEs5TMneVRtEB5JXLLl0BnDnsGg5a0Ie0ORolm/O2xTsfzjbDjGpVYGxttG1HXNmqJiEsHHQ1R2+JMoLCe53sQtb3CkT1PHzYzAaTtdcdytWb7Elzy7Kizd5qGfEulhRjdBMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/nfUsa3nrQB28CvgksNPj5PlcpValBLU08SZenRAxc=;
 b=HwSI2wCpoqXiL0Gy2QMXpbLHgqQkYFr7+HZA/Wizx+XSHQ2xMk1+sngWnYNuXIpnYenknAJzVS/VnbrPgNQLK7a4VAV1d9ZNSBUZrrjKhR6u4/YxOS7egKvzrts68j7xnd1ZL3rOl9tjhHrfFFygB3f4UKE3MuHKTDOPP2pcUPBP6t6SGWx1w6gNrQtiS7e+CqNNb06EZQ+Ort4HcHHd7l8gmyp6ANyZAvO67HVg9Bn13v63jtxl8qOiHgwPRdUYscQY3zbPRr5HVCSf8IvBYX+dQfmoG3DllXO79sU820VdyzT2tp1pMZAJdtnsoivEcknjkUsV3fid/MQslJp9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/nfUsa3nrQB28CvgksNPj5PlcpValBLU08SZenRAxc=;
 b=31D2alhWKZpKWJQl8GxEec4VvuXncncoqrx6Wijo+W0zWRhrdo7Owcqcu+BXDt26dv/QssF1NfOdNUUa9UwEcLshqXKZ6MIg096YNyEfLqDVAn05u1N2aKTcLhxZAzWqeWkzVaqCIDSfszGEbq3hqCFK48UlwEI5TkkPcWDR5xE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:12:19 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::6a6c:fde3:1b43:73dc]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::6a6c:fde3:1b43:73dc%6]) with mapi id 15.20.6745.035; Thu, 21 Sep 2023
 09:12:19 +0000
Message-ID: <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
Date:   Thu, 21 Sep 2023 14:41:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To:     Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, vaishnav.a@ti.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
Content-Language: en-US
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::31) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e23059-0a16-4a0e-e8aa-08dbba82db01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLhHsA/j3gTyYB7GqdUYeR6oopDyGL3LBOcaerbMK0gCkef42ZKXa+/Oi2OcaTUbLJnZ2iztYNtfj/h5+0erek72oOVROBO1iSvMs01TzuouL9TNN27rsmOL9ZPt+qtJkXLb1U0oCOPn0BgJRwK0e7tHB9phQRNHCl9WwcxlYAyWJv9bLUmkG2tDfup064yD+nsBBS2FhZk14G2ypY3eHdyonWxdxQ/iKSpVNdg1uG5z0hnI61M9Ln0Oif6Xxjh/1co2zYil6D6hnA9A1UvHlHfwbHCVc1khiMeZ0vP4xzEgvZ+RcGe0EpsyJSFGsvFyiXyNqOQi1bwV6bWICAiamp0X8IwrHIEr6Lme08D2rDyCgG8P4q2tJM/JW+zad75Gd6/s0Zv/Q2ezsekB3cUDeoWn/DHmCULFKyfvtKJkqwUbsFdEB8b+6Iod9LpaMQzF5gjs4klBjNoNrLXDoeGf5mUjqiA5yAAl6i9Q7fkwpftkqRXJ6HNL43e6nag2lJEuXeShRxGTmHldylmQAfotqVGQNr0t0WWlrZE3cmQ4p/xvaH22W/Q3nOum61e5bqzd+u4FYr2geSvAIU/LW+psP3in2neANR3XZPtNjhkWxMBjLnydN7XS9enpV/7+Boid1Tbkvi4zFkEBIjZofTYBL4fimRuxVmybCUaA2/nfOV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(1800799009)(451199024)(186009)(6506007)(6666004)(6486002)(53546011)(5660300002)(6512007)(966005)(83380400001)(478600001)(2616005)(26005)(7416002)(66946007)(2906002)(66476007)(66556008)(54906003)(316002)(8676002)(4326008)(110136005)(8936002)(41300700001)(36756003)(31696002)(38100700002)(3613699003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlWQlF3bDNseGpaUEE0UjZKcFpCVjNIV3NjOUxOTFMyS0Z2WWkwVU5TZDd3?=
 =?utf-8?B?ZUFjS0RnbU1RRG5ybEV5WTlEZ2prNmpKVWZoenV0a1BhZmJyY3UzbHFFLzYr?=
 =?utf-8?B?bGE5QVQvNWZKWjd4TXlibUxZZFNvNTU0enZXMHZhQmEzV0ptczBibzJHZzJq?=
 =?utf-8?B?V0J4cHBYRjRxM3FjQWZZdC95djNQaHdvd2FkeTFNcE92R2R6Q1BPbG55N3Ev?=
 =?utf-8?B?NStZWnN2VVl4MjFDZSt6OW5xM0Vqa3ZOL0ozQ2VFTkxNNjN6SUlsd2tlcElO?=
 =?utf-8?B?R0x1N2NBQklyak5DMzNHRXZ5dHVpS1Ztb2VoamMydDZqOEYwL1ptM080V1Nk?=
 =?utf-8?B?R0dYM2pQaWNFZ3NYYTVvYnlqOGh3UkUvb2hZdzFFbGg2OTkwMk82OFlHYU9y?=
 =?utf-8?B?NWY0d2RhSXMwUnhVQUJKWld4OFdnaTFCbm5ReFNweXJPcVQxS2dRSDR0aCtW?=
 =?utf-8?B?SjNUd1ZVajVzdjNudUthZkZ1OTZBNVVNVkQyREcrRW9DSlJpSythMkEvUC9X?=
 =?utf-8?B?VXNtVGJLUXcxVWpMODY2RXh1blJrM0ZsaUNsbEYyZkRqTzFXUmsrYndBRzBD?=
 =?utf-8?B?OU5nNkI3clZFSGVnWFNRdkk2M2VCSHdKWXNrOGxCUUxVd25RMER1TUpCZ0pG?=
 =?utf-8?B?WFV5RkZlbTBSWllIUlJYUEZXWkhYbTh1clNibzYrVzgxZ2taSXYvTkV3eFNY?=
 =?utf-8?B?YUwrVEN2VlBRUVgzbFRzbHNIQUhQMTdUYnk1TWtPc3JRMWlPZEdCSFJhL01F?=
 =?utf-8?B?SktUL1M0Y1NVZUtWbVAyd280cGczWmYzTXBnRFg5OG4zWnBDZ3d0TmVIbnZ0?=
 =?utf-8?B?RWU2bXdxa2ZJdWJKa0IwdXR2Rk5sMndZYzZJOTBTQ2ZKaGNLblFFdkNhaXNj?=
 =?utf-8?B?emxxSHVPeU1xUmE3SURtb3I3QVZ3M21mOVRYbis5RkZ3VUhyTlZtVzAwT3pG?=
 =?utf-8?B?dU8veHZSNG16eWttcmJYQW94SVpOM0VtdUZyb05iaWhFTC9WTmRXWWFrak5T?=
 =?utf-8?B?d2EzckNXKzBLbldod3Q0K1NMVTgvdFlYaDRTU21FeVhvRXBlSHEvMFdDaENl?=
 =?utf-8?B?YWt2WUhvb082WWJ4T29XODc0UzhMQ0crRUpVM1BUZ0l6RTYrejZVTXpCZ2JR?=
 =?utf-8?B?YngwNzJYei9XZXhseUdEZVNpa1YwN0xQSy94bVJMTS93UytlMnFDRUhQYjNr?=
 =?utf-8?B?SkgyajRmNFZtSzkxMEV4SFBYQ3VrZWp0OFhUVlhFekRlQmpQM041WlRqY1pk?=
 =?utf-8?B?b2pjbWNlZFlQZ240RTVqVTFFdWlmTCt2a0NxL2thL1BXbGgrT0VhSnBzUzU0?=
 =?utf-8?B?cFZQR1E3ODFOTmZ2UERpamRKU2hvVVVQeUhBOHd2N2xtN1BCNy9BOFBrZXBV?=
 =?utf-8?B?UXd0RjlwZTc3VUZ3YldWY21wOTlwbmxIeTN0M3BId3RRMGtrMC9mMGpPOXl6?=
 =?utf-8?B?OUloeUR5V3JqMkpxTFFEdDhPMWNoenBSQnNaSTkvenVZV2xaWFBoRmRrcGlu?=
 =?utf-8?B?b1M3MklBSGNlUmxkdTBVam1XWENhRDJOTnlVdFpIb0pZeHBFOHRnWEh5TlZU?=
 =?utf-8?B?NkcvNTZlZUVyeTRFQW8xWEt6Y2VvTGVPT0JrenVUVW0zenBWRVp4ZGlIOEFX?=
 =?utf-8?B?dHJJMm1PQytjWXN0dUR2OW5uK1RnUFNtTEJkL05ERGRsMGhsbGtlWnE1NWNa?=
 =?utf-8?B?SVFnTnlFdlpNSnBzQ3ZzeUpWeEZtZkRrbzU1blJMQkFOMVh6VVBnOUEwT3U5?=
 =?utf-8?B?M096RWwvam4yTjY0ZFZOaEswZlJZN2Y3dE95ZkxFVWNOS2YybnJZVGl3WWFQ?=
 =?utf-8?B?dURQU05oRk0rOFFiQndvUzA0aWtSM0piL3RWOTBndGg5R0YyNGE1T2NiSCsv?=
 =?utf-8?B?cytYcEpaaUYrTzFrZTdzdThKNEdTK3lOWHZ5aSt3cUpKb1V5OTEzVE4zQTY1?=
 =?utf-8?B?MkcrOSs1MU5wV1RwUHlCbzl3YlkxZHR0blJSVmhuVWQxdFhiakQvZHFodmwx?=
 =?utf-8?B?UVNzQVlCVVArclp0Mk8rT0doWEc4bDVTUUNPZk01OUJjR3FrQlhyRlMvR29C?=
 =?utf-8?B?YUtUY3lOL1FNUzdEQnFZWG9TS0dJVEVCVHNjR3VpcEdPQ0NQUHhWL0Y5dWo3?=
 =?utf-8?Q?Jq0Sh5UQL62O2jPJ8jEiGfo5I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e23059-0a16-4a0e-e8aa-08dbba82db01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:12:18.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9xO3z1i2zpqE8sbKdJVRxzdcZW0oepJ4OnopXMOQTD4uxa5LZT7Bu1fnWBSXWTghb8tpObn2R/sL/WKx60XXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Vaishnav

Hi Shunsuke,

On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
> Hi all,
> 
> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
> can be run on QEMU without real hardware. At present, partially we have
> confirmed that pci-epf-test is working, but it is not yet complete.
> However, we would appreciate your comments on the architecture design.
> 
> # Background
> The background is as follows.
> 
> PCI Endpoint function driver is implemented using the PCIe Endpoint
> framework, but it requires physical boards for testing, and it is difficult
> to test sufficiently. In order to find bugs and hardware-dependent
> implementations early, continuous testing is required. Since it is
> difficult to automate tests that require hardware, this RFC proposes a
> virtual environment for testing PCI endpoint function drivers.

This would be quite useful and thank you for attempting it! I would like 
to compare other mechanisms available in-addition to QEMU before going 
with the QEMU approach.

Though I don't understand this fully, Looking at 
https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, 
Vaishnav seems to solve the same problem using greybus for multiple type 
s of devices.

Vaishnav, we'd wait for your OSS presentation but do you have any 
initial thoughts on how greybus could be used to test PCIe endpoint drivers?

Thanks,
Kishon

> 
> # Architecture
> The overview of the architecture is as follows.
> 
>    Guest 1                        Guest 2
> +-------------------------+    +----------------------------+
> | Linux kernel            |    | Linux kernel               |
> |                         |    |                            |
> | PCI EP function driver  |    |                            |
> | (e.g. pci-epf-test)     |    |                            |
> |-------------------------|    | PCI Device Driver          |
> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
> +-------------------------+    +----------------------------+
> +-------------------------+    +----------------------------+
> | QEMU                    |    | QEMU                       |
> |-------------------------|    |----------------------------|
> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
> +-------------------------+    +----------------------------+
> 
> At present, it is designed to work guests only on the same host, and
> communication is done through Unix domain sockets.
> 
> The three parts shown in the figure were introduced this time.
> 
> (1) QEMU PCI Endpoint Controller(EPC) Device
> PCI Endpoint Controller implemented as QEMU PCI device.
> (2) QEMU PCI Endpoint Controller(EPC) Driver
> Linux kernel driver that drives the device (1). It registers a epc device
> to linux kernel and handling each operations for the epc device.
> (3) QEMU PCI Endpoint function(EPF) Bridge Device
> QEMU PCI device that cooperates with (1) and performs accesses to pci
> configuration space, BAR and memory space to communicate each guests, and
> generates interruptions to the guest 1.
> 
> Each projects are:
> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1 
> <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc 
> <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
> files: drivers/pci/controller/pcie-qemu-ep.c
> 
> # Protocol
> 
> PCI, PCIe has a layer structure that includes Physical, Data Lane and
> Transaction. The communicates between the bridge(3) and controller (1)
> mimic the Transaction. Specifically, a protocol is implemented for
> exchanging fd for communication protocol version check and communication,
> in addition to the interaction equivalent to PCIe Transaction Layer Packet
> (Read and Write of I/O, Memory, Configuration space and Message). In my
> mind, we need to discuss the communication mor.
> 
> We also are planning to post the patch set after the code is organized and
> the protocol discussion is matured.
> 
> Best regards,
> Shunsuke
