Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD208228E55
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgGVC7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgGVC7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:59:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CBC061794;
        Tue, 21 Jul 2020 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G0/7KtMKJzq/+2ucPHyrp8qSjT83rmF+pYA0uzJD1tg=; b=ovwuKXgqAUsxGhqPDyS22pRIeI
        xMiOVOwxaoI5c7auIWBuoVznL5SJr5DYP15o191s5Z4IJ1vFobOjgG7Eqi9fTonf9G+CmEPV2wc4u
        eEpj1NkrsXbwJSENqRbBC2FIFFZkKySr/GzEWC2Ws16UUJ1NWUboVaYWJlVv9ivIRRYJc9E0f+oiY
        2tW1KFzpJZioc1hgC1abswih9oana9n2W5Bh7aIjAC5HjGicW7CMeKHscF0VMAbrwGE4c/G6FocvB
        /Gm1YWWGrT6lAP4U3s69BCu3cCyepYsXgywdxY/Q9i6mlgvFZsWkcQeBdfERCRSMvNueyDKykDJuw
        MCZZK8kg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy4yO-0004YU-SQ; Wed, 22 Jul 2020 02:59:12 +0000
Date:   Wed, 22 Jul 2020 03:59:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
Message-ID: <20200722025912.GM15516@casper.infradead.org>
References: <20200722001513.298315-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722001513.298315-1-jusual@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
>  {
>  	if (type == 0)
>  		return;
> +
> +	if (raw_pci_ext_ops && kvm_para_available())
> +		return;

This is a bit of a subtle way of saying "If mmconfig exists, don't use
the cf8 mechanism".  There's probably a better way of doing this, but
the x86 pci init sequence is already byzantine and I don't understand it
well enough to offer you an alternative.

