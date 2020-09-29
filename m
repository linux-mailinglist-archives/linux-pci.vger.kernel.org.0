Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266D527BAD2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 04:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgI2C2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgI2C2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 22:28:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1546C061755;
        Mon, 28 Sep 2020 19:28:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e22so4625938edq.6;
        Mon, 28 Sep 2020 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygg9/4iRHT21kcmBGkSM1pLATrrcqMs4HjO1+e+77XE=;
        b=Vl6HngjmW6fkWNnFUozmkjOJ7Aeg1U7JaEUUQe3qD7RGFCCRL2X9yWPmil47nY3Fh9
         XQtiIhpFdniiqBQ/3oSBl+ChvTWQ69m8pd7tdftr9ZocGBS5AcQw7pKxYzPoQBMK2j/H
         NlNjhPEJ6MRLs7e9ehYzO4o06ErMlg2vQrEn6q3zZcB5BU2J9oB6zKinOmvdvoEovCBA
         oXxuoIKVH4BTXHp17ncBzqzUWHF17twiyb50Uh8eE2+OG6ukHGlXZmjyyGJfBI25jhRv
         G4G9GlIco+Sw/+c+822xbQENRwToPh9gtzIbj87X1zL9/j4NGi+z+L1EkNwcxzHJLAJm
         7Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygg9/4iRHT21kcmBGkSM1pLATrrcqMs4HjO1+e+77XE=;
        b=R5MX+GzQXAJskmUgNJSZUwQQo7Hn4c+15EVSS3ziSdUN4ViWuH4w737K7j2kVGDElm
         MZZ4eIcLCjCCW4A4fIljqvp7DSaqXTHWHRGiSdGv/tty0ADYigHhJUKI3DLdRe5OLedF
         ROEqzBDDBSMg3DKb+dY3zDsKfnb7OlM/9RLd1jT0F6VNNeMkR8Ud1dW//iijLHyBjwgu
         /QBLk5vg5UfWO8czpq9nrRF/UkT8BL0ClLXzMw7nX+ks0ir/WaKSNAMEU1LucA5MkmOQ
         e3WSS7jMC9ixvlIIem4PqFR6gSvqyB3CrQEc6smGHrDOSa7S7X4iBzSArxKSfCU3vUCy
         jy9w==
X-Gm-Message-State: AOAM5329lXjqN8Irg1a51a+e7t8vstCd8L6+58Ze53UMneDZnTxkfp5x
        dAuE2D6Q5cBQgVvQHkIeKU/WTaSmfWiEe61d+ho=
X-Google-Smtp-Source: ABdhPJy8/ZnHAdreYcqpUMlQNKl4LBK67PDtCwMgVYRt58mkOpDye85bngrZE/uxB3pwomb4wHRHZdEmm98TyABMjfk=
X-Received: by 2002:a05:6402:7d2:: with SMTP id u18mr942326edy.69.1601346499551;
 Mon, 28 Sep 2020 19:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com> <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <MWHPR11MB1696BA6B8473248A8638FD3797350@MWHPR11MB1696.namprd11.prod.outlook.com>
 <14b7d988-212b-93dc-6fa6-6b155d5c8ac3@kernel.org> <16431a60-027e-eca9-36f4-74d348e88090@kernel.org>
 <38cc8252-e485-ef11-93a1-7b43ad85fc2e@intel.com>
In-Reply-To: <38cc8252-e485-ef11-93a1-7b43ad85fc2e@intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 10:28:08 +0800
Message-ID: <CAKF3qh3nBS=bbusT_na54qo-yBdM1vc38Lx7JGm0Ck2sZ6qoCA@mail.gmail.com>
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Zhao, Haifeng" <haifeng.zhao@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 12:45 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@intel.com> wrote:
>
>
> On 9/28/20 9:43 AM, Sinan Kaya wrote:
> > On 9/28/2020 7:10 AM, Sinan Kaya wrote:
> >> On 9/27/2020 10:01 PM, Zhao, Haifeng wrote:
> >>> Sinan,
> >>>     I explained the reason why locks don't protect this case in the patch description part.
> >>> Write side and read side hold different semaphore and mutex.
> >>>
> >> I have been thinking about it some time but is there any reason why we
> >> have to handle all port AER/DPC/HP events in different threads?
> >>
> >> Can we go to single threaded event loop for all port drivers events?
> >>
> >> This will require some refactoring but it wlll eliminate the lock
> >> nightmares we are having.
> >>
> >> This means no sleeping. All sleeps need to happen outside of the loop.
> >>
> >> I wanted to see what you all are thinking about this.
> >>
> >> It might become a performance problem if the system is
> >> continuously observing a hotplug/aer/dpc events.
> >>
> >> I always think that these should be rare events.
> > If restructuring would be too costly, the preferred solution should be
> > to fix the locks in hotplug driver rather than throwing there a random
> > wait call.
> Since the current race condition is detected between DPC and
> hotplug, I recommend synchronizing them.

The locks are the first place to root cause and try to fix. but not so easy to
refactor the remove-scan-semaphore and the bus-walk-mutex. too expensive
work. --- rework every piece of code that uses them.

Thanks,
Ethan

>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>
