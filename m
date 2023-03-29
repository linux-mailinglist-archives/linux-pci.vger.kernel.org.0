Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C76CEC05
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC2OpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjC2Oom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 10:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C06A69;
        Wed, 29 Mar 2023 07:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7915A61D5E;
        Wed, 29 Mar 2023 14:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C937FC433D2;
        Wed, 29 Mar 2023 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680100927;
        bh=v/O9YnUMjPsVXWpIvJiLm+MGovZMWi2Z/gPhfkk/A5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxCDPI71R9uZSTNmXhHxF8t85mkSE2zNX8BxQOayZqdHIxTYDozMlZs910xqJ7t76
         4rjKaBL7ySfmJpbJf6G/nXvgdGev1Z8MpqM5wBbIdTmRWYoXoZ4sHqCkR8/3j+Avg+
         hAEEyLL8Aou5GtO1fpAAIL8dDjlxkVTD35PDVcSs+VZOw3VDoUNd/vLMCiv+yvuss+
         DROArO+SXXTk7V95PMzcb/Bf5/h7g6cYbjfWCzuHVs5v+u5XyMNJezWXK6WfbBAsYl
         YVCI2stvveX76scNavgqFs7D67bKizILe0SdbIy4veKKSJjTiwadD1Hb0/hCUn9nWb
         zYW/mMTXd08ZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1phX0J-0000NB-QL; Wed, 29 Mar 2023 16:42:23 +0200
Date:   Wed, 29 Mar 2023 16:42:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <ZCROTyuxZ+dkrnx8@hovoldconsulting.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <ZCQLWzqKPrusMro+@hovoldconsulting.com>
 <20230329125232.GB5575@thinkpad>
 <ZCQ69xyQ4mwTow1W@hovoldconsulting.com>
 <20230329140150.GE5575@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329140150.GE5575@thinkpad>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 07:31:50PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 29, 2023 at 03:19:51PM +0200, Johan Hovold wrote:
> > On Wed, Mar 29, 2023 at 06:22:32PM +0530, Manivannan Sadhasivam wrote:

> > Why would you need PCIe gen1 speed during suspend?
> 
> That's what the suggestion I got from Qcom PCIe team. But I didn't compare the
> value you added during icc support patch with downstream. More below...
> 
> > These numbers are already somewhat random as, for example, the vendor
> > driver is requesting 500 kBps (800 peak) during runtime, while we are
> > now requesting five times that during suspend (the vendor driver gets a
> > away with 0).
> 
> Hmm, then I should've asked you this question when you added icc support.
> I thought you inherited those values from downstream but apparently not.
> Even in downstream they are using different bw votes for different platforms.
> I will touch base with PCIe and ICC teams to find out the actual value that
> needs to be used.

We discussed things at length at the time, but perhaps it was before you
joined to project. As I alluded to above, we should not play the game of
using arbitrary numbers but instead fix the interconnect driver so that
it can map the interconnect values in kBps to something that makes sense
for the Qualcomm hardware. Anything else is not acceptable for upstream.

Johan
