Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A1555560
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiFVU0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFVU0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 16:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A136682;
        Wed, 22 Jun 2022 13:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0470061738;
        Wed, 22 Jun 2022 20:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2427CC34114;
        Wed, 22 Jun 2022 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655929605;
        bh=kXEUTw/N4tbohAVX+9EPs5JvigCwZ5p1wSKw76VkLGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LxVMS/Q/AXjq/CFLjx4GJiLjQKJ1DETmISnpLERNDTg2bTZi4w9aDIBxvLnuWHHlP
         uMOqpinUDwRQ+HTyi7KMHnZXBnVNrcnH/UxO8QsTWuwAJ7kdPuCvRgke06RfZxQZt7
         QgEL+qw7tt9eRLTpjPoy7ssl0bW/Tyjx5mt1eNzRdQ+1zLOSY0fxJbjLJDF8D0cahZ
         nDWudeSbzuQUmMQ4tlgD5EEkUGAZ1IJ66qk3fgaONAN4C8A/znTSv2/BJZuhZJtOGZ
         b5OYUF+e4/fmbJ4zisPg/pv7Mlrd0UahYo0SSImMXQ5rb4mVfhbixGAom1IIeVs0wR
         niIalZUMbk1mQ==
Date:   Wed, 22 Jun 2022 15:26:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <20220622202643.GA1387264@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU6isNEF4LYRDUEjnKwOcsEoPJR2ekn2kD9RjKFwusF4DA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 04:23:49PM +0200, Robert Marko wrote:
> On Tue, 21 Jun 2022 at 23:43, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 21, 2022 at 11:05:17PM +0200, Robert Marko wrote:
> > > On Tue, 21 Jun 2022 at 22:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > > > > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > > > > cause the system to hang as its using DBI registers in the .init
> > > > > and those are only accesible after phy_power_on().
> ...

> > Unless there's a reason *not* to move the DBI accesses for other
> > variants, I think we should move them all to .post_init().  Otherwise
> > it's just magic -- there's no indication in the code about why IPQ8074
> > needs to be different from all the rest.
> 
> I am not sure how to do it properly, especially for the 2.1.0 IP that
> IPQ8064 uses
> and that is already filled with tweaks to get it properly working.
> 
> As far as I can tell, the reason why it works for all of the others
> is that they dont use a PHY driver at all (2.1.0 in IPQ8064 and
> 2.4.0 in IPQ4019), 1.1.0 in APQ8084 appears to be unused completely
> as its compatible is not used in any of the DTS-es.  2.3.2 in
> MSM8996 and MSM8998 also use QMP, so I am not sure why these work.
> ...

> This patch applies to 5.19 as well, though I will send a v4 with the
> updated description.  Like, I said, I am not sure how to move DBI
> accesses in other IP-s without breaking them.

Why would they break?  I don't see anything that indicates the DBI
accesses are required to be before phy_power_on() or would fail after
phy_power_on().

I agree there's always a risk of unintended breakage.  It just doesn't
seem very likely.

Bjorn
