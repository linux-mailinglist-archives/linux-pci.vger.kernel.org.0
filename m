Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBB25BFF7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICLPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgICLLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 07:11:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5CC061249;
        Thu,  3 Sep 2020 04:01:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so1836308pgm.7;
        Thu, 03 Sep 2020 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DEgrL1WqdyDp96QHpOBjswHW12HsyAvByI+w5af+1I=;
        b=DgUFp7W4BHAzcm7/LgTX2Fc1BO1sq9gKqpjsC2I/9qSrQExgNfPuGBXIRSxOWXozme
         ySmh3YYVU5QFZ+VFFuwoxF+P/k05Jt9mgxmmSzEyV3mwl8+8ylfaSmCuw0YLLeYDRI32
         9GdussqBn8kHj8gNLSZKL132p4vck8rhSER4R+KEFSlBzNv5ARgwyKd0oB8iBIT8eq+R
         JzEDWHPbo8ar9HvrRF1xogLTK0hfmYFd1EBtgKuRVl2WexthE/y40zYBqrdoAK2sOZKG
         C7Hkkp9W4d4CgY8K0MX8qvn77cDs5WBmHPfkB3ukSITD+gbjDKNZTWxCY/Q0FteWNhXz
         cOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DEgrL1WqdyDp96QHpOBjswHW12HsyAvByI+w5af+1I=;
        b=QjghZg8F4JHoa/rs4KQFwLC6mTbhIyZNXbbisCZuYdmAN9WR8tQrXRLbsvxkwJCk5z
         mWk74A9+VzTnCAYGk3HposoYmK7A2USUMJGd4BKCs1pbhxjjIJrE07K3yyVRuIpe/rRb
         adcdq2wVqY8n89REdnnNRvO6fmxk2WQ3zhBZU2b4ZFVNOzN1b2wLU4pCMsXvRkczzMuG
         vX4BU7QZAcI9P/vF/dUO8hhjjhGSU108BRCvfPT1Lcen9pmBZmAA218xF8+PVe8Hqx95
         wevBQ1VmaB/CuOq7Xk+8D6u+R+Kl56Lm9Wk7RI4NmW0l3gc/rHEUDvFrEZ3RsC8VCeMG
         yK5A==
X-Gm-Message-State: AOAM533Mw8xpwH3l9WFD5NnPo0rI4b6ndX43M4K+wqgqbvLbcFBgUCin
        M5YpfhumBik2e4ZRAsriGpPpZI2vCvJoZ93Zfs4=
X-Google-Smtp-Source: ABdhPJzWB8HoVy5iFsB5Op5vyLrnbRcI/Ap8Gp+5ZFJ0NzzhtqGslGDMIN9czc9ATfqg7sEcE+oUtEC2yQtpuLRRVv8=
X-Received: by 2002:a63:d648:: with SMTP id d8mr2507713pgj.4.1599130885521;
 Thu, 03 Sep 2020 04:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200831212606.1718-1-shiju.jose@huawei.com> <20200831212606.1718-3-shiju.jose@huawei.com>
 <20200901082607.GP1891694@smile.fi.intel.com> <7f5146dba8ac4ac0a258742551f204fb@huawei.com>
In-Reply-To: <7f5146dba8ac4ac0a258742551f204fb@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 14:01:08 +0300
Message-ID: <CAHp75Vd3wjNHdYC_A1EVV+kzN=6SGqP2qQ0Wb6pdZWWt9qMMLw@mail.gmail.com>
Subject: Re: [RESEND PATCH v14 2/2] PCI: hip: Add handling of HiSilicon HIP
 PCIe controller errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 3, 2020 at 1:43 PM Shiju Jose <shiju.jose@huawei.com> wrote:
> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >Sent: 01 September 2020 09:26
> >On Mon, Aug 31, 2020 at 10:26:06PM +0100, Shiju Jose wrote:
> >> From: Yicong Yang <yangyicong@hisilicon.com>

...

> >> +config PCIE_HISI_ERR
> >> +    depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
> >
> >> +    depends on ACPI
> >
> >Isn't this implied by
> >       drivers/acpi/Kconfig:45:if ACPI
> >?
>
> This can be removed as  ACPI_APEI_GHES depends on ACPI.
>
> Do you have any other comments on this patch?

Nope. The rest is fine to me.

> >> +    bool "HiSilicon HIP PCIe controller error handling driver"
> >> +    help
> >> +      Say Y here if you want error handling support
> >> +      for the PCIe controller's errors on HiSilicon HIP SoCs

-- 
With Best Regards,
Andy Shevchenko
