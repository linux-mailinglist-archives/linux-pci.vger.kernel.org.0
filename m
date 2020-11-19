Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E412B9130
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 12:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgKSLhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 06:37:20 -0500
Received: from foss.arm.com ([217.140.110.172]:54218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgKSLhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 06:37:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E481478;
        Thu, 19 Nov 2020 03:37:19 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35B303F718;
        Thu, 19 Nov 2020 03:37:18 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:37:15 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>
Subject: Re: [PATCH 0/2] VMD subdevice secondary bus resets
Message-ID: <20201119113715.GC19942@e121166-lin.cambridge.arm.com>
References: <20200928010557.5324-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928010557.5324-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 09:05:55PM -0400, Jon Derrick wrote:
> This set adds some resets for VMD. It's very common code but doesn't
> seem to fit well anywhere that can also be exported if VMD is built as a
> module.
> 
> Jon Derrick (2):
>   PCI: vmd: Reset the VMD subdevice domain on probe
>   PCI: Add a reset quirk for VMD
> 
>  drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++
>  drivers/pci/quirks.c         | 48 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

I can queue it up but I need Bjorn's ACK on patch (2).

Lorenzo
