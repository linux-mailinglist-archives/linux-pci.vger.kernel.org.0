Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8881F72CF6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfGXLLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 07:11:10 -0400
Received: from foss.arm.com ([217.140.110.172]:39124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfGXLLK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 07:11:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC289337;
        Wed, 24 Jul 2019 04:11:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B02D3F71A;
        Wed, 24 Jul 2019 04:11:09 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:11:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/VMD: Fix config addressing with bus offsets
Message-ID: <20190724111103.GA26018@e121166-lin.cambridge.arm.com>
References: <20190611211538.29151-1-jonathan.derrick@intel.com>
 <20190621142803.GA21807@e121166-lin.cambridge.arm.com>
 <1ec9408fabb2178181f02b7ddbb2b22604c49417.camel@intel.com>
 <20190723093251.GA12867@e121166-lin.cambridge.arm.com>
 <1a742393512b088e79194948faa245d8a350c93a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a742393512b088e79194948faa245d8a350c93a.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 03:12:51PM +0000, Derrick, Jonathan wrote:

[...]

> > > Besides the stable issue, can we get this into 5.3?
> > 
> > Usually we send fixes at -rc for patches that were merged in the
> > previous merge window; this fix is not one of those so I think
> > we will send it for v5.4 unless it is very urgent.
> > 
> > We should still update stable info in the log appropriately
> > before queuing it.
> > 
> > Thanks,
> > Lorenzo
> 
> 
> Sure. Had assumed it would be queued for 5.3 as it was submitted in 5.2
> I will resubmit during 5.4 merge window and deal with stables later.

It should not be that complicated to add stable tags (possibly
with commit dependencies on stable kernels where the patch
does not apply and require additional patches to be pulled),
there is plenty of time to sort this out.

Apologies for not picking it up for v5.3 - I should have asked
you to just update the stable tag so that we could merge it.

Lorenzo
