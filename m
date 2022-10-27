Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1D60EFCA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiJ0GEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 02:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiJ0GDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 02:03:46 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4747CA80;
        Wed, 26 Oct 2022 23:03:44 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B51CE300018BB;
        Thu, 27 Oct 2022 08:03:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA99F30110; Thu, 27 Oct 2022 08:03:42 +0200 (CEST)
Date:   Thu, 27 Oct 2022 08:03:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] firewire: ohci: convert to generic power management
Message-ID: <20221027060342.GA444@wunner.de>
References: <20221025212521.686779-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025212521.686779-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 04:25:21PM -0500, Bjorn Helgaas wrote:
> N.B. This changes the order of pmac_ohci_off() and pmac_ohci_on().
> Previously, pmac_ohci_off() was called *after* pci_save_state() and
> pci_set_power_state(), and this change calls it *before*.
> 
> Similarly, pmac_ohci_on() was previously called *before*
> pci_set_power_state() and pci_restore_state() and this change calls it
> *after*.

Seems likely the ordering change may break things.

pmac_ohci_on/off() toggles PMAC_FTR_1394_ENABLE, which is defined as:

 * enable/disable the firewire cell of an uninorth ASIC.

It sounds like it will cut power to the firewire controller and I'd
expect that pci_save_state() will then not be able to access config
space.

The only way to make this work is to define a struct dev_pm_domain
whose ->suspend_noirq callback first invokes the pci_bus_type
->suspend_noirq callback and then cuts power to the firewire cell
by calling pmac_ohci_off().

I've done something like this for Thunderbolt power management on
x86 Macs a few years back but didn't get around to upstream it so far:

https://github.com/l1k/linux/commit/4db7f0b1f5c9

Thanks,

Lukas
