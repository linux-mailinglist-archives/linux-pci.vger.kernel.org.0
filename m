Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10B42D35B9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgLHWBL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 17:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbgLHWBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 17:01:11 -0500
Date:   Tue, 8 Dec 2020 16:00:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607464830;
        bh=qojVubxWvD78y7n37ZPt0eQRPp8mmIIfux4KgGIXmHo=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=bz5zHPwasO66Jq0URftHcXG/DpMcno9A33ALNhTkK4J+lvTeVGzEGeQS13TSUioxk
         lQpCgo4caH2Q7KVSNu5hLFejog4rYRoZrWc3KXoxR+aC0vFhJnyDXiZ8Sewo9Qt09S
         EidU6d6yI7OrzT4zukNJzv96zSXZGEXPBvPga2yOxPRaL5ckCNcYlnhLznU9fuXr+X
         /RzsDA1378img3ircEakRaMLVG13IfcHcZICeGNIQUk37p6J8ThrpN8vp2fZLi4hVq
         u/6WfGKwZfLkfav2SQo/gjsFVz48cAqakvT2U/rgUOpQvYSM9WyBu9xlZZpXN3RsKM
         iik9D4t1X7rvQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Remove unused HAVE_PCI_SET_MWI
Message-ID: <20201208220028.GA2426833@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f20cac-708d-7897-c7c7-cb4e63cfd991@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 01:16:22PM +0100, Heiner Kallweit wrote:
> Remove unused HAVE_PCI_SET_MWI.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/misc for v5.11, thanks!

> ---
>  include/linux/pci.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e007bc3e8..de75f6a4d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1191,7 +1191,6 @@ void pci_clear_master(struct pci_dev *dev);
>  
>  int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
>  int pci_set_cacheline_size(struct pci_dev *dev);
> -#define HAVE_PCI_SET_MWI
>  int __must_check pci_set_mwi(struct pci_dev *dev);
>  int __must_check pcim_set_mwi(struct pci_dev *dev);
>  int pci_try_set_mwi(struct pci_dev *dev);
> -- 
> 2.29.2
> 
