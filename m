Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25ED468352
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 09:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354946AbhLDIWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbhLDIWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 03:22:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54D7C061751;
        Sat,  4 Dec 2021 00:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0F5FCE1DF1;
        Sat,  4 Dec 2021 08:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAD7C341C0;
        Sat,  4 Dec 2021 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638605924;
        bh=kty3J+USVyeE4Idv7w5UgZmxLBx3YN1fchmwfdH+rkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCu0DrYlh9Xgrw1Jd8KnaCvZbl/ZyX9WYrT1ZIBB/y2VGYAYLBgY/OS8miTXgLkGf
         Urx7AUMkZsHqf2fjeJTDAwVkpkrqxeDeq8SYPR2DoXwPhwzsJnhSbVTsTjRoVOBN0b
         qrmUv70wUfnPEo8kwFtyD2WuiKOtlBqhc+J/e10s=
Date:   Sat, 4 Dec 2021 09:18:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: PCI: latency
Message-ID: <YaskYBhmI6Hncaey@kroah.com>
References: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 10:30:58PM +0530, Subhashini Rao Beerisetty wrote:
>  [ Please keep me in CC as I'm not subscribed to the list]
> 
> Hi all,
> 
> We are using the Linux OS on an x86_64 machine. I need to measure the
> PCIe latency on my system, does kernel have any latency measurement
> module for the PCIe bus?

How exactly are you going to define PCIe latency?

And what is this going to be used for?

thanks,

greg k-h
