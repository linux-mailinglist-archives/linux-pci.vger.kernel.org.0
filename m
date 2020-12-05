Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11C82CFF30
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgLEVXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Dec 2020 16:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLEVXy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Dec 2020 16:23:54 -0500
Date:   Sat, 5 Dec 2020 15:23:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607203394;
        bh=FufiC1afJA8lTp7nDlXjnmCwVGnC5HpBKUnHKXXS9xk=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=TZk/iZvKcEWgrmmjU3so2Reu0zNCmWChVJ7PGAdWJSkyPfJlpWFLT0mKbdssFcS5A
         MG8TSaY1SfbMTlbY+q7+BrBe6geNFS1fiD+BoRkQ2Wkc2f7NnUcGTO2ltmtAJloOdL
         C+kuu9Qmw3XhP6pmrtwV88be9V+QlZs4/MOBqkPRbOVaeggEOZCSdaLK0yVzifaaSc
         B7PLrTqGU9HIV/hiqhMOHo5gSriw1hC/XOSk+TFPAWsP3bjqLlnVo9wVaaC344BgUQ
         z8LnyKxTLEuoHmPPv1tpdNPF4WUh0yHCR0ZdOB28VdavzdRmXNCRBccVA13TVFIai/
         0nBYiwAGzWvIQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel-team@android.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
Message-ID: <20201205212312.GA2092372@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5h9ky3.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 05, 2020 at 01:05:08AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 04 2020 at 16:41, Bjorn Helgaas wrote:
> >
> > Applied to for-linus for v5.10 since there's no risk and the bounces
> > are annoying.
> 
> It's queued in tip irq/urgent already and going to Linus for rc7 :)

I dropped it, thanks!
