Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55D58B481
	for <lists+linux-pci@lfdr.de>; Sat,  6 Aug 2022 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiHFIOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Aug 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiHFIOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 04:14:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA3EE2C
        for <linux-pci@vger.kernel.org>; Sat,  6 Aug 2022 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xt6/r1gPFT/TzLV0NKT4atWiSTcK5SawGhgCt3BntG4=; b=NDsn7dSBOIcAD5aWiWn0US2tGT
        +HYIgIXRgd9473UzPhN7c9QLqqNHJXuchGfTalTlChJNwhs6mqaDBDXt+whO03YY7lXbHw3IBBFav
        uCbYkP+AS/86FOv7co4i4ktRyFv/pPAzNEThz6fED5UM9FF8Il9bdnHtVjVIUeBg195mjhiekMG+j
        DsJN2sbHrdGCDQA9GL1YbxtxyNDby9sXPkJxetAIm0X0yd66qijOr6GYwgIUKIH+b6HLnw2qCGW3L
        BiUxRcEngJkFoZdKz6TBGCEkuM+ppdWQU2eYKVkLE/qrLhCHLqUJd/uzyoUX4u6625y4R/jWWYnR+
        pJN++lPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEwh-006Q0A-6s; Sat, 06 Aug 2022 08:14:07 +0000
Date:   Sat, 6 Aug 2022 01:14:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Wang <KevinYang.Wang@amd.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: export pci_vf_drivers_autoprobe() symbol
Message-ID: <Yu4iz9AsaUNcRqud@infradead.org>
References: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 04:56:39PM +0800, Yang Wang wrote:
> make pci_vf_drivers_autoprobe() as export symbol.
> 
> the external module have no way to control vf autoprobe flag
> before pf driver call pci_enable_sriov().

But this does not actually seem to be used by any potentially
modular driver.
