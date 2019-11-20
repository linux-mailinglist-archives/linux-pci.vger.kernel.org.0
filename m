Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F601039B0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfKTMMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 07:12:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729574AbfKTMMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 07:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VF+bQZFHPewNnM9aH9KyZQntlM8F2dUwAxVJVb/6oKY=;
        b=BRMvBy0jr6Cl7DF+3UNGZo3rjEa3ndIOh44ahtijq+vY8thtK4qQKQG/adR0rb5RqFX2La
        j/FCO8gVonNnmDnprlVcE7/k11Xgg7+hbuXhiDlo5dhNxTOEebod66yjSqYxZUtV+RXigH
        GjJmuXTdJUzUwwhwtOfEsy8BByTm7dI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-iOHe1_qDMdO_danoY_59SQ-1; Wed, 20 Nov 2019 07:12:03 -0500
Received: by mail-qt1-f197.google.com with SMTP id e2so16896513qtq.11
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2019 04:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF+bQZFHPewNnM9aH9KyZQntlM8F2dUwAxVJVb/6oKY=;
        b=bZ/L++v3d7cOho6MJS/C1s8VXfN7gl8j0ZY995C/YC5jfB+N+bSBQBZFKtyZlQmBPb
         JiqGviYigaODtq/v6ItLe4hAQM/zqDm/B2eONXjKjhD5NTZDqKHaN2kGbohpxjH/rJUR
         qkPXSyrCY+cfnqEHgXh/sUJvgzUcXxTkxBsPq9Fxoi1NYTHYK9XU36QrAZxqLVUAYJLC
         LVBESzuc6Bpbnag/K++QIXU089r2W3sWVnvXguVV9JZNBNUH7KnCaUY/wiscGUOz4fNk
         PSheqhdDQ2jMVtFGKEOS7tufauanhqURrJvbkqooqz2vUp6yIXYHgMjpUR/RCENbRNzZ
         VMOw==
X-Gm-Message-State: APjAAAULK5VrSwRB4t09pWbiLAoXVUX66OKr4pvlA3gg6prDvcivkUC2
        VxFW8tc7Nco773Hz7+t6hklv+habJlxlXC0IXWq4ATOTpFxdLLtWYgFHWZ8GcT0i+ov7H2E+YbU
        jRCvHdXs+djC8uXNjyjYTHJO3ZsD8qT87yaAj
X-Received: by 2002:a37:9083:: with SMTP id s125mr2044108qkd.192.1574251923299;
        Wed, 20 Nov 2019 04:12:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBAA4TCCMTkJLA3fk7uQ/livSO00sZJsFKKfFUtKcydvGnjFRyWiHk4b/E6hpfbS10eFj88YdwU+FKUdPz0cI=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2044079qkd.192.1574251923040;
 Wed, 20 Nov 2019 04:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com> <20191120120913.GE11621@lahna.fi.intel.com>
In-Reply-To: <20191120120913.GE11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:11:52 +0100
Message-ID: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: iOHe1_qDMdO_danoY_59SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > overall, what I really want to know is, _why_ does it work on windows?
>
> So do I ;-)
>
> > Or what are we doing differently on Linux so that it doesn't work? If
> > anybody has any idea on how we could dig into this and figure it out
> > on this level, this would probably allow us to get closer to the root
> > cause? no?
>
> Have you tried to use the acpi_rev_override parameter in your system and
> does it have any effect?
>
> Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> should hopefully reveal something.
>

I think I did in the past and it seemed to have worked, there is just
one big issue with this: it's a Dell specific workaround afaik, and
this issue plagues not just Dell, but we've seen it on HP and Lenovo
laptops as well, and I've heard about users having the same issues on
Asus and MSI laptops as well.

I will spend some time to collect all the necessary information,
create a bug to put it all in there and send out a v5 with the updated
information and references to this bug.

