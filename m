Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E154C212
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbiFOGoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiFOGoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 02:44:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532429372;
        Tue, 14 Jun 2022 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1rEC5ALaIx0d2HCn0F/BRl3rZtH5sm1gZYoEirDhT0=; b=upfrVsj4EyeIaKq5NLpH7XMypo
        j2NNMqh6rsu23p/22yhoKdcZgeY+leAu8Zgq5JVbY/t+9dA5Yeb+V3udY6zfXdDsA7Rq4iRAvr9ZT
        DsK05XBhDP2pNCIjf/ha16rNdqcEASlC73NiN4LJ4GCTXTkLd4KztPoYUHMHiM7U+bc06qfOPxSbb
        iOPB2V+QEhQunT9QYsLblws9sHf+AUDud35DkLIXL0DKscaLxrU8fg7sxd6zJHikYMjX3ik/g7JV6
        yFqVpbk52teNqSXZ8as9qQUE6KHr42FoCv9CiEpoalrhCNDd7vCG/yrn9/HrD9UrGi+gjK6LhVJkt
        mNGOmPIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Mkh-00Ctus-OR; Wed, 15 Jun 2022 06:43:43 +0000
Date:   Tue, 14 Jun 2022 23:43:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang Wenhu <wenhu.wang@hotmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, hao.wu@intel.com,
        trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org,
        linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Subject: Re: [PATCHv2 2/2] uio:powerpc:mpc85xx: l2-cache-sram uio driver
 implementation
Message-ID: <Yql/n+RuVttucWVf@infradead.org>
References: <YqHy1uXwCLlJmftr@kroah.com>
 <20220615055735.53585-1-wenhu.wang@hotmail.com>
 <SG2PR01MB29513533A1EA32DCB00D10309FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB29513533A1EA32DCB00D10309FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
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

As pointed out last time:  uio is the wrong interface to expose sram,
and any kind of ioremap is the wrong way to map it.
