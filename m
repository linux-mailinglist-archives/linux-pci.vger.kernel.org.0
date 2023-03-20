Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354106C0D47
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCTJ20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCTJ17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 05:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2540CB;
        Mon, 20 Mar 2023 02:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD36612D4;
        Mon, 20 Mar 2023 09:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9D7C433A0;
        Mon, 20 Mar 2023 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304442;
        bh=rCKrNjd3yw6vYapn4P5njBlAE6teSv1Bf+1tVsguCMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsisnhAgrDKYTQUBZVhCaTuo4xZHkVHl5076Fk7zLApJ55eWKS9K5j6UUuJYzpBCW
         tpxQnrlfkK5dHzatJRPXm+b4jpDDoGimzOoUgaObzPs1unwqJdL9Mudi46bsy6Yyj/
         WrqhgyLB7NENjQNTsPDS1r0DPuYXqxFeQXI0cUxBgL0Q0hwNyO8ZMLvPALQZr+KWeP
         drbGDYbe/RWRVyH03u09M0C/W1p3Bbbw4gv1bzJ5z+8Ua/7KTdOO8sl8aEw6H+k6IR
         PVSE2sxhd5IrvjwOoJZI/vHPmCSzLhxMvRdzXbXM6X+cSUYbjbSkEJN5RUm9FcgUyD
         WphR7cavQmaFw==
Date:   Mon, 20 Mar 2023 14:57:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 12/13] phy: qcom-qmp-pcie: Add RC init sequence for
 SDX55
Message-ID: <ZBgm9QxXWJWpEuIl@matsya>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
 <20230308082424.140224-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308082424.140224-13-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08-03-23, 13:54, Manivannan Sadhasivam wrote:
> Add PCIe RC init sequence making use of the common init sequence. The RC
> mode additionally requires REFCLK_DRV_DSBL bit to set during powerup and
> powerdown.

Applied to phy/next, thanks

-- 
~Vinod
