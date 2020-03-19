Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76718BDB6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCSRMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 13:12:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35176 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgCSRMv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 13:12:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so3406972ljo.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGnzjLPuiF5jh+YmVcnbPs/rygoBzTtr0yQpmvu1C/U=;
        b=ho5WkQIp7FBmmWnNEs8qarjlXHQ/bMpYIjVlz5diN+cFqHjIA9Cfpaie2yvrq56MzY
         6TnA04IH3cBRxYREMcsiPUpLCig/QPzuawQ7+ZDABjg2D7iZ5uNSWio6VnyJC48k22lp
         9sUOw53EsymdqqmachpMBK4cZKv94z+KiqobI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGnzjLPuiF5jh+YmVcnbPs/rygoBzTtr0yQpmvu1C/U=;
        b=AUW24Cis8UgyCV8F4M2UN0aPEj1favZoAsKYOfG9HCyuINWf/6OqLbkLw5mfG5SWQj
         CMelefTRSS27ap1D+hawSXhfmcd3cSp96g8UF9l7jCO+IiGiAKXI5E+/SddWGEWI0gM3
         Amc54c4c/Jfo6+jrN9f4uLmqCWN7O3rl6z7TOfhVR1fEjcKjxS4UKbndE+1hqYfSexRO
         KKXCg8YQvvcMMDm3Ij9B9DY4UYNFd7kAMZoG4H9m1GgVAhGVyvfwQhvBOAWcrjTl+2E+
         ACyw59PoyFCNprblir1Vx7nl8Q66wJfOCLo+2++eQ0aFLfSw7H9UgVUvdfj0x4k/MdpK
         Vmtw==
X-Gm-Message-State: ANhLgQ3/POCBXpS1tf5QxKC2GuKTPkcBgHPK3m/fbiP0MIDqA98CUT76
        MInvOyVdFBUzT6Bpta3wo78XyRoRI+o=
X-Google-Smtp-Source: ADFU+vtrq+VIFgoP4aMHObrslkdKZXZP/tr30rWoOUB0WCFnPD2Gm5OY1t8Y/UaJ6g5FcFeshYTOgQ==
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr2634390ljo.165.1584637967879;
        Thu, 19 Mar 2020 10:12:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x3sm1826177ljc.105.2020.03.19.10.12.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:12:46 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z22so2271088lfd.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 10:12:46 -0700 (PDT)
X-Received: by 2002:a19:c7:: with SMTP id 190mr2779646lfa.30.1584637965843;
 Thu, 19 Mar 2020 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200318204302.693307984@linutronix.de> <20200318204408.521507446@linutronix.de>
In-Reply-To: <20200318204408.521507446@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 10:12:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3bwUD9=y4Wd6=Dh1Xwib+N3nYuKA=hd3-y+0OUeLcOQ@mail.gmail.com>
Message-ID: <CAHk-=wj3bwUD9=y4Wd6=Dh1Xwib+N3nYuKA=hd3-y+0OUeLcOQ@mail.gmail.com>
Subject: Re: [patch V2 11/15] completion: Use simple wait queues
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 1:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is no semantical or functional change:

Ack, with just the explanation, I'm no longer objecting to this.

Plus you fixed and cleaned up the odd usb gadget code separately
(well, most of it).

              Linus
