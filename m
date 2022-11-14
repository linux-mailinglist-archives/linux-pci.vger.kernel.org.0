Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5A627B2F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNK6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 05:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiKNK6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 05:58:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F5E7657;
        Mon, 14 Nov 2022 02:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F68DB80DE4;
        Mon, 14 Nov 2022 10:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9DBC433D6;
        Mon, 14 Nov 2022 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668423506;
        bh=tO/eLpT16vXEE/iAh4KKX6vzv3SYcIBqarX+crWY80s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V46KsAsV5wjYw1WY0qja3/f+J06lkP+LMTYOQuyjTLVrv4jLkwGgnrFBy7DQI6Jhi
         z9wgBxZFgQQKY3mg8+km8Kb8L+pcmHCg1wtxeNQQMGpwNFVj4cs9eQy8ztLJ+P1zYE
         JWSm9Lo2UFI/bc7ALqe3lkg7TgR2byfFhUsts749aG4PFcOePG7di8C2RJbp03Yxbb
         lI6bqNPky0S7osF9o9kRgSmGUdI6p01wxUlkia9Hzty5vh1SQ1n6sUwjwMZj4WxrRl
         JuM47rnP/fhPkjdYECqc07Ah34dM7L9e6+HIAVukjvHSGjdu0k0p23RhAtM9ueub61
         twgifmOjve8UQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] PCI: histb: switch to using gpiod API
Date:   Mon, 14 Nov 2022 11:58:15 +0100
Message-Id: <166842347910.24264.12306903018237110796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Sep 2022 13:43:00 -0700, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> 

Applied to pci/dwc, thanks!

[1/2] PCI: histb: switch to using gpiod API
      https://git.kernel.org/lpieralisi/pci/c/1d26a55fbeb9

Thanks,
Lorenzo
