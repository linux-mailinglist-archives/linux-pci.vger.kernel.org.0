Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC530F110
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhBDKkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 05:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhBDKku (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 05:40:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F369364F4D;
        Thu,  4 Feb 2021 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612435208;
        bh=CQyj/sSo8xI867DsxS1WdYQhB65eb22naaawqQg/afc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqGL1T1ttXRGVzH/yHU8sj3tqnaejolVmxip/w/tP51DDu+51kPsjS2hFtgXcKfvv
         B2PllRqUiyK/DRLQrT3di2iNITlcDSmeKcE+YQgdXPjm3uJNJSVkxAenDOs2v863Vh
         Uw9Y9XP6eQkyNxCniCf+Rp9QgRJ8UrEsTYn/6Qm8=
Date:   Thu, 4 Feb 2021 11:40:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
Message-ID: <YBvPBD+fCtQkCFFD@kroah.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204094353.63819-2-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
> The global UID uniqueness attribute exposes whether the platform
> guarantees that the user-defined per-device UID attribute values
> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
> a global identifier for the associated PCI device. With this commit
> it is exposed at /sys/bus/pci/zpci/unique_uids
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c39770c6..812dd9d3f80d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -375,3 +375,12 @@ Description:
>  		The value comes from the PCI kernel device state and can be one
>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>  		The file is read only.
> +What:		/sys/bus/pci/zpci/unique_uids

No blank line before this new line?

And why "zpci"?

> +Date:		February 2021
> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
> +Description:
> +		This attribute exposes the global state of UID Uniqueness on an
> +		s390 Linux system. If this file contains '1' the per-device UID
> +		attribute is guaranteed to provide a unique user defined
> +		identifier for that PCI device. If this file contains '0' UIDs
> +		may collide and do not provide a unique identifier.

What are they "colliding" with?  And where does the UID come from, the
device itself or somewhere else?

thanks,

greg k-h
