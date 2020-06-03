Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3631ECF10
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCLv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCLv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 07:51:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5EC08C5C0
        for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2020 04:51:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n24so2293191lji.10
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2020 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdBB5hfXeMUbxEadj8HyXcRzRwZM+PPwSB4AAz3DRGw=;
        b=mI5aPFlm4k8KFAD/9YB1eDbVdeziZR/ErHPbp/wRCC8wXXF+CZyztaQ4Kk/vvYyuBJ
         HozI4UzdsNGaqHg4MJhQmWRdoOvBD5r5yexuyUa3ee5i2E2ZwGKIFPP1wy5iCV97459W
         fT9k1KSus2StCFqzxCGTAqFVk1HXRXWRXSbnF8FBqrv+JuDh0KzhFwnq6CLrwH2iN9E0
         wza4bf3IOPqxJCvH+mtlBd4SCduGmeCciSI4X4oeaVDYAdsLCH1enJG/8vd1vH3f3JEu
         ZG4XXt/RJzF5PgH9pftNeFs0E/agvaR6f3P3h9TIV3dguN8ypGKrwWmhoZnZvS6VVhAA
         Faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdBB5hfXeMUbxEadj8HyXcRzRwZM+PPwSB4AAz3DRGw=;
        b=DYgoG2jpyjRD7hyxqVLUe9HYFzebl9/QmLrs4z0h69leZEVxvQFPwkDyrGt4izTZnb
         ZinvEyR5NQaXP/umzW06OG/iy4LjthLG2RHDNhkrh66UoZ211I96Vmhln/Pi1JoY9r+b
         WIcoBnK1ErcSpfnC1RFiTp26u8tgS5CVJcPp8LzchL3qXBmiIjcp9wjHXubUf6v0qtmW
         XZgFekuRlnO2ayAWD4cIAxAjotOmcF1XfhIrxWSpyWzfk/9Yprr83lZj3wdjabmv2WHd
         k6UU7HcQvhc8YiI4UP49Z8xdupVjN4hrnMjq7hg4RrEYgasgT6HTk89yvvUqZjPcxkGW
         n/KQ==
X-Gm-Message-State: AOAM532y4bDibUVF82XUD6maZWqGCG7nMLpuV4EmfBCpDP5mV9xCSblM
        njLdIJXjjmVJck3aoU0iiLtMNgYnW8c0pLHrSnSjnw==
X-Google-Smtp-Source: ABdhPJyf5ID0wFLZrpBtkoD4Bbg02jpPZv24wGHOaCOu5JUKLGvhg2+QXOqH5CyRdbH2HtcXK+IXsJLgkB9JGLk0PJM=
X-Received: by 2002:a2e:8554:: with SMTP id u20mr1865102ljj.188.1591185115803;
 Wed, 03 Jun 2020 04:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com> <20200603060751.GA465970@kroah.com>
In-Reply-To: <20200603060751.GA465970@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 3 Jun 2020 04:51:18 -0700
Message-ID: <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

>
> > Thanks for the pointer! I'm still looking at the details yet, but a
> > quick look (usb_dev_authorized()) seems to suggest that this API is
> > "device based". The multiple levels of "authorized" seem to take shape
> > from either how it is wired or from userspace choice. Once authorized,
> > USB device or interface is authorized to be used by *anyone* (can be
> > attached to any drivers). Do I understand it right that it does not
> > differentiate between drivers?
>
> Yes, and that is what you should do, don't fixate on drivers.  Users
> know how to control and manage devices.  Us kernel developers are
> responsible for writing solid drivers and getting them merged into the
> kernel tree and maintaining them over time.  Drivers in the kernel
> should always be trusted, ...

1) Yes, I agree that this would be ideal, and this should be our
mission. I should clarify that I may have used the wrong term
"Trusted/Certified drivers". I didn't really mean that the drivers may
be malicious by intent. What I really meant is that a driver may have
an attack surface, which is a vulnerability that may be exploited.
Realistically speaking, finding vulnerabilities in drivers, creating
attacks to exploit them, and fixing them is a never ending cat and
mouse game. At Least "identifying the vulnerabilities" part is better
performed by security folks rather than driver writers. Earlier in the
thread I had mentioned certain studies/projects that identified and
exploited such vulnerabilities in the drivers. I should have used the
term "Vetted Drivers" maybe to convey the intent better - drivers that
have been vetted by a security focussed team (admin). What I'm
advocating here is an administrator's right to control the drivers
that he wants to allow for external ports on his systems.

2) In addition to the problem of driver negligences / vulnerabilities
to be exploited, we ran into another problem with the "whitelist
devices only" approach. We did start with the "device based" approach
only initially - but quickly realized that anything we use to
whitelist an external device can only be based on the info provided by
*that device* itself. So until we have devices that exchange
certificates with kernel [1], it is easy for a malicious device to
spoof a whitelisted device (by presenting the same VID:DID or any
other data that is used by us to whitelist it).

[1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html

I hope that helps somewhat clarify how / why we reached here?

Thanks & Best Regards,

Rajat

> thanks,
>
> greg k-h
