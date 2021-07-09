Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949563C23AB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGIMtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhGIMtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:49:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F7C0613DD;
        Fri,  9 Jul 2021 05:46:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 37so9881255pgq.0;
        Fri, 09 Jul 2021 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8Fdp0uOkotya/kKDIDVD2b894Pw0XhGKYmVcYD6eEw=;
        b=hlp54LnJJs1CAUdyxnywduEZx2aVQdAFjMZ8bC8CIlzhwsIHht8V/i8iGTF4+zFiCK
         xCnrf62Hh32UXJeClpw+fJORc5Zb99y2fguP0hGqJ3cwaUlHgEVkwMrwBXTiQsg4gFvI
         0IwtidDeeYjzxwdfVcHLlEdkXkZQoe+AWCeNP8DA/dWCChF+Q+wg+V7bB2IU5sMHNDug
         c2aDuywfrdNiPaI1lZMKJ0y04wCdV0XZwKvO9eD8rovvxqsPc7LmQrzGV7zHc2Z8ibR2
         MAB5ejjWMd6iRdI3GitBSJfVEzOb0hTiL02uCb6VzGB42U+DjNuMSH8p+8LwMyJqnDz0
         FT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8Fdp0uOkotya/kKDIDVD2b894Pw0XhGKYmVcYD6eEw=;
        b=oBM1ZWU9ymqswW9gbMvX+pW07f/qAw1hk4yRbw+ktzWz/Jm6daivG72qBCESGgRNMc
         DoZjS7GmLXor80fGqPHmm5yYVVVePApnr9qkZyqrPDiiQrZarroJapybvuGvqiFvvUaK
         xad/Ow+2zTqELyA0DAKsx6e9wAmdWdxMIQGMlItHoxYb7/lrx6Tj13qLcZsDrh5f5DT7
         1FLOv2Edw+5VJLZ4Lzlzcer3nvXESnIC2hlQy3CBOK8kI8SZ7dYsNaoS24l/at4D+EKD
         ujfp12bPibkHKq3j0xDri3PIJrgsRBin8+0ey1AIoa+crzd8/6ib7vyK0mpkGLlWxmqX
         8/YA==
X-Gm-Message-State: AOAM530tcKQl4kCRw7oXo8mxwfvWXnSVJpQOnvUx7fzErEoNf0YeaJLl
        YwholPdj6IOccp4RsZwOogY=
X-Google-Smtp-Source: ABdhPJzKpGnIHiI1mb1IZJRs4ZZ91CGKjEI3GaLhAcHodQ9xrHfMMD5ahjV0Hr4h/dfGJItBh0Ccqw==
X-Received: by 2002:a63:5345:: with SMTP id t5mr36500421pgl.167.1625834786944;
        Fri, 09 Jul 2021 05:46:26 -0700 (PDT)
Received: from localhost ([152.57.176.46])
        by smtp.gmail.com with ESMTPSA id e24sm6226808pfn.127.2021.07.09.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:46:26 -0700 (PDT)
Date:   Fri, 9 Jul 2021 18:16:21 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v10 0/8] Expose and manage PCI device reset
Message-ID: <20210709124621.ky3c6ip4wjrpsctr@archlinux>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/09 06:08PM, Amey Narkhede wrote:
> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.
>
> Expose the reset methods available per device to userspace, via sysfs
> and allow an administrative user or device owner to have ability to
> manage per device reset method priorities or exclusions.
> This feature aims to allow greater control of a device for use cases
> as device assignment, where specific device or platform issues may
> interact poorly with a given reset method, and for which device specific
> quirks have not been developed.
>
> Changes in v10:
> 	- Fix build error on ppc as reported by build bot
>
Aplogies for late response. For some reason I did not get email from
test bot. I checked spam folder too. Not sure if gmail messed something
up.

[...]
Amey
