Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06076AEB5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfGPSfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 14:35:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38097 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbfGPSfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 14:35:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so10546646plb.5
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAKhev+MhcsyOVuReyPGPlfwr6RAqsm8KLJC/p+tBWo=;
        b=BtxFNZrJ1lxuLHdz4p0cb5NpRBas4oMeXYrSpaXChm3f5inh99nI5E+MdCjO+0SvFN
         Ry8bf1i9hikIL8m72cMNN8wnWLsm9KfRlPPMZ5RjfBcQEkIc6IujCMbAsuy+mISYcuee
         Qr4kYdcFcd5XUHZrH7KXQ8HM3/IMx446SBoQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAKhev+MhcsyOVuReyPGPlfwr6RAqsm8KLJC/p+tBWo=;
        b=BJYVQw2CoH5/CVLiZyEvhzVoCCvZ4GTDJ6bJsIfmRrWVnHmwZZQuRMbh7fEXLhH3h5
         mK1uf3+b0P+7VThw+vanBXjHrIFoefrW17eKLheShooqM+iNNTG/FCs4AtBJ4tCYcbBi
         BnLFxzdhMEKK8lfM1cSUhbwfKb/tKr7UdPgwNGV1lPsYAH56weU3IbFVTgNdltPYHAY8
         1wWqoU3NJodL7ed+A98bpNz/dgdFcF4TJ3JZZWIk2eSo6p1sE7milvZhYZcRihA6dCEN
         7YiJNuwrriuBtF3E5M62f85kLOgf2SmmCSBr+T4UPiweHlLeu/3Xb43heFcO5E45dtK0
         6NqQ==
X-Gm-Message-State: APjAAAWznWFMbf+OCcz12S36/QJVbSMpz0rEPjcDr6GggQT2gkHKfEkt
        rWmkt/M9wdqXGesakTdGTnI=
X-Google-Smtp-Source: APXvYqyfCs9+aKdxQJQ7pxXZdVPAjoPO3h0r2nncpS7RMorjmeD2xnNucSDVGhLwrY66fVK+0eWNvA==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr38238048pls.9.1563302119843;
        Tue, 16 Jul 2019 11:35:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm16618398pgw.3.2019.07.16.11.35.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:35:19 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:35:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        peterz@infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v2 2/9] rcu: Add support for consolidated-RCU reader
 checking
Message-ID: <20190716183517.GA129705@google.com>
References: <20190712170024.111093-1-joel@joelfernandes.org>
 <20190712170024.111093-3-joel@joelfernandes.org>
 <20190716182237.GA22819@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716182237.GA22819@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 16, 2019 at 11:22:37AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 12, 2019 at 01:00:17PM -0400, Joel Fernandes (Google) wrote:
> > This patch adds support for checking RCU reader sections in list
> > traversal macros. Optionally, if the list macro is called under SRCU or
> > other lock/mutex protection, then appropriate lockdep expressions can be
> > passed to make the checks pass.
> > 
> > Existing list_for_each_entry_rcu() invocations don't need to pass the
> > optional fourth argument (cond) unless they are under some non-RCU
> > protection and needs to make lockdep check pass.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> If you fold in the checks for extra parameters, I will take this
> one and also 1/9.

I folded the checks in and also threw in the rcu-sync with Oleg's ack:

Could you pull into /dev branch?

git pull https://github.com/joelagnel/linux-kernel.git list-first-three
(Based on your dev branch)

