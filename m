Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1B65C0B1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjACNRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 08:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjACNQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 08:16:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48A1146D;
        Tue,  3 Jan 2023 05:16:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A302CE10E4;
        Tue,  3 Jan 2023 13:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A30AC433F0;
        Tue,  3 Jan 2023 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672751788;
        bh=QzmSB4Fsa2kuyLrblpTp0oCbj0W8DeYw43TZjZaN4Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRLdGZGF9eUpt105J6xSrYRgx41Jqz85g4UZomuqwpvGcJa4EYWSGXRXhF55WYJcO
         n3XCV59CdzmzB39syIMbB4bCoVnD9FIQa9xqF7FYMrFvOL/kaR0cCLtP4O5iSwpmHQ
         /k4BpN8HAhhvlwpo8s+41PPsxPHKQmT8ysfcC/7/FsoRKBLO1lytXlpiVHhRzrM1Xo
         WJkoCDJASC8mWH8BgPt5gs0TrzjoviUPRF+VmvJQW/t58ENxbangFL++153ueWqjx2
         ESw2KP3zrqE+WSOqZNaFlj/4l0mvst6H/6s4vqdAdU9LuTJWs+2tWIhxoQroQTFR+i
         iUEj43d6dk4yQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCh9r-0002cH-QS; Tue, 03 Jan 2023 14:16:47 +0100
Date:   Tue, 3 Jan 2023 14:16:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Message-ID: <Y7Qqv+kyREvXdRu1@hovoldconsulting.com>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 03, 2023 at 01:19:07PM +0530, Manivannan Sadhasivam wrote:
> During the system suspend, vote for minimal interconnect bandwidth and
> also turn OFF the resources like clock and PHY if there are no active
> devices connected to the controller. For the controllers with active
> devices, the resources are kept ON as removing the resources will
> trigger access violation during the late end of suspend cycle as kernel
> tries to access the config space of PCIe devices to mask the MSIs.
> 
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
> 
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
> 
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

I just gave this a quick spin on the sc8280xp-crd, and unfortunately
this change appears to break suspend (e.g. hangs during suspend or
resume). Setting a non-zero (250 MBps) peak bandwidth during suspend
makes things work again.

Presumably something is relying on these interconnect clocks to remain
enabled. And isn't that expected as we need to set a non-zero icc bw to
enable the interconnect clocks during probe?

I'm afraid I won't have time to look into this for a while myself, but
have you tried this on the CRD, Mani? 

One obvious difference is the modem on the CRD which I believe neither
of our X13s have, but this seems like more of a general problem.

Johan
