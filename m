Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C03559D3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhDFQ7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDFQ7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 12:59:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C2C06174A;
        Tue,  6 Apr 2021 09:59:28 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so15318482oto.2;
        Tue, 06 Apr 2021 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0vcjmfkxT+FMarvJR1c5UkvtHgWk27fUbHRkWTwpuM=;
        b=bjJ+VuGbGdU5iyhiJDxbr+3vL4o+9DMITQG2zj1EM0kfv32Y0hkTrqs4fU1RaOtulB
         ttQ+4VD1SKKqhuKvcAxUzcH7aTbVPAUNSUztgCXhOcCNPuXdgU5tndnEv3+o1N/wF0hw
         fIauUESFLFhfOcZTArCr1pHrlpYcgmspekQtGvyPlFSogto54TQJ4BvpWM9iohB3oKTB
         w5u6hhWK2bP5+rKRPeHTCjq4yK9FtStpblsBsmfQ4rIzwOnG153D4Dkm49dhc8n/jp8K
         Pv4Mzj4HwequtKzhQPV+iEdx49+xnZ9Wpk57AnF6yWlKO0REeSAKGAvkl89d2QhsCn19
         4l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0vcjmfkxT+FMarvJR1c5UkvtHgWk27fUbHRkWTwpuM=;
        b=BYAIW9oLII/labOPE8HWbLCZMJ16h8+uicdZE3jXnQK8QajWQPNag5/dqmang+pxkh
         0PZ2/mq5epRRm6oWTS9naOkelffkBSw5H4zxCeVhpNtXrcQFMLhKqerqCfHc2IPh7yAa
         7/heo9HRJ1fREOL137SqjtXvJqGvYQjH0Vep/7nKwDNR/FJyS/5yjb30ZYEpiCeRH7ua
         3tQPrui7+SrrKk2tAaZVxjRpQc/Df36UiAy8qpnWFV7YaNUOh7bYNDYSGax8Fq0xlUtf
         TO1wYaEXo4HBtLZvvx9E0hjxmcKF/yXV7b4LAKiyB6iGksnKSZ22Yd2iuAjgGrltX1zC
         5Viw==
X-Gm-Message-State: AOAM5334qh0HkNk9O6yIFgYp64P0tGMvxXfT+O3zVZhClaJe5QCBCyHv
        G/XJzKSgABEF5K45+5te5P2E0XHxXPxmwP5nbb4=
X-Google-Smtp-Source: ABdhPJz5iJqO3rF79/N/EJoRF+CC6lbD3Jutm2e+GIHzkqN6Fzqr+bxXVIEyl+oz8Fhr2p3cPfT4QSL1G44JtAagyiA=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr27819767otg.17.1617728368316;
 Tue, 06 Apr 2021 09:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210401212148.47033-1-jim2101024@gmail.com> <20210401212148.47033-4-jim2101024@gmail.com>
 <20210406163439.GL6443@sirena.org.uk>
In-Reply-To: <20210406163439.GL6443@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 6 Apr 2021 12:59:16 -0400
Message-ID: <CANCKTBvP66su2bXNMbawMfe3T7mpiQsRsG5xLfSPL2BWPNYFyw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] PCI: brcmstb: Add control of slot0 device voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Tue, Apr 6, 2021 at 12:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 01, 2021 at 05:21:43PM -0400, Jim Quinlan wrote:
>
> > +     /* Look for specific pcie regulators in the RC DT node. */
> > +     for_each_property_of_node(np, pp) {
> > +             for (i = 0; i < ns; i++)
> > +                     if (strcmp(supplies[i], pp->name) == 0)
>
> This is broken, the driver knows which supplies are expected, the device
> can't function without these supplies so the driver should just
> unconditionally request them like any other supply.

Hi  Mark,
Some boards require the regulators, some do not.  So the driver is
only  sure what the names may be if they are present.  If  I put these
names in my struct regulator_bulk_data array and do a
devm_regulator_bulk_get(), I will get the following for the boards
that do not need the regulators (e.g. the RPi SOC):

[    6.823820] brcm-pcie xxx.pcie: supply vpcie12v-supply not found,
using dummy regulator
[    6.832265] brcm-pcie xxx.pcie: supply vpcie3v3-supply not found,
using dummy regulator

IIRC you consider this a debug feature?  Be that as it may, these
lines will confuse our customers and I'd like that they not be printed
if possible.

So I ask you to allow the code as is.  If you still insist, I will
change and resubmit.

Regards,
Jim Quinlan
Broadcom STB
