Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFC3513E3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhDAKqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 06:46:38 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38444 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDAKqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 06:46:17 -0400
Received: by mail-ot1-f49.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so1714342otk.5;
        Thu, 01 Apr 2021 03:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o87MMBtEyXrLDI+UXXVN/kLAY/ixo6UgJV9nJTpzby0=;
        b=n+PniYApmaTxqx1KRPtmEpK71o7hU89EQOFNHod08o6h4syknXKlrO74O8yqG4iH2z
         bEfEqMSmveENP4dKb1JcevEswChDc9pG6AKN/ZR3AGaAVzRGwW7E5yf5fFn+Y5irHw99
         l/nUanCr+Gaw7Kc6tDTH2k6Emh547b2yyiuxD9PnyyGJjxRFillvGVgVpMfC5qcFIJLv
         /fVjo9toufQELotfLLjy2xTuIOCJJyuOqv47dPCL29GN5LRm6t5nYgNKgCFF6mwkYCrv
         Z0bMm/1p0gpx5Jc5rVqy3Cv4xl8QWPlSeXkubSSuJHWdCBA7xSdRVGt7mrsy7KHiX0aG
         NaIA==
X-Gm-Message-State: AOAM530o2SFLgAqLw1GO8KnIctn/3smsNlBGD/VQYoL0Z4FzpNlSbYqw
        bCnXQtAVFyiQQELwztewFfZYsgnwDufvYbABsJnXm+tb
X-Google-Smtp-Source: ABdhPJy35DDwAq+peQ/etkj5pBR3XohD0I+EXiJaupWlcMzeaTf9KWgxaFEZwnqZqOJFIH6z2AIFVAmajpUx8DQfUQw=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr5757449otb.260.1617273976398;
 Thu, 01 Apr 2021 03:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <4319486.LvFx2qVVIh@kreacher> <20210331210845.GA1422864@bjorn-Precision-5520>
In-Reply-To: <20210331210845.GA1422864@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 12:46:03 +0200
Message-ID: <CAJZ5v0jksMw4Cmo_u4cU_6ii5_4R5xfytLzpF282tfkv__nF_w@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: PM: Fix debug message in acpi_pci_set_power_state()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 31, 2021 at 11:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 25, 2021 at 07:57:51PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If PCI_D3cold is passed to acpi_pci_set_power_state() as the second
> > argument and there is no ACPI D3cold support for the given device,
> > the debug message printed by that function will state that the
> > device power state has been changed to D3cold, while in fact it
> > will be D3hot, because acpi_device_set_power() falls back to D3hot
> > automatically if D3cold is not supported without returning an error.
> >
> > To address this issue, modify the debug message in question to print
> > the current power state of the target PCI device's ACPI companion
> > instead of printing the target power state which may not reflect
> > the real final power state of the device.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Applied with Krzysztof's reviewed-by to pci/pm for v5.13, thanks!
>
> Let me know if you have nearby or related changes that you'd rather
> take via your tree.

I don't have any, thank you!
