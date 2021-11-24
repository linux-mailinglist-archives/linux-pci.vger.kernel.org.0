Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA945CFFD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbhKXWZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 17:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbhKXWZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 17:25:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B98C06173E
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:22:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r5so3382682pgi.6
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1usb7UtD3l2QlYViflcIVKcZYxhVZOO6TUs/1spBqks=;
        b=sU4NY7H4Hr60DZ4Fb9gi2nK8Mjta2Jap7KfLpXKofdGY+Y0adBu+vNmgUj0BITrOK7
         RX+8xIbJgqva3JmJEQmqEL8Bj9v1422S6/1/r5GxrLSR+flFP3bqaQX63HIF/PFFyXN1
         Daa8hzF6rrjmZS8NwC/f6F/Nia7Nlx+1XFuL71VqG2hqo5TaNHL4LXNEOhDotBhmxyOV
         UnxTJ1JeRhWz4uURfuvVIv+nRcQwM/6/VHzLXlao8gyCF2OW0f/L/L9sTfmo6OqCfeES
         fhnAWC2o23/iqYnp+KRXdj7JD+P0YnYvTGkwRx6Od1wKwtGLUhMssZgWBcW94Rauj4wQ
         1YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1usb7UtD3l2QlYViflcIVKcZYxhVZOO6TUs/1spBqks=;
        b=PMR3/ipFjgn2Uy1h1ee36Hs7XncVVZhVRUcs4uQ4HlyHh6vikKwD9bOnm93kyfdwq3
         tfmwTPiGQ7lih5Lja1UPKJqb289mN4fPgqGoFpu0q02zL16kYVGMF9EDgISxCbROuh7E
         4OVug4u7iMVe3FPgOFRuPPVMb/27TTmp/omgI/BV3FnJfY1Qce+PPEQtKjus1eQiqYNT
         lwE3TpxrrTV26f3dY14QbCdHQpmgmL4LBoAqTnPNSNctFRmFU+6JHwVhUyRuaFRoGQXz
         yzUcueo9MVC2cPJI5A2uq+ORO2Y16iZD7U48riUH6ENT7WZMpmWwSRioSZVvBzvuPuaW
         fQlw==
X-Gm-Message-State: AOAM532t0mJVS6ps8y6gHLZOEgElDUYSD17cCYMKxMkTN2EZ1kmwZjxD
        L2RZAiT9GQsCO06D6d3n8UWPXd0QYXDT3Nj23Q37kA==
X-Google-Smtp-Source: ABdhPJy5kNPu9teWe090tmKlzC0EdhLvwER/Av/pfEXD/2h1jMTKe+JplmNnORPJz1SaB39a4wDuYB7kepvu4FF5XO0=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr9757066pfe.86.1637792553750; Wed, 24
 Nov 2021 14:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-10-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:22:23 -0800
Message-ID: <CAPcyv4hgF4T_oVniu0J4xNUegi_+XLEXkMcC_L8AB2Y+Sf4Nzg@mail.gmail.com>
Subject: Re: [PATCH 09/23] cxl: Introduce module_cxl_driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Many CXL drivers simply want to register and unregister themselves.

s/Many/Some/?

> module_driver already supported this. A simple wrapper around that
> reduces a decent amount of boilerplate in upcoming patches.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
