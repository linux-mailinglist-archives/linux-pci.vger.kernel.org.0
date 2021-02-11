Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51B318751
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBKJqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhBKJhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 04:37:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8394C60238;
        Thu, 11 Feb 2021 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613036186;
        bh=EF7BoELqh8AFftHlLQgKMYNIBfyeyzf1EC2TjiCf92c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhBgm3wOGtHVUFqnOWQxFSE5GzU4P64eZgDHqQe3MeGe/V3u6+2+PsXfpqjRv7b5T
         owsZZcBsQKFD1+EEbyx3D9bmM6OxmoqxJGFPp3nxk8eeBxYXfFZVBpUyjTSKZVwSP/
         OMTJvXpPL9x9Vf2lsKwFEhVXQoIUCB+02+EYJR4I=
Date:   Thu, 11 Feb 2021 10:36:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 6/6] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Message-ID: <YCT6lp+kxpwa9sRi@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <dce623f03f782fe536765916a9c3be36cee1dfe2.1613034397.git.gustavo.pimentel@synopsys.com>
 <20210211092914.GD1275163@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211092914.GD1275163@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 11:29:14AM +0200, Leon Romanovsky wrote:
> On Thu, Feb 11, 2021 at 10:08:43AM +0100, Gustavo Pimentel wrote:
> > This patch describes the sysfs interface implemented on the dw-xdata-pcie
> > driver.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
> 
> I don't know and maybe this is how modern drivers are developed now, but my
> laptop doesn't have anything driver and vendor specific related under plain
> /sys/kernel/* directory.
> 
> ➜  kernel git:(rdma-next) ls -l /sys/kernel
> total 0
> drwxr-xr-x.   2 root root    0 Feb 11 11:20 boot_params
> drwxr-xr-x.   2 root root    0 Feb 11 11:20 btf
> drwxr-xr-x.   2 root root    0 Feb 11 11:20 cgroup
> drwxr-xr-x.   2 root root    0 Feb  8 07:45 config
> drwx------.  51 root root    0 Feb  8 07:45 debug
> -r--r--r--.   1 root root 4096 Feb 11 11:20 fscaps
> drwxr-xr-x.   2 root root    0 Feb  8 10:16 iommu_groups
> drwxr-xr-x.  94 root root    0 Feb 11 11:20 irq
> -r--r--r--.   1 root root 4096 Feb 11 11:20 kexec_crash_loaded
> -rw-r--r--.   1 root root 4096 Feb 11 11:20 kexec_crash_size
> -r--r--r--.   1 root root 4096 Feb 11 11:20 kexec_loaded
> drwxr-xr-x.   2 root root    0 Feb 11 11:20 livepatch
> drwxr-xr-x.   6 root root    0 Feb  8 07:45 mm
> -r--r--r--.   1 root root  512 Feb 11 11:20 notes
> -rw-r--r--.   1 root root 4096 Feb 11 11:20 profiling
> -rw-r--r--.   1 root root 4096 Feb 11 11:20 rcu_expedited
> -rw-r--r--.   1 root root 4096 Feb 11 11:20 rcu_normal
> drwxr-xr-x.   4 root root    0 Feb  8 07:45 security
> drwxr-xr-x. 163 root root    0 Feb 11 11:20 slab
> drwxr-xr-x.   4 root root    0 Feb 11 11:20 software_nodes
> drwx------.   8 root root    0 Feb  8 07:45 tracing
> -r--r--r--.   1 root root 4096 Feb 11 11:20 uevent_seqnum
> -r--r--r--.   1 root root 4096 Feb 11 11:20 vmcoreinfo
> 
> Also it is very uncommon in large subsystems to see custom sysfs entries
> for the specific driver. I wonder why this dw-xdata-pcie driver is different.

It is not, and should not do that at all.

