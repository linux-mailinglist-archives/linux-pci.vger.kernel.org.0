Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5511628415
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiKNPiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNPiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:38:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57502E6A4;
        Mon, 14 Nov 2022 07:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCRKNjYGPXgqP1ZFwdk+4BL0Mz/Ucnv0jANasN5OgmqB0/1aoUsh8DAQDhghBHCpSO5gqLvtQ1aBNR9sJwc8eZW9dq7/lY+3uoBBQ3laybuMSLuBIbvi14BCr5lUrIbgXjeZ9AFvu1AcVwsaTKfpeb6fw0wZnTZq8G8w1NXc2aY1x24bQy71L74s9awK1/ayBD5MWeCkYgDWgJqCvfTWV01yYy05vbQB7b3ouGWbQ7aXeyblux1zQm3nFCqbAypdDjVgZ7HF3pw7+LUZF7mEwpMQnDnklW0Ce9Lzx1zVBO9nmcZOhJBvs+PSYpPauIiG5j/XTEgJmO2BQsb1f7h5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwLCzAslaPP7qJptUm+JvjOntC6dnO2i1C73ncOLSs4=;
 b=UPfjopWqxJsNFSFCcgQ0DFoMr9iNYW/OP/4z8wuANpu4Eh1957DLH4DMEaeMb1IyowQoTtwMjH3c0HJaA7iL6pmkYtxHDRe/pO2qRD8oGLN20j/Mr6PEcp9ruYON45lNvW7DbBuCl/xlip5/vKbZ7uK/qOb5fB2QJ57NT4gQ1yYhiTJQTg4Z3asHSsdGxraXH7yC7Ianv12fvsqLlAo6eiMHxPRscdnwaP0D3oBv04Eo4BjU4O34RNREZmkbOi8Om3U33G0NCgOj3a7fQIz883Ez6MnbhIXIKUu0ZbmrrWy6o1HJHrd0xlj75rxg0nAoOnZf8FCpb8tXLWgCWccitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwLCzAslaPP7qJptUm+JvjOntC6dnO2i1C73ncOLSs4=;
 b=oSoNvGIA6x2bJkvuRzmcjgk/B6aNIIGvgK+IZKg7TmKt7laeJSfstrdNJQRIyq4BVkHNo+t/89XMqjqfOmCN1COWMF6uDj9nB1B6N6eTPqEr1wj0SR4oFb68l941vYrN8bubL3JD62GIia8mPljrPNNXnJf5A1tdaLr20PvxofQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 15:38:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:38:01 +0000
Message-ID: <53e6278b-9261-952e-56bb-4bd288cd2e9e@amd.com>
Date:   Mon, 14 Nov 2022 09:37:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5754039e-e3c6-cdb8-8d64-6332b0093940@amd.com>
 <20221111214209.GA748269@bhelgaas>
 <CAJZ5v0g834K4ZBrEvhAbJhvGBVyq53nreG+xeBufXKQXA3VtrQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g834K4ZBrEvhAbJhvGBVyq53nreG+xeBufXKQXA3VtrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:59::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e84bf5-50a4-4f94-7e1d-08dac656366e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3zXtq+exrV8/xmWgRjBgv+Ja0jBcY8kXj3mQOJf64MTcgY6j9gsjnQuR9Ry3JysaGEiwr1YrTHSh63eRBJ2GYqdqOQNBHILa7ZzSQ19El+sTVypw40HR/7SuESVkwKZw4d7GIOfjruHI40Fm7Ar3cX9uhsr55srKn60KeOmCfGMuf0phy8e/aGFYry0cL0b0O+9d2e0Vc1TW742ekDRd4tJVa21lJ3LCfBW9e4G9+bonFFT4P+4UVXtpxCp/3QGuUBfXVjNl3W2JmloU0356tFI/ZEbNYrHBaGwx5L2eK0LYHrQdStIGpmr3HlLzBbO5P7icMKBJmXszpfeSnAAh7MdH7S7JqOs1Tnn5/7PaopJ12fiNLU/tQqB6T2WyPiggtsid9CLDHf+0sCtNQ+A3FAmRwjB+1ZOkDjcU5QW4EGUx5IPJ7NCvR9ntOoDYlKBuW6ijFiDnw76F/lc3Gwx8VDF7fRbQmSNNF4/ca9qxm5f5syQtBYUWo0uXeM8KjFf+83rFkpXuU2DZrCWOQhXS8+m33doC4NTk2oU8KxAs2GbhNcpgcHO4q+epFanW5gOyyKde26922Fa2fTJk+lGBvQWwMdR9OacEw17Xw/yAqt/sSs2VerUv8JeZdsq11gwfbrsALNi6iuO3Jopjvpgm1lUMDRHNrwGJc2mwtiyxhr+2e0VT4IgdSdQdsBnMj6Nfuq8R5oJ4cGNeEtJJWmrloH9KIYtgqPL9CW94Wv4O6xP+AUhvVbpsXY9lRM4sVAM377gOM/VlyHrdwKFTIachmK7lCzC6ca1qmCoMssS21E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(8936002)(5660300002)(186003)(41300700001)(2616005)(7416002)(19627235002)(6512007)(53546011)(36756003)(15650500001)(26005)(4326008)(6486002)(478600001)(8676002)(38100700002)(83380400001)(6506007)(66946007)(31686004)(110136005)(66476007)(316002)(66556008)(6666004)(2906002)(86362001)(54906003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dkU2trYTVwYmRQeGZsaG9vNVFqSzRXblVmenRkV2w1cmt5bmFzR2xoa0FQ?=
 =?utf-8?B?TFh3di91aFp4UGIyRjluYVUzNlpRMVUzRW5MckVuZzdBTldadFFyNXk2enMx?=
 =?utf-8?B?bTdNZDVscGV6dTQzMS9DbndicE1BRklRcmNCSkl2NkpyU1NCVmtIQWNWSFYw?=
 =?utf-8?B?UUEwV085REcvM2w5eG1zWkd4Y25YcGxPbDJuYzgwS1FsTjJ6U2UwSG9PV1Jq?=
 =?utf-8?B?Y2dFNE5pUE9sbGMrNzNLdUxFcy9TWVNBdXVqMXBSSUdRREdXbTBFZzEwdFF4?=
 =?utf-8?B?Z1NLRnppODRGdEZ4azZlMm0yVHpzQU9Dc2ZiaG8yMUF4bGo1Q3dqODRXcFlj?=
 =?utf-8?B?VEx3Q1hJN21XZkZHMTc2OWdXeFAzRjVWcjBNT2JPZzltVmRwZGdWNkJpOUlF?=
 =?utf-8?B?NENzSmw4anlTUHFsd2xQSW9DbFF1Y2VEdW8razl2MlBhcVZvckVWRFhJQ3hm?=
 =?utf-8?B?V3JtUTJDeVhHQ01razlNR2RpdSt0ZE9RZi9tdUhSc0M2WkVmSWh3bTNpUHRR?=
 =?utf-8?B?eUp6ZDJkall2eDBhdzJDOWZVZ2NyUEhLa0t4bFNRbmFsa0ZUMUhSRjdESm1R?=
 =?utf-8?B?akgvbjBrM3ZkZGt6a1o4T0xja1FNeUxqNCs0SCtBWlAzQlpjN0I3N0R1YjJv?=
 =?utf-8?B?ZDBzWlhIM1piMThWNU1kVVdyK2t1M2hkL0dyWjRQZWhzTldtZnYrc1Y0cTA5?=
 =?utf-8?B?SGxmaXBUSXIrRW96MWhjYml2RHA0d0JpNmRFaU42RnhQdGJxdFBwSGF1Q0d3?=
 =?utf-8?B?ZFhhSUhMeWh6VTdpL2VMY3lvTFBsdzR5L2t5aVVuQ0kxY010Vm5tVkptQzVi?=
 =?utf-8?B?dCt1ZkFDNVhuMHhpeStwRFdmb3NrTE5TWWhRMzhCcnhVMWs1WUhsMFFmSUxs?=
 =?utf-8?B?RHJpazVJeHR3VVpKekZSSXFvd1FFbjZZRTN3S0Y1R2ZhMGtoQzNPZVZBcnJG?=
 =?utf-8?B?STFVR05nTWFuVDM2a2tCSWZteHROcUQ5RGQwOENHNVJRaXd4dVFGSDJQek1U?=
 =?utf-8?B?a2JyYjdZaWhjTU9ucm1XVmVYVDNGVU1QVlkraWNqNFA5anVGNnI1Z1M0R1JX?=
 =?utf-8?B?OUdrUWY0ZlRMTm9BeVB1Z1NYYVpxaXVOcUVZNXdTZnZ6ai9OWG45T2ZvUUhX?=
 =?utf-8?B?bXcxbGhGTlRIRmpIYXY2aERSUWhzWm5HZHN6cHovQ2pySmJIRlpNa1NLQ3ox?=
 =?utf-8?B?Mmx6UzRWUEdzV3l3aGZwNENWeTlWRnJmSWhjM2MxclAwVjc0WlNCdFpiSDA0?=
 =?utf-8?B?cFVic0xPRkJodjVxUjR0MEhsUVhyYXUvS0svSUZLanNyRWlFR3dJSUJPdmRz?=
 =?utf-8?B?TWdkWWNpUHhzb3ZjelAxQlZtZ2lsTzJETENVUDNSS201cnNSRTdVTTFjb29y?=
 =?utf-8?B?R0g0amRndFVOdFNUN3d3aG5SRS8zbGx0QlNVRGlCU09JMU5jdEtpVUQwZ1hO?=
 =?utf-8?B?M0RTN1dSSFdOYiszY3dwWnNjMnIxa0hpQndheVg1M010TUM1VEVxc0M1bVh3?=
 =?utf-8?B?MCtKVDRRa25wNFR6QVUyYXBXM1hMbW9HN3d5bFZBeTEvR2prUy9jMGczRU52?=
 =?utf-8?B?d1FOcHZMSWRtcWw5UTVLMkpmT0JVR1E3c0RCdVkrNUpyTFhtM1ZYTUhlaHQr?=
 =?utf-8?B?VzZhMWIxZmRvT2pWT1I3Skt2T1A0SFpNMGdmVUFjQ0sxTzRyYVlSS1dvVHZj?=
 =?utf-8?B?NVdwR0dOWUlONTZZc1hzSDRSVnM1bzUyWlhmRnltWTdyaFViZTBlRitSSHZp?=
 =?utf-8?B?V1pjMFBPMStzdS9VUW5QcjJPSDVsM1dFR3BqODE5d3QxTlBMeTV3bDIzRHJF?=
 =?utf-8?B?NGhxNzRLaDBJa3Aya0puZEg4eEZUNnN0eDVQVW9KU2tkYy8yZEwvVG5rcVhG?=
 =?utf-8?B?cHZjcVlXeTdPcTlDSzJ3TjNGUGZEK3pzODZHanNtSVpqNVNqQlhsd2ZSM3V3?=
 =?utf-8?B?NjAraTB5YTE1cnJDcXB4WXhQbC9FSE9vUm5MQnRNRHJESjlydnRPMGZSeE96?=
 =?utf-8?B?dkFpblJaOVdQTjdyL1A3ZndkRm8zVkJjbzY2dmdDMmlkL1pZREIrZzF5QTFi?=
 =?utf-8?B?M1lpdG5oUUU2SkY3MUtDR1gzY3VzZ3l5NHZ3azhHQVhVUlhKbE1nNVRwbGd2?=
 =?utf-8?Q?5VXZw/gw2IpdOC33YUalS7+Om?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e84bf5-50a4-4f94-7e1d-08dac656366e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:38:01.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8v2gxfzr077gxng6zDeqLPLR5unRzbSI3nEGCDsNiaf/jTI9js3VHTtkUrRQsxmum3EPST93DmOZ2SXDLl28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/14/2022 09:33, Rafael J. Wysocki wrote:
> On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
>>> On 11/11/2022 11:41, Bjorn Helgaas wrote:
>>>> On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
>>>>> Firmware typically advertises that ACPI devices that represent PCIe
>>>>> devices can support D3 by a combination of the value returned by
>>>>> _S0W as well as the HotPlugSupportInD3 _DSD [1].
>>>>>
>>>>> `acpi_pci_bridge_d3` looks for this combination but also contains
>>>>> an assumption that if an ACPI device contains power resources the PCIe
>>>>> device it's associated with can support D3.  This was introduced
>>>>> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
>>>>> D3 if power managed by ACPI").
>>>>>
>>>>> Some firmware configurations for "AMD Pink Sardine" do not support
>>>>> wake from D3 in _S0W for the ACPI device representing the PCIe root
>>>>> port used for tunneling. The PCIe device will still be opted into
>>>>> runtime PM in the kernel [2] because of the logic within
>>>>> `acpi_pci_bridge_d3`. This currently happens because the ACPI
>>>>> device contains power resources.
>>
>> Wait.  Is this as simple as just recognizing that:
>>
>>    _PS0 means the OS has a knob to put the device in D0, but it doesn't
>>    mean the device can wake itself from a low-power state.  The OS has
>>    to use _S0W to learn the device's ability to wake itself.
> 
> It is.
> 
>> If that's enough, maybe we don't need to complicate this with all the
>> Thunderbolt and device link stuff.  Which would be great, because the
>> code change itself has nothing to do with those things.
> 
> Indeed.

I'd think it's still useful to leave "something" in the commit message 
about how we got to that conclusion though.

Bjorn, do you want me to to attempt to rewrite the commit message and 
send a v6, or would you like to?

Thanks,
