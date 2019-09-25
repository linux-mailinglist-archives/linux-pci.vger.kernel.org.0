Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8353BBDA6E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfIYJEN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 05:04:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfIYJEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 05:04:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E185B142F;
        Wed, 25 Sep 2019 02:04:12 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C5E3F59C;
        Wed, 25 Sep 2019 02:04:12 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:04:10 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 01/11] PCI: aardvark: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190925090409.GQ9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-2-robh@kernel.org>
 <20190925105944.30fe64cd@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925105944.30fe64cd@windsurf>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 10:59:44AM +0200, Thomas Petazzoni wrote:
> On Tue, 24 Sep 2019 16:46:20 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > Convert aardvark to use the common pci_parse_request_of_pci_ranges().
> > 
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 58 ++-------------------------
> >  1 file changed, 4 insertions(+), 54 deletions(-)
> 
> Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> (on Armada 3720-DB, with a E1000E NIC)

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
