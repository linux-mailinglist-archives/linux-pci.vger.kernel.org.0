Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F02383CE9
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhEQTJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 15:09:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhEQTJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 15:09:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621278508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZq0Zc1ElW6yPz6imj2oxDmoySZoSSEBMbiufUA2Zmg=;
        b=o9SQmC70s2eFvxz//H6OLHxYHDqY03vKEABdmcJffUJdxoDE87/lhAJMMZVY2Dwze1oLsn
        zQgHg1g7DlquvL0lXHsQKQZ4CFqYDHyZSrDXTTKUcrxeUH2CGy41KWgB620tLMpaygbqVR
        6j+VVrHb7m5+VPg2F/w78jRZ4o2me/U07mY4WQpWYY8J1iJHN5CSuxBf26syFS2tbRkWa7
        MBfFKEgk5mVCma/Or3ouChFirAD3Ev4R5uo7+jq4PJpCgKQoPA7Ehfx2jKKHe1uqKMz4lB
        Q1VvgjDheJp1mUFX3NqVjFSclKy0ySROj49btfkJRKs03KvwAGdj0yBp0+ASoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621278508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZq0Zc1ElW6yPz6imj2oxDmoySZoSSEBMbiufUA2Zmg=;
        b=e0aQcF3w2r0jSv9EnzJ3s3M+MP2CDaqYaTFGXis35a5At/TqI3mnTBo4LHbiRLWFFb0+5r
        qoL7yx7aWNgupPDQ==
To:     Robin Murphy <robin.murphy@arm.com>, Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "frederic\@kernel.org" <frederic@kernel.org>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        Alex Belits <abelits@marvell.com>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas\@google.com" <bhelgaas@google.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt\@goodmis.org" <rostedt@goodmis.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr\@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen\@networkplumber.org" <stephen@networkplumber.org>,
        "rppt\@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi\@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun\@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when setting the hint
In-Reply-To: <d1d5e797-49ee-4968-88c6-c07119343492@arm.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com> <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com> <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com> <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com> <87sg2lz0zz.ffs@nanos.tec.linutronix.de> <d1d5e797-49ee-4968-88c6-c07119343492@arm.com>
Date:   Mon, 17 May 2021 21:08:27 +0200
Message-ID: <874kf1faac.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17 2021 at 19:50, Robin Murphy wrote:

> On 2021-05-17 19:08, Thomas Gleixner wrote:
>> On Mon, May 17 2021 at 18:26, Robin Murphy wrote:
>>> On 2021-05-17 17:57, Nitesh Lal wrote:
>>> I'm not implying that there isn't a bug, or that this code ever made
>>> sense in the first place, just that fixing it will unfortunately be a
>>> bit more involved than a simple revert. This patch as-is *will* subtly
>>> break at least the system PMU drivers currently using
>> 
>> s/using/abusing/
>> 
>>> irq_set_affinity_hint() - those I know require the IRQ affinity to
>>> follow whichever CPU the PMU context is bound to, in order to meet perf
>>> core's assumptions about mutual exclusion.
>> 
>> Which driver is that?
>
> Right now, any driver which wants to control an IRQ's affinity and also 
> build as a module, for one thing. I'm familiar with drivers/perf/ where 
> a basic pattern has been widely copied;

Bah. Why the heck can't people talk and just go and rumage until they
find something which hopefully does what they want...

The name of that function should have rang all alarm bells...

> some of the callers in other subsystems appear to *expect* it to set
> the underlying affinity as well, but whether any of those added within
> the last 6 years represent a functional dependency rather than just a
> performance concern I don't know.

Sigh. Let me do yet another tree wide audit...

Thanks,

        tglx


