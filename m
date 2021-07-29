Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B033DA736
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhG2PKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 11:10:00 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44675 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2PKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 11:10:00 -0400
Received: by mail-oi1-f173.google.com with SMTP id w6so8826205oiv.11;
        Thu, 29 Jul 2021 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bJH/fpoUt2uQkPvcGjyGDKgGhlQRm6pEd78vhS/jc4=;
        b=dcpopyNmCSugC/5Ljm+GJtGYxWHX9qB3IgvaSbUM4/MjayxwF23BRzMAVQwKlGpS0e
         IVbdHO5V00PmyaQVbWedk2YpU4Zhk/uKQzKa61zivfwtR1LtXyp9Cr49eFD5byB5riJM
         kDImKeHY2/SJCkJ2dpYbZ3GCCRK+pswMaPSGrg/M1eR7mIcN5pZJJm66ddu1sGblbl9T
         /ZyDx4flkuY2c6OQKCvZ3GOLGBD751aVS/skUTXrScqZBwuHzQVHjvQutiEy483cmLSh
         gKxDPZGVP/D+FQC+wD87YbMfEKE3uwCrXk4dIKW+T17coe1Ze9TR+ZDhqhXEgTl1wTG9
         JMPQ==
X-Gm-Message-State: AOAM532ugR+AmWRt2QpIGJteHO8MM6QY1G5E9mFq/tq/1z3rrfxsrddK
        28N3VS+z3lQmXQUxL2TpPwWTqwqpx2vJEpYz3xI=
X-Google-Smtp-Source: ABdhPJyvEGB8FjJACYl3Fr7vWAR7dFS0J8VaBw0Le10jR0USiUfcLHOOMG8vDbEB/DEgNPj66v0To6sSiuu4EQ8RXyg=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr1418309oib.71.1627571396779;
 Thu, 29 Jul 2021 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <4668274.31r3eYUQgx@kreacher> <2207145.ElGaqSPkdT@kreacher>
In-Reply-To: <2207145.ElGaqSPkdT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jul 2021 17:09:45 +0200
Message-ID: <CAJZ5v0jA92Mdrv2NyKpNs0tB45_p2sFmh_81RaBpnFVnr66+5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: PM: Add special case handling for PCIe device wakeup
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 4:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is inconsistent to return PCI_D0 from pci_target_state() instead
> of the original target state if 'wakeup' is true and the device
> cannot signal PME from D0.
>
> This only happens when the device cannot signal PME from the original
> target state and any shallower power states (including D0) and that
> case is effectively equivalent to the one in which PME signaling is
> not supported at all.  Since the original target state is returned in
> the latter case, make the function do that in the former one too.
>
> Link: https://lore.kernel.org/linux-pm/3149540.aeNJFYEL58@kreacher/
> Fixes: 666ff6f83e1d ("PCI/PM: Avoid using device_may_wakeup() for runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The subject of this patch should be different, let me resend it.
