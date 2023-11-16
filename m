Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603A7EEA03
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjKPXiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 18:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKPXiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 18:38:06 -0500
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 15:37:58 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929D8E;
        Thu, 16 Nov 2023 15:37:58 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 13F98406B6; Thu, 16 Nov 2023 23:27:48 +0000 (GMT)
Date:   Thu, 16 Nov 2023 23:27:48 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com,
        andrea.righi@canonical.com, vicamo.yang@canonical.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Witt <kernel@witt.link>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <ZValdAmd027avr20@srcf.ucam.org>
References: <70ec50bab17ec112641f01a122e389e71b470270.camel@linux.intel.com>
 <20231116231812.GA57394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116231812.GA57394@bhelgaas>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 16, 2023 at 05:18:12PM -0600, Bjorn Helgaas wrote:

> I think this would be better as a quirk instead of a driver probe
> method because I don't think ASPM really has anything to do with the
> driver probe.  We do most ASPM configuration at enumeration (before
> driver probe), so now we have this exception that we delay it until
> probe time if the policy is POLICY_POWERSAVE or
> POLICY_POWER_SUPERSAVE.

I think doing this as a quirk would probably work fine, but from an 
aesthetic point of view it feels awkward - this is knowledge that the 
drivers have, and so fundamentally placing that knowledge in the core 
PCI code feels like the wrong place to put it.
