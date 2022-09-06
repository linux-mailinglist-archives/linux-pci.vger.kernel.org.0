Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADF5AF69A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIFVIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIFVIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B932AE9DA;
        Tue,  6 Sep 2022 14:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30E2616DF;
        Tue,  6 Sep 2022 21:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEEEC433B5;
        Tue,  6 Sep 2022 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662498495;
        bh=qXXAYgKTIRD2l23CsbtEC48/4YIxrzNRLygN3m+wefs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBF1vQSL6Yd7yZlDJbTVkXHugwYdrpjj+YFqseCd1wcSfBRPTn1uI/gA1PYtcNvVt
         Nj8QSyiacbLu9nKLvo3IK/idDhpTWLkztDMks302QmoPQiEYgreB42QiHamfS/w38n
         z4/I5BT0hJRN7v2UGn27irdWPSjnaqTnwU+FE8dU+mFsZKhAXbMYV1id/TIyq0lRgn
         WmDw0oHtL3R3VMHVGkZcQDHcVa/vAB0TturZjp3V8B55giMLVXl2Lm/YxNU5JaO7FI
         D5n3k20cny4CwHWjfG4K96jYAe9sKquJAGHYsZd4+RGSoz/DAuLzoSH+FyhyqMyvVP
         upuEfgiudoMcQ==
Received: by pali.im (Postfix)
        id B523372C; Tue,  6 Sep 2022 23:08:11 +0200 (CEST)
Date:   Tue, 6 Sep 2022 23:08:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
Message-ID: <20220906210811.5kzdq66eeeauk2d3@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 06 September 2022 13:43:00 Dmitry Torokhov wrote:
> +	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
> +				      "PCIe device power control");

Just unrelated thing, I know it was there before, but I saw it just now
and have to comment it: This is absolute nonsense name. "reset-gpios"
device tree property specifies PERST# signal pin (PciE ReSeT) as defined
in PCIe CEM (Card ElectroMagnetic) specification and it has absolute
nothing with PCIe power control.

My suggestion for maintainers would be to remove this critic name at
all as it would just mislead other people reading that code.

> +	if (ret) {
> +		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
> +		return ret;
>  	}
