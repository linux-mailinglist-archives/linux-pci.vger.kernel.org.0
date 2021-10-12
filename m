Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73B42A6DB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJLONb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 10:13:31 -0400
Received: from foss.arm.com ([217.140.110.172]:44518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237098AbhJLONb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 10:13:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15431ED1;
        Tue, 12 Oct 2021 07:11:29 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC07A3F66F;
        Tue, 12 Oct 2021 07:11:26 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:11:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 4/5] PCI: qcom: Add a flag in match data along with
 ops
Message-ID: <20211012141109.GA28486@lpieralisi>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
 <1633628923-25047-5-git-send-email-pmaliset@codeaurora.org>
 <CAE-0n51NfLevCSwDDK0pxg=zmdw7pqw-wGEV2_MxBZZvh_caOQ@mail.gmail.com>
 <6007d4168a942dd95661705a675bd8dc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6007d4168a942dd95661705a675bd8dc@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 08, 2021 at 07:29:05AM +0530, Prasad Malisetty wrote:
> On 2021-10-07 23:33, Stephen Boyd wrote:
> > Quoting Prasad Malisetty (2021-10-07 10:48:42)
> > > Add pipe_clk_need_muxing flag in match data and configure
> > 
> > This commit text isn't accurate. The flag isn't added in this patch
> > anymore. Same goes for the commit title/subject. Can you please update
> > it to say something like "Point match data to config struct"?
> > 
> Hi Bjorn,
> 
> Could you please update below commit text while taking this patch.
> 
> "PCI: qcom: Replace ops with struct pcie_cfg in pcie match data.
> 
> Add struct qcom_pcie_cfg as match data for all platforms.
> Assign appropriate platform ops into qcom_pcie_cfg and read
> Using of_device_is_compatible in pcie probe. "

of_device_get_match_data() you mean ? I am confused, please let
me know, I am applying patches 4-5.

Lorenzo

> 
> Thanks
> -Prasad
> 
> > > If the platform needs to switch pipe_clk_src.
> > > 
> > > Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> > > ---
> > 
> > Otherwise code looks fine:
> > 
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
