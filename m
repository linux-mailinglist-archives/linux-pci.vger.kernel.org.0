Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49E583E89
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiG1MTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiG1MTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 08:19:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FE46DAC;
        Thu, 28 Jul 2022 05:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE7E1B82432;
        Thu, 28 Jul 2022 12:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5207DC433C1;
        Thu, 28 Jul 2022 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659010770;
        bh=SkS6G0rptpwlgeSV0bISNL3/MaKjQgocq5LaHbB8Mb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2uohG5RUUGwrkh7g6QgjZ5er8K8kvInqsnMXjRoUgM2loTv0i1+C/JEUz5tBMfZU
         Y3oMw+Bq4m9SE9gPD8WK2JBpZWkmYJsYWoFm31NXm9KnPi19l0bcBKVnpoFOXKnOCC
         G9DLdUI1mc4qq0FOsP+SoAlPpPPnmRRdIOjw2GRKF9989W29sCX7LyfkNZHOH9gF9j
         c4bQTTtzOogOwjQewaJNmEtALnKRYn3I+O+gNhAjhUYm0IwKPAKV6+w5dncEmAj3A8
         4nQAdSlreHtX46Mv9ne8GeFVDPi8EdIbXtLR9xXMb48PpqvFhmCFbyhlALR3DrHHsA
         oxcyrcdQHlqJw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oH2UR-0008JE-Su; Thu, 28 Jul 2022 14:19:43 +0200
Date:   Thu, 28 Jul 2022 14:19:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Message-ID: <YuJ+31mJNHosH5i5@hovoldconsulting.com>
References: <20220721193513.GA1747404@bhelgaas>
 <20220727200257.GA220948@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727200257.GA220948@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 27, 2022 at 03:02:57PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 02:35:13PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > > is useful for multi-platform kernels as well as during development.
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Applied to pci/ctrl/qcom for v5.20, thanks!
> 
> I'm going to drop this one for now, since the module vs remove
> discussion [1] is still ongoing.
> 
> This patch actually makes it both *modular* and *removable*.  I think
> the modular part is uncontroversial and valuable by itself.
> 
> If you want to just make it modular and *non*-removable, I think that
> would be fine and we can add removability next cycle if we think it's
> safe.
> 
> [1] https://lore.kernel.org/r/20220721195433.GA1747571@bhelgaas

Nah, I prefer we conclude that discussion so that hopefully this can be
merged as is.

Johan
