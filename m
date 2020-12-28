Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86E2E3462
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 06:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgL1Foi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 00:44:38 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:40765 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgL1Foi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 00:44:38 -0500
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4D46134tzFzfFY;
        Mon, 28 Dec 2020 00:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1609134232; bh=C49VBnc7b16ypJBbXONSWN2vexJOG7VxxTVZAqMLwJ0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=Njg6F5jd9B5hah4ch2aWcVebBe1hcTvbJC3JQgN8wPqq5uA5ThYz7aH/Tvin3xIxa
         f8MHRnYS4/3a3XxSzTFxP6S8xID3CbSpCndpECGjXEyBKUBWZn47zIIEcdPF8uEm8T
         sT7Qv2q1+ptilFm6A8evL2cefcKiUf0lQ2wQ4BSY=
Date:   Sun, 27 Dec 2020 21:43:49 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
In-Reply-To: <20201228040513.GA611645@bjorn-Precision-5520>
Message-ID: <88d569d8-09c-6bfc-c246-f4989bfbc1@panix.com>
References: <20201228040513.GA611645@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


OK, got more info:

On Sun, 27 Dec 2020, Bjorn Helgaas wrote:

> If it's convenient, can you try the patch below?  If the debug patch
> doesn't help:

>   - Are you seeing the hibernate/resume problem when on AC or on
>     battery?

OK, so:

- on TLP, before your patch, it panic()s on AC, but not on battery
- on TLP, with your patch, it panic()s on battery, but NOT on AC
- if TLP is masked, it still panic()s, but I forget if AC or battery
- even if I mask TLP, with your commit in place it panic()s

>   - If you revert 4257f7e008ea, does hibernate/resume work fine?  Both
>     with the tlp tweak and without?

Definitely with the revert everything works. I'll try your patch after the
revert and see if anything changes.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
