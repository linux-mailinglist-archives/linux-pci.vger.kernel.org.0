Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9821D484
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgGMLGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 07:06:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38469 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbgGMLGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 07:06:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id r8so10622902oij.5;
        Mon, 13 Jul 2020 04:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xq0Xpj14H2RAfHIcz6O1rzdZKTYQ6stUGUnZp3snUe0=;
        b=iVYSe7Us9wDPxyFvo0pgk4rajJsRChRRD3hiC6voLQvFGFVIcAkMW9r4FymxEMC5iK
         qExrqkvlouFNVApMlsR4771pxDCDhHAfEawzXtwJYjsBpuyb+/4fI2UfEwKY9j+lGL8a
         GjQbtnYap6mOB36iDEbns6Qoczx6O098ZHEfCjZ8/hC+B+2RuCOVBFC0o/AUyl2Qt9Lv
         7mcPdyAALQDHBmXwrs9QA+p+vK4CY8q59mP0L6wNW5NQGyJELymylci5XIPRrG4986Vp
         gxK/4H25miGQGAwWTlwLB97onFU1IrWS8tUmqKQqyYzFXXPnlFeTNKo5BtWjrm3JGM9R
         /ohw==
X-Gm-Message-State: AOAM533bERfIskueIrd96dk3cQKxfyng/8AP42EBQQADALImmL8gPHvg
        WkXcmzT/L7Yz9Vj0jePcIRV1KTNe85+ma3r1Bsg=
X-Google-Smtp-Source: ABdhPJxuUGgC2576RXR5fqSCHur+PTLt9ehNfGPdTtWn5K6sa2wMiG5IebMDbeR/EJoDO++pbbUzgVbpU7JFKksBRPA=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr12958541oih.68.1594638366777;
 Mon, 13 Jul 2020 04:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200710213753.83420-1-helgaas@kernel.org>
In-Reply-To: <20200710213753.83420-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 13:05:50 +0200
Message-ID: <CAJZ5v0hy+B7wTuJoXzC_7Gnm2KBUPFS0XR3TH=p5twX3oajspw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/ACPI: Unexport pci_root.c functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Unexport a couple functions that are no longer needed by modules.
>
> Bjorn Helgaas (2):
>   PCI/ACPI: Unexport acpi_pci_osc_control_set()
>   PCI/ACPI: Unexport acpi_pci_find_root()

For both:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  drivers/acpi/pci_root.c | 5 ++---
>  include/linux/acpi.h    | 3 ---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
>
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
