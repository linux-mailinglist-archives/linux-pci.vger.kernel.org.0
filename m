Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9732B629DB2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiKOPhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 10:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiKOPhl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:37:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27882DA90
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45041B8162B
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 15:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE77FC433C1;
        Tue, 15 Nov 2022 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668526657;
        bh=EPTb+44e04rF0bskyceQIlwlsswsXM0uklynsfFrHjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BptTUUUkitpg/OHvxRFmZXPIOkC+wxsq+O2nQYe+I5LdI6+BPR45dZ6m9RvYteJ3o
         9jYcJscvRVQQX5Hifwsd/0UgpoPQrgt5dsa9qKAs9fJ0MgD11+jOg+Etkz46DKe4bV
         oE67H6iLvSuF3Yu4rKQXLtVdsvR7vn2Lq9o1dUd+eJQHbRyYWCMcjf7cvwTNedvchs
         3KSt9PU8ZxhcXkGU3khPGznr9SX8G+ONFY99upfKndQNmaog7XNwQZkpCRRSPuHLL/
         wI2f6Gak3qYeb4ymwhXp1NcWzge0OydQsXPJ4ZKmHx84oI6hl3oTLGWz8WNr004piC
         qMWKrFDtWjjXQ==
Date:   Tue, 15 Nov 2022 09:37:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/5] PCI: add 4x lane support for pci-j721e controllers
Message-ID: <20221115153735.GA993634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115150335.501502-1-mranostay@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 07:03:30AM -0800, Matt Ranostay wrote:
> Adding of dditional support to Cadence PCIe controller (i.e. pci-j721e.c)
> for up to 4x lanes, and reworking of driver to define maximum lanes per
> board configuration.
> 
> Changes from v1:
> * Reworked 'PCI: j721e: Add PCIe 4x lane selection support' to not cause
>   regressions on 1-2x lane platforms
> 
> Changes from v2:
> * Correct dev_warn format string from %d to %u since lane count is a unsigned
>   integer
> * Update CC list
> 
> Changes from v3:
> * Use the max_lanes setting per chip for the mask size required since bootloader
>   could have set num_lanes to a higher value that the device tree which would leave
>   in an undefined state
> * Reorder patches do the previous change to not break bisect
> * Remove line breaking for dev_warn to allow better grepping and since no strict
>   80 columns anymore
> 
> Changes from v4:
> * Correct invalid settings for j7200 PCIe RC + EP
> * Add j784s4 configuration for selection of 4x lanes
> 
> Changes from v5:
> * Dropped 'PCI: j721e: Add warnings on num-lanes misconfiguration' patch from series  
> * Reworded 'PCI: j721e: Add per platform maximum lane settings' commit message
> * Added yaml documentation and schema checks for ti,j721e-pci-* lane checking
> 
> Matt Ranostay (5):
>   dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
>   PCI: j721e: Add per platform maximum lane settings
>   PCI: j721e: Add PCIe 4x lane selection support
>   dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
>   PCI: j721e: add j784s4 PCIe configuration

Hi Matt,

Don't repost just for this, but if you have occasion to post this
again, capitalize this subject line to match the others, i.e.,
"Add j784s4 configuration".

Also looks like some commit logs are wrapped at about 65 columns; it's
nice if they're consistently 75.
