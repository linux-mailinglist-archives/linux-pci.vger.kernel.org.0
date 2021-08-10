Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336AB3E5497
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 09:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhHJHuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 03:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhHJHuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 03:50:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1998760C51;
        Tue, 10 Aug 2021 07:49:40 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDMW2-003zrA-2G; Tue, 10 Aug 2021 08:49:38 +0100
MIME-Version: 1.0
Date:   Tue, 10 Aug 2021 08:49:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch V2 00/19] PCI/MSI, x86: Cure a couple of inconsistencies
In-Reply-To: <20210729215139.889204656@linutronix.de>
References: <20210729215139.889204656@linutronix.de>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <411f1a9b861f45c3366c63369b42fcc0@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, ashok.raj@intel.com, davem@davemloft.net, bhelgaas@google.com, linux-pci@vger.kernel.org, kevin.tian@intel.com, mingo@kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, borntraeger@de.ibm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-07-29 22:51, Thomas Gleixner wrote:
> A recent discussion about the PCI/MSI management for virtio unearthed a
> violation of the MSI-X specification vs. writing the MSI-X message: 
> under
> certain circumstances the entry is written without being masked.
> 
> While looking at that and the related violation of the x86 non-remapped
> interrupt affinity mechanism a few other issues were discovered by
> inspection.
> 
> The following series addresses these.
> 
> Note this does not fix the virtio issue, but while staring at the above
> problems I came up with a plan to address this. I'm still trying to
> convince myself that I can get away without sprinkling locking all over 
> the
> place, so don't hold your breath that this will materialize tomorrow.

For the patches I haven't acked yet, and with the fix on patch 18:

Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>

Thanks,

         M.
