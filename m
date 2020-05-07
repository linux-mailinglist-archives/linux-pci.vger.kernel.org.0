Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E81C9B61
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGTtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgEGTtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 15:49:41 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427EE208E4;
        Thu,  7 May 2020 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588880981;
        bh=3BFFez11ssEZqJXanr8tMIJWo0jrdd8+mi41ZiiNFeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JCOa7Rse7JB6N+5ceUwmomOh/fUwbhzciB1fjEKCZ4P9hwt7LCcA6xjlWVpbSfl0W
         K9WobNpo7/gtNna+drJTplZg7iggn/2qcYb1lD+LoaGru6cNq26602ReVnO0yzoKXr
         WM49CbDcNJ/6KUwWVxjXs4m35x7wmjHVje8Pe2H4=
Date:   Thu, 7 May 2020 14:49:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        rgummal@xilinx.com
Subject: Re: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200507194939.GA21050@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 05:28:36PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.

> +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;

Almost all of the *_link_up() functions return "int".  I don't know if
there's really any benefit to using "bool", but if you do, you should
probably return "true" or "false" instead of 1/0.

> +	port->irq_misc = platform_get_irq(pdev, 0);
> +	if (port->irq_misc <= 0) {

Use:

  if (port->irq_misc < 0) {

See https://lore.kernel.org/r/20200501224042.141366-3-helgaas@kernel.org
