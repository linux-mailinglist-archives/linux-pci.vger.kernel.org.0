Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2916327D688
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgI2TMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 15:12:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A0C061755;
        Tue, 29 Sep 2020 12:12:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so6063943ila.0;
        Tue, 29 Sep 2020 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcP6TY5iCwC4Aoa9hwj7YacP7g0fXCBXP6lot9lXg7I=;
        b=ustwV+rQiU+AfTkh65OgnJDZzP9M8ZI1CxVfUb0JYxtghu8VHXN/6YLxMbxlRrB0B/
         tZAefFPj4E8Hyjk+P/4kJk8pqDOR3+TwogijtIOyah5RMu8gdowuu2+VdY16xA+7Q64L
         mtaKRWSTeXbP2AS4i7wtDcqk5yWknpoJpjl97g8brg4D/vKRO7LmXXSy2dvllE04Teim
         0xQiDG54qhMCwCxvES0IkqlOHVL3eoNp53wYh2Nw1I2KNYjY0xwUFkjV2WvGYZMzP0iZ
         otTBbfUMfCf+XJuzTTvdR/62MQpwLtn2fHMlKWGT/UYSX3Mtv1z/k3zpDoTI+EjAZIKR
         12Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcP6TY5iCwC4Aoa9hwj7YacP7g0fXCBXP6lot9lXg7I=;
        b=rkHCUiwkt93L1Z9LK46Sh9wPykeT1kQeNHt052vLt2TFfna8FrJ9W0Cvz94qhBp8tZ
         EyY2XdnT7fDk3fR58j52N4JPpD/tr1anfJ8v5nYHLW6zUw3LkRbYeQtN/IV1KicyfTKf
         aT9vs5ykMviTvw9b/ssqT0A3PbM7+TVEtqq4XQaHUGRI0Y5ZOUnXmjqWxB5khPIOVHlR
         JGTdEabct9Z/5iGwCH6bCmE+AbPcdkAoITkgHknn7EfP0VAKTl4/iRJtVnARRtCdobPY
         WpRaus+khoe7HU46TCoL5xhJPXoTTBpYju47wUPnGxE7fqbpAjviyfhUnp+jbKaYKd1B
         fbww==
X-Gm-Message-State: AOAM531L6yzhH2GeM8nMte1DFOjJRvB+7VE2S6TdjQ7TXhGnVuZyNlJH
        ue/2JN6vk780Sfquca22vIfgEBLwOcTz0szTi2ZzRmScUcOFpg==
X-Google-Smtp-Source: ABdhPJwyk6blmfn5pIjP/C9X1CZaW/UNM30nRQNP087xNYHB9CF9KavT7Uci512Yl24zVZ7QO9jgJLndkrhCBBY5hiw=
X-Received: by 2002:a92:1591:: with SMTP id 17mr4486385ilv.237.1601406758621;
 Tue, 29 Sep 2020 12:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200929005320.14739-1-david.e.box@linux.intel.com>
 <20200929005320.14739-4-david.e.box@linux.intel.com> <d6d59aad-a946-d780-b2d2-9c187fd8303c@infradead.org>
In-Reply-To: <d6d59aad-a946-d780-b2d2-9c187fd8303c@infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 29 Sep 2020 12:12:27 -0700
Message-ID: <CAKgT0Uc9LtFKnaHpzJhBLyeB_ycD74mb8wcaaO4KZBn+05Je5w@mail.gmail.com>
Subject: Re: [PATCH V6 3/5] platform/x86: Intel PMT class driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 6:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/28/20 5:53 PM, David E. Box wrote:
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 40219bba6801..093c43b63f48 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1360,6 +1360,15 @@ config INTEL_PMC_CORE
> >               - LTR Ignore
> >               - MPHY/PLL gating status (Sunrisepoint PCH only)
> >
> > +config INTEL_PMT_CLASS
> > +     tristate "Intel Platform Monitoring Technology (PMT) Class driver"
> > +     help
> > +       The Intel Platform Monitoring Technology (PMT) class driver provides
> > +       the basic sysfs interface and file heirarchy uses by PMT devices.
>
>                                              hierarchy
> No "heir" involved.

Knowing me I probably had class inheritance on the mind at the time
when I was writing it up and it was just a thinko.. :-)

Thanks for the review feedback. I'll work with David to make sure we
address the formatting/spelling issues in this patch and the crashlog
patch.

- Alex
