Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014FB36E07C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhD1Upj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 16:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhD1Upi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 16:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C2361289;
        Wed, 28 Apr 2021 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642693;
        bh=RBtEYb+9X34kYYQ5r2JH+1KyfH8AH6vFwS4Xncp/xcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UN+pjLCaSMy2qR7/Gqdw5lc2alAu6aWreYLUYyq5bChAkUOjy/ckL2Hw/MxliICtO
         jHfit+TEX7FwKaDv1aiUGgwEwIMaAd4EjA0L+hL7VGo0O7xW4bAUg/joEcC8uYI+0O
         bfSJOGSWMxRKFc/18S7clMsp1XcVLD6f2AIOvmCh5ReDOhGt8uXPfeV/13nK8gdBn8
         cMejyDsDohu2fDpU7CH378w3T4LiL/a/RQQs1gspp3eU1YYHp1+LOaR3MC69P4KcIU
         9IzrAnAk3KBjolGPdpea/OY9aWwvv3T8v4woQvdmVraOJCXlMQmaI/2p4DMaelnPX7
         EJNGAdwOiDR1A==
Date:   Wed, 28 Apr 2021 15:44:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: Conflicting commits changing VPD sysfs attribute to static
Message-ID: <20210428204451.GA426926@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96350860-b9d2-b278-860a-a0e886723b3a@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 08:31:28AM +0200, Heiner Kallweit wrote:
> 85725825c10a ("PCI/sysfs: Convert "vpd" to static attribute") duplicates
> what 1e3b0fb5e4d1 ("PCI/VPD: Convert sysfs file to static attribute") did
> already. So this will conflict once you merge pci/sysfs.

Thanks for the heads-up.  I tried to meld 1e3b0fb5e4d1 and
85725825c10a together and put the result on pci/sysfs along with the
other static attribute changes.  Let me know if you see anything I
messed up.

Bjorn
