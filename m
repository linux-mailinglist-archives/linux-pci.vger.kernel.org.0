Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEB602F38
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJRPLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 11:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRPLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 11:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704A50B86;
        Tue, 18 Oct 2022 08:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA3AB81F68;
        Tue, 18 Oct 2022 15:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018FC433C1;
        Tue, 18 Oct 2022 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105865;
        bh=QiYNM+K9UffyPq7bB1q2XxVJ5g4+7nvu943fwEjrsBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER3B+QxfDyT+DCKKNpiGHKNCMudOdLCWJulUxF1LxYPzeuc1LwWN9Cn8hAC8PCCyJ
         eAkY3eQUKqa/LtXSBAx39JjFvAOFXYGAbGSmBnSC3d+NJUFfP5JJvNyKZ2OkHlc7/r
         kO6PLTl1iXYAlgC7bkPqbMCONcC5hlyG9TsdlZgxe1L56p4mc7PL39D9a7s4652GUg
         Y9GWHzdrQ7CQ/3xqZAsfnDzFVQ0gk1sA0DpV8TqXucINREdHsespKV43/TCMs61M+C
         I3SwErhv1usOs7KNa1O/bPLDF+fMwbZuI7bnsy9YvrFf3G4ltFvDrhrQWItVl/yXuH
         Q/4XXRBxEOOJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okoF3-0005eX-GA; Tue, 18 Oct 2022 17:10:54 +0200
Date:   Tue, 18 Oct 2022 17:10:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for modular builds
Message-ID: <Y07B/cHkyvw3M4NV@hovoldconsulting.com>
References: <20221017114705.8277-3-johan+linaro@kernel.org>
 <20221017173422.GA3715509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017173422.GA3715509@bhelgaas>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 12:34:22PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 17, 2022 at 01:47:05PM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> 
> There are two different goals here, and there's no real reason to
> bundle them together:
> 
>   1) Make qcom a loadable module.  This is a hard requirement so
>      multi-platform kernels don't need to build in all drivers
>      statically.
> 
>   2) Make qcom unloadable.  This is a high want, possibly even a
>      requirement for developers, but is not really a big issue for
>      users.
> 
> There are different changes required: 1) requires the Kconfig change;
> 2) requires .remove() to be implemented.  Since there's no requirement
> that these be done together, let's split them into separate patches.
> 
> Then we can make sure that at least 1) gets done, and if for any
> reason 2) isn't safe or breaks something, we can at least bisect and
> if necessary revert it without losing 1).

Implementing 1) in itself requires more than simply splitting this
patch. And I don't think we should be making life harder for developers,
as well as users assisting during debugging, by going in that direction.

We have tons of modules in the kernel and very few that cannot be
unloaded. Anyone who doesn't trust root to not unload modules can
always disable unloading completely using CONFIG_MODULE_UNLOAD.

Johan
