Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDE389682
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhESTVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhESTVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:21:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12BC06175F
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 12:20:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so21514622ejo.13
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZTVmwpnlwJk3q+dqnl1uoJR23ZTrquT34/lklTUmQM=;
        b=oa95qayqJeznuxVvd7slQCeIUqrYjiIZts2NsfJaYIVvuK6xYGVwhshMMF6JMFdxK9
         dPWrKavPKXSO1qJWw1dwqcIvlrazCPnvTCAienQE0n6+2JO2c7QU50HU0qVQXHeBT3W1
         RN5uIXr6+Pyybomrr/CigZmjB6LCqt4JiU+A82of7XwBql99QOlTQu9dqPMRy3OGGWMi
         +Mfy8/wP+UdHimuz3gJG9JUXlw55bAX64wL/RFxhzyZ5E7rnkDtk6pbm9cCGpBrh/6fP
         hRH5wbXxFNFwAIUl0p7GbAUDzjnziuLTYDHFxrO6/Yo0DM8AeohT3TNJ1U/w5gxQRoYQ
         63yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZTVmwpnlwJk3q+dqnl1uoJR23ZTrquT34/lklTUmQM=;
        b=cXZNVRFMcrFtugXrROcoOITyReIROVLi0TlcpVKBqFnCM3wkcUR6NgxLPz2Or700ns
         QhlmODAFZTXV+m3DtKfXu0WEhkogXsH3qx7N8mBIjXCfJjJpPqQzaa8nJrmDgiszggFr
         vsYLGb10vZj2/IL4xrWDFNwHcP3v+xXGmA521AxQi6d2Yearra7AnZmLtYij5PWnw7Qk
         0Wx+WkcE1lZDQQH0Oco/AeTKR8a+iaq1xK7ZoCr19gAv8ZX/OeU/m48iajpGOUp1NIhL
         g4xhV5aVY/L4NFHs+HtbC8h/8D3/mvdrBa2ebpXk7jdogA4mcI+trNJ6YrnYluBF8fQR
         ipkw==
X-Gm-Message-State: AOAM533XnnkvQg1U6teZbuNb11ht/lKIuGdlLdYoP6GM7DkDBxQG5+Eb
        FL9UXkBqIV9Ut4A0QUTOYgSM/JLV1q5i4XU9AsA3+w==
X-Google-Smtp-Source: ABdhPJwqOQrlCZg0awAR1a1BUWi3Y4xD0KvYxlxX0nXEhyIT8srkTX+UW1Arz5DDuf25QNzn3NZm4fmbgtr6+/UcLE4=
X-Received: by 2002:a17:906:110d:: with SMTP id h13mr697747eja.45.1621452028040;
 Wed, 19 May 2021 12:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com> <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com> <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
 <20210518110403.000013e6@Huawei.com> <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
 <20210519161156.00003bf9@Huawei.com> <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
 <20210519172052.00002124@Huawei.com> <20210519173352.000026fe@Huawei.com>
 <CAPcyv4gUy0nNh-3y2wWVwM4AtO4F8OOJCtWz_ZH7Eu0H=oymuw@mail.gmail.com> <20210519180057.00002ac3@Huawei.com>
In-Reply-To: <20210519180057.00002ac3@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 12:20:17 -0700
Message-ID: <CAPcyv4ii3KC6MBBxJrnCUCm_JGS7ugL+JTFUu9QTBnPUhQFtfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 10:03 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > > "The DOE Busy bit can be used to indicate that the DOE responder is
> > >  temporarily unable to accept a data object. It is necessary for a
> > >  DOE requester to ensure that individual data object transfers are
> > >  completed, and that a request/response contract is completed, for
> > >  example using a mutex mechanism to block other conflicting traffic
> > >  for cases where such conflicts are possible."
> >
> > I read that as the specification mandating my proposal to disallow
> > multi-initiator access. My only mistake was making the exclusion apply
> > to reads and not limiting it to the minimum of config write exclusion.
>
> Key thing is even that isn't enough.   The mutex isn't about stopping
> temporary access, it's about ensuring "request/response contract is completed".
> So you would need userspace to be able to take a lock to stop the kernel
> from using the DOE whilst it completes it's request/response pair and
> userspace to guarantee it doesn't do anything stupid.

A userspace lockout of the kernel is not needed if userspace is
outright forbidden from corrupting the kernel's state machine. I.e.
kernel enforced full disable of user initiated config-write to DOE
registers, not the ephemeral pci_cfg_access_lock() proposal.

> Easiest way to do that is provide proper interfaces that allows the
> kernel to fully mediate the access + don't support direct userspace access
> for normal operation. (treat it the same as an other config space write)

Again, it's the parenthetical at issue. I struggle to see this as just
another errant / unwanted config-write when there is legitimate reason
for userspace to expect that touching the DOE is not destructive to
device operation as opposed to writes to other critical registers.
Where the kernel's legitimate-access and userspace's legitimate-access
to a resource collide, the kernel provides a mediation interface that
precludes conflicts. Otherwise, I don't understand why the kernel is
going through the trouble of /dev/mem and pci-mmap restrictions if it
is not supposed to be concerned about userspace corrupting driver
state.
