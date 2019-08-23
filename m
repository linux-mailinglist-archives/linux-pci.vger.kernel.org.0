Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AE49B5B0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfHWRph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 13:45:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53497 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbfHWRph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 13:45:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C3C1221B1B;
        Fri, 23 Aug 2019 13:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 23 Aug 2019 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lVyCGBXSSCQnZhOtnYu7o00wJCF
        IuFyiGIL5jBbRwvM=; b=pqS/M5HHZRe9l1FTP3lKTN3VxYTHoZrG+1jx5XrXKs6
        NKXFWVkypiRzzQW8nY5A6Lqvcxmfpy2I7L2xMRyIL4S5Tl4eOvFRUk7gofwc1XUL
        OQU8FyODmC4h6F5N7MCvz6EUgt0vI++U8NV1BUHUhvzMgLBWWejNHPN5IMtShEqt
        htjxO9uoHY2M1Vrze1Eq1vh0M0rQFnMxWkxPmou84ibMxWQBkhj764wDg8KdzgJV
        pSxF2v4clDocer6tWxQXm8qJbI1loTV84wiQ5i+VC5efEdWmPWQ9vgnp0CdNkbKp
        QGTyHB3gyjvTqy94udFl8dleHOrabBlrfLyJloEILAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lVyCGB
        XSSCQnZhOtnYu7o00wJCFIuFyiGIL5jBbRwvM=; b=hQ8EOI38+Zo+wkz2wmlf9g
        1lj9csv/Rn0hRiJzgSfwpqRBJpJ9ptBQZu4O7hC3rQWwSZ9tWBkOhFj4bbvnDIJu
        /WkJ33B7x7wd9F5B0X2g6PG2//CJM2fdBKetaOf5+cEaJg1fQmnkem0iTgN2KH7Z
        ZKti0TgK0tzZwyS7r8dbsb7GaEQiYNnYEZ/4CiGQeyUdQXAo7hMCDi78JhGtTFs1
        6OeecKsv8b1TcGuM1iNQkJ5pFw4BIFQU7AdIUoYrAN+kbEnX/23uPXM9Z38H66bf
        e103m3qrtefxwT7/AyygBU+2r0ZyJG3ivkWTxctVNGLQ1k0Rr9Qm5DXPLZ2JevOQ
        ==
X-ME-Sender: <xms:PyZgXapDP1g87-lbaE7Tv3cS9vmXfzUGPr2uP2cqZFO5i-1owGEAcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinheplhhkmhhlrd
    horhhgnecukfhppedutdegrdduvdelrdduleekrddvfeehnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PyZgXVxRt3CVJKTVS5XFlqfxC8i-9J_lEWmxzMGYZ0Glo2N1OeofQA>
    <xmx:PyZgXca1myLW02AtsGM-PaJrN1fHDl1Nrz8fRZj5yJUli2n3BDHPSA>
    <xmx:PyZgXaDJzrZRzkAnFV-SZh7BaqTSikPeFXQe_YTaBvtmZ64IxMGx3Q>
    <xmx:PyZgXdD-zUy_Ofm_Sh81ssT6Pftx6rJIqKRWSRg5s1gcdPP5TD9X-g>
Received: from localhost (unknown [104.129.198.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DCD7D60062;
        Fri, 23 Aug 2019 13:45:35 -0400 (EDT)
Date:   Fri, 23 Aug 2019 10:45:34 -0700
From:   Greg KH <greg@kroah.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatxjain@gmail.com
Subject: Re: [PATCH 2/2] PCI/AER: Split the AER stats into multiple sysfs
 attributes
Message-ID: <20190823174534.GC8052@kroah.com>
References: <20190821231513.36454-1-rajatja@google.com>
 <20190821231513.36454-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231513.36454-2-rajatja@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 04:15:13PM -0700, Rajat Jain wrote:
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
> I personally think that this makes it a little overwhelming for a human,
> e.g. I could look at total but don't exactly know while file to look at
> next in order to drill down. But I couldn't think of any other way. Some
> problems I'd have liked to fix but they require deeper surgery:
> 
> * Now each PCI device sysfs node will have a sub-directory called aer_stats.
>   (The subdirectory will have attributes only if it supports AER, but
>    the sub directory will always be present). 
> 
> * This patch isn't re-using the strings array like it was using earlier.
>   I thought of adding the attribute group at run time, so it will take
>   care of both the problems, but can only do that after device_add() call,
>   I think.
> 
> If we are comfortable introducing a call to a new function
> pci_aer_stats_init() after call to device_add() in in pci_device_add(),
> the above problems can be fixed.
> 
>  drivers/pci/pcie/aer.c | 166 +++++++++++++++++++++++++++++------------
>  1 file changed, 119 insertions(+), 47 deletions(-)

You need a Documentation/ABI/ update for the new sysfs files before we
can properly review this to see if you are doing what you think you are
doing :)

thanks,

greg k-h
