Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1484267DBE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 06:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgIME1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 00:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgIME1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2020 00:27:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F08C061573;
        Sat, 12 Sep 2020 21:27:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x19so13995038oix.3;
        Sat, 12 Sep 2020 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOQk3xXdtW33zXCs+KFbhvBQfCJkZslsCotpgafvdOU=;
        b=FuVL2uRbGAJjafaeSJMnHdvLXqH/n0Kc4u1aarjXA5W1Rm6v1rvWYEbq+F5QUch2tS
         uJPTjiOXoeDNz4aUVXgsl1uqinE2Du4gUcOsnd6kQbWbphtCfr/cLPUvIxQ82aY9T5rS
         pTFCBZBSa7BxLl4HXKt2X/Hz3Cl8RIgz5yZD6ntuL3dTx/LgkKLQcjR+qanuR1u9vLaR
         AJxZ5XHwYdRp8i215/+lwBeXGNl/ijvWOZ8HoOGj0VguzIDBnso42WE7mzqphuVwyxVG
         R4uVMud0EQNzUL9dsUYe9UVr0o24uumxsU46QdG0CcSNvrYgHqRkYNtakKn6mechSA7f
         wQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOQk3xXdtW33zXCs+KFbhvBQfCJkZslsCotpgafvdOU=;
        b=RSpd7xK7o5RH8JSkvC6Yv8ggtET2Tr4Y/omwYXXTesmTWxpMXm4ur0fUhlpY4pe0/4
         vZwq5KoD/jOgNZEkgTmm56gxQHQYw+fZct/ku92spFgNZPUGdFL3z5KfaMQvwr0AMtrD
         FTTrYveNFMYHa2ZJ+hmSK8fNdDFiolUKdkX0BBg2+9phuPvJPrjnf8B+RQxPkGHu/exR
         Xjq5bPGDj2ta5Dkpzcbl/2FiVHgVj1BQmGFHYr/x1n5lt8cYQ1lk/63B8IaQ7yJjx3fc
         KwFTgSUAhcphR1o6+iQnmPJ8wtG6sJ7ONC+xE31GEFMKE+9IC9yvJ2xaUyoltA2LH1dL
         bvXw==
X-Gm-Message-State: AOAM532Lg7bafsWKTe0s8mphOvKjEHedSWAyQzAbeCtSOP3Hxvwjm6ga
        iXyoga+qXzH0AtI17Fw6AFpV7PMv9xlulZCbfIQ=
X-Google-Smtp-Source: ABdhPJxWhktkLLA3tbhKQU7RIOG156DdWop2W6za+3JfRX5Mg1TlmFG3CzQnL5GtEBPT3I8EcK5U8pAGNHK2NytcH8A=
X-Received: by 2002:aca:aa84:: with SMTP id t126mr5500928oie.5.1599971239961;
 Sat, 12 Sep 2020 21:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJCdB=HzNJp36tjD0=-R-cs4+8=xhxAfmR-tZ2DkpcyiugH-g@mail.gmail.com>
 <20200910015950.GA748330@bjorn-Precision-5520>
In-Reply-To: <20200910015950.GA748330@bjorn-Precision-5520>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Sun, 13 Sep 2020 12:27:09 +0800
Message-ID: <CAPJCdBngxwYdc-CEfSabTAdAXCdnG424Qa2BS47+xcV2wDvJCA@mail.gmail.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in pci_read_config
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On Thu, 10 Sep 2020 at 09:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 09:54:02AM +0800, Jiang Biao wrote:
> > Hi,
> >
> > On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > > > From: Jiang Biao <benbjiang@tencent.com>
> > > >
> > > > pci_read_config() could block several ms in kernel space, mainly
> > > > caused by the while loop to call pci_user_read_config_dword().
> > > > Singel pci_user_read_config_dword() loop could consume 130us+,
> > > >               |    pci_user_read_config_dword() {
> > > >               |      _raw_spin_lock_irq() {
> > > > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > > > ! 137.582 us  |      }
> > > >               |      pci_read() {
> > > >               |        raw_pci_read() {
> > > >               |          pci_conf1_read() {
> > > >   0.230 us    |            _raw_spin_lock_irqsave();
> > > >   0.035 us    |            _raw_spin_unlock_irqrestore();
> > > >   8.476 us    |          }
> > > >   8.790 us    |        }
> > > >   9.091 us    |      }
> > > > ! 147.263 us  |    }
> > > > and dozens of the loop could consume ms+.
> > > >
> > > > If we execute some lspci commands concurrently, ms+ scheduling
> > > > latency could be detected.
> > > >
> > > > Add scheduling chance in the loop to improve the latency.
> > >
> > > Thanks for the patch, this makes a lot of sense.
> > >
> > > Shouldn't we do the same in pci_write_config()?
> > Yes, IMHO, that could be helpful too.
>
> If it's feasible, it would be nice to actually verify that it makes a
> difference.  I know config writes should be faster than reads, but
> they're certainly not as fast as a CPU can pump out data, so there
> must be *some* mechanism that slows the CPU down.
>
> Bjorn
We failed to build a test case to produce the latency by setpci command,
AFAIU, setpci could be much less frequently realistically used than lspci.
So, the latency from pci_write_config() path could not be verified for now,
could we apply this patch alone to erase the verified latency introduced
by pci_read_config() path? :)

Thanks a lot.
Regards,
Jiang
