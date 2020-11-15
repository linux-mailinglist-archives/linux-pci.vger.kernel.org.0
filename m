Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91362B32B0
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKOGTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 01:19:41 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51205 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgKOGTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 01:19:41 -0500
Received: by mail-wm1-f47.google.com with SMTP id 19so20448464wmf.1;
        Sat, 14 Nov 2020 22:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m2k+jXkCTT8AyJtZmh8dXLdTOAO5+++5VuzTxxdVjaA=;
        b=stn6go7mLtOxEj43cm1lGzCLhEaVk1ovK0HsslXF5DG2Db7hEOntlAcR8tzgeNWPeX
         dMz6fIZCW0Mp0JghNp40eqeMa3Ay3ULL3kywhW4rKvYeStvHJPcNA9hXsoX641M/nW1n
         3KbRk/rnuQyDmMZWGHIshrafR5x5WB95EWFNVHKLjwA+exv0zcHXbRblRMorsbNYxz7m
         AOq0hD+JO6yRQqAo3mza912SR3qqliobNb3zwHzdv0yppmzD90/xkBnKBDxNo1FV/0G7
         dHW/DWLJrNN1dK4aY6lk0rILFt7E0lVw2u62HB6qBHAbjqYxa3g6Gvp/vKIPgn2T8cUj
         lW7w==
X-Gm-Message-State: AOAM533iQ7/rc+nfvAdH2l1BHMMSUlKwPpAfPcZRXh3CpFh37HVgnCJP
        WpM4hMNjHX7RaWxDuB/FSns=
X-Google-Smtp-Source: ABdhPJxlnhRokfdT7Ykzm/yBO4HrN33xEkq6Ahv6bP8YU7Hn7OqIVw9WeM9man48fIGe3vgzPRIIcA==
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr9966222wmj.114.1605421178486;
        Sat, 14 Nov 2020 22:19:38 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g4sm17131135wrp.0.2020.11.14.22.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 22:19:37 -0800 (PST)
Date:   Sun, 15 Nov 2020 07:19:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <X7DIeE2tPqnDoYXP@rocinante>
References: <20201007161434.GA3247067@bjorn-Precision-5520>
 <20201008195907.GA3359851@bjorn-Precision-5520>
 <20201009080853.bxzyirmaja6detk4@pali>
 <20201104162931.zplhflhvz53odkux@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104162931.zplhflhvz53odkux@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Pali!

Sincere apologies for taking a long time to get back to you.

On 20-11-04 17:29:31, Pali Rohár wrote:

[...]
> 
> Krzysztof, as Bjorn wrote, do you want to take this issue?
> 
[...]

Yes.  I already talked to Bjorn about this briefly, and thus I am more
than happy to take care about this.  Most definitely.

Krzysztof
