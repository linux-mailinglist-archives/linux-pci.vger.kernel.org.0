Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30BB7535C0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjGNIzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjGNIzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 04:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F25198A;
        Fri, 14 Jul 2023 01:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 315DA61CAD;
        Fri, 14 Jul 2023 08:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BACC433C7;
        Fri, 14 Jul 2023 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689324929;
        bh=xdDf7J7wabwwPPB+N1BvY/uSNfnGVhm7ZROnIm0p/5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMgYoOahrvkogcf5KQkChhRaST3bloYhS2133a16LmXrB+jLLypPWfg5s3h980Q7B
         dPw70+y61HTYkjwcD9HaqTJuO7Kz7V8Ura3Owh9wU/bz4ixATwQABqwf6RHy0O3JJ+
         rhsYYh+XDJ6LbdGjOT5VihuKX+hl0pcmeL0yFgaunyt2kui0yb4QqQEnron+jGQOGz
         nQl04P5F7xw4j4Ory6Dy5RhWoVeJRUCoNQIENhMeRZ4NjC7ekmbHKNv47wnsRdB0Ua
         LL4jdDay9N0m89Dn1Z3/JjTr+fmkMud94GpnIfIBuZFnOizgeJVR0eHhcgTJ+E4kiy
         8VQvGNXLEzJmg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qKEaH-0006W1-29;
        Fri, 14 Jul 2023 10:55:30 +0200
Date:   Fri, 14 Jul 2023 10:55:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZLENgbMe4YVOINRQ@hovoldconsulting.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
 <20230710170608.GA346178@rocinante>
 <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
 <ZK7m0hjQg7H5rANZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK7m0hjQg7H5rANZ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 11:15:54PM +0530, Ajay Agarwal wrote:
> On Tue, Jul 11, 2023 at 08:52:23AM +0200, Johan Hovold wrote:

> > All mainline drivers already start the link before that
> > wait-for-link-up, so the commit in question makes very little sense.
> > That's why I prefer reverting it, so as to not pollute the git logs
> > (e.g. for git blame) with misleading justifications.

> I am developing a PCIe driver which will not have the start_link
> callback defined. Instead, the link will be coming up much later based
> on some other trigger. So my driver will not attempt the LTSSM training
> on probe. So even if the probe is made asynchronous, it will still end
> up wasting 1 second of time.

Yeah, I had the suspicion that this was really motivated by some
out-of-tree driver, which as I'm sure you know, is not a concern for
mainline.

Vendor drivers do all sorts of crazy stuff and we don't carry code in
mainline for the sole benefit of such drivers that have not been
upstreamed (and likely never will be).

So again, I think this patch should just be reverted.

If you want to get something like this in, you can send a follow-on
patch describing your actual motivation and use case. But as it appears
to boil down to "I need this for my out-of-tree driver", I suspect such
a patch would still be rejected.

Johan
