Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451735D5CF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBSBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 14:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGBSBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 14:01:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E15CF21721;
        Tue,  2 Jul 2019 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562090476;
        bh=kIyxmE2Mr1IyGzQ4fVM/a6nCRCw2PNXuUwGbNB+MA+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaeHKq6Ue8uNfTzlxnZXXbihytg9QMqaUnI2S2DhsYTgdm9nOjREh0s1HoBp1xDlO
         jMLz038dAIeYfukbzvZ+QbDEhd/+8PpFGdtXSlH3SQhtX6cp5uij9hy/245ylau6iA
         Xi1Fyx+Rl6dX3GqKOxvYfoiCMYlh66VMbaFM4s7U=
Date:   Tue, 2 Jul 2019 13:01:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
Message-ID: <20190702180112.GB128603@google.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
 <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
 <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
 <E29A2CD2-1632-4575-9910-0808BD15F4D3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E29A2CD2-1632-4575-9910-0808BD15F4D3@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 04:25:59PM +0800, Kai Heng Feng wrote:
> +linux-pci
> 
> Hi Sasha,
> 
> at 6:49 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> > at 14:26, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> > 
> > > On 6/26/2019 09:14, Kai Heng Feng wrote:
> > > > Hi Sasha
> > > > at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > > > Hi Jeffrey,
> > > > > 
> > > > > We’ve encountered another issue, which causes multiple CRC
> > > > > errors and renders ethernet completely useless, here’s the
> > > > > network stats:
> > > > I also tried ignore_ltr for this issue, seems like it alleviates
> > > > the symptom a bit for a while, then the network still becomes
> > > > useless after some usage.
> > > > And yes, it’s also a Whiskey Lake platform. What’s the next step
> > > > to debug this problem?
> > > > Kai-Heng
> > > CRC errors not related to the LTR. Please, try to disable the ME on
> > > your platform. Hope you have this option in BIOS. Another way is to
> > > contact your PC vendor and ask to provide NVM without ME. Let's
> > > start debugging with these steps.
> > 
> > According to ODM, the ME can be physically disabled by a jumper.
> > But after disabling the ME the same issue can still be observed.
> 
> We’ve found that this issue doesn’t happen to SATA SSD, it only happens when
> NVMe SSD is in use.
> 
> Here are the steps:
> - Disable NVMe ASPM, issue persists
> - modprobe -r e1000e && modprobe e1000e, issue doesn’t happen
> - Enabling NVMe ASPM, issue doesn’t happen
> 
> As long as NVMe ASPM gets enabled after e1000e gets loaded, the issue
> doesn’t happen.

IIUC the problem happens with the mainline and dev-queue e1000e
driver, but not with the out-of-tree Intel driver.  Since there is a
working driver and there's the potential (at least in principle) for
unifying them or bisecting between them, I have limited interest in
debugging it from scratch.

If it turns out to be a PCI core problem, I would want to know: What's
the PCI topology?  "lspci -vv" output for the system?  Does it make a
difference if you boot with "pcie_aspm=off"?  Collect complete dmesg,
maybe attach it to a kernel.org bugzilla?

> > > > > /sys/class/net/eno1/statistics$ grep . *
> > > > > collisions:0
> > > > > multicast:95
> > > > > rx_bytes:1499851
> > > > > rx_compressed:0
> > > > > rx_crc_errors:1165
> > > > > rx_dropped:0
> > > > > rx_errors:2330
> > > > > rx_fifo_errors:0
> > > > > rx_frame_errors:0
> > > > > rx_length_errors:0
> > > > > rx_missed_errors:0
> > > > > rx_nohandler:0
> > > > > rx_over_errors:0
> > > > > rx_packets:4789
> > > > > tx_aborted_errors:0
> > > > > tx_bytes:864312
> > > > > tx_carrier_errors:0
> > > > > tx_compressed:0
> > > > > tx_dropped:0
> > > > > tx_errors:0
> > > > > tx_fifo_errors:0
> > > > > tx_heartbeat_errors:0
> > > > > tx_packets:7370
> > > > > tx_window_errors:0
> > > > > 
> > > > > Same behavior can be observed on both mainline kernel and on
> > > > > your dev-queue branch.
> > > > > OTOH, the same issue can’t be observed on out-of-tree e1000e.
> > > > > 
> > > > > Is there any plan to close the gap between upstream and
> > > > > out-of-tree version?
> > > > > 
> > > > > Kai-Heng
> 
> 
