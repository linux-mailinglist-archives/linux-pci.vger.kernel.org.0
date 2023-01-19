Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2421672F22
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 03:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjASCm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 21:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjASCm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 21:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38637B47E;
        Wed, 18 Jan 2023 18:42:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE44EB80A29;
        Thu, 19 Jan 2023 02:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68C5C433F0;
        Thu, 19 Jan 2023 02:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096175;
        bh=ynDeNozJvjU7+2OdaF3xoRj/R1KFU7FIil+EFkOuDRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnXICSpVfBfXZci7nc2q8kkT7++j7vPT5f8MJjKsdvQ1H41xzmuXgGvjMYGhdUK4F
         wSwAX3+iFQWay5xUcDusoa38bDHqbhUylPnY2dc5ybACrK/wRf8tphdHD7gf3ebHbE
         SaE8GSo9y36ZyrYt7dcJFhdvBlK/pjOOT0b6gYQfHpUM9RKbqgJUCZSVbbK/UEP8kU
         2+AZgFTw7R5F2+0cH1G6RMdz44GbWNliVB/6gx//xcUMvbJOf6Umyd/8rvf1WNSkHU
         MeoWsZFpW3G2IBFa6BLTzsY/YTogGC48D9Fi1ttzYvlv14JUW4ajom5TPt6UfqRWTl
         7Ha3vnxP2YjeA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, lpieralisi@kernel.org,
        devicetree@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: PCI: qcom: Allow both GIC-ITS and internal MSI controller
Date:   Wed, 18 Jan 2023 20:42:50 -0600
Message-Id: <167409616954.3024582.9628170500602623153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230111123004.21048-1-manivannan.sadhasivam@linaro.org>
References: <20230111123004.21048-1-manivannan.sadhasivam@linaro.org>
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

On Wed, 11 Jan 2023 18:00:03 +0530, Manivannan Sadhasivam wrote:
> The binding should specify both MSI implementations and the OS/driver
> should choose the one based on the platform requirements.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8450: Allow both GIC-ITS and internal MSI controller
      commit: 0da2eff44e78ded247fe35d8a3f73508263d0948

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
