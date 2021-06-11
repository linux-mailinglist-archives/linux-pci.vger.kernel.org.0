Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7D3A3844
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFKAKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFKAKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 20:10:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2473FC061574
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 17:08:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so7447743wmq.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/eAP35ITcmNnovetpDKG7r6EeGDs7ZdC3jfVQVGgeI=;
        b=cTDCaEk4fjCh+e1guGKETRlqQsfo5Xt8zgweSTKLUen4ooyHvrwvYZwYcI43W4zhek
         NlYaaSegvVjD6wTz1ew3COpbt8WQ01dWwxsRyIA9qulwOFPmAQ4QSyWEuQjx/sTM2m0S
         OBqO8AfRcoGxd3a6Q3oN7uJ9mjji8IrHt5PxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/eAP35ITcmNnovetpDKG7r6EeGDs7ZdC3jfVQVGgeI=;
        b=hVu4a4fj6EIslNzkh5mE2l+me/fZgoctCoPjNAfYqYzvPW5gkue2S4UjCnbE1D9Vj6
         1DG/JqVI0Gfy0j6EdNoqTNty/QJXdM8i3zdvcZ4LpeOE/cWQaA178avm1U0TZxTQwQTA
         9RqXqlGcWGtRYQpc6WHiBXtIbavK6fUL7F+7e7zEY1JYApZlNn3oy2Jm7045s2j+W7Do
         TqXg+jsQyggRwU7d4E7RE2/MugNinLeB7PpsQiiM1dkMkIm3spK4iLg03rrgRnBBVvJH
         EJmRmitplhz1e5CZqNF3XtGeQ3MwGAO8u516sXpe3uCX+yeIl83YLbquoYVz51HH26l7
         i5fQ==
X-Gm-Message-State: AOAM5308kwViE/jlTzOX5zd5KftbiiXniq8dggvMfE4FRMzXK8FcUkPo
        Ra7bhaNNjWf9O3F38qbBQZicxSkQp0kxjBzsTEW0hQ==
X-Google-Smtp-Source: ABdhPJxYdeL+TC3eAAcOQXRiEMybJtC95iQnOTxZma3aQtWxYf0cDRMdRsRISvBCURzMlPQMymIPQNr7h6VJZ1pTQMs=
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr17919456wms.150.1623370107601;
 Thu, 10 Jun 2021 17:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu> <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
 <20210608185314.GB1812516@rowland.harvard.edu> <960057be-ef17-49e7-adba-ba2929d3a01f@lwfinger.net>
 <20210609021237.GA1826754@rowland.harvard.edu>
In-Reply-To: <20210609021237.GA1826754@rowland.harvard.edu>
From:   Ibrahim Erturk <ierturk@ieee.org>
Date:   Fri, 11 Jun 2021 03:08:16 +0300
Message-ID: <CAFHYy-iMty-jjZzgzRA6tOezN-RJ+o4hRL1kZk+tuN1i-K9Ukg@mail.gmail.com>
Subject: Re: Strange problem with USB device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I've already attached logs and a snapshot from the device manager on
the windows side into the bug report. Hope this helps.

Regards,
Ibrahim ERTURK

On Wed, Jun 9, 2021 at 5:12 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Jun 08, 2021 at 03:56:11PM -0500, Larry Finger wrote:
> > On 6/8/21 1:53 PM, Alan Stern wrote:
> > > I don't get it.  If this is a PCIe device, why should it appear
> > > on a USB bus?  Wouldn't you expect it to show up as a PCI device
> > > on a PCI bus instead?
> > >
> >
> > I do not know the internal details, but Realtek packages a PCIe wifi
> > device and a bluetooth USB device in the same package. Intel does the
> > same thing on my Wireless 7260.
> >
> > My lsusb shows:
> > Bus 003 Device 002: ID 8087:8000 Intel Corp. Integrated Rate Matching Hub
> > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 001 Device 002: ID 8087:8008 Intel Corp. Integrated Rate Matching Hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 002 Device 004: ID 8087:07dc Intel Corp. Bluetooth wireless interface
> > Bus 002 Device 003: ID 0bda:c822 Realtek Semiconductor Corp. Bluetooth Radio
> > Bus 002 Device 002: ID 04f2:b3b2 Chicony Electronics Co., Ltd TOSHIBA
> > Web Camera - FHD
> > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
> > I have no devices plugged into a USB port.
>
> Okay, now I get the picture.  The Intel PCIe card contains an
> EHCI USB host controller plus a couple of on-board USB Bluetooth
> devices and an on-board USB webcam, in addition to the PCIe wifi
> device.
>
> Which means you're looking at the problem all wrong.  It isn't a
> USB problem at all; it's a PCI problem.  Namely, why doesn't the
> system detect the USB host controller on the PCIe board?
>
> I have added the PCI maintainer and mailing list to the CC.
> Maybe they can help shed some light.
>
> The original Suse Bugzilla report:
>
>         https://bugzilla.suse.com/show_bug.cgi?id=1186889
>
> shows the Realtek board at PCI address 0000:03:00.0, but there's
> no mention of a USB host controller on that board.  The only host
> controller on the system is the one at address 0000:00:14.0,
> which is xHCI and is directly on the motherboard.
>
> Furthermore, there's no trace of any mention of an EHCI USB host
> controller in the system log.  So maybe the board has to be told
> somehow to turn that controller on before it will show up, and
> the rtw_8822ce driver isn't giving the appropriate order.
>
> Can the bug reporter get information from Windows about the USB
> host controllers, and in particular, the one on the RTL8822
> board?
>
> Alan Stern
