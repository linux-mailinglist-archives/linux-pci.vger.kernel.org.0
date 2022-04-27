Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E85112BC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358951AbiD0Hpy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 03:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358998AbiD0Hpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 03:45:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A337C790;
        Wed, 27 Apr 2022 00:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1E4AB82524;
        Wed, 27 Apr 2022 07:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B07C385A7;
        Wed, 27 Apr 2022 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651045358;
        bh=cavqywrPF0KyQusxmwRZcnnrnFetZ2Ev826pxFogUGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Seusk21xJnYrzwhKK17gD7lnd8Segt158qh1BtGQVxkqhB7K/jZ9/aeNLYZ+nnX0s
         A5Qz7Zb8rUupKOBRskUgjp18pgBRVZ21PphE5TRQBvNgxD89Zne3m1fYJfLCqy/Jdb
         Ocb8I2BVAe31wAK3UE/CQMos+JpI1uDiFJ7YMWSShNfE4G5PvaaPPd0YXcslfDe/eD
         j8NvXOmIHWfV4WSRQJ0O9XM5a7udhg9PRE5AavfdFkbt2J7dFQCYEJ43AinqR6dgmD
         uHvYwSmdQlUrAh/1XYtCmBeThAZFEk9WHdkNOCKp1v6Px5pYyxY1y3ypxCyW4jFgyB
         iGFFH8p8PDE8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1njcJr-0004T2-8O; Wed, 27 Apr 2022 09:42:40 +0200
Date:   Wed, 27 Apr 2022 09:42:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Fix probe error paths
Message-ID: <Ymjz76YFLU28CUzn@hovoldconsulting.com>
References: <20220401133854.10421-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401133854.10421-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 01, 2022 at 03:38:52PM +0200, Johan Hovold wrote:
> This series fixes a few problems in the probe error handling which could
> cause trouble, for example, on probe deferral.

> Johan Hovold (2):
>   PCI: qcom: Fix runtime PM imbalance on probe errors
>   PCI: qcom: Fix unbalanced PHY init on probe errors
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Any comments to this series? Does it need a Qualcomm maintainer ack to
be merged? Bjorn?

Johan
