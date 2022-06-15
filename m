Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693254CD4F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiFOPoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbiFOPo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 11:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148672A705;
        Wed, 15 Jun 2022 08:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10754617BA;
        Wed, 15 Jun 2022 15:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A8C34115;
        Wed, 15 Jun 2022 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655307864;
        bh=zn+/9NlXFFxNxik8PzMPhaZQNyZRXGyoUKmHeh3qoKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jrgcQroKhGK+qJaprMi3K8vdIP0AeA+TaghGIMQewyWTRAUWd1j93uevWM/vnkIY6
         GgRjk7et5CJt1/2LReby/gDaRzibvaObXc7hgTnZNCJN8SoVf1JkvJAQdumqW9jco8
         O2rtia3ub56/BpqZVVU4PotvWBr2WgbI8sc9McxctKx1lL7LLIEQHGXPUXruUMb8Rn
         //6Y1PCHX8Ig3UNJ47ycxELdbjx67QiTSZ61ZL9lBpyOVLXR/SuLKsv5q490RB2aNS
         UrH7x6gM8LuArjItzGEd8YJRoh9JnwT2T5XCRCAi9hRFF7ufcCSE+q+YE6tZiHcyKX
         LiD4UNogf+Mag==
Date:   Wed, 15 Jun 2022 10:44:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: qcom: Allow L1 and its sub states on qcom dwc
 wrapper
Message-ID: <20220615154422.GA941075@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e92745e-6fa4-a3bd-d0cb-5c1f78efbead@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:44:19PM +0530, Krishna Chaitanya Chundru wrote:
> On 6/9/2022 3:47 AM, Stephen Boyd wrote:
> > Quoting Krishna chaitanya chundru (2022-06-03 00:18:50)
> > > Allow L1 and its sub-states in the qcom dwc pcie wrapper.
> > > By default its disabled. So enable it explicitly.
> > > 
> > Would be good to add some more details about why it's disabled by
> > default. I guess it's disabled by default in the hardware and enabling
> > it is OK to do unconditionally for all qcom dwc pcie devices?
> 
> This is disabled by default in the hardware. We can enable this for all qcom
> devices unconditionally because
> 
> Adding this patch alone will not allow aspm transitions we need to enable
> aspm configs. If particular devices doesn't want aspm
> they can disable using aspm configs.

This patch only affects qcom.  Is PCIE20_PARF_PM_CTRL qcom-specific?
Or is this something that should be done for all dwc-based drivers?

In fact, it only affects Qcom IP rev 2.7.0 and 1.9.0 (the only users
of qcom_pcie_init_2_7_0()).  I guess the other revisions don't support
ASPM L1 at all?

Does this patch affect the Link Capabilities register?  Before this
patch, does Link Cap advertise L1 support but enabling it doesn't
work?  Or does it not even advertise L1 support?

After this patch, I assume Link Cap advertises L1 support and enabling
L1 and L1 substates via PCI_EXP_LNKCTL_ASPM_L1,
PCI_L1SS_CTL1_ASPM_L1_1, and PCI_L1SS_CTL1_ASPM_L1_2 works per spec,
right?

Bjorn
