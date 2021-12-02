Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA29465A4A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 01:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354083AbhLBAGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:06:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354038AbhLBAFG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 19:05:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638403303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sL+YIaY0kXx9h0ZbGxqN7dkvXLUzeLZfDG9h71cyvO0=;
        b=wwn+hpt0XnJfDkFE5pg37ANYJtFnOIy3FjiYVnKOtejDXM8uCnkxu+nh7L/Gt7UI1Mznej
        zm/jXSJ8zu1FRnqiDDEnnIda6Hm9awW653bsk3gmtsFS5bdhFgLpvguxugwMjmimAoDXGP
        MI6j85IqGUEkNWJ0Y6VZaY8CHvzYsWxvm4gxrYDb+4S+OeiBytABjZMye+/6hPnLkDoVv9
        PLwcWEgQO+z9NfGAYS2Ig+/s9MwNuPxiZoL5aqfBf0zZHNmZfZ5+gEGSKZkGVc4UicQw0N
        4Pxe+kcWs1WTUhOL+BDwP/+OOVm+QVzvUqSSWmCL4/nzzQ+MfeLBuxPiOR5ZyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638403303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sL+YIaY0kXx9h0ZbGxqN7dkvXLUzeLZfDG9h71cyvO0=;
        b=EgThZXNWcMkIxl29m1yERZS89u/hm615vIHy6fzYAwVqJgaHfeGocaaf76bjgJPa/atLqw
        b5jxYX7bxpP9pjBg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <87mtlk84ae.ffs@tglx>
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
Date:   Thu, 02 Dec 2021 01:01:42 +0100
Message-ID: <87r1av7u3d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> Which in turn is consistent all over the place and does not require any
> special case for anything. Neither for interrupts nor for anything else.

that said, feel free to tell me that I'm getting it all wrong.

The reason I'm harping on this is that we are creating ABIs on several
ends and we all know that getting that wrong is a major pain.

Thanks,

        tglx
