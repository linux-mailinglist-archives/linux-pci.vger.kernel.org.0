Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06332659787
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiL3LUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 06:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiL3LT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 06:19:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804E1AD81;
        Fri, 30 Dec 2022 03:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CACE8B81BB7;
        Fri, 30 Dec 2022 11:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93E2C433D2;
        Fri, 30 Dec 2022 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672399196;
        bh=66+Utcio1Yvnm6IqPcSYYfhn1IhtICBAOV3ml14FGKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hwu1qn0mjo+k62TPiPpDqoqgYJ+SvClfHp5/BmvAj6znQv1DiNqniZiOPpus4nCSi
         o+qSirm1CSH6+2n7CYUuzbJU5Pf6v7fJlZSO6zaeB0/PSw+P41M7Wa0ONCZXy7OiO0
         MqarN7GqKsFoHjSlrJLTKasL5TuJXcjqQdynFmBJS+dvb7ws6rO5tYR72enrHKePGt
         IIbAtC67jDDnVNJuMhNqEAYRI+f+QxBJXjFaFcCXN00XsgMATxbUZNAni8GawdcJqL
         RJbaf5QlszT5S1/oxXd2yYZ8kIE1dSDDynffNbblk+l/mOBBRQyzogncaMqlq2uDPK
         ypOAPibHZXWbA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/1] dt-bindings: PCI: uniphier: Fix endpoint descriptions
Date:   Fri, 30 Dec 2022 12:19:49 +0100
Message-Id: <167239915876.744743.14217216236475860697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223070713.20549-1-hayashi.kunihiko@socionext.com>
References: <20221223070713.20549-1-hayashi.kunihiko@socionext.com>
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

On Fri, 23 Dec 2022 16:07:12 +0900, Kunihiko Hayashi wrote:
> This series fixes dt-schema descriptions for PCI endpoint controller
> implemented in UniPhier SoCs.
> 
> Drop the patch in this series,
> "dt-bindings: PCI: designware-ep: Increase maxItems of reg and reg-names",
> because this was done by the commit 4cc13eedb892
> ("dt-bindings: PCI: dwc: Add reg/reg-names common properties").
> 
> [...]

Applied to pci/dt, thanks!

[1/1] dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names using compatible string
      https://git.kernel.org/lpieralisi/pci/c/89836d5becf2

Thanks,
Lorenzo
