Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A285157CB
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiD2WGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350222AbiD2WF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B6CDC59B;
        Fri, 29 Apr 2022 15:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F147B835F1;
        Fri, 29 Apr 2022 22:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB20C385A4;
        Fri, 29 Apr 2022 22:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651269756;
        bh=y1e1VCaxAZamC4kGuCyNm7/0euzVSjNbMRuTo9mAw0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X24md+kAryMr8evPBXrbn5mPQnu2YTMc65YtQb7Xjc4U5hS4vBQR5PCjnbWRryVMe
         glqTr9cGRTGJgM9T0RXfp3T6CS8oP2NBPb4lCp851QKJEZhFMNwHznPGzYHybAt/3g
         s44Cpj27CxjfuhnLbbBLPnCS0submunTQddW2al3vXzOlwsII1oQ9wCDS6sPAkMR7i
         edqOOjjA5quwuU6VbklYKpB+FhCiB74rZoUj/Q1Ifl8B+yJv4UnnFBzhNRRf/4rBHx
         gWPt3vZ6RGRb+mhavUs0uvVBlXaWXVUI1aQcePT0KqDoGTfkETAkhzOefB7ypiH/xR
         ezM+MeAorUdMw==
Date:   Fri, 29 Apr 2022 17:02:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/8] dt-bindings: PCI: qcom: Do not require resets on
 msm8996 platforms
Message-ID: <20220429220233.GA110383@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429213032.3724066-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 12:30:26AM +0300, Dmitry Baryshkov wrote:
> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
> resets. So move the requirement stance under the corresponding if
> condition.

Nit: Pretty sure you mean "stanza" instead of "stance".  Only
mentioning it because I pointed it out last time but it was buried
down in some text that I should have trimmed out.
