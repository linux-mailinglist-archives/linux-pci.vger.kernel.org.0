Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2534FD0F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhCaJgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:36:32 -0400
Received: from foss.arm.com ([217.140.110.172]:36446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234648AbhCaJgN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 05:36:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7D4D6E;
        Wed, 31 Mar 2021 02:36:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71AFC3F792;
        Wed, 31 Mar 2021 02:36:11 -0700 (PDT)
Date:   Wed, 31 Mar 2021 10:35:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>, toan@os.amperecomputing.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dann.frazier@canonical.com
Subject: Re: [PATCH] PCI: xgene: fix a mistake about cfg address
Message-ID: <20210331093534.GA10056@lpieralisi>
References: <20210328144118.305074-1-zhengdejin5@gmail.com>
 <20210330191926.GA1297928@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330191926.GA1297928@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 02:19:26PM -0500, Bjorn Helgaas wrote:
> On Sun, Mar 28, 2021 at 10:41:18PM +0800, Dejin Zheng wrote:
> > It has a wrong modification to the xgene driver by the commit
> > e2dcd20b1645a. it use devm_platform_ioremap_resource_byname() to
> > simplify codes and remove the res variable, But the following code
> > needs to use this res variable, So after this commit, the port->cfg_addr
> > will get a wrong address. Now, revert it.
> > 
> > Fixes: e2dcd20b1645a ("PCI: controller: Convert to devm_platform_ioremap_resource_byname()")
> > Reported-by: dann.frazier@canonical.com
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> 
> This looks right to me, but since e2dcd20b1645a appeared in v5.9-rc1,
> I think it should have:
> 
>   Cc: stable@vger.kernel.org	# v5.9+

Fixed and pushed out in my pci/xgene branch.

Thanks,
Lorenzo
