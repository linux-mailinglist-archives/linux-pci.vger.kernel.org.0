Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD17AF8BA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 05:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjI0DhE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 23:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjI0Dd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 23:33:26 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321A1BD7;
        Tue, 26 Sep 2023 20:01:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VsyiB2f_1695783680;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsyiB2f_1695783680)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 11:01:22 +0800
Message-ID: <afea2d15-d73a-1ba0-a364-8e24ffbb583d@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 11:01:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        mahesh@linux.ibm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux PCI <linux-pci@vger.kernel.org>, bhelgaas@google.com,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lenb@kernel.org" <lenb@kernel.org>
References: <20230926230247.GA429368@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230926230247.GA429368@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/27 07:02, Bjorn Helgaas wrote:
> On Fri, Sep 22, 2023 at 10:46:36AM +0800, Shuai Xue wrote:
>> ...
> 
>> Actually, this is a question from my colleague from firmware team.
>> The original question is that:
>>
>>     "Should I set CPER_SEV_FATAL for Generic Error Status Block when a
>>     PCIe fatal error is detected? If set, kernel will always panic.
>>     Otherwise, kernel will always not panic."
>>
>> So I pull a question about desired behavior of Linux kernel first :)
>> From the perspective of the kernel, CPER_SEV_FATAL for Generic Error
>> Status Block is not reasonable. The kernel will attempt to recover
>> Fatal errors, although recovery may fail.
> 
> I don't know the semantics of CPER_SEV_FATAL or why it's there.
> With CPER, we have *two* error severities: a "native" one defined by
> the PCIe spec and another defined by the platform via CPER.
> 
> I speculate that the reason for the CPER severity could be to provide
> a severity for error sources that don't have a "native" severity like
> AER does, or for the vendor to force the OS to restart (for
> CPER_SEV_FATAL, anyway) in cases where it might not otherwise.

Agreed, it is the key point.

Per ACPI 6.5 18.1 Hardware Errors and Error Sources[1]:

	- An uncorrected error is a hardware error condition that cannot be
	corrected by the hardware or by the firmware. Uncorrected errors
	are either fatal or non-fatal.

	- A fatal hardware error is an uncorrected or uncontained error
	condition that is determined to be unrecoverable by the hardware.
	When a fatal uncorrected error occurs, the system is restarted to
	prevent propagation of the error.

	A non-fatal hardware error is an uncorrected error condition from
	which OSPM can attempt recovery by trying to correct the error.
	These are also referred to as correctable or recoverable errors.

Based on our discussion and the PCIe and APCI Spec:

- Native AER fatal error defined in PCIe does not indate that there's
uncontained data corruption.
- The kernel is capable of handle native AER fatal and non-fatal errors.
- When a CPER_SEV_FATAL error nofitied by firmware, it indicates the
platform wants to force the OS to restart, and the APEI/GHES driver follows
the Spec now.

(Please correct me if I misunderstand any)


> 
> In the native case, we only have the PCIe severity and don't have the
> CPER severity at all, and I suspect that unless there's uncontained
> data corruption, we would rather handle even the most severe PCIe
> fatal error by disabling the specific device(s) instead of panicking
> and restarting the whole machine.
> 
> So for PCIe errors, I'm not sure setting CPER_SEV_FATAL is beneficial
> unless the platform wants to force the OS to panic, e.g., maybe the
> platform knows about data corruption and/or the vendor wants the OS to
> panic as part of a reliability story.

So back to the original question, I think your above comments are clear enough.

> 
> Presumably the platform has already logged the error, and I assume the
> platform *could* restart without even returning to the OS, but maybe
> it wants the OS to do a crashdump or shutdown in a more orderly way.
> 

If the system is reset in platform without even returning to the OS,
it is not visible to end user. IMHO, it always a bad choice.
The OS can provide enhanced debuggability, for example:

- providing details about the runtime context through crashdump
- saving error information to persistent storage

Thank you for your patience and valuable feedback. It is greatly appreciated
and truly helpful.

Best Regards and Cheers.
Shuai




[1] https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#hardware-errors-and-error-sources
