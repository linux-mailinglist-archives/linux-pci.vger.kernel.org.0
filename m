Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7672C4C4D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 01:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgKZAul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 19:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKZAul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 19:50:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CFC0613D4;
        Wed, 25 Nov 2020 16:50:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606351840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzr6UOnsfyNXZdV6NA8bv0lhwjnBdh+CcA7c2WqTOSg=;
        b=g6jiyEdXD5WNu/5SEzbD5xJdSl95lHvmYh7cn55huXcxwNNhbg0KKz2xKI46Pkn1PUQK6n
        Q80HByiMpuO7YMh3cE+gqSj0gM+uCFUrhCaoZuiwCm5zAp9Sr6tlOqtHanCGGX0QBbtvew
        tJ2isQFsddTi+JanWS0hrNlR1Hvj4TTen0+Ccst4KHh15MjbUPdH9riShDA3zxq8wzIEmk
        25Yw9XD3tVKdPSZrrCiq5/RTIJwZTsC2Z5U50CHcXGJN5YMNpTh/LcAj8u5rgQGGezXwEl
        QksCZZwQnVgDxyolcZJoe2nirJcQKx/PlA/uY9b89CFEks+seUdaloiu/Jq7lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606351840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzr6UOnsfyNXZdV6NA8bv0lhwjnBdh+CcA7c2WqTOSg=;
        b=2R0YMZIJ5dKXYcHHC4jYWwBdWun70vMGbQ/XNTxbGMP9hssPQssKyN5ppzXpI0DzJC29d7
        g1HaUlFMVh6D5jBQ==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
In-Reply-To: <20201125191327.GA653914@bjorn-Precision-5520>
References: <20201125191327.GA653914@bjorn-Precision-5520>
Date:   Thu, 26 Nov 2020 01:50:39 +0100
Message-ID: <87lfepj600.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25 2020 at 13:13, Bjorn Helgaas wrote:
> On Wed, Nov 25, 2020 at 01:46:23PM +0100, Thomas Gleixner wrote:
>> Now the more interesting question is why this needs to be a PCI quirk in
>> the first place. Can't we just disable the HPET based on family/model
>> quirks?
>
> You mean like a CPUID check or something?  I'm all in favor of doing
> something that doesn't depend on PCI.

The reason why these are PCI quirks is that the HPET is not part of the
CPU core. It's usually part of 00:00:0 (aka. host bridge) and the legacy
mess which resides there.

OTOH that thing is integrated into the actual chip nowadays and these
quirks are platform quirks, so the CPUID and the PCI vendor/device codes
should be the same for a particular model.

But what do I know. This whole platform/cpuid mess is inpenetrable even
for people who have access to the Intel internal documentation...

But, the point is that HPET does not provide any value on contemporary
CPUs assumed that Intel finally decided that TSC and the TSC deadline
timer are crucial system components along with the ability to get the
correct frequency of these beasts from firmware/cpuid.

So if parts of a particular chip generation, which we can determine by
CPUID (family, model) has issues with HPET, then there is no value in
preserving HPET for the N out of M submodels which are not affected even
if we can differentiate them by the host bridge device id.

But as I said above, what do I know. The Intel wizards which might have
better insight into this should speak up and come forth with objections.

Otherwise I just go and disable HPET support for the CPU models which
are covered by these PCI quirks today.

Ideally we can just disable it for anything more modern as well, but of
course that requires that future devices have proper frequency
enumeration and Intel prevents the OEMs to screw that up with their
"value add" BIOS/SMM machinery. Hope dies last...

Thanks,

        tglx
