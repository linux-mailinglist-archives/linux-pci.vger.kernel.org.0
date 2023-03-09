Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C276B2C62
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCIRx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCIRx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 12:53:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033E5981B
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 09:53:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 777A7B8203A
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B4EC433EF;
        Thu,  9 Mar 2023 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678384403;
        bh=YbNLcyYgD3CnJBITfEOYUx7F18nRKc3peRdWuMSZAr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UouuOTezo/P7M726zxCCMGS2T7mcgugfWgWisQTaOzVz8n4JCkVxLByrr5K/xqUzG
         QM1HwSyj5nZ+khmW3BX4IrjU2gW42ahmwcNKIRPOafzUHj8AGJuU1v2iETz6gci605
         IOJXoxer1pGz86w4ntEvPPXptt5Bv7UIhkiQNqQN53IIQ1juCp2fcfJ0rnlPrsLGBR
         wY9AETQZcH2cMoXABoviIK64A1x28UWocrrjDhwxkhAVYqrf4Ilcxjl0HjrGr3F9di
         SvxpTAd6cspu+vEvNYyYrQC/Ovba546RUZUo2wV2+bgE9Xy0IDxdfIGSIQdPbNKRjb
         BuPy4jkkQ+1cA==
Date:   Thu, 9 Mar 2023 11:53:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tushar Dave <tdave@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <20230309175321.GA1151233@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbd48b5-1d6e-8fe3-d6a0-cb341e5c34e3@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Wed, Mar 08, 2023 at 07:34:58PM -0800, Tushar Dave wrote:
> On 3/7/23 03:59, Sagi Grimberg wrote:
> > On 3/2/23 02:09, Tushar Dave wrote:
> > > We are observing NVMe device disabled due to reset failure after
> > > injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
> > > I tried this on 2 different system and it is 100% reproducible with 6.2
> > > kernel.
> > > 
> > > On my system, Samsung NVMe SSD Controller PM173X is directly behind the
> > > Broadcom PCIe Switch Downstream Port.
> > > MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch
> > > to 128B (keeping NVMe device MPS 512B).
> > > 
> > > e.g.
> > > # change MPS of PCIe switch (a9:10.0)
> > > $ setpci -v -s a9:10.0 cap_exp+0x8.w
> > > 0000:a9:10.0 (cap 10 @68) @70 = 0857
> > > $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
> > > 0000:a9:10.0 (cap 10 @68) @70 0817
> > > $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
> > >          DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
> > >              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> > >              MaxPayload 128 bytes, MaxReadReq 128 bytes
> > > 
> > > # run some traffic on nvme (ab:00.0)
> > > $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
> > > dd: error reading '/dev/nvme0n1': Input/output error
> > > 2+0 records in
> > > 2+0 records out
> > > 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
> > > 
> > > #kernel log:
> > > [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
> > > [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> > > [  163.049071] pcieport 0000:a9:10.0: DPC: containment event,
> > > status:0x2009 source:0x0000
> > > [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
> > > detected
> > > [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error:
> > > severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> > > [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error
> > > status/mask=00040000/00180000
> > > [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP
> > > (First)
> > > [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
> > > ab0000ff 00000001 d1fd0000
> > > [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> > > [  163.112095] nvme nvme0: frozen state error detected, reset controller
> > > [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error
> > > (sct 0x3 / sc 0x71)
> > > [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
> > > 0x4080700 phys_seg 4 prio class 2
> > > [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> > > [  163.390895] nvme nvme0: restart after slot reset
> > > [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c
> > > (was 0x100, writing 0x1ff)
> > > [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30
> > > (was 0x0, writing 0xe0600000)
> > > [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10
> > > (was 0x4, writing 0xe0710004)
> > > [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc
> > > (was 0x0, writing 0x8)
> > > [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4
> > > (was 0x100000, writing 0x100546)
> > > [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
> > > [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0
> > > (reading 0xa824144d)
> > > [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4
> > > (reading 0x100546)
> > > [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8
> > > (reading 0x1080200)
> > > [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc
> > > (reading 0x8)
> > > [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10
> > > (reading 0xe0710004)
> > > [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14
> > > (reading 0x0)
> > > [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18
> > > (reading 0x0)
> > > [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c
> > > (reading 0x0)
> > > [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20
> > > (reading 0x0)
> > > [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24
> > > (reading 0x0)
> > > [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28
> > > (reading 0x0)
> > > [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c
> > > (reading 0xa80a144d)
> > > [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30
> > > (reading 0xe0600000)
> > > [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34
> > > (reading 0x40)
> > > [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38
> > > (reading 0x0)
> > > [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c
> > > (reading 0x1ff)
> > > [  210.089132] block nvme0n1: no usable path - requeuing I/O
> > > [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
> > > [  223.825236] nvme nvme0: Identify Controller failed (-4)
> > > [  223.832145] nvme nvme0: Disabling device after reset failure: -5
> > 
> > At this point the device is not going to recover.
> Yes, I agree.
> 
> I looked little bit more and found that nvme reset failure and second DPC,
> both were due to nvme_slot_reset() restoring MPS as part of
> pci_restore_state().
> 
> AFAICT, after the first DPC event occurs, nvme device MPS gets changed to
> _default_ value 128B (this is likely due to DPC link retraining). However as
> part of software AER recovery, nvme_slot_reset() restores device state, and
> that brings the nvme device MPS back to 512B. (MPS of PCIe switch a9:10.0
> still remains at 128B).
>
> At this point when nvme_reset_ctrl->nvme_reset_work() tries to enable the
> device, malformedTLP again getting generated and that causes second DPC,
> makes NVMe controller reset to fail as well.

This sounds like the behavior I expect.  IIUC:

  - Switch and NVMe MPS are 512B
  - NVMe config space saved (including MPS=512B)
  - You change Switch MPS to 128B
  - NVMe does DMA with payload > 128B
  - Switch reports Malformed TLP because TLP is larger than its MPS
  - Recovery resets NVMe, which sets MPS to the default of 128B
  - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
  - Subsequent NVMe DMA with payload > 128B repeats cycle

What do you think *should* be happening here?  I don't see a PCI
problem here.  If you change MPS on the Switch without coordinating
with NVMe, things aren't going to work.  Or am I missing something?

Bjorn
