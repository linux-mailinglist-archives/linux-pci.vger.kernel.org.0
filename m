Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C3B5C51
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhF1KQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1KQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:16:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90880C061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RSzTG2Gg+gRLtCJwNney+ucz4/nrQQhXt9xGMV5gk4U=; b=swVcZz/hce0YO5bCNbElbKrdiT
        E9iUD8HtaDH+2Y7pRf2fl7rR8r1/0JkjIaOnzCxRQVQr2CK8mKF9qEJZrl1zV0ATNNiQzure9LUX3
        d0PlBkWHJF/P8lN8fy3h/Ck0wGuJPdOtLWn7SmmNiiUwXikt9JCqnsVMeQNj52wGdOSyh98BCc6sd
        nII0+Qgp7kvI626vveNIrlbaItB/YtXLwtuDaRzd9iH3CE+84xayE5g4qGyYsirCkUQsbBGts0OM1
        UyocOO+VXe+x730f1u2xoyvfCvBebd56DbTV6vBsL8IIYTq4HQAy0sO1VI93elwrrWtmnzgdhTWoC
        WGxcnVPA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxoDG-002pmN-FB; Mon, 28 Jun 2021 10:10:34 +0000
Date:   Mon, 28 Jun 2021 11:09:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Krzysztof Wilczy??ski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali Roh??r <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs
 open callback
Message-ID: <YNmf9sAB2NEnivsk@infradead.org>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-2-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625233118.2814915-2-kw@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 11:31:17PM +0000, Krzysztof Wilczy??ski wrote:
>  	if (battr->mapping)
> -		of->file->f_mapping = battr->mapping;
> +		of->file->f_mapping = battr->mapping();

I think get_mapping() is a better name now.  That being said this
whole programming model looks a little weird.

Also, does this patch imply the mapping field of the sysfs bin
attributes wasn't used before at all?
