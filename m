Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5101FDF054
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJUOtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfJUOtW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 10:49:22 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 168B62A09AB
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 14:49:22 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id n59so14314822qtd.8
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoM05916f2iOKQ8k9NQo94DTKSXVJOYaaX8pIUuRDvI=;
        b=rkiRgXQCygxazwxi8Ng4O6Zg1W7ZFF6dMlcK5ztgRZDOvqIfrL0rVjQJ/sz1Cvp/Px
         jSXzCBUnkY8Ad9bslRBEP0Ma9D/VFPQvKMMieRUEO9hDjY6CSuENsB6ucE3FipGwQEpt
         eR9bDNSPij55+b05bvQqsIKRrfEOwkZLUTtCzDboG7ksdCIEcoiYfEdNLDKQ1uf+1mg9
         F0goN8EsVWHKtbWGmho4wVDbunTDJ2mTdhnZIiWZvaW7msX7pxtlVLXYZqcIhhT3Jb6U
         AqvURzcb4/KZA4Wux0DJV1NhMxpPQKDtu1gHaRxqkwUgRXJLJs/CcCojx455dG0eT1RG
         nGSA==
X-Gm-Message-State: APjAAAWHDDaQgDDsUdVSnPlI2Z0j6q7jVXY4wqXwtzIbackGnzNIfwT5
        mhQ4/i5xlnIl4hwHboDaxskHzsaV4SKu7CRTlH5nL4b4k3FytioSYjvxCxyi8u7YS+j6/gfbTVX
        pH8uQGGF7uCw552n5WgyIySJjYtfBgLq+rzev
X-Received: by 2002:a05:620a:a9c:: with SMTP id v28mr1773197qkg.381.1571669361065;
        Mon, 21 Oct 2019 07:49:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd+SAXdjO3y4S1oIDF06DXEmDuqtYz9U6zcL462CpXUBB9ua/mW5nvAsl4Exz5hHeQUwEuYJSw0QkJYkjPK+k=
X-Received: by 2002:a05:620a:a9c:: with SMTP id v28mr1773179qkg.381.1571669360782;
 Mon, 21 Oct 2019 07:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com> <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com>
In-Reply-To: <20191021140852.GM2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 16:49:09 +0200
Message-ID: <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 4:09 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Oct 21, 2019 at 03:54:09PM +0200, Karol Herbst wrote:
> > > I really would like to provide you more information about such
> > > workaround but I'm not aware of any ;-) I have not seen any issues like
> > > this when D3cold is properly implemented in the platform.  That's why
> > > I'm bit skeptical that this has anything to do with specific Intel PCIe
> > > ports. More likely it is some power sequence in the _ON/_OFF() methods
> > > that is run differently on Windows.
> >
> > yeah.. maybe. I really don't know what's the actual root cause. I just
> > know that with this workaround it works perfectly fine on my and some
> > other systems it was tested on. Do you know who would be best to
> > approach to get proper documentation about those methods and what are
> > the actual prerequisites of those methods?
>
> Those should be documented in the ACPI spec. Chapter 7 should explain
> power resources and the device power methods in detail.

either I looked up the wrong spec or the documentation isn't really
saying much there.
