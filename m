Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C32928F4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgJSOIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgJSOIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 10:08:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDEDC0613D0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 07:08:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so14111688ejc.5
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/KfoISsApaN0NSURJOvvfJb6dwcjjrFUhXMB/UsO5u8=;
        b=NdZ9UN+yHyzobun2pSlu10EnMwdoI5kP57Dg+V9m5zdFRPjXDmTawgoX/3q3hFLOr7
         TR5GP/k/Lp6kZRQsnuow8o3X97atocZ1Gg0S7CVRhxF9sCC+PDl3TXsHlCw5ZYr214ny
         d39+ustjfCO8YQY2hsjzo1g621AuJAVzgi+iHCt05Y95N7+cvHBoiwfmQS5qyExSnd6U
         VNNSXIdBmX7tr2OAhm0mMmhtrkIqePNqGUavbKyC7caHTGUlbxS42DsK58B8keW2wtLJ
         66lBN8ZAkgIhKatEKaGFAMpbsGtj/WH3lUykXJ8SFQGCrlYHkigOufghId9ptnzODJmi
         c9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KfoISsApaN0NSURJOvvfJb6dwcjjrFUhXMB/UsO5u8=;
        b=l0owxpGxed0i6kkEQJ432fY0in0oPEq9JG1wUlnvmZUV4ZeNUc8BdwJ/SDocUggJWB
         ITh2lPK0bja5HffF6aUj/NUe7Nyquh8fqoIJ1mkGq9dogusfVQEMW/ymrEEp0gfE780L
         u52b7/0xRZuaFiJekO3Dvea2blbMK2yEisQm5dSvVnSmRYbCM6LDWOYQmdCmqcqVAZo3
         5KtgQ8E7Vrbj+h/BuYs5KOE96ujhb0GyJ0SgLhaXB0msRLC5a7Vpwnf9Vv95ITnleI5X
         XHP96gALmmGZvKcVv7O1pUJG+QRastSeLsjigrWJ1yE23gsT47WfJdN3Wa46LyCf5g5b
         dm3w==
X-Gm-Message-State: AOAM532JA2gfwHgkg4XR1vJFJY9lYOYiaNBwrdoDl9WrEzAhKVb1w5ME
        cY0m/sstLk7KQBbvYI+jl4ZLNQ==
X-Google-Smtp-Source: ABdhPJwA7uw6+ZE3RVnaAj9H96KR8FzN4UrEVEZS6aUBgtDdquQPDfuzZYCFSozbMOV5OyjLm10zow==
X-Received: by 2002:a17:906:1150:: with SMTP id i16mr96740eja.82.1603116524907;
        Mon, 19 Oct 2020 07:08:44 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id f25sm10868868edy.52.2020.10.19.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:08:44 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:08:24 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201019140824.GA1478235@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017112525.GA47206@otc-nc-03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> > 
> >   To stop [using a PASID] without using a Stop Marker Message, the
> >   function shall:
> >   1. Stop queueing new Page Request Messages for this PASID.
> 
> The device driver would need to tell stop sending any new PR's.
> 
> >   2. Finish transmitting any multi-page Page Request Messages for this
> >      PASID (i.e. send the Page Request Message with the L bit Set).
> >   3. Wait for PRG Response Messages associated any outstanding Page
> >      Request Messages for the PASID.
> > 
> > So they have to flush their PR themselves. And since the device driver
> > completes this sequence before calling unbind(), then there shouldn't be
> > any oustanding PR for the PASID, and unbind() doesn't need to flush,
> > right?
> 
> I can see how the device can complete #2,3 above. But the device driver
> isn't the one managing page-responses right. So in order for the device to
> know the above sequence is complete, it would need to get some assist from
> IOMMU driver?

No the device driver just waits for the device to indicate that it has
completed the sequence. That's what the magic stop-PASID mechanism
described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
says:

"A Function must have a mechanism to request that it gracefully stop using
 a specific PASID. This mechanism is device specific but must satisfy the
 following rules:
 [...]
 * When the stop request mechanism indicates completion, the Function has:
   [...]
   * Complied with additional rules described in Address Translation
     Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
     or Page Requests were issued on the behalf of this PASID."

So after the device driver initiates this mechanism in the device, the
device must be able to indicate completion of the mechanism, which
includes completing all in-flight Page Requests. At that point the device
driver can call unbind() knowing there is no pending PR for this PASID.

Thanks,
Jean

> 
> How does the driver know that everything host received has been responded
> back to device?
> 
> > 
> > > I'm not sure about other IOMMU's how they behave, When there is no space in
> > > the PRQ, IOMMU auto-responds to the device. This puts the device in a
> > > while (1) loop. The fake successful response will let the device do a ATS
> > > lookup, and that would fail forcing the device to do another PRQ.
> > 
> > But in the sequence above, step 1 should ensure that the device will not
> > send another PR for any successful response coming back at step 3.
> 
> True, but there could be some page-request in flight on its way to the
> IOMMU. By draining and getting that round trip back to IOMMU we gaurantee
> things in flight are flushed to PRQ after that Drain completes.
> > 
> > So I agree with the below if we suspect there could be pending PR, but
> > given that pending PR are a stop marker thing and we don't know any device
> > using stop markers, I wondered why I bothered implementing PRIq flush at
> > all for SMMUv3, hence this RFC.
> > 
> 
> Cheers,
> Ashok
