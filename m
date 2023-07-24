Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DB75F96E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGXOKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGXOKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 10:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7635E63;
        Mon, 24 Jul 2023 07:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CFAB61222;
        Mon, 24 Jul 2023 14:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B920CC433C8;
        Mon, 24 Jul 2023 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690207794;
        bh=KuEIKez9ZJ58UWJuh/R8gWRHJz5+pZVFjkjNd8d6ZHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMo5ndOUxmAC89bvY/4t6aW/pvF0Xm81qjX8t2GJLMIv26bITrL7wwMr3sPoBglEu
         fa59/H/lg+LFsYazg6toAOhrnPntGiB9tfqr5zXsngUqibuubScYptTCwRiZDBnLIa
         RjTiVIUMG0riRfYouMFVyMynpnr1tp0qkY/n5K2eDrpJz5LEFmOT7eQopDeNeN3q+Y
         phfw6szt0XQOMI4lMcqZFgq+aFE9n2RpxeB5z6MT8nDgs6wOse6SypPt/ZMxm/dXP8
         eqBFQBB3F6hn1JtkUxVavcZtZJ2jlLfXWLzhZPNlrMmJX8mw6pzfpSwJ0hf0doK7Rx
         /zBmKBWJBBB4w==
Date:   Mon, 24 Jul 2023 19:39:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
Message-ID: <20230724140940.GP6291@thinkpad>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
 <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
 <20230724130855.GO6291@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724130855.GO6291@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 06:38:55PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 24, 2023 at 02:53:37PM +0200, Konrad Dybcio wrote:
> > On 24.07.2023 14:47, Praveenkumar I wrote:
> > > Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
> > > PCIe RC to use the max payload size when a capable link partner is
> > > connected.
> > > 
> > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > ---
> > [...]
> > 
> > > 
> > > +static void qcom_fixup_mps_256(struct pci_dev *dev)
> > > +{
> > > +	pcie_set_mps(dev, 256);
> > Looks like setting "dev->pcie_mpss = 1" here would make the PCIe generic
> > code take care of this.
> > 
> 
> Right, also this setting should not be PCI-PCI bridge specific but rather
> controller specific.
> 

Wait, have you tested this patch with PCIe devices having MPS < 256 i.e.,
default 128?

Take a look at this discussion: https://lore.kernel.org/all/20230608093652.1409485-1-vidyas@nvidia.com/

- Mani

> - Mani
> 
> > Konrad
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
