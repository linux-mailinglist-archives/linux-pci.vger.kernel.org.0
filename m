Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEC25B889
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 04:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgICCDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 22:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 22:03:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F713C061244
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 19:02:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so1589648ljj.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2020 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hhuuiXUXPKShiC2Hls0S5u+97zhlA3Lfy3FSwPZAvg=;
        b=MBUm6X2YTxoMrNEsmsd3ByNMySLkQvEH9s/fpLDT25i27Qzys1GNTUlZM5s8aDj8mo
         EqbWsiYrK41/1h7pE3vshEiq3zac+0m5Iw8AtlZV+UFOB1vMg2K6ukwyT9LBbKbzM4db
         Jgji/OQ9Z8TsGHrNvZMPNEyJ+vni7HtYdMpWBOEyZOlJrqR+TAawkYGdlo7m/Byi6vE/
         fDBMjBCwDFNbgq8DPZI8gscsPu6AT7J0XQoX4jMVhJLBYmRZRnTitm2OxSHEXgBZ567n
         Jtl3jhGFgMBh/7jclUPPjFKYPQpQTHifZNq4BZ7Yt1Gu8T26YPAK76w2QTUHjxYNViIE
         uXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hhuuiXUXPKShiC2Hls0S5u+97zhlA3Lfy3FSwPZAvg=;
        b=t+KI144x8dC0tBEtBD+Lmeo7FXt/k+DYKB4I+ZlmhIWxfUaaLcG/gDyV0X38aUUKq9
         JvoUKIHi917YX9+abpPZaBSlsEbViV5bqMqywPs0gs318SXPn25J67wnE/lvM3Ye/KeW
         aCWq2Q4fAhXMQbnyEVW+tle96qLy2QAzn33u976LbiXlzJcs0pJkkrCoSegaVtJGAZ48
         eBEMTIaUzIHxZ0bAM+F6LVNED6ssABtSWWV5ehhbiVl8TQvr09yL+dIjEVaGGsLzSPpU
         iMJfpxSa6VqRjWCgPU0KcvTgI8wP+TIqo7X0vF0m16m7IqmmaXb0ku9v3zduwOEUM0lQ
         8GNw==
X-Gm-Message-State: AOAM530lfmVqEsoEvT+quYqztNhfBLvlkuRl0N/ULD2Df5L7jSjdkSb9
        43HWNoOTLGQgok2E0v5ZkxGQQlE4w2myYtGrgUs=
X-Google-Smtp-Source: ABdhPJzNoSz8uY8UPgeA6q7FOXakXQ+iiBNWwUG+0sQjrda+2kn2J/WiiHYxLFnj8lC2PzmhToR6/lB1iKnoP7+eT3Y=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr433249ljg.125.1599098578210;
 Wed, 02 Sep 2020 19:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Sep 2020 23:02:46 -0300
Message-ID: <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 2, 2020 at 2:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is an extension to a %p to print phys_addr_t type of variables.
> Use it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped bytes replacement (Fabio)

Reviewed-by: Fabio Estevam <festevam@gmail.com>
