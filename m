Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47304216F18
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGOpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGGOpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 10:45:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B64C08C5E2
        for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2020 07:45:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so45454533wrn.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2020 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRi5dL4kQrmUCECuqd6eWlOROk0aWQtTVaEBXrLXt14=;
        b=R/b1Xo7qEbzdwTncWlbC+d3clQ34dlTOrCGN1/ILLiVn4RJXQqtn858I5OVzb+avNV
         tVZ+VU654n3B2bCYt9FINONRQqz+bKuFs0QijtWCJOoX9HwG+UNJrxZdovAQajftzTsp
         lQGjP34g0JgjTCRZs4+TwHZ2+PqczW5VvmSO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRi5dL4kQrmUCECuqd6eWlOROk0aWQtTVaEBXrLXt14=;
        b=FnHX67lNBFYg+OZXKmakizkAk2AFPwLMwD8izAOQA6QNZJKI3/sCSbtMHsEWcXYUpd
         DK9VOY9uayPT0oIDDvF+Cbq7/XwKAuiWh0b3ikKegbMfwlCx/j12C7hiWE477EvMwcN2
         XbpEjFai19pIAURq4EkOqi9HaBRqAnAlxtmoJUawu+bGqFuQ5FP1LwC35JzhqyK5Omcx
         RTpkt4TS7myWjkADGpgpdle/lNdrLFNtxgffMhNo4GX2lSSdtqx+MmxUAHo+obhebOJY
         vOlfYpiPXblDL+1ZddSHqnwBNSrCzGvo61k4ssBP9siKlyZyw7C5rYc5Y6fMrsUcNKiq
         ouvA==
X-Gm-Message-State: AOAM533C+fMCJ24USf18hHiTJq1/oAj65ggCYQJnD3JBxFt8nvkfJYIc
        /N0+lRW51pATpuiP/5OtYUq+ZtwVvlEbGqVxmHpgn9xb7R5kGhTH
X-Google-Smtp-Source: ABdhPJyhIPa3U1bTW7UlULocCH4eT2T0NxtMN2UWRMtL2ZRIuBeALk/agL6ONyjaajr2oy9MkkK3mpYlKMLOkhB7VqA=
X-Received: by 2002:adf:edc6:: with SMTP id v6mr54744665wro.413.1594133102091;
 Tue, 07 Jul 2020 07:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200701212155.37830-9-james.quinlan@broadcom.com> <20200707132724.GT2549@kadam>
In-Reply-To: <20200707132724.GT2549@kadam>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 7 Jul 2020 10:44:50 -0400
Message-ID: <CA+-6iNwzQ0gn2KfdqNGwGjDgPT5op8bTCs6paMT7BwVmm+9vTw@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>, lkp@intel.com,
        kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rich Felker <dalias@libc.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Hanjun Guo <guohanjun@huawei.com>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

On Tue, Jul 7, 2020 at 9:27 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Jim,
>
> url:    https://github.com/0day-ci/linux/commits/Jim-Quinlan/PCI-brcmstb-enable-PCIe-for-STB-chips/20200702-053156
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm-randconfig-m031-20200701 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/of/address.c:1012 of_dma_get_range() warn: passing zero to 'ERR_PTR'
>
> # https://github.com/0day-ci/linux/commit/0c50b6db383883854419f10df0d79b663433f121
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 0c50b6db383883854419f10df0d79b663433f121
> vim +/ERR_PTR +1012 drivers/of/address.c
>
> 18308c94723e16 Grygorii Strashko 2014-04-24   955  /**
> 0c50b6db383883 Jim Quinlan       2020-07-01   956   * of_dma_get_range - Get DMA range info and put it into a map array
> 18308c94723e16 Grygorii Strashko 2014-04-24   957   * @np:              device node to get DMA range info
> 18308c94723e16 Grygorii Strashko 2014-04-24   958   *
> 18308c94723e16 Grygorii Strashko 2014-04-24   959   * Look in bottom up direction for the first "dma-ranges" property
> 0c50b6db383883 Jim Quinlan       2020-07-01   960   * and parse it.  Put the information into a DMA offset map array.
> 0c50b6db383883 Jim Quinlan       2020-07-01   961   *
> 18308c94723e16 Grygorii Strashko 2014-04-24   962   * dma-ranges format:
> 18308c94723e16 Grygorii Strashko 2014-04-24   963   *   DMA addr (dma_addr)     : naddr cells
> 18308c94723e16 Grygorii Strashko 2014-04-24   964   *   CPU addr (phys_addr_t)  : pna cells
> 18308c94723e16 Grygorii Strashko 2014-04-24   965   *   size                    : nsize cells
> 18308c94723e16 Grygorii Strashko 2014-04-24   966   *
> 0c50b6db383883 Jim Quinlan       2020-07-01   967   * It returns -ENODEV if "dma-ranges" property was not found for this
> 0c50b6db383883 Jim Quinlan       2020-07-01   968   * device in the DT.
> 18308c94723e16 Grygorii Strashko 2014-04-24   969   */
> 0c50b6db383883 Jim Quinlan       2020-07-01   970  const struct bus_dma_region *of_dma_get_range(struct device_node *np)
> 18308c94723e16 Grygorii Strashko 2014-04-24   971  {
> 0c50b6db383883 Jim Quinlan       2020-07-01   972       const struct bus_dma_region *map = NULL;
> 18308c94723e16 Grygorii Strashko 2014-04-24   973       struct device_node *node = of_node_get(np);
> 0c50b6db383883 Jim Quinlan       2020-07-01   974       struct of_range_parser parser;
> 18308c94723e16 Grygorii Strashko 2014-04-24   975       const __be32 *ranges = NULL;
> 951d48855d86e7 Robin Murphy      2019-07-03   976       bool found_dma_ranges = false;
> 7a8b64d17e3581 Rob Herring       2020-02-06   977       struct of_range range;
> 0c50b6db383883 Jim Quinlan       2020-07-01   978       int len, num_ranges = 0;
> 0c50b6db383883 Jim Quinlan       2020-07-01   979       int ret = 0;
> 18308c94723e16 Grygorii Strashko 2014-04-24   980
> 951d48855d86e7 Robin Murphy      2019-07-03   981       while (node) {
> 18308c94723e16 Grygorii Strashko 2014-04-24   982               ranges = of_get_property(node, "dma-ranges", &len);
> 18308c94723e16 Grygorii Strashko 2014-04-24   983
> 18308c94723e16 Grygorii Strashko 2014-04-24   984               /* Ignore empty ranges, they imply no translation required */
> 18308c94723e16 Grygorii Strashko 2014-04-24   985               if (ranges && len > 0)
> 18308c94723e16 Grygorii Strashko 2014-04-24   986                       break;
> 18308c94723e16 Grygorii Strashko 2014-04-24   987
> 951d48855d86e7 Robin Murphy      2019-07-03   988               /* Once we find 'dma-ranges', then a missing one is an error */
> 951d48855d86e7 Robin Murphy      2019-07-03   989               if (found_dma_ranges && !ranges) {
> 951d48855d86e7 Robin Murphy      2019-07-03   990                       ret = -ENODEV;
> 951d48855d86e7 Robin Murphy      2019-07-03   991                       goto out;
> 18308c94723e16 Grygorii Strashko 2014-04-24   992               }
> 951d48855d86e7 Robin Murphy      2019-07-03   993               found_dma_ranges = true;
> 18308c94723e16 Grygorii Strashko 2014-04-24   994
> 951d48855d86e7 Robin Murphy      2019-07-03   995               node = of_get_next_dma_parent(node);
> 951d48855d86e7 Robin Murphy      2019-07-03   996       }
> 951d48855d86e7 Robin Murphy      2019-07-03   997
> 951d48855d86e7 Robin Murphy      2019-07-03   998       if (!node || !ranges) {
> 0d638a07d3a1e9 Rob Herring       2017-06-01   999               pr_debug("no dma-ranges found for node(%pOF)\n", np);
> 18308c94723e16 Grygorii Strashko 2014-04-24  1000               ret = -ENODEV;
> 18308c94723e16 Grygorii Strashko 2014-04-24  1001               goto out;
> 18308c94723e16 Grygorii Strashko 2014-04-24  1002       }
> 18308c94723e16 Grygorii Strashko 2014-04-24  1003
> 7a8b64d17e3581 Rob Herring       2020-02-06  1004       of_dma_range_parser_init(&parser, node);
> 7a8b64d17e3581 Rob Herring       2020-02-06  1005
> 0c50b6db383883 Jim Quinlan       2020-07-01  1006       for_each_of_range(&parser, &range)
> 0c50b6db383883 Jim Quinlan       2020-07-01  1007               num_ranges++;
> 18308c94723e16 Grygorii Strashko 2014-04-24  1008
> 0c50b6db383883 Jim Quinlan       2020-07-01  1009       map = dma_create_offset_map(node, num_ranges);
>                                                         ^^^
> If this fails then "ret" is zero so the function returns NULL instead of
> an error pointer.

I'm not sure I see what is wrong with this; perhaps my usage is
unorthodox and has triggered this warning.   The return of

        map = of_dma_get_range(....);

can mean one of three things:

1. Failure, ret = PTR_ERR(map) gives the errno.
2. Success, map is a valid memory pointer   /* occurs when there are
"dma-ranges" */
3. Success, map is the NULL pointer and ret = PTR_ERR(map) yields  0.
/* occurs when there are no "dma-ranges" */

After calling this function I do this

        ret = IS_ERR(map) ? PTR_ERR(map) : 0;

which will be replaced in the next version with this:

        ret = PTR_ERR_OR_ZERO(map);

If ret == 0 I do the assignment

        dev->dma_range_map = map;

which is exactly what I want.  Please advise if action on my part is
still required.

Thanks,
Jim Quinlan
Broadcom STB

>
> 18308c94723e16 Grygorii Strashko 2014-04-24  1010  out:
> 18308c94723e16 Grygorii Strashko 2014-04-24  1011       of_node_put(node);
> 0c50b6db383883 Jim Quinlan       2020-07-01 @1012       return map ? map : ERR_PTR(ret);
> 92ea637edea36e Santosh Shilimkar 2014-04-24  1014
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
