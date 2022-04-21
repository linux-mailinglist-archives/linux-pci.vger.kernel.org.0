Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3D50A102
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiDUNoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiDUNoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 09:44:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB8369F8
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 06:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CD70B82482
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 13:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D357AC385A5;
        Thu, 21 Apr 2022 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650548485;
        bh=pgo4BbBjhxcVoY2YbPqv7GUVqwKZ4HUwIdR3mU2vpTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ropwZZfhtx1+7gwZRllAnz7ER+jqvdGdM3g+B7fhf4VVK4LEOdcys+/xKO9e0Up7V
         rvgaPQa1GmKbBOfnDwXlJgzVSVuzgZjzkVuMpaUJsWONLFXrFJJZcpgjg6wWav9/1q
         8i04vE+c8nbbNU+qeoC9/T+/fqqCcepoZD+wCYQe29vU8Kgb6DBBfuxDx7gBvifWiw
         fKrTDZ05pAAdwPmKj1vjXDo8nj91zPMyOApqvkx3SzuRpCFAfQuQCqcxuMMwtMMM7n
         5dlc6mucpX+tKL/qF418QnrIG2gAd34pcsVH8ZXEtKRtDtBSFfOesicKWT5HL/WGfc
         iPOa0UBcg9kng==
Received: by pali.im (Postfix)
        id 1B34DCD7; Thu, 21 Apr 2022 15:41:22 +0200 (CEST)
Date:   Thu, 21 Apr 2022 15:41:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     u.kleine-koenig@pengutronix.de, Daire.McNamara@microchip.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, ian@linux.cowan.aero,
        kernel@pengutronix.de, gregkh@linuxfoundation.org,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI: microchip: Allow driver to be built as a module
Message-ID: <20220421134121.pnhlwm74yzd5bdrs@pali>
References: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
 <20220420164139.k37fc3xixn4j7kug@pali>
 <bad31f90-f853-fdff-c91c-1a695ff162d1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bad31f90-f853-fdff-c91c-1a695ff162d1@microchip.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 21 April 2022 11:31:16 Conor.Dooley@microchip.com wrote:
> On 20/04/2022 16:41, Pali Rohár wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wednesday 20 April 2022 11:34:49 Uwe Kleine-König wrote:
> >> There are no known reasons to not use this driver as a module,
> > 
> > Hello! I think that there are reasons. pcie-microchip-host.c driver uses
> > builtin_platform_driver() and not module_platform_driver(); it does not
> > implement .remove driver callback and also has set suppress_bind_attrs
> > to true. I think that all these parts should be properly implemented
> > otherwise it does not have sane reasons to use driver as loadable and
> > unloadable module.
> > 
> > Btw, I implemented proper module support for pci-mvebu.c driver
> > recently, so you can take an inspiration. See:
> > https://lore.kernel.org/linux-pci/20211126144307.7568-1-pali@kernel.org/t/#u
> 
> Hmm, so what is the way forward here, are you happy to do it yourself
> or do you not have the hardware/would rather that we did it?

Hello! It would be needed to implement remove callback. But I do not
have hardware for doing and testing it, so I do not feel that I can do
it. I think that somebody with hardware and documentation should look at
it and decide what is required to do in remove/cleanup procedure.

Also it would be needed to investigate if something more is needed to
change builtin_platform_driver() to module_platform_driver(). If there
are not some other steps which needs to be done in correct sequence and
usage of builtin_platform_driver() currently ensures it.

> If you'd prefer that we did it, do we change the driver & submit that
> as a series with this patch as patch 2/2? Or should it be a single
> patch with your suggested-by?

Feel free to put it into one patch. It is single change which implements
one new feature = module support.

> Not quite sure what the expectation is with attestation for something
> like this.
> 
> Thanks,
> Conor
