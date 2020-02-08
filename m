Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1315672A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHSlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:41:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36041 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHSlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:41:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6236464wma.1
        for <linux-pci@vger.kernel.org>; Sat, 08 Feb 2020 10:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yuFklzcmtRlyLzv28Ill1R4mgHWH5TmE6qKQbk/+SAw=;
        b=PC7GCXBLVaH++NIE2VO7Iz9G/Y/xg+cgxbNn/Mb5pX0FZoyds4F6n2d+vpiLq277RG
         0YSAFlcouBuJRAtwPPUONwgacaa2cHeCAXLQB4YJOS8a0NYPwatgK/Bh1YKlcrV6E/vI
         oQZGn8dng8h1jiQl6B8uafkRWemydqoinVXJzMOYVkF8HIhJshQAnXjY822aVvLKc98N
         NSUiESBI6TjVBz//88dLXEQZZC48wfozkvmpIHES+0XpJLtk506iuTNYhtMMuZmByA7D
         DTL+racOYWYdvwHLkcAFgxZ8nQ5LjiGtYS174Q6WDWXRfuN3KURY5U2+c2DjfXzCCfLy
         0JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuFklzcmtRlyLzv28Ill1R4mgHWH5TmE6qKQbk/+SAw=;
        b=Ar8Noz5sFy0UYHlBbf22iw3cZDlNAiouWb1jFicNEM4J1d9BTzDOQRldI8lVmvPmT/
         abcFX9rA+1O0me3JnNeLbSIZ62C6kmjRCzjKCTQ2KkeBp3wm9J/LnLi0JzjPsOvZqjSz
         RtZlaW9XIAYk7AUBs9FcQQO7tdHw3jS6tSw/f7SbsLfGTpduB5mOeAnamvEmxzqAFTCj
         d+Zjj6l0fgUG7O+tsZLZf3PawHVrLeSNmt0ZXdrUS/x2PBSm84l56Q/jsKbi1lo61jp4
         EipVUXXTsRM4Lf/yMJoNMxiFapI0oBsFdpIGg2lG0IPF1tfa1LWAsr8YavM6s+O1Y7xM
         BpBg==
X-Gm-Message-State: APjAAAUPtc4v2KxNja0FwsG1Ss2U50OJKn0QIwlew4gwzp1+JDcpULt6
        2M751z66ErixxR8vyzfG9+v0w00Upqs=
X-Google-Smtp-Source: APXvYqzm1fxtYdTOVS15Th1+jHBLOfEKmyzv8y7MpeitOvzf+LvrpOfxMrHYnN2nQpTT2F0aHIRgng==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr5517319wme.53.1581187309223;
        Sat, 08 Feb 2020 10:41:49 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:201c:bfcb:d69f:2329])
        by smtp.gmail.com with ESMTPSA id k7sm7984506wmi.19.2020.02.08.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:41:48 -0800 (PST)
Date:   Sat, 8 Feb 2020 18:41:47 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: rcar: Fix incorrect programming of OB windows
Message-ID: <20200208184147.GC19388@big-machine>
References: <20191004132941.6660-1-andrew.murray@arm.com>
 <20191216120607.GV24359@e119886-lin.cambridge.arm.com>
 <0e6e7353-c92b-d819-771b-f9b58684a3d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6e7353-c92b-d819-771b-f9b58684a3d4@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 08, 2020 at 10:46:25AM +0100, Marek Vasut wrote:
> On 12/16/19 1:06 PM, Andrew Murray wrote:
> > On Fri, Oct 04, 2019 at 02:29:41PM +0100, Andrew Murray wrote:
> >> The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
> >> a CPU address (which is determined by the window number 'x') and a
> >> programmed PCI address - Thus allowing the controller to translate CPU
> >> accesses into PCI accesses.
> >>
> >> However the existing code incorrectly writes the CPU address - lets fix
> >> this by writing the PCI address instead.
> >>
> >> For memory transactions, existing DT users describe a 1:1 identity mapping
> >> and thus this change should have no effect. However the same isn't true for
> >> I/O.
> >>
> >> Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
> >> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> >>
> >> ---
> >> This hasn't been tested, so keen for someone to give it a try.
> >>
> >> Also keen for someone to confirm my understanding that the RCar windows
> >> expect PCI addresses and that res->start refers to CPU addresses. If this
> >> is correct then it's possible the I/O doesn't work correctly.
> > 
> > Marek/Yoshihiro - any feedback on this?
> 
> It does indeed look correct,
> Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> # On R8A77951 Salvator-XS with Intel 8086:f1a5 600P SSD
> # On R8A77965 Salvator-XS with Intel 8086:10d3 82574L NIC
> Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for testing - much appreciated!

Andrew Murray
