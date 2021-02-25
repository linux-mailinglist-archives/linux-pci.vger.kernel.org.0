Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F563259B0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBYWcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 17:32:35 -0500
Received: from foss.arm.com ([217.140.110.172]:56338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBYWcf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 17:32:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E59ED1;
        Thu, 25 Feb 2021 14:31:49 -0800 (PST)
Received: from [192.168.122.166] (unknown [10.119.48.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD44A3F73D;
        Thu, 25 Feb 2021 14:31:48 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Masters <jcm@jonmasters.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will@kernel.org>,
        mark.rutland@arm.com, linux-pci@vger.kernel.org,
        sudeep.holla@arm.com, lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
 <20210128233147.GA28434@bjorn-Precision-5520>
 <CACCGGCc3zULqHgUh3Q9wA5WtPBnQ4eq_v2+1qA8bOBCQZJ5YoQ@mail.gmail.com>
 <20210225093000.GA22843@e121166-lin.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <790e63a4-bd8c-8644-19de-645cf6691953@arm.com>
Date:   Thu, 25 Feb 2021 16:31:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210225093000.GA22843@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/25/21 3:30 AM, Lorenzo Pieralisi wrote:
> On Thu, Feb 18, 2021 at 12:43:30PM -0500, Jon Masters wrote:
>> Hi Bjorn, all,
>>
>> On Thu, Jan 28, 2021 at 6:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>      On Tue, Jan 26, 2021 at 10:46:04AM -0600, Jeremy Linton wrote:
>>
>>   
>>
>>      > Does that mean its open season for ECAM quirks, and we can expect
>>      > them to start being merged now?
>>
>>      "Open season" makes me cringe because it suggests we have a license to
>>      use quirks indiscriminately forever, and I hope that's not the case.
>>
>>      Lorenzo is closer to this issue than I am and has much better insight
>>      into the mess this could turn into.  From my point of view, it's
>>      shocking how much of a hassle this is compared to x86.  There just
>>      aren't ECAM quirks, in-kernel clock management, or any of that crap.
>>      I don't know how they do it on x86 and I don't have to care.  Whatever
>>      they need to do, they apparently do in AML.  Eventually ARM64 has to
>>      get there as well if vendors want distro support.
>>
>>      I don't want to be in the position of enforcing a draconian "no more
>>      quirks ever" policy.  The intent -- to encourage/force vendors to
>>      develop spec-compliant machines -- is good, but it seems like the
>>      reward of having compliant machines "just work" vs the penalty of
>>      having to write quirks and shepherd them upstream and into distros
>>      will probably be more effective and not much slower.
>>
>>
>> The problem is that the third party IP vendors (still) make too much junk. For
>> years, there wasn't a compliance program (e.g. SystemReady with some of the
>> meat behind PCI-SIG compliance) and even when there was the third party IP
>> vendors building "root ports" (not even RCs) would make some junk with a hacked
>> up Linux kernel booting on a model and demo that as "PCI". There wasn't the
>> kind of adult supervision that was required. It is (slowly) happening now, but
>> it's years and years late. It's just embarrassing to see the lack of ECAM that
>> works. In many cases, it's because the IP being used was baked years ago or
>> made for some "non server" (as if there is such a thing) use case, etc. But in
>> others, there was a chance to do it right, and it still happens. Some of us
>> have lost what hair we had over the years getting third party IP vendors to
>> wake up and start caring about this.
>>
>> So there's no excuse. None at all. However, this is where we are. And it /is/
>> improving. But it's still too slow, and we have platforms still coming to
>> market that need to boot and run. Based on this, and the need to have something
>> more flexible than just solving for ECAM deficiencies (which are really just a
>> symptom), I can see the allure of an SMC. I don't like it, but if that's where
>> folks want to go, and if we can find a way to constrain the enthusiasm for it,
>> then perhaps it is a path forward. But if we are to go down that path it needs
>> to come with a giant warning from the kernel that a system was booted at is
>> relying on that. Something that will cause an OS certification program to fail
>> without a waiver, or will cause customers to phone up for support wondering why
>> the hw is broken. It *must* not be a silent thing. It needs to be "this
>> hardware is broken and non-standard, get the next version fixed".
> 
> It is a stance I agree with in many respects, it should be shared (it
> was in HTML format - the lists unfortunately dropped the message) so I
> am replying to it to make it public.


So, the V3 of this set has a pr_info of "PCI: SMC conduit attached to 
segment %d". I will respin with that at pr_warn() which seems to fulfill 
the comment above. Is that "giant" enough, or should it be higher/worded 
differently?

Thanks,


