Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6435EF099
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiI2IgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiI2IgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 04:36:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE4BB1E4;
        Thu, 29 Sep 2022 01:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A28B823C0;
        Thu, 29 Sep 2022 08:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E9C433C1;
        Thu, 29 Sep 2022 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664440565;
        bh=IWwdb6bfrNTHaSDjZf5Zq6LcjfEfOxyQQ8/I4mwHavo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijdINw9nLYF2UOHTUk5P4A3xkIU5T+G0Y1Ktvgt0izJmndOK29JzovTOV5PM4gH99
         hjBSqpO55R53I6FpRHEDFV54A0OrUFwuJfdlQYXgHqF4KfGkQcNRFmfNjQvS+4DdFB
         wDs6VlbWjiXWhyDpOQHrQxiZgee6Vs7C40yJZD2hjkRqzNTCdxlM8URmS8XtIfOtOY
         o2WKoH1u49PXWBBdOMM7VVgKHUAYWzMxFC/zjvTVlDVnEoM6aPTRnj4a8ZQmwC6Y9G
         rEpFGREjf3tTItKnxD/3CtHTtJ25Eavftnd9L4JPOCeIPBFEhG3nVCzoYQLinnK9kB
         NPt5j8HJojq9A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/2] PCI: qcom: Drop unused post_deinit callback
Date:   Thu, 29 Sep 2022 10:35:59 +0200
Message-Id: <166444053875.166182.16168492318251008339.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928155421.21660-1-johan+linaro@kernel.org>
References: <20220928155421.21660-1-johan+linaro@kernel.org>
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

On Wed, 28 Sep 2022 17:54:19 +0200, Johan Hovold wrote:
> This series drops the badly named post_deinit callback which is unused
> after merging the PIPE clock series. Included is also a related
> error-label cleanup.
> 
> Since the modular driver patch is held off for a while still, I've
> rebased these cleanups so that they might make it into 6.1.
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] PCI: qcom: Drop unused post_deinit callback
      https://git.kernel.org/lpieralisi/pci/c/b623023225ab
[2/2] PCI: qcom: Rename host-init error label
      https://git.kernel.org/lpieralisi/pci/c/0e4d9a5cc767

Thanks,
Lorenzo
