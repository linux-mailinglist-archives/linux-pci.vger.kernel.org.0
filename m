Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA311008D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCOqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 09:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCOqc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 09:46:32 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875DF2064B
        for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2019 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575384391;
        bh=1tc5gXPWwVgPzYdPrdTiVNPjY98/vv22P0ubwxUh7lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OsIX9EAYhlumlE8w0MrA4ASb7IExxOlzCQo8s6pOZuHt9lbyHT6hbit4nalof+WZz
         zU4PENi677i0iW4TuC0qrxKVBTq5R28D4bft9MEZaXU3BhP9ShKJKG7HhB8EsWUZVU
         SOwXIRj5m6aQmgrZjsNmRKgwlSgwpTc+xti6aZ/A=
Received: by mail-qv1-f52.google.com with SMTP id b18so1602626qvy.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 06:46:31 -0800 (PST)
X-Gm-Message-State: APjAAAUQXlGnmF2vU2QATC8beInItY9sdLOSHEU7rKoZH6OMIOnAyJDY
        c12phiqhdVXLqkHVroMjOKpxYwk7EUHKfA2TL/A=
X-Google-Smtp-Source: APXvYqwIMlXI6ZCNSCwzRodkJ+nn2SARfHVqfH3NXZPHUTY0u7FOTIJX9WAq/1/NTt6NZjL412Y4Af1pTnQnLOSJW8Q=
X-Received: by 2002:a0c:e503:: with SMTP id l3mr5433952qvm.92.1575384387693;
 Tue, 03 Dec 2019 06:46:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHd7Wqw56pPXFgvk+vNnrMCeVow6Op2mXONiqHs4C9NrMfS=VQ@mail.gmail.com>
 <20191203144226.GA255690@google.com>
In-Reply-To: <20191203144226.GA255690@google.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Tue, 3 Dec 2019 14:46:16 +0000
X-Gmail-Original-Message-ID: <CAHd7Wqy=RRK-Gbw4D5Bqru1ab_CVhzxTwbaqPVkLqp8g9gea0w@mail.gmail.com>
Message-ID: <CAHd7Wqy=RRK-Gbw4D5Bqru1ab_CVhzxTwbaqPVkLqp8g9gea0w@mail.gmail.com>
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 3 Dec 2019 at 14:42, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 03, 2019 at 02:06:57PM +0000, Wei Liu wrote:
> > On Wed, 27 Nov 2019 at 10:59, Wei Liu <wei.liu@kernel.org> wrote:
> > >
> > > On Tue, 26 Nov 2019 at 23:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> > > > > CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> > > > > in.  Removing the ifdef will allow us to build the driver as a module.
> > > > >
> > > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > >
> > > > Sorry, I missed this thinking it would be under drivers/pci/controller
> > > > and hence handled by Lorenzo.
> > > >
> > > > So I guess this doesn't fix a build problem, but without this patch,
> > > > we just don't run the quirk if the driver is a module, right?
> > >
> > > Yes, this is correct.
> > >
> > > Without this patch, the quirk doesn't get to run if the driver is a module.
> >
> > Are you satisfied with the patch? What do I need to do to get it merged?
>
> You needn't do anything.  I'll clarify the changelog (the patch
> doesn't actually *enable* building the driver as a module; it merely
> ensures that we include the quirk in that case).
>
> This is too late for v5.5, so it will get merged for v5.6 unless the
> modular driver itself was enabled for v5.5.
>

OK. Thanks for the clarification.

Wei.

> Bjorn
