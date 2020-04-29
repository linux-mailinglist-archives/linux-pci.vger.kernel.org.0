Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAF51BE256
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2PPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 11:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgD2PPl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 11:15:41 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE1020575;
        Wed, 29 Apr 2020 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588173341;
        bh=5g2VI9qjR80PiqAY18zZKeMqz0H6vmEOZgAJY/OcAho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TV7Z5C/XzkRNYyr+1iGIhULOMEGL45IadvmsRnPE+arFxGDHB6ewNRZDmeQR0daxa
         6voLTBv9u2oBqhbIv1oFmG7VHhR5cXRgpKuZOI2XoweY6AgwiLk2y1efqRsbgMmaAF
         xFndeo6oeh2P4CKdkVBUmEZK89YSW9nXibn+/QUA=
Date:   Wed, 29 Apr 2020 10:15:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daire.McNamara@microchip.com, amurray@thegoodpenguin.co.uk,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200429151538.GA26094@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429145703.GB26461@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 07:57:03AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 02:44:05PM +0000, Daire.McNamara@microchip.com wrote:
> > > why?
> > The PCIe hardware is only available on 64-bit RISCV based
> > platforms at the moment.  Our intention is to extend the driver,
> > at a later date, as and when the hardware becomes available.
> 
> I'll let the actual PCIe maintainer speak, but normally we try to
> allow drivers to build on all platforms unless they have an actual
> code platform depency.  And as far as I can tell this driver doesn't
> actually depend on RISC-V specific code.

Agreed; if the driver doesn't actually depend on interfaces that are
RISC-V-specific, we should be able to compile-test it on other arches.

Bjorn
