Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20CA39258A
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhE0DpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 23:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhE0DpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 23:45:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C97DC061574;
        Wed, 26 May 2021 20:43:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so4007297edr.12;
        Wed, 26 May 2021 20:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnZq+n+gp23G19nG+lOoSxanxr/9NKSMMQJp+1JiGZg=;
        b=Zkw0EaT+4+Aq1hEEXu7KywR45D4+dOXE6EIiVjlfCpy2F5BS81MKUCKOmfUWs7YusB
         RhuRzR/qtFGMZ2ao8NXhLY3XETukK8DbKA1lJkvlLZ7NfYN8Zl6GzYF9BObEE1P/OHcR
         hDt6oqISKG336THMkogyOWb5ISZpAJHt16mHkWGJki9jqQPIJqbPy+Pho5yTTiE6/Ujl
         IqWwd/w4YltWmAuKLpmbe9wC1nzGto4FaWr0LBn6LljDuEX6zEuuvuMzWNE8NLiw3Nim
         ZN8HkPLbLPETxBO9NRpq1pgt6YhGr12zCpybCcR+3M7/UumOf/7x36WAw0Bbghe0M3iB
         uZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnZq+n+gp23G19nG+lOoSxanxr/9NKSMMQJp+1JiGZg=;
        b=J2FIts5HLOBBe+359+ptL7yPnkVDJqqDXWwpiCqc7WO94mLC3+b8VJOCN2vNkYo4a1
         FzUslKlSsW4otZJHSYHM/VFptBlFxKYRip1IvQVwmW+2ZDspAg1btq3i8Rj4AerDy7cO
         pCEWWqJ26bgHaz3F+lyqH8ULahhSoYhP3GOmB7PcTiXenIes8cYg5rMyotLSwpH4VngP
         wPKhAen0+cMRhiHJv9E7gwOKOHT31gd13cvr2zKBAneH4zPqVbMTRjFOC9owFk00MqIv
         yq9EUSBg0tQmS/NazJJ385NfM7WMkP8C5MGHA3sRfuTCrOuQx3MyXoK/Dq7UR/hyY4D4
         oDVA==
X-Gm-Message-State: AOAM533IB6nc8MDmlahTtFlWJPvaDKuSzCIEcXZdj1oGMvRu69FB0v5D
        C9sFBK0LwuDlgkEbCw+tC+nexrGszuIqnaI8dmo=
X-Google-Smtp-Source: ABdhPJz3m1xWvxLhojfoUpwC4+hwhiYwDbNnEhI/KtnbEkJVDgWtcCDD3bPJrI53FI/xKkI0NraEkIyurMncPtHujY4=
X-Received: by 2002:aa7:c441:: with SMTP id n1mr1748739edr.6.1622087016202;
 Wed, 26 May 2021 20:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
 <20210526162306.GA1299430@bjorn-Precision-5520>
In-Reply-To: <20210526162306.GA1299430@bjorn-Precision-5520>
From:   Lambert Wang <lambert.q.wang@gmail.com>
Date:   Thu, 27 May 2021 11:43:24 +0800
Message-ID: <CAATamawK53+XvZ+FV_1-Td9iFZwHeLX1O+PzCh01twzNAyRZHw@mail.gmail.com>
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 12:23 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 02:12:38PM +0800, Lambert Wang wrote:
> > ...
> > The user is our new PCI driver under development for WWAN devices .
> > Surprise removal could happen under multiple circumstances.
> > e.g. Exception, Link Failure, etc.
> >
> > We wanted this API to detect surprise removal or check device recovery
> > when AER and Hotplug are disabled.
> >
> > I thought the API could be commonly used for many similar devices.
>
> Be careful with this.  pci_device_is_present() is not a good way to
> detect surprise removal.  Surprise removal can happen at any time, for
> example, it can occur after you call pci_device_is_present() but
> before you use the result:
>
>   present = pci_device_is_present(pdev);
>   /* present == true */
>   /* device may be removed here */
>   if (present)
>     xxx; /* this operation may fail */
>
> You have to assume that *any* operation on the device can fail because
> the device has been removed.  In general, there's no response for a
> PCIe write to the device, so you can't really check whether a write
> has failed.
>
> There *are* responses for reads, of course, if the device has been
> removed, a read will cause a failure response.  Most PCIe controllers
> turn that response into ~0 data to satisfy the read.  So the only
> reliable way to detect surprise removal is to check for ~0 data when
> doing an MMIO read from the device.  Of course, ~0 may be either valid
> data or a symptom of a failure response, so you may have to do
> additional work to distinguish those two cases.

Thanks for reminding.  :)

Yes the check has race conditions. When the driver is doing recovery detection,
the check result is not reliable.

It is pretty useful when the driver wants to confirm if the device is
absent *after*
the driver finds it's not working as expected.

>
> Bjorn
