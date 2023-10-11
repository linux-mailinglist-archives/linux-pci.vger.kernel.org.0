Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7D7C48FA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 07:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjJKFEL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 01:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbjJKFDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 01:03:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817E98;
        Tue, 10 Oct 2023 22:03:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF6EC433C7;
        Wed, 11 Oct 2023 05:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697000632;
        bh=794p5WpeA8qidxrpcDZSFxEyuDxwDmggKrBW0CTOJuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D14BRIXvecrU5dYW61kULPsWzX1lO8lAUNoDmm8U2p7vsc3VYQltBz7JPMqQg5WXA
         QZIt+ilYpgt+6sQF1+vQ492cOEMJO1UkwdWlKBzcy8y0Zf6+NaBTJjebaCjs0hoUJ3
         P6QsqEbW94eJAZphtrHjIdjOKMaUE548mPJA2i8Hyme6whCWx0VxCSvzCr6k6sy1ZR
         xTd6ECSmhKQV/dteh4xz6KD/gEQBV5gnEp14kXOsbYnEE/I8Hk2YBcdAL6fIeIp/+J
         S73llBsvYox/RrbBnxg7YsDUYhPv6w5okgleib9soWEcnADs4s5XKIGJb6Odq0DY/M
         hYh8oFhbbeQ0g==
Date:   Wed, 11 Oct 2023 10:33:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Enable ASPM for platforms supporting
 1.9.0 ops
Message-ID: <20231011050339.GD3508@thinkpad>
References: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
 <20231010155914.9516-3-manivannan.sadhasivam@linaro.org>
 <e6d22992-e3aa-480c-8def-00a447951a02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d22992-e3aa-480c-8def-00a447951a02@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 06:33:52PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10/10/23 17:59, Manivannan Sadhasivam wrote:
> > ASPM is supported by Qcom host controllers/bridges on most of the recent
> > platforms and so the devices tested so far. But for enabling ASPM by
> > default (without Kconfig/cmdline/sysfs), BIOS has to enable ASPM on both
> > host bridge and downstream devices during boot. Unfortunately, none of the
> > BIOS available on Qcom platforms enables ASPM. Due to this, the platforms
> > making use of Qcom SoCs draw high power during runtime.
> > 
> > To fix this power issue, users/distros have to enable ASPM using configs
> > such as (Kconfig/cmdline/sysfs) or the BIOS has to start enabling ASPM.
> > The latter may happen in the future, but that won't address the issue on
> > current platforms. Also, asking users/distros to enable a feature to get
> > the power management right would provide an unpleasant out-of-the-box
> > experience.
> > 
> > So the apt solution is to enable ASPM in the controller driver itself. And
> > this is being accomplished by calling pci_enable_link_state() in the newly
> > introduced host_post_init() callback for all the devices connected to the
> > bus. This function enables all supported link low power states for both
> > host bridge and the downstream devices.
> > 
> > Due to limited testing, ASPM is only enabled for platforms making use of
> > ops_1_9_0 callbacks.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> [...]
> 
> > +static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> > +{
> > +	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
> > +	pci_set_power_state(pdev, PCI_D0);
> > +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> Do we not care about retval here?
> 

No. Even if it fails, we shouldn't care about it.

> > +
> > +	return 0;
> > +}
> > +
> > +static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> post_init_enable_aspm?
> 

The scope of this callback may get extended in the future. So I'd keep it as it
is.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
