Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8037C01B3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjJJQd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjJJQd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:33:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80B8E;
        Tue, 10 Oct 2023 09:33:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB13C433C8;
        Tue, 10 Oct 2023 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696955607;
        bh=pUHfRDYSoPK3j7m9jdHCMaY5gkPeGw8CTojkINPhAeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iwuDy2bsxp1GBOVc6hQUNqRfX3dMbtt6NS/e01EPkN8cA9REXRNxbd6YyvodLKHCh
         9EFJzGCtd9kE5lUYRxuqwT9HLtBOiseBp4GlSabD2CsA1odwbzT3EGeq5reg+5cpC+
         Gw/pKKM8oWTFSR9tlAYz+XvgI+ghTaZASPsJSkHIkGwVn8oErhZUBPko0r4JfwqmdT
         UYpisRgeOLPg5ZAvo2El+r4bG7u1UIKhkHP6Ch5Os+jR5Y5o4TgC4u+OTEsXVfa88A
         EquArwLnhHmb0Hvb5+jTEjdDBKQwTwJGpmSg+9mqcFZ4ptCp2s4DTgkalsGpN6Fnts
         9IpqNwRyXPThw==
Date:   Tue, 10 Oct 2023 11:33:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: Make d3cold_allowed sysfs attribute read only
Message-ID: <20231010163325.GA978803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7b4b03-0bb4-492f-bcac-d4e9fd1a81ac@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 01:56:27PM -0500, Mario Limonciello wrote:
> On 10/5/2023 13:53, Bjorn Helgaas wrote:
> > On Wed, Oct 04, 2023 at 09:47:31AM -0500, Mario Limonciello wrote:
> > > Before d3cold was stable userspace was allowed to influence the kernel's
> > > decision of whether to enable d3cold for a device by a sysfs file
> > > `d3cold_allowed`.  This potentially allows userspace to break the suspend
> > > for the system.
> > 
> > Is "Before d3cold was stable" referring to a "d3cold" read-only
> > variable, or to Linux functionality of using D3cold, or ...?
> 
> I was referring to the previous thread's comments when I asked about the
> history on it.
> 
> > In what sense does the `d3cold_allowed` sysfs file break suspend?
> 
> SoCs might not be able to get into their deepest sleep state if userspace
> messes with it.
> 
> > > For debugging purposes `pci_port_pm=` can be used to control whether
> > > a PCI port will go into D3cold and runtime PM can be turned off by
> > > sysfs on PCI end points.
> > 
> > I guess this should be "pcie_port_pm=", which affects *all* PCIe
> > ports?
> 
> Yes.
> 
> > Which sysfs file turns off runtime PM for endpoints?
> 
> /sys/bus/pci/devices/*/power/control

To close the loop on this, I think these are questions that should be
answered in the commit log (actually, that's usually the case when I
have questions, because future readers of the git history may have the
same questions, and it's not practical to dig the answers out of the
lore archive).

Bjorn
