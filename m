Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615C5BE809
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiITOGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiITOGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 10:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5058B5A;
        Tue, 20 Sep 2022 07:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE60362A3D;
        Tue, 20 Sep 2022 14:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57459C433D6;
        Tue, 20 Sep 2022 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663682751;
        bh=nYzrdrHjs9RmPAKVsaX7dli+NsPGeJ8cpNWtIh1y4rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X75kw4i4QdgZBaLCHe7ouuuI0Gi8fX6FK/+RC3ZXNpZFjglT8KoAgyKivg821G5qt
         CjZn11A8epi3YF1BO1Al4iCTKUvhVxrH3w3ZriOVZyZZUmHHkiUJztW5UupfU+t7pV
         zy2jP02f5zTWiXHgnJjVYzFDLdGfPAVjvVA/do1E7fw1pgpLklobewbk8pPZhqWSmk
         BFqdJObZNje0smXp+o3Jw7xOi4ZAM2zevBeY788xMntZEOcfgVYtLiGEXKtCNreD5Z
         yFB2lONCAG2lNzD0HoRRXYa1lxaznFRtMXKIgfyUEI2bf6cKAFelYvVuskX/3r9u52
         zCaVaSPmI3/SQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oadsn-0000Am-S4; Tue, 20 Sep 2022 16:05:53 +0200
Date:   Tue, 20 Sep 2022 16:05:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Message-ID: <YynIwRVglGGm1To3@hovoldconsulting.com>
References: <Yyl+PNcbtSwzlgvh@hovoldconsulting.com>
 <20220920133754.GA1102995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920133754.GA1102995@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 08:37:54AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 20, 2022 at 10:47:56AM +0200, Johan Hovold wrote:
> > Hi Lorenzo,
> > 
> > On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > > is useful for multi-platform kernels as well as during development.
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > 
> > > Changes in v2
> > >  - rebase on next-20220720 (adjust context)
> > >  - add Rob and Mani's reviewed-by tags
> > 
> > Have you had a change to look at this one since you got back from
> > vacation?
> > 
> > I believe this should be uncontroversial as we already have other
> > modular dwc drivers and there's no mapping of legacy INTx interrupts
> > involved.
> 
> I'm not Lorenzo, but was there a conclusive outcome to the thread at
> [1]?  The last thing I remember was that a buggy endpoint driver that
> failed to unmap all its interrupts could cause crashes if the PCIe
> controller driver was removed.

That's not so much an argument against allowing the PCIe controller
driver to be unbound as it is an argument for preventing endpoint
drivers from being unbound.

And they generally need to be able to unbind due to hotplugging, right?

> Making the driver modular is essential so distros can build all the
> drivers and users can load the one needed by their platform.
> 
> Making the driver removable is useful for developers but not for
> users, so I don't see it as essential.  Developers are in the business
> of developing and can easily carry a trivial out-of-tree patch to add
> removability if needed.

Having modular drivers that can be unloaded is a debugging feature. I
believe I already posted this quote from Linus:

	The proper thing to do (and what we _have_ done) is to say
	"unloading of modules is not supported". It's a debugging
	feature, and you literally shouldn't do it unless you are
	actively developing that module.

	https://lore.kernel.org/all/Pine.LNX.4.58.0401251054340.18932@home.osdl.org/

And no, keeping such patches out-of-tree is not an option as it prevents
sharing them with others and they will quickly bit rot.

> If removability is actually safe even if endpoint drivers aren't
> perfect, then I don't object to it.  But if it's not always safe, I
> don't think the argument that "other drivers do it" is strong.  I'd
> rather make all the drivers safe even if that means making them
> non-removable.

If we have buggy endpoint drivers we need fix them regardless. Allowing
this fundamental debugging feature will even allow developers to catch
those bugs sooner.

And this is really no different from any other type of bug in endpoint
drivers; a failure to deregister a class device on unbind would lead to
crashes due to use-after-free, etc.

> [1] https://lore.kernel.org/r/20220721195433.GA1747571@bhelgaas

Johan
