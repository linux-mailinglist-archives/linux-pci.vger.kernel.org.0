Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26C2AFEB7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 06:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKLFjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 00:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgKLEs5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 23:48:57 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C5C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 20:48:57 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id t191so4246511qka.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 20:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYgDvr1bBvi/7JL23Rwf3pvljbbY3cllWNL7cd89QBU=;
        b=n4uJK/AjV+JPQY9fOrfKFQbdBnf8l8LzV+NbtoXlSxdL2NsiNlwwQ7d//d2y/tL+0g
         ogBQxQT3LQwKo//MiTsd/HTMJlvfMUPdN6a0HNm1OeWr4hVS0JlwCR/TY/15X9asl12G
         9JazjKX72wd9PxK8qiweL44aZeRlGQN+r080fp8nLf3qu9CTqgtTD2nsr/8rMkQ1bj6x
         ZrplJDI1WqzjHBMHL/tCMycfLhRaHCXLQ/y5sHIkjhQH9Sg6qGwO9J1FqjlgI2B02CDZ
         hdrs4dH9+12PsGegxm3kOYKbwAGQZL7vopJo5HNis4+ae63xeuqIWosHfQndQ0SmUMJ/
         zlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYgDvr1bBvi/7JL23Rwf3pvljbbY3cllWNL7cd89QBU=;
        b=ljEMWAuKt7S8asV+4Dgk3NA0iRjA7Xu2PhCGxo40DYEuzaqYlAoehgPCabz8xD8QRf
         0GUFg0uRetuF+egBwyYa4Ck8hCyaZy778XArNLJ5dWizY528H3iGA21u35iDnl9eK9x3
         JnRDp0tu7giruw/3KLcl0AH4Ls2suGiy2uUtp0IOOChWoO1yiankzGRrgEkxF4kEGB/a
         dKCGzgFgoGGRIZHQBMa/dPNfW/wgCvM+MWbfkly/SiE7jlf5a1U342j/F4Naf7C5QQNb
         sUeoQp1aVS3lUIv1fFLzyapvpRbv5YF3t8t4Uxm6mbRq0t2QrQL4FoWI2ExFJ7ir0x1u
         UXgg==
X-Gm-Message-State: AOAM532kr4tNURrWfs9T+k/wahidPIyAdhkMtYKjl4SBGDbV1G0di72N
        54ss4NnTRj9prFS8HFkEC4vIeH8DYay+3QWh+74+bZxsqwM=
X-Google-Smtp-Source: ABdhPJz1kVjQNKWJb1wwo5p1LP8acl5WsO3zCvVoeptYH5O98z9el6DfmmMYkHMhnz1ABWtwTa1GsIXrM706qWOXm6E=
X-Received: by 2002:a05:620a:c9a:: with SMTP id q26mr26159221qki.272.1605156536155;
 Wed, 11 Nov 2020 20:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com> <20201111070528.GA7829@infradead.org>
In-Reply-To: <20201111070528.GA7829@infradead.org>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Wed, 11 Nov 2020 22:48:43 -0600
Message-ID: <CAL5oW028rM75b+ROd09PkP9Q7FUdKQNJFTVmhC=m8CoRRuH3Fg@mail.gmail.com>
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/2020 1:05 AM, Christoph Hellwig wrote:
 > On Tue, Nov 10, 2020 at 09:37:35AM -0600, Stuart Hayes wrote:
 >> +Date:              October 2020
 >> +Contact:   Stuart Hayes <stuart.w.hayes@gmail.com>
 >> +Description:       If the device supports the ACPI _DSM method to
control the
 >> +           PCIe SSD LED states, ssdleds_supported_states (read only)
 >> +           will show the LED states that are supported by the _DSM.
 >> +
 >> +What:              /sys/bus/pci/devices/.../ssdleds_current_state
 >> +Date:              October 2020
 >> +Contact:   Stuart Hayes <stuart.w.hayes@gmail.com>
 >> +Description:       If the device supports the ACPI _DSM method to
control the
 >> +           PCIe SSD LED states, ssdleds_current_state will show or set
 >> +           the current LED states that are active.
 >
 > Is the supported file really required?  Doesn't the current_state one
 > also show which LEDs exist?
 >

The current_state just shows which LED states are currently active, not
which
are supported by the system.  I guess you could try to set all the states in
current_state and read it back to see which ones went on to see which states
are supported, but I'm not 100% if that would work, plus it might result in
the drive LEDs flashing in a strange way briefly.

 >> +config PCI_SSDLEDS
 >> +   def_bool y if (ACPI && PCI)
 >> +   depends on PCI && ACPI
 >
 > We really should not default new code to y.
 >

Good point, I agree.

 >> +   if (dsm_output->status != 0 &&
 >> +       !(dsm_output->status == 4 && dsm_output->function_specific_err
== 1)) {
 >
 > overly longline.  But to make this a little more obvious, maybe you
 > want to
 >
 >   a) switch on dsm_output->status
 >   b) add symbolic names for the magic numbers
 >

Good feedback, thanks.
