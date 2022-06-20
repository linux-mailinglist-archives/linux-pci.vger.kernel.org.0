Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479F6552163
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiFTPms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiFTPmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 11:42:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9619286;
        Mon, 20 Jun 2022 08:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10BD3B8120C;
        Mon, 20 Jun 2022 15:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C57C3411B;
        Mon, 20 Jun 2022 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655739763;
        bh=DjTm5z1TckD7/FnLfGxter2Pb89zCQ7bxMD/6sv1abI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbD9HC4D4MyLUdpxq/CvkBrVrQijnYDnvpn3aPHs8mZMw5at8hflfNeEYMNMnQnrv
         y9cUViFT8x189DDaoHMvKOYgaCWLBk8f3tGU31GS2Iz7065eDNVOO4E2WtKizJphlU
         +RlL0VB+hpZS4I1z3mdgd5laOqISUFywqHfvh7Fs1hHO4qFhJHErA7yfJf3iW+gskG
         OIz2EaIcnBDE952t6PvDDbsh/Dmu9+m4c0kubHjb38ckztMRgBz7tqr9T6WiCF8NcD
         vegvHd+caOxvnPAOVoj4dwZq94emOFROERCMVWofMvBWpeOoSdXUy33mMzhjSrJciH
         TSYxtYJofFsqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3JXy-0003Fo-LH; Mon, 20 Jun 2022 17:42:39 +0200
Date:   Mon, 20 Jun 2022 17:42:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Drop unused post-init callbacks
Message-ID: <YrCVbhXXEzDAdZm1@hovoldconsulting.com>
References: <20220620150759.11507-1-johan+linaro@kernel.org>
 <CAA8EJpr02CGRLyafkVV6V=0mchbfQga2=YiE_MkhuLE9veUj3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr02CGRLyafkVV6V=0mchbfQga2=YiE_MkhuLE9veUj3w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 06:29:17PM +0300, Dmitry Baryshkov wrote:
> On Mon, 20 Jun 2022 at 18:19, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Drop the unused post_init and post_deinit callbacks that were added for
> > the now removed pipe clock handling.
> 
> I think the IPQ60xx PCIe support is intended to use post_init
> callback. See [1]. That is the reason why I left the post_init in
> place, while reworking the pipe clocks handling.
> 
> [1] https://lore.kernel.org/linux-arm-msm/a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il/

Ah, ok. Let's keep them then.

Johan
