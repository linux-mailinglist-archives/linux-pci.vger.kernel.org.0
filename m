Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E46698D3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 14:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbjAMNjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 08:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbjAMNjT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 08:39:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A25D42B;
        Fri, 13 Jan 2023 05:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F41E3CE20C0;
        Fri, 13 Jan 2023 13:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6ADC433D2;
        Fri, 13 Jan 2023 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673616845;
        bh=4fIWeSfavalqyGaq8m38A11UZhjKnhPHicQ6ZbqFu8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgjDGETScby1FKWVrmMfAQ/T8tszPrDULuGLI1BHFEAENeEPRerw4A9BXPeFCJqOg
         z1I93YKLAytPh8pIYwH3TyGKsKYsiqh8Tfz4mK94E6gXRcSNlTK6UdhJhNVrMIN0zT
         cuSEds5r+U2ljBlZNrSv1BOtiFlxysWXf1XHmlYw30co6me3I5lM5X3eK8dUZCyMRl
         6EBKD3pIRRLCQyvUfMIdY4nrxtEx6+AiknsMtMn64wI9QRQKeYO+9umYmr/jVKbCES
         48BzpOfM2AfsNFoSfW6omjJ4XQ/oD6eoUl82GZwic1L82ASv0gvucgCM96h/5EtrcZ
         O5eIhWnFEBvbQ==
Date:   Fri, 13 Jan 2023 14:33:58 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: qcom: add support for IPQ8074 Gen3 port
Message-ID: <Y8FdxtCitnBd1c6k@lpieralisi>
References: <20221116214841.1116735-7-robimarko@gmail.com>
 <20221117192837.GA1203269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117192837.GA1203269@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 01:28:37PM -0600, Bjorn Helgaas wrote:
> Hi Robert,
> 
> If you post a v2 for any reason, capitalize the subject line to match
> previous history:
> 
>   PCI: qcom: Rename host-init error label
>   PCI: qcom: Drop unused post_deinit callback
>   PCI: qcom: Sort device-id table
>   PCI: qcom: Clean up IP configurations
>   ...

If he could do that while rebasing on top of my current pci/qcom branch
that would be ideal, I tried to cherry-pick patches 5,6,7 but 5 does not
apply.

Thanks,
Lorenzo

> 
> On Wed, Nov 16, 2022 at 10:48:39PM +0100, Robert Marko wrote:
> > IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
> > Add compatible for Gen3 port which uses the same controller as IPQ6018.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 77e5dc7b88ad..97e8510c53fb 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> > +	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> >  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> >  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> >  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> > -- 
> > 2.38.1
> > 
