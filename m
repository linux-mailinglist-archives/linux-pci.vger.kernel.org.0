Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2887541D78F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbhI3KWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349893AbhI3KWR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 06:22:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8AC06176A;
        Thu, 30 Sep 2021 03:20:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s17so19878165edd.8;
        Thu, 30 Sep 2021 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2lTT1u/Fn4oWAUqyMELvnYcYq+0z0mii+LOMpZnQQ8=;
        b=Uq4l7ePOVZemVxv2Fn4TJXeAeh3rZynmWGdNYWSjrqVANG0rDiWkLwKKcCqNWN16cK
         O4224AlUZ8e5tATcbWAGSRdTlxJ5SVFSu0Vrsd0bSCfGiEGnUGzb1zg4tAQ1E1NxA8o7
         eDK4MVGSEsOkgath7AKUyNkl+OAATm8Ps2NHnOiMUgFoUVZdWQHTef+Aqt/uoNMbXztY
         VqHWyqtsBDp/Si2obHzbPh3THD1USP2CckrQZx/CY+G8p+KnHCnn+nAJB1NGN1fgkoWW
         AGWwFi2dBe7D97gAXE1tu++dFXazUKSRRLAJVio2YK2u+kmZ/xl13BcBj1hzhBwfrSZv
         uNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2lTT1u/Fn4oWAUqyMELvnYcYq+0z0mii+LOMpZnQQ8=;
        b=HolUYF96SsMOp8xS8xyg1pBBSlKaThMt+Uiba4LKLatlVKrP42K+1tjxMsF1vNSkLi
         guKn9XxGFB1qzEKwLXP1mMbuBAjo+EyWDYlBcTBtyc3A0tCRJCzN6n4jbyACSyKI05ED
         j7ebEHBUThJjMTUcsYIDDNHvcqXKgnJgHQ61aMt6EUsXjpOQfWJ6RUvCH7HH/uImki6C
         6kqJmn2uVvKdf5dI6WxmRxhh05Gv3qaZRJzui6Gx4chy9ox7MbxGPs5zgt5/WGp+g8CO
         ZyL+iI7+CcbW7KaSWw9vCRSUH5sfltWiR2unDHjb+ktPTWTXtF/prAQru1nzeJqx7+w6
         FcwQ==
X-Gm-Message-State: AOAM530y/5aFXgsHW7o9Nft+LNuzXogTeN/gu549mgb/r1byc4/yEWfx
        o+RUB83WvplVTBsQwZu/C9v10S6jo9PWCruvt/4=
X-Google-Smtp-Source: ABdhPJwmULVoGBwUWpTGObIO+XIg9tb84jNzomfSYUNs8wermBb5UWAtchFWmNaRStkEXOYvu8ZSspTOV+S4ULqWY1k=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr5625227ejd.425.1632997232508;
 Thu, 30 Sep 2021 03:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210929170804.GA778424@bhelgaas> <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
 <YVWL3PyYRanGTlVG@kuha.fi.intel.com>
In-Reply-To: <YVWL3PyYRanGTlVG@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Sep 2021 13:19:54 +0300
Message-ID: <CAHp75Vc9hxqy=vrVfuS_cPLCVxZ=KgxZUaD=-rU9W3KH=tAX9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device properties
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
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

On Thu, Sep 30, 2021 at 1:06 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Thu, Sep 30, 2021 at 10:33:27AM +0800, Zhangfei Gao wrote:

...

> If the device is really never removed, then we could also constify the
> node and the properties in it. Then the patch would look like this:

I'm not sure the user can't force removal of the device (via PCI
rescan, for example,, or via unbind/bind cycle). I guess this way
should be really taken carefully.

-- 
With Best Regards,
Andy Shevchenko
