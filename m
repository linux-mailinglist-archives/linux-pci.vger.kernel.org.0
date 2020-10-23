Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9F297083
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374472AbgJWNbD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901493AbgJWNbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 09:31:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E7C0613D2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 06:31:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg9so1523978edb.12
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Xktd1fxP40CWJFM1jy30H8ussuycAV5mskqffDln2o=;
        b=bqxMHyxEWS14502z6xrwi3KaUAsTA5SaQKBiqCo57rL8XVwGal6C7chrnrNbulQCa2
         g5eS76psPWeyxUKhONIMwmZlnaS1FPBH1XrfoXCAFjb5pFgk+PDQ66MMTX82BzRh1A5q
         CK6WhrwmmppDIEebc9peddwq3iRyC+723fzz0+6BJzQt4a7SxrWhKrsuTLON8IP6SkCO
         BBszpvpr3ooTKZu5Ra11j003IPVYeSqAdkXCG108c7Cu8U4oQHpvXxa2c4kYg1Jh7UIt
         juRKWA0xCi2MQ4U8UMRIQZmLEhOExPCJleN4+u+p3EMPukCQkgImVx+o45Eo4yy292fI
         4utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Xktd1fxP40CWJFM1jy30H8ussuycAV5mskqffDln2o=;
        b=ShwLpVjC+CLmDXUf5HYYJL6Y0IEn8Qo1wEXQdH++lA+PYL+h8Nqi63RXPxK+xxsOoH
         hqWWIJhJ17ghK3QL9xPN+LGbzYVBcxxJRlWwXQRzb6YgODPSFtKfOjrQQG80+CKlvIAd
         p6uDmdrZcvcmaOxBNN8SYVpjkurbcMlk4Evzg3baQj1jG/59s3fyhxCgrPokYmi0RfQM
         MlnbgcDKLnjEqs1mnTU1fGLi4yTGRFMR61IBNA72jY5R61g19xI01zJk+kL7Qlj06QFd
         WGSI3NoGZVuh9b52tEKlZaQSyDp/0chXDQ2pdGidxu+KYUpLwMIxVUurgjGM2LEZJyXh
         JLSQ==
X-Gm-Message-State: AOAM5325GKQfVm90PuM2LNAAkTaOThfqdUxnyU79Q2GeKfWPbh9h+fLw
        nVtr2wdEZWJsMiASsmzZQGhN1g==
X-Google-Smtp-Source: ABdhPJyerbyLeRW1OUwcQivBu3uvKQxf96P9/VcEbVPZll6+IDia+owxg1JQS2cXpVGg1gDI671+Ww==
X-Received: by 2002:aa7:dd53:: with SMTP id o19mr2215297edw.370.1603459862035;
        Fri, 23 Oct 2020 06:31:02 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id sb29sm833964ejb.76.2020.10.23.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:31:01 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:30:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, kevin.tian@intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201023133041.GE2265982@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
 <20201019113316.2957c5f0@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019113316.2957c5f0@jacob-builder>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:33:16AM -0700, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Mon, 19 Oct 2020 16:08:24 +0200, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > > For devices that *don't* use a stop marker, the PCIe spec says
> > > > (10.4.1.2):
> > > > 
> > > >   To stop [using a PASID] without using a Stop Marker Message, the
> > > >   function shall:
> > > >   1. Stop queueing new Page Request Messages for this PASID.  
> > > 
> > > The device driver would need to tell stop sending any new PR's.
> > >   
> > > >   2. Finish transmitting any multi-page Page Request Messages for this
> > > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > > >   3. Wait for PRG Response Messages associated any outstanding Page
> > > >      Request Messages for the PASID.
> > > > 
> > > > So they have to flush their PR themselves. And since the device driver
> > > > completes this sequence before calling unbind(), then there shouldn't
> > > > be any oustanding PR for the PASID, and unbind() doesn't need to
> > > > flush, right?  
> > > 
> > > I can see how the device can complete #2,3 above. But the device driver
> > > isn't the one managing page-responses right. So in order for the device
> > > to know the above sequence is complete, it would need to get some
> > > assist from IOMMU driver?  
> > 
> > No the device driver just waits for the device to indicate that it has
> > completed the sequence. That's what the magic stop-PASID mechanism
> > described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> > says:
> > 
> > "A Function must have a mechanism to request that it gracefully stop using
> >  a specific PASID. This mechanism is device specific but must satisfy the
> >  following rules:
> >  [...]
> >  * When the stop request mechanism indicates completion, the Function has:
> >    [...]
> >    * Complied with additional rules described in Address Translation
> >      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
> >      or Page Requests were issued on the behalf of this PASID."
> > 
> > So after the device driver initiates this mechanism in the device, the
> > device must be able to indicate completion of the mechanism, which
> > includes completing all in-flight Page Requests. At that point the device
> > driver can call unbind() knowing there is no pending PR for this PASID.
> > 
> In step #3, I think it is possible that device driver received page response
> as part of the auto page response, so it may not guarantee all the in-flight
> PRQs are completed inside IOMMU. Therefore, drain is _always_ needed to be
> sure?

So I don't think that's a problem, because non-last PR are not handled by
IOPF until the last PR is received. And when the IOMMU driver detects that
the queue has been overflowing and could have auto-responded to last PR,
we discard any pending non-last PR. I couldn't find a leak here.

Thanks,
Jean

