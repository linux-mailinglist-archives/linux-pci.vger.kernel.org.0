Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41665F698
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjAEWUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 17:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAEWUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 17:20:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4267BFF;
        Thu,  5 Jan 2023 14:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D93A61C39;
        Thu,  5 Jan 2023 22:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1396C433EF;
        Thu,  5 Jan 2023 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672957233;
        bh=wFsjpVh3IkDmL+Utxx+F+EeOCJi8KbNIByUbOF9OlAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bl4maVmL8WVazXiY1F4XvKQmhwaB5YBcUiFS2s31mdvm8a1ZZn/Hx49BfQ/XYT+2m
         YeqtLdjYUydFElqyULMAnZKpFwCClpWNRqTcNuUl+j4ckAlIZ+m6ltXms9VWMUFqMd
         hIwBaDWpHxeIBiE4dEQzBNil5NCL+5dz41FOJeHBR394j8G5RTDXwQnYlv12YS/TFB
         kPIUH6P8kIVxY+Ro/RQMIFc9bEOgfbe0WMdX0Mi0Exvewjb9E63X0m6vjRyLCYZOOD
         6beeQmfQybHtimNh92uaCN64BE0+CNmtKtAAUgByvvBFUZXPzMpo0osAMV1UJqotEQ
         R+gdDRAfjTwXg==
Date:   Thu, 5 Jan 2023 16:20:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105222031.GA1175847@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608376AF8369BE02661C48D7FCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 09:49:44PM +0000, Luck, Tony wrote:
> > The EDAC driver wouldn't have any ACPI stuff in it; it's just that
> > Linux is looking for ACPI info about the ECAM area.
> 
> Is there some way for a driver to know that pci_read_config_dword()
> is going to fail for offsets in extended PCIe config space?

There's no nice way to know ahead of time.  "raw_pci_ext_ops ==
&pci_mmcfg" means it should work.  It looks like pci_direct_conf1 and
pci_mmcfg_numachip would also work, but it's all pretty ugly.

You could check the result for PCI_POSSIBLE_ERROR(), since reads
should return ~0 (PCI_ERROR_RESPONSE) if they fail either because we
can't access extended config space or because there was some PCI
error.

Bjorn
