Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030997D7CBC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjJZGLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjJZGLw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 02:11:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847C187;
        Wed, 25 Oct 2023 23:11:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA9CC433C7;
        Thu, 26 Oct 2023 06:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698300709;
        bh=WP9d1iMdHPkt0PbU8QkjDRKGyEiT4D30Ft8z4vXjTQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVkNkhKh5ml5e5y+JFl345qvwmlc2Mz25e1JTAeCRFmHBWCp3hXXt1ZXdu+qnjTRS
         HYORrhArTLtrjXIlUtP6SJb7IaFad4JoO0V1W4HVBoQOLATcMaTvSxoCw7wl0CK1h/
         KavsoFACTRYaKd36vfWdPMQeLdTV5yrRJhVUJIbnIodsgthnmnP+ZAFjcxEmYItRLn
         HBiI/gXbgG/lf9ECvqU2j9kDzE8yj5iSDkbRgLxmaSphXt2JJQfJXt5ZYpWsF6hliq
         RbVRkfiuIF71qUmw5tBcocOI1LO3uBemxrUqUFO+zKsY71yM29X3rD7zshKmo9wbep
         7pEQ6KDmEs/iw==
Date:   Thu, 26 Oct 2023 11:41:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/5] PCI: epf-mhi: Add support for SA8775P
Message-ID: <20231026061139.GB4915@thinkpad>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-5-git-send-email-quic_msarkar@quicinc.com>
 <20231025075603.GD3648@thinkpad>
 <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 11:00:29AM +0530, Mrinmay Sarkar wrote:
> 
> On 10/25/2023 1:26 PM, Manivannan Sadhasivam wrote:
> > On Thu, Oct 19, 2023 at 05:07:09PM +0530, Mrinmay Sarkar wrote:
> > > Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
> > > SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
> > Is the PID fixed? I thought you just want to reuse the SDXxx PID in the
> > meantime.
> > 
> > - Mani
> 
> The PID for SA8775p EP is not decided yet. So using 0x0306 PID meantime.
> 

Okay, then please mention that explicitly in the commit message.

- Mani

> --Mrinmay
> 
> > > no fixed PCI class, so it is being advertised as "PCI_CLASS_OTHERS".
> > > 
> > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > ---
> > >   drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 +++++++++++++++++
> > >   1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > index b7b9d3e..4487260 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > @@ -114,6 +114,22 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
> > >   	.flags = MHI_EPF_USE_DMA,
> > >   };
> > > +static struct pci_epf_header sa8775p_header = {
> > > +	.vendorid = PCI_VENDOR_ID_QCOM,
> > > +	.deviceid = 0x0306,
> > > +	.baseclass_code = PCI_CLASS_OTHERS,
> > > +	.interrupt_pin = PCI_INTERRUPT_INTA,
> > > +};
> > > +
> > > +static const struct pci_epf_mhi_ep_info sa8775p_info = {
> > > +	.config = &mhi_v1_config,
> > > +	.epf_header = &sa8775p_header,
> > > +	.bar_num = BAR_0,
> > > +	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	.msi_count = 32,
> > > +	.mru = 0x8000,
> > > +};
> > > +
> > >   struct pci_epf_mhi {
> > >   	const struct pci_epc_features *epc_features;
> > >   	const struct pci_epf_mhi_ep_info *info;
> > > @@ -677,6 +693,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
> > >   }
> > >   static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
> > > +	{ .name = "sa8775p", .driver_data = (kernel_ulong_t)&sa8775p_info },
> > >   	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
> > >   	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
> > >   	{},
> > > -- 
> > > 2.7.4
> > > 
> 

-- 
மணிவண்ணன் சதாசிவம்
