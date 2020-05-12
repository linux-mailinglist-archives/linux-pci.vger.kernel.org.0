Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72091CF47B
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgELMfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729773AbgELMfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 08:35:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23735C061A0C
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2020 05:35:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so5738431ljg.9
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2020 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+869pZRfZJGBIoOGq9mbn83yXJ+3UvweYCO0bpzAwU=;
        b=UXp5LWlOcqJH4Otgcn6q2A/q237JlCum+6BEJUbhK3WCudK1bkbQ749omybmNu/3GT
         144x3LhV8t+xWMxbIoPgDMj+X3EI033ppEuEJhGDane5FEBqRYnOfLaVGLMsxYZvffi8
         jl/3Mg4YWPlQowpVgZTm6stKpaLrns46uAFa8Mmq/asfIME0nHcs+9Zzez6daQdqXZ+q
         MvqfSVB/ERfLsc/7464D8pTh8/uX3asXjb5DRGj/wmQFWpsdg3WeX7ex2JBAHeCQZ8mi
         4phPCqUEkxDkgK59hWRd+l+E1LKLDdKILaREvTtkahvakxfN6ei+ZK7ZpUW3Qelm+UQH
         ZQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+869pZRfZJGBIoOGq9mbn83yXJ+3UvweYCO0bpzAwU=;
        b=PEgB+pmUF2axO/9s7UYpBhn/t7DflhxZRkLpOFvl9MfmmTrWgEeHrAd+vCHIlQuOti
         bIV7GvwFv4eM37Gm2B0pDMFSDkgqkTDJDSb3QPR8c2hP4tKwT0+D+286HOMJLPD+uOEk
         fXOr/RruGzcCXqzT48op9AfownVmBJcWwDH0+ihTikz0evv0fkCN7qXkiq+J5/FdghhJ
         B+kIB2KEJ0m19bYFZ4PkvlFKj0Whdin9bkcayBSgRrbR1Ysdhz1/xulSiQn2/zKL1Cje
         LEBzIIcpLyTeTZUdhYydCYZfi+3pgiUVNlknQvbnO8OrijrnsfGBRpJy0XIsUmMILPYP
         oybA==
X-Gm-Message-State: AOAM533kia9SVyMRZYQzEG2TIT5ie/e0d6gdC+gKDbCVMYBJUuR8D0WF
        Z/gQP3t/7Jd2uikowLtXoQp6Z4xdH2JFRIhkflNRFw==
X-Google-Smtp-Source: ABdhPJwyAmzC6q+bZTHJQiILGIOYXc53TsNeXcXr1K8tekap2deRZGY7SbCRt6J66veik8VTCp6tr6H0vjULsNvGn30=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr12693709ljg.99.1589286928448;
 Tue, 12 May 2020 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200501224042.141366-1-helgaas@kernel.org>
In-Reply-To: <20200501224042.141366-1-helgaas@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:35:17 +0200
Message-ID: <CACRpkdbkPX3cX9VDoGx9LMLPgDFxwVbWQuKuaSyED5Nek0ATRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: Check for platform_get_irq() failure consistently
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 2, 2020 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> All callers of platform_get_irq() and related functions interpret a
> negative return value as an error.  A few also interpret zero as an error.
>
> platform_get_irq() should return either a negative error number or a valid
> non-zero IRQ, so there's no need to check for zero.
>
> This series:
>
>   - Extends the platform_get_irq() function comment to say it returns a
>     non-zero IRQ number or a negative error number.
>
>   - Adds a WARN() if platform_get_irq() ever *does* return zero (this would
>     be a bug in the underlying arch code, and most callers are not prepared
>     for this).
>
>   - Updates drivers/pci/ to check consistently using "irq < 0".
>
> This is based on Aman's series [1].  I propose to merge this via the PCI
> tree, given acks from Greg and Thomas.
>
> [1] https://lore.kernel.org/r/cover.1583952275.git.amanharitsh123@gmail.com

Makes sense to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

for the series.

Yours,
Linus Walleij
