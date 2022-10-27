Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E161055F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 00:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiJ0WJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiJ0WJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 18:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F695FB2;
        Thu, 27 Oct 2022 15:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B266254F;
        Thu, 27 Oct 2022 22:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F780C433D6;
        Thu, 27 Oct 2022 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666908573;
        bh=0ibclOpSF9HH3L57UEPEv2fw+q8NLFznCDvQbhV9ktQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aHn9T3jiGiyP4WIK+IhzHViEpCB7YO6wdnH4UREjTPbgA6/bOaGrU8ubBbBpy+1fY
         pmTXwIkm5b6ZRNOizyBQjpsm8+2ifPIPQNrGmO0CIsTgRBeP9mMKJUGg6H2vTbqP4t
         ynJ9wThvOy2cOTwjs1g/4/gXc9vg4EvIOstBSIYNe9Hbej2Mnr9lktv6vkUGtiOonX
         jJxJoNg0Ut1QQJXccNa3s/5HjXgpLOOrrbWa/Uri92WknLGcgeUBQ8LeD/TQyXPhZO
         Mi4fOgoi91oYxOrufjLzedzA8ubx98muaFLLOsE12gz1ulxT1hcluIgs9kLtK3c0Oy
         t5fu+XgExEYVg==
Date:   Thu, 27 Oct 2022 17:09:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
Message-ID: <20221027220931.GA843829@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027031458.2855599-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 11:14:58AM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> HEST PCIE AER error source information describes the Uncorrectable Error 
> Severity, CorrectableError Mask and other aer register's value to write to the
> bridge's Correctable Error Mask register.

I guess the point is to extract register values from HEST PCI Express
AER structures (ACPI r6.5, sec 18.3.2.4, etc.) and program them into
AER Capabilities?

> leoliu-oc (5):
>   ACPI/APEI: Add apei_hest_parse_aer()
>   ACPI/APEI: remove static from apei_hest_parse()
>   ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
>   ACPI/PCI: Add pci_acpi_program_hest_aer_params()
>   ACPI/PCI: config pcie devices's aer register

If/when you repost this, it would be nice if the patches ([1/5],
[2/5], etc) were responses to the cover letter ([0/5]).  Since they're
not responses, b4 doesn't know they're connected and can't grab the
whole series at once.

Also capitalize the subject lines consistently and s/PCIE/PCIe/ and
s/pcie/PCIe/ and s/aer/AER/, e.g.,

  ACPI/APEI: Add apei_hest_parse_aer()
  ACPI/APEI: Remove static from apei_hest_parse()
  PCI: Add AER #defines for PCIe/PCI-X bridges
  ACPI/PCI: Add pci_acpi_program_hest_aer_params()
  ACPI/PCI: Configure devices AER registers based on HEST

>  drivers/acpi/apei/hest.c      | 121 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci-acpi.c        |  92 ++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   5 ++
>  drivers/pci/probe.c           |   1 +
>  include/acpi/actbl1.h         |  69 +++++++++++++++++++
>  include/acpi/apei.h           |   9 +++
>  include/uapi/linux/pci_regs.h |   5 ++
>  7 files changed, 300 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 
