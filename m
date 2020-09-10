Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B188263ADE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIJCra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 22:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgIJB7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 21:59:55 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B32F206DB;
        Thu, 10 Sep 2020 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599703191;
        bh=eQSHJfWZ3DxC0HJ+ibhPFp1Bf0FdR9SvFxiYcGxWF6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AiZwJ0if6N9KXZ/+Y+yitBZHqIPrOj2JaQFG2eR1JW5GdcWOilKF7bRxXxdA6zYqu
         IIjUQmmxmmyOswztPrNUh2211cq4RAa9C7t3OgRrGeWTXaCjNhSsMN+dvqK0eoK/24
         y2s2RIpdENaFgkeNuM2/3HNLfxDLV70I53U6QsVs=
Date:   Wed, 9 Sep 2020 20:59:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in
 pci_read_config
Message-ID: <20200910015950.GA748330@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPJCdB=HzNJp36tjD0=-R-cs4+8=xhxAfmR-tZ2DkpcyiugH-g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 09:54:02AM +0800, Jiang Biao wrote:
> Hi,
> 
> On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > > From: Jiang Biao <benbjiang@tencent.com>
> > >
> > > pci_read_config() could block several ms in kernel space, mainly
> > > caused by the while loop to call pci_user_read_config_dword().
> > > Singel pci_user_read_config_dword() loop could consume 130us+,
> > >               |    pci_user_read_config_dword() {
> > >               |      _raw_spin_lock_irq() {
> > > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > > ! 137.582 us  |      }
> > >               |      pci_read() {
> > >               |        raw_pci_read() {
> > >               |          pci_conf1_read() {
> > >   0.230 us    |            _raw_spin_lock_irqsave();
> > >   0.035 us    |            _raw_spin_unlock_irqrestore();
> > >   8.476 us    |          }
> > >   8.790 us    |        }
> > >   9.091 us    |      }
> > > ! 147.263 us  |    }
> > > and dozens of the loop could consume ms+.
> > >
> > > If we execute some lspci commands concurrently, ms+ scheduling
> > > latency could be detected.
> > >
> > > Add scheduling chance in the loop to improve the latency.
> >
> > Thanks for the patch, this makes a lot of sense.
> >
> > Shouldn't we do the same in pci_write_config()?
> Yes, IMHO, that could be helpful too.

If it's feasible, it would be nice to actually verify that it makes a
difference.  I know config writes should be faster than reads, but
they're certainly not as fast as a CPU can pump out data, so there
must be *some* mechanism that slows the CPU down.

Bjorn
