Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7483022F322
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgG0O4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgG0O4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 10:56:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D6C061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 07:56:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so9690293pgh.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=OlYVjQkhuW+DpvyGdYp6ANgYaCy9yrWHvu5eQ5Kq3qw=;
        b=aWuJNc/PDTimiz7m+gzMYSslvoJtRmOD3zYjtFk2VleGD8jWaUrMjVwZyTI1HS4KwY
         Bi92LLLwOeAUy7w19cPf1n27UpLURH2SAfQIQAkpXHwd0uRurIpEabtWmBbXRsqOE/c1
         7UqrnwTrFMwpsQKClit/TG1A8zh2mgG1bo5jFjf+FenoCccDymS+C5BHLWyqSYPLmmbK
         KgJNkf9/0I8O7I3G403Zd3AsgFyRTz3zChV1TdebRrK5Ls2Q5EaXC00kHacuYh8UyBFG
         wxYKp9ai1Enfd5exK3AFATIssAqB1m7/xAS6qqT2MaiGVaOu9Fm31Ob1EI+K31D+uugV
         FD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=OlYVjQkhuW+DpvyGdYp6ANgYaCy9yrWHvu5eQ5Kq3qw=;
        b=cKdrUdoz6vTdVGrJBMqku2NmMrtr/lqX58i+vMs7mOuNNiuQ+DrqapjvHBqtnh950f
         rpucKSOSFxvmwCo+4jFtumJJZGWSok2Xk8LkJEZMjjnSIMrLEfI2ZCK3Sj8ltpyMHDB3
         7LQwkLWJyjsrYPaPYBXxdXaw5ZeGGUKbZaNi3QG3S2gwD3Ex1TAum0EKMsAPoCnl+s8G
         w/h4aAH0PX9W8PEeYm9zf/schFYgekVxAMDwrlHyFH41ZzHpSqbJOs4pF9BX1PkcthMf
         Wjh6QLOpYoNghtWrxtHB+iaEtPvkocqKor8h/HspRMtdJFpo78qKKlTDZxhWIvrSEJfY
         yuGQ==
X-Gm-Message-State: AOAM532OxzRgHiANAxaWaB65alF7YHZcYOfhKf2FgEZMWmzQ5oNtfXTN
        fdHYZEbeYBqUwcAcvhiJxGZ8Aw==
X-Google-Smtp-Source: ABdhPJy/H3S4qMTMVLHI4lHou5D0M1ramtReWu7AUnWA1ozqw7tS/AFiD98OXLRx8bjSOhOKtNXtOg==
X-Received: by 2002:a62:3446:: with SMTP id b67mr19665682pfa.184.1595861795846;
        Mon, 27 Jul 2020 07:56:35 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id w2sm3464735pfu.85.2020.07.27.07.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:56:35 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, tony.luck@intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] Add RCEC handling to PCI/AER
Date:   Mon, 27 Jul 2020 07:56:35 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <E04FFB14-95BA-4D04-BC53-037B5EB2FE80@intel.com>
In-Reply-To: <20200727133736.00001066@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200727133736.00001066@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,

On 27 Jul 2020, at 5:37, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:14 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> Root Complex Event Collectors (RCEC) provide support for terminating 
>> error
>> and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An 
>> RCEC
>> resides on a Bus in the Root Complex. Multiple RCECs can in fact 
>> reside on
>> a single bus. An RCEC will explicitly declare supported RCiEPs 
>> through the
>> Root Complex Endpoint Association Extended Capability.
>>
>> (See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. 
>> Cap.))
>>
>> The kernel lacks handling for these RCECs and the error messages 
>> received
>> from their respective associated RCiEPs. More recently, a new CPU
>> interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities 
>> for
>> purposes of error messaging from CXL 1.1 supported RCiEP devices.
>>
>> DocLink: https://www.computeexpresslink.org/
>>
>> This use case is not limited to CXL. Existing hardware today includes
>> support for RCECs, such as the Denverton microserver product
>> family. Future hardware will be forthcoming.
>>
>> (See Intel Document, Order number: 33061-003US)
>>
>> So services such as AER or PME could be associated with an RCEC 
>> driver.
>> In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated 
>> with a
>> platform's RCEC it shall signal PME and AER error conditions through 
>> that
>> RCEC.
>>
>> Towards the above use cases, add the missing RCEC class and extend 
>> the
>> PCIe Root Port and service drivers to allow association of RCiEPs to 
>> their
>> respective parent RCEC and facilitate handling of terminating error 
>> and PME
>> messages.
>
> Silly question number 1.  Why an RFC? I always find it helps to 
> highlight which
> bits you are unsure on / want particular input on.

I suppose it was because we were continuing the conversation from 
discussion on the mailing list.
And I was not fully sure about the impact to your use case.  No worries, 
I will remove it.

>
> Otherwise, I've left the PME and error injection patches as I don't 
> really know
> anything about those two paths.
>
> I'll fire up my APEI etc test VMs in the nex day or so and report back 
> if there
> any problems with that case (fairly sure there is one in patch 6, 
> highlighted in
> review but it is possible I've missed others.
>
> It all seems to have come together rather simpler than I was expecting 
> which is
> great!

Sounds good, looking forward to your feedback.

Sean

>
> Thanks,
>
> Jonathan
>
>
>>
>> TESTING:
>>
>>    Results:
>>     1) Show RCiEPs which are associated with RCECs:
>> 	Run dmesg | grep "RCiEP"
>> 	Log:
>> 	[    8.981698] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 
>> 0000:e8:01.0
>> 	[    8.988830] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 
>> 0000:e8:02.0
>> 	[    8.995956] pcieport 0000:e8:00.4: RCiEP(under an RCEC) 
>> 0000:e9:00.0
>> 	[    9.023034] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 
>> 0000:ed:01.0
>> 	[    9.030159] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 
>> 0000:ed:02.0
>> 	[    9.037282] pcieport 0000:ed:00.4: RCiEP(under an RCEC) 
>> 0000:ee:00.0
>> 	[    9.064294] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 
>> 0000:f2:01.0
>> 	[    9.071409] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 
>> 0000:f2:02.0
>> 	[    9.078526] pcieport 0000:f2:00.4: RCiEP(under an RCEC) 
>> 0000:f3:00.0
>> 	[    9.105535] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 
>> 0000:f7:01.0
>> 	[    9.112652] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 
>> 0000:f7:02.0
>> 	[    9.119774] pcieport 0000:f7:00.4: RCiEP(under an RCEC) 
>> 0000:f8:00.0
>>
>>     2) Inject a correctable error to the RCiEP 0000:e9:00.0
>> 	Run ./aer_inject <a parameter file as below>:
>> 	AER
>> 	PCI_ID 0000:e9:00.0
>> 	COR_STATUS BAD_TLP
>> 	HEADER_LOG 0 1 2 3
>>
>> 	Log:
>> 	[  253.248362] pcieport 0000:e8:00.4: aer_inject: Injecting errors 
>> 00000040/00000000 into device 0000:e9:00.0
>> 	[  253.260656] pcieport 0000:e8:00.4: AER: Corrected error received: 
>> 0000:e9:00.0
>> 	[  253.269919] pci 0000:e9:00.0: AER: PCIe Bus Error: 
>> severity=Corrected, type=Data Link Layer, (Receiver ID)
>> 	[  253.282549] pci 0000:e9:00.0: AER:   device [8086:4940] error 
>> status/mask=00000040/00002000
>> 	[  253.293937] pci 0000:e9:00.0: AER:    [ 6] BadTLP
>>
>>     3) Inject a non-fatal error to the RCiEP 0000:e8:01.0
>> 	Run ./aer_inject <a parameter file as below>:
>> 	AER
>> 	PCI_ID 0000:e8:01.0
>> 	UNCOR_STATUS COMP_ABORT
>> 	HEADER_LOG 0 1 2 3
>>
>> 	Log:
>> 	[  288.405326] pcieport 0000:e8:00.4: aer_inject: Injecting errors 
>> 00000000/00008000 into device 0000:e8:01.0
>> 	[  288.416881] pcieport 0000:e8:00.4: AER: Uncorrected (Non-Fatal) 
>> error received: 0000:e8:01.0
>> 	[  288.427487] igen6_edac 0000:e8:01.0: AER: PCIe Bus Error: 
>> severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer 
>> ID)
>> 	[  288.442098] igen6_edac 0000:e8:01.0: AER:   device [8086:0b25] 
>> error status/mask=00008000/00100000
>> 	[  288.452869] igen6_edac 0000:e8:01.0: AER:    [15] CmpltAbrt
>> 	[  288.461118] igen6_edac 0000:e8:01.0: AER:   TLP Header: 00000000 
>> 00000001 00000002 00000003
>> 	[  288.471192] igen6_edac 0000:e8:01.0: AER: device recovery 
>> successful
>>
>>     4) Inject a fatal error to the RCiEP 0000:ed:01.0
>> 	Run ./aer_inject <a parameter file as below>:
>> 	AER
>> 	PCI_ID 0000:ed:01.0
>> 	UNCOR_STATUS MALF_TLP
>> 	HEADER_LOG 0 1 2 3
>>
>> 	Log:
>> 	[  535.537281] pcieport 0000:ed:00.4: aer_inject: Injecting errors 
>> 00000000/00040000 into device 0000:ed:01.0
>> 	[  535.551911] pcieport 0000:ed:00.4: AER: Uncorrected (Fatal) error 
>> received: 0000:ed:01.0
>> 	[  535.561556] igen6_edac 0000:ed:01.0: AER: PCIe Bus Error: 
>> severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent 
>> ID)
>> 	[  535.684964] igen6_edac 0000:ed:01.0: AER: device recovery 
>> successful
>>
>>
>> Jonathan Cameron (1):
>>   PCI/AER: Extend AER error handling to RCECs
>>
>> Qiuxu Zhuo (6):
>>   pci_ids: Add class code and extended capability for RCEC
>>   PCI: Extend Root Port Driver to support RCEC
>>   PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs associated with 
>> RCEC
>>   PCI/AER: Apply function level reset to RCiEP on fatal error
>>   PCI: Add 'rcec' field to pci_dev for associated RCiEPs
>>   PCI/AER: Add RCEC AER error injection support
>>
>> Sean V Kelley (2):
>>   PCI/AER: Add RCEC AER handling
>>   PCI/PME: Add RCEC PME handling
>>
>>  drivers/pci/pcie/aer.c          | 43 ++++++++++++-----
>>  drivers/pci/pcie/aer_inject.c   |  5 +-
>>  drivers/pci/pcie/err.c          | 85 
>> +++++++++++++++++++++++++++------
>>  drivers/pci/pcie/pme.c          | 15 ++++--
>>  drivers/pci/pcie/portdrv.h      |  2 +
>>  drivers/pci/pcie/portdrv_core.c | 82 +++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv_pci.c  | 20 +++++++-
>>  include/linux/pci.h             |  3 ++
>>  include/linux/pci_ids.h         |  1 +
>>  include/uapi/linux/pci_regs.h   |  7 +++
>>  10 files changed, 232 insertions(+), 31 deletions(-)
>>
>> --
>> 2.27.0
>>
