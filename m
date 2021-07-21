Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906303D060C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhGTXXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 19:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232511AbhGTXWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 19:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CDDF610A7;
        Wed, 21 Jul 2021 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626825774;
        bh=4X+MY49rjryZvvRXxK8ssEFNb0cXmxMn4lOtd87aZxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rjFCPPAdZPh9XywpEjPFp6/MIt1SRmKb5g6mNv8Qah2yKKjraFf0D5cupzLRnaBDZ
         iSb52ue3lJRevQ6sHJQQScfm2HPFuPMjxXvzAzY2HGde07Rj1BkgrmABQ9idiabfQk
         gp4NDCokkL07DuidcKWgCel+Tt2jwVoy9Pq2sOhnStErhuBL9bfomg5nLg5b5ei7hm
         oCAe4vmUYe5ptudQD8TfnMvw857nIQF58WrxTNo39YxJphpY23eeeQFrwB5exHFOv0
         D1xtPraRaENGQKMtSK0aRin6EH0TGnRLaBoAx7dhddh5pTYg+NVvvYdu5DyzYpW7GZ
         6Yan3VJCnXjKQ==
Date:   Tue, 20 Jul 2021 19:02:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2] genirq/affinity: add helper of irq_affinity_calc_sets
Message-ID: <20210721000253.GA143407@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720075025.GA17565@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 09:50:25AM +0200, Christoph Hellwig wrote:
> > +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
> > +{
> > +	/*
> > +	 * Simple invocations do not provide a calc_sets() callback. Call
> > +	 * the generic one.
> > +	 */
> > +	if (!affd->calc_sets)
> > +		default_calc_sets(affd, affvecs);
> > +	else
> > +		affd->calc_sets(affd, affvecs);
> 
> Nit: avoid pointless negations:
> 
> 	if (affd->calc_sets)
> 		affd->calc_sets(affd, affvecs);
> 	else
> 		default_calc_sets(affd, affvecs);

+1

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for doing this!  For the PCI part:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

