Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E9218A3
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfEQMxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 08:53:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbfEQMxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 08:53:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so6848055wml.4
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2019 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcYe+aG05w2UO1ZXKc7jrJL+Ovz86Hm2R29bKoYuqSk=;
        b=FTHo35TdEfRpOvLXv+pT5cGeQ2f+MdB7347X2StGrPCzRUBwiMket+1T6L3T9E6Xvq
         9gtotIVK2HrHUJPu9CpHJaoHIgYNXVGCaO3ZL2ScRM+CcgGVyVDtpL8HFb2Ks5JWegeN
         JyTyhlaCT0Y5Pb8gfww3I+xGlje/yVywyQvQC58fhCDKRwox05ecAWJ8t/x1S7VMQcL9
         f41d+JAt35dy8s5waM6jTPjDDK4g36KxR3StdpHYXJ/a04TeWphHCOwE8YqCu7E6UWP4
         H3rj7I51hJq8QZiS47fFOnpWje4QM6AiIQdn8BlPkqNdghkgX4WoQ+alyxhzuGNnTfxR
         ZCaQ==
X-Gm-Message-State: APjAAAW0+TMLLmzbUVjUmh+IKDGc2e8Io09EO9CYptcff8WJgNPDUGfw
        LTULKwvAWEXabWH1qao1E/00zQ==
X-Google-Smtp-Source: APXvYqzvQo4PLIOLgEYS45mThRlVYeoSKfB0i310BFOLRFwKSRuu+NOfl46fdrqxPtJzbnmADzwaFw==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr2040524wmc.94.1558097596479;
        Fri, 17 May 2019 05:53:16 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id q3sm6514366wrr.16.2019.05.17.05.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 05:53:15 -0700 (PDT)
Date:   Fri, 17 May 2019 14:53:13 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel III edition (OSPM-summit 2019)
Message-ID: <20190517125313.GJ14991@localhost.localdomain>
References: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114161910.GB5581@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14/01/19 17:19, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
> May 20-22, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---
> 
> .:: FOCUS
> 
> The III edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 20-22, 2019.

Next week!

FYI, final schedule is online (Italy (GMT+2)):

http://retis.sssup.it/ospm-summit/program.html

Live streaming events have been created and are accessible both from the
summit schedule ("live streaming" links) and at:

https://bit.ly/2Vz3yKg

Best,

- Juri
