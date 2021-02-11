Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE24318728
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBKJcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhBKJaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 04:30:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34DCB64DE2;
        Thu, 11 Feb 2021 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613035757;
        bh=TdDtTkUvRYVcZIeH1JHLGALhh7StacRh/n9Adchr+SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiDtzenrs7HOobzQEk+/zmYceBiXPUdQUnfKrlNOPDgyLjeFGD10dM5dufesC6YFU
         ZisAcxCnIaMX2f+hJO/OSEdInO23t2u/xcXUGC6qIIn/LR4ROjwqFBulDIpm+bgvSm
         q3SkLAHvNaePKprWB1m4qGAsrrceYHm4OryiwFd07P0hSdD4eb3aRCjj8BioFOX5Vy
         yWtlNcr8m+a6ZCwoyU/6M9TBpqvbkD2IAXq/iSfu0n7A/dF4md0e8PtYAT9j/B2177
         yDHNkVs+KFmdJ1FLGcDPH2Ux1NwH9JTCRTH0aNp/59MD1ZLBMaygqArGXX6Us4n3Tt
         NDAlRLlGhVYxA==
Date:   Thu, 11 Feb 2021 11:29:14 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 6/6] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Message-ID: <20210211092914.GD1275163@unreal>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <dce623f03f782fe536765916a9c3be36cee1dfe2.1613034397.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dce623f03f782fe536765916a9c3be36cee1dfe2.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:08:43AM +0100, Gustavo Pimentel wrote:
> This patch describes the sysfs interface implemented on the dw-xdata-pcie
> driver.
>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata

I don't know and maybe this is how modern drivers are developed now, but my
laptop doesn't have anything driver and vendor specific related under plain
/sys/kernel/* directory.

➜  kernel git:(rdma-next) ls -l /sys/kernel
total 0
drwxr-xr-x.   2 root root    0 Feb 11 11:20 boot_params
drwxr-xr-x.   2 root root    0 Feb 11 11:20 btf
drwxr-xr-x.   2 root root    0 Feb 11 11:20 cgroup
drwxr-xr-x.   2 root root    0 Feb  8 07:45 config
drwx------.  51 root root    0 Feb  8 07:45 debug
-r--r--r--.   1 root root 4096 Feb 11 11:20 fscaps
drwxr-xr-x.   2 root root    0 Feb  8 10:16 iommu_groups
drwxr-xr-x.  94 root root    0 Feb 11 11:20 irq
-r--r--r--.   1 root root 4096 Feb 11 11:20 kexec_crash_loaded
-rw-r--r--.   1 root root 4096 Feb 11 11:20 kexec_crash_size
-r--r--r--.   1 root root 4096 Feb 11 11:20 kexec_loaded
drwxr-xr-x.   2 root root    0 Feb 11 11:20 livepatch
drwxr-xr-x.   6 root root    0 Feb  8 07:45 mm
-r--r--r--.   1 root root  512 Feb 11 11:20 notes
-rw-r--r--.   1 root root 4096 Feb 11 11:20 profiling
-rw-r--r--.   1 root root 4096 Feb 11 11:20 rcu_expedited
-rw-r--r--.   1 root root 4096 Feb 11 11:20 rcu_normal
drwxr-xr-x.   4 root root    0 Feb  8 07:45 security
drwxr-xr-x. 163 root root    0 Feb 11 11:20 slab
drwxr-xr-x.   4 root root    0 Feb 11 11:20 software_nodes
drwx------.   8 root root    0 Feb  8 07:45 tracing
-r--r--r--.   1 root root 4096 Feb 11 11:20 uevent_seqnum
-r--r--r--.   1 root root 4096 Feb 11 11:20 vmcoreinfo

Also it is very uncommon in large subsystems to see custom sysfs entries
for the specific driver. I wonder why this dw-xdata-pcie driver is different.

Thanks

>
> diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
> new file mode 100644
> index 00000000..a7bb44b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> @@ -0,0 +1,46 @@
> +What:		/sys/kernel/dw-xdata-pcie/write
> +Date:		February 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to enable the PCIe traffic generator which
> +		will create write TLPs frames - from the Root Complex to the
> +		Endpoint direction.
> +		Usage e.g.
> +		 echo 1 > /sys/kernel/dw-xdata-pcie/write
> +
> +		The user can read the current PCIe link throughput generated
> +		through this generator.
> +		Usage e.g.
> +		 cat /sys/kernel/dw-xdata-pcie/write
> +		 204 MB/s
> +
> +		The file is read and write.
> +
> +What:		/sys/kernel/dw-xdata-pcie/read
> +Date:		February 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to enable the PCIe traffic generator which
> +		will create read TLPs frames - from the Endpoint to the Root
> +		Complex direction.
> +		Usage e.g.
> +		 echo 1 > /sys/kernel/dw-xdata-pcie/read
> +
> +		The user can read the current PCIe link throughput generated
> +		through this generator.
> +		Usage e.g.
> +		 cat /sys/kernel/dw-xdata-pcie/read
> +		 199 MB/s
> +
> +		The file is read and write.
> +
> +What:		/sys/kernel/dw-xdata-pcie/stop
> +Date:		February 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to disable the PCIe traffic generator in all
> +		directions.
> +		Usage e.g.
> +		 echo 1 > /sys/kernel/dw-xdata-pcie/stop
> +
> +		The file is write only.
> --
> 2.7.4
>
