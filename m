Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227CE3CF587
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGTHKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 03:10:16 -0400
Received: from verein.lst.de ([213.95.11.211]:54106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhGTHJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 03:09:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 638E16736F; Tue, 20 Jul 2021 09:50:25 +0200 (CEST)
Date:   Tue, 20 Jul 2021 09:50:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] genirq/affinity: add helper of
 irq_affinity_calc_sets
Message-ID: <20210720075025.GA17565@lst.de>
References: <20210720044209.851141-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720044209.851141-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Call
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		default_calc_sets(affd, affvecs);
> +	else
> +		affd->calc_sets(affd, affvecs);

Nit: avoid pointless negations:

	if (affd->calc_sets)
		affd->calc_sets(affd, affvecs);
	else
		default_calc_sets(affd, affvecs);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
