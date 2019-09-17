Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20BDB532C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfIQQhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 12:37:35 -0400
Received: from foss.arm.com ([217.140.110.172]:58686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfIQQhe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 12:37:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4802828;
        Tue, 17 Sep 2019 09:37:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7977A3F575;
        Tue, 17 Sep 2019 09:37:33 -0700 (PDT)
Date:   Tue, 17 Sep 2019 17:37:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Message-ID: <20190917163716.GA9715@e121166-lin.cambridge.arm.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
 <20190916135435.5017-3-jonathan.derrick@intel.com>
 <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
 <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
 <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
 <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
 <20190917151523.GA7948@e121166-lin.cambridge.arm.com>
 <ec24dc3d6f6f962a9f96ab1bab8c9cf4e138d61a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec24dc3d6f6f962a9f96ab1bab8c9cf4e138d61a.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 17, 2019 at 03:51:39PM +0000, Derrick, Jonathan wrote:

[...]

> Sorry for the confusion.
> 
> These changes only affect systems with VMD devices with 8086:28C0
> device IDs, but these won't be production hardware for some time.
> 
> Systems with VMD devices exist in the wild with 8086:201D device IDs.
> These don't support the guest passthrough mode and this code won't
> break anything with them. Additionally, patch 1/2 (bus numbering) only
> affects 8086:28C0.
> 
> So on existing HW, these patches won't affect anything

It is me who created confusion, apologies. I read the code properly and
I understand that both patches are fixes for HW that is still not
available (and they can't create an issue with current kernel because
HAS_MEMBAR_SHADOW and HAS_BUS_RESTRICTIONS features are not implemented
on 8086:201D), we should take these patches and trickle them to stable
kernels as soon as possible so that when HW _is_ available mainline and
stable kernels are fixed.

Correct ?

Lorenzo
