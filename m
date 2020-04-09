Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C641A3AD5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDIT4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 15:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIT4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 15:56:18 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA2D2084D;
        Thu,  9 Apr 2020 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586462178;
        bh=dUCW6RnIcMjhAnTJbwebYynW6mVTSDbRRQmg3x1CV64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iOARlR4p0dzbkvfbE8UFDVYD0dZFSOH/o4k7+v0Hqn6oGr+d0ALIMp+9p2nCVMMxk
         5uBPeCK1cSiFQc0Cul3ILhxzP0GULCcCdJ8QOuxVEZVltGC9FNsJ5Gc5yEL0slw8OW
         o756JCXyu490iVr2sgA8NEAdSjzXbJDZRQjPredc=
Date:   Thu, 9 Apr 2020 14:56:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [Patch 1/1] lspci: Add available DVSEC details
Message-ID: <20200409195616.GA62263@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409183204.328057-2-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 09, 2020 at 11:32:04AM -0700, Sean V Kelley wrote:
> Instead of current generic 'unknown' output for DVSEC, add details on
> Vendor ID, Rev, etc.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>

Looks good to me.

> +static void
> +cap_dvsec(struct device *d, int where)
> +{
> +  u32 hdr;
> +
> +  printf("Designated Vendor Specific Extended Capability:\n");

s/Vendor Specific/Vendor-Specific/ to match the spec usage
s/ Extended Capability:// to match other lspci capability output (?)

> +4e:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93

> +        Capabilities: [d00 v1] Vendor Specific Information: ID=0040 Rev=1 Len=04c <?>
> +        Capabilities: [e00 v1] Designated Vendor Specific Extended Capability:
> +                DVSEC Vendor ID=8086 Rev=0 Len=038 <?>
> +                DVSEC ID=0000 <?>
> +        Capabilities: [e38 v1] Device Serial Number 12-34-56-78-90-00-00-00
> +00: 86 80 93 0d 00 00 10 00 00 00 00 ff 00 00 80 00

Obviously this class code is wrong.  I assume it'll be fixed in real
hardware, but ironically we've just spent a few days chasing a problem
because of a Google Edge TPU with invalid class code.  In that case,
Linux doesn't assign resources to BARs, so things fall apart after
that.
