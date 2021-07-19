Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37C3CDB7E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGSOnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 10:43:16 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42774 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbhGSOiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 10:38:01 -0400
Received: by mail-lj1-f173.google.com with SMTP id r16so26826395ljk.9;
        Mon, 19 Jul 2021 08:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNIqat7cYfcb63IwviLUw0Xdroq3HYsAHAyWsh0CF1I=;
        b=GQJzrRP+J6XHrvFhRRRah1X8HLVt5JOaXVH2tK8ICn4LXj4J4p8uW7VUkL+Z/UdnEy
         1DYmLTvi1glHVDsZuF+ZORC7UCxA164GkvS0q5qQVJbVE5IAP2ge5BHdXzkEyebwXlTY
         2P1qsCw3eIXHs+5r1lWX0gQiNWexs3tf66OK4c6kGvOSF6t08zDpmTydIz/pZdqRN2BH
         Cn2x64RWqjPsEjE9Pu4zUaqqGB6gd84hiFkSm9YFujwwlp4SCjfqcycjrzE4MdAvtUgb
         WaUevC5CPIomK/vbvsw0dyo7jO8PkdR+8QYrD7VPFTcrOs6krmlHEX4wDC+uUJCcak6O
         BAXA==
X-Gm-Message-State: AOAM530e4witZp921aEvbZwmnmjxCaNyUA4YEwXvNIJpJIR8sMjD4Dfd
        qgkCR5634E2PdTK2NDH8WwQ=
X-Google-Smtp-Source: ABdhPJy2Iy5SpdUFHLCw4EWwJAecbyGu4Lab48/CA34GciD86ngDPCOFSwH/fROYScyhpsd4Pkj63Q==
X-Received: by 2002:a05:651c:1695:: with SMTP id bd21mr15632606ljb.312.1626707919411;
        Mon, 19 Jul 2021 08:18:39 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e7sm1400948ljq.9.2021.07.19.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:18:38 -0700 (PDT)
Date:   Mon, 19 Jul 2021 17:18:37 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Use sysfs_emit() in "show" functions
Message-ID: <20210719151837.GA473693@rocinante>
References: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210719034313.GA274232@rocinante>
 <af1d4c61-53ff-f4e9-a708-33251b7e6470@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af1d4c61-53ff-f4e9-a708-33251b7e6470@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sasha for visibility]

Hi!

[...]
> > Nice catch!
> 
> I actually executed "cat" against configfs to meet the issue and found
> your solution in pci-sysfs.

Oh!  That's not good...  I am curious, which attribute caused this?

Also, if this is fixing a bug, then it might warrant letting the folks who look
after the long-term and stable kernels know.  I also wonder if there would be
something to add for the "Fixes:" tag, if there is a previous commit this
change fixes.

	Krzysztof
