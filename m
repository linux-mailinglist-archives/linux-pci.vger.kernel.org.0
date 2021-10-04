Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387942096A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJDKmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 06:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJDKmt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 06:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3301961372;
        Mon,  4 Oct 2021 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633344061;
        bh=YNX0rx3+r7oMKT+8ZenUdTgp0D0UXksTNWtdWMgunAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGauOJg0qCA/L/l8EdWyl44OL81Dhu8aGgSkjnkWZ2C47zdysaQIn1Wlf2/4mofi1
         I0o2jSpx4aNzDnUZiotf1NsZQ/+S/4nHaOrV1K37cBXAyQ2qBcAIC1X5SIQU4P2Erz
         unE79DCHVaqudklMdQaaTbhRwQgctsZ7vOdHWEvHxXh1HKPRknZgQ5kyXllRTWDA0k
         0/DNT41CeOapihOhKTCxX4d9bK3ONwwgCHXsvSK9PQFXgGVb9SZthdZmDlomJg0PSB
         /Ui1fOrh5nyDD+/J+NiV7P7gTeheCPtIKtwofwqaNzwDaQyjZP1VK4cD/4Bharj/EG
         0HyLkbLoOoeZw==
Date:   Mon, 4 Oct 2021 12:40:55 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 00/13] PCI: aardvark controller fixes
Message-ID: <20211004124055.752496d6@thinkpad>
In-Reply-To: <20211004095351.GB22827@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
        <20211004095351.GB22827@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> OK, so what's the overlap between this series and:
> 
> https://patchwork.kernel.org/user/todo/linux-pci/?series=506773
>
> https://patchwork.kernel.org/user/todo/linux-pci/?series=507035

Lorenzo, both those patch series are superseded by this one and the
following I plan to send once this one is applied (since I wanted to
avoid sending 60+ patches in one go).

(From the first series you applied one patch:
  PCI: aardvark: Implement workaround for the readback value of VEND_ID

 Another patch
  PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
 got an Ack from Bjorn, but was not applied, so we sent it again (the
 1st patch in this series). Now we have also Bjorn's Reviewed-by for
 that patch.)

Regarding links to patchwork, I am unable to see patches not delegated
to me (I can't remove delegate=kabel filter), so I can't set their
status to Superseded myself.

> I need to keep track of reviews in the series above and make
> sure they are reflected into *this* series if some of the
> patches overlap or they are a rework.
> 
> Please let me know, thank you.

