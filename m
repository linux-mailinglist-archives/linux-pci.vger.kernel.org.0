Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79427EF3F4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjKQODZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKQODZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 09:03:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A98A3;
        Fri, 17 Nov 2023 06:03:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8321EC433C8;
        Fri, 17 Nov 2023 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700229801;
        bh=+YyWYw/YzYJ+SPOs/yiZevHVY0O0qocR6W15SI2TW+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDU74y+5cXrh06NB2CxYyBRr1mU1l22/wxgbBKqx0psUVhiEdgtG2EervVZOQg1zD
         H9NTbgQzvCFrY0t6SMhJUhJCeswoZ05RkCu+Y+oYqJIvJcXyEqeMToJbi1r0gYnKg8
         lPhPbOKBw29M+ITZOsdBV1c9OhJ7ZwrlI0IImxDVRJ77HMdeZGycumPmA233Wi8I97
         DYGPfSaT2CCIAy41n1FXeNKbArse/uxSwpkvoCirBDD8TcFG+DVLFc76ftKHMl5qF1
         XLYLIsEvSvmuxx3GFo0zJSKhsaBIYVbLkMyUj6RJxmtjcmV6q9arbWNYkiiKMshd4O
         C4TodqHX9b+TQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3zRM-0004DS-17;
        Fri, 17 Nov 2023 15:03:24 +0100
Date:   Fri, 17 Nov 2023 15:03:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: qcom: Clean up ASPM comment
Message-ID: <ZVdyrGXyahM7bxwh@hovoldconsulting.com>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-5-johan+linaro@kernel.org>
 <20231117103227.GM250770@thinkpad>
 <ZVdE6nqanqcaL8sO@hovoldconsulting.com>
 <20231117105404.GR250770@thinkpad>
 <ZVdH3GkzWupoxyzJ@hovoldconsulting.com>
 <20231117112352.GS250770@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117112352.GS250770@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 17, 2023 at 04:53:52PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 17, 2023 at 12:00:44PM +0100, Johan Hovold wrote:
> > On Fri, Nov 17, 2023 at 04:24:04PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 17, 2023 at 11:48:10AM +0100, Johan Hovold wrote:

> > > > The coding style clearly states:
> > > > 
> > > > 	The preferred limit on the length of a single line is 80 columns.
> > > > 
> > > > 	Statements longer than 80 columns should be broken into sensible chunks,
> > > > 	unless exceeding 80 columns significantly increases readability and does
> > > > 	not hide information.
> > > > 
> > > > Going beyond 80 chars may sometimes be warranted for code, but the
> > > > exception is not intended for comments.
> > > 
> > > Breaking the comment here is indeed making it hard to read. It's just one word
> > > that needs to be broken if we go by 80 column limit and I won't prefer that,
> > > sorry!
> > 
> > Please read the above quote again, it is as clear as it gets. 80 chars
> > is the preferred limit unless (for code) exceeding it *significantly*
> 
> Where does it say "code" in the Documentation? As I read it, the doc weighs both
> code and comment as "statement".

No, comments are not statements (in C).

You'd also never even consider interpreting it that way if you knew
where that exception comes from (namely that people break long
*statements* just to fit under 80 chars, thereby sometimes making the
*code* unnecessarily hard to read).

> And how on the world that breaking a single word to the next line improves
> readability? I fail to get it :/

You got it backwards; you should only go *beyond* 80 chars if it
"significantly increases readability".

But again, this does NOT apply to comments in the first place.

> > increases readability, which clearly isn't the case here (even if this
> > exception applied to comments).
> > 
> > I really don't understand why you keep insisting on this. Just fix your
> > editor.

> But I do not want to get into a spat here. Checkpatch, the tool supposed to
> check for the kernel coding style is not complaining and I do not want a patch
> that _fixes_ a coding style that is not an issue.

Checkpatch is just a tool, not the standard, and knowing when it is ok
to break the 80 column rule for code requires human judgement.

Johan
