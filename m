Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BB58EE1E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 16:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiHJOUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJOUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 10:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B369100;
        Wed, 10 Aug 2022 07:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 257A4B81CE7;
        Wed, 10 Aug 2022 14:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D543CC433C1;
        Wed, 10 Aug 2022 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660141210;
        bh=m3CoMnz7sNRQpMg68VArz8QaTvZrurPeO80ZShmkn7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gue/6h/jbi/tSLlPoXxOtWxTMbxFD2rydVL8uRERCDiH5xbl21UOuqObls52eyfke
         m/w5zhtfAKonZDfu8sY13UAWx9x15Qfe3u4ZPXtislZABiOnUqt1j6Zy19jjsHYx0A
         AOquMCfyfRA3do5NtnFuPSl4qMZVCl5iDGkE3WMsG/G9aX+KKhTycJHOWi2P01a28d
         l7oT1SH34e1Pv+hp+9PzJJNs9RzwqqN4hWQqRmahy8kAEYPQ/y8CD/56vrycV3o89S
         HepNnnPjGvuajTBIC4MrpQbT0SOaQKB4DKCotWuGN9V9wIkZuW8JHlPQhuGCHo18gy
         yWZ5iB9fMHijQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oLmZ6-0029I7-K1;
        Wed, 10 Aug 2022 15:20:08 +0100
MIME-Version: 1.0
Date:   Wed, 10 Aug 2022 15:20:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>
Cc:     Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ntb@lists.linux.dev
Subject: Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
In-Reply-To: <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <32f06a0035c5b0760f5152c699f17af8@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh+dt@kernel.org, jdmason@kudzu.us, Frank.Li@nxp.com, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-10 15:01, Rob Herring wrote:
> On Wed, Jul 20, 2022 at 3:31 PM Frank Li <Frank.Li@nxp.com> wrote:
>> 
>> imx mu support generate irq by write a register.
>> provide msi controller support so other driver
>> can use it by standard msi interface.
>> 
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 
>> +++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> This is failing in linux-next now, but I'm wondering why it is there
> given all the comments.

*BLINK*

Jon, please drop this and the corresponding irqchip changes
from -next. There is definitely not 6.1 material if the current
code is anything to go by. That'd be commits:

621b7555c914 ("dt-bindings: irqchip: imx mu work as msi controller")
893ae515ff8d ("irqchip: imx mu worked as msi controller")

Once it is ready, I'll take it via the irqchip tree. But only when
it is ready.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
