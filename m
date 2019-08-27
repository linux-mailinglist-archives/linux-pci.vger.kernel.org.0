Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2429DD98
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 08:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfH0GXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 02:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0GXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 02:23:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA9C2054F;
        Tue, 27 Aug 2019 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566886992;
        bh=est3wmZaSmSGcTJuKxM8cN8m1fYP8CsycRXpIl+3Uos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VL2rm9MIAHpcITPpub7LChTfs4fcMod9+jzDAtp8AIJjPL8mzSyQZXEkB7m/e1O09
         NKd2CD0Vts/kOWTvdnrU6Bi/NdeE+LrBVQixyduwhpZobuT8YYWHqCnx92n6jHN+eC
         y4ejXRdv8Xla9uHWXghROmKxHmcYIYIybfwBMXoE=
Date:   Tue, 27 Aug 2019 08:23:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatxjain@gmail.com
Subject: Re: [PATCH v2 2/2] PCI/AER: Split the AER stats into multiple sysfs
 attributes
Message-ID: <20190827062309.GA30987@kroah.com>
References: <20190821231513.36454-2-rajatja@google.com>
 <20190827005114.229726-1-rajatja@google.com>
 <20190827005114.229726-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827005114.229726-2-rajatja@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 05:51:14PM -0700, Rajat Jain wrote:
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -9,89 +9,72 @@ errors may be "seen" / reported by the link partner and not the
>  problematic endpoint itself (which may report all counters as 0 as it never
>  saw any problems).
>  
> -What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
> -Date:		July 2018
> -KernelVersion: 4.19.0
> +What: Following files in /sys/bus/pci/devices/<dev>/aer_stats/
> +correctable_bit0_RxErr
> +correctable_bit12_Timeout
> +correctable_bit13_NonFatalErr
> +correctable_bit14_CorrIntErr
> +correctable_bit15_HeaderOF
> +correctable_bit6_BadTLP
> +correctable_bit7_BadDLLP
> +correctable_bit8_Rollover
> +fatal_bit0_Undefined
> +fatal_bit12_TLP
> +fatal_bit13_FCP
> +fatal_bit14_CmpltTO
> +fatal_bit15_CmpltAbrt
> +fatal_bit16_UnxCmplt
> +fatal_bit17_RxOF
> +fatal_bit18_MalfTLP
> +fatal_bit19_ECRC
> +fatal_bit20_UnsupReq
> +fatal_bit21_ACSViol
> +fatal_bit22_UncorrIntErr
> +fatal_bit23_BlockedTLP
> +fatal_bit24_AtomicOpBlocked
> +fatal_bit25_TLPBlockedErr
> +fatal_bit26_PoisonTLPBlocked
> +fatal_bit4_DLP
> +fatal_bit5_SDES
> +nonfatal_bit0_Undefined
> +nonfatal_bit12_TLP
> +nonfatal_bit13_FCP
> +nonfatal_bit14_CmpltTO
> +nonfatal_bit15_CmpltAbrt
> +nonfatal_bit16_UnxCmplt
> +nonfatal_bit17_RxOF
> +nonfatal_bit18_MalfTLP
> +nonfatal_bit19_ECRC
> +nonfatal_bit20_UnsupReq
> +nonfatal_bit21_ACSViol
> +nonfatal_bit22_UncorrIntErr
> +nonfatal_bit23_BlockedTLP
> +nonfatal_bit24_AtomicOpBlocked
> +nonfatal_bit25_TLPBlockedErr
> +nonfatal_bit26_PoisonTLPBlocked
> +nonfatal_bit4_DLP
> +nonfatal_bit5_SDES

All of those should be indented, right?

Same for other entries

thanks,

greg k-h
