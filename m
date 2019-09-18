Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7EB5FED
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfIRJPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 05:15:40 -0400
Received: from foss.arm.com ([217.140.110.172]:37942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfIRJPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 05:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F48337;
        Wed, 18 Sep 2019 02:15:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2165F3F59C;
        Wed, 18 Sep 2019 02:15:39 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:15:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] VMD fixes for v5.4
Message-ID: <20190918091532.GA24503@e121166-lin.cambridge.arm.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916135435.5017-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 07:54:33AM -0600, Jon Derrick wrote:
> Hi Lorenzo, Bjorn, Keith,
> 
> Please consider the following patches for 5.4 inclusion.
> 
> These will apply to 5.2 stable. 4.19 has a few feature deps so I will instead
> follow-up with a backport.
> 
> Jon Derrick (2):
>   PCI: vmd: Fix config addressing when using bus offsets
>   PCI: vmd: Fix shadow offsets to reflect spec changes
> 
>  drivers/pci/controller/vmd.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

I have pulled them into pci/vmd hopefully for v5.4.

Thanks,
Lorenzo
