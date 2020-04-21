Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F161B2DD1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDURIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 13:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDURIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 13:08:10 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2B7206E9
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488889;
        bh=lQ/gTMz1UfvYmiHUc9XPCspLvM9OlaM+FUj0x/Ctm+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nEIb7DgfvkxxDYUxsIV1scmgs5Q2g9QUb99cei3PDYQQt1kk6edHZlYH/HfDyV5y1
         zam5All/Re5k4OjSzG923LvbEi3x00T7cqIQhh/JxY3EyDW/k/wwDG3igBsLGR8sfO
         r5qu2v8g3XGnAeKDvPNSIjIqbDoARnYyTqKnhNAg=
Received: by mail-io1-f50.google.com with SMTP id e9so8199426iok.9
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 10:08:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubZRwlmC8qSaG/eKFgI4W5A2MjqoDHlyzspLYqudxbEka9uIEPJ
        GtMqskdC6MJJqxx7fspfp9BnWK6KkQocouC032g=
X-Google-Smtp-Source: APiQypKGkNmqWgc1+ABO2RiKqdkY29Yns+vbbAlzRO5cAQVhQJ8tiuWQkgKENkjXpzND/jYkV31uYYOJ2qgHUtyG3z8=
X-Received: by 2002:a02:3341:: with SMTP id k1mr22037425jak.74.1587488889039;
 Tue, 21 Apr 2020 10:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
In-Reply-To: <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Apr 2020 19:07:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
Message-ID: <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, jon@solid-run.com,
        wasim.khan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> > When resizing a BAR, pci_reassign_bridge_resources() is invoked to
> > bring the bridge windows of parent bridges in line with the new BAR
> > assignment.
> >
> > This assumes that the device whose BAR is being resized lives on a
> > subordinate bus, but this is not necessarily the case. A device may
> > live on the root bus, in which case dev->bus->self is NULL, and
> > passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> > will cause it to crash.
> >
> > So let's make the call to pci_reassign_bridge_resources() conditional
> > on whether dev->bus->self is non-NULL in the first place.
> >
> > Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing B=
ARs")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Sounds like it makes sense, patch is
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.

Thanks Christian.

>
> May I ask where you found that condition?
>

In this particular case, it was on an ARM board with funky PCIe IP
that does not expose a root port in its bus hierarchy.

But in the general case, PCIe endpoints can be integrated into the
root complex, in which case they appear on the root bus, and there is
no reason such endpoints shouldn't be allowed to have resizable BARs.
