Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA57D1B64E8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDWUAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 16:00:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C3BC09B042;
        Thu, 23 Apr 2020 12:52:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t63so7867960wmt.3;
        Thu, 23 Apr 2020 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bovI+nPzSNj2sKyQBiYFJbyyronnwfOZafj50co011I=;
        b=pMEoHWALeeAnkX1KcYrdq9Wu09rZZfiG5IlDb0WnsVVnJDRHzrp05fQubkH2BZTNmb
         yW+R/DX+rnBB8PgAdw0U/4eHnsp39QNe8FT25c3xH45B8LCuhSWon7FM4BFoB6t/koUs
         U9DUDbWpZXMp/QJMw0zGszTH06M9Y5ZRbAwuIqTZCL0Y8HQymmcB/6BovysfBVKYZABC
         zn+RXSL3uxt0jyISXIuYIxiL5iu4cd9mDG/H9USAFsr7cwFDJVikzJMaGgp0aYtXuS/R
         PhNb9mcDil7QY99HMs/Gm1boGu3tyqqAQBlNWZ76ShV6EkXW6cZh60fduZye4h3x9luF
         cbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bovI+nPzSNj2sKyQBiYFJbyyronnwfOZafj50co011I=;
        b=DkhKEM5chH9v21A/Mmy5LvaZ7Crr+3qZR7GNg5JqOnMwtWnoEX9WrPsJeMMoWjfMMk
         EnG3Pg+7tD/ncLz8S45ccSykDu6/0w40ktr/+RQIcpWJFNG5bxujERFOAuE6ZwP/ey8F
         Y0VSGLiKupC3OfNxV9w2e6Yolm7Xx+MPQ/8jVAZaxjCE00wLr/MFI/ktNvdHhrKFgryG
         9iV94O9lv+VWhaAAovhhUVCD1IyWImuZkEg0F++KRnzuPCJcRSjhl0jTJAO6xlPxmtKx
         fF/8ipBlaS0yO/6cqLZbwf6fGgJPZeVeJpi+tBEop+NCy9s1J8wtZT3oVzyyS9S08JWL
         whRA==
X-Gm-Message-State: AGi0PuZz3Dgadld7y8j1lLLMwgeeU/0axG50C9+8FADMw1qqMYtSoyVv
        CYpYK2g9NaMMi3S1Mw/qk8GU/rdepXH9fcXbs62CUK7I
X-Google-Smtp-Source: APiQypKWYdRlNdDAQJSC7cfHmZ7OAgf6FRy5MFVTwUB9gGunyGmFEOeM9r8KlecUb0R6BbS0howq0wze2Q9r3Z4OpUQ=
X-Received: by 2002:a5d:5352:: with SMTP id t18mr6638141wrv.111.1587671548719;
 Thu, 23 Apr 2020 12:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_NUueBoEXcO_HBHqwrONnmoAvepBLwwxtQW7R=SuyoFfQ@mail.gmail.com>
In-Reply-To: <CADnq5_NUueBoEXcO_HBHqwrONnmoAvepBLwwxtQW7R=SuyoFfQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Apr 2020 15:52:17 -0400
Message-ID: <CADnq5_PPxCPPrggE96uNRHQLTq7+bg0iSq2+C46QybV_Xd_=gQ@mail.gmail.com>
Subject: Re: runtime pm without pci or platform subsystem involvement
To:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 1, 2020 at 10:54 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Hi,
>
>   I would like to be able to use the runtime pm infrastructure to
> support additional power savings at runtime for a PCIe device, but for
> various reasons, I need to keep the device in D0.  I don't want the
> PCI or platform subsystem to put the device into D3hot/cold.  Is this
> possible?  If so how?  I'd like to avoid spinning my own variant of
> runtime pm just to support this feature.

Expanding the audience a bit.  Is what I want to do possible?  Just
want to make sure I don't re-invent something that already exists.

Thanks,

Alex

>
> Thanks,
>
> Alex
