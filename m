Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E327F5B78B1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiIMRp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiIMRpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:45:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046B6C124;
        Tue, 13 Sep 2022 09:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7ECEB80E42;
        Tue, 13 Sep 2022 16:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51134C433C1;
        Tue, 13 Sep 2022 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663087277;
        bh=zbv4EwTaP7rUkUEvFc0RdqraUvYNfEaRoM8zAcgBhuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pRweID/xbMDKa46YcOEacdA2JxVlxKekXd0bNpQGONzRzVTSM/ooW4cMQNrdO0AlV
         G4FPiNAc9Uab/ewSkNMRbzO0kMfN4ly/+AzHlzSEZ3extX8VHzzsSBNtiCo78yWin/
         32VcE3QYY22/a2s7VwqmgkK3Sun8cg8wg/tpZUYQqu/NYW8meeeu6ylxIi8zur3vjN
         Z8d5mu/VaZputxRt9QOnh8024aU7m2o0eevjYtdIKouhmHzOFwregHfmliUq15UtIE
         5AXH6at/lGGxfSVLt3POxlUuWM5mdD4X9SFK1Hh8yXPMFKHCauimcnNvi4fjwlICQy
         VyyCFAfSamlCA==
Date:   Tue, 13 Sep 2022 11:41:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v6 3/5] phy: core: Add support for phy power down & power
 up
Message-ID: <20220913164115.GA603018@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCahxV+315zoSQG@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 08:28:15PM +0530, Vinod Koul wrote:
> On 09-09-22, 14:14, Krishna chaitanya chundru wrote:
> > Introducing phy power down/up callbacks for allowing to park the
> > link-state in L1ss without holding any PCIe resources during
> > system suspend.
> 
> where is the rest of the series, pls cc relevant folks on cover at
> least!

Would be best to cc relevant folks, but in the meantime, it's easy to
find via lore, e.g., 3/5 has:

  Message-Id: <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>

so the lore URL is:

  https://lore.kernel.org/r/1662713084-8106-4-git-send-email-quic_krichai@quicinc.com

and the thread overview is at the bottom.

I use this incredibly handy mutt hook that adds lore URLs to emails
directly when viewing them: https://github.com/danrue/lorifier

Bjorn
