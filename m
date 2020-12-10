Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3C2D4FAF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgLJAn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 19:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgLJAnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 19:43:10 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524DC0613D6
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 16:42:30 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id dk8so3675240edb.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 16:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNvEsgxEU6uZTR1Us7I6r4YjbSGdWuf43XtWg1h/ZjQ=;
        b=kj91qDjjmmSRx9Y9wZ28xrM4ILAD7D+wZc32csdO3Abd86CcS8AIaktID/pLpeWAy9
         Lg4z817plMRMoe59ZWqcK/04+BfENFz0xADon2k4MolNMPPs+lkzHdmDTFXNLFDXK3Q8
         YqyJGSCuhZpYUehX2ELEtQVWjQ59/V+8xNz60ZcxdhYRDK2i/r6c+aP372zYUKxjHx0V
         05JeQeIAdF6IAVr+UwxZD6mt9PXXBE0DddWLQZ/IY1T6dR5DjDPHmDTKa7zlnffIZlTU
         3kTU8HPQQb0S9ei8mEk9AessjYqLRVZhdteyNoISDjfhJUaFIUaTYj6um7CWEJw45/Jk
         OQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNvEsgxEU6uZTR1Us7I6r4YjbSGdWuf43XtWg1h/ZjQ=;
        b=YogvJlkG2xFg7B3MRuMchXLm0ya777FyhuxK6/sBszmGu2hUqbh01cpjWrFKDdHcNP
         eoPj5Uym0F+NNFjwdSL/qfoIPSTHENFb3j0E5/SLSkfQLjTcwev+HEpnbMKNchLuY9k9
         QiGozMg2YEgXA/DYztOTeBhOc0qyXlyH64BYDhJ1xgyoI7hBgYuoVW4hyJLg6HOlZgM5
         FuvHPqMuwxHyXGIuwkrCUQpJ3VRYU60bnb2OWR3w1QCQ2MwPLZNdd9/Vz1+00R4z6wdK
         IBJLpgMGLQ2NeGjfL05iPp0qJcTZneZ0D27GYGxREjR0g6nRCk2IwyVOco4i1VOftrGK
         N/Sg==
X-Gm-Message-State: AOAM533ncCovibGyZ4KZa5UCGgAbeP69C8tY+6AxnAbHipZfEhYInpvs
        MdYWaUP6yxl4QONufG+aC1R6f5bhbNX1w+z6k0pUFw==
X-Google-Smtp-Source: ABdhPJxkEYy1l4Dzzh42MlB1DBuPbdpyEYWjS7i+HtHHCrX01UWMKJujV74kKgE5AM/PYa95sJsQEEPdm4fu6DF/EhY=
X-Received: by 2002:a50:8a44:: with SMTP id i62mr4336434edi.97.1607560948709;
 Wed, 09 Dec 2020 16:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com> <20201209002418.1976362-15-ben.widawsky@intel.com>
In-Reply-To: <20201209002418.1976362-15-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 16:42:26 -0800
Message-ID: <CAPcyv4hTP+AQ_h7SfeJPjMORqArTWp-6KWPA3Eu=-dmpo1B0AA@mail.gmail.com>
Subject: Re: [RFC PATCH 14/14] WIP/cxl/mem: Add get firmware for testing
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 8, 2020 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> This also serves as an example how to add a new command
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c            | 22 ++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |  3 ++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6b2f8d3776b5..76aa1e6e4117 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -116,6 +116,7 @@ struct cxl_mem_command {
>  static struct cxl_mem_command mem_commands[] = {
>         CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
>         CXL_CMD(RAW, TAINT, ~0, ~0, "Raw", true, 0),
> +       CXL_CMD(GET_FW_INFO, NONE, 0, 0x50, "Get FW Info", false, 0x0200),

I think CXL_CMD() arguments can be put on a diet if the
mem-command-id-to-name was moved to its own table, and the opcode was
defined as something like:

#define CXL_MBOX_OP_GET_FW_INFO 0x200

...so that CXL_CMD can just do:

    .opcode = CXL_MBOX_OP_##_id

That @_enable arg wants a flag #define like CMD_ENABLE which reads
better than 'true'. I would then add CMD_KERNEL_EXCL alongside that
flag to indicate the commands that may be exclusive to the kernel when
the device is active in a PMEM memory region, or ones that have an
alternate ABI wrapped around them like the keys subsystem for security
or the firwmare activation sysfs interface.

>  };
>
>  static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> @@ -827,6 +828,23 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>         return cxl_register(dev);
>  }
>
> +static int cxl_mem_enable_commands(struct cxl_mem *cxlm)
> +{
> +       struct cxl_mem_command *c;
> +
> +       /*
> +        * For now we pretend Get FW info is supported.
> +        *
> +        * FIXME: Invoke GET LOG to get the Command Effect Logs (CEL).
> +        */
> +       c = cxl_mem_find_command(0x200);
> +       if (!c)
> +               return -ENOENT;
> +
> +       c->enable = true;
> +       return 0;
> +}
> +
>  /**
>   * cxl_mem_identify() - Send the IDENTIFY command to the device.
>   * @cxlm: The device to identify.
> @@ -936,6 +954,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (rc)
>                 return rc;
>
> +       rc = cxl_mem_enable_commands(cxlm);
> +       if (rc)
> +               return rc;
> +
>         rc = cxl_mem_identify(cxlm);
>         if (rc)
>                 return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index f2fbb0dcda06..3ac39acf8fa7 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,7 +50,8 @@ struct cxl_command_info {
>         __u32 id;
>  #define CXL_MEM_COMMAND_ID_INVALID 0
>  #define CXL_MEM_COMMAND_ID_RAW 1
> -#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_RAW + 1)
> +#define CXL_MEM_COMMAND_ID_GET_FW_INFO 2
> +#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_GET_FW_INFO + 1)

Seems like CXL_MEM_COMMAND_ID definitions want to be an enum so that
CXL_MEM_COMMAND_ID_MAX does not need to be touched every time.

>
>         __u32 flags;
>  #define CXL_MEM_COMMAND_FLAG_NONE 0
> --
> 2.29.2
>
