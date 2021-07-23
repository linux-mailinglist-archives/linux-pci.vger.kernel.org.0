Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2789F3D36A5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGWHqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhGWHqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 03:46:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25EC061575
        for <linux-pci@vger.kernel.org>; Fri, 23 Jul 2021 01:27:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hs23so2336360ejc.13
        for <linux-pci@vger.kernel.org>; Fri, 23 Jul 2021 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFpK+T9+raPLxD+yxquAoKkiFMyk8CjZ/tSZDv72n2o=;
        b=ZVJXefECKmKkO0h9sYZ9RR58AL+LWdFA77aSbDvdI+zrMQ1A6P5FjdcTwjZyEjFUMT
         dhw2K7Qaq+0Sc8B1FqcOpWv7fAmBt9R5PeYi3O6uSOM0LrQd8Z5eI7QRZ0Gi6eQKlIAW
         6KA5HNR69yUmOgsScu9ArA9ZZrhpJIoY5Ov9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFpK+T9+raPLxD+yxquAoKkiFMyk8CjZ/tSZDv72n2o=;
        b=g5JYTAtFaYeEUvgIK9r+35nR7uoKqFhUufPNPM79H/UjMexqUhNxlgQgjuPOFoR6wG
         JZHJ/6ZICb8dsSlLQW8PZRJJXaQ6o5WdOLdQ3Gd/kvVySPR/wkVOzRxLdzbzmFDMX8hn
         N0T6SX9HEFigt7++Q31wzpy6sEnafZVUmf3o7th2gLfll7HRoDYGtpVZBD/2Vtp/XNs6
         +0TrchWQZ88PBcNmBoSy0ZE80TX6rE2IC3//AW+Y7JKOLDiUjRrIUmlfd2YWl0ptFdk+
         QTkeOAD+XFUDrscmZvXJBOH/14NQ1UgGMSYOH6b95b1OwhKQlV/L97FYPb9/q2rsHdUO
         t8nQ==
X-Gm-Message-State: AOAM530If/KafyOqMe9xVb4FzYPxYGf5U37y6BhWRLqiXGTEacY4mjWe
        ZssSDpl7JZaCYLM2Kc61cUnAiw==
X-Google-Smtp-Source: ABdhPJyzWM4G9HcIWpk6UZ8YFodYmP7Y4vSG+XIakxaW8WUjB18orefvqugOUHJXwuBXOz5wWBjYxQ==
X-Received: by 2002:a17:907:d09:: with SMTP id gn9mr3619982ejc.447.1627028830842;
        Fri, 23 Jul 2021 01:27:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m12sm10376485ejd.21.2021.07.23.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:27:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 10:27:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/9] PCI/VGA: Rework default VGA device selection
Message-ID: <YPp9XCa+1kS/s3wK@phenom.ffwll.local>
References: <20210722212920.347118-1-helgaas@kernel.org>
 <YPpY/zRTYK3xI6rK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPpY/zRTYK3xI6rK@infradead.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 06:51:59AM +0100, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 04:29:11PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This is a little bit of rework and extension of Huacai's nice work at [1].
> > 
> > It moves the VGA arbiter to the PCI subsystem, fixes a few nits, and breaks
> > a few pieces off Huacai's patch to make the main patch a little smaller.
> > 
> > That last patch is still not very small, and it needs a commit log, as I
> > mentioned at [2].
> 
> FYI, I have a bunch of changes to this code that the drm maintainers
> picked up.  They should show up in the next linux-next I think.

Yeah I think for merging I think there'll be two options:

- We also merge this series through drm-misc-next to avoid conflicts, but
  anything after that will (i.e. from 5.16-rc1 onwards) will go in through
  the pci tree.

- You also merge Christoph's series, and we tell Linus to ignore the
  vgaarb changes that also come in through drm-next pull.

It's a non-rebasing tree so taking them out isn't an option, and reverting
feels silly. Either of the above is fine with me.

Also I just noticed that the scrip has gone wrong for drm-misc-next and
it's not actually yet in linux-next. I'll sort that out. Ok I just did
sort that out while I forgot this reply draft here, one of our committers
pushed a patch to the wrong branch. Luckily it was a broken one and the
right fix is in the right branch (and already in Linus' tree), so a hard
reset was all it took. So should be all in linux-next on the next update.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
