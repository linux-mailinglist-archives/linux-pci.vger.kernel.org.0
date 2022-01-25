Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4DA49B6B2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 15:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389059AbiAYOoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 09:44:44 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:38844 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389262AbiAYOkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 09:40:19 -0500
Received: by mail-yb1-f179.google.com with SMTP id i62so15962560ybg.5;
        Tue, 25 Jan 2022 06:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmXgH7zvCKX7VHBhpaIeJiGEHk4KUYcP0Ex/yLKpPRw=;
        b=6H9+F/nMrttzgBGtZU3fM2qnAlAR7KVAXR+P0s5h/nqDNTjZafFa8k+A0docFREHBo
         v+UNaAppgBLuEzJ0Zw3kM/P0nZeSfWx0xBGdL3jdNaZrrsSrFaHl52JrsuaqlnpG+wUO
         qkilZta4eSlvWl9Wcq6CgxGHHwLNwLY7CGAEPrzOCt090tH99Dn056Ql86bc8qlyhPju
         Pn9lyTcNtzuSDspgA8UungONARLYR4T9cXyYwNjAx9g53ohnVf/CZSV3B5XW49rPtWGj
         orfn9tAy5VYJk8GOADDbb9/DiuF8actN2z/1vwsIYPDmeLmP9fPgWFQNX9mkL8WtLcrf
         ZWAQ==
X-Gm-Message-State: AOAM5312sBf6MilPQnB3HJ81awEeW9Q7/18jy/PC+qbX2SA6xO4ApbB7
        qObpEtJ7QHLPLM4bZMCjThF8FQH3gvTWEGgbbloc49nu
X-Google-Smtp-Source: ABdhPJyf4NeSGDSjgs2JLUl9Ym4PFBwT201JLgx/QXUQCHDWtDkDZoHe8Rmk0nWCImELThqsOUzv2R/oSJ1fmxEwliY=
X-Received: by 2002:a5b:5c7:: with SMTP id w7mr30536273ybp.343.1643121613569;
 Tue, 25 Jan 2022 06:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna> <Ye/X7E2dKb+zem34@lahna>
In-Reply-To: <Ye/X7E2dKb+zem34@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 15:40:01 +0100
Message-ID: <CAJZ5v0gii3z=DfFbGvubyg=f3t+74eNFdtpJDauwzH4roL-dAQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 25, 2022 at 11:59 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > by the firmware to mark any device as untrusted.
> >
> > I think this new property should be documented somewhere too (also
> > explain when to use it instead of ExternalFacingPort). If not in the
> > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > under Documentation/devicetree/bindings.
>
> Actually Microsoft has similar already:
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
>
> I think we should use that too here.

Agreed.

This is what the platform firmware will need to use anyway for Windows
compatibility and OEMs may not care about running Linux on their
platforms.
