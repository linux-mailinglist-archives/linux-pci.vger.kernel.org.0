Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D374B3A9EBC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhFPPR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 11:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233931AbhFPPR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 11:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F02B261166;
        Wed, 16 Jun 2021 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623856520;
        bh=uMZie5RWKEcyCPorkI5+nQfRysgXeQmrGBXqGAxJ3To=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Oy9jCgLfsNMrKeOGACgaImnTqfcsnjZigIQ70vQ/Z686+xblHZRSKIPm93J2U/tLy
         7CbYOeFhwgzeONorEr4T8+Mk5bWjw8iUESF04Zy+IRrYVkWCVZO95j3WJLEIRlOUCE
         Jq9+npaTeK5Fj+iKdW+dBKftXyTbnEOQuOxye4SRWogxjGfsoMTXCvnBD2aWe70Etr
         KT115oWzZWGYp+PmWZWhBxJl0kZdNo0Cf2wUvKV7lT4cQJdToC7W2TAICVogVnE31c
         HpuwVRU3NR6a6FjGcobFA7kjqmmxkZweGOLv2mb+AokZbeUGxe0kUN+DozfdGFgSLM
         No74BB4WcNKLQ==
Date:   Wed, 16 Jun 2021 10:15:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6] PCI: ixp4xx: Add a new driver for IXP4xx
Message-ID: <20210616151518.GA2977529@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZjr=Rakdga6RpyWu6Amf0UFkpTtQ=rZ3-7T4xua8ziJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 03:10:08PM +0200, Linus Walleij wrote:
> On Wed, Jun 16, 2021 at 1:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > - Bjorn I understand you have a lot to do but could you give
> >   this driver a quick look and ACK? Arnd and Lorenzo have
> >   reviewed it already.
> 
> I realized that this should be enough for the host driver, sorry
> for stressing. I will merge this through ARM SoC now.

Lorenzo is away this week, but there should be no problem getting this
merged either via PCI or ARM SoC.
