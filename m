Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3431A66C6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgDMNL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 09:11:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728502AbgDMNLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 09:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586783483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIzOt50qCMDrR8+x22GmkfIIGJdcpsoV6Dog0U8l+cg=;
        b=YBG8XVcf9V32gNtkfmAUKUoOxRWIsq7MLTov0YyqeHsYj74y2tivzMhtSnph3fBvqSUgmV
        +76PeD8/2e7heijsHKZBnJSxFNXg08Xe3DrbBd1iABLNNLupzNL6CEqrQ48fjVHSEDrefm
        Y6boOsci9GUzDiXjdke1Un2YfRGfB6E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-2GjNE-3cOUaNOgzf3yODvA-1; Mon, 13 Apr 2020 09:11:22 -0400
X-MC-Unique: 2GjNE-3cOUaNOgzf3yODvA-1
Received: by mail-wr1-f70.google.com with SMTP id v14so6676431wrq.13
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2020 06:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIzOt50qCMDrR8+x22GmkfIIGJdcpsoV6Dog0U8l+cg=;
        b=DQ3ppQ7UGsiVp3XZA8/aOjxq57vV+rWG5P0ugMzmyZA8vlZfSai8DAZSn4rm/BUCCw
         CeuyXsZE5dzCnF8sKDHnMcxDzte9BqlGGP9XKNcYYTb1kFb3m1G+e0ucEXBp9c1zsWCX
         yDGLWmiAhqvEiIHjr8h9GJqwsYqWPRiyb5wBicIpuq6p7qCxy0JS1+uUdyafxpcw9s+a
         1DyJLLkTC8UGfJxEtzBcXfxqLepJR/fTzLDi9d/HRqyuKIkIAPIWvetKkEHKTgorY4cT
         G5t49BNwSwAFw173CPniGMSqRbKpnFhBHBVyRU0NRO4+J3CAI7IjtshovUfk78I2cN5B
         ZTHQ==
X-Gm-Message-State: AGi0PuZ0R0VzvHhqInK5HxPjMaff6SK7aLYuKehaZqV1R4hYPEimADph
        SGxAcVVmHMvUUsU1I7anO9fQk5JjdTZF6m4DLmv5AwpvJP/oo70sPyU0vFikzskndqpIK2xXFWs
        3hbUBspsR3YLAiPtSSlvB
X-Received: by 2002:adf:fe87:: with SMTP id l7mr3901104wrr.360.1586783480843;
        Mon, 13 Apr 2020 06:11:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDoBHFkpJzoFrPwJ5is0GUD63dGqZWo2iX5EtpuugfLax6aJbmVddQwhVda5XX4QcR/KQIQw==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr3901084wrr.360.1586783480597;
        Mon, 13 Apr 2020 06:11:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s18sm5721389wrv.2.2020.04.13.06.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 06:11:19 -0700 (PDT)
Subject: Re: [PATCH 0/7] PM: sleep: core: Rearrange the handling of driver
 power management flags
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1888197.j9z7NJ8yPn@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ccb3913e-1ebf-7f4d-b699-cfd2506d2d69@redhat.com>
Date:   Mon, 13 Apr 2020 15:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1888197.j9z7NJ8yPn@kreacher>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/10/20 5:46 PM, Rafael J. Wysocki wrote:
> Hi Alan,
> 
> Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
> I have decided to follow some of your recommendations and make changes to the
> core code handling those flags.
> 
> The purpose of this is basically to make the code more consistent internally,
> easier to follow and better documented.
> 
> First of all, patch [1/7] changes the PM core to skip driver-level "late"
> and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
> still runtime-suspended during the "late" system-wide suspend phase (without
> the patch it does that only if subsystem-level late/noirq/early suspend/resume
> callbacks are not present for the device, which is demonstrably inconsistent)
> and updates the resume part of the code accordingly (it doesn't need to check
> whether or not the subsystem-level callbacks are present any more).
> 
> The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
> the LOC number and move related pieces of code closer to each other.
> 
> Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
> callbacks during system-wide resume (without the patch they may be skipped in
> the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
> may be problematic) and to always run the driver's ->resume callback if the
> corresponding subsystem-level callback is not present (without the patch it
> may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
> by the driver's ->suspend callback (which always runs too) if need be.
> 
> Patches [4-6/7] rename one function in the PM core and two driver PM flags to
> make their names better reflect their purpose.
> 
> Finally, patch [7/7] updates the documentation of the driver PM flags to
> reflect the new code flows.
> 
> This patch series have been available in the git branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   pm-sleep-core
> 
> for easier web and git access.

The series looks sane to me at a first look. I've added it to my local
tree for testing on all the pesky Bay and Cherry Trail devices I have
and which always cause trouble in this area.

Regards,

Hans

