Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BE3C255A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGIN7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 09:59:42 -0400
Received: from foss.arm.com ([217.140.110.172]:53552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhGIN7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 09:59:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF5FED1;
        Fri,  9 Jul 2021 06:56:58 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000A63F694;
        Fri,  9 Jul 2021 06:56:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Joerg Roedel <joro@8bytes.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Jonathan Corbet <corbet@lwn.net>, quic_c_gdjako@quicinc.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
Date:   Fri, 9 Jul 2021 14:56:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOaymBHc4g2cIfRn@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-07-08 09:08, Joerg Roedel wrote:
> On Wed, Jul 07, 2021 at 01:00:13PM -0700, Doug Anderson wrote:
>> a) Nothing is inherently broken with my current approach.
>>
>> b) My current approach doesn't make anybody terribly upset even if
>> nobody is totally in love with it.
> 
> Well, no, sorry :)
> 
> I don't think it is a good idea to allow drivers to opt-out of the
> strict-setting. This is a platform or user decision, and the driver
> should accept whatever it gets.
> 
> So the real question is still why strict is the default setting and how
> to change that. Or document for the users that want performance how to
> change the setting, so that they can decide.

As I mentioned before, conceptually I think this very much belongs in 
sysfs as a user decision. We essentially have 4 levels of "strictness":

1: DMA domain with bounce pages
2: DMA domain
3: DMA domain with flush queue
4: Identity domain

The "make this device go faster because I trust it" use-case is why we 
have the sysfs interface to switch between 2 and 4, so it's entirely 
logical to have the intermediate option as well for when 3 is "faster" 
enough while still giving a bit more peace of mind than full-on bypass.

Making it a platform-specific decision that's hidden in a driver - 
arm-smmu-qcom can be considered a dumping ground of detailed platform 
knowledge ;) - happens to work as a reasonable compromise for this 
specific case, but I concur that it could be viewed as setting a 
precedent for other cases which we definitely aren't as reasonable.

I've been thinking about the sysfs thing some more, and since it's 
Friday afternoon and I can't concentrate on what I'm supposed to be 
doing anyway, let's see how far I can get by Monday...

Robin.
