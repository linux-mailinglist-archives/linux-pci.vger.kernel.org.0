Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE673B0FE4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 00:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFVWMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 18:12:44 -0400
Received: from foss.arm.com ([217.140.110.172]:56020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhFVWMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 18:12:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3700ED1;
        Tue, 22 Jun 2021 15:10:26 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 553FD3F694;
        Tue, 22 Jun 2021 15:10:22 -0700 (PDT)
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
 <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <498f3184-99fe-c21b-0eb0-a199f2615ceb@arm.com>
Date:   Tue, 22 Jun 2021 23:10:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-22 17:06, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Doug,
>>
>> On 2021-06-22 00:52, Douglas Anderson wrote:
>>>
>>> This patch attempts to put forward a proposal for enabling non-strict
>>> DMA on a device-by-device basis. The patch series requests non-strict
>>> DMA for the Qualcomm SDHCI controller as a first device to enable,
>>> getting a nice bump in performance with what's believed to be a very
>>> small drop in security / safety (see the patch for the full argument).
>>>
>>> As part of this patch series I am end up slightly cleaning up some of
>>> the interactions between the PCI subsystem and the IOMMU subsystem but
>>> I don't go all the way to fully remove all the tentacles. Specifically
>>> this patch series only concerns itself with a single aspect: strict
>>> vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
>>> to talk about / reason about for more subsystems compared to overall
>>> deciding what it means for a device to be "external" or "untrusted".
>>>
>>> If something like this patch series ends up being landable, it will
>>> undoubtedly need coordination between many maintainers to land. I
>>> believe it's fully bisectable but later patches in the series
>>> definitely depend on earlier ones. Sorry for the long CC list. :(
>>
>> Unfortunately, this doesn't work. In normal operation, the default
>> domains should be established long before individual drivers are even
>> loaded (if they are modules), let alone anywhere near probing. The fact
>> that iommu_probe_device() sometimes gets called far too late off the
>> back of driver probe is an unfortunate artefact of the original
>> probe-deferral scheme, and causes other problems like potentially
>> malformed groups - I've been forming a plan to fix that for a while now,
>> so I for one really can't condone anything trying to rely on it.
>> Non-deterministic behaviour based on driver probe order for multi-device
>> groups is part of the existing problem, and your proposal seems equally
>> vulnerable to that too.
> 
> Doh! :( I definitely can't say I understand the iommu subsystem
> amazingly well. It was working for me, but I could believe that I was
> somehow violating a rule somewhere.
> 
> I'm having a bit of a hard time understanding where the problem is
> though. Is there any chance that you missed the part of my series
> where I introduced a "pre_probe" step? Specifically, I see this:
> 
> * really_probe() is called w/ a driver and a device.
> * -> calls dev->bus->dma_configure() w/ a "struct device *"
> * -> eventually calls iommu_probe_device() w/ the device.

This...

> * -> calls iommu_alloc_default_domain() w/ the device
> * -> calls iommu_group_alloc_default_domain()
> * -> always allocates a new domain
> 
> ...so we always have a "struct device" when a domain is allocated if
> that domain is going to be associated with a device.
> 
> I will agree that iommu_probe_device() is called before the driver
> probe, but unless I missed something it's after the device driver is
> loaded.  ...and assuming something like patch #1 in this series looks
> OK then iommu_probe_device() will be called after "pre_probe".
> 
> So assuming I'm not missing something, I'm not actually relying the
> IOMMU getting init off the back of driver probe.

...is implicitly that. Sorry that it's not obvious.

The "proper" flow is that iommu_probe_device() is called for everything 
which already exists during the IOMMU driver's own probe when it calls 
bus_set_iommu(), then at BUS_NOTIFY_ADD_DEVICE time for everything which 
appears subsequently. The only trouble is, to observe it in action on a 
DT-based system you'd currently have to go back at least 4 years, before 
09515ef5ddad...

Basically there were two issues: firstly we need the of_xlate step 
before add_device (now probe_device) for a DT-based IOMMU driver to know 
whether it should care about the given device or not. When -EPROBE_DEFER 
was the only tool we had to ensure probe ordering, and resolving the 
"iommus" DT property the only place to decide that, delaying it all 
until driver probe time was the only reasonable option, however ugly. 
The iommu_probe_device() "replay" in {of,acpi}_iommu_configure() is 
merely doing its best to fake up the previous behaviour. Try binding a 
dummy driver to your device first, then unbind it and bind the real one, 
and you'll see that iommu_probe_device() doesn't run the second or 
subsequent times. Now that we have fw_devlink to take care of ordering, 
the main reason for this weirdness is largely gone, so I'm keen to start 
getting rid of the divergence again as far as possible. Fundamentally, 
IOMMU drivers are supposed to be aware of all devices which the kernel 
knows about, regardless of whether they have a driver available or not.

The second issue is that when we have multiple IOMMU instances, the 
initial bus_set_iommu() "replay" is only useful for the first instance, 
so devices managed by other instances which aren't up and running yet 
will be glossed over. Currently this ends up being papered over by the 
solution to the first point on DT systems, while the x86 drivers hide 
their individual IOMMU units behind a single IOMMU API "instance", so 
it's been having little impact in practice. However, improving the core 
API's multi-instance support is an increasingly pressing issue now that 
new more varied systems are showing up, and it's that which is really 
going to be driving the aforementioned changes. FWIW the plan I 
currently have is to hang things off iommu_device_register() instead.

>> FWIW we already have a go-faster knob for people who want to tweak the
>> security/performance compromise for specific devices, namely the sysfs
>> interface for changing a group's domain type before binding the relevant
>> driver(s). Is that something you could use in your application, say from
>> an initramfs script?
> 
> We've never had an initramfs script in Chrome OS. I don't know all the
> history of why (I'm trying to check), but I'm nearly certain it was a
> conscious decision. Probably it has to do with the fact that we're not
> trying to build a generic distribution where a single boot source can
> boot a huge variety of hardware. We generally have one kernel for a
> class of devices. I believe avoiding the initramfs just keeps things
> simpler.
> 
> I think trying to revamp Chrome OS to switch to an initramfs type
> system would be a pretty big undertaking since (as I understand it)
> you can't just run a little command and then return to the normal boot
> flow. Once you switch to initramfs you're committing to finding /
> setting up the rootfs yourself and on Chrome OS I believe that means a
> whole bunch of dm-verity work.
> 
> 
> ...so probably the initramfs is a no-go for me, but I'm still crossing
> my fingers that the pre_probe() might be legit if you take a second
> look at it?

That's fair enough - TBH the current sysfs interface is a pretty 
specialist sport primarily for datacentre folks who can afford to take 
down their 40GBE NIC or whatever momentarily for a longer-term payoff, 
but it was worth exploring - I'm assuming the SDHCI holds your root 
filesystem so you wouldn't be able to do the unbinding dance from real 
userspace. As I said, the idea of embedding any sort of data in 
individual client drivers is a non-starter in general since it only has 
any hope of working on DT platforms (maybe arm64 ACPI too?), and only 
for very much the wrong reasons.

If this is something primarily demanded by QCom platforms in the short 
term, I'm tempted to say just try it with more device-matching magic in 
arm-smmu-qcom. Otherwise, the idea of growing the sysfs interface to 
allow switching a DMA domain from default-strict to non-strict is 
certainly an interesting prospect. Going a step beyond that to bring up 
a flush queue 'live' without rebuilding the whole group and domain could 
get ugly when it comes to drivers' interaction with io-pgtable, but I 
think it might be *technically* feasible...

Robin.
