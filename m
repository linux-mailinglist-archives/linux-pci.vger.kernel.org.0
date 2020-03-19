Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3843418C144
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 21:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgCSUY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 16:24:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41201 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgCSUYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 16:24:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so4026604ljc.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvQkY59qXbqmh2jA/0FCgGEES29MX9NxM3v9QbCaiJg=;
        b=BZCx6sdMC/lZySAftdRcfeiiSq2uZA9YVpplNcpG2p8J9RhJnbGmiUdzWYXMmfV1pt
         qRp5YBrSnlyF9mvpiq75rGA2Teb1lRawyJ+HHOPY9yq0q29xhakmwe+xEq4Izg4v9vsZ
         ilCqAnpC4TIwbvbJyaI81jwVNVrb1D6HsAIrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvQkY59qXbqmh2jA/0FCgGEES29MX9NxM3v9QbCaiJg=;
        b=QdOuHNvafCikzL4alg0EEcSZlF7aueWVM0guTDuGf4yzsrmwEJaHMyyDvy4y77hkWm
         Hg/EZ9EwrLr5x41sPm4IPjBXORxZs2Wk3I5+f+eh0L2Ih7D5/USKBLUOSS32UPmNfHIu
         6MusL9VrbGQmMtKkzJmLUd7h2k0v9V68IlYJAJkeOfADbBr1BrKud4JYyaF4zG5x6pTo
         +9d/qalHf0aeAfOPUnlyX73Vb/o0/h/7afE97BthRFZPzA2hvtkiJb/1o1fOgxQ7RkoX
         X3P2JGUn8BYFrt16qUaZ+RNXdZaiL5B6EyqEAY1M+r6EIZNi6hlN5BOML2YGLL5he6Y7
         LQyw==
X-Gm-Message-State: ANhLgQ0/B4PTjJZpp3H7bqhk2W86qi7gcfa7900Yyi3HceZGv+P/sg8W
        /NBDj2IN8NQyZ3ER6TGb2lr61XqzYAc=
X-Google-Smtp-Source: ADFU+vtrlo8gsU3JzLWdj6gRTx7lPYRrvPQ8OBkP72Vtn8msv1FVhSJOwkvjV7tw7yArYwLqhlFm3w==
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr3266084ljm.248.1584649490895;
        Thu, 19 Mar 2020 13:24:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u5sm1607536lfm.74.2020.03.19.13.24.49
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 13:24:50 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z22so2753112lfd.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 13:24:49 -0700 (PDT)
X-Received: by 2002:a19:c748:: with SMTP id x69mr3099253lff.196.1584649489074;
 Thu, 19 Mar 2020 13:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
In-Reply-To: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 19 Mar 2020 13:24:12 -0700
X-Gmail-Original-Message-ID: <CAE=gft4Vx8tD71TXFD++hMLiExBWDNXn7LA6ohkGLwZvG2N6YQ@mail.gmail.com>
Message-ID: <CAE=gft4Vx8tD71TXFD++hMLiExBWDNXn7LA6ohkGLwZvG2N6YQ@mail.gmail.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     x86@kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 12:23 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> Hi
>
> I can reproduce the lost MSI interrupt issue on 5.6-rc6 which includes
> the "Plug non-maskable MSI affinity race" patch.
>
> I can see this on a couple platforms, I'm running a script that first generates
> a lot of usb traffic, and then in a busyloop sets irq affinity and turns off
> and on cpus:
>
> for i in 1 3 5 7; do
>         echo "1" > /sys/devices/system/cpu/cpu$i/online
> done
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "F" > "/proc/irq/*/smp_affinity"
> for i in 1 3 5 7; do
>         echo "0" > /sys/devices/system/cpu/cpu$i/online
> done
>
> I added some very simple debugging but I don't really know what to look for.
> xhci interrupts (122) just stop after a setting msi affinity, it survived many
> similar msi_set_affinity() calls before this.
>
> I'm not that familiar with the inner workings of this, but I'll be happy to
> help out with adding debugging and testing patches.

How quickly are you able to reproduce this when you run your script?
Does reverting Thomas' patch make it repro faster? Can you send the
output of lspci -vvv for the xhci device?

-Evan
