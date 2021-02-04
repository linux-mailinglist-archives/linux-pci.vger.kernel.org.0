Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1030F915
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhBDRFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 12:05:51 -0500
Received: from foss.arm.com ([217.140.110.172]:33978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238355AbhBDRDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 12:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C85713A1;
        Thu,  4 Feb 2021 09:02:53 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814BB3F73B;
        Thu,  4 Feb 2021 09:02:52 -0800 (PST)
Date:   Thu, 4 Feb 2021 17:02:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v5 0/2] PCI: qcom: fix PCIe support on sm8250
Message-ID: <20210204170247.GA583@e121166-lin.cambridge.arm.com>
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
 <64f62684-523d-cbd5-708b-4c06e7d03954@linaro.org>
 <CAA8EJpqxtqxy5Z8KGt_wQGLvXKWhmLXi845VQ+w2_ps71fKVhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqxtqxy5Z8KGt_wQGLvXKWhmLXi845VQ+w2_ps71fKVhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Stanimir]

On Thu, Feb 04, 2021 at 06:06:16PM +0300, Dmitry Baryshkov wrote:
> On Tue, 26 Jan 2021 at 23:11, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Rob, Lorenzo, gracious poke for this patchset.
> 
> Dear colleagues, another gracious ping. I'm not insisting on getting
> this into 5.12 (it would be good though), but I'd kindly ask for these
> patches to be reviewed/acked.

I need an ACK from the maintainer(s) to pull them.

Thanks,
Lorenzo

> > On 17/01/2021 04:31, Dmitry Baryshkov wrote:
> > > SM8250 platform requires additional clock to be enabled for PCIe to
> > > function. In case it is disabled, PCIe access will result in IOMMU
> > > timeouts. Add device tree binding and driver support for this clock.
> > >
> > > Canges since v4:
> > >   - Remove QCOM_PCIE_2_7_0_MAX_CLOCKS define and has_sf_tbu variable.
> > >
> > > Changes since v3:
> > >   - Merge clock handling back into qcom_pcie_get_resources_2_7_0().
> > >     Define res->num_clks to the amount of clocks used for this particular
> > >     platform.
> > >
> > > Changes since v2:
> > >   - Split this clock handling from qcom_pcie_get_resources_2_7_0()
> > >   - Change comment to point that the clock is required rather than
> > >     optional
> > >
> > > Changes since v1:
> > >   - Added Fixes: tags, as respective patches have hit the upstream Linux
> > >     tree.
> > >
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
> 
> 
> 
> -- 
> With best wishes
> Dmitry
