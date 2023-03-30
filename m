Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8E6CF90A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjC3CKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3CKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 22:10:20 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53E01BC;
        Wed, 29 Mar 2023 19:10:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Veyj5ne_1680142215;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Veyj5ne_1680142215)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 10:10:15 +0800
Date:   Thu, 30 Mar 2023 10:10:16 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [RFC PATCH] PCI: avoid SBR for NVIDIA T4
Message-ID: <20230330021016.GA30164@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
 <20230329170515.GA3067097@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329170515.GA3067097@bhelgaas>
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

On Wed, Mar 29, 2023 at 12:05:15PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2023 at 07:58:45PM +0800, Wu Zongyong wrote:
> > Secondary bus reset will fail if NVIDIA T4 card is direct attached to a
> > root port.
> 
> Blank line between paragraphs.  Rewrap to fill 75 columns if it's a
> single paragraph.
Will be fixed.
> 
> Is this only a problem when direct attached to a Root Port?  Why would
> that be?  If it's *not* related to being directly under a Root Port,
> don't mention that at all.
Yes, this problem occurs only when the T4 card is direct attached to a
Root Port.
I have test it with a T4 card attached to a PCIe Switch or a PCI Bridge,
and it works well.

> 
> > So avoid to do bus reset,  pci_parent_bus_reset() works nomarlly.
> > 
> > Maybe NVIDIA guys can do some detailed explanation abount the SBR
> > behaviour of GPUs.
> 
> This is a follow-on to 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to
> avoid bus reset"), so probably should have a Fixes: tag so it goes
> whereever that commit goes.
> 
> Also copy the subject line from 4c207e7121fa, e.g.,
> 
>   PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Will be fixed too.
> 
> Are there any problem reports or bugzilla issues you can include a URL
> to?
No, I just find the problem in our test environment and I didn't find a
similar report.
> 
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > ---
> >  drivers/pci/quirks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf95..be86b93b9e38 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
> >   */
> >  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> >  {
> > -	if ((dev->device & 0xffc0) == 0x2340)
> > +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
> >  		quirk_no_bus_reset(dev);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > -- 
> > 2.34.3
> > 
