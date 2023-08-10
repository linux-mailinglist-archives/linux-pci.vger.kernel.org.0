Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44B4778413
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 01:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjHJXUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHJXUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 19:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD38128;
        Thu, 10 Aug 2023 16:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D70264393;
        Thu, 10 Aug 2023 23:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CC4C433C8;
        Thu, 10 Aug 2023 23:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691709643;
        bh=1kZs1FI9DpObKoH3l747JUx9vqG04yRIFvz/rOusHR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MIGP4Y7FN5sr3mZR+d6BTlIQ1V2MVujLg2kOK3xF4C1fTL4zV0RwneVdXBcouOemV
         UoE9fIBDhCOtYis+vYXz/WzYTm9KeyEml3qowIcRwbaSRufJkhGxUZBl4u5xVar06Q
         MmhjjDNNFAfE6hMVc4WIfiFZ9t4HAlU+EK6xD6Xug3MljnXM/1rkSZJJLAEleaA960
         B4WlMOHGQDXBnohqmL3Tptvdf0bl3AQevpaqNun4Wqj1IxzzyuU/ie5fRLIVGLMNG5
         D0Z0HnoCf7tdyj+jauDgCwaIF1TUvwyLztTcufomwN5NsSuXNjrDbhAzwLBJdUx5Pl
         z9S/IQmxTvrjQ==
Date:   Thu, 10 Aug 2023 18:20:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH v3 0/5] Parse the PCIe AER and set to relevant registers
Message-ID: <20230810232041.GA50619@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120453.1322069-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 08:04:53PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
> register values form HEST PCI Express AER Structure should be written to
> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
> is to extract register values from HEST PCI Express AER structures and
> program them into AER Capabilities.
> Refer to the ACPI Spec r6.5 for a more detailed description.
> Considering that HEST AER patch is an effective supplement to _HPP/_HPX
> method when the Firmware does not support the _HPP/_HPX method and can be
> specially configured for the AER register of a specific device.
> The question about whether OS has control of AER to write the information
> in the HEST AER structure to the AER register of the corresponding device
> is similar to the question about _HPX/_HPP method to write the AER
> information to the AER register of the corresponding device.I looked in
> ACPI Spec for a description of the relationship between writing to the AER
> register through the _HPP/_HPX method and whether the OS requires AER
> control:
> 1.OSPM uses the information returned by _HPX to determine how to
> configure PCI Functions that are hot- plugged into the system, to
> configure Functions not configured by the platform firmware during initial
> system boot, and to configure Functions any time they lose configuration
> space settings (e.g. OSPM issues a Secondary Bus Reset/Function Level
> Reset or Downstream Port Containment is triggered).
> 
> 2._HPX may return multiple types or Record Settings (each setting in a
> single sub-package.) OSPM is responsible for detecting the type of
> Function and for applying the appropriate settings. OSPM is also
> responsible for detecting the device / port type of the PCI Express
> Function and applying the appropriate settings provided.
> For example, the Secondary Uncorrectable Error Severity and Secondary
> Uncorrectable Error Mask settings of Type 2 record are only applicable to
> PCI Express to PCI-X/PCI Bridge whose device / port type is 1000b.
> Similarly, AER settings are only applicable to hot plug PCI Express
> devices that support the optional AER capability.
> 
> 3.Note: OSPM may override the settings provided by the _HPX object's Type2
> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
> Settings) when OSPM has assumed native control of the corresponding
> feature. For example, if OSPM has assumed ownership of AER (via _OSC),
> OSPM may override AER related settings returned by _HPX. This means that
> writing the AER register value by _HPX does not require the OS to gain
> control of the AER. Also from the usage description of _HPX, I think
> ownership of AER means who decides the configuration value of the AER
> register rather than who can write the configuration value. Even though
> the OS does not have control or ownership of the AER, it should still
> write the configuration values determined by the firmware to the AER
> register at the request of the firmware. 
> Therefore, the ownership of AER is not considered in this patch.

There's a lot of good information above, but this is the cover letter,
so it won't make it into the git history.  Can you move this
information to the relevant patches, where it will help justify the
need for the patch?

Also, if at all possible, can you arrange for the patches themselves
to be sent as *responses* to the cover letter?  This makes the series
thread nicely and makes it much easier to download and apply it.

Bjorn
