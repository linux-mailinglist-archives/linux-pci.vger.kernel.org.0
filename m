Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E285F28ED26
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJOGnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOGnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 02:43:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08409C061755;
        Wed, 14 Oct 2020 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fh7RBjR4gWJAcXHXeFIXuxtprpG5sdnXQMpcASE4DN0=; b=YdcSBxFc1sJyff9DT3WX6ebAk1
        YqKc24tKHSkGeQrJ/mNIYdAdFYn78PdoVQ/No8o354uaBUU6+y7HZtjF4pLBt8cczoCeRgdjL6TUr
        pm2q4R+VSV2ok2dhEvSe4t5jfGc2MaPGeLPxT31xKOrxSCmEGA8fyci2VyvIghe1y8K2VkSeYBkyj
        gmqjvZmiTw+Hg1blKMOtYp1OivN/YBMRG6xRv2CyCDSAYKUShqj+CnyXQ8VXpofMpUzsUWQIA7GjG
        BjJYSVVUDbTQdHG+54Oq0NQem6dhiV+72RpiTwNTU56CY9hkqZ1QCH4Sk3rRSh1/qVPyQKHDYKsxl
        bwkXikuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSwz3-0003TV-Kj; Thu, 15 Oct 2020 06:43:29 +0000
Date:   Thu, 15 Oct 2020 07:43:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        sathyanarayanan.nkuppuswamy@gmail.com, bhelgaas@google.com,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
Message-ID: <20201015064329.GA12987@infradead.org>
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201013115600.GA11976@infradead.org>
 <2fa2e5ed-dbfb-f335-5429-8bbb13f004e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa2e5ed-dbfb-f335-5429-8bbb13f004e2@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 13, 2020 at 08:17:39AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 10/13/20 4:56 AM, Christoph Hellwig wrote:
> > You might want to split out pcie_do_fatal_recovery and get rid of the
> > state argument:
> This is how it was before Keith merged fatal and non-fatal error recovery
> paths. When the comparison is between additional-parameter vs new-interface
> , I choose the former. But I can merge your change in next version.

But now you split the implementation.  Keith merged made complete sense
when the code was mostly identical.  But now that the code is separate
again it doesn't make sense to hide it under a common interface that
uses a flags value to call different functions.
