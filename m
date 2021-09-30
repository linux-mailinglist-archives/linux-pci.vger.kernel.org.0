Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59641D7E6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbhI3KjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 06:39:21 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46954 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349928AbhI3KjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 06:39:20 -0400
Received: by mail-oi1-f169.google.com with SMTP id s69so6619895oie.13;
        Thu, 30 Sep 2021 03:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=791k1dCYnBwj6qh9NyFd6tnYYhaFD9tuqv9gadUQ6dQ=;
        b=keAo38l35U+Sl/ieQvcKxHju+dNVkpr6ZgNsiFonZgmdyNCqdDq81/NDxnVDzDAru8
         pYgQEJ4i0JMv+JQk8uUDDfV5xANp2PcwP2RUXdZDdguBzoxiuNSdWJSxKlmT2UhdMbs5
         EuzGVmZhR7Mnxvqd7oSRMPME28zaU6TLCUFYytphlsbUjsqJBpoyfed8uB5HWbM2NdGr
         7RU6XgJx2kw8ZngRBFPmuURDrdylMdW2n/SbJZy9GsgZseVwmo6DeB4QaPK/ETXuWYy7
         xzniA9sb+yeW6nAd5XGZZ++PxvX/fvhrjM9bIOOfEblMn8okVvj766AcDKmySUCdhn2Z
         zZHw==
X-Gm-Message-State: AOAM531G8Q0ZlvEoH9yBNztYqFmRGCna4H26BbprisnD2xWTp7qFpcba
        2QRRQ0vrZh3uYG6qQ1WyC5k4CaWgiQmeQsowHnY=
X-Google-Smtp-Source: ABdhPJyMeqiDR56PoBiJKZzrWrCADhqOYOWxKRwfmWJHwa57BMk+C85nXGqnvTtW11Vklj1lLQAAiXpkRzH6TIE7jBc=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr2079960oib.69.1632998258221;
 Thu, 30 Sep 2021 03:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210929170804.GA778424@bhelgaas> <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
 <YVWL3PyYRanGTlVG@kuha.fi.intel.com> <CAHp75Vc9hxqy=vrVfuS_cPLCVxZ=KgxZUaD=-rU9W3KH=tAX9Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc9hxqy=vrVfuS_cPLCVxZ=KgxZUaD=-rU9W3KH=tAX9Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Sep 2021 12:37:27 +0200
Message-ID: <CAJZ5v0gAfWaUXjMrSf7Ei-P=0u7kzHVKQNFY0aSxs6KFd5T6ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device properties
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 12:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 30, 2021 at 1:06 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Thu, Sep 30, 2021 at 10:33:27AM +0800, Zhangfei Gao wrote:
>
> ...
>
> > If the device is really never removed, then we could also constify the
> > node and the properties in it. Then the patch would look like this:
>
> I'm not sure the user can't force removal of the device (via PCI
> rescan, for example,, or via unbind/bind cycle).

The sysfs unbind doesn't remove the device, though, AFAICS.  It just
unbinds the driver from it, if any.

> I guess this way should be really taken carefully.

But I agree.
