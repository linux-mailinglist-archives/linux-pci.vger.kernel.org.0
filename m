Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53D409884
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbhIMQQG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:16:06 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:36432 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhIMQQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 12:16:05 -0400
Received: by mail-oo1-f45.google.com with SMTP id y47-20020a4a9832000000b00290fb9f6d3fso3591840ooi.3;
        Mon, 13 Sep 2021 09:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD6b4gjEXuMSDssAEUxv3yw1AVPOlnQQhosOE6fABxw=;
        b=mKE4Vwwhq4fOc6+vUkZco0lYCkl/hGnrrBt0agM2z8MZHfzep/rPS0DFpfWRoDRLFx
         jCFqVbDa4BnxLDhBQRjj7i62+7pebm/oQ1TosFNa9qRnIDDed4IihAcTyZvwZ/X/eEH1
         xO2yRs/vGB9pnq6aDtGiEoEORH/vzLY0UZYExzF3goVLrZjpMf0fQu6ctpbnV5Yx8h+S
         azIwAJj3UQWFMu1m4aYJBO8yxfNXkoB9/Z2iGe+OPJXR7g6PNqGVs1qW2UVgyhX+Tdk7
         h6RxDSlCago9eI5mLD/s7TGRF+EpwYpmkK2NQrSLQrp89XAH7FHewy4MI5OGjuYBEgSC
         XUaQ==
X-Gm-Message-State: AOAM532ewk9O9IFYVMLcl973XKbQEMHQqE0dAVmLJuqKuxfYTAJ80gGW
        tr5Md/DTGC0ANy2e5RZyWHPXCt7CUAo3I8+CAfI=
X-Google-Smtp-Source: ABdhPJz1C8i4WX56ljYUCpTaGKUQWQ7b2nSz3hNmFxzBCW7JaZjHuAA84c2M8Mm425XO9BsEXk6qvmLfTbSA5ZHcHyk=
X-Received: by 2002:a4a:a78a:: with SMTP id l10mr9814539oom.30.1631549689413;
 Mon, 13 Sep 2021 09:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <CAJZ5v0jqwgvmRrRts4Nf4ySmrp5gwmv_iJWBh3OjN54ZU+qneQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jqwgvmRrRts4Nf4ySmrp5gwmv_iJWBh3OjN54ZU+qneQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Sep 2021 18:14:38 +0200
Message-ID: <CAJZ5v0hn5EvwjPggCeUw+kjDNjdzx3eLP2PRBGKRAyo2eYECyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 1, 2021 at 9:33 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Aug 24, 2021 at 2:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Hi,
> >
> > here is the third version of my patches to simplify the _OSC
> > negotiation of PCIe features between Linux and the firmware.
> >
> > This version is a complete rewrite, so there is no changelog to the
> > previous version. Patches 1-3 are cleanups and small restructurings of
> > the code as a preparation for patch 4.
> >
> > The last patch gets rid of the dedicated _OSC query to check for _OSC
> > support and merges that functionality into acpi_pci_osc_control_set().
> >
> > This allows to simplify and/or remove other functions and consilidate
> > error handling in negotiate_os_control().
> >
> > I have tested the patches with and without 'pcie_ports=compat' and
> > found no regressions on my test machine.
>
> I have reviewed the patches, so if you want me to queue up this
> series, please let me know.

Should I assume that Bjorn will be taking it?
