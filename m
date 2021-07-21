Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772013D087C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhGUFFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 01:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhGUFFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 01:05:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C17C061574
        for <linux-pci@vger.kernel.org>; Tue, 20 Jul 2021 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ILXClfUuTZ1MDh8PxJhABjxWJ9KLFYrL9TpGq8wtgg=; b=caX4qMnkfw/x9Jwgd5iRmIm/H+
        hvyi3mOKR54OWTgz84hlEgsk2zIWQh40t/XeEb+6kX8gYUBEoDkGjoaedQFhQPNxwUuR7KyA8HWPL
        RM1nE4Rn7Iaj81YONChjgXLhWWEPxIqsNb+PdNMCQ2nySLphaCdAHbSI5BGdYp6mPsXmQwzvdW2ax
        tJlL8yLslmmu4OtkCaztP3/17OVlzbAbsiYRUU31ArsCjJRM0QvmOs+75eu0WnfUkBD8T+2gNe0gO
        7T/dXeAifIloFSRffBTHvoFfl6KPvfHpzr0d2fSBF87UiZNWxpFsjT8pqWUyv+fwDs8TmpfVIJ/k0
        NUH49d6A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m653L-008qLF-Ue; Wed, 21 Jul 2021 05:45:59 +0000
Date:   Wed, 21 Jul 2021 06:45:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
Message-ID: <YPe0k1bkj7v33vrM@infradead.org>
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
 <20210720205009.111806-2-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720205009.111806-2-nirmal.patel@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 01:50:08PM -0700, Nirmal Patel wrote:
> +#define PCI_HEADER_TYPE_MASK 0x7f
> +#define PCI_CLASS_BRIDGE_PCI 0x0604

Please use the existing definitions from pci_regs.h / pci_ids.h.

>
> +#define DEVICE_SPACE (8 * 4096)
> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))

Plase turn thos into readable inline functions and avoid the overly long
lines.

> +	/*
> +	* Subdevice config space may or many not be mapped linearly using 4k config
> +	* space.
> +	*/

Please avoid the overly long line, especially in a comment.
