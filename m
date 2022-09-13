Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331D5B7C9F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIMVMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIMVMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:12:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69996760E5;
        Tue, 13 Sep 2022 14:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B83F1B810E0;
        Tue, 13 Sep 2022 21:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421DDC433D6;
        Tue, 13 Sep 2022 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663103505;
        bh=EqY+NqhVnysbIE+p5o7TH2MFWfeZ8Ji3Lp9KdSogTdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZZrrTuzQFcDZqyAlbzVysvh5WkG66uD5zeqNqrKwnX5XB2JK/oM5H2AN0kJfCKTUs
         qZdb3DBmjt5HpqEJ/dzkK8sNCsH6VhmG3a8LclTNgSdyz+dmlu3trBINKbkkM829Ia
         Uq1PwTKMJRNxtrlXdsNCgmHNvV4n5gW+qCpmz6t+ZWm1NJ7r9u139KZSDaurBewnOk
         Wh4eXbFhFZmcCjF+kFgkJgLYeGAs9z1zS2PT16kbSsO1fGPU9k1jU3AsgWDgBH7Yrw
         VnOiuW+7n4kKGMmoffW+YUxq7ZuptY7MOZXcXHw6vv4crs+CmbnB64yODoLpJ5EmOp
         aieka6oXQ4Aaw==
Date:   Tue, 13 Sep 2022 16:11:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] PCI: Add standard PCI Config Address macros
Message-ID: <20220913211143.GA624473@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220911112024.14304-2-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 11, 2022 at 01:20:22PM +0200, Pali Rohár wrote:
> Lot of PCI and PCIe controllers are using standard Config Address for PCI
> Configuration Mechanism #1 (as defined inPCI Local Bus Specification) or
> its extended version.
> 
> So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
> new include file linux/pci-conf1.h which can be suitable for PCI and PCIe
> controllers which uses this type of access to PCI config space.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  include/linux/pci-conf1.h | 51 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 include/linux/pci-conf1.h

This seems like a nice addition, but it would be nice if we could
encapsulate it in drivers/pci.

I know it's parallel to the existing include/linux/pci-ecam.h.  I wish
we could encapsulate *that* in drivers/pci, too.  For pci-ecam.h, I
think the only things that prevent that are drivers/acpi/pci_mcfg.c,
loongarch, and a few arm64 things.

pci_mcfg.c arguably would make more sense in drivers/pci; it uses
acpi_table_parse(), but no other ACPI services.

The arm64 code that uses pci-ecam.h is really generic code that would
not be in arch/arm64 except for the fact that x86 has really ugly
legacy x86-specific mmconfig code.

I guess that's a long-winded way of saying that I think maybe we could
put this in drivers/pci/pci.h even though the parallel ECAM stuff is
in include/linux/pci-ecam.h.

Bjorn
