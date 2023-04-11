Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9996DD74B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDKKA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDKKAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 06:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC71989;
        Tue, 11 Apr 2023 03:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 390CE6237E;
        Tue, 11 Apr 2023 10:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF97C433EF;
        Tue, 11 Apr 2023 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681207223;
        bh=2Keq4mCspCfodAShTdZm6WYR/UkXTzR5FoMI1X1CAKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXDw27WS54Awt52Gw+8LzBkircV8TErUYRIznfxBuN/jzK6/GUPdHex2En9MtGFJ0
         9ptyxr8wqorGkEkrtvSSeH9sEfrmRk04YjUrv9hjjDXnKL2wIEffC5eFFMRGJoa5we
         VDYrxSWppJu27PR//I+53BjuAdyHXcA87n56WRkxoqaiyuHGb1alq8e085To+VhqVC
         SEykm97mIXpqvdoVd2V3jnP5kfDQwTLBZZ6hGoywE8V+MqNCMqFxfOevyz65fhdgIg
         fTp1DmKMaYNULypESgCaWHAvoOTQi5teNriZjmMcE8iiyPvaOTgioCBpQKDIdE4Qa7
         ZsM8Wru2Z/4RA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH v2] PCI: qcom: Add async probe support
Date:   Tue, 11 Apr 2023 12:00:15 +0200
Message-Id: <168120720036.16834.5098751319191987141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320064644.5217-1-manivannan.sadhasivam@linaro.org>
References: <20230320064644.5217-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 20 Mar 2023 12:16:44 +0530, Manivannan Sadhasivam wrote:
> Qcom PCIe RC driver waits for the PHY link to be up during the probe. This
> consumes several milliseconds during boot. So add async probe support so
> that other drivers can load in parallel while this driver waits for the
> link to be up.
> 
> 

Applied to controller/qcom, thanks!

[1/1] PCI: qcom: Add async probe support
      https://git.kernel.org/pci/pci/c/2dee743c8b4d

Thanks,
Lorenzo
