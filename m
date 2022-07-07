Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B054A56A488
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGGNyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiGGNym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C45C969;
        Thu,  7 Jul 2022 06:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62CF3621ED;
        Thu,  7 Jul 2022 13:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B212EC3411E;
        Thu,  7 Jul 2022 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201999;
        bh=N37AT1l4FTWK6oQ7foUlDTwImtgc9JahL3XVae3vWh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubwxzPzeIKk1CJFQ+A8DyQc/YlyPm83AFhAFsNkSOJPZjZ4x7smXIxvjW4snzKMAs
         D1DUWEDGLCsaLlEMQWafW5WoUCPY99pJ49kzZWSX5hGa3POWG1VAi3nqt2ao5kySGn
         JDQK5LA5Yt5k5G41xZs4bHVHsL2yE8p4VOaH31TEgr0phAhbvhH8oIa+ZMVVVH7ICq
         l0IOyfLiq0Xtsv9EkYPRLEsYT3pXpW11JuHiAZdfHj1+A0NHbPo6TOfQYWyeS3ZkEu
         UAfRPek6IFErFcQmMZRnywea8PnaDhDct+i5fUA8VUq5UhY7csKamL5bFxLPQ+WA7n
         WrOro+Wlm31Xg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o9RwX-00019G-Ue; Thu, 07 Jul 2022 15:53:22 +0200
Date:   Thu, 7 Jul 2022 15:53:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Fix msi-interrupt
 conditional
Message-ID: <YsblURZDD08fj1Ih@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-3-johan+linaro@kernel.org>
 <cab173ce-9c7c-9985-277c-3498d82b8400@linaro.org>
 <2fbe9cf7-7ed8-ccc8-b0bc-26d358cec927@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbe9cf7-7ed8-ccc8-b0bc-26d358cec927@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 04:41:02PM +0300, Dmitry Baryshkov wrote:
> On 07/07/2022 16:34, Dmitry Baryshkov wrote:
> > On 29/06/2022 17:09, Johan Hovold wrote:
> >> Fix the msi-interrupt conditional which always evaluated to false due to
> >> a misspelled property name ("compatibles" in plural).
> >>
> >> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on 
> > msm8996 platforms")
> 
> Ugh, I was thinking about a different chunk (which also has this issue), 
> so please ignore the Fixes.

Heh, yeah, I was pretty I had already added it for the issue in mainline.

Johan
