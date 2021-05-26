Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D9391CBA
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhEZQNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhEZQNh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:13:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A47EA613EC;
        Wed, 26 May 2021 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622045525;
        bh=plkzmqFfNAQzIDwAmha6TrfSbLQm+saf1V+MFBd4Y4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kh6hEPyJbcPHLy+T6gIzgL6WDxQHtT4q0hlJfdrJRBNJ7GX9CpPQov5XxZXoNjZVb
         RghzrXklpnY1izJOLdaSbNMn5uM8Wk80rxswOoSdV/cxXX5AmkhrLrRuBcG5mykrzt
         XqIWuL0gnycpFMa8BhmkruiADUxXLRmqo4Nj2HBtSb9gLZgZtYwsPSFCj1jtC5fmSs
         1iVfjrVWTryXyJ91gd9bqHsSB6ZeuIxSBHcJO0UN5sabynl0YvopR7QMFjgp5wpHkS
         GXoZdShHj/hOJfxZKdlOrGg6HvUqfWj4CXOj0cF49M70RDo/rwtyw40CpuUedQi3gE
         4XuhfPx7qYSig==
Received: by mail-ej1-f53.google.com with SMTP id z16so2699302ejr.4;
        Wed, 26 May 2021 09:12:05 -0700 (PDT)
X-Gm-Message-State: AOAM533M3Ieg4PxVuni481n3tTedHM4kSZLL5CcCtdUupyuGWei4CLHe
        874TCtbNvf2Z24us3ikBfvMqLBpVfrMjD6uXMQ==
X-Google-Smtp-Source: ABdhPJzsgwTde9AZHJs0192mQAo9uL9cmKMD6PA8pgpxX/B3veY0O4k7ZEw9pBw7r3WOrLTwX1ttlgOxOL5RsICjZ0k=
X-Received: by 2002:a17:907:76e8:: with SMTP id kg8mr32336386ejc.130.1622045524118;
 Wed, 26 May 2021 09:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210427175140.17800-5-jim2101024@gmail.com> <20210525211804.GA1228022@bjorn-Precision-5520>
In-Reply-To: <20210525211804.GA1228022@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 May 2021 11:11:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++cfNM8sEygMn45Ue8BPPX+8P=ag=bURKvuUuLPvvtUQ@mail.gmail.com>
Message-ID: <CAL_Jsq++cfNM8sEygMn45Ue8BPPX+8P=ag=bURKvuUuLPvvtUQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 4:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Capitalize "Add" in the subject.
>
> On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
> > The shutdown() call is similar to the remove() call except the former does
> > not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
> > if it does.
>
> This doesn't explain why shutdown() is necessary.  "errors occur"
> might be a hint, except that AFAICT, many similar drivers do invoke
> pci_stop_root_bus() and pci_remove_root_bus() (several of them while
> holding pci_lock_rescan_remove()), without implementing .shutdown().
>
> It is ... unfortunate that there's such a variety of implementations
> here.  I don't believe these driver differences are all necessary
> consequences of hardware differences.

What's correct here?

This was on my radar and something we should get in front of. It's
only a matter of time until everyone is converting their drivers to
modules since that is now the Android WayTM. My plan here was to
register a devm hook to call pci_stop_root_bus() and
pci_remove_root_bus(). That way every driver doesn't have to implement
a remove() hook. Though maybe they all need to quiesce themselves
anyways.

Rob
