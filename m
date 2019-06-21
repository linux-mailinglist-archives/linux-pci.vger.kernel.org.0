Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0144ED96
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFURMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 13:12:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFURMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 13:12:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so6974110wmj.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxr2lSdUhJgiTc5D2qMkfm5yMBvV0zsum9CKhKZLKz4=;
        b=wCehu0cCKZdI0SqRemOcP+Jn913NqS5nSwotxkFEFo5+dPmAtz98iMU2wgRqCjFI/e
         mfJHcD6e3Xprhrb6TswjZuQ5BO33gux+9KU3rr2Lp4nxHKiQtODWN60aOqc8Bgj3TIh/
         tqfZHDPiQdwUZ7SkWBB+PP9i0DtUcFWK2kJF8kR7sqguXYAmNzuLpV/HoLY9VKKsxDs5
         0uNZj/It2Gjca0mOMdmL2lqX0vPV3cCPE9R0kOgEgVL6I4ZJclhj2GCJWjpvZUhK4U4a
         hOAIQflzgT+NnohAEOQQq4eM/KzhCa070OPFMc0pWwBhITwIWUxa01b+9KCgXcQGO2w4
         fNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxr2lSdUhJgiTc5D2qMkfm5yMBvV0zsum9CKhKZLKz4=;
        b=VNuUOeqMkWo4GIh6g1mcDUdOA7RI7CqGfZlfshYQoej2OSlOJAiGy7tI+pELxE4bgg
         YPkLyoyv8i5H92QVfEv5oE3vUaB/kTB9MQXmfNK/2sPVLr0BIrWNDRdxIw63Zo+RjkzP
         dBP9D67wexX9Qw43iPMAzULhkDyP2MyyUBkjm714Tn3YyvTjVdxEC8dHVj7Bv84+XE54
         3gSGaAuNZbwRTFI8vVtZpmrg2ISp/jL40dWj4E63svlwU5Kmu6Rd3ce5wNvvIQlJZ5pg
         ovLgrncDU/DUXVv1OlIn0ROeYpV8L3KsYGyh6NtF2nlVSJ0U1Cm3EFa/XoVG/L8MvSbk
         ghrw==
X-Gm-Message-State: APjAAAVuYaBzdlCQfY2Yo7XXuAulpYxb5DBCk+NKx1btzShMHxGaA8xH
        VTKTUre+9uRksvHQGjCaFGoowrSBFfjEPhhQOfTB
X-Google-Smtp-Source: APXvYqywL6fNwbUpFL//brGYmRCCnNuSg/TYeHcfUUEF0hSGIlVkbA14J2PQH52TmeF3M+qF5tLucTRd8fAuLAIi+2E=
X-Received: by 2002:a1c:9ecd:: with SMTP id h196mr5008540wme.98.1561137124525;
 Fri, 21 Jun 2019 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190621163921.26188-1-puranjay12@gmail.com>
In-Reply-To: <20190621163921.26188-1-puranjay12@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Jun 2019 12:11:52 -0500
Message-ID: <CAErSpo5TMPokae7BMY8ZcOXtW=GeGsWXX_bqS8SrZnh0pEQYxw@mail.gmail.com>
Subject: Re: [PATCH 0/3] net: ethernet: atheros: atlx: Use PCI generic
 definitions instead of private duplicates
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 11:39 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> This patch series removes the private duplicates of PCI definitions in
> favour of generic definitions defined in pci_regs.h.
>
> Puranjay Mohan (3):
>   net: ethernet: atheros: atlx: Rename local PCI defines to generic
>     names
>   net: ethernet: atheros: atlx: Include generic PCI definitions
>   net: ethernet: atheros: atlx: Remove unused and private PCI
>     definitions
>
>  drivers/net/ethernet/atheros/atlx/atl2.c | 5 +++--
>  drivers/net/ethernet/atheros/atlx/atl2.h | 2 --
>  drivers/net/ethernet/atheros/atlx/atlx.h | 1 -
>  3 files changed, 3 insertions(+), 5 deletions(-)

Let's slow this down a little bit; I'm afraid we're going to overwhelm folks.

Before posting more to LKML/netdev, how about we first complete a
sweep of all the drivers to see what we're getting into.  It could be
that this will end up being more churn than it's worth.  You could
send the result to linux-kernel-mentees, Shuah, me (but not LKML and
netdev), and then we can talk about whether it should be posted all at
once, as several series, etc.
