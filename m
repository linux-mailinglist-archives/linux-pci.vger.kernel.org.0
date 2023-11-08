Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A817E5F10
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjKHUUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 15:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHUUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 15:20:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3724A2122;
        Wed,  8 Nov 2023 12:20:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA36C433C7;
        Wed,  8 Nov 2023 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699474836;
        bh=nvUQR9lzcuZ4TP2VSkhQhJGAQr+6zmKhRB6WBVbAtbg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ksw3nwCx0VgdQTcFuX2xphyNUOjVXiFFIL1vEMiqHyzEP+Gmsx4I4I3oHIttHrgjk
         9eVRQmJEGh0S6lCsgyqAmNKpxYiqgRPG/qaMxYZ/GSNoYCzvpgmE1kfzZWLE4u+MRJ
         BXXPavG5F18VoaINv+WYhib+KDyf1mxoM1FH4190D98f8jJ9UGZhWusXRl5kNBXB81
         CjtH/dsbmHqH07Bt5BIVZLYTVKTcfcZdzRM2aMC/XDToXTkhrRda6kAMLi2c6NFq8C
         rpYkLirO2qOqqFFE7eX7bRhBBSNHLcP3DXmDLGh5tMRbS9AvoqJbCWdNJhjsO4E9bI
         qv8MO+MiQtUKA==
Date:   Wed, 8 Nov 2023 14:20:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tomasz Pala <gotar@polanet.pl>
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
        Benoit =?utf-8?B?R3LDqWdvaXJl?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231108202034.GA424133@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108174721.GA421447@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 08, 2023 at 11:47:21AM -0600, Bjorn Helgaas wrote:
> ...

> Adding to regression tracking:
> 
> #regzbot ^introduced: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218107

#regzbot title: PCI BAR vs MCFG/ECAM resource conflict
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218050
#regzbot link: https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-driver-fails-to-load-due-to-pci-device-probing-failure.131203/

