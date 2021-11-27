Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB91845FE88
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 13:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbhK0MZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 07:25:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34672 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhK0MXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 07:23:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86FB7B812A7;
        Sat, 27 Nov 2021 12:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76579C53FAD;
        Sat, 27 Nov 2021 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015584;
        bh=9GiZUKo8nx6/UXOAKehD+CmOwbtZ0T2/Kz9AayGbFqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mX1Uu04lIKEXFitFkOiHJ03Gn/imdCcHDYan77Sh9kQRA6xY9Ddkytu2qzd0Rfobk
         ByHdP1chTshJfa/gEcKIhkQX8Y2fE165LXuchit0MIZemFgkLhYWz5AV1oErIQv0TF
         1Vl+4h9eOhAjCQw/A98z+1S2EfXk5F118yyfssDs=
Date:   Sat, 27 Nov 2021 13:19:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 01/32] genirq/msi: Move descriptor list to struct
 msi_device_data
Message-ID: <YaIiXcRABq2E6/sJ@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.349989857@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.349989857@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 02:22:29AM +0100, Thomas Gleixner wrote:
> It's only required when MSI is in use.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/base/core.c    |    3 ---
>  include/linux/device.h |    4 ----
>  include/linux/msi.h    |    4 +++-
>  kernel/irq/msi.c       |    5 ++++-
>  4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
