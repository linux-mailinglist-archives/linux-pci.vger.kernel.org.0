Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E3D4C8CC7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiCANjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiCANjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 08:39:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943222BDF;
        Tue,  1 Mar 2022 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PTvDGXpj4QceN1WruyMqNJDszkmC9L67vBNfhw3P1J8=; b=ATmAfbpmSQgx4C/xTj8lT7/TB0
        eHZTZVRcvLJzGR0a4gdeUHbjJX/sDbo6liX+3izIMNeXz/esL51HF89uMwqqILim5R0GdM80ENCRf
        3ilyZGA3JiWqbgsnmxxVCPpl+DP7rP+B1gLy1lTP6xARcOO3NOmP3nJYB2bGYcgnNQ4RXhQAyKWLg
        aXVE+JMlTD4wd6S6+HfBog3u6rO3sRuDyGyGPaB1wRbDKr1BSbolh7fy1fHuFLKZPcGscAPfxbjvw
        2q/NJVegB4WKM1+5SIUTxU9guQ6m1HUdDTNhTBQVEiUgxqGrw3M4ZLVqVmGcEo72pNckf17htyb+s
        nj7jJ+Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2hr-00GvQj-1M; Tue, 01 Mar 2022 13:38:23 +0000
Date:   Tue, 1 Mar 2022 05:38:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/3] PCI/ASPM: Add pci_enable_default_link_state()
Message-ID: <Yh4hzz/IGS8xg3vV@infradead.org>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
 <20220301041943.2935892-2-david.e.box@linux.intel.com>
 <Yh3Vt6/WzoAasPxZ@infradead.org>
 <ba9128b499b243f5c08f855018a37cd1484211b6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9128b499b243f5c08f855018a37cd1484211b6.camel@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 01, 2022 at 05:31:51AM -0800, David E. Box wrote:
> > Is there any reason the ASPM_* values aren't passed directly to this
> > function?
> 
> The ASPM_* macors aren't visible outside of aspm.c whereas the
> PCIE_LINK_STATE_* macros are defined in pci.h. This is similar to what
> is done for pci_disable_link_state().

Ok.  This looks a little weird but I guess we should stick to the
existing pattern here.
