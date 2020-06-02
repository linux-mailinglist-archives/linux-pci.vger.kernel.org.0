Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751491EB9A2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgFBKbf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 2 Jun 2020 06:31:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbgFBKbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 06:31:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9DA1C2F3133232790D75;
        Tue,  2 Jun 2020 11:31:32 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 2 Jun 2020 11:31:29 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Tue, 2 Jun 2020 11:31:29 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: RE: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Thread-Topic: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Thread-Index: AQHWLgezl67to0Fq/kugWrIzT8tlbajDuzCQgAFbKgCAABJrcA==
Date:   Tue, 2 Jun 2020 10:31:29 +0000
Message-ID: <1517c4d97b5849e6b6d32e7d7ed35289@huawei.com>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-22-jean-philippe@linaro.org>
 <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
 <20200602093836.GA1029680@myrica>
In-Reply-To: <20200602093836.GA1029680@myrica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Jean-Philippe Brucker
> Sent: 02 June 2020 10:39
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: devicetree@vger.kernel.org; kevin.tian@intel.com; will@kernel.org;
> fenghua.yu@intel.com; jgg@ziepe.ca; linux-pci@vger.kernel.org;
> felix.kuehling@amd.com; hch@infradead.org; linux-mm@kvack.org;
> iommu@lists.linux-foundation.org; catalin.marinas@arm.com;
> zhangfei.gao@linaro.org; robin.murphy@arm.com;
> christian.koenig@amd.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
> platform devices
> 
> Hi Shameer,
> 
> On Mon, Jun 01, 2020 at 12:42:15PM +0000, Shameerali Kolothum Thodi
> wrote:
> > >  /* IRQ and event handlers */
> > > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64
> > > +*evt) {
> > > +	int ret;
> > > +	u32 perm = 0;
> > > +	struct arm_smmu_master *master;
> > > +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > > +	u8 type = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > > +	struct iommu_fault_event fault_evt = { };
> > > +	struct iommu_fault *flt = &fault_evt.fault;
> > > +
> > > +	/* Stage-2 is always pinned at the moment */
> > > +	if (evt[1] & EVTQ_1_S2)
> > > +		return -EFAULT;
> > > +
> > > +	master = arm_smmu_find_master(smmu, sid);
> > > +	if (!master)
> > > +		return -EINVAL;
> > > +
> > > +	if (evt[1] & EVTQ_1_READ)
> > > +		perm |= IOMMU_FAULT_PERM_READ;
> > > +	else
> > > +		perm |= IOMMU_FAULT_PERM_WRITE;
> > > +
> > > +	if (evt[1] & EVTQ_1_EXEC)
> > > +		perm |= IOMMU_FAULT_PERM_EXEC;
> > > +
> > > +	if (evt[1] & EVTQ_1_PRIV)
> > > +		perm |= IOMMU_FAULT_PERM_PRIV;
> > > +
> > > +	if (evt[1] & EVTQ_1_STALL) {
> > > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > > +		flt->prm = (struct iommu_fault_page_request) {
> > > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > > +			.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]),
> > > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > > +			.perm = perm,
> > > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > > +		};
> > > +
> >
> > > +		if (ssid_valid)
> > > +			flt->prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> >
> > Do we need to set this for STALL mode only support? I had an issue
> > with this being set on a vSVA POC based on our D06 zip device(which is
> > a "fake " pci dev that supports STALL mode but no PRI). The issue is,
> > CMDQ_OP_RESUME doesn't have any ssid or SSV params and works on sid
> and stag only.
> 
> I don't understand the problem, arm_smmu_page_response() doesn't set SSID
> or SSV when sending a CMDQ_OP_RESUME. Could you detail the flow of a stall
> event and RESUME command in your prototype?  Are you getting issues with
> the host driver or the guest driver?

The issue is on the host side iommu_page_response(). The flow is something like
below.

Stall: Host:-

arm_smmu_handle_evt()
  iommu_report_device_fault()
    vfio_pci_iommu_dev_fault_handler()
      
Stall: Qemu:-

vfio_dma_fault_notifier_handler()
  inject_faults()
    smmuv3_inject_faults()

Stall: Guest:-

arm_smmu_handle_evt()
  iommu_report_device_fault()
    iommu_queue_iopf
  ...
  iopf_handle_group()
    iopf_handle_single()
      handle_mm_fault()
        iopf_complete()
           iommu_page_response()
             arm_smmu_page_response()
               arm_smmu_cmdq_issue_cmd(CMDQ_OP_RESUME)

Resume: Qemu:-

smmuv3_cmdq_consume(SMMU_CMD_RESUME)
  smmuv3_notify_page_resp()
    vfio:ioctl(page_response)  --> struct iommu_page_response is filled
                             with only version, grpid and code.

Resume: Host:-
  ioctl(page_response)
    iommu_page_response()  --> fails as the pending req has PASID_VALID flag
                             set and it checks for a match.
      arm_smmu_page_response()

Hope the above is clear.

> We do need to forward the SSV flag all the way to the guest driver, so the guest
> can find the faulting address space using the SSID. Once the guest handled the
> fault, then we don't send the SSID back to the host as part of the RESUME
> command.

True, the guest requires SSV flag to handle the page fault. But, as shown in the
flow above, the issue is on the host side iommu_page_response() where it
searches for a matching pending req based on pasid. Not sure we can bypass
that and call arm_smmu_page_response() directly but then have to delete the
pending req from the list as well.

Please let me know if there is a better way to handle the host side page
response.

Thanks,
Shameer

> Thanks,
> Jean
> 
> > Hence, it is difficult for
> > Qemu SMMUv3 to populate this fields while preparing a page response. I
> > can see that this flag is being checked in iopf_handle_single() (patch
> > 04/24) as well. For POC, I used a temp fix[1] to work around this. Please let
> me know your thoughts.
> >
> > Thanks,
> > Shameer
> >
> > 1.
> > https://github.com/hisilicon/kernel-dev/commit/99ff96146e924055f38d97a
> > 5897e4becfa378d15
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
