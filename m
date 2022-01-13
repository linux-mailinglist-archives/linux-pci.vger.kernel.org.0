Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0960448DA46
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 15:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiAMO7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 09:59:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37700 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiAMO7C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 09:59:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAD98B822C7;
        Thu, 13 Jan 2022 14:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49354C36AEB;
        Thu, 13 Jan 2022 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085939;
        bh=0+/Y0CsIVcYpaYWcjiIcMKL5vH+XhHAvce7jccMD//g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ten1AGEIZchYGDLcl70PhaCzp5aZnCEEh25RgJDFU4On1fdX9CqAfBMysRaeuLqOp
         j7oa7IeH8jnEssSY9HXYUf4Vh3z+O8ezQpCr50gfsoP+rhKbienR0+3jUAZ/hlN1M/
         GIqmACUZfPqODrqUzv9qysO2FFLGWEqvJZOEEB+JVuNRZUiPlrdhFMF/Hl+1amZTNl
         G2va5P0lu96Fb2nTBn+ftiD3NVU4Lddb5OL4ngskX60FK/OtGFh1Mlt7B8dfPKjsRA
         bEasHyVIK813Jsv301IqY8q+sN+VrkBT+w4RBnbjmAFJILM82EeR2NP7skYAkxrw6w
         JSNJlkAs9d83Q==
Date:   Thu, 13 Jan 2022 08:58:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     bhelgaas@google.com, lukas@wunner.de,
        zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2] PCI: Waiting command completed in
 get_port_device_capability()
Message-ID: <20220113145857.GA347384@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d47e5af3-d339-01b6-5925-a2037b177be2@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 13, 2022 at 03:34:41PM +0800, Yao Hongbo wrote:
> 在 2022/1/13 上午2:01, Bjorn Helgaas 写道:
> > On Wed, Jan 12, 2022 at 03:33:25PM +0800, Yao Hongbo wrote:
> >> 在 2022/1/12 上午2:55, Bjorn Helgaas 写道:

> >>> What kind of system are you seeing the problem on?  It seems like it
> >>> should be safe to drop the HPIE and CCIE disable here for ACPI
> >>> systems.  And *likely* we could do the same for non-ACPI systems,
> >>> though I have no experience there.
> >>
> >> Hi, Bjorn
> >> Thanks for your comments.
> >>
> >> The problem occurs on ACPI systems.
> >>
> >>  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> >>  acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR DPC]
> >>  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> >>
> >> We clear HPIE and CCIE here because the firmware doesn't control
> >> Hotplug via __OSC.
> >>
> >> And on ACPI systems, we can also set pcie_ports=native, which will
> >> also encounter such problems.
> > 
> > What happens if you just drop that call like the patch below?
> > 
> > If that avoids the problem, then we can talk about whether we need to
> > worry about broken firmware in the non-ACPI or "pcie_ports=native"
> > cases.
> 
> Hi, Bjorn.
> This can avoid the problem currently.

Thanks for collecting that data!

> But i'm not sure if removing this code will introduce other problems,
> such as suprious hotplug before probing hotplug service.

I don't think spurious hotplug before probing the hotplug service is
an issue because there is always a window like this.  It's either
between:

  A: Handoff from firmware to OS
  B: get_port_device_capability()

or between:

  A: Handoff from firmware to OS
  C: pciehp initialization

Either way there is *some* window, and we have to decide how to deal
with it.  The exact duration is not very important.

Bjorn
