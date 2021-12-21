Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B647C99C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 00:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhLUXRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 18:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhLUXRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 18:17:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FBC061574;
        Tue, 21 Dec 2021 15:17:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65371B817D0;
        Tue, 21 Dec 2021 23:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ED1C36AE9;
        Tue, 21 Dec 2021 23:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640128623;
        bh=eLpwNszMuOuFEkO+RZzNfIdGgdQR36iwWtCmciSz6/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PSk8Xv5BtvoaVFwebGYKgMvw8X8f2J268mCFiUliSj7V8seeRzBhRP26sn3TaPtiO
         t2EKjS4LmdBFZpVZMhDyxhtFJq2As+KZKrqyZugS2IGWUUQFEXa8WBQ8a6RIOqC5E0
         Ct7KS1kPcuxcCjtTQomDaLYUwSY+kkBHKfvVDigsWiAoqam/3ncqtEXGBj11BmiTmu
         CImW9ns+J1zL9R+i/h0zaRWIH8homEVTVX15SP0n6bQhMMcfXR0U7Q2XlDwFf+Fmeq
         apI2M6zrudl1fOrMgzhcFA8Z9NjaMK0xO9/u6s+TzL/NyLc6A1yr8LI3Xf9sf5yVqA
         SuVfgP+j7oJxg==
Date:   Tue, 21 Dec 2021 17:17:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v4] ACPI: Move sdei_init and ghes_init ahead to
 handle platform errors earlier
Message-ID: <20211221231701.GA1125162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216133456.21002-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 09:34:56PM +0800, Shuai Xue wrote:
> On an ACPI system, ACPI is initialised very early from a subsys_initcall(),
> while SDEI is not ready until a subsys_initcall_sync().
> 
> The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
> apei_sdei_unregister_ghes) to register or unregister event callback for
> dispatcher in firmware. When the GHES driver probing, it registers the
> corresponding callback according to the notification type specified by
> GHES. If the GHES notification type is SDEI, the GHES driver will call
> apei_sdei_register_ghes to register event call.
>
> When the firmware emits an event, it migrates the handling of the event
> into the kernel at the registered entry-point __sdei_asm_handler. And
> finally, the kernel will call the registered event callback and return
> status_code to indicate the status of event handling. SDEI_EV_FAILED
> indicates that the kernel failed to handle the event.
> 
> Consequently, when an error occurs during kernel booting, the kernel is
> unable to handle and report errors until the GHES driver is initialized by
> device_initcall(), in which the event callback is registered. All errors
> that occurred before GHES initialization are missed and there is no chance
> to report and find them again.
> 
> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> the estatus memory pool. On the other hand, ghes_init() relies on
> sdei_init() to detect the SDEI version and the framework for registering
> and unregistering events.

> By the way, I don't figure out why acpi_hest_init is called in
> acpi_pci_root_init, it don't rely on any other thing. May it could
> be moved further, following acpi_iort_init in acpi_init.

I think you should drop the "By the way ..." text or move it after the
"---" at the bottom of your commit log.  It doesn't help understand
this patch.

> sdei_init() relies on ACPI table which is initialized
> subsys_initcall(): acpi_init(), acpi_bus_init(), acpi_load_tables(),
> acpi_tb_laod_namespace().  May it should be also moved further,
> after acpi_load_tables.

This text also doesn't seem relevant to this patch.

> In this patch, move sdei_init and ghes_init as far ahead as
> possible, right after acpi_hest_init().

I'm having a hard time figuring out the reason for this patch.

Apparently the relevant parts are sdei_init() and ghes_init().
Today they are executed in that order:

  subsys_initcall_sync(sdei_init);
  device_initcall(ghes_init);

After this patch, they would be executed in the same order, but called
explicitly instead of as initcalls:

  acpi_pci_root_init()
  {
    acpi_hest_init();
    sdei_init();
    ghes_init();
    ...

Explicit calls are certainly better than initcalls, but that doesn't
seem to be the reason for this patch.

Does this patch fix a bug?  If so, what is the bug?

You say that currently "errors that occur before GHES initialization
are missed".  Isn't that still true after this patch?  Does this patch
merely reduce the time before GHES initialization?  If so, I'm
dubious, because we have to tolerate an arbitrary amount of time
there.

s/acpi_tb_laod_namespace/acpi_tb_load_namespace/

You use "()" after function names sometimes, but not always.  Please
do it consistently.

> -device_initcall(ghes_init);

>  void __init acpi_pci_root_init(void)
>  {
>  	acpi_hest_init();
> +	sdei_init();
> +	ghes_init();

What's the connection between PCI, SDEI, and GHES?  As far as I can
tell, SDEI and GHES are not PCI-specific, so it doesn't seem like they
should be initialized here in acpi_pci_root_init().

> -subsys_initcall_sync(sdei_init);
