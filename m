Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773A125F043
	for <lists+linux-pci@lfdr.de>; Sun,  6 Sep 2020 21:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgIFTsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgIFTsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 15:48:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AABC061573;
        Sun,  6 Sep 2020 12:48:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so11804729wmb.4;
        Sun, 06 Sep 2020 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqAqs+BxEK1Lea1e7i04ZpNCHike02s62kLGfdQa8+k=;
        b=vb8SiqDIvvHapprV1lprMwSm9c5cfiBHu40wh8kFOxFX6ZC+LhcGPqrBEQAAjVyAc9
         i87w3YE75KLs65Auyfxo6XiiCKaOTY2c0j5GlJE9XOrZVwXB+4j1Sp5GB2my4KLJ1PWn
         95MnVRBUsCI796cPpWy3SMthaqFnAECdmWSRdbuplY1OLcCRBl20jO6TyL2CslnASqtb
         oQwRwe29tCvJVsG2dba4OYbLsAE1i0BfHVOwjJu0iUv6WdxaMIk62cylIqbtuGU4ZQF/
         CaWMupsR4iUctHsiuIBNeenzIUuJ99KkMLIi6s+RjE+4/H5uVpjKtRO8HnmzrWzD2Oqy
         CUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqAqs+BxEK1Lea1e7i04ZpNCHike02s62kLGfdQa8+k=;
        b=ReL5kS+GM90dIMjZiodJbc17t0ZJhvGB/YaUlttDvvyRvaAY+f/vo9qEDRn4YZ9P0a
         nseTBq07zawaBXDb4RRfsaYwAxNMjABRP9aj6f/e8sAaXlb6QWYWLwVPZMlDbjDFfGfX
         rDhmctLTo1F6WXsB0SH/lJxoRlhLoasCeDlTw9B23KnAeI8lALYkMMemvEYg+3TejWQ8
         PG/fNm/M2JS6yhusXloCX9LFnA/jrmJupVVcVd/kxscDikpSEIlfUy2rgCpsEWJaoeDn
         hwVpGc64GdEcyQ6wmy9H9z6Pa4edplYAtsmPfD0sWiEkJKgf7Da+zn21NmEjZTJCyCH7
         tHdw==
X-Gm-Message-State: AOAM531SczMV1T6z+lcYtxMMQdD378AkAEGxvuicZ/sw2anpL8NhpGFP
        JAQ9DdQZ47/4vvoBbPngMBg=
X-Google-Smtp-Source: ABdhPJyS9f8Bcaw6Mkh/wEM3XgB8NpO/ZpNR/imQZcS/ho+hAi7nGGv7efiAn479NGyK0OZepBZ2SA==
X-Received: by 2002:a7b:c44b:: with SMTP id l11mr17182208wmi.52.1599421732901;
        Sun, 06 Sep 2020 12:48:52 -0700 (PDT)
Received: from lenovo-laptop (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id f14sm25366512wrv.72.2020.09.06.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:48:52 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Sun, 6 Sep 2020 20:48:50 +0100
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: keystone: Enable compile-testing on !ARM
Message-ID: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
References: <20200904185609.171636-1-alex.dewar90@gmail.com>
 <CAJKOXPdjev5gMFBX8q6Q7ZZ1s3aBiGKOqfmrCQKTMGeXDeAoTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPdjev5gMFBX8q6Q7ZZ1s3aBiGKOqfmrCQKTMGeXDeAoTA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 06, 2020 at 02:19:44PM +0200, Krzysztof Kozlowski wrote:
> On Fri, 4 Sep 2020 at 20:56, Alex Dewar <alex.dewar90@gmail.com> wrote:
> >
> > Currently the Keystone driver can only be compile-tested on ARM, but
> > this restriction seems unnecessary. Get rid of it to increase test
> > coverage.
> >
> > Build-tested on x86 with allyesconfig.
> 
> You should at least build it on x86_64, powerpc and MIPS. These are
> widely available (e.g. in most of distros, or here:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/). Useful is also
> riscv and sh (specially sh lacks certain headers/features).

Good suggestion. I've built it on x86, ppc, mips and riscv. sh wouldn't
build because of some kbuild dependency, rather than a compiler error.
I'll send a v2 with an updated commit message.

> 
> Best regards,
> Krzysztof
