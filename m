Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7855B4EDF
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIKM6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKM63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 08:58:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB52250E;
        Sun, 11 Sep 2022 05:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE050CE0B66;
        Sun, 11 Sep 2022 12:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B819C433D6;
        Sun, 11 Sep 2022 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662901101;
        bh=5pJPTMNJ5+OElsd2lfD1/7XCGfw/8/wjX2/SJBtX6dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/f2Q9GZUUjdulHdonqjUh0XkSa0hh6y7LrCaZoiIalUTU/ncEa1JNDyvY3CXRUzb
         eouebK/Xa3nZqcm9EVYRVNuxwU+nCzhNxXclivv3Vf1gZsQTMAvyVvFQUxYk3nFUnk
         e42A18EwT6ZnaVh7NrKoGb99spI/o4EEZL6Da0ORC0JsTukjIc6omPzsHzKNmqUO7g
         1fK9Bv46qhBqnUiHypM+Dc22bQjBiyoPH2Xn4xLNm78xnQCS920VhHnHoQ+LuIyE4L
         3Ub7b+bWIiLxejkK13qMk2cAGzc2y0ZjLne2dlyWcJuYk10Ahq7NDqX4ibSbxY+IT8
         AXv3F/Qyp1qGw==
Received: by pali.im (Postfix)
        id 5DA7D878; Sun, 11 Sep 2022 14:58:18 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:58:18 +0200
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
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <20220911125818.qe4j6gwbz423m2xt@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
 <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxfMkzW+5W3Hm1dU@google.com>
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

On Tuesday 06 September 2022 15:41:23 Dmitry Torokhov wrote:
> Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
> GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
> deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?

+1 for GPIOD_OUT_INACTIVE / GPIOD_OUT_ACTIVE. It is less misleading than GPIOD_OUT_LOW.
