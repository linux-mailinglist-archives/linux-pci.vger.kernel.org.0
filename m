Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852942A90F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJLQHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 12:07:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF263C061570;
        Tue, 12 Oct 2021 09:05:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 187so17941496pfc.10;
        Tue, 12 Oct 2021 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMOxU6+YA/sNdOBxrd9xR6DIR92SPqX/cAtPGdDmVKU=;
        b=bDwa7qIkxxY4j1mjJTPYMU69RjYrf7BqhXHN8j96S+Q1bdbHT0UGhaGhYsTUiJzcgW
         Q+h23U6lvfXttX1Xr5f4SLw+YP6GMI8ma5BcESwFQjnv19d5Pzkx+Nf0QYEODQ4eEgJM
         5eEeI8PtE9M6SItS3znLiYEW5weFDD26ChmXer5Ekg1TKqcfTRSTZYQ1a1pv4TQLck5V
         znNWK4tc3AIMqY1oL4iNthKN5YOrxIq7RNDXuI1p9eWy6AjxderpQclUoKUtMnKWpIT+
         XYfzMq2vtlyWT7YiLP0mG+SqRjbsaj9tPcfTahwelLVbv5cjqooIZZTyX26bKICf8NhH
         ZyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMOxU6+YA/sNdOBxrd9xR6DIR92SPqX/cAtPGdDmVKU=;
        b=iKLUIRWCUGYZc1up70e98hsslut4TZqHfOXquf4sb+SXDvgKD9nZT2PAa6eah3dzh0
         LgO3xkis0dCq7nTt1PsB07UgxfcGQehB31N/7CD77kQUMKQeJTDLu14lERN9puKTe60K
         Nd+BQ8dvJgdS4nA+cPs+jWHKVCigfVHXxK8+cJNpJqwDfox0MiI5ZwCAgYZfi04Xs7GR
         EmVwsWc0U+Lt1t3ppP7TIMZ+jP4+5WamP+gpAy3GO1kuL3Wv9PvXwRu1RltmCigSSfao
         eY7GWsC9NyvVCChaQ0k0jZ3TvXPBDrljmzc1TjrYq4P9/TnPoGuTYxSbEsr1qtP+/U9Z
         /08Q==
X-Gm-Message-State: AOAM530uO/lUIEXQgiSHdZy/yk6ssfevVyD9t3LuDG7YCjyqRupSRPGe
        vg2S+87pV0/jKM7IUlfWs0e7IkbEZvem5Iwo
X-Google-Smtp-Source: ABdhPJw1IJ/QU67iU8+q118FcNosA5aecym8ZP3I99NBl9Ql4AcFwhi6Y+1cS+L7U0m4T9btUbxwfg==
X-Received: by 2002:a63:2b4b:: with SMTP id r72mr23056190pgr.57.1634054728858;
        Tue, 12 Oct 2021 09:05:28 -0700 (PDT)
Received: from theprophet ([2406:7400:63:cada:3b09:6c3b:61f5:2cfd])
        by smtp.gmail.com with ESMTPSA id m186sm11857248pfb.165.2021.10.12.09.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 09:05:27 -0700 (PDT)
Date:   Tue, 12 Oct 2021 21:35:13 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211012160505.3dov6gjnmxdq5lz6@theprophet>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
 <20211011194740.GA14357@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011194740.GA14357@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10, Lukas Wunner wrote:
> On Mon, Oct 11, 2021 at 11:37:33PM +0530, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> > data from hardware.
> 
> Actually what happens is that PCI read transactions *time out*,
> so the host controller fabricates a response.
>

Ah! yes. Now that I look at it, RESPONSE_IS_PCI_TIMEOUT() does indeed
seem like a better option to RESPONSE_IS_PCI_ERROR(), since it's more
specfic and depicts the actual condition. 

I'll wait for sometime and see if others have any objection/a better
name for the macro and then redo the patch with that.

Thank you very much for the review ^^ 

> By contrast, a PCI *error* usually denotes an Uncorrectable or
> Correctable Error as specified in section 6.2.2 of the PCIe Base Spec.
> 
> Thus something like RESPONSE_IS_PCI_TIMEOUT() or IS_PCI_TIMEOUT() would
> probably be more appropriate.  I'll leave the exact bikeshed color for
> others to decide. :-)
> 
> 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Acked-by: Lukas Wunner <lukas@wunner.de>
