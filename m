Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F01C836F
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 09:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGH3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 03:29:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbgEGH3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 03:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588836583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqHWm03cdWE9AeodDX2gtE5xAzgCwXmdJaTKNX0BlUA=;
        b=eeVEUetIdm7Dj0XSGmNhpOJH3qJ2W/CubleUNBObLQSUTv53iM6valDLMsjt6t0qQJzSuM
        QP8iRXOewI0uAAaucE4alWo8PSrb15CcL61eXQwgR6N6UEua7F5b8NRvpfUBmN466+9AOY
        GCCLiF1MNODXAL5fAsPXQn9PIn1LNek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-9obbNRY2Opm1XuuQYQtYMQ-1; Thu, 07 May 2020 03:29:36 -0400
X-MC-Unique: 9obbNRY2Opm1XuuQYQtYMQ-1
Received: by mail-wm1-f71.google.com with SMTP id s12so2817298wmj.6
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 00:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqHWm03cdWE9AeodDX2gtE5xAzgCwXmdJaTKNX0BlUA=;
        b=lI/LjzYbZcurxhG6WA80WWuBY8TyegYO6GwS0rUns/SyIHxS/V3nM+ySffgKv02N04
         pMlBQzk05xKBLY9BaWmb6L7tFe41NjH2nCdfmdxyr2rU5POBuPKwZNAmy3UyYTv+aulM
         GAJ53jac5fjxZJkt/NSBiaMN3GJfKOky3ZB9hfFGYMfJHRj+qchnO8xtl1kzlNA8LmPm
         7836gXVYhSVZWlDdeYWRTe+Ckz1PlI5oeEZMEF11HiHNmphxmE59U5jm3ezRTSPBXZJg
         4MnD1JKyzrYQCFya0GRos8AWBnJXT6nJOeB8NBhwnIyjTLfXhfSTJsxM8o2ipY6RNhxW
         4y8w==
X-Gm-Message-State: AGi0PuaNnb5t2Hht1KjW+z2b24gBiwA79ACb14fRvad2vMYe5KdOq6EY
        NCL8Rtnl7PBHY5trPtzGGXKjoK4H0vcJG49mOh/x8VY0AHWQWVr768YKCIEOChrZHNvjqPPNnAR
        bsQ9dM4Yn0OyjVRN89gOK
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr13722760wrs.91.1588836574140;
        Thu, 07 May 2020 00:29:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKW/afKgcN6Ys3SlaqvJeC2tMA76ui4ITX8WaKt12BBr/x/h/A/RJ6Rv71x5W9jITqlLYoytg==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr13722718wrs.91.1588836573396;
        Thu, 07 May 2020 00:29:33 -0700 (PDT)
Received: from localhost.localdomain ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id z11sm6487512wro.48.2020.05.07.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:29:32 -0700 (PDT)
Date:   Thu, 7 May 2020 09:29:30 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20200507072930.GM17381@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 

Quick reminder that OSPM-summit IV edition is happening next week!

Not in Pisa (for obvious reasons :-/), but online, kindly hosted on LWN
BigBlueButton server. Thanks a lot to Jon and LWN for this opportunity.

> .:: FOCUS
> 
> The IV edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 11-13, 2020.
> 
> Although scheduler techniques for reducing energy consumption while
> meeting performance and latency requirements are the prime interest of
> the summit, we welcome anybody interested in having discussions on the
> broader scope of real-time systems, real-time and non-real-time
> scheduling, tooling, debugging and tracing.
> 
> Feel free to have a look at what happened previous years:
> 
>  I   edition - https://lwn.net/Articles/721573/
>  II  edition - https://lwn.net/Articles/754923/
>  III edition - https://lwn.net/Articles/793281/

[...]

> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!). Registrations open on February 24th, 2020.
> 
> To register fill in the registration form available at
> https://forms.gle/7LfFY8oNyRxV1wuQ7

Since we don't have real rooms constraints, registration is still open.
Everybody is more then welcome to join us. Please use the form above to
register. Details about how to join will be provided after registration
completes. You can also reach out to me directly.

Schedule (still subject to small changes) is available at
https://bit.ly/2WAtsjy (CEST tz).

> .:: ORGANIZERS (in alphabetical order)
> 
> Luca Abeni (SSSA)
> Tommaso Cucinotta (SSSA)
> Dietmar Eggemann (Arm)
> Sudeep Holla (Arm)
> Juri Lelli (Red Hat)
> Lorenzo Pieralisi (Arm)
> Morten Rasmussen (Arm)
> Claudio Scordino (Evidence SRL)

Thanks also a lot to Scuola Superiore Sant'Anna of Pisa, Arm and
Evidence for helping put this together for the 4th consecutive year.

Looking forward to meet you all soon.. virtually. :-)

Best,

Juri

