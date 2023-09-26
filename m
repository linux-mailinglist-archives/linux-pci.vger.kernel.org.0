Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76667AE6CD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjIZH1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjIZH1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 03:27:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B8FB;
        Tue, 26 Sep 2023 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1EY996H2+nH9kVv7VeJU7gdej000u01sa7M392CTh8=; b=GgDOX9CWEbDc4YMM/aQ26SsUk2
        b9PNZ3qRQ6wNjEp8D24yZ6pSz/DQ5m1/YwEnvv/vklPcFF5gm0sMGut4fYDXCa853VmHgFPt2DDsI
        Gyc7MZtPtTnNdZYMJoJ/J0l4z9YT8UojXVzWfacia1N+QBRRUcrzKF/d9LD+Kl0yiAQoSgXgVqWU1
        Xvocw4+WXqLTIH8G9ThPqN+WWHPYGyfTe0RRIAp7d6WbjXXqN9BISlhYc5K3Yt00i0/yOOkaj06ii
        YkyyObq/BrQCFSHSN4HbNzEfnoXd8Xaza4pACStfXRAxPAEcvrAWy95GTZ3Gw7wo9RsnXSw7DKlY0
        8woO0Dcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2Tk-00FnKk-0i;
        Tue, 26 Sep 2023 07:27:32 +0000
Date:   Tue, 26 Sep 2023 00:27:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     christophe.jaillet@wanadoo.fr, bhelgaas@google.com,
        hch@infradead.org, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v2 1/1] PCI: layerscape-ep: set 64-bit DMA mask
Message-ID: <ZRKH5CTucrT5BFwC@infradead.org>
References: <20230922042836.3311689-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922042836.3311689-1-Frank.Li@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	/* set 64-bit DMA mask and coherent DMA mask */
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

The comment is a bit silly :)

> +	if (ret)
> +		return ret;

Also no need to check the return value when setting a 64-bit mask,
but I guess it desn't hurt here.

