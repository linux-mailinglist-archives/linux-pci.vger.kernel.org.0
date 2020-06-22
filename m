Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDF2039CE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgFVOoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVOoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 10:44:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB68C061573;
        Mon, 22 Jun 2020 07:44:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k6so7659441pll.9;
        Mon, 22 Jun 2020 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbPnTXWG3FTmKbDopj7bVz9XNFpW3F1DzJqvbTKH2Zo=;
        b=pcF1W0cfpODtkp7D7/LY/drAOVyuL7/KWS4xrre+BLffHK5GwrwZ/jtRVNPLawPUHr
         2w7Zg1KkePSaczW2TgAvo1f10hhwTkc5L6QXRLiYvoAHMwQesbaJZlP5ggnkEPJpauk9
         jANIZKgBR8/lM4d3ssU6hi3gTyTMXYpx+azF6yAL2U/cxfc/1LTRhwclFfGELpDMOg8s
         lCyCmTMuc7Ibbt3RxO99mUbcSvQPt8zJehCJRRX1JL/QJC9l7CMppcOFUVk6YlbgUaro
         7hOyzU9L5qYM17r5TNWnIVSmhMNESGu+U4bDOe50Vhj6LI7fjFmFcArTfotx+vY3SuiN
         e8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbPnTXWG3FTmKbDopj7bVz9XNFpW3F1DzJqvbTKH2Zo=;
        b=shFA2oreCk5VNpvJuje3TYL9XQj3s5Hq5s1rxguIe18NavLvvG+/HSJFSmcaGX1MMr
         +jTV1Cxryp9z8ZtxkuD6GLBVsneOdepXd8L2r5KHZOBKyKL7IR53QIMcaOYoAzXVT8RP
         pXre7NVDVbz/JaJsVICgx5jzAjQqHjRgyDtEKkSbgAE9rVormssalnkni5NIsalu5u6/
         6bRPg95Y9sF9rxbfWxx23ySH/HDYc+5MqyERN63S6ARTfkjLEO3SkbWMTVd7G1ATlut0
         21NjK/cMDjVfL0K3HKqhvVfUy1NmHaME8yUKV8rfU7BXc4m/F2mtGOPLfmo4STUhYe31
         ZW2A==
X-Gm-Message-State: AOAM531mqkMmMLMnRoGUo1KYs7b4RD1yxjwJAHsfhCZCAmrTZhx6g7EU
        99R8gkI7dJD+CkHvthu80aSiid1aIS+apifxG28=
X-Google-Smtp-Source: ABdhPJxDUtDkhHtkqwhq4HY8M/nWiY/fsbrbIXC4HEmYrBR2T4oIo8B1Gv3zIv6X55ZAHTGyTenpahian5FNO7Ri6AA=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr19166666pjq.228.1592837057666;
 Mon, 22 Jun 2020 07:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200622103817.476-1-nsaenzjulienne@suse.de> <20200622103817.476-7-nsaenzjulienne@suse.de>
In-Reply-To: <20200622103817.476-7-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 17:44:05 +0300
Message-ID: <CAHp75Vcpo49BUe+cApfbB2BXFLz0SyLjWkO_6Uw=sYEcJEBMPg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 5:26 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.
>
> The initialization of Raspberry Pi 4's USB chip is now handled through a
> reset controller. No need to directly call the firmware routine trough a

trough -> through.

> pci quirk.

pci -> PCI.

...

> -
> -#include <soc/bcm2835/raspberrypi-firmware.h>
> -

Leave one blank line here.

>  #include "pci-quirks.h"
>  #include "xhci-ext-caps.h"

-- 
With Best Regards,
Andy Shevchenko
