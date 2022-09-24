Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BCD5E88A0
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 07:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiIXFsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 01:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXFsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 01:48:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2784B12206C;
        Fri, 23 Sep 2022 22:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8B98B80B3C;
        Sat, 24 Sep 2022 05:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC56C433D7;
        Sat, 24 Sep 2022 05:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663998498;
        bh=kDO1j81r5vdzKPwMHSxyrWHxgWdkM8cvZeZ9JggJ8Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hysZq40+JxDOCHrPadbWELgM00BKYV540TWbj64uWXzL2zG7ZIy37OTAR13JkcCZd
         9D14qyzlvcKKCnH+NcAAh4D8gZ3my14vdLOsUDp537ttS4clznj3LiYm/iwpsR8R9I
         AMtOIGmJCD3g6k5+rMs00ttlo/Yzg2LtlzsFZVdR33+ww8G46zybIzfIZhmk5k0hJ1
         HhPfvByTEX2IqisE9PNf6W3xZSgam3s57oXPrOl2HZh3xJzvj0oD2OhRiktMS0CCt1
         uk40XZeWEpN4qjYa3A4liPggHU8gRQh0ahM6G+rFb922+fp+pfioL+LJKGMuD6//0o
         i0Kx1dy7Wyvmg==
Date:   Sat, 24 Sep 2022 11:18:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] PCI: qcom: Support using the same PHY for both RC
 and EP
Message-ID: <Yy6aHB6qc/pHEZi2@matsya>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
 <YyF5SJASdCJWcPaX@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyF5SJASdCJWcPaX@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14-09-22, 08:48, Johan Hovold wrote:
> On Fri, Sep 09, 2022 at 12:14:24PM +0300, Dmitry Baryshkov wrote:

> > Changes since v2:
> > - Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
> > - Changed `primary' table name to `main', added extra comments
> >   describing that `secondary' are the additional tables, not required in
> >   most of the cases (following the suggestion by Johan to rename
> >   `primary' table),
> 
> This wasn't really what I suggested. "main" is in itself is no more
> understandable than "primary".
> 
> Please take another look at:
> 
> 	https://lore.kernel.org/all/Yw2+aVbqBfMSUcWq@hovoldconsulting.com/

Am not sure example quoted there was very initutive:
"as the tables can be referred to as

	cfg.tbls2.serdes

instead of
	
	cfg.secondary.serdes_tbl;"

I would agree with Johan that primary and secondary are too long, but
that tbls2 is not very intuitive either...

Maybe shorten to pri/sec... any better idea?

-- 
~Vinod
