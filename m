Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5489E54C221
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 08:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiFOGt0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiFOGtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 02:49:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3280443FF;
        Tue, 14 Jun 2022 23:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ysitRv3xhQ/0opcsLZgBDd+5+oJ6cii7ZXUtzDdN2bs=; b=Bt/jIrItpFGMmhD2t82mbrPCxX
        IYvizaoHsLXTzczLly3E94z0QpHSuhSN9nJXXiGv4NnFadJCcOXo6oT8yXuZx4i0GVNN488ufzbnl
        RSnuj9kd866sXQW8SBJZB6qO5G1O0CcMjGrQgP/kAPUkNOwHnquTo9ZlO+ElhY/XwW3ljhYpFLn7y
        7caUyypCtkQHqBSShdA03uyEAIh2tmnI7EQq0bk2BTGaOXWiXlxENEgbzyNk7yyvLHKX+O46QwNod
        6ShKgrSKHg/GXLV37SfkDT+vHpCyPRlBRXkWncr8PgoZEzeSL38kzShP3kiV21Al/Q6NvDWqYx8lD
        eFsi3wog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Mpy-00CvVU-FB; Wed, 15 Jun 2022 06:49:10 +0000
Date:   Tue, 14 Jun 2022 23:49:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang Wenhu <wenhu.wang@hotmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, hao.wu@intel.com,
        trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org,
        linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Subject: Re: [PATCHv2 1/2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c
 files
Message-ID: <YqmA5h5wCrrVCqoE@infradead.org>
References: <YqHy1uXwCLlJmftr@kroah.com>
 <20220615055735.53585-1-wenhu.wang@hotmail.com>
 <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Did you verify that all architectures actually provide a ioremap_prot
prototype?
The header situation for ioremap* is a mess unfortunately.
