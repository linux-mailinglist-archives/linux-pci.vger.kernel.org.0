Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E400A3ABD50
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhFQURd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 16:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhFQURc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 16:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 662FF613D8;
        Thu, 17 Jun 2021 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623960924;
        bh=L9FplHBnsT4DdGAjNwBoZQiikqRViJZ8+NMc/aNkOAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dWY/gRmg8kph/qjI/K1gLLsyrOeYNJhLgXUWRlznBt+Blgng7S/7x7WsVBaquYYO3
         OkrVUaMT8zBsFzz59PAR+3MJPEiG7Z8wty2lhmZGmRYBhYZ6slJT3c/XpX7jC69kBL
         lht1ccQldDhWB2o4U3sKYA7o56bo7nKjBZ+DTQsoTOUn9VwuAHGBS8khslDDzoaic5
         znHOBuu1nGn/Dg8SoCUKoMT8xS+RNj08+w8igyA33ch2+dnUpTRM5nRpcXfBqoS1gG
         rYTdr4nJM0IKro6C1uXMQN/fXka5On3dci1Lha+AwELRsO+2CdIGqNKGOW38A6WFXc
         PfRfCtWvWPSRA==
Date:   Thu, 17 Jun 2021 15:15:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: aardvark: Fix kernel panic during PIO
 transfer
Message-ID: <20210617201523.GA3104553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162322862108.3345.4160808336030929680.b4-ty@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 09, 2021 at 09:50:39AM +0100, Lorenzo Pieralisi wrote:
> On Tue, 8 Jun 2021 22:36:55 +0200, Pali Rohár wrote:
> > Trying to start a new PIO transfer by writing value 0 in PIO_START register
> > when previous transfer has not yet completed (which is indicated by value 1
> > in PIO_START) causes an External Abort on CPU, which results in kernel
> > panic:
> > 
> >     SError Interrupt on CPU0, code 0xbf000002 -- SError
> >     Kernel panic - not syncing: Asynchronous SError Interrupt
> > 
> > [...]
> 
> Applied to pci/aardvark, thanks!
> 
> [1/1] PCI: aardvark: Fix kernel panic during PIO transfer
>       https://git.kernel.org/lpieralisi/pci/c/f77378171b

Since this fixes a panic and only affects aardvark, I cherry picked
this to my for-linus branch.

Can you drop it, Lorenzo?  It's currently the only thing on your
pci/aardvark branch, so I just dropped that whole branch from -next.

Bjorn
