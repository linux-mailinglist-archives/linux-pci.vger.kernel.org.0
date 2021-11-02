Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7B442EDF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBNNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 2 Nov 2021 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKBNNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 09:13:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E12C061714
        for <linux-pci@vger.kernel.org>; Tue,  2 Nov 2021 06:11:05 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhtYt-0004rh-Fm; Tue, 02 Nov 2021 14:10:47 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhtYp-004CFx-W3; Tue, 02 Nov 2021 14:10:44 +0100
Message-ID: <276db30d95bf84cb31f9d9a6c029593fb0ccec21.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] reset: tegra-bpmp: Handle errors in BPMP response
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, thierry.reding@gmail.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 02 Nov 2021 14:10:43 +0100
In-Reply-To: <397003f8-bf3c-68a4-828c-1254710f714b@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
         <20210915085517.1669675-2-mperttunen@nvidia.com>
         <397003f8-bf3c-68a4-828c-1254710f714b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

On Thu, 2021-10-28 at 12:54 +0100, Jon Hunter wrote:
> Hi Philipp,
> 
> On 15/09/2021 09:55, Mikko Perttunen wrote:
> > The return value from tegra_bpmp_transfer indicates the success or
> > failure of the IPC transaction with BPMP. If the transaction
> > succeeded, we also need to check the actual command's result code.
> > Add code to do this.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c
> > index 24d3395964cc..4c5bba52b105 100644
> > --- a/drivers/reset/tegra/reset-bpmp.c
> > +++ b/drivers/reset/tegra/reset-bpmp.c
> > @@ -20,6 +20,7 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
> >   	struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
> >   	struct mrq_reset_request request;
> >   	struct tegra_bpmp_message msg;
> > +	int err;
> >   
> > 
> >   	memset(&request, 0, sizeof(request));
> >   	request.cmd = command;
> > @@ -30,7 +31,13 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
> >   	msg.tx.data = &request;
> >   	msg.tx.size = sizeof(request);
> >   
> > 
> > -	return tegra_bpmp_transfer(bpmp, &msg);
> > +	err = tegra_bpmp_transfer(bpmp, &msg);
> > +	if (err)
> > +		return err;
> > +	if (msg.rx.ret)
> > +		return -EINVAL;
> > +
> > +	return 0;
> >   }
> >   
> > 
> >   static int tegra_bpmp_reset_module(struct reset_controller_dev *rstc,
> 
> I see that you have pulled this into the mainline for v5.15. 
> Unfortunately, this is causing a regression for the Tegra HDA 
> controller. We need to fix the Tegra HDA driver but this is too late now 
> for v5.15 and so we need to revert this change for v5.15. Sorry about 
> this, but I did not expect this to be pulled in so late.

I'm sorry, I picked this up as a fix and went on vacation. Now that
v5.15 has already been released, could you send a revert for stable?

regards
Philipp
