Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114D65EBE80
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiI0JZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiI0JY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F3CDCC4;
        Tue, 27 Sep 2022 02:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE806174F;
        Tue, 27 Sep 2022 09:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F7FC433D7;
        Tue, 27 Sep 2022 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664270591;
        bh=fxyKD3idrxd/Kwm5HJI4SBtsysFFrlTJnWuARd0zvNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sey6YFB7+D5kctKLKQvVOBFkabkp4Q5/W2Th/2QtSyYxaxkqzTu9QEyTSl6eVitA2
         1nOC82tfXPdXwVuXIVJGPEE3rAJsvuFlIfBPYpFv7cwTW+2h8dmMon3+JUrmRZbfkf
         ZGqh4wUnXwHG1KcwNFelmhwRWdWjux53J6cadvd1BtyHNjeScFmMOfsdc95H+oKBXH
         B2It17OpaiPixryi3x+EsstDWdeA1GSp6gTMWHs0H54VcJH7PXst6dnF6Dmx3KiUJV
         BOHgI9q0evNQ9ppNINpOPM7HznK3C7H+RblXN2S2dmllMt0e6HAnIWOGPfXrEQb7+6
         IAS61smLHdvjA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     helgaas@kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, mka@chromium.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_ramkri@quicinc.com,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_skananth@quicinc.com, quic_vbadigan@quicinc.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        quic_nitegupt@quicinc.com, quic_hemantk@quicinc.com
Subject: Re: (subset) [PATCH v4 0/2] PCI: qcom: sc7280: add missing aggre0 and aggre1 clocks
Date:   Tue, 27 Sep 2022 11:23:03 +0200
Message-Id: <166427053134.73906.17497859805426997677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
References: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Sep 2022 14:16:14 +0530, Krishna chaitanya chundru wrote:
> Add missing aggre0 and aggre1 clocks supports to PCIe node.
> 
> Without voting these clocks, PCIe link is going down when system is
> suspended as these clocks can get turned off as no-one is voting for them.
> 
> Krishna chaitanya chundru (2):
>   arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks
>   dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
> 
> [...]

Applied to pci/dt - dts changes (patch 1) should go via
platform tree, thanks!

[2/2] dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
      https://git.kernel.org/lpieralisi/pci/c/1abbe04a1b55

Thanks,
Lorenzo
