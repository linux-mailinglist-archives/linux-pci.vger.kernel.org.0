Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50F84965D8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiAUTqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiAUTqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 14:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F67C06173B;
        Fri, 21 Jan 2022 11:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAFB7B820D9;
        Fri, 21 Jan 2022 19:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D7C340E1;
        Fri, 21 Jan 2022 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642794369;
        bh=s8CFfVkEFgCYwCsZ61/HoZHTy/2PzVbQ2BSmTJdrEdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uHTdVgBy9ezeNTbMzWmnwiE6TI3L/I6fJoGLt3SRePP0x9NdGjgSkMNUVS+C7n8QY
         qkWdTdB85ezcr5jWrn7/T4hj+B+dvoz+VCZC9yTXSTbKsOkQC8Z20ucKjx/Im8u6q4
         QWwOOSkatByCFnRPQqqYJLiiUwygpgY4zl3LB/ndV8hnPtJ5use8gf3nThTNv7CCrY
         Dq9GuN6EXV4+CgaeoZ4UqGd71T9tDIdXF9pQ/qWyWyZwCRWPjrwu6lDCBANIy8yV7B
         Dk6r369J3f01rlNvnZINN93F5fdDna0T31skPTlNyRTaNXRoTyo1PRUkAM8/5fLwQR
         TYAMEcskIrt3Q==
Date:   Fri, 21 Jan 2022 13:46:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rafael@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, lenb@kernel.org, rjw@rjwysocki.net,
        bhelgaas@google.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] ACPI: explicit init HEST, SDEI and GHES in apci_init
Message-ID: <20220121194607.GA1146355@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c34906a-244e-3956-0ca7-7131b268cf60@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 11:43:25AM +0800, Shuai Xue wrote:
> 在 2022/1/21 AM12:22, Bjorn Helgaas 写道:
> > On Thu, Jan 20, 2022 at 01:05:22PM +0800, Shuai Xue wrote:
> >> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> >> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> >> the estatus memory pool. On the other hand, ghes_init() relies on
> >> sdei_init() to detect the SDEI version and (un)register events. The
> >> dependencies are as follows:
> >>
> >>     ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
> >>     ghes_init() => sdei_init()
> >>
> >> HEST is not PCI-specific and initcall ordering is implicit and not
> >> well-defined within a level.
> >>
> >> Based on above, remove acpi_hest_init() from acpi_pci_root_init() and
> >> convert ghes_init() and sdei_init() from initcalls to explicit calls in the
> >> following order:
> >>
> >>     acpi_hest_init()
> >>     sdei_init()
> >>     ghes_init()

> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -30,6 +30,7 @@
> >>  #include <linux/acpi_viot.h>
> >>  #include <linux/pci.h>
> >>  #include <acpi/apei.h>
> >> +#include <linux/arm_sdei.h>
> > 
> > This "arm" looks a little out of place in this supposedly arch-generic
> > code.  Not really a new thing with this patch, since this #include
> > already appears in drivers/acpi/apei/ghes.c.  Maybe it's unavoidable.
> 
> Yep, should we move sdei_init() into the beginning of ghes_init()?
> ...

> > Software Delegated Exception Interface (|SDEI|) is an Arm specification for
> > Non-secure world to register handlers with firmware to receive notifications
> > about system events.
> > LINK: https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/components/sdei.rst
> 
> I think SDEI is not a ACPI Specification but Arm specification so we should
> not rename sdei_init() with an "acpi_" prefix.  If we move sdei_init() into
> ghes_init(), and rename ghes_init() to acpi_ghes_init(), then all looks
> fine? What's your opinion, Bjorn?

Makes sense to me, especially since drivers/acpi/apei/ghes.c already
includes linux/arm_sdei.h.  This is Rafael's area.

Bjorn
