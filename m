Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15A22CF7C1
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 01:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLEAFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 19:05:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLEAFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 19:05:50 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607126708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdu+2+gVxGM9DRgyWR7T6Z+kkEunl6zKsXAanmgGQJs=;
        b=RPqSoVzm5R9+At5P1ODCEDVEaB0WEw2cO4aTb7yso55swtfYBJAtEj7Ogg33mXVemb9QiI
        RemFqX9r1xdVI4amHO7KhrOo0qHB4yrXlLWIvp1ZWf8l1qpS7YV70vBkZsBb4a7Pwlc9+v
        pg4FCRvHX5QbwNHw4HGIvCe2bY7hOBkn/lTE6e640ifpuhH0Ni0e+d9EBkGj5l1ZuqMhWV
        mHE5HXQN8CSQUY9CHPf55XcmYlGnl3USuk5dD5hyasje2f/Hyc8d7al4/LLIAkgBJEKrwn
        kATCiDyKncKkWkrbuuhSaVNlZJEW6pS+aR9pabcZYgITkXP4EsZ+WmW1s2j5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607126708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdu+2+gVxGM9DRgyWR7T6Z+kkEunl6zKsXAanmgGQJs=;
        b=WaUih28wxhsPc9lXt/1kuuX57g8Y0qeeP0xxlhL460dqj4p2yfoBEjpo0U4VB7E+XG+Y5W
        0/mhpEHr6GWGwHDA==
To:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel-team@android.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
In-Reply-To: <20201204224135.GA1975685@bjorn-Precision-5520>
References: <20201204224135.GA1975685@bjorn-Precision-5520>
Date:   Sat, 05 Dec 2020 01:05:08 +0100
Message-ID: <875z5h9ky3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04 2020 at 16:41, Bjorn Helgaas wrote:
>
> Applied to for-linus for v5.10 since there's no risk and the bounces
> are annoying.

It's queued in tip irq/urgent already and going to Linus for rc7 :)
