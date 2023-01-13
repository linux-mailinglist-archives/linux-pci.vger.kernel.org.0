Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C866A630
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 23:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAMWrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 17:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjAMWry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 17:47:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6297D9C0;
        Fri, 13 Jan 2023 14:47:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B4962379;
        Fri, 13 Jan 2023 22:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D13C433D2;
        Fri, 13 Jan 2023 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673650071;
        bh=m6BCAWNCPI6j0WsoXGJueh7ZBC9YQjK4rw2vau9f6mE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l/Us437tR08BaTqdpx/LtDn3GUNJYJg+Q8Qi5HMaiYhVvONBUlSrGv79HJQGvxiT6
         p6/q50Wu6Czee5ULnAsKzeDbHh5TQISKMlca6R7kQ4ZplFYPFnF8ElPhWn3GxsdTdb
         K8qNLEijAJVUWWB8SjEZyM8zboiRkd6HLLr5XR984042aVd92+VjSyFik0W+r8+20H
         VutIfnjEYX9IUaDSlyjdoj1sYoYJCcJY9AOk2NK6ZwxYpuDhsT/IN3rSGUfEGPIIu9
         OaZEshQxs8h78d3LMoDGrYmIlI2PrE+FsIYW/sijONi/dPMo6JK7+XkMSYhh76lfYF
         RLTIm1jqIckiA==
Date:   Fri, 13 Jan 2023 16:47:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom,pcie-ep: correct
 qcom,perst-regs
Message-ID: <20230113224749.GA1867364@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9016ea51-9ca2-551d-d4a1-0b70232b5dc5@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 03:23:18PM +0100, Krzysztof Kozlowski wrote:
> On 13/01/2023 15:03, Bjorn Helgaas wrote:
> > On Fri, Jan 13, 2023 at 10:02:27AM +0100, Krzysztof Kozlowski wrote:
> >> On 30/12/2022 14:42, Lorenzo Pieralisi wrote:
> >>> On Wed, 9 Nov 2022 12:32:02 +0100, Krzysztof Kozlowski wrote:
> >>>> qcom,perst-regs is an phandle array of one item with a phandle and its
> >>>> arguments.
> >>>
> >>> Applied to pci/dt, thanks!
> >>>
> >>> [1/1] dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs
> >>>       https://git.kernel.org/lpieralisi/pci/c/68909a813609
> >>
> >> It's still not in linux-next. Is you tree correctly included in the next?
> > 
> > It's on Lorenzo's branch
> > (https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/)
> > but I haven't pulled it into my "next" branch yet.  Will try to do
> > that today.
> 
> If Lorenzo picks up patches which at some point are merged by another
> maintainer, his tree should be in linux-next as well (and in LKP tests).
> Otherwise we loose some build and test coverage.

Oh, I remember what happened.  I started the merge a while ago and
tripped over the conflict between these:

  dt-bindings: PCI: qcom: add MSM8998 specific compatible
  dt-bindings: PCI: qcom: Add sm8350 to bindings

I asked about splitting the first and if you did that, I missed it,
and in the meantime I got distracted by my E820/EfiMemoryMappedIO
regression.

In any event, I updated "next" with this.  Check my conflict
resolution because I'm not a DT expert:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/Documentation/devicetree/bindings/pci/qcom,pcie.yaml?id=25cfdd48a4bd
