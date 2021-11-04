Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD90C445211
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhKDLSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 07:18:32 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:45012 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 07:18:31 -0400
Received: by mail-wm1-f42.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso3971737wme.3;
        Thu, 04 Nov 2021 04:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOpeRyhSrWLhm7pnKwCXx+SDhg6aZqCSyZIAd5+foKg=;
        b=zIS2nlOPUIEz1/3FqwD9bHVYwpw3/sse5kwhM5KE/DkFfLk+nfjU86Eh3z/Rq+JzUH
         56QBDCVwfd81Rmx7auLli7mQd6MXh+lJ8d5AuSzXjT0Blr9pZLVOqAzUebC9iER5tWDB
         GwXUcEhBEJYVWCbc8IX0w08Zss1okBh8mybcjVbgnU7PB+NV6KQ4dX1wFixzM7G+Ni65
         G6M01EnFjwPUf2ylx+Fnp7mSdMsH8u+qlTHvBjLsLnJuigF1pqGvj9vh41d9xQUGFq2N
         qBuBlndBOtacILhuaAUVru4k7dF3rr5NAszC78f+Xv83bKkec4qIxfYU408xrne15bGi
         nXPw==
X-Gm-Message-State: AOAM532H9eaqSgkcWCzOfquzECICAEopjkUZa91yC8d7UawgMa9IToSe
        Gb4hZ24HsGIrzD1ehXGJiRA=
X-Google-Smtp-Source: ABdhPJwgYd/ahbGiqQu+IScVKbnJX4RZpTB9iy0joJeSCVXm8EZnzzJbn9tN2CgD43T0svvbgkHjKg==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr21194423wmi.151.1636024552847;
        Thu, 04 Nov 2021 04:15:52 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u16sm7897996wmc.21.2021.11.04.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:15:51 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:15:50 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] PCI: vmd: Remove duplicated include in vmd.c
Message-ID: <YYPA5rFIqYBCek+u@rocinante>
References: <20211104063720.29375-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104063720.29375-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -10,7 +10,6 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/device.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>

Wan, thank you for reporting this!

Bjorn, the patch I sent earlier:

  https://lore.kernel.org/all/20211013003145.1107148-1-kw@linux.com/

Accidentally left the include at the top that was intended to me moved to
be before the linux/msi.h to reflect previous order of the asm/device.h and
asm/msi.h had.

I must have forgotten to remove the one from the top later.  Sincere
apologies!

I can send an update, or we can squeeze these two patches together.  Sorry for
adding you more work to do.

	Krzysztof
