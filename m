Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825E7B0B56
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjI0Rzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Rzp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 13:55:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FDA1;
        Wed, 27 Sep 2023 10:55:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504FDC433C7;
        Wed, 27 Sep 2023 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695837344;
        bh=YWY1pyf8MtEkd6eJhAPHczfGvF6Owa5tbXmP/WVgLMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NRgoEnRTPkUxDJfSAg22dvbMv0o7P+aiMaU+hrFKT6KEdma8oTW/Lpn/ECBb19RtA
         +8T7UzqRABdIZ+uYKKc4wS2KzStSHPLgG+SjHuCjy0D2W6lyn0wUYpcJDLOLllKtEX
         XITi9rgdX6EG4lKiDDne6GElZioCNUo/54z1zlHc7eICG/O4cr9ugzL/Q89qkHS4Ym
         kGk/FzOjXSDhQ5QkJhJNt3bVztUmVQxD/rV1qo7azgeNZHa1oNFSFQtOc5hlSwxCR0
         rEiAKPgDtNKDugR7dzchKwVeNFe3PO6NJEx0ABOtzXESjQfp8Ir1UKdihd8ROpPEN1
         9w33dJoWMOd4w==
Date:   Wed, 27 Sep 2023 12:55:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v3 2/3] PCI: qcom-ep: Make use of PCIE_SPEED2MBS_ENC()
 macro for encoding link speed
Message-ID: <20230927175542.GA455424@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927154603.172049-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 05:46:02PM +0200, Manivannan Sadhasivam wrote:
> Instead of hardcoding the link speed in MBps, let's make use of the
> existing PCIE_SPEED2MBS_ENC() macro that does the encoding of the
> link speed for us. Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW()
> macro to do the conversion to ICC speed.

In subject, /Make use of/Use/ would make better use of the subject
line.  Lots of "uses" there :)

Above, s/let's//, and also s/make use of/use/.

> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))

It's a shame to have to duplicate this macro in pcie-qcom.c and in
pcie-qcom-ep.c, especially since there's nothing qcom-specific in it.

Would a macro like this fit in interconnect.h?

> -	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));

"1" is not very informative here.  Maybe PCIE_SPEED_2_5GT?  (I didn't
completely verify that this is equivalent.)

Bjorn
