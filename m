Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593942CE8AE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLDHgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 02:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgLDHgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:36:36 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B3C061A53
        for <linux-pci@vger.kernel.org>; Thu,  3 Dec 2020 23:35:55 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cw27so4821646edb.5
        for <linux-pci@vger.kernel.org>; Thu, 03 Dec 2020 23:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ib4z7ovnO/Is9x9bv4eZdlrrRMtAOfboZBD7JQtUG5M=;
        b=MlznnxVBeS9Jeb9K6pxCGMSisJ5di5vo8rnZgccJEokQkubT+b5ELOaP/qYZPZYens
         LTQTZ5qK5+rN7i7TrBiUt/aTlSX5Si22lwK89sloMRq0lkL5fRELUsL6cmnUB3ewrYzQ
         1C9XmpiDtksVcCp4aPdPDUu7mqzrhfTMil4Ii3r3Z+W4Rch+qHSCIy5nHqdZZHzjfuFC
         CouE9HwiB531iUdh3GBA/XBU2A5lxBYq8LwhDwqMK/fdnMIEGn+ShaX5yrUWSLlOXrdb
         pcuY+emGUnm4SuFF1EGQYrkKyVUfjNb/nVosCF9na3545V2UELil7agJD0NNoLsVMpuy
         +qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ib4z7ovnO/Is9x9bv4eZdlrrRMtAOfboZBD7JQtUG5M=;
        b=R9xeLrMy2xtL6BudutDxYd2/Nb4Dry6nqysMaxXjDHLxAS+W7bgvED1ESLoYDz8N+b
         xtXbvvDKfJ4JSBfrYKSpOHf9JkHcnQObxT/B0mvrn60bu/t6MYVanw4f5uAI8w4e0Gxe
         4CXTco6PJ5o0UcW8h2V43UqqHj6ET8AC5+zm3k7oKdMfWzjrpq/exWq85bb47pfie7mV
         y9ZhZcJz9SRTYL5PBnQ5fCPoS1ELX2y2FM3i+KALs6wthJHw4rt8o8COU4vkax9OVY9P
         vHHQi2V3zaZGkkzgN/9klFaSSfyqZF3spkazH7WP0hUHXMXUNMzninZFBKfLvdNeKOKT
         lLgw==
X-Gm-Message-State: AOAM531qtfo+Igt9OC1PzQN3MCixhY6OZHxYCMdDqWlzVtkKHt1F1iOf
        DXaAAkLot5lJTmHQYq914VASFvp4YRIYITsdei9o2Q==
X-Google-Smtp-Source: ABdhPJxnSZOAJkjodNrzG83gLmg0TXLoPO+mgtRWWPBjvZDtvRpGbpYSdnh6boOt1ZZAav86Y2rNmJuHLlFwPeiDAfk=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr6641049edl.210.1607067354664;
 Thu, 03 Dec 2020 23:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-6-ben.widawsky@intel.com> <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
In-Reply-To: <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Dec 2020 23:35:51 -0800
Message-ID: <CAPcyv4hYR8Ty2vq6kfG6_h6XRQPv2=-x4S0DgyzAykgx0TWzog@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 10:06 PM Jon Masters <jcm@jonmasters.org> wrote:
>
> On 11/11/20 12:43 AM, Ben Widawsky wrote:
>
> > +             case CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX:
> > +                     dev_dbg(&cxlm->pdev->dev,
> > +                                "found UNSUPPORTED Secondary Mailbox capability\n");
>
> Per spec, the secondary mailbox is intended for use by platform
> firmware, so Linux should never be using it anyway. Maybe that message
> is slightly misleading?
>
> Jon.
>
> P.S. Related - I've severe doubts about the mailbox approach being
> proposed by CXL and have begun to push back through the spec org.

The more Linux software voices the better. At the same time the spec
is released so we're into xkcd territory [1] of what the driver will
be expected to support for any future improvements.

[1]: https://xkcd.com/927/
