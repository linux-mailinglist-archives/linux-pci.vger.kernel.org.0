Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C746339750
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 20:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhCLTUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 14:20:24 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:35523 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbhCLTUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 14:20:07 -0500
Received: by mail-lj1-f172.google.com with SMTP id a1so8365346ljp.2;
        Fri, 12 Mar 2021 11:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ND/jgNT8ofFBknOpxvwxPuKEQnHAiAsxpDzmcQ2O248=;
        b=omJ8g+IGNqAItNEs1o0HFNdTsU33oW3S8DdnOVhlkB5dRANDtAfzFxRM2kvE0+wMwP
         5j9P99M9ptCAwbIyOr8UZE/uifNrHY8R7SkRmKukdve8VBU0I2H985144ljgKo/m/HZq
         N2MSXVC9px4LiAjtfp0G/ikIlZ5zsuxKUm2JAeg2pRBO2tNb/nOsHSiGc9Ru9N8wgUc5
         GyYv4bjkl2CTMfdj5aY09o3P6/ctulv4JBw71R0dYLfy9VFu2uk685AO4CbyStiZ5UJr
         fLWBaJYmVqBkrxCvH2rpDLRpLj3UCYesSCfsrS6yRvxoCanvoEGd55GkJl1m9OdRXrtb
         cK5Q==
X-Gm-Message-State: AOAM532v+9FlNmORdzkn728DgZlz+Xcpu6+p+FkNIjBUL1uZauKpPEYJ
        5kh1O38ZmoWgT5aALEx6rYs=
X-Google-Smtp-Source: ABdhPJxsNxrm8nTq+lRQDHurz91qvjnjjj0Yc2nIV9dX0S9ErvwEjevri2tGMDLzJiPChSnYQyfnPA==
X-Received: by 2002:a05:6512:224c:: with SMTP id i12mr426496lfu.520.1615576806260;
        Fri, 12 Mar 2021 11:20:06 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r1sm2042559ljn.71.2021.03.12.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:20:05 -0800 (PST)
Date:   Fri, 12 Mar 2021 20:20:04 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Message-ID: <YEu+5IIZ9KvIlPL4@rocinante>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312112043.3f2954e3@omen.home.shazbot.org>
 <20210312184038.to3g3px6ep4xfavn@archlinux>
 <YEu5vq4ACcupBpRC@rocinante>
 <20210312190649.hulyrpkdg6btn6y7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312190649.hulyrpkdg6btn6y7@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

[...]
> Basically whole thing boils down to I'm not good at handling terminal
> email clients. I'll surely keep those points mentioned by Bjorn
> in my mind.
[...]

No worries.  Thunderbird works fine with Google Mail and can send plain
text e-mails too, if you get tired of Mutt etc.

By the way, don't immediately send v2 quite yet.  Allow people some time
to review first version.  Well, unless you deem that you need to do it,
that is.

Krzysztof
