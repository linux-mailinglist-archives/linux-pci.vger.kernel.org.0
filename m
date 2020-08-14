Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53343244E2C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHNRpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 13:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNRpX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 13:45:23 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D1420838;
        Fri, 14 Aug 2020 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597427123;
        bh=FiIcjZUHsrXzXH0x/aRcjN5xj+GMmd6ZOirtzojIXcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZAQA2SeRvHDUZUCMEMhk/0up8jQO6zukqnZPWP2/qF2LxON+B1HgoWgA/aPl1RNA7
         qtJbKBIz4H7GgYO6dX6Ge62lOOT16nrHFZKhmD2Ez7iBwdidw6GnjDn+71qIYW6vVB
         eQC7EmThFZFXHOkecVbdctpD+ccrkYJynET6VPu4=
Received: by mail-ot1-f52.google.com with SMTP id k12so8229332otr.1;
        Fri, 14 Aug 2020 10:45:22 -0700 (PDT)
X-Gm-Message-State: AOAM531YlG85wTcCJPTgxKfXDXmXdX6Isun3I0FwukXkSoIASwQ196bI
        WOR24Obi5zLDD5MzFJpKmI9+Zkm3OCXKPaaC3Q==
X-Google-Smtp-Source: ABdhPJzLneaV1U/oXF/OaPVbM1bWrBHv2LQr0VSykU63XEDKIJjDJeWXJvk+9sbW6PNCVPqJyPVi9PedlAYR9QizpQk=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr2509020ote.107.1597427122326;
 Fri, 14 Aug 2020 10:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Aug 2020 11:45:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpuoGi4r9a+nKGyTyh4zXtFr-M8oAmJLcQjiN3V54F9g@mail.gmail.com>
Message-ID: <CAL_JsqJpuoGi4r9a+nKGyTyh4zXtFr-M8oAmJLcQjiN3V54F9g@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     Ray Jui <ray.jui@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 5, 2020 at 10:15 PM Mark Tomlinson
<mark.tomlinson@alliedtelesis.co.nz> wrote:
>
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
>
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
> changes in v4:
>  - Use bitfield rather than bool to save memory (was meant to be in v3).
>
>  drivers/pci/access.c | 9 ++++++---
>  include/linux/pci.h  | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
