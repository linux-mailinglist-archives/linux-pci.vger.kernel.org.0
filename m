Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9FF5B8720
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiINLTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiINLTL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 07:19:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBA4DF3B
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 04:19:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g3so4259136wrq.13
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T6Z1sxrsS/iEyWK4j442NiGqIJjiqn+hpIPVo9lGQ+0=;
        b=EV9tuRTXpn8Dt09HoeSuTrAMldTw1Jim0+TnkCZoTrTuQZljmfH4bnbDpMRZ0sM8/w
         huW2ANhWjq65n1bL6a2xixQGdmUrVHBvYfu6f1In6tjqW8zLYDSUjU0/p2siIduwpZji
         6y48iiOUxomqn/0/bH2Z6M/f3dQgs9Rdasa5PFPT5QrFYMksvq9ph0boIPqHWKIaI2b7
         a/0iU931cKjcDtU0MC7bZoduCBkoSMGxEK+0rSliHVOJj9HpiZgxAzfTQDdA9hx1bhu0
         8QYvx4CqjDwYIHzMnsuRsShaBBumAApbESyxiBk43vaPlpBxva9kG41sg3x8mhA6RRKU
         /xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T6Z1sxrsS/iEyWK4j442NiGqIJjiqn+hpIPVo9lGQ+0=;
        b=vMut4jUMdXbcqtMVvZsPDl7RyH4+mScTDhLBi5WdcSfIDijnkoSQRybd/tHVRHCbaR
         cVmNVWBnreFwXsh/jh8n5Wi2u5BxTt6qbtGF2co2vvIEDBkCzHkrGhpRZRZxOr/vo/7l
         YiSy809ZuNqiZ8Ixwf1TC34GitQsry3gsJoXGCMHVGZ+ohbnYKKFJokL1DDfQB3eUV5+
         UfAUJJ80bkm4GsqQ8Q9WQcadgkT6oU4UUOcN7WQXUSinwf19mkbA1BCB0P5L/bbPJwz8
         A1M2FiuBB1/ey14IUHOUFYPeuVottfpBqhEWxIvQvRnvc+68iULPxFZp5SeLRke/jLKX
         GTmA==
X-Gm-Message-State: ACgBeo3I+hyxd9wxxN5ACwakZGw+htYbCSKSuqnpUIhnmG+UL21foE3A
        74K2dZrkj4pAVCP9Ijju5hMk8vuBROEJ5cY=
X-Google-Smtp-Source: AA6agR6VGpioQ/8N5I56HuLuLO/P7B2PHYmZGZupIHqW8kM8FpOGbUMkgVsC8oAjqnbj2WsWtUrQ3A==
X-Received: by 2002:a5d:564e:0:b0:228:d609:7ac3 with SMTP id j14-20020a5d564e000000b00228d6097ac3mr20736994wrw.27.1663154348174;
        Wed, 14 Sep 2022 04:19:08 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b00228c792aaaasm13110142wrw.100.2022.09.14.04.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 04:19:07 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:48:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220914111857.GF16459@workstation>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 04:32:10PM +0530, Vidya Sagar wrote:
> Agree with Mani.
> Not all form factors support PRSNT pin (Ex:- M.2 Key-M form factor) and even
> if the slot form factor supports PRSNT, it is not mandatory to have a GPIO
> routed to the PRSNT pin of the slot.

Right.

> Also, since these are development platforms, we wouldn't want to keep
> changing a controller's status in the DT, instead want to know the device's
> presence/absence (by way of link up) looking at the log.
> In my honest opinion, I don't think the absence of a device in the slot
> should be treated as an error.
> 

As I mentioned earlier, timeout can happen due to an issue with PHY layer
also. In those cases, "dev_err()" is relevant.

And I also agree that absence of the device should not be treated as an
error. But my question is, if you know that the slot is going to be
empty always, why cannot you just disable it in dts?

Even if you make the log "dev_info()" there is the wait time for link up
and I'm sure that you wouldn't want it either.

Thanks,
Mani

> Thanks,
> Vidya Sagar
> 
> On 9/14/2022 11:54 AM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> > > > On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > > > > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > > > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > > > > not having an endpoint connected to the slot is not an error.
> > > > > > So, changing the macro from dev_err to dev_info to log the event.
> > > > > 
> > > > > But the link up not happening is an actual error and -ETIMEDOUT is being
> > > > > returned. So I don't think the log severity should be changed.
> > > > 
> > > > Yes it is an error in the sense it is a timeout, but reporting an error
> > > > because nothing is attached to a PCI slot seems a bit noisy. Please note
> > > > that a similar change was made by the following commit and it also seems
> > > > appropriate here ...
> > > > 
> > > > commit 4b16a8227907118e011fb396022da671a52b2272
> > > > Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > Date:   Tue Jun 18 23:32:06 2019 +0530
> > > > 
> > > >      PCI: tegra: Change link retry log level to debug
> > > > 
> > > > 
> > > > BTW, we check for error messages in the dmesg output and this is a new error
> > > > seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> > > > error, but in this case it seem more appropriate to make this a info or
> > > > debug level print.
> > > 
> > > Can you tell whether there's a device present, e.g., via Slot Status
> > > Presence Detect?  If there's nothing in the slot, I don't know why we
> > > would print anything at all.  If a card is present but there's no
> > > link, that's probably worthy of dev_info() or even dev_err().
> > > 
> > 
> > I don't think all form factors allow for the PRSNT pin to be wired up,
> > so we cannot know if the device is actually present in the slot or not all
> > the time. Maybe we should do if the form factor supports it?
> > 
> > > I guess if you can tell the slot is empty, there's no point in even
> > > trying to start the link, so you could avoid both the message and the
> > > timeout by not even calling dw_pcie_wait_for_link().
> > 
> > Right. There is an overhead of waiting for ~1ms during boot.
> > 
> > We workaround this issue by disabling the PCIe instances in devicetree
> > for which there would be no devices connected.
> > 
> > Thanks,
> > Mani
> > 
> > > 
> > > Bjorn
