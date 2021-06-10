Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4723A2F2D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFJPUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 11:20:31 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39438 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFJPUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 11:20:30 -0400
Received: by mail-pf1-f177.google.com with SMTP id k15so1892915pfp.6
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mS2MKuQ1MIt5zD53BiXmwH5v3s+3aSWZOMRcLFPuyQQ=;
        b=aQo9cpvxebrDYW33Evapw/yzHiQs2RxOy61K7n6IgoUxXfISlrgVfdnJDR4OZgqovP
         yYwwBdVs3foftayF4m2A9wfEOAncKKn2BRzh1HtIvcmSvLMtsw/HHxtzrcY1+psDLHsc
         40TLCaGdp6NniC1rGVV5GIPP6vudH01wEdeJmKMaXJ95lJq3OLJDIqsTRGzNTM4OJrpa
         DwZpfxIW+A4Mqvse8uOyl2SMZ8N6V+1Oi9kbUwhek03aEk400N9J9eKocfp3NckjiLen
         FCAX3l3f1J1Ln8lqWl6H4IoUj9GnbnYM3FT3hXAZR6WPQh4m/nDjCW4F0zDww18ZIQEC
         WcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS2MKuQ1MIt5zD53BiXmwH5v3s+3aSWZOMRcLFPuyQQ=;
        b=bVcGOh0WSEVj9K4/uPvYRy7C193anYI4AMF9tr6lCyuVrkuHSERLq6IHe2qDj+a5xL
         UdCzHDlkflVERhGTH4hO8PxblMS8QTdBPN+wREKegB1lGiPwx4ysA5yloxznwK9aIN38
         FYG53di6WbvJNuLsf/NElnLvHWzWFCC1JxgqBtFws4m89k9v71pfmjVid+UXPN0wuHuC
         WxDwFx+e7uP32CkpHiP/nICHszPzkikVfTrn1bYGrA/oQpzO2Rag5vJ1wbG5BJGywjxa
         nsrHiDKg9pUUb/KdIbMfxmqo8KrXLx9iXecvYOjbEakkdTxFNwy+aqVZp2R20vp3eLD0
         pvjA==
X-Gm-Message-State: AOAM5316lyj9kCQp88ly09LinSB6S8I2LCFRscUHUniRrCpVoslWNBSu
        jfM6Fea7/8ycHSxKiwAL03g+yJttGpIF7yi8aBJfBw==
X-Google-Smtp-Source: ABdhPJwEZL6AolcfQZhCtpeWi9L4JRznxZSkG0jfVSTQeMveEIT9vlfwlPBapoWue5ubB3fyFFQoiZkPFIhMAYJAY0g=
X-Received: by 2002:a62:8287:0:b029:2ec:9b1f:9c0a with SMTP id
 w129-20020a6282870000b02902ec9b1f9c0amr3541997pfd.31.1623338254593; Thu, 10
 Jun 2021 08:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com> <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 08:17:23 -0700
Message-ID: <CAPcyv4i5-d6HrhQwUmjx7HqKA+pr8aQjPGHJ=7Sh3eTgJ1UKyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PCI: Add vendor ID for the PCI SIG
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> This ID is used in DOE headers to identify protocols that are defined
> within the PCI Express Base Specification.
>
> Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..dcc8b4b14198 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,7 @@
>  #define PCI_CLASS_OTHERS               0xff
>
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> +#define PCI_VENDOR_ID_PCI_SIG          0x0001

Should this not be:

PCI_DOE_VENDOR_ID_PCI_SIG?

...because I don't think this value will ever show up at the typical
config-offset 0 vendor-id, will it?
