Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF62D4E2F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 23:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbgLIWkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 17:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388582AbgLIWjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 17:39:33 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F3C061793
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 14:38:53 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id h16so3379849edt.7
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIQL03/zPKLYNtedDsrbaZi2weGw3ezzccqUR9STUu4=;
        b=l2Ft/LcFTKYXO8IPePZ2BYv+uOHAjdrRbZntfnElLBHe0ZXC/kvJFcPyKVcvQ7D6OC
         Ue0zE1ERVHPYKqttcjjlWhTf2s0uaI5dGJX558cBCfmdBjJ1YhR2q9I4hcqFMIhCBYy3
         f92ybU4JscstvCIPyOrP6FDwNOMpHmExMR79vy/Pj4pPSKHqUT3P0bs8gtHYCzBIqPXn
         Fy4Z9nV18PfB+jKufBdaYSEikISgiHZEhse+SqEI80SzefwRNMqhuD6qnXj77wM3zLRv
         x0eFWyAqda4DUVZB8Kibs4DJcmJymY00M84nFgWTcUnME/v7ZzJHl5gekjJF+o7j1PCB
         TvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIQL03/zPKLYNtedDsrbaZi2weGw3ezzccqUR9STUu4=;
        b=exR1iiPAv4T659zl0V/wUTvUXbMiONX+f1cJdrvEf7CxYly8Uk+Knbz8QwSHPkMOxL
         lyoYNwxPzFihI6JbJDd2z6jUcfJIA2Ejnxb1Qxl61kSjenrJtPS/Yq6hqImlj8UbXUk9
         ywEDa6kUiAia2ejbMf3hCH1afHhY+1rCb2sPVuZUqK2di4QLKPQPffse4H+M2mSRarEP
         70wHh/+Y9IGRq9DnHY/X+GLKahxHBFyQ+KbIUy7aBhm3bI+GX6SsZtkYxs1P16M4w0Ji
         YlzjQ+pUJkF/8JECqr22ji3rT6XazRMQ6BYAi48taVvGjnweZ4keJUCZlzAmTr9pWvtj
         unBA==
X-Gm-Message-State: AOAM530gvba3qNBzy6M5qQWkd9hRiJcgXhDbIkZkLv3S0H7eqijE8buZ
        NQ/Epp/CN1xlbzfXUEcwgi6MC7Bo/IUSdi6EfJThOg==
X-Google-Smtp-Source: ABdhPJzvDmJdBGoIr2bpKyfdZskmwNIku+gIOLs9wv4Je7JCUxMR5i7LKYt13r8VyhBfLKCIGVO74IGD7Ytc27nWDtM=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr4022893edw.52.1607553531849;
 Wed, 09 Dec 2020 14:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com> <20201209002418.1976362-12-ben.widawsky@intel.com>
In-Reply-To: <20201209002418.1976362-12-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 14:38:49 -0800
Message-ID: <CAPcyv4hRJRP+55QHxQYsAoE7V601+YMWgtEvzLimKRO8b4Jrjg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] cxl/mem: Add a "RAW" send command
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

On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The CXL memory device send interface will have a number of supported
> commands. The raw command is not such a command. Raw commands allow
> userspace to send a specified opcode to the underlying hardware and
> bypass all driver checks on the command. This is useful for a couple of
> usecases, mainly:
> 1. Undocumented vendor specific hardware commands
> 2. Prototyping new hardware commands not yet supported by the driver
>
> While this all sounds very powerful it comes with a couple of caveats:
> 1. Bug reports using raw commands will not get the same level of
>    attention as bug reports using supported commands (via taint).
> 2. Supported commands will be rejected by the RAW command.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c            | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h | 14 ++++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0bf03afc0c80..a2cea7ac7cc6 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -115,6 +115,7 @@ struct cxl_mem_command {
>
>  static struct cxl_mem_command mem_commands[] = {
>         CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
> +       CXL_CMD(RAW, TAINT, ~0, ~0, "Raw", true, 0),

Why is the taint indication in the ABI? It seems like it only needs to
be documented.

>  };
>
>  static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> @@ -326,6 +327,20 @@ static int cxl_mem_count_commands(void)
>         return n;
>  };
>
> +static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(mem_commands); i++) {
> +               struct cxl_mem_command *c = &mem_commands[i];
> +
> +               if (c->opcode == opcode)
> +                       return c;
> +       }
> +
> +       return NULL;
> +};
> +
>  /**
>   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
>   * @cxlmd: The CXL memory device to communicate with.
> @@ -421,6 +436,23 @@ static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
>         c = &mem_commands[cmd.id];
>         info = &c->info;
>
> +       /* Checks are bypassed for raw commands but along comes the taint! */
> +       if (cmd.id == CXL_MEM_COMMAND_ID_RAW) {
> +               struct cxl_mem_command temp =
> +                       CXL_CMD(RAW, NONE, cmd.size_in, cmd.size_out, "Raw",
> +                               true, cmd.raw.opcode);

Oh, I thought CXL_CMD() was only used to populate the mem_commands
array. Feels out of place to use it here when all it is doing is
updating the size_{in,out} and opcode fields. Mainly I'm interested in
CXL_CMD() enforcing that the command-id is the mem_commands index.

> +
> +               if (cmd.raw.rsvd)
> +                       return -EINVAL;
> +
> +               if (cxl_mem_find_command(cmd.raw.opcode))
> +                       return -EPERM;
> +
> +               add_taint(TAINT_WARN, LOCKDEP_STILL_OK);

TAINT_WARN seems the wrong value, especially since no WARN has
occurred. I feel that this is more in the spirit of
TAINT_PROPRIETARY_MODULE, TAINT_OVERRIDDEN_ACPI_TABLE, and
TAINT_OOT_MODULE. How about a new TAINT_RAW_PASSTHROUGH? I could use
this for the acpi/nfit driver as well to disclaim responsibility for
system errors that can result from not using the nominal
kernel-provided commands.
