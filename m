Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B014D3F7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 00:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2Xtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 18:49:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37268 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 18:49:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so1325027ljg.4
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZuYO1iwTS6qTMEuTEAkXWId/UBWv4N98s5kLzpeWFk=;
        b=Mmdzqguz0RYjmqywHXsnnBq1PdYo4sEDQvqeVgCcrxrK3x4W6UMUDCboC/Le9yM/eX
         4+GaCZCfx4fDwOpfU7dHJTWHzF+yfSKLllDfGhshvjXnlZPG3siNr2aa6jyb/1ZYnJtX
         EpWbRtyk0rfwFsoj1VzGp/DiH69QHf88kVbL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZuYO1iwTS6qTMEuTEAkXWId/UBWv4N98s5kLzpeWFk=;
        b=cIOukMIocEaN8aQFRm/4s8DcNbPmTV4CXsH7+/9CcxnMO6/j5t+XYpmjkAANwHwzU0
         oueFlYh02D6GkYMp3MmOpdPMHBus98sH3hgHjrLXDPLEPPRha0fvKVE2olSuPqrdbn7R
         wTUYrpj6QDNSMlbtowUERF3ydcqfkppQiDfpQbkh06zyAWm1nHaiN9v/9lSNtrdAaWbR
         rleKKzzm+5JK4nwkMizK9/uP1wlKcxihXYDGagV5hui//X8qYJDo/Qy8bJK7GgvR5lT7
         fqus58Cxy9Z4pM/l9SX4Wlfv/pS06RbFggL4qdcx7r4MqmocDwKJiHC8vs2p8KH/ZLX4
         8XKw==
X-Gm-Message-State: APjAAAWWq/U+IF65safmfAntC7UzpRfe+GCutAe01yYNfgJVGuc/tyQz
        X0vi0iWjWoeXpftUQFjQMNnIWg8jIOs=
X-Google-Smtp-Source: APXvYqxwwg9qYlXh6ivk8llcUmxnXtjYiWDZmohu2lO+8u+UGc8lBYs09iuP1qkYy0PgOI76s2Npgg==
X-Received: by 2002:a2e:8e95:: with SMTP id z21mr953959ljk.119.1580341766416;
        Wed, 29 Jan 2020 15:49:26 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z8sm1765804ljk.13.2020.01.29.15.49.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 15:49:25 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id q8so1283744ljj.11
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 15:49:25 -0800 (PST)
X-Received: by 2002:a2e:85ce:: with SMTP id h14mr988980ljj.41.1580341764990;
 Wed, 29 Jan 2020 15:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de> <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
 <874kwd3lbn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kwd3lbn.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 15:48:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
Message-ID: <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 3:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Wed, Jan 29, 2020 at 1:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> Could you please add some instrumentation to see how often this stuff
> >> actually triggers spurious interrupts?
> >
> > In about 10 minutes of this script running, I got 142 hits. My script
> > can toggle the HT cpus on and off about twice per second.
> > Here's my diff (sorry it's mangled by gmail). If you're looking for
> > something else, let me know, or I can run a patch.
> >
> No, that's good data. Your testing is hiting the critical path and as
> you did not complain about negative side effects it seems to hold up to
> the expectations. I'm going to convert this to real patch with a
> proper changelog tomorrow.
>
> Thanks for your help!

Sounds good, please CC me on it and I'll be sure to test the final
result as well.
-Evan
