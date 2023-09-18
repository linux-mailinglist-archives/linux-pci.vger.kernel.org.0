Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B77A51F0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIRSXE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Sep 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 14:23:03 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D9FB;
        Mon, 18 Sep 2023 11:22:57 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-578a49f7e57so658140eaf.1;
        Mon, 18 Sep 2023 11:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695061377; x=1695666177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieBf/hMr/hpAEX/C0CiEwBQf3tOTKGFzMMH/tQKhbPE=;
        b=KZmhXmZH7fGZQDuFh42Y3TbgpxtOzE36C5ZSVLWJAAKRd5xmi7O0aq5HP2Q7F7n7SE
         r1a7nqnu552CXhLDame9x4oLgoeGR48YsJebCK9+/ES5P/s0kLiTHKTqTFNidu9M9K7p
         1I/jFcwowPqiboF8ZTf5TKsppU3NKfPbuQl3dBKUzk2Q4stZPEf7G9nMrzqrTvVqz9wo
         kO0eSIW0fQlLm2UZjqtEZH/kUmD/QYyFW+ZJpufHIAv/PDO+FfE1zysrSTdm78R2A8e7
         1fSmrVfuAVpl5l9sjLFdsooQ2x8Ku0jnl8ec9xTADxphUnu1LkxMa7fKJMYOUWfU+v4a
         jNJw==
X-Gm-Message-State: AOJu0YyaBoVjHtnhI2xk06pa1dEArcF3wwKG5Sr5/ptfSSlSAqapspVa
        wnCsudocrftp2oaVYuQQqQzPW6BDYk4W7nAYW5o=
X-Google-Smtp-Source: AGHT+IEaxW9g0SbTeoSTZfJFHWBgYiwc3lG+mmAMfTzaneCYLI8jeEpdntTA2GIHBSt3y0As+RrAVWpzfYS6FivWl7Q=
X-Received: by 2002:a4a:de83:0:b0:56e:94ed:c098 with SMTP id
 v3-20020a4ade83000000b0056e94edc098mr8897573oou.0.1695061376820; Mon, 18 Sep
 2023 11:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <c1a4d76b89c44437b328fe8a6d3517dc@huawei.com> <20230918181644.GA197123@bhelgaas>
In-Reply-To: <20230918181644.GA197123@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 20:22:45 +0200
Message-ID: <CAJZ5v0jRRHqRttovFC-sqtW-XhCS_VUAZnshRfUcQHTpygHT=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / APEI: Fix for overwriting aer info when
 error status data have multiple sections
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 8:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Rafael, probably the logical place to apply this]
>
> On Mon, Sep 18, 2023 at 01:07:45PM +0000, Shiju Jose wrote:
> > >-----Original Message-----
> > >From: Bjorn Helgaas <helgaas@kernel.org>
> > > ...
>
> > >On Sat, Sep 16, 2023 at 01:44:35AM +0800, shiju.jose@huawei.com wrote:
> > >> From: Shiju Jose <shiju.jose@huawei.com>
> > >>
> > >> ghes_handle_aer() lacks synchronization with
> > >> aer_recover_work_func(), so when error status data have multiple
> > >> sections, aer_recover_work_func() may use estatus data for
> > >> aer_capability_regs after it has been overwritten.
> > >>
> > >> The problem statement is here,
> > >> https://lore.kernel.org/all/20230901225755.GA90053@bhelgaas/
> > >>
> > >> In ghes_handle_aer() allocates memory for aer_capability_regs from the
> > >> ghes_estatus_pool and copy data for aer_capability_regs from the
> > >> estatus buffer. Free the memory in aer_recover_work_func() after
> > >> processing the data using the ghes_estatus_pool_region_free() added.
> > >
> > >Thanks for working this up!  I had it on my to-do list, but
> > >obviously had not gotten to it yet.
> > >
> > >> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > >> ---
> > >>  drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
> > >>  drivers/pci/pcie/aer.c   | 10 ++++++++++
> > >>  include/acpi/ghes.h      |  1 +
> > >>  3 files changed, 33 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> > >> ef59d6ea16da..63ad0541db38 100644
> > >> --- a/drivers/acpi/apei/ghes.c
> > >> +++ b/drivers/acpi/apei/ghes.c
> > >> @@ -209,6 +209,20 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
> > >>    return -ENOMEM;
> > >>  }
> > >>
> > >> +/**
> > >> + * ghes_estatus_pool_region_free - free previously allocated memory
> > >> + *                                   from the ghes_estatus_pool.
> > >> + * @addr: address of memory to free.
> > >> + * @size: size of memory to free.
> > >> + *
> > >> + * Returns none.
> > >> + */
> > >> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size) {
> > >> +  gen_pool_free(ghes_estatus_pool, addr, size); }
> > >> +EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
> > >> +
> > >>  static int map_gen_v2(struct ghes *ghes)  {
> > >>    return
> > >> apei_map_generic_address(&ghes->generic_v2->read_ack_register);
> > >> @@ -564,6 +578,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> > >>        pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> > >>            unsigned int devfn;
> > >>            int aer_severity;
> > >> +          u8 *aer_info;
> > >>
> > >>            devfn = PCI_DEVFN(pcie_err->device_id.device,
> > >>                              pcie_err->device_id.function);
> > >> @@ -577,11 +592,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> > >>            if (gdata->flags & CPER_SEC_RESET)
> > >>                    aer_severity = AER_FATAL;
> > >>
> > >> +          aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
> > >> +                                            sizeof(struct aer_capability_regs));
> > >> +          if (!aer_info)
> > >> +                  return;
> > >> +          memcpy(aer_info, pcie_err->aer_info, sizeof(struct
> > >> +aer_capability_regs));
> > >
> > >This is a very straightforward approach to fixing this, and it looks pretty
> > >reasonable, although I'd rather not have to pull more GHES stuff into aer.c
> > >(ghes.h and ghes_estatus_pool_region_free()).
> > >
> > >What I had in mind was to put a queue of aer_capability_regs on the PCI side
> > >that could be used by both the APEI path and the native path.
> > >
> > >In the APEI path, platform firmware reads the error information from the
> > >hardware, and it feeds into PCI AER via aer_recover_queue().
> > >
> > >In the native path, Linux should be reading reads the same error information
> > >from the hardware, but it feeds into PCI AER quite differently, via
> > >aer_process_err_devices() and handle_error_source().
> > >
> > >These paths are fundamentally doing the exact same thing, but the data
> > >handling and dmesg logging are needlessly different.  I'd like to see them get a
> > >little more unified, so the native path could someday also feed into
> > >aer_recover_queue().
> > >
> > >Does that make any sense?
> >
> > Thanks for letting us know.
> > Make sense, solution with in the AER looks better.
>
> Thanks for considering this.  The AER rework I have in mind is a
> longer-term project, so unless you have time and interest in doing
> that, I think we should apply your patch since it's all ready to go.
>
> You pointed to the problem statement, but I think it would be good to
> include a brief outline directly in the commit log, e.g., something
> like this:

Agreed.

>   ghes_handle_aer() passes AER data to the PCI core for logging and
>   recovery by calling aer_recover_queue() with a pointer to struct
>   aer_capability_regs.
>
>   The problem was that aer_recover_queue() queues the pointer directly
>   without copying the aer_capability_regs data.  The pointer was to
>   the ghes->estatus buffer, which could be reused before
>   aer_recover_work_func() reads the data.
>
>   To avoid this problem, allocate a new aer_capability_regs structure
>   from the ghes_estatus_pool, copy the AER data from the ghes->estatus
>   buffer into it, pass a pointer to the new struct to
>   aer_recover_queue(), and free it after aer_recover_work_func() has
>   processed it.
>
> What's your take on this, Rafael?

I can apply it if the changelog is updated along the lines of the above.

>  The biggest change is in
> drivers/acpi, so if you want to take it, feel free to add my:
>
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
