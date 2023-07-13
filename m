Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964127519CC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjGMHXQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjGMHXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47841FD7;
        Thu, 13 Jul 2023 00:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B27761A44;
        Thu, 13 Jul 2023 07:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45F4C433CC;
        Thu, 13 Jul 2023 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689232985;
        bh=34iBZBeM9o/lETNpx3DmFjAaTAaoREDVy3VCozGSLL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7Xv9wZXb46K03sC3gymRa4ZNwBcdEB+sTKIrCPeNRwJUYF3u/8Dlt2vhH5lVYFDT
         0VVchOXpgdGrkLgQklYtLV+pLYTLz5vC89tb7vnTTJjVVl5ZV1yGEayqaaAP1RAiqj
         7ERJE1MIYKbWRGAW9i9c+U3va4a+tTHAI3/oBwAST8WNJaEuf54EAQ+ohjEkCY2WHg
         Dw+bih96XyVUYfIRXfWIy2LBCmgtFMvfOm6F3sB8pcHO68R0TjnLKvebcBq+LsF6R8
         a5W2aStzb5LaM31Eim7l91VcfVj5ODfaoo7UThsFaWrZmanF608D8SvgyQECsApa3G
         x9ylxg67JQB+A==
Date:   Thu, 13 Jul 2023 12:52:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Message-ID: <20230713072249.GG3047@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <20230705084606.GF11854@thinkpad>
 <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
 <20230706111218.GA4808@thinkpad>
 <878103c6-0dc3-164b-92ce-17ec4f87bff6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878103c6-0dc3-164b-92ce-17ec4f87bff6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 02:09:09PM +0200, Krzysztof Kozlowski wrote:
> On 06/07/2023 13:12, Manivannan Sadhasivam wrote:
> >>> Please note that the dts patches should come before driver patches.
> >>>
> >>
> >> Why? DTS is always independent thus usually put at the end of patchset
> >> or better separate. It is the first time I hear that DTS should be
> >> before driver.
> >>
> > 
> > This is what I was suggested by Rob during my initial days and I've been
> > following this pattern since then. If that's not the case, I have no issues.
> 
> I really doubt Rob ever suggested that. He probably suggested that
> bindings must come before user, but not the DTS.
> 

Maybe I misunderstood it to be both bindings and dts. Thanks for clarifying.

- Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
