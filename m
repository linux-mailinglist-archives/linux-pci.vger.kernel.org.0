Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B935B4C3AE7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 02:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiBYB1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 20:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiBYB1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 20:27:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA3139CFD;
        Thu, 24 Feb 2022 17:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E14B60EE6;
        Fri, 25 Feb 2022 01:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424C8C340E9;
        Fri, 25 Feb 2022 01:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645752422;
        bh=85HLwqlMewbSTrfjrAGqrkfIdSjqXwp0JPp7/aV8oao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CWeHyaMrKSdImi6hOg4U9noz6tqzKHIZUjH13gF9g3nF6NbTkZgECjc47NFg6M1Re
         TQaJK3/EtRRbNXIBNiv0ItbHzqW516lHT581oit2EAjSdgX0YLN9bnUnKaz1GZry7d
         EE4wsswMdhEE2ZdOqOIE7L1GRaycVqFECVFq76nAPCI809gYnzZLTeUpfJwmdgyDwu
         gXDpO7Bydtp+mXExg8f7vlIkWi5YYsOfrpWPOr7PK+Qg4dqRvTFwCPKZe3df1XblYT
         oF0Gg1ybQvZIO2BGvcpeh5efMlC16fMdYbfHBWM49HVaE9KiOzweoX4xFgmWySDmQ2
         Po/3tKeCF+sJg==
Date:   Thu, 24 Feb 2022 19:27:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <20220225012700.GA319379@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225012346.GA317859@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 07:23:49PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 24, 2022 at 03:51:12PM -0600, Mario Limonciello wrote:
> > The `is_thunderbolt` attribute originally had a well defined list of
> > quirks that it existed for, but it has been overloaded with more
> > meaning.
> > 
> > Instead use the driver core removable attribute to indicate the
> > detail a device is attached to a thunderbolt or USB4 chain.
> ...

> If these things are not specifically related to Thunderbolt, I'd
> prefer to get rid of pci_is_thunderbolt_attached() and see if we can
> help the GPU folks figure out what they really need.

Ah.  Guess I should read the whole series before commenting :)  I see
that you *did* remove pci_is_thunderbolt_attached() in the last patch.
I'll look more at the rest tomorrow.

Bjorn
