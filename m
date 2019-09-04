Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B72A8D5E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfIDQro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 12:47:44 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33679 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfIDQrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 12:47:43 -0400
Received: by mail-io1-f48.google.com with SMTP id m11so13715557ioo.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFnr7zgJe+61oG4oqxymDnM4izKIkBVQkyb90hB3S+I=;
        b=iIiZLF14sOBStDzF/zd5qvQJo3HPHJzWwvCAMo/xC62V6+aBfDX2kCYoBGGFUL3io9
         mWteVTYIKwVmcppcgjI1Gz1JAjVVCiH8X54EIkWjj6U27wYnJiIYrUt3pXw9gVP7wPn/
         4tuIZY8AfhSpnphPjvx4Hgk9KszlkdMQOFMlLTO2Ebh9fCM+JJRVD6JJgeiTgVNJqYQa
         JR8hQpqmlmA+DIrPW9H61r1U6ESB3m1BaWvc1rcuGx7tUZlmPqVnJO9VdyK1rpiMSxuY
         FVQxbLlmDI5xjHezuh8ZT8KOGWtLHQUqteGreVrFv/CpWVoh3ir59di5coFcOFJIy+Zh
         AfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFnr7zgJe+61oG4oqxymDnM4izKIkBVQkyb90hB3S+I=;
        b=CQ+tHHFU58SIJvEDbFMhe+BOpEuiDm68W/fONUEKllJAbqzo4eZDpGzfKVO7Fp9TNL
         lfvebH+4GPWv0u7akaVsW7J3WS0CZxX63PMpSgoakWmFzqAVfS6t9aF+nEqQjEzrVnyN
         N87L963hmGCeXSxNlmlUf303Tfv/66cwfAGUfIn9++t4+CN4SYlneJAE4gQvrS0KJgeY
         rrtBqSAqc5oPAKaE14Vv0pmVeSNSm6D0vD8QD8AWLJNAdu5slkbaoEvH/Qesozn51eQj
         fEgStJmOeDKOZA4vhipMUjdqdfyWn7SxBPlkb9i6szJQ46dBsPAMGLc6qxVK8iH8l+94
         W5og==
X-Gm-Message-State: APjAAAWa3+6R3nuOhgttiVZgj8xNCgBTGLhZs6wl4j7qqFdRGkbHiqF/
        kwU2glamKgbo0hnQig+sdiG1h0Hm6G8udZPhtKHa8efCu7w=
X-Google-Smtp-Source: APXvYqxSl27LcKurdt2fQvWY+lSxjaoKv1CHvidnAFxG8QO4wPpbzVxnVi7kqXp7e40rk4a0QrrOJkCYYK+1aHl5iSo=
X-Received: by 2002:a02:6a17:: with SMTP id l23mr5941298jac.102.1567615662334;
 Wed, 04 Sep 2019 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <cf90a8aa-536e-f4df-0b2f-60724e4034fb@mev.co.uk>
In-Reply-To: <cf90a8aa-536e-f4df-0b2f-60724e4034fb@mev.co.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:47:30 -0700
Message-ID: <CACdnJuumhcFw2394J-ymAq1VVAGXpknhdd1T8x565pcU6eAU-w@mail.gmail.com>
Subject: Re: Should PCI "new_id" support be disabled when kernel is locked down?
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 4, 2019 at 9:12 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> Hello,
>
> The "new_id" PCI driver sysfs attribute can be used to make an arbitrary
> PCI driver match an arbitrary PCI vendor/device ID.  That could easily
> crash the kernel or at least make it do weird things if used
> inappropriately.  Is this scenario in scope for the "lockdown" security
> module?

Crashing the kernel isn't really a concern - the issue is more whether
it's possible to get a driver to perform a sufficient number of writes
to a device that it can in turn cause the device to overwrite the
kernel in a controlled manner. This seems theoretically possible, but
I think I'm inclined to leave it as is unless someone demonstrates
that it's more than theoretical.
