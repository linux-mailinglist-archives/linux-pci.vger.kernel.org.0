Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C26565882
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiGDOVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDOVG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 10:21:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217B10B5;
        Mon,  4 Jul 2022 07:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96067B8104A;
        Mon,  4 Jul 2022 14:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB7C3411E;
        Mon,  4 Jul 2022 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656944463;
        bh=12vzbNxNUnFOcp03yedceqZx1z1ZYE4M2dVAZ89UotM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6p4JmIu5nOOrSEmp2cDT9G8ifOIRlFhh5ky5zveJCGFCzSWMu67zL9jSPMf1YxBY
         3e63WXwyy+SH3Dair7MaPxlg4BGU5RJHDQELy18y0gTklCzsca/v9/EMU3OWW5Fxro
         cdwitAqbl6u2dtoGJK523s718hsFw4ALC0tSxZ3Ak46CKMbovkg7vPOJq93N6wGLw5
         7SJdisdSm8DFJ7KlTDOYx2AGv5nd0YWn0tV73PqwDvCWFr8Gb/EXl7hPYlcNtFgEt5
         SJdj92agragpITx9sBYrdR19v+FW8SuKN9wyEYq4Y8ZMNcvwVE65lTou36rAZtoVCw
         gHDIfK2m98gvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8Mwh-0006yf-0j; Mon, 04 Jul 2022 16:21:03 +0200
Date:   Mon, 4 Jul 2022 16:21:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: PCI: qcom: Enumerate platforms with
 single msi interrupt
Message-ID: <YsL3T8GjDzuxfRtP@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-4-johan+linaro@kernel.org>
 <c20ba06c-b37a-e91c-84c6-6d2147bb2478@linaro.org>
 <Yr6ykvru52aDZhFm@hovoldconsulting.com>
 <20220701183819.GB1284915-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701183819.GB1284915-robh@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:38:19PM -0600, Rob Herring wrote:
> On Fri, Jul 01, 2022 at 10:38:42AM +0200, Johan Hovold wrote:
> > On Fri, Jul 01, 2022 at 10:33:35AM +0200, Krzysztof Kozlowski wrote:
> > > On 29/06/2022 16:09, Johan Hovold wrote:
> > > > Explicitly enumerate the older platforms that have a single msi host
> > > > interrupt. This allows for adding further platforms without resorting
> > > > to nested conditionals.
> > > > 
> > > > Drop the redundant comment about older chipsets instead of moving it.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > 
> > > This does not exist in linux-next, so it should be squashed it with the
> > > previous series.
> > 
> > As mentioned in the cover letter this depends on the MSI series that has
> > unfortunately not yet been merged.
> > 
> > That series is self-contained and ready to be merged, so this follow-up
> > does not need to be squashed in.
> 
> I suspect that Bjorn would rather squash these in.

Sure. Squashing in the compatible-conditional fix makes sense, but the
motivation for this one is the SoC added by this series so I'd argue
that it belongs here. But either way is fine with me.

Johan
