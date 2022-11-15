Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7146295C9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiKOK1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiKOK1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:27:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28D1F9F3;
        Tue, 15 Nov 2022 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7rjjuG4MhWSWvJIH4DsOcCy+1gVkrN814g410rEgjz4=; b=enAVznMCK/RCROvdDARJDbzBoz
        kxDyIP8h+D6lJx4lvrfd1axgekqzg56kfgGA3FBr2JNukrRzzYqXfIoJzkTZS9ysKlb+dRG62pXVk
        q1LBFTTNn9OdUjgIYHvn0Lwj0mI3ssiYn+UNIpmyYcWgh9K/n8DygdqXz9QyTPWp/E5fhu9O8xbGH
        tpnjBteP1e0swrboXUYztS4CNT4M2Y4xHGGRBtimRtIrgStskNKBVUzgOOsOsJw2MVk7NqA09ZAym
        i6L0euegCdnwQcr1t6wA7l3tSBghwV69XBcegSuB4aYAe49nOdJhjr0VKbkbywkU72XNCdl0UEeCo
        gCY0PrOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1outA5-009ugK-OR; Tue, 15 Nov 2022 10:27:25 +0000
Date:   Tue, 15 Nov 2022 02:27:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] PCI: vmd: Clean up some inconsistent indenting
Message-ID: <Y3NpjbXkcb3wfZcQ@infradead.org>
References: <20221115054847.77829-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115054847.77829-1-jiapeng.chong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 01:48:47PM +0800, Jiapeng Chong wrote:
> +	if (vmd->irq_domain)
> +		vmd_set_msi_remapping(vmd, true);
> +	else
> +		vmd_set_msi_remapping(vmd, false);

Why not go one step further:

	vmd_set_msi_remapping(vmd, !!vmd->irq_domain);

?
