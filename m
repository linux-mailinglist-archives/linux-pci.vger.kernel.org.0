Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B23D429F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhGWVYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 17:24:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57802 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhGWVYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 17:24:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627077917; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=gJtuPTfqxC4kdihjJ9vxNkLwv1ZJHsY2IZL4on1Wp5E=;
 b=Bz44tuGFZMemOGYkjcSNRnXqU2701ZLvUJsUO55N20zipldPag/r1Py1VL+5PyOaSL3RWAKn
 oWjWyVsZOWfKseTTE8JRRmNvkxEB9haPRbZ9TW1gCqP6SYDtjqb4XIg95DgKE59EH3tbpDYN
 PCU4biVHfjAHub7KnQFqF9MbePU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60fb3d06b653fbdadd32fe55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Jul 2021 22:04:54
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCEA3C4360C; Fri, 23 Jul 2021 22:04:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97651C433D3;
        Fri, 23 Jul 2021 22:04:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Jul 2021 15:04:52 -0700
From:   hemantk@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, linux-pci@vger.kernel.org
Subject: Re: Query on ASPM driver design
In-Reply-To: <20210723203206.GA436727@bjorn-Precision-5520>
References: <20210723203206.GA436727@bjorn-Precision-5520>
Message-ID: <7c3c904bc19850f667e2249ccdee0b37@codeaurora.org>
X-Sender: hemantk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
On 2021-07-23 13:32, Bjorn Helgaas wrote:
> On Fri, Jul 23, 2021 at 01:11:18PM -0700, hemantk@codeaurora.org wrote:
>> Hi Bjorn,
> 
> It's best if you can cc: linux-pci@vger.kernel.org so others can
> contribute and benefit.
Good idea. Added now.
> 
>> I have a question regarding PCIe ASPM driver in upstream. Looks like
>> current ASPM driver is going to enable ASPM L1 and L1SS based on
>> EP's config space capability register read. Why ASPM driver is
>> enabling L1SS based on capability, instead of that can ASPM honor
>> default control register value (in EP config space) and let pci
>> device driver probe (or later after probe) to make the decision if
>> ASPM needs to be enabled or not.
> 
> Are you asking why the PCI core makes the decision about enabling ASPM
> instead of having each device driver decide?
Yes.
> 
> If you want each driver to decide, what benefit would that have?
Basically if PCI EP has capability to support ASPM L1 and L1SS but
power on default control reg values are meant to enumerate with ASPM 
disabled.
Which means EP wants to keep ASPM disabled right from the enumeration, 
and at some
point of time later EP wants to enable the ASPM. Main benefit is to give 
control
to EP to enumerate with what ever its control reg's power on default 
value is. EP
does not want to enable ASPM during its boot up and after entering to 
mission
mode use case it would enable the ASPM.

> 
> Obviously ASPM involves a power vs performance tradeoff, but
> functionally, ASPM is designed so drivers don't need to be aware of
> it.
> 
>> As far as i know there is an option to update quirk.c for a given
>> device id and vendor id to disable L0s/L1/L1SS but that sounds like
>> adding a software workaround to a device specific HW bug.
> 
> Yes.  It is common practice to use software quirks to work around
> hardware defects.
> 
>> Also, i know 5.5 kernel added a patch to control aspm using sysfs
>> per link basis:-
> 
>> https://patchwork.kernel.org/project/linux-pci/patch/b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com/
> 
> Yes.  This is intended for use by tools like powertop to tune the
> power vs performance tradeoff.
> 
>> Basically point is: it is possible to honor what device control reg
>> reflects power on default and let the pci ep driver running on host
>> to make the decision when to enable/disable the aspm in kernel space
>> pci driver.
> 
> There is a pci_disable_link_state() interface that drivers can use to
> disable certain link states.  Some drivers use this to work around
> hardware defects, but it would be better to use quirks in that
> situation.
Thanks for pointing this API, which quirk also uses. But we just have
disable ver which EP driver can call only after enumeration is done. i 
was
thinking of the other way round where EP enumerates and then calls 
enable
API at some point of time. Also, if it decides to again disable and then 
enable.

> 
>> Sorry if this was already well thought/discussed argument in the
>> design of ASPM driver, i would appreciate, if you can shed some
>> light on the reason for not taking that approach.
> 
> I don't know the history of that decision, but in general we try to do
> things in the core instead of endpoint drivers whenever possible
> because it reduces the complexity of drivers.
> 
> Bjorn

Thanks for taking your time to respond very promptly Bjorn!

-Hemant

---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
