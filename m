Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B045C5FF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbhKXOEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 09:04:46 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36384 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349984AbhKXOCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 09:02:23 -0500
Received: by mail-oi1-f169.google.com with SMTP id t23so5528862oiw.3;
        Wed, 24 Nov 2021 05:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pufUHSmtP9gb31UGnZ0b9lBzW6YY7sb7qKv1eYjbsnU=;
        b=NpFpcBCU75Mbhhfo6eN4a0RAk5AAQaHwOmxBnbSQVDKV+6onG0keaciOiCesSgRfn5
         fz5kX2ktpMkztbUH8QDiDSh8mP8wN0vbeR/LEfsdGn920c8cEsVbxYJtX5B2rUk9/Hut
         yJjDBC54CNBy0iTp6d5lX5SsrctDXCafqttvRcSFGN2cezGbBhrM2k5Ei1Ge50cL/Naj
         oGE3/J4DZ7npSiGRMfUKJn9JeL0uX3d98bmVBFQ1A/CC5bXdjHapLDZPt0YQZnOZskFw
         STMcq7XUYIL8ill+nOtOE37RZRPROzaa8eSdWEsNux+Mi20jjwD+0aJ2iM2glJA9xi90
         JNag==
X-Gm-Message-State: AOAM533IqB77wYns6G6FEoVx/YJqXENKaRRObFT44jL+EACln3ItH8za
        1cbhk7URFqcKV8v4WfcGbMEe545zvzt3dDFT/AjHT81i
X-Google-Smtp-Source: ABdhPJyB9bqRrYLo8nMiqocpMtEtKqgGJL73wZeqCo2+G32Xg4BqilXxOlxxzGOtxdobVzXxJNFkS5dLwiILGFCiJ5I=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr6278436oiw.51.1637762352525;
 Wed, 24 Nov 2021 05:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 14:59:01 +0100
Message-ID: <CAJZ5v0jsWVw4OyVbkdn2374tLAXAShZ_B3CKDmnQOE_QEXXPiQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] device property: Remove device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 1:10 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> One more version. Hopefully the commit messages are now OK. No other
> changes since v3:
>
> https://lore.kernel.org/lkml/20211006112643.77684-1-heikki.krogerus@linux.intel.com/
>
>
> v3 cover letter:
>
> In this third version of this series, the second patch is now split in
> two. The device_remove_properties() call is first removed from
> device_del() in its own patch, and the
> device_add/remove_properties() API is removed separately in the last
> patch. I hope the commit messages are clear enough this time.
>
>
> v2 cover letter:
>
> This is the second version where I only modified the commit message of
> the first patch according to comments from Bjorn.
>
>
> Original cover letter:
>
> There is one user left for the API, so converting that to use software
> node API instead, and removing the function.
>
>
> thanks,
>
> Heikki Krogerus (3):
>   PCI: Convert to device_create_managed_software_node()
>   driver core: Don't call device_remove_properties() from device_del()
>   device property: Remove device_add_properties() API
>
>  drivers/base/core.c      |  1 -
>  drivers/base/property.c  | 48 ----------------------------------------
>  drivers/pci/quirks.c     |  2 +-
>  include/linux/property.h |  4 ----
>  4 files changed, 1 insertion(+), 54 deletions(-)

Has this been picked up already or am I expected to pick it up?
