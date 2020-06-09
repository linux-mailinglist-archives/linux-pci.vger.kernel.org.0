Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF751F467F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgFISoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgFISoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:44:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB008C05BD1E;
        Tue,  9 Jun 2020 11:44:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so8375542plo.7;
        Tue, 09 Jun 2020 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU2WSCc5fTUsgnysxzRNJxs8r/CkSU3tfyTjN091RxU=;
        b=p9vwKPysRmyJpJidWcr/XZ5LPsj43gV5ylOJjIZy175anrIA0q0aXevn1w6L/tHw/2
         CilRpz/A8s2Xgv66x+c5mJz9vnhs1M0AgkR2ZcF8llNB8ODgtv7yARYe8yqWxe67VcSl
         eIXVmSioCEdDx/33i6p7MvUfrvtYy0/HDQhyuhDHJ58n7e+r5VBzSLiCXZSxfQG0tRcR
         HhEnSrEO2ZuW9ibsFl4klHuJQsc7z0gSzT+Z3WRuhOoCOCAzEQ5MKiVF31zRcd6kdTFq
         FfHFfprwiRoFz7vM50w46S4UN0PGMn6qorzg0xzKNinpDPZFMCCj1pEYjInhfYtc+Hwn
         77PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU2WSCc5fTUsgnysxzRNJxs8r/CkSU3tfyTjN091RxU=;
        b=dkMXabmKuCPIb5VuIkPE1uZtBPiMOxP210rDM8F8s8hLxvUZbOk62Sa83CztWrRRkZ
         8Hk4HBs+e2a+KcjzfM+7iugzHmr2ZpXPNhQ4UDwNKCKZWkfwgOLICnFx6GBmR3ZFWP0H
         8hyB+/j8ubJMRGnsnwClMb2dSPlwjU0KC9xsJhbNVMI9SZVEVP+ZtlxXZu6Kj71FaHWB
         YCrkaTZPyd77J4XU7sx+sT8Lny0TW4duJTDYL0+A1MQejJRxp8F+UvymUhqRYz9fsay7
         tObUhi0Lk1ewnzz8MgRMhCkTMt+ivLJHmdAIaO/rtc5gjGFmwhLSgh/DPhsyBsP3lv3K
         6KwA==
X-Gm-Message-State: AOAM532dEr6b2R3vs9OQWko320/Mr8cQ7j3lEJDMFTZHrKwKHhBfqG/F
        3Iudu+X/8eqRnnyAGAMEemN0GMx7bAJxsxr8NVs=
X-Google-Smtp-Source: ABdhPJx0RiX4lxJ3jtBScoX+hSRo7BJa7PbBAuUa09WsYVDwWWg5oyAqW2t/Zz4dsplunUK1BR4yGxVPksOs9RAEVnw=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr6162606pjr.181.1591728249457;
 Tue, 09 Jun 2020 11:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200609175003.19793-1-nsaenzjulienne@suse.de> <20200609175003.19793-8-nsaenzjulienne@suse.de>
In-Reply-To: <20200609175003.19793-8-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Jun 2020 21:43:57 +0300
Message-ID: <CAHp75VcxjpMYgQV+Mv2_A6gT+qkG_Kihe4Ke+avJ6e6UNdZCnA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] usb: host: pci-quirks: Bypass xHCI quirks for
 Raspberry Pi 4
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        USB <linux-usb@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 9, 2020 at 8:50 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The board doesn't need the quirks to be run, and takes care of its own
> initialization trough a reset controller device. So let's bypass them.

through

...

> +       if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483 &&
> +           of_device_is_compatible(of_get_parent(pdev->bus->dev.of_node),
> +                                   "brcm,bcm2711-pcie"))
> +               return;

No put?

-- 
With Best Regards,
Andy Shevchenko
