Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0ADD71C5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJOJFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:05:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOJFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 05:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sPDsJgYn2fHJq7hV1mzBz8upI2uH4JqPspr1DdlpSq0=; b=DeXj4qBDY4EvUiALUiS6E4Ilg
        hHbLc5dvUAeFYf2dcVY5Pf9sZqPwxG9f7DudCgAjx+CDWYdOwMcyO5YxO0Ut77sujzLrANQOEukJY
        bXAkPDCNVeGhyryk9qwJQ0Eq6XzKJBPlIPUVAi6RAq28JHxRiVKCmbnw9e1qVMWDzB4vlW1lEvn3W
        9Fue0CWMygNgQSzTC8japrmDMwzooizIXixq9c+fivBEqXGaJ3EH4a2YMS7sU8cAlh5vUi06nMZsK
        BRymXjTyI8HlrnKqB/KJ/NbFTeh2fN9hC61J9VbFzdEXT83gwR0Emg4UvPhQJWP6y99T2oNX1PoZM
        gKREe7R1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKIm3-0003Bd-6O; Tue, 15 Oct 2019 09:05:47 +0000
Date:   Tue, 15 Oct 2019 02:05:47 -0700
From:   'Christoph Hellwig' <hch@infradead.org>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     'Christoph Hellwig' <hch@infradead.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        andrew.murray@arm.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, 'Anvesh Salveru' <anvesh.s@samsung.com>
Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Message-ID: <20191015090547.GA7199@infradead.org>
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
 <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
 <20191015081620.GA28204@infradead.org>
 <068001d58336$a76ed970$f64c8c50$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068001d58336$a76ed970$f64c8c50$@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 02:28:00PM +0530, Pankaj Dubey wrote:
> Is this something mandatory?
> 
> As we discussed during first patch-set here [1] with Andrew, we have need of
> this patch (along with some other stuffs, which will be sent soon), to clean
> up our internal driver and make it ready for upstream. As of today we have
> some internal restrictions where we can't make it to upstream along with
> this patch. 

We don't add code to the kernel without actual users.
