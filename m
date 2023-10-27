Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09E7D9CD9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0PYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJ0PYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 11:24:31 -0400
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31EAC;
        Fri, 27 Oct 2023 08:24:27 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:24:24 +0200
From:   Tomasz Pala <gotar@polanet.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-2?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231027152423.GA15910@polanet.pl>
References: <20231012153347.GA26695@polanet.pl>
 <20231026205319.GA1832508@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20231026205319.GA1832508@bhelgaas>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 15:53:19 -0500, Bjorn Helgaas wrote:

> Something is wrong with our allocation scheme.  Both the MMCONFIG
> region and the ixgbe BAR 0 are at 0x80000000, which obviously cannot
> work.  Maybe the full dmesg log will have a clue about why we didn't
> move ixgbe out of the way.
> 
> Would you mind opening a new report at https://bugzilla.kernel.org,
> attaching those logs, and responding here with the URL?

Sure, no problem: https://bugzilla.kernel.org/show_bug.cgi?id=218050

I've attached the failing one and the one working with my workaround in
place ("if (size >= 256*1024 && 0) {").

regards,
-- 
Tomasz Pala <gotar@pld-linux.org>
