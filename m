Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B83439AC0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhJYPuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 11:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhJYPuD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 11:50:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2450360720;
        Mon, 25 Oct 2021 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635176861;
        bh=Xwb5Yz7gFBCWfV8eeB5HZeQ6RselDA4w2/nvB8onK8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GqYaw9FP0d/q74pySuxBYGNCr2Bozemjbhn/kpaCx5xu9p/jQhNJlKWPK1yf/lrvH
         /QcTqpdFi205KqDDb3VGwzrP9hOT4jrb53H5q6hO6cqivki+CuBK4f6pNunEj+23qz
         OwpKmYyse90v0/KQ8tPxhYihSlz2ivPtbw6EFheLNumPPFLnctEDxPsBxT2S5bmcSU
         7a67vZNbrQZUXuBG4jn4Ks/eex+vcmofL80odgGgMgdXkKEtdxwo/IyHZlECa82Hk0
         VVDKp6CTfWKGJazoBm2MxJapVtU+GhzaVQrP6jdLx5y8levlfuInWMm5YAXX7CAZ0D
         gEhbEjsZU3+sA==
Date:   Mon, 25 Oct 2021 10:47:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: nvme may get timeout from dd when using different non-prefetch
 mmio outbound/ranges
Message-ID: <20211025154739.GA4760@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Tom (Cadence maintainer), NVMe folks]

On Fri, Oct 22, 2021 at 10:08:20AM +0000, Li Chen wrote:
> Hi, all
> 
> I found my nvme may get timeout with simply dd, the pcie controller
> is cadence, and the pcie-controller platform I use is
> pcie-cadence-host.c, kenrel version is 5.10.32:

Given that nvme is pretty widely used, I tend to suspect the cadence
driver or DTS here, but I added both cadence and nvme folks to the CC:
list.

> # dd if=/dev/urandom of=/dev/nvme0n1 bs=4k count=1024000
> [   41.913484][  T274] urandom_read: 2 callbacks suppressed
> [   41.913490][  T274] random: dd: uninitialized urandom read (4096 bytes read)
> [   41.926130][  T274] random: dd: uninitialized urandom read (4096 bytes read)
> [   41.933348][  T274] random: dd: uninitialized urandom read (4096 bytes read)
> [   47.651842][    C0] random: crng init done
> [   47.655963][    C0] random: 2 urandom warning(s) missed due to ratelimiting
> [   81.448128][   T64] nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x2010
> [   81.481139][    T7] nvme 0000:05:00.0: enabling bus mastering
> [   81.486946][    T7] nvme 0000:05:00.0: saving config space at offset 0x0 (reading 0xa809144d)
> [   81.495517][    T7] nvme 0000:05:00.0: saving config space at offset 0x4 (reading 0x20100006)
> [   81.504091][    T7] nvme 0000:05:00.0: saving config space at offset 0x8 (reading 0x1080200)
> [   81.512571][    T7] nvme 0000:05:00.0: saving config space at offset 0xc (reading 0x0)
> [   81.520527][    T7] nvme 0000:05:00.0: saving config space at offset 0x10 (reading 0x8000004)
> [   81.529094][    T7] nvme 0000:05:00.0: saving config space at offset 0x14 (reading 0x0)
> [   81.537138][    T7] nvme 0000:05:00.0: saving config space at offset 0x18 (reading 0x0)
> [   81.545186][    T7] nvme 0000:05:00.0: saving config space at offset 0x1c (reading 0x0)
> [   81.553252][    T7] nvme 0000:05:00.0: saving config space at offset 0x20 (reading 0x0)
> [   81.561296][    T7] nvme 0000:05:00.0: saving config space at offset 0x24 (reading 0x0)
> [   81.569340][    T7] nvme 0000:05:00.0: saving config space at offset 0x28 (reading 0x0)
> [   81.577384][    T7] nvme 0000:05:00.0: saving config space at offset 0x2c (reading 0xa801144d)
> [   81.586038][    T7] nvme 0000:05:00.0: saving config space at offset 0x30 (reading 0x0)
> [   81.594081][    T7] nvme 0000:05:00.0: saving config space at offset 0x34 (reading 0x40)
> [   81.602217][    T7] nvme 0000:05:00.0: saving config space at offset 0x38 (reading 0x0)
> [   81.610266][    T7] nvme 0000:05:00.0: saving config space at offset 0x3c (reading 0x12c)
> [   81.634065][    T7] nvme nvme0: Shutdown timeout set to 8 seconds
> [   81.674332][    T7] nvme nvme0: 1/0/0 default/read/poll queues
> [  112.168136][  T256] nvme nvme0: I/O 12 QID 1 timeout, disable controller
> [  112.193145][  T256] blk_update_request: I/O error, dev nvme0n1, sector 600656 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.205220][  T256] Buffer I/O error on dev nvme0n1, logical block 75082, lost async page write
> [  112.213978][  T256] Buffer I/O error on dev nvme0n1, logical block 75083, lost async page write
> [  112.222727][  T256] Buffer I/O error on dev nvme0n1, logical block 75084, lost async page write
> [  112.231474][  T256] Buffer I/O error on dev nvme0n1, logical block 75085, lost async page write
> [  112.240220][  T256] Buffer I/O error on dev nvme0n1, logical block 75086, lost async page write
> [  112.248966][  T256] Buffer I/O error on dev nvme0n1, logical block 75087, lost async page write
> [  112.257719][  T256] Buffer I/O error on dev nvme0n1, logical block 75088, lost async page write
> [  112.266467][  T256] Buffer I/O error on dev nvme0n1, logical block 75089, lost async page write
> [  112.275213][  T256] Buffer I/O error on dev nvme0n1, logical block 75090, lost async page write
> [  112.283959][  T256] Buffer I/O error on dev nvme0n1, logical block 75091, lost async page write
> [  112.293554][  T256] blk_update_request: I/O error, dev nvme0n1, sector 601672 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.306559][  T256] blk_update_request: I/O error, dev nvme0n1, sector 602688 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.319525][  T256] blk_update_request: I/O error, dev nvme0n1, sector 603704 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.332501][  T256] blk_update_request: I/O error, dev nvme0n1, sector 604720 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.345466][  T256] blk_update_request: I/O error, dev nvme0n1, sector 605736 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.358427][  T256] blk_update_request: I/O error, dev nvme0n1, sector 606752 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.371386][  T256] blk_update_request: I/O error, dev nvme0n1, sector 607768 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.384346][  T256] blk_update_request: I/O error, dev nvme0n1, sector 608784 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.397315][  T256] blk_update_request: I/O error, dev nvme0n1, sector 609800 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
> [  112.459313][    T7] nvme nvme0: failed to mark controller live state
> [  112.465758][    T7] nvme nvme0: Removing after probe failure status: -19
> dd: error writing '/dev/nvme0n1': No space left on device
> 112200+0 records in
> 112199+0 records out
> 459567104 bytes (438.3MB) copied, 70.573266 seconds, 6.2MB/s
> # [  112.935768][    T7] nvme nvme0: failed to set APST feature (-19)
> 
> 
> 
> 
> Here is the dts I used:
> pciec: pcie-controller@2040000000 {
>                                 compatible = "cdns,cdns-pcie-host";
> 		device_type = "pci";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		bus-range = <0 5>;
> 		linux,pci-domain = <0>;
> 		cdns,no-bar-match-nbits = <38>;
> 		vendor-id = <0x17cd>;
> 		device-id = <0x0100>;
> 		reg-names = "reg", "cfg";
> 		reg = <0x20 0x40000000 0x0 0x10000000>,
> 		      <0x20 0x00000000 0x0 0x00001000>;	/* RC only */
> 
> 		/*
> 		 * type: 0x00000000 cfg space
> 		 * type: 0x01000000 IO
> 		 * type: 0x02000000 32bit mem space No prefetch
> 		 * type: 0x03000000 64bit mem space No prefetch
> 		 * type: 0x43000000 64bit mem space prefetch
> 		 * The First 16MB from BUS_DEV_FUNC=0:0:0 for cfg space
> 		 * <0x00000000 0x00 0x00000000 0x20 0x00000000 0x00 0x01000000>, CFG_SPACE
> 		*/
> 		ranges = <0x01000000 0x00 0x00000000 0x20 0x00100000 0x00 0x00100000>,
> 			 <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000>;
> 
> 		#interrupt-cells = <0x1>;
> 		interrupt-map-mask = <0x00 0x0 0x0 0x7>;
> 		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0 229 0x4>,
> 				<0x0 0x0 0x0 0x2 &gic 0 230 0x4>,
> 				<0x0 0x0 0x0 0x3 &gic 0 231 0x4>,
> 				<0x0 0x0 0x0 0x4 &gic 0 232 0x4>;
> 		phys = <&pcie_phy>;
> 		phy-names="pcie-phy";
> 		status = "ok";
> 	};
> 
> 
> After some digging, I find if I change the controller's range
> property from
>
> <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000> into
> <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>,
>
> then dd will success without timeout. IIUC, range here
> is only for non-prefetch 32bit mmio, but dd will use dma (maybe cpu
> will send cmd to nvme controller via mmio?).

I don't know how to interpret "ranges".  Can you supply the dmesg and
"lspci -vvs 0000:05:00.0" output both ways, e.g., 

  pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
  pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
  pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
  pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]

> Question:
> 1.  Why dd can cause nvme timeout? Is there more debug ways?
> 2. How can this mmio range affect nvme timeout?
> 
> Regards,
> Li
> 
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
