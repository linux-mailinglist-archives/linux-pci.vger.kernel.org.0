Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FE659BC4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiL3Twg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 14:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiL3Twf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 14:52:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BA11A32;
        Fri, 30 Dec 2022 11:52:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37D061B9C;
        Fri, 30 Dec 2022 19:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0DAC433EF;
        Fri, 30 Dec 2022 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672429953;
        bh=8d81TX58YH1G9J+afWPRLe8LwaJbseEEbaaCSWCyhUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FZ0aRG52Zqkc4eP+mgUb3RQa0QaxbxWEYHFibI5hIv5age03Zz3UpWas9exd+utXz
         kNzq8BucpbMEaK/dg702NKqxaQzm1QTziVsCHQTG7PQxa/PLLHGTu75l6lBaCNLQUV
         v9Diu3UOp4hMot/Z9fDReK6oAj4Rw0H7J1g4YWaPqh+l+Lg4TdarkySNmU9vSqYzUa
         K9FJGRJJBGM9M0fXIzHPCOrUlLHXfuPUtRVBgYciTrPb004ekbalKO5gpbFZPT2wzK
         q8FEHdlASbSJf4oZE0eeGo5ihklt75WwECj6dYMj7zhL/P7gomo5vWdzdAy7EP7w6r
         0LoQnp4mMD3pw==
Date:   Fri, 30 Dec 2022 13:52:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     daire.mcnamara@microchip.com, conor.dooley@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 8/9] PCI: microchip: Partition inbound address
 translation
Message-ID: <20221230195231.GA704036@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212221347.puj3IN6d-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 01:30:03PM +0800, kernel test robot wrote:
> ...
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/controller/pcie-microchip-host.c:896:32: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>            devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
>                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I know this particular warning wasn't added by *this* series, but of
600+ instances of devm_add_action_or_reset(), only 4 have similar cast
ugliness like this.  I think most others define a trivial stub that
takes a void * and passes it on to the underlying function that
expects a more specific type.  That's kind of ugly too, but arguably
a little less so.

Bjorn
