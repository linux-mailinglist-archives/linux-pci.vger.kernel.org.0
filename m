Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730E53DE278
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHBW3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhHBW3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B6F260724;
        Mon,  2 Aug 2021 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627943351;
        bh=8U8VOdwMNEO2KoXwqhRcavlZGH0C/U4aX0zjngMgXak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gBhWvPo7WNijUM+fqtrwtQeFHeg9U47GqcGELry1buTkaDPEW3ILuekY6BUX9Wnch
         aNL3TAlQdm7X1f8E1jNM0F87I/yZDwtXtOpry4kBlB4tBluDqR+YRNujSBCPvXxVv6
         MMOCl6YaTeC3j928B2FexEcqaZFxfjaUCm+/bXC55LIQZaZ3eyyW+71IqMnXCEEcvE
         1SG9ZpnTuC4vMP52wckc8cm2iTdiBsq2O4bz9wPUh9VXXhTvkEhMLF+eAtH82N7eyG
         yW1uBZSDoxeX72OkeB5CHeGtf9jVgzimuz94g/MU/Vp85DbuMrIIwlmY99LHK2/AAK
         iM9f59+P6SgaA==
Date:   Mon, 2 Aug 2021 17:29:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/6] PCI/VPD: pci_vpd_size() cleanups
Message-ID: <20210802222910.GA1470350@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 01:42:28PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The basic idea is to validate VPD resource *size* without validating the
> actual content, since the kernel really doesn't care about the content.
> 
> Thanks very much for the feedback on v1, and I'd be glad for any additional
> feedback.
> 
> Follow-up to:
> https://lore.kernel.org/r/20210715215959.2014576-1-helgaas@kernel.org
> 
> Changes since v1:
>   - Incorporate Heiner's patch to reject VPD if first byte is 0x00 or 0xff
>     (https://lore.kernel.org/r/8de8c906-9284-93b9-bb44-4ffdc3470740@gmail.com/)
>   - Update size checks to reject resources that would extend past the
>     maximum VPD size
> 
> Bjorn Helgaas (5):
>   PCI/VPD: Correct diagnostic for VPD read failure
>   PCI/VPD: Check Resource Item Names against those valid for type
>   PCI/VPD: Reject resource tags with invalid size
>   PCI/VPD: Don't check Large Resource Item Names for validity
>   PCI/VPD: Allow access to valid parts of VPD if some is invalid
> 
> Heiner Kallweit (1):
>   PCI/VPD: Treat initial 0xff as missing EEPROM
> 
>  drivers/pci/vpd.c | 55 +++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)

I applied this to pci/vpd for v5.15.

Thanks for the feedback so far, and I'll still be happy to receive
more.
