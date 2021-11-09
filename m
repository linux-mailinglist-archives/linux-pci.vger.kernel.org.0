Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8344ADB0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbhKIMp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 07:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbhKIMp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 07:45:26 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AD0C061766
        for <linux-pci@vger.kernel.org>; Tue,  9 Nov 2021 04:42:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so30662416ott.4
        for <linux-pci@vger.kernel.org>; Tue, 09 Nov 2021 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=aDBWIiucwrR4twJxh1j09QBuXMtg+nFBsnO8yfr9inGfJNrTSt1egY7oqGSmhTfuwC
         vcaz3Sx1kbHlilCeGj3PMg6oXqs9z06/rThvqWJFf51LG1gitCUprW69S/+skNQV7nql
         CvQSW0VaO6vlINcuTpU/d89xxxnnJ05lBil0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=PINTkdbXHL9o6UeED9DqmPgrjgtbQxAJSLwQq8+jWIUtd+1vVQe5UUb9+/pxZ2MEDa
         F8VpW6cl+bKD4udko9UH44GERKQLa8qQuBnCO7zLvbMK3q3I1fj0TI54O05qiNx9aVlm
         hCpolNw/YRfaGmG01wG3qwKcaxfuxGcUT+mYWIOi6kECSj7mcTtDjVJyqjlX/zq+8isj
         Ql8NIcDogCDB/dHs8jHELJaUCEIJQovWXd6sgK+W9Ez61rzl++CNA2brLjTU4Eu3odpX
         zPIRaaaZkCbdJP3SRCl2K3NwItTBozSaZ3gt9KHDL+bAtuvZ0PFVt+T4ZmUhrWu5BmSX
         YJ6Q==
X-Gm-Message-State: AOAM533BQc17uSQCKkGl14k0xdsGUGGNjLqSOEy37uOyxlLacILwtPcb
        lUfPOKpK0++7EaQYxp3wlizTcHntGjFi9NoYZqXwKA==
X-Google-Smtp-Source: ABdhPJy38nhRcMBXJpyq2S4dQ2zU3L9V/AZ8XtKJjs2aut3JvHhtudp4KIav7A/3isAEGLGD8gW0FtdtOdnqCmJmD80=
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr5661303ott.62.1636461760200;
 Tue, 09 Nov 2021 04:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20211108212226.253mwl4wp7xjckqz@pengutronix.de>
 <20211109025619.GA1131403@bhelgaas> <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
In-Reply-To: <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 9 Nov 2021 13:42:29 +0100
Message-ID: <CAP145pjO9zdGgutHP=of0H+L1=nSz097zf73i7ZYm2-NWuwHhQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Also, this might be unrelated, but the following happened around this
patch (ie https://github.com/torvalds/linux/commit/0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4)

I sometimes run Win11 under qemu/kvm/vfio (gfx card), and it stopped
booting (even with the latest patch for pci). Another Linux distro
boots fine under the same qemu/kvm/vfio, but Win11 stops at the boot
screen.

It worked well with 5.15.0 and a few PRs later - with the git tip it's
not booting - and it works well with 5.15.0-rc7

Maybe related to pci/vfio changes, maybe not, just leaving it here for
track record. I'll try to debug it a bit.
