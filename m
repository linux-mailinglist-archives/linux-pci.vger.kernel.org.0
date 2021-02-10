Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6A316BF8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBJRAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 12:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhBJRAk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 12:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C979564DF6;
        Wed, 10 Feb 2021 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612976400;
        bh=OmIhHMxRZ50Ed961Qh4lDQ91A3L9gd/vVHzZhe9w3Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVjB2d5rm47xRUnQqhYPCgPGyhU/TohcbSjobFXPYMRlPAgWHpxZ2GcDL2FT9qUDX
         HWytabXu8Fp1GwCZ33nw8c8J2GLJL56n6oYafrIqg3xl6H1mvtUrOJ1ztQR03+cxnn
         ZAY6eox5Cy6wJqNXyLcRuGMZVCnBnSB4ntbUmoZ9Q9dXdQHsa43N4QMxVX2v0R6Fvo
         8QO7PFICDCtwHBzBXfHgQajKI5krPdUV/Fuc/ppRB/g3rgQRo6tUdA7ajhz3/E2TsS
         sRHjl8jaNRB5q2Fdfc06bn80rXNg1q0n4Mjfw9R1sCHg4XL9TnRXBX1ZayaOVoRxzy
         3r6wMZMi73n2Q==
Date:   Thu, 11 Feb 2021 01:59:53 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/ERR: Fix state assignment
Message-ID: <20210210165953.GC23363@redsun51.ssa.fujisawa.hgst.com>
References: <20210210151604.2678236-1-kbusch@kernel.org>
 <YCQGYu/7jywLktlw@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCQGYu/7jywLktlw@rocinante>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 05:14:26PM +0100, Krzysztof Wilczyński wrote:
> Hi Keith,
> 
> [...]
> >  	if (new == pci_channel_io_perm_failure) {
> > -		dev->error_state == pci_channel_io_perm_failure;
> > +		dev->error_state = pci_channel_io_perm_failure;
> [...]
> 
> Ouch!  Nice catch.

Heh, the 0-day build actually caught this one, so credit to the bot! :)
