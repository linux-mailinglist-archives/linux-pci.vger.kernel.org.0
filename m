Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87D34BC68
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1MuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 08:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhC1MuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 08:50:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC8DD61920;
        Sun, 28 Mar 2021 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935821;
        bh=b+buVN5aG+qlyTWm1YcinjejUz7pYce/bddgEQgIIjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMzTLqsSUo/ps/llWyLsEokdTAWddTSkk4hUVogNrK8NC8xPa6ORopsMNpoM3cBBF
         Mr4UE7tFRyd12g9bzzLNNqpYp8MgBBlB0KXa6YiXIJ9MqiwCNkOr+TY5r/O9tbd/3u
         ZOWUTKu0f5Uf6KzMhlRCFn8qEMj+NCD0GlHV4RXg=
Date:   Sun, 28 Mar 2021 14:50:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v7 5/5] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Message-ID: <YGB7itUZILP1rqNj@kroah.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
 <83d6573cf8bd03a0b3c3497ded6dce3f0b2e2ebd.1616814273.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d6573cf8bd03a0b3c3497ded6dce3f0b2e2ebd.1616814273.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 04:06:55AM +0100, Gustavo Pimentel wrote:
> This patch describes the sysfs interface implemented on the dw-xdata-pcie
> driver.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
> new file mode 100644
> index 00000000..cb3ab7e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> @@ -0,0 +1,46 @@
> +What:		/sys/class/misc/drivers/dw-xdata-pcie/write
> +Date:		April 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to enable the PCIe traffic generator which
> +		will create write TLPs frames - from the Root Complex to the
> +		Endpoint direction.
> +		Usage e.g.
> +		 echo 1 > /sys/class/misc/dw-xdata-pcie/write

That did not look like what the code was looking for at all :(


> +
> +		The user can read the current PCIe link throughput generated
> +		through this generator in MB/s.
> +		Usage e.g.
> +		 cat /sys/class/misc/dw-xdata-pcie/write
> +		 204
> +
> +		The file is read and write.
> +
> +What:		/sys/class/misc/dw-xdata-pcie/read
> +Date:		April 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to enable the PCIe traffic generator which
> +		will create read TLPs frames - from the Endpoint to the Root
> +		Complex direction.
> +		Usage e.g.
> +		 echo 1 > /sys/class/misc/dw-xdata-pcie/read

Again, did not match the code :(


> +
> +		The user can read the current PCIe link throughput generated
> +		through this generator in MB/s.
> +		Usage e.g.
> +		 cat /sys/class/misc/dw-xdata-pcie/read
> +		 199
> +
> +		The file is read and write.
> +
> +What:		/sys/class/misc/dw-xdata-pcie/stop
> +Date:		April 2021
> +KernelVersion:	5.12
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to disable the PCIe traffic generator in all
> +		directions.
> +		Usage e.g.
> +		 echo 1 > /sys/class/misc/dw-xdata-pcie/stop

Same here :(

Who tested this?
