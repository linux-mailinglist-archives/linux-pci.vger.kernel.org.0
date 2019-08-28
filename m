Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF19FE7A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfH1JaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 05:30:08 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36321 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfH1JaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 05:30:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 760E65A6;
        Wed, 28 Aug 2019 05:30:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 28 Aug 2019 05:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=P8J9s2s8eH7Ar5wyBE89/+UKWMN
        ppv9j293pWFZo1Yg=; b=HpYnOvau8zH3WqEcR/mx7lCU2Id+FHhUM084nNAPzee
        XakZbK7BRuxW4w+rwluC5mi0LWlr34FaGlkEzAI3Zw6yxM131YJYP8pmB8yWONuV
        oVdPVg3YLUlwMByM/rZPLsNf5acgjctfsa+qRYgaJMhbukWFaQwAkny+tjyIXr3R
        0eWn6/85MzSEUhDvr2eljBHNQSKyl47jL0x/5kWW2A51XPD7j2hLCXtc5VEqycpi
        R7fFFP17XpUvLyrMmJUQqD/Wre9DH73fm0XcVMnf8DtzkImtUaNK4RWRrPdio//l
        lB2XVz24W56jpUmbRtvwXZGf0DRbrCrES2f4Sk8J99Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=P8J9s2
        s8eH7Ar5wyBE89/+UKWMNppv9j293pWFZo1Yg=; b=DWggFqvhmPOa2rzdhiAREY
        i5BOfDGYG70ClWrNzP1xpr38UChGoqCqz5/aefbYgQVGSvxOXaLUiumS3Fbf07K3
        buifKTlirlWK8tBYLUdMQOJhrusxWsfGDJiReZEk1t3D8kRKjYi0lrgkm73c5EMF
        YJ9X8L957ZyzzJ0WQugNHfydF7sZOT69c1+BPC5RLNNQ9pGhuZNc7ORkvbMCvuEb
        3Nrl+8nTtVrrpL8lFHJqkLSFr8bz4h7Dt2zVxnPwIKiNEyaLW0xb2vV0KdK0UWop
        OTbd4gjBVzaEMLx9zjXeMdoQ9ueFgNSeWMNfrALEeOxsaG8ozGKVL8Nh+++5pIrw
        ==
X-ME-Sender: <xms:nUlmXX-lZUmG2di96mKAMnSXwtpyi1p3Rbz-9imqfJrhKFhyUVSSug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehlkhhmlhdroh
    hrghenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:nUlmXYxfDTMg8P0aGyJKcgsBWVXWB_PNLz5YjEXOmlkT_2q61uNIbQ>
    <xmx:nUlmXSC8vygScdf3ZeQzc-z3lIhIYgl6-Vig8b7fF0Xtfmwc_vuWwA>
    <xmx:nUlmXRJ7Vj-VTAQ4hsRBNkb46UxZjtTXP5R378zrwajcfSNM7Stggw>
    <xmx:nklmXUd6Y1kv2dgVhrJ_Ym7WVg4XpfaUMzjAEUvYKQ3-zPBXxNTJwA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F038D6005E;
        Wed, 28 Aug 2019 05:30:05 -0400 (EDT)
Date:   Wed, 28 Aug 2019 11:30:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatxjain@gmail.com
Subject: Re: [PATCH v3 2/2] PCI/AER: Split the AER stats into multiple sysfs
 attributes
Message-ID: <20190828093004.GC23192@kroah.com>
References: <20190827062309.GA30987@kroah.com>
 <20190827222145.32642-1-rajatja@google.com>
 <20190827222145.32642-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827222145.32642-2-rajatja@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 03:21:45PM -0700, Rajat Jain wrote:
> Split the AER stats into multiple sysfs atributes. Note that
> this changes the ABI of the AER stats, but hopefully, there
> aren't active users that need to change. This is how the AERs
> are being exposed now:
> 
> localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats # ls -l
> total 0
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit0_RxErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit12_Timeout
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit13_NonFatalErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit14_CorrIntErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit15_HeaderOF
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit6_BadTLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit7_BadDLLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit8_Rollover
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit0_Undefined
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit12_TLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit13_FCP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit14_CmpltTO
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit15_CmpltAbrt
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit16_UnxCmplt
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit17_RxOF
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit18_MalfTLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit19_ECRC
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit20_UnsupReq
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit21_ACSViol
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit22_UncorrIntErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit23_BlockedTLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit24_AtomicOpBlocked
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit25_TLPBlockedErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit26_PoisonTLPBlocked
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit4_DLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit5_SDES
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit0_Undefined
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit12_TLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit13_FCP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit14_CmpltTO
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit15_CmpltAbrt
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit16_UnxCmplt
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit17_RxOF
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit18_MalfTLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit19_ECRC
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit20_UnsupReq
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit21_ACSViol
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit22_UncorrIntErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit23_BlockedTLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit24_AtomicOpBlocked
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit25_TLPBlockedErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit26_PoisonTLPBlocked
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit4_DLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit5_SDES
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_cor
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_fatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_nonfatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_cor
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_fatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_nonfatal
> localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats #
> 
> Each file is has a single counter value. Single file containing all
> stats was frowned upon and discussed here:
> https://lkml.org/lkml/2019/6/28/220
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: indent the sysfs attribute names in documentation.
> v2: Also change the Documentation
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 160 ++++++++---------
>  drivers/pci/pcie/aer.c                        | 166 +++++++++++++-----
>  2 files changed, 191 insertions(+), 135 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index 3c9a8c4a25eb..8cd93acddf76 100644
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
> +	correctable_bit0_RxErr
> +	correctable_bit12_Timeout
> +	correctable_bit13_NonFatalErr
> +	correctable_bit14_CorrIntErr
> +	correctable_bit15_HeaderOF
> +	correctable_bit6_BadTLP
> +	correctable_bit7_BadDLLP
> +	correctable_bit8_Rollover
> +	fatal_bit0_Undefined
> +	fatal_bit12_TLP
> +	fatal_bit13_FCP
> +	fatal_bit14_CmpltTO
> +	fatal_bit15_CmpltAbrt
> +	fatal_bit16_UnxCmplt
> +	fatal_bit17_RxOF
> +	fatal_bit18_MalfTLP
> +	fatal_bit19_ECRC
> +	fatal_bit20_UnsupReq
> +	fatal_bit21_ACSViol
> +	fatal_bit22_UncorrIntErr
> +	fatal_bit23_BlockedTLP
> +	fatal_bit24_AtomicOpBlocked
> +	fatal_bit25_TLPBlockedErr
> +	fatal_bit26_PoisonTLPBlocked
> +	fatal_bit4_DLP
> +	fatal_bit5_SDES
> +	nonfatal_bit0_Undefined
> +	nonfatal_bit12_TLP
> +	nonfatal_bit13_FCP
> +	nonfatal_bit14_CmpltTO
> +	nonfatal_bit15_CmpltAbrt
> +	nonfatal_bit16_UnxCmplt
> +	nonfatal_bit17_RxOF
> +	nonfatal_bit18_MalfTLP
> +	nonfatal_bit19_ECRC
> +	nonfatal_bit20_UnsupReq
> +	nonfatal_bit21_ACSViol
> +	nonfatal_bit22_UncorrIntErr
> +	nonfatal_bit23_BlockedTLP
> +	nonfatal_bit24_AtomicOpBlocked
> +	nonfatal_bit25_TLPBlockedErr
> +	nonfatal_bit26_PoisonTLPBlocked
> +	nonfatal_bit4_DLP
> +	nonfatal_bit5_SDES

{sigh}

Does this look good to you?  There's a whole lot of alignment in the
original tags here, and you are not doing that here at all.

Yes, this is a trivial complaint, but please, these should be easy to
read and understand, and you aren't makeing it that here...


> +Date:		Aug 2019
> +KernelVersion:  5.3.0

I do not think this will hit 5.3, right?

thanks,

greg k-h
