Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56743644280
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 12:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiLFLvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 06:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiLFLvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 06:51:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0827DED;
        Tue,  6 Dec 2022 03:51:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A836B819BB;
        Tue,  6 Dec 2022 11:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8D6C433D6;
        Tue,  6 Dec 2022 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670327500;
        bh=s4K6bUN232iqgGLvJebgGUOXpM0Nekv+4mjWez6DWJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiES+w/sgACehabQ6uDUpA2H2rgqaWd2j8ft6FggvWDX77Skw6L7pY7Z+A7LqWQUO
         dSKU50T7pQCD+ueZThDG0C3Xmdp6qggNQGgKEgu+u0GlFBeJ1gG52mklvgTC+fn/Db
         X3wbHEvReFDEc1gctm7Wq5A3oKuJLodsoMvhgArGsKIS+gCF5qlPKLT9Y7Ju1zF0f8
         HoKdasAplW9SjPPt1jgPd/kGvxPPWKeEKjpPktupwDv5VRZqRZGez5h0JbZEMTlYgp
         zyR36nP8kZ5qj+R7etGVXufEpWtx1EIBM6tjzmyJsE6QImfdASM9kodNcpkywY7gDM
         C5NwERGeObbcw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2WUF-0000Vi-IY; Tue, 06 Dec 2022 12:51:47 +0100
Date:   Tue, 6 Dec 2022 12:51:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
Message-ID: <Y48s09HMMkb34kRn@hovoldconsulting.com>
References: <20221205094530.12883-1-johan+linaro@kernel.org>
 <Y48f4ktAwsPBW60y@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y48f4ktAwsPBW60y@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 06, 2022 at 11:56:34AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Dec 05, 2022 at 10:45:30AM +0100, Johan Hovold wrote:
> > Devices on some PCIe buses may be cache coherent and must be marked as
> > such in the devicetree to avoid data corruption.
> > 
> > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > Lorenzo, the corresponding SC8280XP DT fix is heading for 6.2 so it
> > would be nice if this one could be merged for 6.2-rc1 (or -rc2) as well
> > to avoid the corresponding DT validation warnings.
> 
> What's the commit base for this patch ? I tried applying to my pci/dt
> branch to no avail, please let me know and I will merge it.

That should be pci/qcom which has 3a936b2a5a58 ("dt-bindings: PCI: qcom:
Add SC8280XP/SA8540P interconnects").

Johan
