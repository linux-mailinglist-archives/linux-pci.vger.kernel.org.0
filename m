Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE05262E5
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380655AbiEMNSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380638AbiEMNSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D081E3CE;
        Fri, 13 May 2022 06:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7717F61FFB;
        Fri, 13 May 2022 13:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FC7C34100;
        Fri, 13 May 2022 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652447850;
        bh=T1QQEzF5u+mr9W1+YFwxQKA1GpTReldFhGanLnCFGkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drfPPSCy5Lgc7j0aijKhr/HDjQG5sKhwTgnQt4RskjZgLF1t5VwdMXxLeT9CVpi1v
         o6QwhLoPH6KvwD5pTccd4ezKFDI0aGNJQcB9CN1KXLavzzPjRng/Xo9SLs9983GX1F
         fUl5ft6GFp5KtclE0UhtQWSgNBmgsRwgdownnxq/5wGLe/WGv25l6Wt99UbEBywpt+
         W5WaIl8gFAgYstHKlOLXqkCmLmH7j9f/vyR4OP9SdA5eoTcWMsYZj5qZFk0yYYpLMM
         A68vN0jRmBDayc6RGKBr0S/iseJC/cJmCH+E+CpkRZT8d2wnlaxDtMr2j6o5NIq12j
         ZsqgxHWmRms2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npVAd-0002uJ-Vo; Fri, 13 May 2022 15:17:28 +0200
Date:   Fri, 13 May 2022 15:17:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <Yn5aZ8Hpmf0PpqKJ@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <Yn4dvpgezdrKmSro@hovoldconsulting.com>
 <c35595ff-f789-5452-d9a8-b5dfcb920141@linaro.org>
 <4ea9b1f0-d9f0-cb9f-4b0e-d66606130061@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea9b1f0-d9f0-cb9f-4b0e-d66606130061@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 04:08:30PM +0300, Dmitry Baryshkov wrote:
> On 13/05/2022 15:39, Dmitry Baryshkov wrote:
> > On 13/05/2022 11:58, Johan Hovold wrote:

> >> I've been using your v7 with an sc8280xp which only has four IRQs (and
> >> hence 128 MSIs).
> >>
> >> Looks like this version of the series would not allow that anymore.
> > 
> > As a second thought, let's relax parsing needs.
> 
> Hmm, with num_vectors being specified in the qcom cfg data, this is not 
> required anymore.

Right, but I'd prefer it the other way round; to use devicetree to
describe the system and not duplicate that information in the driver if
possible.

Johan
