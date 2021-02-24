Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D87324493
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 20:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhBXTWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 14:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhBXTWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 14:22:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFFC061786
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 11:22:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f1so4798260lfu.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLkIzfKvA1tdVHUtMb/iXKnZBm8DzytxyIIS1uOtFXs=;
        b=Cykmeg2BJZxLL6B3CqFN8bYWXedcpxSrxU0obGXA67ldt53T1Zpp1kfII/YTsRxyGR
         7+PgVrl1GpAP3zASXR1P6ptK9NfrEIUej74r3llcPs1dZHaUDziptxNdAuOecoOUHHak
         y8TaQG7xMC0xTVy8H2BjUgVzI1nDYOoyh4Gg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLkIzfKvA1tdVHUtMb/iXKnZBm8DzytxyIIS1uOtFXs=;
        b=hSr+lsx+VzIpKwDD8jemdCATkuUhiyFt5S056hHl9snTpo7T+aDxzCBqDJ6H+y6ET9
         dmTnXcsl0CD8tNIWIoTtqFUiqdhlDbF9dvAYCtP0AL6KS5/YTbEzqyQ+9yfYpBOv20b3
         AFFTlFs3ktyfFuoshW6g5nr2H6Vn0FFHcfqjqy+QYsNyTpC82JquJm3h5L+awEqLaG5c
         SGWy1wj/PPSKrY7eprebuXWZ3NwdI/KfAAtB1us5VVEbsQuuaxRRppOwGDzULYNvq/BM
         PCIbdr0W2pEzAO/fw+pA+ldMhUTdQCPx+qh53F5kgH35CWpRRcvh5F0sSIKo4Nc0xjMx
         rhWA==
X-Gm-Message-State: AOAM532CX72rkFY43x29Z+amFLZm7Pue/F4OziaDlKItg46e0obpINxW
        XWRWji7WCSRItI029kSVjEyJrMMkZgHqQw==
X-Google-Smtp-Source: ABdhPJwEuLgU4OWwHeTPpLIRLP55ObQ5lMnqSbvVKGdMM9lJN8xE57i6zFMpk/uDN5OQCC0Dd1S0WQ==
X-Received: by 2002:a05:6512:94b:: with SMTP id u11mr20740844lft.15.1614194521713;
        Wed, 24 Feb 2021 11:22:01 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s12sm655321lfi.75.2021.02.24.11.22.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 11:22:01 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id y7so3718049lji.7
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 11:22:00 -0800 (PST)
X-Received: by 2002:a05:651c:110e:: with SMTP id d14mr21545549ljo.220.1614194520371;
 Wed, 24 Feb 2021 11:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20210224190335.GA1583051@bjorn-Precision-5520>
In-Reply-To: <20210224190335.GA1583051@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 11:21:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUjFdHYxQzTPJX+J38iSz-hS8Sn9sNx=+B=uMX+Q3wwQ@mail.gmail.com>
Message-ID: <CAHk-=wiUjFdHYxQzTPJX+J38iSz-hS8Sn9sNx=+B=uMX+Q3wwQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.12
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 11:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes

I pulled this, but I'm now unpulling it again.

Why are many of those commits only two hours old, and most of the rest
is from yesterday?

Has any of this been in linux-next?

And if it has, then why was it rebased, and why didn't you explain
*why* it was rebased if so?

I'm willing to pull this if it turns out it _has_ been in linux-next,
but I need explanations.

               Linus
