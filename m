Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8F30E111
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhBCR3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhBCR30 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 12:29:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A126A64DF6;
        Wed,  3 Feb 2021 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612373326;
        bh=ZfyEWbXgGE7iB/C+n2dr4ZGiM/wtJqhcSoACDrUJ1rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DF+nSkp88uygLsa6ursDKRCFWs1Onyr6sH1Y1kEzdIFS+mvKIVxONSDcWqn6QgRqE
         h4+HiSwSokND2UoH9hZGcnXVKLOXTAwXSzYoa0mWustO6yKgXP2hQVYmdamqVmIOMe
         21MWiC/WfFxUnMEI5MuB9yxOc5jBcd+JX7RB2NqXg9ZNS4yB1eShMwTwVwcX3BEpkH
         AwQfpfE2B7beo4mPvSkcTG10OLaKb02eAGLpt9C5penuxfY6EG+yhPToXohcDub7i4
         EqhYRrKi96uyJoVPtmse5tarx+AOHUl9ecLItvcNrUkRZp7TL35IKIkJdqWtIBGjzK
         99lO3bkEOf5Ng==
Date:   Wed, 3 Feb 2021 18:28:40 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple
 reset GPIOs
Message-ID: <20210203182840.20381c1b@coco.lan>
In-Reply-To: <20210203134620.GE4880@sirena.org.uk>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
        <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
        <20210203134620.GE4880@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 3 Feb 2021 13:46:20 +0000
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, Feb 03, 2021 at 08:01:53AM +0100, Mauro Carvalho Chehab wrote:
> 
> > +	reg = devm_regulator_get_optional(dev, "pci");
> > +	if (IS_ERR_OR_NULL(reg)) {
> > +		if (PTR_ERR(reg) == -EPROBE_DEFER)
> > +		    return PTR_ERR(reg);
> > +	} else {
> > +		ret = regulator_enable(reg);  
> 
> This is still misuse of regulator_get_optional() for the same reason.

Sorry, it seems to be a badly solved rebase conflict. I'll address it
at the next round.


Thanks,
Mauro
