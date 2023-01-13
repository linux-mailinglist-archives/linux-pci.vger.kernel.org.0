Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7E669993
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 15:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbjAMOHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 09:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240798AbjAMOGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 09:06:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604BCFC;
        Fri, 13 Jan 2023 06:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6501B8215D;
        Fri, 13 Jan 2023 14:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3437EC433EF;
        Fri, 13 Jan 2023 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618611;
        bh=RTvuy+dTqPShiRNonoOL20JdR0sMfhjyNaV/ObiJjNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cBXyW3TB7xwWQEdHbF0HBJVQWmAP09DEFS5FsjhH5+QpSafAaJuZ/eR8/C0DcJvxQ
         LVAv9hp5CZKm/JWaMXfSqMyPY4Fh3Vza2Gj8U2jHVfoVVXs3BvD50uH8zGuDpWjASS
         X2o8LKldguRLZWRwF4HTVaLXjHpCT5x4YoyRQATVjXAxPpxUh49BIEDtQTC7xd9t0k
         OzDxLKXQQwq2ScW+0sxBBeQPF6M4zch8lbyuDMgmhoevhSY4eIJgIzpQmh+0AyCmPY
         BoLspTGFKt/kwtP8FSTAsT0Xwk9Ph4m4MjwJQRHjWriu3LHc0JJ454hasio35v1rDH
         sMVS0cnzD5NoQ==
Date:   Fri, 13 Jan 2023 08:03:28 -0600
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
Message-ID: <20230113140328.GA1836008@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7831a607-db55-274c-8fba-d01d5bac3a7a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 10:02:27AM +0100, Krzysztof Kozlowski wrote:
> On 30/12/2022 14:42, Lorenzo Pieralisi wrote:
> > On Wed, 9 Nov 2022 12:32:02 +0100, Krzysztof Kozlowski wrote:
> >> qcom,perst-regs is an phandle array of one item with a phandle and its
> >> arguments.
> > 
> > Applied to pci/dt, thanks!
> > 
> > [1/1] dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs
> >       https://git.kernel.org/lpieralisi/pci/c/68909a813609
> 
> It's still not in linux-next. Is you tree correctly included in the next?

It's on Lorenzo's branch
(https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/)
but I haven't pulled it into my "next" branch yet.  Will try to do
that today.

Bjorn
