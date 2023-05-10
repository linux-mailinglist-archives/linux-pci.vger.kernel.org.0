Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF116FD8BE
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjEJH5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjEJH5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:57:50 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC31BF4;
        Wed, 10 May 2023 00:57:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 833672B0681C;
        Wed, 10 May 2023 03:57:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 03:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683705438; x=1683712638; bh=lu
        YuF/JxvULVmeDkbLyw1Zb3ZU/LU2UPbqzZwwIFgXw=; b=tJa8a0KbkrvxLGCR7o
        RenGyf/IB6qR1pixLlCkrrhzyY4nd6Hgh0GBNTsFmBpS0yMjL74a8jbaxz46Idci
        SbSk8gDCdjUF9MktAUpyyVurrve2RX/OUlZjer7wv7lNpvic911D/4E4OEUyg5Yl
        CsNBemqmjUcJsRVRfTneLAqz0mVFo75fWmzQg8OUbugSCgDvE8FdJDVbm4Dbqmoj
        1YpZKNl8oNskPtS6BxXH1Lq3mUjh400ZR/q5wuj6GCk5qtV6r3N/A94Sxu0Mv5Nc
        saY5yq+lnqIzpNAnBPijBvK8V0ZnoKZomnU0ISU4+RW7lk093hW9aX5chyoEv5kR
        PMtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683705438; x=1683712638; bh=luYuF/JxvULVm
        eDkbLyw1Zb3ZU/LU2UPbqzZwwIFgXw=; b=IojDGxNtfD0DJ2+CDtWHQSSGfufa3
        mL3zg7qEiV1DwRNj71zq5VhPgXz26dFRGtLgymYCP7w5nSNkImbCcIwUctOOm7/B
        ILWPc13tLoAl3sR8mTTKHxmONTLbjgfmpSWPs1lOuK8U9zXaZi11/wdQnTnqsNa0
        fk9xG4zZO8A/FbAQfy7FJOgON5rUl9is5pA99i6YUy6B0NoO3wsQm+3c64IcgMpn
        lFCY54lj9He2nNNY8D5OKNO+zkZcWTMElhVf+R6m4KGjeXdzVCUDRhD+BDi0wTeA
        P/w+qzj0IDnU03FOBPAkIyURywhEcUJomw7TS5cJzS2/BCp/dOUZTwQ9w==
X-ME-Sender: <xms:XU5bZMf7Es_B0mwWdMR6GPrBKUfqIBy8Fv2iQcwsFpJEzP-LUx33qg>
    <xme:XU5bZOMZtC6bj_qHm8gMWnmPqo6h9LwJqGP9JE4E7mQwNeBHLJ3ZhwG-0B2G4kmbj
    5GCo-AXCaGUyw>
X-ME-Received: <xmr:XU5bZNhPlWCTwCYTsx7F-DVagjVKZm_GDne2UCLTFm9eOeG9JFudqwkmx0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:XU5bZB97UnXv30emiW9sr70rvQi2LVWwvNxvEf-JAoLlrxnFx0dAJg>
    <xmx:XU5bZIsKlK22zhz6WYqNwgO7ZnD9qhkdh6gJmsYnXuZzK5TdRaKDqA>
    <xmx:XU5bZIH7i6ymzx6TM4i5eFMSOp4qcaSjBHhPECWvkwh2qGSziJl6Cg>
    <xmx:Xk5bZB6scUFm3rT8fS8eGVX945sSW2Q7ZKiIHhmaToKgTntgMO0ltQpY_qg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 03:57:16 -0400 (EDT)
Date:   Wed, 10 May 2023 09:57:14 +0200
From:   Greg KH <greg@kroah.com>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     linux-pci@vger.kernel.org, robh@kernel.org, heiko@sntech.de,
        kw@linux.com, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
Message-ID: <2023051014-foe-multiply-ffff@gregkh>
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -38,6 +38,10 @@
>  #include "../pci.h"
>  #include "pcie-rockchip.h"
>  
> +/* bus_scan_delay - module parameter to override the
> + * device tree value, which is 0 by default. */
> +static int bus_scan_delay = -1;

Please do not add new module parameters, this is not the 1990's anymore.
We have per-device settings everywhere, this makes that impossible.
Just use a DT value, if it is wrong, then fix the DT value!  No need to
have the kernel override it, that's not what DT files are for.

thanks,

greg k-h
