Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7187013B9
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjEMBYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEMBYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 21:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120140ED;
        Fri, 12 May 2023 18:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E26A063EFA;
        Sat, 13 May 2023 01:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15BFC433D2;
        Sat, 13 May 2023 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683941081;
        bh=ufptWhk0BbCBOlRE0pk1y6y1XcHSouNAvlan/zSTrAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sxtJ8CfHTCeAo0D9/++DN1TpfPp54rd4Bjo9/cVcNl+dpoRXUItLhHO5gRcwq/76H
         iG2T612DUkjnlkyelE9eD2HgVSk04mxeWbB0MU+5ARtEwZw1qO4cyCfiHmHjmGZvH1
         nDgF5O5vp+wv35xUsBBE8WZaXp3awA3WiHOajXq++DOBOGEEF7LKHnbMDxrj4WqF+Q
         O+3N4Vm1dRMOBRBmrKN/f+e07pyMPCq7HDKGhx1ySipqxRfIZJme8kOOTfOjO6rJ8b
         ogh0CxwXsoQHtYEWTf8j2mjN7gAEPM4vUsAqY6xRymjRUSmPw989oheJkEI1Qy1xl7
         2SRbEcfq/u5IQ==
Date:   Fri, 12 May 2023 20:24:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, kw@linux.com, heiko@sntech.de,
        robh@kernel.org, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
        broonie@kernel.org, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
Message-ID: <ZF7m1npzLZmawT8Y@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSK8M39MQL2C.3S7JO031H0BA2@vincent-arch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc ARM64 folks, in case you have abort handling tips; thread at:
https://lore.kernel.org/r/20230509153912.515218-1-vincenzopalazzodev@gmail.com]

Pine64 RockPro64 panics while enumerating some PCIe devices.  Adding a
delay avoids the panic.  My theory is a PCIe Request Retry Status to a
Vendor ID config read causes an abort that we don't handle.

> On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
>> ...
>> [    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
>> [    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJARO-ARM
>> #1
>> [    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
>> [    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
>> [    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
>> [    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
>> ...
>> [    1.229939] Kernel panic - not syncing: Asynchronous SError Interrupt
>> ...
>> [    1.229955]  nmi_panic+0x8c/0x90
>> [    1.229956]  arm64_serror_panic+0x78/0x84
>> [    1.229958]  do_serror+0x15c/0x160
>> [    1.229960]  el1_error+0x84/0x100
>> [    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
>> [    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
>> [    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
>> [    1.229968]  pci_scan_single_device+0xa4/0x144

On Fri, May 12, 2023 at 12:46:21PM +0200, Vincenzo Palazzo wrote:
> ... Is there any way to tell the kernel "hey we need some more time
> here"?

We enumerate PCI devices by trying to read the Vendor ID of every
possible device address (see pci_scan_slot()).  On PCIe, if a device
doesn't exist at that address, the Vendor ID config read will be
terminated with Unsupported Request (UR) status.  This is normal
and happens every time we enumerate devices.

The crash doesn't happen every time we enumerate, so I don't think
this UR is the problem.  Also, if it *were* the problem, adding a
delay would not make any difference.

There *is* a way for a PCIe device to say "I need more time".  It does
this by responding to that Vendor ID config read with Request Retry
Status (RRS, aka CRS in older specs), which means "I'm not ready yet,
but I will be ready in the future."  Adding a delay would definitely
make a difference here, so my guess is this is what's happening.

Most root complexes return ~0 data to the CPU when a config read
terminates with UR or RRS.  It sounds like rockchip does this for UR
but possibly not for RRS.

There is a "RRS Software Visibility" feature, which is supposed to
turn the RRS into a special value (Vendor ID == 0x0001), but per [1],
rockchip doesn't support it (lspci calls it "CRSVisible").

But the CPU load instruction corresponding to the config read has to
complete by reading *something* or else be aborted.  It sounds like
it's aborted in this case.  I don't know the arm64 details, but if we
could catch that abort and determine that it was an RRS and not a UR,
maybe we could fabricate the magic RRS 0x0001 value.

imx6q_pcie_abort_handler() does something like that, although I think
it's for arm32, not arm64.  But obviously we already catch the abort
enough to dump the register state and panic, so maybe there's a way to
extend that?

Bjorn

[1] https://lore.kernel.org/linux-pci/CAMdYzYpOFAVq30N+O2gOxXiRtpoHpakFg3LKq3TEZq4S6Y0y0g@mail.gmail.com/
