Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278E25A5E19
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiH3Ias (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiH3Iao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 04:30:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790245B044;
        Tue, 30 Aug 2022 01:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3744AB81719;
        Tue, 30 Aug 2022 08:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD7C433D7;
        Tue, 30 Aug 2022 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661848239;
        bh=4fIFFAmJqtaWiPJveN43JWTiBEf0tvkh3C0coDWgI78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKdw1Yl99W5tBdesNduvC+WKgCPMNEqW6XFyVfMVxgD93+oFZ3ZMMuHthDT2mCCLD
         gqbzX+jsk8UYqlK8Y3fxfvIKVnVlwuUoOYmWJkBK+Z8ZgE2pGtOIJhsipiP4pIm+0R
         zdxtdRp1U4VYy1athyNZyDwgMfuWpx5nKhp4FzRrny6Uqr+X6BoojoAg1pmIy+resV
         pCT/KJGttEqF623ZadAJw8W1EerEkyWz+6ybQqTh8eMsxnu5iDyEAHWBCLT2wz0DoN
         QKdt+aMuWuqiYn0Bd/wLRDiPc3UZqd31X5rI8Nw196K/zPu64uTJJfX1nr13DNY2xu
         pbus2WrHLKNBA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        Siddartha Mohanadoss <quic_smohanad@quicinc.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Add MODULE_DEVICE_TABLE
Date:   Tue, 30 Aug 2022 10:30:34 +0200
Message-Id: <166184821458.217434.12003679728159470237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430084740.3769925-1-dmitry.baryshkov@linaro.org>
References: <20220430084740.3769925-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 30 Apr 2022 11:47:40 +0300, Dmitry Baryshkov wrote:
> Add MODULE_DEVICE_TABLE to enable module autoloading for respective
> device.
> 
> 

Applied to pci/qcom, thanks!

[1/1] PCI: qcom-ep: Add MODULE_DEVICE_TABLE
      https://git.kernel.org/lpieralisi/pci/c/2baedb9f93c4

Thanks,
Lorenzo
