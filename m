Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CE5F3E9A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJDImF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJDImD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 04:42:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0022285;
        Tue,  4 Oct 2022 01:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E35B819A1;
        Tue,  4 Oct 2022 08:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451FEC433C1;
        Tue,  4 Oct 2022 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872919;
        bh=J9xOEOWZpj+qqTZPpEFH7soAtq/QD2uKoVcecjamnCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQrUTmAlvAQsGDbrvCvVvbesT63M+8l5Ov0SpsBQbGTl1Lny7Dg41jIefzdfF9I4Z
         1ra7nKs2HzK3APr19Zstxv+6SSaT+RTNqYPa8pTK3ggdjSvp12QuajOxC3SKIEm0Bq
         MzOeA6w9A87GQ/DqyDQqRdD3ddBOC5pySjvn698QFa0I3LGY4i6SEp4KoQrYOLo7UZ
         0PubjXlbJbNG6KIboEMW83jQsJCU3wbtMDN1XZzJKSo6dWLRQFwzw3RrD6GoQOeSXt
         Um3iIOn+CGNnUrCVnf7ieAdOQXa0fBpl06fN1kDPAcYudPlSt+kZKzRi22QML1Ht27
         8em85vlLcMWSg==
Received: by pali.im (Postfix)
        id 689857BA; Tue,  4 Oct 2022 10:41:56 +0200 (CEST)
Date:   Tue, 4 Oct 2022 10:41:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
Message-ID: <20221004084156.stshem4pdvhlt5zj@pali>
References: <20220928122539.15116-1-pali@kernel.org>
 <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 04 October 2022 09:56:18 Linus Walleij wrote:
> On Wed, Sep 28, 2022 at 2:25 PM Pali Rohár <pali@kernel.org> wrote:
> 
> > Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro for
> > accessing PCI config space.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> I have no way to evaluate this change in my head, once the kernel test robot is
> happy I can test the patch on IXP4xx.
> 
> Yours,
> Linus Walleij

You just need to apply this change on Lorenzo's pci tree. Or wait until
Lorenzo's changes are propagated into master tree and then robot should
be happy.
