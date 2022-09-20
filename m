Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F75BECA8
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiITSQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITSQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 14:16:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489244571;
        Tue, 20 Sep 2022 11:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E71D0CE1B08;
        Tue, 20 Sep 2022 18:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18CC433C1;
        Tue, 20 Sep 2022 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663697799;
        bh=qbFGsZmeyVBsjxnEf6EsFVV+a4DqJ+aI9q4jgAqQE8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DCi2N5qM84CpyJ4wWr0ZucIQfZKVQ9ERFZuGWlCmq+KdUixA1HAh1v8vNfh4J1Aim
         dn1G+rhm0MHuDMsEoHq8cetTXUnhyoalNpvXmhh277nw0EaDo9O6MTwrA9BBrmQ16/
         5/BeI3IIWkQOMdSSKAyS2p+BxENvI44PCFCDXm7StNs1GqNwTnr1PleZyGmTbXrfxD
         zVPg999YsligGnuuBm4yvP7Ud4ol5JkZG980TQslP4KTZV6y7mrhPooZyOwJldg3Yn
         SIUn2kmZu8JI+eJ+wOgrL5mUkGPUa2+Gq+Wm8c6rMIemS1jEgKiB5OmUMreQ4ywUHZ
         khGDd80bxmvdg==
Date:   Tue, 20 Sep 2022 13:16:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v7 1/5] PCI: qcom: Add system suspend and resume support
Message-ID: <20220920181637.GA1121154@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663669347-29308-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> Few PCIe endpoints like NVMe and WLANs are always expecting the device
> to be in D0 state and the link to be active (or in l1ss) all the time
> (including in S3 state).

What does this have to do with the patch?  I don't see any NVMe or
WLAN patches here.

> In qcom platform PCIe resources( clocks, phy etc..) can released
> when the link is in L1ss to reduce the power consumption. So if the link
> is in L1ss, release the PCIe resources. And when the system resumes,
> enable the PCIe resources if they released in the suspend path.

What's the connection with L1.x?  Links enter L1.x based on activity
and timing.  That doesn't seem like a reliable indicator to turn PHYs
off and disable clocks.

> is_suspended flag indicates if the PCIe resources are released or not
> in the suspend path.

Why is "is_suspended" important for the commit log?  It looks like
just a standard implementation detail.

> Its observed that access to Ep PCIe space to mask MSI/MSIX is happening
> at the very late stage of suspend path (access by affinity changes while
> making CPUs offline during suspend, this will happen after devices are
> suspended (after all phases of suspend ops)). If we turn off clocks in
> any PM callback, afterwards running into crashes due to un-clocked access
> due to above mentioned MSI/MSIx access.
> So, we are making use of syscore framework to turn off the PCIe clocks
> which will be called after making CPUs offline.

Add blank lines between paragraphs.  Or rewrap into a single paragraph.

s/Its observed/It's observed/
s/MSIX/MSI-X/ throughout
s/MSIx/MSI-X/ throughout

Bjorn
