Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6652B3D82
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 08:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgKPHIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgKPHIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 02:08:47 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BAC0613CF;
        Sun, 15 Nov 2020 23:08:46 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so18964017ljf.2;
        Sun, 15 Nov 2020 23:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiSVixBzWFRrc5F0VIHSOyW+ZLBve41qKR5fsnIR0cc=;
        b=kp/kq64MevP2otQ4mOzUUPbmumwm/olcWFs2tn8XQ25HbaPVfWe/CRo0+hTXfxuBZy
         3YQE2ojPjuOKYD0KuwRi/vd6qgB0GylXp8BlPmGZLiBObFxBI7MSMM2pwqCWlpZAO7LC
         N84PGHgBxMTmZbUyOzojdzRVoneUyYZxgZq1GpBgPo3BIQDswb7Yglq6l2IW+F9X90NP
         4HZ1Wm210Bm3hUBnXL+Gh3j/ZzsT5U6MTl/SAkOux9sQ2GqSkCATk7KWioFCBwwAc68V
         st/KqcMttugibCjMluGI3b64OIMSRtEx4ydhrZ21sPpHyCk2AjMvpULRTyMKaDc5trQv
         HCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiSVixBzWFRrc5F0VIHSOyW+ZLBve41qKR5fsnIR0cc=;
        b=fsFrkuLdf9ijdPnENU2/LnU4rayVW8h3aILtEdDOb4aJV2K+dAv3yTHqVdeYSqWUKE
         oJdmNuhcp29WWJBmrPebR0jN5H9e702E2tTirEX8lDhURdwOoraomnSWFNgo2QXWZZrs
         p1wDaO+ItT2ZzipYQwxdcbXoCzk0ZXAi8OZVF/OTuiAV0ZUlh0Zo6REm+z2oPiuCYxgw
         LwqZQ2tUNJP76TwZohKtmXHYiPdoa+ybofptuulZ1+Z8jI8WXFHNwKKtSU7YfivBpVeB
         C0mfmNdlqJRsDYUB6Fi5hme9/tXNG0geDatkPRguSbewTHiJQtmgfCehbRb+cSa4i8S3
         LYag==
X-Gm-Message-State: AOAM530VzNgnL0arbDSwvdV42d/2pfWDppBo7pbcYikp6a75XTgQV9s/
        vZqGZ1bHe7CAk4p9iliC+m88CCJQ017CjpyG558=
X-Google-Smtp-Source: ABdhPJw4dMUsVH/zA8fDWR3XLDojnnHfwl/Scr8jxyVncyS2oZX6qzh6nwR375d2cINE/xjokB9mR1M7hYtzJvx7BkM=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr5151725ljh.209.1605510525308;
 Sun, 15 Nov 2020 23:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20201026035710.593-1-zhenzhong.duan@gmail.com> <20201113224723.GA1139246@bjorn-Precision-5520>
In-Reply-To: <20201113224723.GA1139246@bjorn-Precision-5520>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 16 Nov 2020 15:08:26 +0800
Message-ID: <CAFH1YnMV2b=HSNU838vaN+MrSCa-7L=HWXOhwpafbe6B9Ysopw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: check also dynamic IDs for duplicate in new_id_store()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Nov 14, 2020 at 6:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alex, Cornelia in case VFIO cares about new_id/remove_id
> semantics]
>
> On Mon, Oct 26, 2020 at 11:57:10AM +0800, Zhenzhong Duan wrote:
> > When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
> > only static ID table is checked for duplicate and multiple dynamic ID
> > entries of same kind are allowed to exist in a dynamic linked list.
>
> This doesn't quite say what the problem is.
>
> I see that currently new_id_store() uses pci_match_id() to see if the
> new device ID is in the static id_table, so adding the same ID twice
> adds multiple entries to the dynids list.  That does seem wrong, and I
> think we should fix it.
>
> But I would like to clarify this commit log so we know whether the
> current behavior causes user-visible broken behavior.  The dynids list
> is mostly used by pci_match_device(), and it looks like duplicate
> entries shouldn't cause it a problem.
>
> I guess remove_id_store() will only remove one of the duplicate
> entries, so if we add an ID several times, we would have to remove it
> the same number of times before it's completely gone.

Current behavior doesn't cause user-visible broken behavior, only not
user friendly. One has to remove an ID at least twice to ensure it's
really removed if he doesn't know how many times it has been added
before.

>
> > Fix it by calling pci_match_device() which checks both dynamic and static
> > IDs.
> >
> > After fix, it shows below result which is expected.
> >
> > echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> > echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> > -bash: echo: write error: File exists
> >
> > Drop the static specifier and add a prototype to avoid build error.
>
> I don't get this part.  You added a prototype in include/linux/pci.h,
> which means you expect callers outside drivers/pci.  But there aren't
> any.
>
> In fact, you're only adding a call in the same file where
> pci_match_device() is defined.  The usual way to resolve that is to
> move the pci_match_device() definition before the call, so no forward
> declaration is needed and the function can remain static.
>
> I think pci_match_id() and pci_match_device() should both be moved so
> they remain together.  It would be nice if the move itself were a
> no-op patch separate from the one that changes new_id_store().

Yes, that's better, will do, thanks for your suggestions.

Zhenzhong
