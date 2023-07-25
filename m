Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26A760A08
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 08:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGYGGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 02:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGYGGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 02:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE010F8;
        Mon, 24 Jul 2023 23:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7728361316;
        Tue, 25 Jul 2023 06:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F228C433C7;
        Tue, 25 Jul 2023 06:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690265210;
        bh=gIfBT1IjYyX5EUVuONtyzFWbE5BA+lYcbKh21wrD12Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVhSA2bkccs7Aiv0a08RT9UC2kZPUxNh2T/H5iATA3TIKc7zX6XgSTYFwZodZW/8H
         E1X15QA4JkS3SKn9byNHtYCGCgOLkJy/ZuDRJgh6uzoEZ8tL+SHEw171st0WbZX7P2
         vXDdITli1MqzPpitLG9dXgV7pQ6FBuRJEbby79XhfwVyRWWqR3RBtwim5maY3J9Yu7
         CQFHDME4gPgeJkyLSxGHqGTKjYO1KN1uL+fXVF78xCt8NvlULq7Sapnp22/HhZVUVj
         KR5oGhHUlD70Pe+GIptw4jlDJI+aP0k6QVg1zJ+abmfLhBDEwOul3/qrmRAdgWqIjM
         jVhBbYM9De/+w==
Date:   Tue, 25 Jul 2023 11:36:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
Message-ID: <20230725060635.GA22139@thinkpad>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
 <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
 <20230724130855.GO6291@thinkpad>
 <20230724140940.GP6291@thinkpad>
 <172de6f2-ea61-568e-2845-d1334fb49cb6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172de6f2-ea61-568e-2845-d1334fb49cb6@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 10:16:04AM +0530, Praveenkumar I wrote:
> 
> On 7/24/2023 7:39 PM, Manivannan Sadhasivam wrote:
> > On Mon, Jul 24, 2023 at 06:38:55PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jul 24, 2023 at 02:53:37PM +0200, Konrad Dybcio wrote:
> > > > On 24.07.2023 14:47, Praveenkumar I wrote:
> > > > > Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
> > > > > PCIe RC to use the max payload size when a capable link partner is
> > > > > connected.
> > > > > 
> > > > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > > > ---
> > > > [...]
> > > > 
> > > > > +static void qcom_fixup_mps_256(struct pci_dev *dev)
> > > > > +{
> > > > > +	pcie_set_mps(dev, 256);
> > > > Looks like setting "dev->pcie_mpss = 1" here would make the PCIe generic
> > > > code take care of this.
> > > > 
> > > Right, also this setting should not be PCI-PCI bridge specific but rather
> > > controller specific.
> > > 
> > Wait, have you tested this patch with PCIe devices having MPS < 256 i.e.,
> > default 128?
> > 
> > Take a look at this discussion: https://lore.kernel.org/all/20230608093652.1409485-1-vidyas@nvidia.com/
> > 
> > - Mani
> Yes, tested this patch with PCIe devices having default 128 and RC is
> falling back to 128 when pci device is added.
> This is handled inside pci_configure_mps().
> /        mpss = 128 << dev->pcie_mpss;/
> /        if (mpss < p_mps && pci_pcie_type(bridge) ==
> PCI_EXP_TYPE_ROOT_PORT) {/
> /                pcie_set_mps(bridge, mpss);/
> /                pci_info(dev, "Upstream bridge's Max Payload Size set to %d
> (was %d, max %d)\n",/
> /                         mpss, p_mps, 128 << bridge->pcie_mpss);/
> /                p_mps = pcie_get_mps(bridge);/
> /        }/
> //
> Also getting the below print,
> /[    2.011963] pci 0003:01:00.0: Upstream bridge's Max Payload Size set to
> 128 (was 256, max 256)/

Ok. But for setting MPS, you need to change the DEVCTL register in post_init
sequence for IPQ9574. It is not a quirk, so you cannot use fixups.

- Mani

> > > - Mani
> > > 
> > > > Konrad
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> --
> Thanks,
> Praveenkumar

-- 
மணிவண்ணன் சதாசிவம்
