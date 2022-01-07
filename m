Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE2487EEA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiAGW23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 17:28:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47346 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiAGW23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 17:28:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7AA61FE3;
        Fri,  7 Jan 2022 22:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E52C36AE9;
        Fri,  7 Jan 2022 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641594508;
        bh=lNOQMqnCqegfm8pumdQ9PFSskvp+/6nHG7AVVSzUDlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duUFMsPG4/A4PRLmBZaFjF5QaNS7r5JBpthzVRxH1hmaaWHyudmGfnXU5bf8oBQ9B
         x2i4FwVOnc+AsPlCZaDGzJLOEYHkYdLfqIrKe9oDGX2VbT31/toJAzyGPfMCPHZlX9
         Zt+mPCT3529H/r9C2Xs5M0EDhP2ateBhHXf0XGUa5D3IXPW6B3+JO2V2v8H4K3THZe
         z9K5OculL6S4siuCKGRoQqPzKh8Bdg6gvDSESG3aQb+kka5WBYzR9gsAPGKakF7gfI
         qYg5R4NbzP8OznsvlHjfKiRlKt7ruFtibjMUqqR+rs90iXYFJB1eAv8l8krUszfFi6
         iq7idyAxUtCAQ==
Received: by pali.im (Postfix)
        id 2D900B22; Fri,  7 Jan 2022 23:28:26 +0100 (CET)
Date:   Fri, 7 Jan 2022 23:28:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] PCI: mvebu: Propagate errors when updating
 PCI_IO_BASE and PCI_MEM_BASE registers
Message-ID: <20220107222826.cv2bzywwayjwzy3c@pali>
References: <20211125124605.25915-9-pali@kernel.org>
 <20220107215504.GA406217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107215504.GA406217@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > Properly propagate failure from mvebu_pcie_add_windows() function back to
> > the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> > PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> > On error set base value higher than limit value which indicates that
> > address range is disabled. 
> 
> Does the spec say that if software programs something invalid,
> hardware should proactively set the base and limit registers to
> disable the window?

No. But this patch address something totally different. Software can do
fully valid operation, e.g. try to set forwarding memory window as large
as possible. But because this driver "emulates" pci bridge by calling
software/kernel function (mvebu_pcie_add_windows), some operations which
in real HW cannot happen, are possible in software.

For example there are limitations in sizes of forwarding memory windows,
because it is done by mvebu-mbus driver, which is responsible for
configuring mapping and forwarding of PCIe I/O and MEM windows. And due
to Marvell HW, there are restrictions which are not in PCIe HW.

Currently if such error happens, obviously kernel is not able to set
PCIe windows and it just print warnings to dmesg. Trying to access these
windows would result in the worst case in crashes.

With this change when mvebu_pcie_add_windows() function fails then into
emulated config space is put information that particular forwarding
window is disabled. I think that it is better to indicate it in config
space what is the current "reality" of hardware configuration. If window
is disabled in real-HW (meaning in mvebu-mbus driver) then show it also
in emulated config space of pci bridge.

Do you have better idea what should emulated pci bridge do, if software
try to set fully valid configuration of forwarding window, but it is not
possible to achieve it (even compliant PCI bridge must be able to do
it)?

> I'm not sure I've seen hardware that does this, and it seems ... maybe
> a little aggressive.
> 
> What happens if software writes the base and limit in the wrong order,
> so the window is invalid after the first write but valid after the
> second?  That actually sounds like it could be a sensible strategy to
> prevent a partially-configured window from being active.
> 
> Bjorn

Invalid window (limit < base) means that window is disabled. And
pci-mvebu.c in its callbacks from pci-bridge-emul.c should correctly
handle it and propagates information about disablement to mvebu-mbus
driver.

After window is valid again (limit > base) then pci-mvebu.c call
mvebu-mbus to setup new mapping.
