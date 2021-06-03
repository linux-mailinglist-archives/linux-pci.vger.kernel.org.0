Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1C39A698
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCREk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 13:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhFCREk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 13:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AF74613C9;
        Thu,  3 Jun 2021 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622739775;
        bh=O6NOUaKgzbYFsX5Lzl4BmVAchR/zLTywxKBCZMccuWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkLn7TRVk8848CsbgwxHgS+YDVLBpP0hT0YssguUgEi/tmAJ4J0allFYEjaVaNlKf
         uMeHQFQgke+ORea3E/2xWshTAp08+ei1TecprNMJC+6kdlMIWHY2OsVyI1ey0Eh/YW
         rEwn6yqfTChiP284/YvGKhucasYz8RsQHYOzxOiUyPV2i1B//V+seYWFd2c8HN3Zv+
         +BVKrY/7vGCctpc2fCtWkqU6yFVB6s3hiu5MmAHGmoOpCUfruzzuz8gsXQeCqh8fmW
         XL5Caly0WGDej+Stz8urXFVhU42I9mv44jbHZI4hYoCvzwMS+JWo5KZtHLSjyoxoR1
         06WnkkQmcHRBw==
Received: by pali.im (Postfix)
        id 068341229; Thu,  3 Jun 2021 19:02:52 +0200 (CEST)
Date:   Thu, 3 Jun 2021 19:02:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/42] PCI: aardvark: Various driver fixes
Message-ID: <20210603170252.vxeqyvnoepgumyu4@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210603151605.GA18917@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603151605.GA18917@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 03 June 2021 16:16:05 Lorenzo Pieralisi wrote:
> May I ask you please to split this series in smaller sets so that
> it is easier to merge ?

No problem!

> Let's start with the more urgent fixes that don't involve rework (or
> you have not received change requests for since they are simple).

Ok, I will do it.

> Thanks,
> Lorenzo
