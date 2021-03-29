Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC89834CDA1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhC2KI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232070AbhC2KIO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 06:08:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F0E61585;
        Mon, 29 Mar 2021 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617012494;
        bh=c/7u/i7ph/tkb1ucVKeq7qerOvzc66BELd2N9yKT6Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xi8z6QdvTQisUhBYLvuH+RY6/Ar4ZYGIuQ6n08/iItJYlqAAZnaxkoeuXDw9aMpj+
         XoG/64oHaZ9QotDYjedPS5h+aUMK8hpIJfROZiCuiezNc9/qrPrZQqZlkMDH3FbTe3
         KffsAwS6ZGeTd5YofEP/7OvODgm5LbhfEATrZoDc=
Date:   Mon, 29 Mar 2021 12:08:11 +0200
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
Subject: Re: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Message-ID: <YGGnC8LouF+paZ6G@kroah.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
 <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:59:40AM +0200, Gustavo Pimentel wrote:
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
> index 00000000..66af19a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> @@ -0,0 +1,46 @@
> +What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
> +Date:		April 2021
> +KernelVersion:	5.13
> +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +Description:	Allows the user to enable the PCIe traffic generator which
> +		will create write TLPs frames - from the Root Complex to the
> +		Endpoint direction.
> +		Usage e.g.
> +		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write

Again, this does not match the code.  Either fix the code (which I
recommend), or change this and the other sysfs descriptions of writing
values here.

thanks,

greg k-h
