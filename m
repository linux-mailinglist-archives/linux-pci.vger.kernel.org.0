Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC043ABD5A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFQUXG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 17 Jun 2021 16:23:06 -0400
Received: from server.avery-design.com ([198.57.169.184]:46710 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhFQUXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 16:23:06 -0400
X-Greylist: delayed 1881 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jun 2021 16:23:06 EDT
Received: from 50-201-210-206-static.hfc.comcastbusiness.net ([50.201.210.206]:55417 helo=smtpclient.apple)
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1lty0E-0005GH-R0; Thu, 17 Jun 2021 19:48:38 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
From:   Chris Browy <cbrowy@avery-design.com>
In-Reply-To: <20210617181225.0000105b@Huawei.com>
Date:   Thu, 17 Jun 2021 15:48:28 -0400
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Reply-To: "20210617181225.0000105b@huawei.com" 
          <20210617181225.0000105b@Huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1BC68362-057C-4AB4-BC7C-731CFC3DBED7@avery-design.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
 <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
 <20210316162952.00001ab7@Huawei.com>
 <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
 <6F0B8DDD-E661-40C8-839B-1B77998EFF23@avery-design.com>
 <CAPcyv4hJG08RaksW3jH_Q5ASqpzX5MtfNFcLqMxAH5jwTidk=w@mail.gmail.com>
 <20210318142529.00001507@Huawei.com> <20210617181225.0000105b@Huawei.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.avery-design.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avery-design.com
X-Get-Message-Sender-Via: server.avery-design.com: authenticated_id: cbrowy@avery-design.com
X-Authenticated-Sender: server.avery-design.com: cbrowy@avery-design.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Jun 17, 2021, at 1:12 PM, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> On Thu, 18 Mar 2021 14:25:29 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Wed, 17 Mar 2021 18:30:26 -0700
>> Dan Williams <dan.j.williams@intel.com> wrote:
>> 
>>> Btw your mailer does something odd with the "In-Reply-To:" field, I
>>> need to fix it up manually to include your address.
>>> 
>>> On Tue, Mar 16, 2021 at 4:28 PM Chris Browy <cbrowy@avery-design.com> wrote:  
>>>> 
>>>> Please address and clarify 2 queries below...
>>>> 
>>>> 
>>>>> On Mar 16, 2021, at 2:14 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>>>> 
>>>>> On Tue, Mar 16, 2021 at 9:31 AM Jonathan Cameron
>>>>> <Jonathan.Cameron@huawei.com> wrote:    
>>>>>> 
>>>>>> On Mon, 15 Mar 2021 12:45:49 -0700
>>>>>> Dan Williams <dan.j.williams@intel.com> wrote:
>>>>>> 
>>>>>>> Hey Jonathan, happy to see this, some comments below...    
>>>>>> 
>>>>>> Hi Dan,
>>>>>> 
>>>>>> Thanks for taking a look!
>>>>>> 
>>>>>>> 
>>>>>>> On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
>>>>>>> <Jonathan.Cameron@huawei.com> wrote:    
>>>>>>>> 
>>>>>>>> Introduced in an ECN to the PCI 5.0, DOE provides a config space
>>>>>>>> based mailbox with standard protocol discovery.  Each mailbox
>>>>>>>> is accessed through a DOE PCIE Extended Capability.
>>>>>>>> 
>>>>>>>> A device may have 1 or more DOE mailboxes, each of which is allowed
>>>>>>>> to support any number of protocols (some DOE protocols
>>>>>>>> specifications apply additional restrictions).  A given protocol
>>>>>>>> may be supported on more than one DOE mailbox on a given function.    
>>>>>>> 
>>>>>>> Are all those protocol instances shared?
>>>>>>> I'm trying to mental model
>>>>>>> whether, for example, an auxiliary driver instance could be loaded per
>>>>>>> DOE mailbox, or if there would need to be coordination of a given
>>>>>>> protocol no matter how many DOE mailboxes on that device implemented
>>>>>>> that protocol.    
>>>>>> 
>>>>>> Just to check I've understood corectly, you mean multiple instances of same
>>>>>> protocol across different DOE mailboxes on a given device?
>>>>>> 
>>>>> 
>>>>> Right.    
>>>> 
>>>> Could you confirm this case for clarity?  A CXL device may have multiple VF/PF.
>>>> For example, PF=0 could have one or more DOE instances for CDAT protocol.
>>>> The driver will scan PF=0 for all DOE instances and finding one or more of CDAT
>>>> protocol will combine/manage them.  I had not considered multiple CDAT tables
>>>> for single PF.  For CXL devices with multiple PF’s the same process would be
>>>> carried out on PF=1-N.    
>>> 
>>> This patch has nothing to do with CXL. This is a general discussion of
>>> how a PCIE device implements a DOE mailbox or set of mailboxes. The
>>> DOE definition is PF-only afaics from the DOE specification.
>>> 
>>> The CXL specification only says that a device can implement a CDAT per
>>> DOE capability instance, so the CXL spec does not limit the number of
>>> DOE instances to 1, but I can't think of a practical reason to support
>>> more than one.
>>> 
>>> [..]  
>>>>>>> https://cfp.osfc.io/media/osfc2020/submissions/ECQ88N/resources/An_open_source_SPDM_implementation_for_secure_devi_kmIgAQe.pdf    
>>>>>> 
>>>>>> Nice!  Looking at CMA / IDE emulation was on my todo list and that looks like
>>>>>> it might make that job a lot easier.    
>>>> 
>>>> Would it be useful to integrate the openspdm’s SpdmResponderEmu.c onto the QEMU’s CXL Type3 Device’s
>>>> DOE backend for CMA/IDE testing?  Doesn’t look hard to do.    
>>> 
>>> Yes, I do think it would be useful.  
>> 
>> Agreed.  Very useful indeed.
>> 
>> Jonathan
>> 
> 
> Hi Chris,
> 
> Just wondering if this qemu/openspdm integration was something your team have
> had time to look at?  I'd like to ideally get a second DOE usecase
> implemented on the Linux side to prove out the implementation.
> 
> If it's fallen off your near term todo list I might see if I can hack
> something together in the meantime.

We have been working on this.  The plan was 
1) implement modified version of openspdm requester running as QEMU app to pass DOE via CXL 
    driver IOCTL’s to do DOE (DONE)
2) enhance cxl_type3.c to call openspdm responder to implement device side SPDM (NOT DONE)
3) enhance the Avery CXL Type 3 device SystemVerilog model to call opensldm 
   responder to implement device side SPDM (DONE)

Currently we run 1) and 3) using our QEMU co-sim environment.

Huai-Cheng can probably finish 2) next week so we can run entirely in QEMU stand-alone environment.


> 
> Thanks,
> 
> Jonathan

