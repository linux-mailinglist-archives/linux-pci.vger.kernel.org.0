Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0263F1E8B4C
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2W0z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2W0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 18:26:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0852C03E969;
        Fri, 29 May 2020 15:26:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so5653514wrr.10;
        Fri, 29 May 2020 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lVYA/yfJI5TaEakm/6pSuFTgrszvzSslMQr1boHj+eo=;
        b=exi6dF1WzRA3XY16RKHO13lNKswIwJP7uC6wlvK8Y9yoj74aobAfBue4fIUJAGdinp
         ZqVMKkCF8ytXI9KjjHqwRr7Kt4CByh3tunV2QFsG/iWcWmGptqgTZG9v4mLPUcu4p12y
         mAl9H21i1w/VFdgMLkpKqPKU8c6N0qNfaSYpDk2VjQ1oXiKZ3p5Xn886PiKFN9O2BSP6
         P94a2dRSgYjtoNxKCAXXqK8l7ola0bk/sQ6tnX7BzGcMyLxY1QS4ByDqlL5EiZzXAbsi
         TXkDZvBGkfldwNRc94dskWjwLbrpXidWAxe0ihKdLrkTwUvkzEhAC5Lj4yaLzNM+VtxD
         T15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lVYA/yfJI5TaEakm/6pSuFTgrszvzSslMQr1boHj+eo=;
        b=FxkRg/sHdE01u1bZv5qejFCyrOTxwS3amY8is4FLjd/jzjWBy78OI4nXX+eJ9yOi4S
         Q2HvcPL/szlpV1GXd3WpYLcG/8gvnzkmKqrPoLBMcgM+bCBzL0lnDLbBBkmPBTwteDWX
         puy7bYMN66++5l7R3CPLgfaZzYYNj14CZ6PtdouiTgVs+Tozz1QHqSjzzJzUWhqn+0gN
         K3VBO5rtQ9ZFWD0S/RJSOxC/AXsiejFn3oLpCKf+xeMXJYQLqf5G6sLwdu/RuU+AxR8i
         5AxKZIQ9YMfswhzztQOb+zfdTgcN0lAWbe1z9Ob1SzPN7pnUN/KaO7Dp1b//XIa48xTi
         WoYg==
X-Gm-Message-State: AOAM5317G4hOZ++cv9I85LBO1S0sLTPvLh7p7f3RMzRqF0AI+TE/qhvh
        TyDh4aoQYDeXHymdm3CKV7ueVm0R
X-Google-Smtp-Source: ABdhPJxFTlfXmevYUGW6SIT7ZFKRSiFNvKUS804FCoxY/fJPUSw6cFymILmi7PX4RjFI4yij5gY0Iw==
X-Received: by 2002:adf:e749:: with SMTP id c9mr11503516wrn.25.1590791182273;
        Fri, 29 May 2020 15:26:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:cfc:56dc:3d49:4699? (p200300ea8f2357000cfc56dc3d494699.dip0.t-ipconnect.de. [2003:ea:8f23:5700:cfc:56dc:3d49:4699])
        by smtp.googlemail.com with ESMTPSA id 23sm1243387wmo.18.2020.05.29.15.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 15:26:21 -0700 (PDT)
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
 <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
Date:   Sat, 30 May 2020 00:26:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.05.2020 22:59, Matthew Garrett wrote:
> On Fri, May 29, 2020 at 03:21:35PM -0500, Bjorn Helgaas wrote:
> 
>> Yeah, that makes sense.  I can't remember the details, but I'm pretty
>> sure there's a reason why we ask for the whole set of things.  Seems
>> like it solved some problem.  I think Matthew Garrett might have been
>> involved in that.
> 
> This was https://bugzilla.redhat.com/show_bug.cgi?id=638912 - some 
> firmware misbehaves unless you pass the same set of supported 
> functionality as Windows does.
> 

Current situation means that PME is unusable on all systems where
pcie_aspm_support_enabled() returns false, what is basically every
system except EXPERT mode is enabled and CONFIG_PCIEASPM is set.
So we definitely need to do something.

One question is whether the system from the 10yr old bug report
actually depends on OSC_PCI_EXPRESS_LTR_CONTROL control, or whether
some other change in recent years fixed the issue.
Not sure whether the system is still available for re-testing.

If worst case we have 10yr old systems breaking with a new kernel
then we still would have the workaround to enable CONFIG_PCIEASPM
on that system.
