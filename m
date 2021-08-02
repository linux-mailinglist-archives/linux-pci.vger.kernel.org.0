Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96853DE280
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHBWdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHBWdK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD7F760EC0;
        Mon,  2 Aug 2021 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627943580;
        bh=Z266hrn85he0zvF5RCL+89a+DOgHYAJj4IT6uf4lvbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j0qLoF75o3kUUr6rOzVzkd3THxw75gj90+uK55GcT32z2yn515EuyjQ1MBGfmgujb
         /ayOqMhw76N/VxmG/cHrkupP9Wb87e8o5e1yPGFDh69BtXe5JAZB2WP76bx2KkgAre
         tNlgv3Hwm84vkceXtcgGDqwzjOiIpAGGLC1ZbtdoWd0Q7cB5ax0wkjtiqMkEi4ouTM
         fqh3/F8KhGhioXoZj7WzAxqiPg76dvjJT0d5MT6/PNwiTARSZXhihEp+Ln36rFLMBW
         Lhh6cQzCybyMlwH8cgW/KNK2OMo/2egsZreJk+UGvX4kqPAdWfCpH8lIVXYrQDGw2a
         swEoecJTpnknw==
Date:   Mon, 2 Aug 2021 17:32:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/VPD: Further improvements
Message-ID: <20210802223258.GA1470946@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 10:53:44PM +0200, Heiner Kallweit wrote:
> Series with further improvements to PCI VPD handling.
> 
> Heiner Kallweit (5):
>   PCI/VPD: Refactor pci_vpd_size
>   PCI: Clean up VPD constants and functions in pci.h
>   PCI/VPD: Remove old_size argument from pci_vpd_size
>   PCI/VPD: Make pci_vpd_wait uninterruptible
>   PCI/VPD: Remove pci_vpd member flag
> 
>  drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
>  include/linux/pci.h |  43 ------------------
>  2 files changed, 37 insertions(+), 112 deletions(-)

Applied to pci/vpd for v5.15, thanks!
