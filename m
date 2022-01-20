Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C611B494ED1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiATNXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 08:23:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44328 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbiATNXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 08:23:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB53B81CE6
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 13:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822ACC340E0;
        Thu, 20 Jan 2022 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684994;
        bh=LY8vXqpUi6pY0CXCohJvugeiiAjYYBnlKZGQoEBa3mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFVpFOSC6eRKicB1ZDCWaqPfak4rXXbiiyfFFMd+S5oYhSo+vT6dwEX4RMwXniLiV
         VgH5wvR58qQTmOJZkchB7l+664yFADoMLL3fiy/1MR0HxCnwoqNv7nNNM3ZzqPZuyv
         A0DSkm1ujdIi9mjsyBqjJZXoZeCeFH3VljWwSS88N/WBpn7XkhJjggt2A/caUaDSgC
         QY05eV3eXP2kqisvHUOcKpo1OcFteQtn9Jcjg8gd6yNosr/lGKIRpqgiFjku+pNUyl
         8OOamwLn37TDhoz4OnJbf6m8OdoY/W8RbHQmL4ihPzudwiighATAs2z6zen5kAXwOO
         vA3T1XgNjBV1w==
Received: by pali.im (Postfix)
        id A83F6791; Thu, 20 Jan 2022 14:23:11 +0100 (CET)
Date:   Thu, 20 Jan 2022 14:23:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220120132311.leokj67pvuqsbmnv@pali>
References: <20220119092200.35823-1-sr@denx.de>
 <20220119092200.35823-3-sr@denx.de>
 <20220119103711.hadtvpxklfnxmqth@pali>
 <487c2f8f-a02d-1ddb-ff17-339cbac7e1a7@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <487c2f8f-a02d-1ddb-ff17-339cbac7e1a7@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 08:31:31 Stefan Roese wrote:
> On 1/19/22 11:37, Pali Rohár wrote:
> > On Wednesday 19 January 2022 10:22:00 Stefan Roese wrote:
> > > With this change, AER is now enabled on all PCIe devices, also when the
> > > PCIe device is hot-plugged.
> > > 
> > > Please note that this change is quite invasive, as with this patch
> > > applied, AER now will be enabled in the Device Control registers of all
> > > available PCIe Endpoints, which currently is not the case.
> > > 
> > > When "pci=noaer" is selected, AER stays disabled of course.
> > 
> > Hello Stefan! I was thinking more about this change and I'm not sure
> > what happens if AER-capable PCIe device is hotplugged into some PCIe
> > switch connected in the PCIe hierarchy where Root Port is not
> > AER-capable (e.g. current linux implementation of pci-aardvark.c and
> > pci-mvebu.c). My feeling is that in this case AER should not be enabled
> > as there is nobody who can deliver AER interrupt to the OS. But I really
> > do not know what is supposed from kernel AER driver, so lets wait for
> > Bjorn reply.
> 
> But what happens right now, when a device driver like the NVMe driver
> calls pci_enable_pcie_error_reporting() ? There is also no checking,
> if the connected Root Port or some switch / bridge in-between supports
> AER or not. IIUTC, this is identical to what this patch here does.
> Enable AER in the device and if the upstream infrastructure does not
> support AER, then the AER event will just not be received by the
> Kernel. Which is most likely not worse than not enabling AER at all
> on this device. Or am I missing something?

You are right!

Seems that AER code has lot of candidates for followup fixes/cleanups...

> > And when you opened this issue with hotplugging, another thing for
> > followup changes in future is calling pcie_set_ecrc_checking() function
> > to align ECRC state of newly hotplugged device with "pci=ecrc=..."
> > cmdline option. As currently it is done only at that function
> > set_device_error_reporting().
> 
> Agreed, this is another area to look into. Not sure if it's okay to
> address this, once this patch-set has been accepted (if it will be).
> 
> Thanks,
> Stefan
