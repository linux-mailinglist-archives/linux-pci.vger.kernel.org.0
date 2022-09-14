Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAA5B81B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 09:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiING75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiING7z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 02:59:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B72BB29;
        Tue, 13 Sep 2022 23:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF6EEB815C8;
        Wed, 14 Sep 2022 06:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE4C433C1;
        Wed, 14 Sep 2022 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663138790;
        bh=Whs4IM7U0IGGXZo3pyOaHLLggtXyRjQJNmPd9HwSIX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmUukbaAhnYWX2B+yqopCAhZOaftArJ6p2kTJWhqv3KTJtD16jAfR3xk6MQDZq6vl
         NNyXjyeT6dz90ag2MXDg5vW3BswGsy+VIBrtH6qUqqOn+W9zTGzwWD4d9NEgF+6SiE
         U0sUxG+LrEyRrdjSLZWsGMXeNIwDBoY0kG3Qm/wmOjLBRAXFLONnxhHURq3RKc29ws
         pafB7jYlKAmqSSg3gcVESvZ1Oy7+yTJcFRbUqxIdoaXr2idxg+DqOFSq7FBH9kXBM5
         931CoIl9oAOPjtAd87jLkL0aUANcbVbPABKAJjXgnTHyFVg1WedvYXuITmOB93RUcY
         obam+Ivgx6dSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYMND-0003Cj-16; Wed, 14 Sep 2022 08:59:51 +0200
Date:   Wed, 14 Sep 2022 08:59:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 5/9] phy: qcom-qmp-pcie: turn secondary programming
 table into a pointer
Message-ID: <YyF757ZdlqW4NfYN@hovoldconsulting.com>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
 <20220909091433.3715981-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091433.3715981-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 12:14:29PM +0300, Dmitry Baryshkov wrote:
> Having a complete struct qmp_phy_cfg_tables as a secondary field in the
> struct qmp_phy_cfg wastes memory, since most of the PHY configuration
> tables do not have the secondary table. Change it to be a pointer to
> lower the amount of wasted memory.

Please be a bit more specific.

We're talking about four pointers per configuration and there are
currently about 15 configurations.

Is the added complexity really worth saving 400 bytes on 64-bit?

Johan
