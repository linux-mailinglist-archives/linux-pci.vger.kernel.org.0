Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A740F6DFB67
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLQcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 12:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA14228;
        Wed, 12 Apr 2023 09:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473AF63592;
        Wed, 12 Apr 2023 16:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651A1C433D2;
        Wed, 12 Apr 2023 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317123;
        bh=Jd0KP9Be/J1eYVNg6f3gA2o2GR5IxjU2odxONAUvHX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u3Vq97gr0+butPSYqTNSkWT/rZLFJQ88FtvnlAQyeWnm/lM8+fP9AXhdEXCyyD9DB
         hVDvIpCBNigVD8QggkamOvcnbvtoAHF9BnUXdFEY+EKuGg4K18DLYNWQ8e10I/21Ss
         MCpe6yLCFLDGQXsLJdiVhInimXjMXfWhvKenerNUX6rALwfxcHptpa5RrqkPlmw/fI
         bjiKp1HcUkDHTkXjdDtlp1rKVIH7uLlm+qJXpSkORwl+48ZbOwAMwylryCXB++cR31
         hC09GskgKbrtJCcPvCfW44azJMVPAwXMH7gNueiLuB4NUMkVJNr3axDUUnNC/+1S8d
         dhJoSr91G29kA==
Date:   Wed, 12 Apr 2023 11:32:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Li, Ming" <ming4.li@intel.com>
Subject: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
Message-ID: <20230412163201.GA49069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433ad19a-8286-ff58-9fd8-d7dd13547032@zhaoxin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 05:11:28PM +0800, LeoLiuoc wrote:
> 在 2023/4/8 7:18, Bjorn Helgaas 写道:
> > On Tue, Nov 15, 2022 at 11:11:15AM +0800, LeoLiu-oc wrote:
> > > From: leoliu-oc <leoliu-oc@zhaoxin.com>
> > > 
> > > According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
> > > register values form HEST PCI Express AER Structure should be written to
> > > relevant PCIe Device's AER Capabilities. So the purpose of the patch set
> > > is to extract register values from HEST PCI Express AER structures and
> > > program them into AER Capabilities. Refer to the ACPI Spec r6.5 for a more
> > > detailed description.
> > 
> > I wasn't involved in this part of the ACPI spec, and I don't
> > understand how this is intended to work.
> > 
> > I see that this series extracts AER mask, severity, and control
> > information from the ACPI HEST table and uses it to configure PCIe
> > devices as they are enumerated.
> > 
> > What I don't understand is how this relates to ownership of the AER
> > capability as negotiated by the _OSC method.  Firmware can configure
> > the AER capability itself, and if it retains control of the AER
> > capability, the OS can't write to it (with the exception of clearing
> > EDR error status), so this wouldn't be necessary.
> 
> There is no relationship between the ownership of the AER related
> register and the ownership of the AER capability in the OS or
> Firmware.

I don't understand this; can you say it another way?  "Ownership of
the AER related register" and "ownership of the AER capability" sound
exactly the same to me.

> The processing here is to initialize the AER related register, not
> the AER event. If Firmware is configured with AER register, it will
> not be able to handle the runtime hot reset and link retrain cases
> in addition to the hotplug case you mentioned below.
>
> > If the OS owns the AER capability, I assume it gets to decide for
> > itself how to configure AER, no matter what the ACPI HEST says.
> 
> What information does the OS use to decide how to configure AER? The
> ACPI Spec has the following description: PCI Express (PCIe) root
> ports may implement PCIe Advanced Error Reporting (AER) support.
> This table(HEST) contains  information platform firmware supplies to
> OSPM for configuring AER support on a given root port. We understand
> that HEST stands for user to express expectations.
> 
> In the current implementation, the OS already configures a PCIE
> device based on _HPP/_HPX method when configuring a PCI device
> inserted into a hot-plug slot or initial configuration of a PCI
> device at system boot. HEST is just another way to express the
> desired configuration of the user.

Why was the HEST mechanism added if the functionality is equivalent
to the existing _HPP/_HPX?  There must be something that HEST supplies
that _HPP/_HPX did not.

I think we need some things in the commit log (and short comments in
the code) to help maintain this in the future:

  - What problem does this solve, e.g., is there some bug that happens
    because we lack this functionality?

  - How is this HEST mechanism related to _HPP/_HPX?  What are the
    differences?

  - How is this related to _OSC AER ownership?

I think we ignore _OSC ownership in the existing _HPP/_HPX code, but
that seems like a potential problem.  The PCI Firmware spec (r3.3, sec
4.5.1) is pretty clear:

  If control of this feature was requested and denied or was not
  requested, firmware returns this bit set to 0, and the operating
  system must not modify the Advanced Error Reporting Capability or
  the other error enable/status bits listed above.

> > Maybe this is intended for the case where firmware retains AER
> > ownership but the OS uses native hotplug (pciehp), and this is a way
> > for the OS to configure new devices as the firmware expects?  But in
> > that case, we still have the problem that the OS can't write to the
> > AER capability to do this configuration.
> > 
> > Bjorn
