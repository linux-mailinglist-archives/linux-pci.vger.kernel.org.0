Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF94203B88
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgFVPvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgFVPvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 11:51:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EDAC061573;
        Mon, 22 Jun 2020 08:51:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so17690pjb.5;
        Mon, 22 Jun 2020 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpPb3+yNpxwCEjuPN9vujTShlReBQ2Dt+rrRa2Bp2DQ=;
        b=hEAGfP/nFGOSzQuYQ+mVlTeEXfn4amAcGfX1VdaDPPQmPhJurXb8NVq8CRcydEKsIf
         Duk388/QhD+XpCFwmhLON1Hz/96s2qi0NKnqqSzCxve7+E/C5RGASHaH+4ZJ1xzZdWMu
         eaEQCRRKZXDh7ZRuIprzQVVkuHq9vwQrSpGbb0qrXjxEGUTHgAQupJhoNFpYmBnLAvF/
         T8Rhl7XYv9bb/HokATYjbec6pMYvKYJ2MMgZa/NDvLOJ5VuKOjZHIIc2pG4Nwzxtd2yF
         damyeMz2Q2TnjsT+xeW5nPUI5yfnrrIs14QbM9WYp5ODCbVpU8/G9NGA+ZVv8XhHHkPB
         zQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpPb3+yNpxwCEjuPN9vujTShlReBQ2Dt+rrRa2Bp2DQ=;
        b=DjL83L0t7FZHKcqrnbegEyHkKt+cpGv4A1/8bHghC3ValMzMwX6QFA/i/3CDg7TmAv
         Zb2Mi5zwfuMQKwhzp/9cGd4MJ+5cFyFAApeI/krFyqkUrCe22McPH6t/O5y5gVWakBI6
         ny0dmVYnWa0ZVnhRFs6uiV5mdZMOFLecu25rjfsSqHQgHyXpDKoZZv80SrhO8Yl2VEWg
         bgB8S8X3b9bwRGAgF15wwt6p5B9QMU7Htday2GgVgTd1vWNypdBZL5yvGnc42HL8NaMT
         jhFDXN1GoH7u8oqAqodPWhxQbljCi10QcKuoOQnl92rDlLx3SCxcXt+KnQGRJPYb8Cfn
         NUpw==
X-Gm-Message-State: AOAM533MkocMW36wQi1HWR29XB2cGtbBF2DHxGdM1QzfWMA8DK+7yTv0
        kOXCSwg3rZ/7G5qMXLdJFN9UVi6QmAMeY5FzQHE=
X-Google-Smtp-Source: ABdhPJzv28LTfnWpJp82+S+pzs7++aNj/pUb9dRwcbTfTgiLWqmcLOfQ70fYghDtqny5H6ocNpkQ1poPDlTbaOtfe+I=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr19471241pjq.228.1592841076136;
 Mon, 22 Jun 2020 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200622103817.476-1-nsaenzjulienne@suse.de> <20200622103817.476-7-nsaenzjulienne@suse.de>
 <CAHp75Vcpo49BUe+cApfbB2BXFLz0SyLjWkO_6Uw=sYEcJEBMPg@mail.gmail.com> <0c0546cfe855eee1381c629b2ffd7f65427c7091.camel@suse.de>
In-Reply-To: <0c0546cfe855eee1381c629b2ffd7f65427c7091.camel@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 18:51:03 +0300
Message-ID: <CAHp75Vcs=QZye_QPwpQ-9uwjOJnbvbyrHpRNjeTEG8X65fseeg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 6:11 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
> On Mon, 2020-06-22 at 17:44 +0300, Andy Shevchenko wrote:
> > On Mon, Jun 22, 2020 at 5:26 PM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.
> > >
> > > The initialization of Raspberry Pi 4's USB chip is now handled through a
> > > reset controller. No need to directly call the firmware routine trough a
> >
> > trough -> through.
> >
> > > pci quirk.
> >
> > pci -> PCI.
> >
>
> Noted
>
> > ...
> >
> > > -
> > > -#include <soc/bcm2835/raspberrypi-firmware.h>
> > > -
> >
> > Leave one blank line here.
>
> This being a revert, does it make sense to do so? If we are 100% strict about
> it, the space should come from a separate patch.
>
> That said, if you insist I'll be happy to edit it.

Even though, this revert depends on the previous patches, so,
considered as a new patch.
I leave this to the maintainer to choose the best approach (update
themselves, request new version, ...).

-- 
With Best Regards,
Andy Shevchenko
