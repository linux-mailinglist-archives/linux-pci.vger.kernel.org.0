Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D071739D
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 04:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjEaCSs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjEaCSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 22:18:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B5B10E;
        Tue, 30 May 2023 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AHO4M8sGie0OSLO/d8Ur4iCaRbtViVC/sruAnPnDQl8=; b=WFqPI8lzgzeJCE5VBFZricroLX
        VFVwpGjv7oZfxVGuYabP5XSgYrcC99JBwmMBYwEpRi+4MJEEbTG56BDO9yUIfE/qrADTFZeCslMRu
        dmHDK8HvHqzd6jptf2Qgnmu/t6fjtnCbxR3U+mS1QqAeiyWIkDumPeLkHT1DpFGU9UqLiJhFrFY4J
        WBRjWzRJhXxIw+K+QX4dy+m0GYlzLwHfTPwOTjWnjlHDMoCBLYaoFCrndkR3NhfSew0gAc8HGkSrO
        f9NTyXgLW8vAcPNrycVkq0TGk003xokLYfWfkWkFgyk36xuCMPBFI+OHX4qVbSPIaqIajw98yJJW2
        3ILdNcZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4BPr-00FmRc-04;
        Wed, 31 May 2023 02:18:23 +0000
Date:   Tue, 30 May 2023 19:18:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, LiuLele <liu.lele@qq.com>,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, bhelgaas@google.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com, helgaas@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, vishal.l.verma@intel.com
Subject: Re: CXL memory device not created correctly
Message-ID: <ZHaubgQOFU0+r1MD@bombadil.infradead.org>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
 <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
 <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
 <646793cc665bf_1231462943c@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646793cc665bf_1231462943c@iweiny-mobl.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 08:20:44AM -0700, Ira Weiny wrote:
> Davidlohr Bueso wrote:
> > On Fri, 19 May 2023, LiuLele wrote:
> > 
> > >In my testing CXL device /sys/bus/cxl/devices/mem0  not created, and the get error messages :
> > >
> > >```
> > >cxl_pci 0000:0d:00.0: Failed to get interrupt for event Info log
> > >```
> > >
> > >My test environment is a qemu CXL emulator with qemu v8.0.0, Linux kernel v6.3.0.
> > >While with kernel 5.9.13,  /sys/bus/cxl/devices/mem0  can be created.
> > 
> > Yes, this can be annoying and would argue the probe should not error out.
> 
> I had to double check.  Events are mandatory on devices.  On checking
> again interrupt support is mandatory as well.  So that is why I errored
> out here.

The failure essentially creates a user visible regression whereas
booting an older kernel fixes it. It is not a friendly error message
when testing kernels / upgrading / test environments. The only thing
I can think of is if a new kconfig symbol is introduced so to make
such cases a bit more clearer for now as things get settled.

Otherwise for testing this creates a few cycles of just noise. And I'd
imagine even a few developer hours.

  Luis
