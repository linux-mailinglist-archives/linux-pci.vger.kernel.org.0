Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE2355A66
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhDFRaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhDFRaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:30:01 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738AC06174A;
        Tue,  6 Apr 2021 10:29:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i81so15916937oif.6;
        Tue, 06 Apr 2021 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9XCrHRbPqjp2SIACD271qp9C9m0DUNFOwKAi0QKpXs=;
        b=YBZah0WeABNCYq0ebm/I87ZFpbg0mlsv9pTMX6nhWLnrxZgASf89DWi7GzZlKD2svc
         BTTN01jmIvz6EI6EZygJ/3n79A8xrD3wBk02eJduiV6a5gJT8VLsoZZoWDoWQDWZxJCi
         z69rT/QA30kbdV4PchR3sj0XyKsqYjdneHxAaRj4Rv8WYywFUli5wHvegPOsbDs4KUGi
         MrawLcKd21iWytX7uPzpgdt9Sr9oOCszLnq71v5x0uBhLhDpyFjfoy6NTAoxFeL3RoHx
         wG1IQzGYERVPErQhJee16HLqo3lNgHXO8/7PTfysJe+EZ1NTLxpDW/GskLhCfK3Gg4tO
         1f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9XCrHRbPqjp2SIACD271qp9C9m0DUNFOwKAi0QKpXs=;
        b=MmWNG9LiMzOb7rQu1P9Bnh5DNowTYpzBLv56be4CQDdAQaDUbi1nPCNqYxJlYHuyAc
         xHjq0iwz1c3pHL7X/jdyMq69oq1CGAfgKNWtabyi8mwul86xqP792mBkxT/HjDw99Sy2
         14k58GxvZ/vlynULbeaK+dIfDyNfnWbIyn2fWSKNat83sblYiF2dAb+EhIY3tw5+CUdU
         7Ex5psL1ScxViEZMFBRmnvA3+o6DCEwy0ra6nt8N2xAxj6Q1MDj3C+cgAMYLyhSJmOu/
         6iSXkDhiOQK91jRZNp1IMxhBlVubCtA2NIU0rwyZytPmZKhgdkGbIr++hhLSJiHElSOm
         WRYA==
X-Gm-Message-State: AOAM530QqpkIe53nkhjYdNXKONQxF94ScPWtsg7RMAwI/agYucXqrMDY
        PMTxN/7PdI3TelvgKWz/mwqXFw1EnSdM16CEvmQ=
X-Google-Smtp-Source: ABdhPJwE+fUN8o/LQb//6t43DmpeyIY8YaG40zK3+s4/evbg6pFMHv53bEk1TPp+MnBpqKtTbb5PjpE44JswmPwH61Q=
X-Received: by 2002:aca:fc11:: with SMTP id a17mr4067194oii.68.1617730191812;
 Tue, 06 Apr 2021 10:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210401212148.47033-1-jim2101024@gmail.com> <20210401212148.47033-4-jim2101024@gmail.com>
 <20210406163439.GL6443@sirena.org.uk> <CANCKTBvP66su2bXNMbawMfe3T7mpiQsRsG5xLfSPL2BWPNYFyw@mail.gmail.com>
 <20210406172320.GO6443@sirena.org.uk>
In-Reply-To: <20210406172320.GO6443@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 6 Apr 2021 13:29:40 -0400
Message-ID: <CANCKTBvptjpNLyN-mZqynF=Af_X0X+OVasL==thQKzzBZ5r4yw@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 1:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 12:59:16PM -0400, Jim Quinlan wrote:
> > On Tue, Apr 6, 2021 at 12:34 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Apr 01, 2021 at 05:21:43PM -0400, Jim Quinlan wrote:
>
> > > This is broken, the driver knows which supplies are expected, the device
> > > can't function without these supplies so the driver should just
> > > unconditionally request them like any other supply.
>
> > Some boards require the regulators, some do not.  So the driver is
>
> No, some boards have the supplies described in firmware and some do not.
True.
>
> > only  sure what the names may be if they are present.  If  I put these
> > names in my struct regulator_bulk_data array and do a
> > devm_regulator_bulk_get(), I will get the following for the boards
> > that do not need the regulators (e.g. the RPi SOC):
> >
> > [    6.823820] brcm-pcie xxx.pcie: supply vpcie12v-supply not found,
> > using dummy regulator
> > [    6.832265] brcm-pcie xxx.pcie: supply vpcie3v3-supply not found,
> > using dummy regulator
>
> Sure, those are just warnings.
>
> > IIRC you consider this a debug feature?  Be that as it may, these
> > lines will confuse our customers and I'd like that they not be printed
> > if possible.
>
> You can stop the warnings by updating your firmware to more completely
> describe the system - ideally all the supplies in the system would be
> described for future proofing.  Or if this is a custom software stack
> just delete whatever error checking and warnings you like.  The warnings
> are there in case we've not got something mapped properly (eg, if there
> were a typo in a property name) and things stop working, it's not great
> to just ignore errors.
A lot of this is really not under our control.
>
> > So I ask you to allow the code as is.  If you still insist, I will
> > change and resubmit.
>
> Remove it, conditional code like this is just as bad in this driver as
> it is in every other one.
I will remove this and resubmit.
Thanks,
Jim Quinlan
Broadcom STB
