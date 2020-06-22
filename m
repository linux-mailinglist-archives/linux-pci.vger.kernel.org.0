Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F402039C5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgFVOmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgFVOmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 10:42:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DBC061573;
        Mon, 22 Jun 2020 07:42:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so7653946plb.11;
        Mon, 22 Jun 2020 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YLaWFLlIzBRLs4RY6djpcyNOYh8PB7BzxpoYxS2lEM=;
        b=spfR+u2xLXtkMNRBWgq+InK0f0X0wRn2Gqp1Ccoi8UHaSQI1UkQiuHQ5EpWDpSy0zr
         NrTwLCKwidJW2ES+yzW6UyTOSxxn+Ra5mqQJm40G3tNWE0jrnggX4349AHin0Sg5G8UH
         BpYoqtScJgu7vBEWkUkDqzOmIZx//ptLQI+2VzEM8/akwN7SFknGAv4mhT2dpd5ZMJdD
         HXkx031RwB12EzIy6U800fuoQQCaqw4ofyv/jeThviWnYdbWWq10ZZm9iSiWrbN/1Vjp
         9YjK2RzNoYXAYK2yUgQzA2p/oO+TvVyxUWXjPyev7NGuEiQXPEhZDfx103v89ibeql+9
         AP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YLaWFLlIzBRLs4RY6djpcyNOYh8PB7BzxpoYxS2lEM=;
        b=N70pNyspdm9/ZSv2+BfxQV3mGxeQNaFfC8bzH9gSx2lj8q8F85x9AIH0il/erflyMn
         yp4Pewge2sXLtUWjRBrDNflpt+lLaL1GxK6F47EnJgyR0ZY2VZpE9+ab41NP6ST+Zo1W
         Ot1by/CxrZRi79cFJvvzcEpqUlhHsNvam1pNUcDht2hmCGI0e7XQO4WxrIfx+l/qk1yT
         Stjd8eRCbkBFYZ3AapXjc9OeatakxWWMFVw07ni3W3qSyZ/sE18waV12EGwwdBkPLB9v
         Lm6CJ+tuGdsrudeXe3Q9HSNwX5xk0RCWTIS6HpCoh+PLxzcVoyovY+XPCKBa/5QPv6xz
         bdHQ==
X-Gm-Message-State: AOAM532V3UfAytbJJW8WGJD7qnObiLoduMsgKVd0rqzWChAq8yfOxhlb
        H3GVGz0sB56t2pKop2/QJqHtYVbVnmbVb0jzNw4=
X-Google-Smtp-Source: ABdhPJwnb91qMbXzVIPFIU6C/Ry5merVXS0V0FxZ1cMSh9l3XgYYN3BXfY2F+Z5mKnXzLMpQ9BNbCOqOdqX6V0uaOiw=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr19958374pll.255.1592836944732;
 Mon, 22 Jun 2020 07:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200622103817.476-1-nsaenzjulienne@suse.de> <20200622103817.476-3-nsaenzjulienne@suse.de>
In-Reply-To: <20200622103817.476-3-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 17:42:12 +0300
Message-ID: <CAHp75VcGoK=6FitfuzEhPZXSrtJiO_-XcD6jtg8SckprWhePgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] reset: Add Raspberry Pi 4 firmware reset controller
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
> Raspberry Pi 4's co-processor controls some of the board's HW
> initialization process, but it's up to Linux to trigger it when
> relevant. Introduce a reset controller capable of interfacing with
> RPi4's co-processor that models these firmware initialization routines as
> reset lines.

...

> +       struct device_node *fw_node;

If you are going to use fwnode (as it should be), make sure the proper
data type is in use, i.e. struct fwnode_handle.

Otherwise, if you want to be OF centric (I discourage this, don't know
if RPi4 is ever going to run RHEL or other distros that require non-DT
firmwares), don't name fw_node. It's confusing.

-- 
With Best Regards,
Andy Shevchenko
