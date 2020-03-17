Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033AE188896
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQPHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 11:07:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCQPHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 11:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SKmm1Brf5qkfGLXpJCZHYlVFonCCKLnpgPetOx1HK64=; b=M8def3lSYI/XT2Taktd7URzLM0
        hObf0PLoK/oHyIztUAUmw9r178gQiKXkaQFWNjBDBZPYMK8ZaY6n/7AUgXbQXF1TcxMtHN+y30IvV
        qIcKoSFRC3Vjam8iI+9TZxyGUIInbN/8TkucqWvDyLTLookSCL0ou2jtQ8LaPg+eh72d97My9B7lp
        h66sUKH3suHVlfZEkZ3ys3i7fPd6Tj4EP0LgM9lGh/uRNJXYyLv8lan8+R5CiGq9Iv2kwMRfJyt5W
        rk1G3PMSKtsr9LGVq6pCzrU2hWWefwQ9L8dQGclh0jFt0FLLWcaqxmH6xmfQ4bWIniU0/BGovV+M6
        mv8nr28g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDod-0000E1-Bn; Tue, 17 Mar 2020 15:07:35 +0000
Date:   Tue, 17 Mar 2020 08:07:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link
 references
Message-ID: <20200317150735.GA653@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200317144203.GE23471@infradead.org>
 <ebb79d02-53f5-cc23-0b38-72a351a05097@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb79d02-53f5-cc23-0b38-72a351a05097@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 08:05:50AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > 
> > This should be folded into the patch removing the method.
> This is also folded in the mentioned patch.
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183

I can't find that series anywhere on the list.  What did I miss?
