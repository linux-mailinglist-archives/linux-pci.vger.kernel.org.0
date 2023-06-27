Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66E73FF49
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjF0PHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0PHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 11:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1D26B3;
        Tue, 27 Jun 2023 08:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EC4611D4;
        Tue, 27 Jun 2023 15:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C32C433C0;
        Tue, 27 Jun 2023 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687878453;
        bh=AXF7IKf4qXT069zemU/G/IVo2cZThyfn1QvsJuPHDDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEyh9e1eJ7A5at0AaLuc5T2nw8P2JF0HnTcofe2s3RIZuABuSFU0NWwUvY7OFBaJM
         123XtMWzzljGeH+aBO04CMeGqeC9uMgzSl8CrUVsLpEuLZxM1uKZbzCqmBYppRI3ex
         21cvQmzogEpH+cfgqJHiR8NpHnpGOLIfNsoF2toqOWmuyUu0dYCfzq6ItGQHNSa0y8
         3x5rBlVOsIJG9A39ZcjgB4Z3Wn12RP5IzlOY8QpqWP+t3tbAEXmTX+RblhDNu3wKKB
         +6O/cxMOpN7WVdywyzY6bR40i/CBv822KIXbh+q+0UI48yO9AokkFdgJt5tvBMOw2C
         BttIy7JbfJ8Ig==
Date:   Tue, 27 Jun 2023 20:37:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230627150718.GJ5490@thinkpad>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
 <bdce0719-4f12-4e75-a8e7-1b38d269ac15@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdce0719-4f12-4e75-a8e7-1b38d269ac15@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 12:05:23PM +0530, Pavan Kondeti wrote:
> On Tue, Jun 27, 2023 at 06:31:31AM +0530, Krishna chaitanya chundru wrote:
> > +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> > +{
> > +	struct dw_pcie *pci = &pcie_ep->pci;
> > +	u32 offset, status, bw;
> > +	int speed, width;
> > +	int ret;
> > +
> > +	if (!pcie_ep->icc_mem)
> > +		return;
> > +
> 
> Is this check needed? interconnect is added as required property and
> probe is failed if interconnect get fails. qcom_pcie_enable_resources()
> which gets called before enabling this interrupt is assuming that
> interconnect available.
> 

Even though the current binding requires interconnect, driver needs to be
backwards compatible with old dts where there was no interconnect.

Also, devm_of_icc_get() will return NULL if the property is missing in dts. But
we are just checking for IS_ERR not IS_ERR_OR_NULL. So this check is required.

- Mani

> 
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> > +
> > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> > +
> > +	switch (speed) {
> > +	case 1:
> > +		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
> > +		break;
> > +	case 2:
> > +		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
> > +		break;
> > +	case 3:
> > +		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
> > +		break;
> > +	default:
> > +		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
> > +		fallthrough;
> > +	case 4:
> > +		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
> > +		break;
> > +	}
> > +
> > +	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
> > +	if (ret) {
> > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > +			ret);
> > +	}
> 
> Are you not seeing the below warning from checkpatch?
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> > +}
> > +
> >  static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
> >  {
> >  	int ret;
> > +	struct dw_pcie *pci = &pcie_ep->pci;
> >  
> >  	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
> >  	if (ret)
> > @@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
> >  	if (ret)
> >  		goto err_phy_exit;
> >  
> > +	/*
> > +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> > +	 * to be set before enabling interconnect clocks.
> > +	 *
> > +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> > +	 * for the pcie-mem path.
> > +	 */
> > +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> > +	if (ret) {
> > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > +			ret);
> > +		goto err_phy_exit;
> > +	}
> > +
> >  	return 0;
> 
> Thanks,
> Pavan

-- 
மணிவண்ணன் சதாசிவம்
