Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D2315A98
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 01:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhBJAFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 19:05:31 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:46666 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhBIXo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 18:44:27 -0500
Received: by mail-lf1-f49.google.com with SMTP id v5so84846lft.13;
        Tue, 09 Feb 2021 15:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yGmWhoja/hQOYUa2PNDucYo9KJYqOoWVC1/FBOW7ZLs=;
        b=CSwu8RNl0F3aLFNUa2Zhqv/aqOr5LKZ/7NneX13EyvlbISAlqrLqBhJJJ7UJZwfvI+
         quS89wObQiz7ojngCi7DM6T1jhylHQ+3XWcBSnVAZ01C4E0m29wEPc2lZDcW/Y4PPIgj
         Ed+riKLtmJ/w0egBe6Fl2kBCYicFdUj3zXYSdcrTD0bV+BuxOFh1lSlbK4bSqNCyr+Zr
         6vxTkKRcP49eVDXmEZhzL2lesOGyuY3FZAzp4583OpXKBd2/cQzuy9xfvmQkbKlaxs+y
         1YY45uwPdPHt4Ie5OGc+I4YVy/5AJXOOJdrs2IYwIjMa1PXanRmjlQhXnQXYL8A35VGG
         nQuw==
X-Gm-Message-State: AOAM530yQyCHG82gFfpTcdg633sDyv2vKJlhv6/9F2IzsgNc+1VYcVPt
        fcfEWP7xYbEkJLY4Epoaof8=
X-Google-Smtp-Source: ABdhPJxx6hda2CiPB5yiesOFRVWCjUTcZerPAMRTqgFm5S+ShAghK/pTP616i1cMawpsbVKWyUk2/w==
X-Received: by 2002:ac2:544c:: with SMTP id d12mr172177lfn.585.1612914223533;
        Tue, 09 Feb 2021 15:43:43 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u6sm21519lji.63.2021.02.09.15.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:43:42 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:43:41 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@openeuler.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Message-ID: <YCMeLS1Vd2YQuWmQ@rocinante>
References: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
 <20210209212510.GA513360@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209212510.GA513360@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you!  This looks great!

[...]
> commit e8e9aababe60 ("PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy")
> Author: Junhao He <hejunhao2@hisilicon.com>
> Date:   Thu Feb 4 19:30:15 2021 +0800
> 
>     PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy
>     
>     CONFIG_PCI_DEBUG=y adds -DDEBUG to CFLAGS, which enables things like
>     pr_debug() and dev_dbg() (and hence pci_dbg()).  Previously we added
>     -DDEBUG for files in drivers/pci/, but not files in subdirectories of
>     drivers/pci/.
>     
>     Add -DDEBUG to CFLAGS for all files below drivers/pci/ so CONFIG_PCI_DEBUG
>     applies to the entire hierarchy.
>     
>     [bhelgaas: commit log]
>     Link: https://lore.kernel.org/r/1612438215-33105-1-git-send-email-yangyicong@hisilicon.com
>     Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>     Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 11cc79411e2d..d62c4ac4ae1b 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG

And thank you again, Yicong, for fixing this.  Much appreciated.

Krzysztof
