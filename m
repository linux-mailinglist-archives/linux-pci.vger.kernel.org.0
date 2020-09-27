Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE3279EA6
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgI0GYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgI0GYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 02:24:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A3C0613CE;
        Sat, 26 Sep 2020 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ct8nhSMxcDNfLPCRPAykjdvwOd+e0dnNMugoJtaxTRQ=; b=dD3lmmajcl7luJKeIk3saAVpKQ
        5vL+ffDHqu3Hjf6bFl5ADl0nZIycXxgkmAgP1tEa4FEtanNvVGkpLo+LhhfFRGXT692N8IzhtEKv3
        VpaqWgcqK2LJ9mya3VJ9ES00hnU4rZOucO4zKYzRXg5WpomBPxoXPZeSzM0BPWjgix15uHRsG9tDi
        gZi0tx0szYDu0+wROe9bXNzUcH1DaT5ZpRPjjJ+afcwZJnOb7f1MEkkWRw/9z31IxfzcSds075fdt
        ke1gROxMh8ni8al0hZDaatsvX3Ptc+z3g7ZvkTZJQLLFD/QGEgGy1rh3aXRcIh0Gb+y96xPxU7kJq
        +9F03zzg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMQ6J-0006BS-7V; Sun, 27 Sep 2020 06:23:59 +0000
Date:   Sun, 27 Sep 2020 07:23:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com
Subject: Re: [PATCH 1/5 V2] PCI: define a function to check and wait till
 port finish DPC handling
Message-ID: <20200927062359.GA23452@infradead.org>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-2-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927032829.11321-2-haifeng.zhao@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +#ifdef CONFIG_PCIE_DPC
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
> +{
> +	u16 cap = pdev->dpc_cap, status;
> +	u16 loop = 0;
> +
> +	if (!cap) {
> +		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");
> +		return false;
> +	}
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> +	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +		msleep(10);
> +		loop++;
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	}
> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +		pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
> +		return true;
> +	}
> +	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +	return false;
> +}

I don't think that there is any good reason to have this as an
inline function.
