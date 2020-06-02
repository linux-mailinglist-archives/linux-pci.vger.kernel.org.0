Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BDB1EBAB4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFBLq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFBLq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:46:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A1C061A0E
        for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2020 04:46:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m21so9779773eds.13
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2020 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ics4wOjFIjzNBxAIlnIKnUmEnmyw0rmLzT7c6ne7pSI=;
        b=yijCmqf0VG0ntw+uiPMpdUH4LMWIvqHsCVmInI53fK9mX51SGYwD72IA6DhJmlD97a
         UNj+wr1xk+MpFkSEXLQv8eoO3cAwX2PJr2eu2gMt+Wdvj5/sAsHXbV5SzeGPc9ipSP0Q
         iHfDaFS6bvC9IQ/hqK24QfP+vlNw2yFbtAIcg3kNx4x1y/EZKku2MJwvmhK6aMevkQFs
         8lcMkEWWV5PLBUJ0P4IRbkLYfbsmxy3mAD17T5a69W7H5qUaRUYgujxCLI7dNY/j2CSu
         DluWkc/YGeWTqDa51l8CLmHNfPGrr46903qlPJBuohlTXpBNuzAlqELce9wbsiG2I2+U
         /T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ics4wOjFIjzNBxAIlnIKnUmEnmyw0rmLzT7c6ne7pSI=;
        b=DfBR1VMC50PiFahPoHK6GBLNHqOLg2wxAA1PQvU0CSmjl5A2ep+RnQ6fuTTh/7K1OA
         B09NAp6RkTRj9fUzJJn/YBvnLVC9Ww70NRaGmH7Cad2UD6gxoQ+MSH79kVWCS+QM1ff9
         j/3E+DIhVnY4a5yMvVEIr/as85IdUzbKijZTV+0YHA0UCHOpCiT0UGftKrQDKhqQA2d1
         kJs2BPREAdajUZzPbihBD1X0b8GU5wpSfC8RpnlgjbFbVc62xK1oSj82/sUNh/XxTgUQ
         GdwSFIVSKCZOiaxzyoCNbA5PIhL2p5eUIo6xZZ3m6KZxMWL5k85tWMPTqQm2+FKkftrU
         Uk2A==
X-Gm-Message-State: AOAM5335/hE7Og6c3KQnld7BHAN+dfler25iXSh272sJJ/lN65vD4rsF
        mY9uk3XgEY9O+Cd+dLkF9EF+bnBDuME=
X-Google-Smtp-Source: ABdhPJzk9qpnI9yUmwOaxqU5ALMvmfWfI4N5ixuLoClwbRn/ueEUAkkLlMA8Jw8WKqsKsrA7069JbA==
X-Received: by 2002:a05:6402:34e:: with SMTP id r14mr14619562edw.351.1591098383894;
        Tue, 02 Jun 2020 04:46:23 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h17sm1047269edw.92.2020.06.02.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:46:22 -0700 (PDT)
Date:   Tue, 2 Jun 2020 13:46:11 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "felix.kuehling@amd.com" <felix.kuehling@amd.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200602114611.GB1029680@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-22-jean-philippe@linaro.org>
 <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
 <20200602093836.GA1029680@myrica>
 <1517c4d97b5849e6b6d32e7d7ed35289@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1517c4d97b5849e6b6d32e7d7ed35289@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 10:31:29AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Jean,
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> > On Behalf Of Jean-Philippe Brucker
> > Sent: 02 June 2020 10:39
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: devicetree@vger.kernel.org; kevin.tian@intel.com; will@kernel.org;
> > fenghua.yu@intel.com; jgg@ziepe.ca; linux-pci@vger.kernel.org;
> > felix.kuehling@amd.com; hch@infradead.org; linux-mm@kvack.org;
> > iommu@lists.linux-foundation.org; catalin.marinas@arm.com;
> > zhangfei.gao@linaro.org; robin.murphy@arm.com;
> > christian.koenig@amd.com; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
> > platform devices
> > 
> > Hi Shameer,
> > 
> > On Mon, Jun 01, 2020 at 12:42:15PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > >  /* IRQ and event handlers */
> > > > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64
> > > > +*evt) {
> > > > +	int ret;
> > > > +	u32 perm = 0;
> > > > +	struct arm_smmu_master *master;
> > > > +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > > > +	u8 type = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > > +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > > > +	struct iommu_fault_event fault_evt = { };
> > > > +	struct iommu_fault *flt = &fault_evt.fault;
> > > > +
> > > > +	/* Stage-2 is always pinned at the moment */
> > > > +	if (evt[1] & EVTQ_1_S2)
> > > > +		return -EFAULT;
> > > > +
> > > > +	master = arm_smmu_find_master(smmu, sid);
> > > > +	if (!master)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (evt[1] & EVTQ_1_READ)
> > > > +		perm |= IOMMU_FAULT_PERM_READ;
> > > > +	else
> > > > +		perm |= IOMMU_FAULT_PERM_WRITE;
> > > > +
> > > > +	if (evt[1] & EVTQ_1_EXEC)
> > > > +		perm |= IOMMU_FAULT_PERM_EXEC;
> > > > +
> > > > +	if (evt[1] & EVTQ_1_PRIV)
> > > > +		perm |= IOMMU_FAULT_PERM_PRIV;
> > > > +
> > > > +	if (evt[1] & EVTQ_1_STALL) {
> > > > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > > > +		flt->prm = (struct iommu_fault_page_request) {
> > > > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > > > +			.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]),
> > > > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > > > +			.perm = perm,
> > > > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > > > +		};
> > > > +
> > >
> > > > +		if (ssid_valid)
> > > > +			flt->prm.flags |=
> > IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > >
> > > Do we need to set this for STALL mode only support? I had an issue
> > > with this being set on a vSVA POC based on our D06 zip device(which is
> > > a "fake " pci dev that supports STALL mode but no PRI). The issue is,
> > > CMDQ_OP_RESUME doesn't have any ssid or SSV params and works on sid
> > and stag only.
> > 
> > I don't understand the problem, arm_smmu_page_response() doesn't set SSID
> > or SSV when sending a CMDQ_OP_RESUME. Could you detail the flow of a stall
> > event and RESUME command in your prototype?  Are you getting issues with
> > the host driver or the guest driver?
> 
> The issue is on the host side iommu_page_response(). The flow is something like
> below.
> 
> Stall: Host:-
> 
> arm_smmu_handle_evt()
>   iommu_report_device_fault()
>     vfio_pci_iommu_dev_fault_handler()
>       
> Stall: Qemu:-
> 
> vfio_dma_fault_notifier_handler()
>   inject_faults()
>     smmuv3_inject_faults()
> 
> Stall: Guest:-
> 
> arm_smmu_handle_evt()
>   iommu_report_device_fault()
>     iommu_queue_iopf
>   ...
>   iopf_handle_group()
>     iopf_handle_single()
>       handle_mm_fault()
>         iopf_complete()
>            iommu_page_response()
>              arm_smmu_page_response()
>                arm_smmu_cmdq_issue_cmd(CMDQ_OP_RESUME)
> 
> Resume: Qemu:-
> 
> smmuv3_cmdq_consume(SMMU_CMD_RESUME)
>   smmuv3_notify_page_resp()
>     vfio:ioctl(page_response)  --> struct iommu_page_response is filled
>                              with only version, grpid and code.
> 
> Resume: Host:-
>   ioctl(page_response)
>     iommu_page_response()  --> fails as the pending req has PASID_VALID flag
>                              set and it checks for a match.

I believe the fix needs to be here. It's also wrong for PRI since not all
PCIe endpoint require a PASID in the page response. Could you try the
attached patch?

Thanks,
Jean

>       arm_smmu_page_response()
> 
> Hope the above is clear.
> 
> > We do need to forward the SSV flag all the way to the guest driver, so the guest
> > can find the faulting address space using the SSID. Once the guest handled the
> > fault, then we don't send the SSID back to the host as part of the RESUME
> > command.
> 
> True, the guest requires SSV flag to handle the page fault. But, as shown in the
> flow above, the issue is on the host side iommu_page_response() where it
> searches for a matching pending req based on pasid. Not sure we can bypass
> that and call arm_smmu_page_response() directly but then have to delete the
> pending req from the list as well.
> 
> Please let me know if there is a better way to handle the host side page
> response.
> 
> Thanks,
> Shameer
> 
> > Thanks,
> > Jean
> > 
> > > Hence, it is difficult for
> > > Qemu SMMUv3 to populate this fields while preparing a page response. I
> > > can see that this flag is being checked in iopf_handle_single() (patch
> > > 04/24) as well. For POC, I used a temp fix[1] to work around this. Please let
> > me know your thoughts.
> > >
> > > Thanks,
> > > Shameer
> > >
> > > 1.
> > > https://github.com/hisilicon/kernel-dev/commit/99ff96146e924055f38d97a
> > > 5897e4becfa378d15
> > >
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-Allow-page-responses-without-PASID.patch"

From 9baf5b9894d4e4be05e665d80fd0ebac8b621aa4 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Tue, 2 Jun 2020 13:13:27 +0200
Subject: [PATCH] iommu: Allow page responses without PASID

Some PCIe devices do not expect a PASID value in PRI Page Responses. If
the "PRG Response PASID Required" bit in the PRI capability is zero,
then the OS should not set the PASID field. Similarly on Arm SMMU,
responses to stall events do not have a PASID.

Currently iommu_page_response() checks that the PASID in the page
response corresponds to the one in the page request without first
checking the "PASID valid" bit. A page response coming from a guest OS
does not necessarily have a PASID, if the passed-through device does not
require one.

Allow page responses without PASID. The page request corresponding to a
page response is identified by device and by Page Response Group Index
(or stall tag).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e61a9fc65b7e4..e481fdfafb77c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1296,7 +1296,8 @@ int iommu_page_response(struct device *dev,
 	 */
 	list_for_each_entry(evt, &param->fault_param->faults, list) {
 		prm = &evt->fault.prm;
-		pasid_valid = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		pasid_valid = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID
+			   && msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
 
 		if ((pasid_valid && prm->pasid != msg->pasid) ||
 		    prm->grpid != msg->grpid)
-- 
2.26.2


--3MwIy2ne0vdjdPXF--
