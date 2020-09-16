Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9F26CE5E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIPWIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIPWIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 18:08:24 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B894206CA;
        Wed, 16 Sep 2020 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600294103;
        bh=E0VvSSnH46rNN7xoxXwVPPz6e+2WkM6N1YkcT2/d+3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MtOEt06FaYpVL85HYzVkUr0UkSrqSdGu0lwC3aqPI1MA3FVojX168m3GJSHG/AEJV
         O0SyvprvAELoq5/wY+xTxAdrKeeHJvzJU/aol8Ar72SM0XCPaV01YOjAkUNo9LxKz9
         L3x64Xw4TWGvtn0LEzptTGWjWXQZOVDAxWaC2qew=
Date:   Wed, 16 Sep 2020 17:08:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: iproc: Add fixes to pcie iproc
Message-ID: <20200916220821.GA1589643@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915134541.14711-1-srinath.mannam@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 07:15:38PM +0530, Srinath Mannam wrote:
> This patch series contains fixes and improvements to pcie iproc driver.
> 
> This patch set is based on Linux-5.9.0-rc2.
> 
> Changes from v1:
>   - Addressed Bjorn's review comments
>      - pcie_print_link_status is used to print Link information.
>      - Added IARR1/IMAP1 window map definition.
> 
> Bharat Gooty (1):
>   PCI: iproc: fix out of bound array access
> 
> Roman Bacik (1):
>   PCI: iproc: fix invalidating PAXB address mapping

You didn't update thest subject lines so they match.
https://lore.kernel.org/r/20200326194810.GA11112@google.com

> Srinath Mannam (1):
>   PCI: iproc: Display PCIe Link information
> 
>  drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 
