Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421B5B7C0F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIMUND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMUNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 16:13:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99A642D3;
        Tue, 13 Sep 2022 13:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77EC2B810B0;
        Tue, 13 Sep 2022 20:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4B8C433D6;
        Tue, 13 Sep 2022 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663099978;
        bh=OoU2B4RsRfA9DUfDB/pYptFOgRvPjtc5VBMN/lNgZk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=On6Z8T7idhEC6JEh9I9R68lgW+Obr5rWb8751JQlKeY46BeQNrEgbAhtpa6CoEgTv
         gkcByWe1rWPywL/+dH5TSp7UAVJdIgyFrGsopyfn99DZEZBJOenPdzLLDiJQjZ6o2H
         fTpgOhke53ncQlfCsOiBxNNzgcQG96eRUgHZabVxxQDpNrcZeDxL7Dk6qojKoMH7RQ
         9m+HmVKKnYoUGQNq6s1DndBz7ECuDE1ZGvf+8TBjqulo9Ao9IDe3jHUbKbmCo/F7qO
         75c9OfSqyDHQ5Oi76JdBNw7wOgBipqUCirizynYfuGeEE9DPFX3Vpzxj0yzgUz1mrB
         DWSCIy76s6L1g==
Date:   Tue, 13 Sep 2022 15:12:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 02/12] PCI: qcom-ep: Do not use hardcoded clks in
 driver
Message-ID: <20220913201256.GA620427@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910063045.16648-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 10, 2022 at 12:00:35PM +0530, Manivannan Sadhasivam wrote:
> Generally, device drivers should just rely on the platform data like
> devicetree to supply the clocks required for the functioning of the
> peripheral. There is no need to hardcode the clk info in the driver.
> So get rid of the static clk info and obtain the platform supplied
> clks.

Possibly reword the subject line to say what this does instead of what
it does not do?  E.g., "Rely on devicetree 'clock-names' instead of
hard-coding" or whatever.

Bjorn
