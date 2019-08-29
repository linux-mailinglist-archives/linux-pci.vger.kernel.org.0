Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C00A156F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfH2KJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:09:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfH2KJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 06:09:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C7128;
        Thu, 29 Aug 2019 03:09:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A7693F59C;
        Thu, 29 Aug 2019 03:09:36 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:09:34 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828214901.GM4298@sirena.co.uk>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 10:49:01PM +0100, Mark Brown wrote:
> On Wed, Aug 28, 2019 at 10:26:55PM +0100, Andrew Murray wrote:
> 
> > I initially thought that you forgot to check for -ENODEV - though I can see
> > that the implementation of devm_phy_optional_get very helpfully does this for
> > us and returns NULL instead of an error.
> 
> > What is also confusing is that devm_regulator_get_optional, despite its
> > _optional suffix doesn't do this and returns an error. I wonder if
> > devm_phy_optional_get should be changed to return NULL instead of an error
> > instead of -ENODEV. I've copied Liam/Mark for feedback.
> 
> The regulator API has an assumption that people will write bad DTs and
> not describe all the regulators in the system, this is especially likely
> in cases where consumer drivers initially don't have regulator support
> and then get it added since people often only describe supplies actively
> used by drivers.  In order to handle this gracefully the API will
> substitute in a dummy regulator if it sees that the regulator just isn't
> drescribed in the system but a consumer requests it, this will ensure
> that for most simple uses the consumer will function fine even if the DT
> is not fully described.  Since most devices won't physically work if
> some of their supplies are missing this is a good default assumption.  

Right, if I understand correctly this is the behaviour when regulator_get
is called (e.g. NORMAL_GET) - you get a dummy instead of an error.

> 
> If a consumer could genuinely have some missing supplies (some devices
> do support this for various reasons) then this support would mean that
> the consumer would have to have some extra property to say that the
> regulator is intentionally missing which would be bad.  Instead what we
> do is let the consumer say that real systems could actually be missing
> the regulator and that the dummy shouldn't be used so that the consumer
> can handle this.

And if I understand correctly this is the behaviour when
regulator_get_optional is called (e.g. OPTIONAL_GET) - you get -ENODEV
instead of a dummy.

But why do we return -ENODEV and not NULL for OPTIONAL_GET?

Looking at some of the consumer drivers I can see that lots of them don't
correctly handle the return value of regulator_get_optional:

 - some fail their probes and return upon IS_ERR(ret) - for example even
   if -ENODEV is returned.

 - some don't fail their probes and assume the regulator isn't present upon
   IS_ERR(ret) - yet this may not be correct as the regulator may be present
   but -ENOMEM was returned.

Given that a common pattern is to set a consumer regulator pointer to NULL
upon -ENODEV - if regulator_get_optional did this for them, then it would
be more difficult for consumer drivers to get the error handling wrong and
would remove some consumer boiler plate code.

(Of course some consumers won't set a regulator pointer to NULL and instead
test it against IS_ERR instead of NULL everywhere (IS_ERR(NULL) is false) -
but such a change may be a reason to not use IS_ERR everywhere).

As I understand, if a consumer wants to fail upon an absent regulator
it seems the only way they can do this is call regulator_get_optional (which
seems odd) and test for -ENODEV. I'm not sure if there is actually a use-case
for this.

I guess I'm looking here for something that can simplify consumer error
handling - it's easy to get wrong and it seems that many drivers may be wrong.

Thanks,

Andrew Murray
