Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E651827EA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 05:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgCLElR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Mar 2020 00:41:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgCLElP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 00:41:15 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jCFej-00011I-Eq
        for linux-pci@vger.kernel.org; Thu, 12 Mar 2020 04:41:13 +0000
Received: by mail-pl1-f199.google.com with SMTP id w11so2575395plp.22
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 21:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HB0cAE4oxL2E4BOZcXbK5oTAfOt5Od5iJ5nMJmPDGQU=;
        b=SJvKQUuH5ymC5F6manhbCeot1EWdoyWKk+hDsc2YWTG/GKrC4BSHnhs+oJThSLSCZ8
         x8ZOb+NYZuRXC+JHN+LRjvKbjvjbYBkLKfyDZghCiTtNh0DvTExLO+x2pwODWYP2SozY
         mvEnk8Rt6yCQc6Ln24FZ7UgC5pG0nmZYh3spooOGe8JhCG2SHOE7TlxRC1+yS4fGDn/v
         KV6QJY2Y9w5FewsfosLHVtavfIPcj73HC/RKN1mLC+P3l9bv6gMA69XCU/LZtCM4NEv+
         iuKnj5+SFprO3hr42EXyAv6+mxVME3PL5itowuMQxk49IwxkU2GHiLWtXTZYvlB+ObnV
         Tt9A==
X-Gm-Message-State: ANhLgQ1Z+K131owd0XBc0QQ/0smCPeqh5M8FbVgiUJP6XfWaB3IIxFk2
        g5zrB/oSowXDx27qDoEgVqyD0xGB6wPg4OxKgi2cGqgxfsLFDhPiNk2HVPFTQXwfDtHXfgUBV8S
        v5VzltkL6wFEa747MXc9lfE0AkepXiAAMrnCojw==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr2197052pjp.40.1583988071815;
        Wed, 11 Mar 2020 21:41:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstoaA6BePG06bC3hsSjV/viLf5I9daEAx7zXmau8SeMcp8CM/i4NX78y75f/5fk4LliXcOoA==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr2197033pjp.40.1583988071462;
        Wed, 11 Mar 2020 21:41:11 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q9sm50973886pgs.89.2020.03.11.21.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 21:41:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200311103840.GB2540@lahna.fi.intel.com>
Date:   Thu, 12 Mar 2020 12:41:08 +0800
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
 <20200311103840.GB2540@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Mar 11, 2020, at 18:38, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
>> Hi,
>> 
>> I am currently investigating long suspend and resume time of suspend-to-idle.
>> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
>> 
>> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
>> 
>> 	/* Avoid direct_complete to let wakeup_path propagate. */
>> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
>> 			dev->power.direct_complete = false;
> 
> You need to be careful here because otherwise you end up situation where
> the link is not properly trained and we tear down the whole tree of
> devices which is worse than waiting bit more for resume.

My idea is to direct-complete when there's no PCI or USB device plugged into the TBT, and use pm_reuqest_resume() in complete() so it won't block resume() or resume_noirq().

> 
>> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
>> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
>> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
>> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
>> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...
> 
> Which system this is? ICL?

CML-H + Titan Ridge.

> I think it is the TBT root ports only that do
> not support active link reporting. The PCIe spec is not entirely clear
> about root ports since it explictly mentions only downstream ports so
> one option would be to check for root port and that it supports gen 3
> speeds and based on that wait for max say 2 * 100ms or something like
> that.

So 200ms for rootport, but still 1100ms for downstream ports?

Kai-Heng
