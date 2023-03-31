Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA096D157B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCaCLU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 22:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCaCLT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 22:11:19 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD14BDD6;
        Thu, 30 Mar 2023 19:11:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vf0OVtn_1680228674;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Vf0OVtn_1680228674)
          by smtp.aliyun-inc.com;
          Fri, 31 Mar 2023 10:11:15 +0800
Date:   Fri, 31 Mar 2023 10:11:15 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [RFC PATCH] PCI: avoid SBR for NVIDIA T4
Message-ID: <20230331021115.GA435@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <20230330021016.GA30164@L-PF27918B-1352.localdomain>
 <20230330154926.GA3150990@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330154926.GA3150990@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 10:49:26AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 30, 2023 at 10:10:16AM +0800, Wu Zongyong wrote:
> > On Wed, Mar 29, 2023 at 12:05:15PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 29, 2023 at 07:58:45PM +0800, Wu Zongyong wrote:
> > > > Secondary bus reset will fail if NVIDIA T4 card is direct attached to a
> > > > root port.
> > > 
> > > Is this only a problem when direct attached to a Root Port?  Why would
> > > that be?  If it's *not* related to being directly under a Root Port,
> > > don't mention that at all.
> >
> > Yes, this problem occurs only when the T4 card is direct attached to a
> > Root Port.
> > I have test it with a T4 card attached to a PCIe Switch or a PCI Bridge,
> > and it works well.
> 
> From an electrical and protocol point of view, the device should not
> be able to tell the difference, so Lukas' suggestion that it may be
> related to reset delays seems very pertinent.
I will test it with the commits mentioned above.
But it may take some time since it is not easy to replace kernel in our
environment.
> 
> Bjorn
