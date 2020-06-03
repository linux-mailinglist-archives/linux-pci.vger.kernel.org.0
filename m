Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231221ECAAD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgFCHjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCHjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 03:39:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406DEC05BD43
        for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2020 00:39:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so848712wmh.4
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2020 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hLQ9Ov0eKr85gKa7olFwe6f0SlVLYGl5nrVG5b+LzPg=;
        b=BaA7HqoJAJJh2tIRtyNtCnJJ+ARabjO7t5qWHkwfey6v8O/bYqibUoJb7g2lNYfNoZ
         ifRC05Pi1fFsLS0xec3/ZwWH5HsiqKmSLEV1fLmRpATey18HMYDmWin9n3Lkz4IawUOQ
         xlEYpZp5UmMhs18ikzeusxNZVkL8Zx3ToEbKvsz7PW6G3ARdQwBq0YY+pC+k6oMkgPG9
         WS33Jb4rH9VdYT1yaXMb7+k5Kf1kqlPXl8+BOa8wlHnCW3navM5sN6dA2DpyHeZobAy9
         jaGeJhzWEgaTqAFNlLtfzmz/6tmkY5sIGP7K7i1KqYqmIFqvLzdVzqj+ASM+V0Ps5U09
         v7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLQ9Ov0eKr85gKa7olFwe6f0SlVLYGl5nrVG5b+LzPg=;
        b=mEdVEklfComiIdQdXHjwx+TmKvonj32SqOvUcbFqRPRXP6z0OIEMMQ5rJR9Pym/csq
         FP7ccNBHTZ+GK4tmak+g0LeDaD5yeUvh7HxZeIuU11sQtVddgicRaL1+KDyOEebtRF06
         6o9kP+FwMppuGqsAzwVnME2ix9X0NfmIv1ckIfu16VIMz2wTx0eKqlHx4Mm0T8f2SZ4W
         zYYt6ezR9Y0iGY1tVj8MJjsbBPzy2Vl0MrjTG5Zmx3wQf5SEyvyWDlgChe1udZyREib7
         89ObNU93Z1d35qY4rcc/vT3HQkh+xMI5Iw9HxkC8ssE6oN/orrEAf4xlwAS/lUT+WA2a
         3SWQ==
X-Gm-Message-State: AOAM532nuFCCEiKHS8Z9SZejn8i6BXhWiCUCFszCR3xyeRN5dnDPSHW1
        Li1qoJs4dsxbMbo/AO8LAvjPeQ==
X-Google-Smtp-Source: ABdhPJx2CVWTxoCwkjfPm8H6OgQs2Q+1IKumvn68jhcLFzJkSHw/NXJvs00yy3+6Xok2VEhmklRBbQ==
X-Received: by 2002:a1c:5a0b:: with SMTP id o11mr7245089wmb.74.1591169941832;
        Wed, 03 Jun 2020 00:39:01 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id t129sm1796108wmf.41.2020.06.03.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 00:39:01 -0700 (PDT)
Date:   Wed, 3 Jun 2020 09:38:51 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "felix.kuehling@amd.com" <felix.kuehling@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200603073851.GA3198@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-22-jean-philippe@linaro.org>
 <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
 <20200602093836.GA1029680@myrica>
 <1517c4d97b5849e6b6d32e7d7ed35289@huawei.com>
 <20200602114611.GB1029680@myrica>
 <c165fe41230f49baba991f1a416a4739@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c165fe41230f49baba991f1a416a4739@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 12:12:30PM +0000, Shameerali Kolothum Thodi wrote:
> > > > > > +		if (ssid_valid)
> > > > > > +			flt->prm.flags |=
> > > > IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > > > >
> > > > > Do we need to set this for STALL mode only support? I had an issue
> > > > > with this being set on a vSVA POC based on our D06 zip
> > > > > device(which is a "fake " pci dev that supports STALL mode but no
> > > > > PRI). The issue is, CMDQ_OP_RESUME doesn't have any ssid or SSV
> > > > > params and works on sid
> > > > and stag only.
> > > >
> > > > I don't understand the problem, arm_smmu_page_response() doesn't set
> > > > SSID or SSV when sending a CMDQ_OP_RESUME. Could you detail the flow
> > > > of a stall event and RESUME command in your prototype?  Are you
> > > > getting issues with the host driver or the guest driver?
> > >
> > > The issue is on the host side iommu_page_response(). The flow is
> > > something like below.
> > >
> > > Stall: Host:-
> > >
> > > arm_smmu_handle_evt()
> > >   iommu_report_device_fault()
> > >     vfio_pci_iommu_dev_fault_handler()
> > >
> > > Stall: Qemu:-
> > >
> > > vfio_dma_fault_notifier_handler()
> > >   inject_faults()
> > >     smmuv3_inject_faults()
> > >
> > > Stall: Guest:-
> > >
> > > arm_smmu_handle_evt()
> > >   iommu_report_device_fault()
> > >     iommu_queue_iopf
> > >   ...
> > >   iopf_handle_group()
> > >     iopf_handle_single()
> > >       handle_mm_fault()
> > >         iopf_complete()
> > >            iommu_page_response()
> > >              arm_smmu_page_response()
> > >                arm_smmu_cmdq_issue_cmd(CMDQ_OP_RESUME)
> > >
> > > Resume: Qemu:-
> > >
> > > smmuv3_cmdq_consume(SMMU_CMD_RESUME)
> > >   smmuv3_notify_page_resp()
> > >     vfio:ioctl(page_response)  --> struct iommu_page_response is filled
> > >                              with only version, grpid and code.
> > >
> > > Resume: Host:-
> > >   ioctl(page_response)
> > >     iommu_page_response()  --> fails as the pending req has PASID_VALID
> > flag
> > >                              set and it checks for a match.
> > 
> > I believe the fix needs to be here. It's also wrong for PRI since not all PCIe
> > endpoint require a PASID in the page response. Could you try the attached
> > patch?
> 
> Going through the patch, yes, that will definitely fix the issue. But isn't it better if
> the request itself indicate whether it expects a response msg with a valid pasid or
> not? The response msg can come from userspace as well(vSVA) and if for some reason
> doesn't set it for a req that expects pasid then it should be an error, right? In the temp
> fix I had, I introduced another flag to indicate the endpoint has PRI support or not and
> used that to verify the pasid requirement. But for the PRI case you mentioned 
> above, not sure it is easy to get that information or not. May be I am complicating things
> here :)

No you're right, we shouldn't send back malformed responses to the SMMU. I
suppose we can store a flag "PASID required" in the fault and check that
against the response. If we have to discard the guest's response, then we
can either fake a response (abort the stall) right away, or wait for the
response timeout to kick, which will do the same.

Thanks,
Jean
