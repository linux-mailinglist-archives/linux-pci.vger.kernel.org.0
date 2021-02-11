Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E1318465
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 05:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBKElq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 23:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKElp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 23:41:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9FC0613D6
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 20:41:04 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y9so7926474ejp.10
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 20:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl6/My6OzOs0T7wZB4oePD5pENhmSvczhT0K8Arc7LI=;
        b=WkyTT/tlVuOu/QtJMR4TMPtKI3ZroEdf6vo0pV6EA6pmvld9AUZh5AcBIdoQsmyy5W
         ujhDIglIq4no4S4FnPjAJEON+41CXF/kZhVZc/Of6nBcJmH2ckxq7jFNww9nR/DwT+h/
         8UqUiI1xPm3fisBJZevopAV8RlTeHFLm996qBPYad35tPwuvIkQ2wNljHBO7QuzsU8pl
         m6UjMx88Bp2ax8h59hFBDU+mEcT6OxV4L26reH2yIq5jyt3ZKaGUX00yc6uufxWXKc/K
         6TpW44YRo7+SiphYrSoLs6Eu0cjTNKyi8E8jF9IRE0pU/01y+thIBuSGcpnf168C/Bou
         mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl6/My6OzOs0T7wZB4oePD5pENhmSvczhT0K8Arc7LI=;
        b=H7vJKw3pVUKIKM3846B2r7NmcK8ZqY30qS7AECJ4I2EpxpU27QSdoN499gqjqrb9jc
         Ol6y5QRt6u2t5NKciPt3djXFRTnBaZ05iAyLAJ1O0HpQYPMFnJfGAby1zm9dhgAmSosC
         cbO2vKhEWtsG8NCYm0w00MW2jnxIqEJlPgTDZvs9/9lVW/fyVc3OZIig+fqRJdjTTnl8
         8Fc4TZk1ql2UwFfFcCAxzAzS+M/RTcnlA6VESxMutOnvV9c85Rh27EltjmppJngdzvyC
         HUnRVjbzH8CamVwCuwof+hyrgvKxmB8AWeTIac6Iot1Tn6FjfRvN7vEhcMAmxKrfTjt/
         cztw==
X-Gm-Message-State: AOAM530En6wTSd1v/IQN84ADlMbJGxNTIhOvXeQbNjQ8ZuyIfNohodJW
        cT6Lx1mddHzeGUmatFDGyJI9LlX1NSiEe2ymQakuQA==
X-Google-Smtp-Source: ABdhPJyqM5HE0PbHSNMhdSZjzjNWswbaPuS/dDwtU5r1wQLbe3Pkm5vgDMrXrmlgqG9PntEEBlBF3kFxRImOkT4QFcE=
X-Received: by 2002:a17:906:78a:: with SMTP id l10mr6139548ejc.264.1613018462922;
 Wed, 10 Feb 2021 20:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com> <20210210184540.00007536@Huawei.com>
In-Reply-To: <20210210184540.00007536@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Feb 2021 20:40:52 -0800
Message-ID: <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig
        <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David
        Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>,
        "Jon Masters <jcm@jonmasters.org>, Rafael Wysocki
        <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.willams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > +#define CXL_CMDS                                                          \
> > +     ___C(INVALID, "Invalid Command"),                                 \
> > +     ___C(IDENTIFY, "Identify Command"),                               \
> > +     ___C(MAX, "Last command")
> > +
> > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > +enum { CXL_CMDS };
> > +
> > +#undef ___C
> > +#define ___C(a, b) { b }
> > +static const struct {
> > +     const char *name;
> > +} cxl_command_names[] = { CXL_CMDS };
> > +#undef ___C
>
> Unless there are going to be a lot of these, I'd just write them out long hand
> as much more readable than the macro magic.

This macro magic isn't new to Linux it was introduced with ftrace:

See "cpp tricks and treats": https://lwn.net/Articles/383362/

>
> enum {
>         CXL_MEM_COMMAND_ID_INVALID,
>         CXL_MEM_COMMAND_ID_IDENTIFY,
>         CXL_MEM_COMMAND_ID_MAX
> };
>
> static const struct {
>         const char *name;
> } cxl_command_names[] = {
>         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
>         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
>         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> };
>
> That's assuming I actually figured the macro fun out correctly.
> To my mind it's worth doing this stuff for 'lots' no so much for 3.

The list will continue to expand, and it eliminates the "did you
remember to update cxl_command_names" review burden permanently.
