Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CC3DE82D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhHCITd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 04:19:33 -0400
Received: from foss.arm.com ([217.140.110.172]:44550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234311AbhHCITd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 04:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85A9D6E;
        Tue,  3 Aug 2021 01:19:21 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22C3F3F70D;
        Tue,  3 Aug 2021 01:19:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Rajat Jain <rajatja@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
 <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
 <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com>
 <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
 <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9a1bc174-3230-912c-09ae-25d9f021e8fc@arm.com>
Date:   Tue, 3 Aug 2021 09:19:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-03 01:09, Rajat Jain wrote:
> Hi Robin, Doug,
> 
> On Wed, Jul 14, 2021 at 8:14 AM Doug Anderson <dianders@chromium.org> wrote:
>>
>> Hi,
>>
>> On Tue, Jul 13, 2021 at 11:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2021-07-08 15:36, Doug Anderson wrote:
>>> [...]
>>>>> Or document for the users that want performance how to
>>>>> change the setting, so that they can decide.
>>>>
>>>> Pushing this to the users can make sense for a Linux distribution but
>>>> probably less sense for an embedded platform. So I'm happy to make
>>>> some way for a user to override this (like via kernel command line),
>>>> but I also strongly believe there should be a default that users don't
>>>> have to futz with that we think is correct.
>>>
>>> FYI I did make progress on the "punt it to userspace" approach. I'm not
>>> posting it even as an RFC yet because I still need to set up a machine
>>> to try actually testing any of it (it's almost certainly broken
>>> somewhere), but in the end it comes out looking surprisingly not too bad
>>> overall. If you're curious to take a look in the meantime I put it here:
>>>
>>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq
> 
> I was wondering if you got any closer to testing / sending it out? I
> looked at the patches and am trying to understand, would they also
> make it possible to convert at runtime, an existing "non-strict"
> domain (for a particular device) into a "strict" domain leaving the
> other devices/domains as-is? Please let me know when you think your
> patches are good to be tested, and I'd also be interested in trying
> them out.

Yup, most recently here:

https://lore.kernel.org/linux-iommu/cover.1627468308.git.robin.murphy@arm.com/

I'm currently getting v3 ready, so I'll try to remember to add you to 
the CC list.

>> Being able to change this at runtime through sysfs sounds great and it
>> fills all the needs I'm aware of, thanks! In Chrome OS we can just use
>> this with some udev rules and get everything we need.
> 
> I still have another (inverse) use case where this does not work:
> We have an Intel chromebook with the default domain type being
> non-strict. There is an LTE modem (an internal PCI device which cannot
> be marked external), which we'd like to be treated as a "Strict" DMA
> domain.
> 
> Do I understand it right that using Rob's patches, I could potentially
> switch the domain to "strict" *after* booting (since we don't use
> initramfs), but by that time, the driver might have already attached
> to the modem device (using "non-strict" domain), and thus the damage
> may have already been done? So perhaps we still need a device property
> that the firmware could use to indicate "strictness" for certain
> devices at boot?

Well, in my view the "external facing" firmware property *should* 
effectively be the "I don't trust this device not to misbehave" 
property, but I guess it's a bit too conflated with other aspects of 
Thunderbolt root ports (at least in the ACPI definition) to abuse in 
that manner.

Ideas off the top of my head would be to flip the default domain type 
and manually relax all the other performance-sensitive devices instead, 
or module_blacklist the modem driver to load manually later after 
tweaking its group. However, if you think it's a sufficiently general 
concern, maybe a quirk to set pci_dev->untrusted might be worth 
exploring? It may make sense to drive such a thing from a command-line 
option rather than a hard-coded list, though, since trust is really down 
to the individual use-case.

[ re gitlab.arm.com, I understand it tends not to like large transfers - 
some colleagues have reported similar issues pushing large repos as 
well. I'd suggest cloning the base mainline repo from kernel.org or 
another reliable source, then fetching my branch into that. I've just 
tried that on a different machine (outside the work network) and it 
worked fine) ]

Thanks,
Robin.
