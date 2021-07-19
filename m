Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F23CD10E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhGSJBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 05:01:19 -0400
Received: from verein.lst.de ([213.95.11.211]:48751 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231928AbhGSJBT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 05:01:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE9EC67373; Mon, 19 Jul 2021 11:41:56 +0200 (CEST)
Date:   Mon, 19 Jul 2021 11:41:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] genirq/affinity: add helper of irq_affinity_calc_sets
Message-ID: <20210719094156.GB431@lst.de>
References: <20210715111827.569756-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715111827.569756-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 07:18:27PM +0800, Ming Lei wrote:
> +				WARN_ON_ONCE(irq_affinity_calc_sets(1, affd));

Hiding actual functionality inside a WARN_ON is nasty.

> +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Install
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		affd->calc_sets = default_calc_sets;
> +
> +	/* Recalculate the sets */
> +	affd->calc_sets(affd, affvecs);

I'm not sure a function like this should have side effects.  Either
we move the assign to an init function with a single caller, or do an
if / else here.
