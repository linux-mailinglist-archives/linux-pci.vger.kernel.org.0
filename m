Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4753765CAA5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 01:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjADAOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 19:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjADAOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 19:14:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F61D14015
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 16:14:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C3FB55C0093;
        Tue,  3 Jan 2023 19:14:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Jan 2023 19:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672791282; x=1672877682; bh=4TKYuKdfQV
        cvwDzNtGpQD1/oCLKNN587VbCslOhBRYM=; b=emElJ3slUlIFvvQkdwUCVFQAhy
        0ztPp5KUGviq9iIzo3QHcIHpZc12q7Gb0cN58Xk0LMUT6ovc9a1UHOTarhnhW2Ul
        DY1keo5EjLHAPLzC4pky7mUTllQ2SfyjbpCGdsmJ/+xYuV9V/We1nYGgu3QdtZHD
        aBsU6JQTdgI8O+bHgWWHfC1+w8GEjV8zaZHD7w4mPtmBIV1/MnUUQupU48rvtsu1
        gDwSEpoIGuyDdohaWwEjRV3fiFVMi0uvOWDBdHNH/BY2uWA2SAEn1RmFyYe+eHUG
        RATlFZ9QQtDoIvC6PuNl2uotl7FnAOEY6kkvVtLpGRZeiFAog0S0svi9OekQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672791282; x=1672877682; bh=4TKYuKdfQVcvwDzNtGpQD1/oCLKN
        N587VbCslOhBRYM=; b=HoQLfkYTufvPyTJXZI0atRTiE5Rtp+WcZMyhxhiBYXHr
        SIVf7qgaQcobX70kcfVE9tyIi5gDo7luaLeAvYB1aNe+tMR4OYSDPLThuJWcwi1t
        20pWo/fHPwYjmw8TQIi/V6iQfSBzfFFh8DCHBguTj7e/ibi2HC/zp/tuPhFwa3R7
        1wIc5rDi2ZfIyG9T2diB8l46vPO9RzApjVqj4uP+ZUEFeP+7M88edSrEeSNDIvcP
        Iwk3GknzWJyThwmZUN0Q2pIXy4/nCH9Cbl3IUdq69zJEL2VjIh2smN6ZKD99IVbd
        +33kzViKo5Y9cco+biCvaJ7Rs9ij3GslTMCDn/ATpw==
X-ME-Sender: <xms:8sS0Y69NN6_tkBodnI8gjANhrJsJJwlicV-9-zkZaVVPFQIf50WN9Q>
    <xme:8sS0Y6tpofGpZ4vVU_vkg7K018dJhNJtFpiyH07v8J6lfK-JgDovLCake3PQ9BWsk
    dimH3YXSyFLtvK8Fpc>
X-ME-Received: <xmr:8sS0YwD4rZG75_5Gmyn1rlzwPtfWA1QffDY5_zzEDIhBsHNn5fNCAqEWFt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpeffuedtgffhfedtgffggfefgfejgeekieehleefkeehffffhfduheevgfefgfeikeen
    ucffohhmrghinhepheduvddrphhinhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:8sS0YycExjgxJC99A9C-fHmQPRs6LAxCmA-NpItAJxnDMoY50P_d2A>
    <xmx:8sS0Y_OSQvYg6m2xr0lg9WvgnXqZbotzk2Oq_4JN0VGbQqGvfC8oqQ>
    <xmx:8sS0Y8l_SV2RF0x5K2-xP6kZuSDpRTZZFyUw4JqiUrdXCkrnuU9m4w>
    <xmx:8sS0Y0rnzlNpV94WNzqgo-3l-r9D8aReSgbkkzlb6WdgVVaaph9KxA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jan 2023 19:14:42 -0500 (EST)
Date:   Tue, 3 Jan 2023 18:14:28 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <Y7TE5KXmdY+qrOOi@sequoia>
References: <20221027225149.GA846989@bhelgaas>
 <20221103221429.GA47218@bhelgaas>
 <20221109234146.qkdx5qw4vjdehlgh@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109234146.qkdx5qw4vjdehlgh@sequoia>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-11-09 17:42:10, Tyler Hicks (Microsoft) wrote:
> On 2022-11-03 17:14:29, Bjorn Helgaas wrote:
> > On Thu, Oct 27, 2022 at 05:51:49PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 25, 2022 at 12:07:47AM -0500, Tyler Hicks wrote:
> > > > On 2022-10-20 15:24:37, Bjorn Helgaas wrote:
> > 
> > > > I've been talking to the firmware folks on why SAFE mode was selected,
> > > > based on Keith's question from Wednesday. From what I've been told,
> > > > U-Boot doesn't seed the RP MPS with a value so the kernel sees a value
> > > > of 128 for p_mps in pci_configure_mps() when using the DEFAULT mode.
> > > > Apparently UEFI does seed the RP MPS but we don't get that with U-Boot.
> > > > Therefore, SAFE mode was selected to get an initial, tuned RP MPS value
> > > > set to 256.
> > > 
> > > Are there any devices below the RP at the time we set MPS=256?
> > > 
> > > > > A subsequent hot-add will do nothing in pci_configure_mps(), and
> > > > > pcie_bus_configure_settings() looks like it would set the RP and EP
> > > > > MPS to the minimum of the RP and EP MPS_Supported.
> > > > > 
> > > > > Is that what you see?  What would you like to see instead?
> > > > 
> > > > No, not quite. After hot-add, we see the EP MPS set to 128 with SAFE
> > > > mode even though the RP MPS is 256.
> > > 
> > > Can you add the relevant topology here so we can work through the
> > > concrete details?
> 
> # lspci -t
> -[0000:00]---00.0-[01-ff]--+-00.0
>                            +-00.1
>                            +-00.2
>                            +-00.3
>                            \-00.4
> 
> 
> > > Is the endpoint hot-added directly below a Root Port?  Or is there a
> > > switch involved?
> 
> There's not a switch involved. The multifunction endpoint is hot-added directly
> below the root port.
> 
> > > What are the MPS_Supported values for all the devices?  If there's a switch
> > > in the picture, it looks like we currently restrict to 128, I think because
> > > it's possible an endpoint that can only do 128 may be added.
> 
> 0000:00's MPS_Supported value is 256.
> 
> The multifunction endpoint's MPS_Supported is 512.
> 
> > Ping?  I'd like to talk about a concrete scenario.  It's too hard for
> > me to imagine all the possible things that could go wrong.
> 
> Sorry for the slow reply here. Thanks for your interest in getting more
> details.

Hey Bjorn - I wanted to re-ping you on this discussion since we're on
the other side of the merge window now. Let me know if you need anymore
details. Thanks!

Tyler

> 
> > I guess part of what's interesting here is that things work better
> > when firmware has already configured MPS?  It doesn't seem like we
> > should *depend* on firmware having done that.
> 
> Our firmware folks felt the same way.
> 
> Tyler
> 
> > 
> > Bjorn
