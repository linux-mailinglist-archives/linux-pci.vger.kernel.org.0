Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EB26F8DD
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIRJDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 05:03:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJDQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 05:03:16 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 05:03:15 EDT
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1422599A47038976F689;
        Fri, 18 Sep 2020 09:46:30 +0100 (IST)
Received: from localhost (10.52.125.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 09:46:29 +0100
Date:   Fri, 18 Sep 2020 09:44:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
        <rjw@rjwysocki.net>, <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <qiuxu.zhuo@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 00/10] Add RCEC handling to PCI/AER
Message-ID: <20200918094451.000033cc@Huawei.com>
In-Reply-To: <39F1C577-2486-43DC-BB65-1F6EDE02B217@intel.com>
References: <20200917173600.GA1706067@bjorn-Precision-5520>
        <39F1C577-2486-43DC-BB65-1F6EDE02B217@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.116]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Sep 2020 10:55:16 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> On 17 Sep 2020, at 10:36, Bjorn Helgaas wrote:
> 
> > On Thu, Sep 17, 2020 at 09:25:38AM -0700, Sean V Kelley wrote:  
> >> Changes since v3 [1]:  
> >
> > This series claims "V4 00/10", i.e., there should be this cover letter
> > plus 10 patches, but I only got 3 patches.  I don't know if some got
> > lost, or if only those 3 patches were updated, or what?  If it's the
> > latter, it's too hard for me to collect the right versions of
> > everything into a single series.
> >
> > Either way, can you resend the entire series as a V5?
> >
> > Bjorn  
> 
> That's weird.  I can see all 10 got sent. There's something awry with 
> the mailer as I got the copies.  You are right.  Lore only shows 3.  I 
> will see if something happened with the smtp access.  Will resend as V5.

I got all 10.  

May be coincidence but I saw this with a couple of series I was trying
to pick up with b4 (so from lore.kernel.org). I assumed it was a problem
at the sender, but that wasn't intel..

Perhaps something more general going on at vger?

Thanks,

Jonathan

> 
> Thanks,
> 
> Sean


