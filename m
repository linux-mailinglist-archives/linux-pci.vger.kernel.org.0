Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2FA57816E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGRMAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRMAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 08:00:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17E717A90;
        Mon, 18 Jul 2022 05:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A57EACE1698;
        Mon, 18 Jul 2022 12:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434FC341C0;
        Mon, 18 Jul 2022 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658145628;
        bh=sGRj1qXf7qH5c/aqUGJ+GwJ1LMbx6Qsg9ex7gdrUBwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQgmnlFhri8bnNZ9apf6ajfwayJZs6d0jduCqLy416gCkGxwlzEIuRCW8/ijcbHi3
         LC9D7dbN+k17NgLmA1FfRDdJJYfaypy4xQ796q5BuvBvacfFSTjovZADvQP3Kt/j3i
         vVgF1boG9KxikUckzn+LMvrZOuqAcFZjVxscs9eD22+oQWPcO7FQJSJOoiCJb9BSwp
         ch0sraky8bo9tK0llp15vtIFHumTkMO7hn6jnAsvaRzujI5O3p3JKKPqzWU3fTHKGk
         ixN72HCbLSq+SK+82TKMzvBIDzUFqSWI2Wm6oHKA65sTg73Bo3AyROgEcv4eUo7pTe
         iBmCfqaa67/8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDPQE-0005hU-8V; Mon, 18 Jul 2022 14:00:22 +0200
Date:   Mon, 18 Jul 2022 14:00:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/8] PCI: qcom: Clean up IP configurations
Message-ID: <YtVLVkluQHiyf1dp@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-8-johan+linaro@kernel.org>
 <91edff9a-53f2-647b-04a8-76d15f22a8f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91edff9a-53f2-647b-04a8-76d15f22a8f2@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 01:39:32PM +0300, Dmitry Baryshkov wrote:
> On 14/07/2022 10:13, Johan Hovold wrote:
> > The various IP versions have different configurations that are encoded
> > in separate sets of operation callbacks. Currently, there is no need for
> > also maintaining corresponding sets of data parameters, but it is
> > conceivable that these may again be found useful (e.g. to implement
> > minor variations of the operation callbacks).
> > 
> > Rename the default configuration structures after the IP version they
> > apply to so that they can more easily be reused by different SoCs.
> > 
> > Note that SoC specific configurations can be added later if need arises
> > (e.g. cfg_sc8280xp).
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> 
> If we have nothing left in the qcom_pcie_cfg other than the .ops, what 
> about dropping the qcom_pcie_cfg completely and using the qcom_pcie_ops 
> as match data?

As I mention above I decided to keep the config structures as they can
be used to implement minor variations of the ops.
 
> This patch is nevertheless:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks for reviewing.

Johan
