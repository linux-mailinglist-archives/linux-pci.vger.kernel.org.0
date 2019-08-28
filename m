Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D327A0C1D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1VE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1VE5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 17:04:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802D522CF8;
        Wed, 28 Aug 2019 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567026296;
        bh=TJNgnj2hdoueFoeSJjtsLew01E0Lu+5GDGze89PUlkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzGy1sXZcPVNgmIhe0pqXZhuLoece8Imu2jO8KK7xWN2c5Hda1tME0+f9U0J1bFKm
         qfak7rd97WUqRunS0p52U6esPSwIWsHw8RIS9gUVYLjDs5xim2P30ac1oByQ9GdRsL
         krAzA7QPaqpwHhkBpakRLYbsW3BBmkxYYDO/rLmY=
Date:   Wed, 28 Aug 2019 23:04:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
Message-ID: <20190828210453.GA27791@kroah.com>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
 <36db4d65-9a38-03aa-bad1-22b15ebb06c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36db4d65-9a38-03aa-bad1-22b15ebb06c2@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 24, 2019 at 05:41:27PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per default.
> However especially on notebooks ASPM can provide significant power-saving,
> therefore we want to give users the option to enable ASPM. With the new sysfs
> attributes users can control which ASPM link-states are enabled/disabled.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
