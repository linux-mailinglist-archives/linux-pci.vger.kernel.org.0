Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41344B2C34
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 18:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiBKR5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 12:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBKR5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 12:57:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 869601AF;
        Fri, 11 Feb 2022 09:57:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EA771042;
        Fri, 11 Feb 2022 09:57:37 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA113F70D;
        Fri, 11 Feb 2022 09:57:35 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:57:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>
Subject: Re: [PATCH 0/3] PCI: qcom: pipe_clk_src fixes for pcie-qcom driver
Message-ID: <20220211175733.GB2300@lpieralisi>
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
 <CAE-0n52qs0fe2Cz2QChc0RmnddcWtuw-u1Q34=_Q7FVJSw=q2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52qs0fe2Cz2QChc0RmnddcWtuw-u1Q34=_Q7FVJSw=q2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 09:11:44PM +0000, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2021-12-18 06:02:20)
> > After comparing upstream and downstream Qualcomm PCIe drivers, change
> > the way the driver works with the pipe_clk_src multiplexing.
> >
> > The clock should be switched to using ref_clk (TCXO) as a parent before
> > turning the PCIE_x_GDSC power domain off and can be switched to using
> > PHY's pipe_clk after this power domain is turned on.
> >
> > Downstream driver uses regulators for the GDSC, so current approach also
> > (incorrectly) uses them. However upstream driver uses power-domain and
> > so GDSC is maintained using pm_runtime_foo() calls. Change order of
> > operations to implement these requirements.
> 
> Prasad, can you test/review this series?

Waiting for testing/review and Bjorn/Andy ACKs.

Lorenzo
