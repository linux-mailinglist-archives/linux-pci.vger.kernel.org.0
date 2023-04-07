Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA696DA995
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjDGHxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 03:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDGHxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 03:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE08AD14;
        Fri,  7 Apr 2023 00:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCC864F79;
        Fri,  7 Apr 2023 07:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C1C433D2;
        Fri,  7 Apr 2023 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680854016;
        bh=AZYBQu+ztIMpM4WPqofdK68OyIzRniCF3fbMoR19hHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsTYmuMkk4dFPoOKr8GTz83zDakYPebgXnfZCLDHicAAxa/CnN1KMZ4WuJo47P8ow
         hS89hbDAO9mGO86l6Jn2kI9T6Fs9QhyZ/aZfRnfOgSLcvT8aks8fkhrhifautOwhOL
         EXJNoSiMCp4oeZMp9iF1CgvUrqcOMSowgYkFaMnV0E4kyIbKMBw3nwxInE309y//on
         +s7NMaJxNJbFloHGbaFtvLToVUN/Ei/I8vug378I2f0YVJii6N/Bg+Qn0jMdxgbVWw
         ZuuYf51bENp2dgjNxyppBBT9i7rXWdadBYyHP574JgtBbaLz25BhhfKFCfHLC2BP4R
         fXBYguCP2Sz7Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, shawnguo@kernel.org, peng.fan@nxp.com,
        marex@denx.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: (subset) [PATCH DTS RESEND v10 0/4] Add i.MX PCIe EP mode support
Date:   Fri,  7 Apr 2023 09:53:29 +0200
Message-Id: <168085399249.239803.7695177672411690439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
References: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Feb 2023 14:18:31 +0800, Richard Zhu wrote:
> i.MX PCIe controller is one dual mode PCIe controller, and can work either
> as RC or EP.
> 
> This series add the i.MX PCIe EP mode support. And had been verified on
> i.MX8MQ, i.MX8MM EVK and i.MX8MP EVK boards.
> 
> In the verification, one EVK board used as RC, the other one used as EP.
> Use the cross TX/RX differential cable connect the two PCIe ports of these
> two EVK boards.
> 
> [...]

Applied to controller/dt, thanks!

[1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema
      https://git.kernel.org/pci/pci/c/b10f82380eeb

Thanks,
Lorenzo
