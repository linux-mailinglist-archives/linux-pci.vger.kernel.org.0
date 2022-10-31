Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5D613103
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 08:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJaHEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaHEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 03:04:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23259283;
        Mon, 31 Oct 2022 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yB7TuPhJxsYJmYHxwnJhbQKU+AWipYLkGa91vvCmT1M=; b=3HdaFZPiiOeqwjmboOZCkb9adz
        QWemucASqnpQyWUzGwCZCG2/kdwLZL9wMgZxALZ4bdsdcUgc1QbWZsR/QIHK+UJ++AcWY7djcBHd6
        ciRqvaPI+3KAkgta9MjA62r8f+r9dR/hxv/9lar0K0s24gDp3a4JS4i6rnVFwtOcqctqe35b8xeRF
        wUdtNu00EeJsbybqCTxXuaBZIt227TUXFOAWL99jm/sl/muTxFIt/nqctTHMVZFLIZdzdAO5SCA2C
        QpGg3Y6Qz4KV1B60tmr9CgbhYm1uItvYJp00+ty+fRNlJExd5ppfT1CGAfmlpQayNUhmivMdWwXji
        QxJGyW5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opOqH-008wfI-3a; Mon, 31 Oct 2022 07:04:17 +0000
Date:   Mon, 31 Oct 2022 00:04:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Message-ID: <Y19zcYqxk7LcGQfG@infradead.org>
References: <20221025004411.2910026-4-david.e.box@linux.intel.com>
 <20221028191308.GA903098@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028191308.GA903098@bhelgaas>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 02:13:08PM -0500, Bjorn Helgaas wrote:
> It looks like these devices come in families where several device IDs
> share the same features.  I think this would be more readable if you
> defined each family outside this table and simply referenced the
> family here.  E.g., you could do something like:
> 
>   static struct vmd_device_data vmd_v1 = {
>     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
> 		VMD_FEAT_OFFSET_FIRST_VECTOR,
>   };
> 
>   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>     .driver_data = (kernel_ulong_t) &vmd_v1,
> 
> Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
> instead of repeating it a half dozen times.

I wonder why we need the ltr field at all.  For those that set it
is always the same value, so it could just be a quirk flag to set it.

Tat being said I think thegrouping makes a lot of sense, but I'd just
do it with a #define for the set of common quirk flags.
