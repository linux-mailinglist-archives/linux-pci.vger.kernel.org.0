Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB456E5880
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 07:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDRFYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 01:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDRFYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 01:24:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94C4682;
        Mon, 17 Apr 2023 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eh/DqUUzY2lVMjQIOADXqy4dsohFXgtxffqXhcCjk5w=; b=1kQY28uOFr0UvLUA8wxZYC5Ovg
        QUwA79p7Awun5OpxioLnsddpA2ecnLTzt78vbM2VIqszOfAPXog6IyQrGUz/XBYhQPQ+5fE1khcTC
        Hf7NOkNVr05+ey/0N44zCD7tbJ7WZZt/mVnWVHUtyO6qH+pRL6pAtFIfg5YFTimshqBddj9YTTznX
        RNqzuzzFsIHfoyQZd8V4Sxpxnx/EJAba1X2/7c9pcmf2A/8QSxE3EccmEy1iCFiCUVjjeoXbMMR5k
        AjhrP3SFTHwqvvPZ9WnWV0YCzY0Ji6XczHHBN2dS+BAK9fCuA0Ao6p9+wv72c0AGGfQAvqB8/L93q
        QOQcmhmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1podpD-000uNI-0t;
        Tue, 18 Apr 2023 05:24:19 +0000
Date:   Mon, 17 Apr 2023 22:24:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] ata: libata-core: Apply ATI NCQ horkage to ASPEED as
 well
Message-ID: <ZD4pg7EMgGU2yjLM@infradead.org>
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
 <20230418011720.3900090-3-chutzpah@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418011720.3900090-3-chutzpah@gentoo.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 17, 2023 at 06:17:20PM -0700, Patrick McLean wrote:
> We have some machines with ASPEED SATA controllers, and are seeing the same NCQ
> issues that ATI controllers (I am not sure if it's a rebranded ATI controller,
> or they both have some faulty implementation). This NCQ breakage is consistent
> across a few different types of drives.
> 
> Instead of maintaining a list of drives that are broken with ASPEED controllers

Are these ASPEED controllers all the same or a wide variety?
Quirking all controllers from the same vendor seems like an overly
broad approach to me.
