Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB74799F3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhLRJba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhLRJba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 04:31:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82EC061574
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 01:31:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639819886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJr/zWN9zDC5sxa8TVVDQsnUf6sg2RymtgjmqgT28sA=;
        b=P2jWXWQWsYUtrqo+EKx/tjTWSk5E+LCT5YhLDYS/shkugqzQDVcihrZmch4azXUJRvSeFh
        SgRAHAYg5wtOVcpEhz0cn6XiAHsBpnxNk+zANSNDNWMFNp0Rclxrj/vYU/+C618Y+r7YrT
        fbeAgBnI8i1nFQIShLWWrT0NVukNDz29lBCvNSRLIrNnkEza1BoWh5+q3xTHVAYACpCq4n
        PsC8U7bOLkYU+81N/66P8JoRwMsQ9vQjWCLcy4sf9cCivchWy2LvvQdFuu1USPgaYDZsUi
        Zmn+qC5A+03sq3mTA6onaJunAin9COFR3XgILIRbFmkphYkBTqD+cg4zQgrrrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639819886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJr/zWN9zDC5sxa8TVVDQsnUf6sg2RymtgjmqgT28sA=;
        b=6sCD/4Hd8A5tdWSH7D1rnNMHS15P4u5x9Yz8nKaW6uXIpy21RdX05ExsTMoieW9mbvjMGw
        UkdzUoex4fwAeRDg==
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH V3] drm/i915/adl-n: Enable ADL-N platform
In-Reply-To: <87r1ab1huq.fsf@intel.com>
References: <20211210051802.4063958-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87r1ab1huq.fsf@intel.com>
Date:   Sat, 18 Dec 2021 10:31:25 +0100
Message-ID: <8735mqb6oi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17 2021 at 15:27, Jani Nikula wrote:
> On Fri, 10 Dec 2021, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>> Adding PCI device ids and enabling ADL-N platform.
>> ADL-N from i915 point of view is subplatform of ADL-P.
>>
>> BSpec: 68397
>>
>> Changes since V2:
>> 	- Added version log history
>> Changes since V1:
>> 	- replace IS_ALDERLAKE_N with IS_ADLP_N - Jani Nikula
>>
>> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
>
> Cc: x86 maintainers & lists
>
> Ack for merging the arch/x86/kernel/early-quirks.c PCI ID update via
> drm-intel?

Acked-by: Thomas Gleixner <tglx@linutronix.de>
