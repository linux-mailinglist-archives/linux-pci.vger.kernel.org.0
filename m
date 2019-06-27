Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC857981
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF0Cdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 22:33:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32897 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfF0Cds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 22:33:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so482094lfe.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2019 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpqYC0bettaQFGE+cPMxYMow71Zk/Lt7y+RJt1aO3ZA=;
        b=CUYJXh+O76PMEBZGgXYE4jBtsdtMsFSEbZO0ZPyGHzyh2zdxZqtKDI8UekfWutOZ/E
         YOB+X7vQ4M6jz4r3vtoOXStSuKF65tzQF2Hy2iAis1o6RYF834KH8sRjmjRZMHCwO+62
         MO4t7AD0yZgX9E1DKMcyzPLyDEPCd2COfseoooOnSJqaFvkUw9X7M0S0KF5v1b58crp0
         FwPaHIAzP4nqMXq7qwBG6huU7gkp8E3fXfbotKN6d/a7vZrhC6xBO1zFP3Kc95nRNozg
         3dUxkOYgiDhv7NyUXyrj5a+3L0Vv1LSR+WiWc3I9rNhxc1Mp1+3c7vN7Xszo0uMwbfZ+
         hNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpqYC0bettaQFGE+cPMxYMow71Zk/Lt7y+RJt1aO3ZA=;
        b=tMYkVDqgQLaiCpUx+dKH6o5BbqnHQsfHtNgFBMea2UXfW5pY+JCsB7Mwk+jeIeM6c9
         N9raPTdWk6vslucG1l08guubXfdJNOPfecFExFibYkSQMdIOa0YNYjOwIC/+jf9PLDZ2
         0xVeK4k8p8xlNzAqZaQJSwkfPKckDLQeRdrqYdIBmG9Fu6jxydmdXNiBXV0J2VKDc0cm
         lHmzh6D5X0JYxEN2MJpSw6uJpGVL/LYIeQwfYoWhGMffD/9SKbEzZKi8eKKpcb1aEhSC
         iWmxpx75T6ExaphH6fydmq3JoUKuqkPPHm7ArQgt+ysju+aQk0IlmOAbc9hPsnod+eVK
         5GEw==
X-Gm-Message-State: APjAAAXvZ1Rd1TKluFq69+Ltj/3s2wM8DZdGh7WJkgbjFfJ5IeN7crND
        guR+63u6W1DgJ92QRejdF8stCw==
X-Google-Smtp-Source: APXvYqwVm7ApFldCcgUkF3KiAVNAlR3f2LErwu5ylCjWa4dtUcO2yDmcrQXQfnSFhvIyODaUbhq7dQ==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr662754lfm.120.1561602825764;
        Wed, 26 Jun 2019 19:33:45 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k12sm117397lfm.90.2019.06.26.19.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:33:43 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:19:37 -0700
From:   Olof Johansson <olof@lixom.net>
To:     John Garry <john.garry@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        jinying@hisilicon.com, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
Message-ID: <20190627021937.kk4lklv2uz3mogoq@localhost>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
 <20190625112148.ckj7sgdgvyeel7vy@localhost>
 <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
 <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 02:31:26PM +0100, John Garry wrote:
> On 25/06/2019 14:03, Olof Johansson wrote:
> > > > are available in the Git repository at:
> > > > > >
> > > > > >   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
> > > > > >
> > > > > > for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
> > > > > >
> > > > > >   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
> > > > > >
> > > > > > ----------------------------------------------------------------
> > > > > > Hisilicon fixes for v5.2-rc
> > > > > >
> > > > > > - fixed RCU usage in logical PIO
> > > > > > - Added a function to unregister a logical PIO range in logical PIO
> > > > > >   to support the fixes in the hisi-lpc driver
> > > > > > - fixed and optimized hisi-lpc driver to avoid potential use-after-free
> > > > > >   and driver unbind crash
> > > >
> > > > Merged to fixes, thanks.
> > 
> > This broke arm64 allmodconfig:
> > 
> >        arm64.allmodconfig:
> > drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
> > 'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
> > [-Werror=implicit-function-declaration]
> > 
> > 
> 
> Uhhh, that's my fault - I didn't provide a stub for !ACPI. Sorry. I'll send
> a fixed v3 series.

No worries, it happens -- but it's good if maintainers do at least a few test
builds before sending in pull requests so we don't catch all of it at our end.


-Olof
