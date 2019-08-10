Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDB889F5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHJIUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 04:20:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43803 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJIUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Aug 2019 04:20:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so71171953lfm.10
        for <linux-pci@vger.kernel.org>; Sat, 10 Aug 2019 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vQnFwQNyVp0MJ6ZA472G3A4Wc8Umh59hbB35xxA2KY=;
        b=xyRgTEG01oxAM6kN3jiwijjpejYs6si4w5U6ne3GUJERc2vRfDRBTIkQDJjJqxDolK
         0bLfKfPb3JCYWf66fSjaqCWEhYLa9ycbxRMraqUJswxo9XOPg2BIpaClQ0f73JcLyEel
         wEnlWiq7C+xmB+M/WcGbHGjA8kxNsahgwIdQW7GjRBhTFb7aTceZi8h2lgO57lgqCa8d
         LLRBFebUb2L3VvHb4mCQFOjF8j0sxr/z+Astq+efuh3CLGgNJRcXqdJjUeS1veFlDXrA
         /VoCRELA/ui1hkqfMSw/IObCC0GWhKbL193R8e8nS43qChlzbYB/dfC9rOinU1R9gHyZ
         QEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vQnFwQNyVp0MJ6ZA472G3A4Wc8Umh59hbB35xxA2KY=;
        b=X1V06XON9egK8Z8C55VcqD0liYechJvt+vRwXTAPH+NkBaZUyDhui94L8eJSZzowkI
         1RutneCKAP/VVvTFf/0uwsnAPH3myNC6/sC+d4OzvXTXe/XMvsliw1GK6C5NpUieFqNP
         /YrC7qJ6dkdfdgCnN3qbL6PtqIXLWk81YEvDnIxltHtSTXIYCm2J1TBdakZpb/sTFPMy
         uOrcnQuVJow15aG4rd5KURQIFhca+9UeOqzj9MrSKbVADJK9Qcx4B1eWUjBnTWxRYv8b
         BCdJGOyuQOPPiuzK41lb5+j+nGulHwVjzpv4ncJj+c2PLwMlzhFLBWfYjQxdptEeWTWy
         Hx2w==
X-Gm-Message-State: APjAAAVYUEaKViAOhML/4Ddz+sR77fx1+KXVHRCz19KGFW2LQ6TJ3AR5
        cooxBLyOquMFVaeh0QzDkzCuDOnO2b5TyRTaghdJXg==
X-Google-Smtp-Source: APXvYqzE1mTpjud1QXbttRnYvBm9iSV2zfdjY1xkGmTm69zvHpAT1DCI81jjIuPyyV8Cd8bHwU5cUrdUSfa0v+ozqu4=
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr14657379lfq.92.1565425216308;
 Sat, 10 Aug 2019 01:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-32-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-32-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Aug 2019 10:20:05 +0200
Message-ID: <CACRpkdZhdp7_ou9XiiAq7OAuXDxE6zr-rHuhEZPi+ErSiLKdLA@mail.gmail.com>
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 30, 2019 at 8:19 PM Stephen Boyd <swboyd@chromium.org> wrote:

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
(...)
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
