Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D15ED2A8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 03:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiI1Bbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiI1Bbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 21:31:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2126.outbound.protection.outlook.com [40.107.244.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E210C786;
        Tue, 27 Sep 2022 18:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2W3jec/Vn21rjl/5YukjkspscApJIEYuRsDlwslNx8Enlg6+e1Wj/faiwFGz8KbK8mqbnmkHsn2exyElnnBc0WwPuzUxynLJWWbRGp0HKK6TxNAOSfmWYcO5LvL76WRuRhlTGF+7bS1xuwSNt/kFbKyzkJrqjfCjiXUdWuAh1fTNIcB9pyLVWd/xa5bY+jqWUxaymZmSp/AHkHSKsavMj27/72EW7B2ibra86+sc3Y+rslE7FSe2jLE/ymH+D+aQAN5u3xQyhegmhQiBanQ0vHFTRvE9hZS47LbtCbmiHJglKj1ExPV2t8awHpJQ5BdjummA1hIZ+k5uEeokQIgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isESbXaK40leE4ztl14GoqacFCpJJi7rqFI1Y3qwCss=;
 b=FgJ0+VYjR8fowGr+aqSsJaRqPulR2CQ7wT4tAEbHBF4kEGiTLlmb6flNDsFGZeoYCMhK04SIPXHOa6+CxFhGmoBOTZ2F/0G7CubMDnQbIN7lwywHkimaVylY3RgHHKyqYeGLqkt7eV52yaobhA4xS4TKagOfb9N3ansp6hotJNB1ScvQhRVqXtGl7XtioJXDwAekdJJtnOoMlHjUKKuzk+EP8Lx1WDnuGK+eqBQW4C1vfEEJc7muCYkAkePjkwTRjYCuFdv8LWvttQLP/lIwkijhdW5+lIQtZaOH9KU9Kj/epg5edvgl+hBxsJk1j2L+Vp+bK648UPJOvLLp3tb4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isESbXaK40leE4ztl14GoqacFCpJJi7rqFI1Y3qwCss=;
 b=tRO5WB/3XQzRugLD+gEfkFboDo6azUXtudsxhlBq2gnA5EEUsgJtZE7GjntvrmUnet6gzT7RRn7Dx044gcWdVC5bEl3xPOCAQuzi34yYwWuMv8SSpeljAIGsEBfgjNnz5lyw4eq3eCqH2VzpynRLI11X2DvroIfyDKd6uwMm8dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN6PR01MB5055.prod.exchangelabs.com (2603:10b6:805:d6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Wed, 28 Sep 2022 01:31:31 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::145c:847a:4e1e:71cb]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::145c:847a:4e1e:71cb%5]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 01:31:31 +0000
Message-ID: <2d03fbdc-4bc1-8d18-ecae-4c95530a41ef@amperemail.onmicrosoft.com>
Date:   Wed, 28 Sep 2022 09:31:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] PCI: update the links for aer-inject git tree
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     bhelgaas@google.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, darren@os.amperecomputing.com,
        corbet@lwn.net, yangyicong@hisilicon.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927234755.GA1750512@bhelgaas>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20220927234755.GA1750512@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SN6PR01MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c962c35-f39d-48af-a0ee-08daa0f12bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uugJ+qycAGl2dqlrYPRQdqilNcn2Kkk3gmI8oK2EV+nyphYpnG3jMgqH5PkfOvD3eQ3lPbJaOTLhXHPXLAuLuxoewZn84J2dsS7VmdN0xY5jygM3+BEB7XFptJAS1D3nnqTjGyt3Rv8ya57z4EEYF2AJq22QX+Z0j4g3tCPaX7Kr6UpyVPWmm7WZLyZ4qLTewOrypd+kPsc8AwOsBspap5QBtyjYEVnChwIiiHK4o6MncpgsVv76JW6wwegdwb4IFNHD/HNIRLLvVv4mHY0wgHdh6nTreUUwhUJpuPAzD4t7+qmVrs+41ikTgM5JLCYL8eQ4fEHo1H5iq/9gmWs7v0WHPwOQhfsETMFYQTEFASfrqbvktgYpH7J5xAcb54yy4iLMABwAQVJ8tBFbgtfZimVpO3NyDmbaOQZVkMnjdzaAzkbJEiENQ9PIVeVcNMq5Q8it6QXASPbx5S74n4IWH3qHuSILsFOun7n3AKf52Nm3CGK1nH+P7QuYADXQLs0UWo4y8OyJN3f+zurAQyB9Hq12hCuLL6/hhVS2xDHaKs8+AW6LCjWh1HjO/ztGPRnpRyBlmQitNiI8YbEiCL/ucv/R9QwTftCBOdc0Aol4dtrlve8DL/me4QpI5OfNv+dv8Eyzid+1CrdkESmolwNpj8/0qCJM7WiW5spzRXLmrAHVvajq1kSOKjsU9jKD0AQtznpmA3DfBk8VroCYCRQvL+8JvriCHnGEcmDiZSyQhUEuA4qoI+p9nk5KWhFIYR14bKEtBHnflanZSm0pTYGJkDdm6AyqLz/6jRwFPKK02SvqrYtUGYH7LeGRg1YeRA0a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(451199015)(2906002)(66556008)(66946007)(66476007)(966005)(15650500001)(6486002)(478600001)(6666004)(31696002)(110136005)(316002)(83380400001)(6512007)(41300700001)(186003)(5660300002)(42882007)(6506007)(52116002)(4326008)(26005)(2616005)(8676002)(8936002)(31686004)(38100700002)(38350700002)(83170400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZlZW5maCtCQWRYVC96T0lHUG5sNWJwNEp4cHBoSy82WU1GenZVWmx5bmhV?=
 =?utf-8?B?U3F3UFRqNyswbEdrU0Jxc2dCSnpzTWxlNWZ5VFJLVHFBNTRkRHE4NXpxK1d2?=
 =?utf-8?B?R0FzMEd4cXVBZjlJcnZ5L3lCQjc4Si9wLzR3YWtzc0pDY2ZGMzRVd3h2T0kr?=
 =?utf-8?B?aHVSU05JMHF4RHc0MU8vTnZRZzhWR3h3eFRDR0NXQi9ZWjl5THNXNFRHa0Fs?=
 =?utf-8?B?UmY1VmFCcFAyU2tnOFRPUDFHZG54ekNiL2x1NHZBZGgrOTdCNU5zTzVIU1Uz?=
 =?utf-8?B?dm1xQ3Y4QlozNTkrV1pWRTVQbzVtcy92MzdRZ3RXdmRPWHVBOVdZTUNaMFly?=
 =?utf-8?B?TWtYb1drVGZKbFgyMnlxVm16Vk1DdkZyRTRrOTJzQlgrSXR5UUFwZ2ZqSi9j?=
 =?utf-8?B?VmdXRy9IUlBEZzZHSjc1M1Q3Qko3enhEYTFlUGptSnp1VDliNkFvTGdITVB5?=
 =?utf-8?B?M2dKcnZBK3czandKNUJ5S2lZVk5hTVYxQXo2cUFBQ3RWQWpPYlNEZzJRNE9s?=
 =?utf-8?B?WmtnVkZxYTA5RVhEQWcxekcyMmlCVXhVMzRlbG1HRk41MHZkVDVPOEJiVW1r?=
 =?utf-8?B?aHRDb0hianBIMmtBZUROQkRzUHhYYzNkUXVVYUJrZkFyZ2Z1d2Y3aHFhdDU4?=
 =?utf-8?B?aGF2elI3VDN4SVA2N0hXeUZTelRVencvZ0dEVGU3ZEsyT1Y5YUJGQ3lGVzNP?=
 =?utf-8?B?eXRGSWNJeGdUbjhzVWhIK2d1VVJMUzI0eGdzeGRBd09WZlozN09BTGdsMElu?=
 =?utf-8?B?NlRTUWFPMW1yN2FhcDBYSWJoSGxMejUxQTh5NkNQS2FDTTNmZk5WNzhvUDBx?=
 =?utf-8?B?RkVFYUxyR2hjdFUvVTQrdUVjMVVEcC94cFhPVGFIeW16TUZBdmJrUVBPZE5r?=
 =?utf-8?B?WlJUNUNmY1A0UWNhVUxaZHJSQ1RSZDl3cDMvMFFBL3Zib2JwcVBvTFd3MlNL?=
 =?utf-8?B?ZGhudGlLRTlXL2hlU29MSHhKSlNGcm9lcnJqblRxUzhFOTc5WnIzSTVxMVRD?=
 =?utf-8?B?RUJ6TitubmR2Q2l2K1NFRmhYelkyR0IyZE0yNUNmZUQzMHRTK013VXlhWFZr?=
 =?utf-8?B?TFRYaEVEVmVBUmhHQnd3T01NUzFWWU9Hd29DUSs3V0IyOTVxK3crZUIySzRj?=
 =?utf-8?B?dzFpaG40aTNJeVdtZHZFcGJQQkpueUllckFwTVFwMHFocFdvc0tRM2g5ckJm?=
 =?utf-8?B?Smt1dGhXR0laWUQyTXI0cWZxenBmN3ViSjBQWkN6Zng5Mm93aFROUCtYNTE1?=
 =?utf-8?B?bUJaL3YzNzRTeG81MlYxUC81WUxKQ2w4ZUNPbVdFdlRBTjB1ZHNkQnpJL09K?=
 =?utf-8?B?TUN6NFJJTVRwVURGZ04zUllVYVRLUUxvRjNHSENnT3NDVjZyRVFORlQrSjRM?=
 =?utf-8?B?cVRnV0RzYmVaMGorK1RaQUUwVWFVeE91dXFKdFNDWDBZWUh0RGtHZk03Rit5?=
 =?utf-8?B?R2VPcFpmOWt3OFNCS2tOUkd3SEdLMGxzdEgxR1dwR0h3SHBwWDJnakw5bzBE?=
 =?utf-8?B?UTFEN2w3WWd3YTlsR1ZIejB3MXhNU1pLeXBTQVhhSTFVZkFpajUwMVFMKzM5?=
 =?utf-8?B?WG9oc0twalppWW9hQm1CUFRqeWJvUXRKdzd4UTI2V213RUxiWlVhaG5NSi96?=
 =?utf-8?B?ZW5JRkRua0dwU2RSWUdIRVdPaUp3OVVUcE1wQWdGS3MvWDFQR2NoSk8xbGlQ?=
 =?utf-8?B?TklKT0ozNWRXa215a28yU1FEa094WTRDSlFRTXU4N3FSZDhsOWc4UGVLQm1L?=
 =?utf-8?B?RUhDMk9sVFVuaWtDS0tOY202eTZSRGlMNFNPRjZmZlJYbHJhcndHSVlldDds?=
 =?utf-8?B?SG40cW43UXhERmNqNnI4cWNadWFueWhxbDNQVjN4ck00M1kxUlFXMCtmM0k5?=
 =?utf-8?B?dXNZdlZqRit5c1krZHg2cERDSyt6elVvYVVrb3c1RGU5RGpLR1EvZmo2NEZ1?=
 =?utf-8?B?d253SVc4Y1ZodEVkMTBwclhLT1ZqL2JLOUp1VE5qcjYwVG9nU3JMcnhQUW9T?=
 =?utf-8?B?ajllRndGNytJb21NYkJlbDdqYTVlK2Y2NFNKVmFncWEwam5CckZQSStGMEd2?=
 =?utf-8?B?bWRrSFBMQ0FvWXB4NklFOTRJb0p1NStsRUN0V0JmcnkydTQ1Nnc1bE1qQjFN?=
 =?utf-8?B?dVl2b3NIQTlUZ0RSR3ZNMHFrcGZyZnFjWTIzS1R4dzVYZk4xM0p4U2RIb3ZI?=
 =?utf-8?Q?2RHmXea54bDAMCPfR6dHZeY=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c962c35-f39d-48af-a0ee-08daa0f12bb2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 01:31:31.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ftw930XSB/yLdkpcxnEgWROJZM2TX9X206q3Rxbi3YeTLBRd5j/f8OlHpt+hkohCrkxtCNx3DbV4TRHJqx9F7WX0K1WHyegZv3ZN9U2FhuESTeDaNxm5qzDvzgIHS98s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5055
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/9/28 7:47, Bjorn Helgaas 写道:
> On Fri, Aug 05, 2022 at 10:52:38AM +0000, Huang Shijie wrote:
>> The aer-inject tree has been moved to:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>> Update the links.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>> v1 --> v2: Modified the commit message and the title.
>> v2 --> v3: Change the commit message again.
>> ---
>>   Documentation/PCI/pcieaer-howto.rst | 2 +-
>>   drivers/pci/pcie/Kconfig            | 2 +-
>>   drivers/pci/pcie/aer_inject.c       | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..b31fc9a0edbc 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -294,7 +294,7 @@ After reboot with new kernel or insert the module, a device file named
>>   Then, you need a user space tool named aer-inject, which can be gotten
>>   from:
>>   
>> -    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>> +    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
> I don't get it.  Both links work fine for me.  Do the cgit links

Yes, the links work fine again. It did not work when I created this 
patch :) ..

Please ignore this patch.


Thanks

Huang Shijie



> redirect to pub/scm, but cgit is deprecated?  I'm happy to apply if
> that's the case, but I'd like a pointer to the reason for the change,
> e.g., email that says cgit is being deprecated.
>
> Bjorn
