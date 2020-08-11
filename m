Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C32417ED
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgHKIEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 04:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgHKIEi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2020 04:04:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD4C06174A
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2020 01:04:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so10552746wrs.11
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2020 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m/9oajnmpulJQFFHe5rO/NKB3oM7j5qRCzsG9Pje1vw=;
        b=WVMBCCGntz9aZSNzO3YGBL6Y5SM+pfJzI1OHFfHZOeB1kaPEXXlb3htXrSjy8zDuCS
         z7DyQl9x3jpE0JH006wM6RG+o35ypzZzygWwX2toXYM3XrU2Mi9a4qg7jgyhFavERwf1
         sYs9pY8XWxvexIgINPc7Vi43PfmdCe3g4IR7jKLbp7EjHU3xGy2347U9DDlA0GoaTLUr
         jkkUhuk1Jnt64sEUosOhKzOg5X+6bXHYPOwgGymYgjxGKK0ZawwAHgPeySN2sxxvf8nK
         KOU5U/cvNuO0uh5Ywm3ndx9LBBHAVMqqvC7G9g7x31AnHgWg0LPfNi2f8C3xrs/XQECe
         F5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m/9oajnmpulJQFFHe5rO/NKB3oM7j5qRCzsG9Pje1vw=;
        b=fiaiuSTb2hdNvmEil0eZ0dh9LoYwX1yC9alUakgQL8Q81CY2aGINnCT5ZmHK/DcCLn
         AcOdvLYUc8Iz/8SrkBtEgAdHgKWscZ3slICaCgok7r2HqbQ4GkLsJiyBIkSTBeOLLIuV
         4oxsT1Ebjcybqt/6EHsBhpizmMjKLKR/399Z+d15Kjmh7DdFjrM7jooGzZyRbZf2vcxZ
         rMavvcJmYSsLVfUc2pxZruFt1rLCdGDthxdM3HKPR4NFTBmk2PtTIm4ui3mLERm+skEx
         cwYp4G/p+aoIuS77ezjiLd3Quml4uBghLG1guiruE6R2TnZxEiUGo4ayk8cadybFGYD5
         Mkkw==
X-Gm-Message-State: AOAM532F13FXD6rA0RYqUe9s03xj9sNg+7y4MLlhlTjcp4but00BfQON
        SWPmVDyKa5upsMwqYRvZ68qBzA==
X-Google-Smtp-Source: ABdhPJzfrOEs4jcEBk/X7yZSCi1Xor8RzKr7I+Yongyi7WT+ad48GTwwGNBes1mYrdoekHxHJbPTxg==
X-Received: by 2002:adf:f488:: with SMTP id l8mr4851884wro.123.1597133075746;
        Tue, 11 Aug 2020 01:04:35 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id 31sm25413291wrj.94.2020.08.11.01.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 01:04:35 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:04:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V5 0/3] Intel Platform Monitoring Technology
Message-ID: <20200811080433.GI4411@dell>
References: <20200717190620.29821-1-david.e.box@linux.intel.com>
 <20200729213719.17795-1-david.e.box@linux.intel.com>
 <74c03fe9fea12f4b056bf694a0d03d5200244231.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74c03fe9fea12f4b056bf694a0d03d5200244231.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Aug 2020, David E. Box wrote:

> Friendly ping.

Don't do that.  Sending contentless pings is seldom helpful.

If you think your set has been dropped please just send a [RESEND].

This is probably worth doing anyway, since you've sent v2, v3, v4 and
now v5 has reply-tos of one another.  The thread has become quite
messy as a result.

Also please take the time to identify where we are with respect to the
current release cycle.  The merge-window is open presently.  Meaning
that most maintainers are busy, either sending out pull-requests or
ramping up for the next cycle (or just taking a quick breather).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
