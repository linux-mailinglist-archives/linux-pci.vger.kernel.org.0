Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF30444A83
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 22:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCV4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhKCV4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 17:56:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE21C06127A
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 14:53:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d5so5691382wrc.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7FSrtNrX5nOFnwygS5xpyL/5wYBkJfbm++yYupLlqo=;
        b=BOnSOl6YXnuSil9Gt1blmrWYKaP4cFrvlgfMaylmUIXlRY1YXa4xesmT9UQguUTb/6
         qKzdmnPAMJktxgWyrIpHWagD6SAb8VIRF6UKohjYn+HjjDgNPy30KAOMIkTMeOaMLsSA
         G1T2j7JWpytiQMstMlQ/Og41MeZRXcoV5nXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7FSrtNrX5nOFnwygS5xpyL/5wYBkJfbm++yYupLlqo=;
        b=F+6GFtgZ8Cn7MUYaj6FsKzcmOyLFhiBPvL93310Jq8J0MbKWrnygXFtnkq4cb3vFZ/
         DM8vHeBk0+/WQk2FDCcipThOKndUSU4+mLo5qWhtFhk6yKSeUNV+AaDIk7D5d90KNmK5
         SPuskI01OqrkWQiRxI0f+SK9AfX+G4+4HQwVyvANpD4LnBgWUdo7OtPoS+lbWxoiNXX5
         MCQX/kFX2J0J5pCbpDmIJrMrcqPaRQS4+grF6bl7EI89QBqp/A2n+l4FeZbM//tlJoLY
         M8SHnK/9WvR2cXIYSGLqsAt9ExheaCq5ODhoCFpNUlfr6+RUvTBoxU+1HChqx85l9131
         cNCA==
X-Gm-Message-State: AOAM5336t3Gbl3cSGrWktupAPOUzEXgYLNl3Wr2DTQoDwxUIb0ZGbIgw
        ZUi4fuVn1oeT/v9EiReeZAkrv7jyZSxYWB0oMDZCns4veJM=
X-Google-Smtp-Source: ABdhPJy0sTuL7PHeTb2+ERKpgRvzQcvSzbrxX79HbSBGj+++Szj2w7dWetm+oKLaSe4IhQdSf37ppgqKLgegphecNFQ=
X-Received: by 2002:adf:ba87:: with SMTP id p7mr59062923wrg.282.1635976423448;
 Wed, 03 Nov 2021 14:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-6-jim2101024@gmail.com>
 <YYLm3z0MAgBK24z5@sirena.org.uk> <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
 <CA+-6iNziZv0UycoaoFhscmp39Z2Y2bHrWUpFW4f9MBK-uM24qA@mail.gmail.com> <YYMEkjlbFdeIjror@sirena.org.uk>
In-Reply-To: <YYMEkjlbFdeIjror@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 Nov 2021 17:53:32 -0400
Message-ID: <CA+-6iNwshLwTaHuh+BezmqjGi7wRnFUqa2HvKestecOy06qj8g@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 3, 2021 at 5:52 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 03, 2021 at 04:34:34PM -0400, Jim Quinlan wrote:
> > On Wed, Nov 3, 2021 at 4:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> > > I did it to squelch the "supply xxxxx not found, using dummy
> > > regulator" output.  I'll change it.
>
> > Now I remember: if I know there are no vpciexxx-supplly props in the
> > DT, I can skip executing all of the buik regulator calls entirely, as
> > well as walking the PCI bus as in brcm_regulators_off().
>
> > Do you consider this a valid reason?
>
> No, the whole point in the core code providing dummy supplies is that it
> removes the complexity introduced by client drivers trying to guess if
> there's supplies available or not.  If they do that then we end up with
> a bunch of code duplication and issues if there's any changes or
> extensions to the generic bindings.
Ok, will change it.
Thanks, Jim
