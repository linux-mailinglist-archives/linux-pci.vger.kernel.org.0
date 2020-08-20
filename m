Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1195324C6E8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 22:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHTU6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 16:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgHTU6Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 16:58:16 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1E620885;
        Thu, 20 Aug 2020 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597957096;
        bh=lNLKf+jbDTqQlg9dtolsEU02o6vf0nzvXNJ1bvqj8cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1PvkMGJcipzgENQgMg02X58bAAGAQwdWr4KMvkJ+83c7lx7qLrGYX3lO5K8V/jRHD
         DgEVr7o1v28Z8D0lu/hAxv6OmbiTYpIl33HjvrkN8E4iJZlnpAOd7QZFtlRRUnqHLM
         rN4Zl3BifVrlMK10HCcFlh2sdQiQQKGUxxp09R2E=
Date:   Thu, 20 Aug 2020 15:58:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Remove unnecessary headers include
Message-ID: <20200820205814.GA1566579@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 03:51:50PM +0200, Gustavo Pimentel wrote:
> Coverity Scan has detected 3 headers include that don't provide
> any symbol required by the current code implemented on
> drivers/pci/pci.c, therefore this patchset aims to remove those
> entries.
> 
> Gustavo Pimentel (3):
>   PCI: Remove unnecessary header include (linux/of_pci.h)
>   PCI: Remove unnecessary header include (linux/pci-ats.h)
>   PCI: Remove unnecessary header include (asm/setup.h)

Applied to pci/misc for v5.10, thanks, Gustavo!

> 
>  drivers/pci/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> -- 
> 2.7.4
> 
