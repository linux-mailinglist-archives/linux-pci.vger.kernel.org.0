Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FE38F46B
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhEXUeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhEXUe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 16:34:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99846C061574;
        Mon, 24 May 2021 13:32:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q67so4752395pfb.4;
        Mon, 24 May 2021 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qJcO70sr7yP3+DUAooohk7hGAbCdhh2b83zx22V/NxA=;
        b=YYFrBODAaSAmB+q9ZGXfZL5VkiIQwK7CzJnzBaKrH64lh5MOCBKA3qZ1DCp66LaGs8
         JWh+6lSVvEsJe7MzYRqjwlRBKI0oBi/NoALfInMvOwYF3js3FZvFL/xupL6/zXFeBbJG
         s9IxY8997sbBBtrofPVs07Xwo80z3JJrBeYCeUWpLJdtQwZbWobmUKmSWiHdAfAJVZH2
         HSXTgYRGl1zODNx7x6aInnmcRIsLwgp57bP+1H13NB6CtFjEyJo7olmaJqWdXgz1MYrD
         cT1wb9BmzwGoDZhVZ/0dlqr+UQHqpqrco8VDOWTW5dMc8x3FsaFu4pVmMG1ElC5Q2SD+
         FXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJcO70sr7yP3+DUAooohk7hGAbCdhh2b83zx22V/NxA=;
        b=ASku3C5ARZLQB9xy7YxcRUKuMnK0H3/uT5nMdUop+2D882SZyXwidoUn4oKXbyQygT
         rmhDCujDdQTruQorjOkdd6AGgUCjuP9qoaRNsZ+jsOfVVCbGAh0cstmLM3WhDNpmG5Zg
         w/VPwEtoD8uWwIU08BMkoZLAZS4gocW6EN2j36UvCKme030GzWwLmGYglUMHjMgXix8b
         T4OfbMl+jqZ/4URlEFN8xQzD6jfpknoYJE/GX6PJ8rXx1K9n6F2/ePcyA8aOW0qJqSJO
         /Wxq9yTBAglZ0UJJbU4AVN/qIEvBc33tkhRadhSyG1lJxTwKCvsxJLBy1mEjJBwd0MLU
         5Biw==
X-Gm-Message-State: AOAM530XsIK2sMm/aCsvbwPvEAA30FUJW9NUCK/vJjAbUImYK+yCcsNJ
        26nK9728rP4fu9sFruGDESJlo5ytZKleCA==
X-Google-Smtp-Source: ABdhPJze8OGjR8VsQN1Cr66K11ljRJfpJHJ5vQuDcI8htZdEiDjGgPAGIDU+QUZBJqQL6Y+B0DYd3g==
X-Received: by 2002:a65:654a:: with SMTP id a10mr15198968pgw.443.1621888376010;
        Mon, 24 May 2021 13:32:56 -0700 (PDT)
Received: from localhost ([103.248.31.164])
        by smtp.gmail.com with ESMTPSA id n8sm11379670pff.167.2021.05.24.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:32:55 -0700 (PDT)
Date:   Tue, 25 May 2021 02:02:53 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] PCI: Check value of resource alignment before using
 __ffs
Message-ID: <20210524203253.xwpq7tmah2vrew7l@archlinux>
References: <20210422105538.76057-1-ameynarkhede03@gmail.com>
 <YIFWhL9RvwZJdnAB@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFWhL9RvwZJdnAB@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/22 01:57PM, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 04:25:38PM +0530, Amey Narkhede wrote:
> > Return value of __ffs is undefined if no set bit exists in
> > its argument. This indicates that the associated BAR has
> > invalid alignment.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/setup-bus.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
A gentle ping :)
