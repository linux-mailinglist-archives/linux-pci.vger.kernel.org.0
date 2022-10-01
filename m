Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2052A5F1D7F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Oct 2022 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJAQLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJAQLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 12:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD728671E;
        Sat,  1 Oct 2022 09:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A666EB8070D;
        Sat,  1 Oct 2022 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426EDC433D6;
        Sat,  1 Oct 2022 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664640662;
        bh=+tLBwJLKoQXm1tSPzdom9fhATSE4ve/d6ppauhe85RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixzRqOMrsrhpJPO56KNiFtbHEDHRU3Bdq1G2MiFnrql6gnPYsSKb+qaRetAMo0t8O
         3gKWaWAsyKYYvYYq7kzwWLJISlDp6DptC82bjJydASIvNR1+LX1Yn8n6lY4ZcWv7kh
         DOp0cxyFq1demqdPZRatUt+31mRsVXuOR1bq0JEzW6F4P72CwIFQUWOD35GAekDVi0
         vYjD9UlL3JA1hXQxFJAZ1qtXPaYGovhthrPslHlRFWZ/f5cxNzaJhrBKX/5ZmKD2wF
         /jZ4vi96ihtcatVj3LvDOVKgdQEXLeV7a6xanmqcPSa1sXU9HxxlNp74N6tYWjhzwH
         zE282A4Yclm5Q==
Received: by pali.im (Postfix)
        id 41C9FA15; Sat,  1 Oct 2022 18:10:59 +0200 (CEST)
Date:   Sat, 1 Oct 2022 18:10:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH V1 1/4] dt-bindings: Add "hotplug-gpios" PCIe property
Message-ID: <20221001161059.5ymdptqzslh3d55x@pali>
References: <20220930192747.21471-1-vidyas@nvidia.com>
 <20220930192747.21471-2-vidyas@nvidia.com>
 <20221001155626.GA9324@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001155626.GA9324@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 01 October 2022 17:56:26 Lukas Wunner wrote:
> On Sat, Oct 01, 2022 at 12:57:44AM +0530, Vidya Sagar wrote:
> > Provide a way for the firmware to tell the OS about the GPIO that can be
> > used to get the Hot-Plug and Unplug events.
> [...]
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -32,6 +32,10 @@ driver implementation may support the following properties:
> >     root port to downstream device and host bridge drivers can do programming
> >     which depends on CLKREQ signal existence. For example, programming root port
> >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> > +- hotplug-gpios:
> > +   If present this property specifies the GPIO to be used for Hot-Plug/Unplug
> > +   functionality. It is used by the PCIe GPIO Hot-Plug core driver for
> > +   PCIe device Hot-Plug/Unplug events.
> 
> Please specify the GPIO's semantics in more detail:
> Is the pin high as long as presence of a card is detected?

Hello! In PCIe is this semantics called "Presence Detect" (see PCIe Slot
Capabilities). So should it be rather named "presence-detect-gpios"
instead of hotplug?

> Or does it pulse when a hotplug/unplug event occurs?
> 
> Thanks,
> 
> Lukas
