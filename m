Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8412228825
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGUSY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 14:24:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726646AbgGUSYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 14:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595355864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ealMEOrHFYO0kZ1pKFx9efUp2/FF6Eq+swSNcBoDaSA=;
        b=Y5gUTrSb7ROYKIDqYBCitJ3ygTc4RhrNj/HU9qtGrfpR4n4/PNehZq560WlD/7xPaGuM1K
        DLyo60JjxtFlqbJHlEW610cDeCUgWMc0OhS7BpzAkPDRSAeTzN1kbhUl0Ls+Yup1WfFbdb
        8DFAdLP9Rj4ukA0z1Pq/uLySqxdCEkY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-lsC7UvXCPx-t4SGe9xBO2A-1; Tue, 21 Jul 2020 14:24:22 -0400
X-MC-Unique: lsC7UvXCPx-t4SGe9xBO2A-1
Received: by mail-qt1-f200.google.com with SMTP id q7so14924873qtq.14
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 11:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ealMEOrHFYO0kZ1pKFx9efUp2/FF6Eq+swSNcBoDaSA=;
        b=pYwraRU4ufUw5dEm9APrxI3yuPOmK8jscWvWbAQUVgu1Rv+nzWPAHlDBR1E0WUVbaV
         lpaADb01v8kMgE+bs4osrCa+eSAKb0BC7LHS7AWmWaXb3OEoRNo544/X+ZZbllH1Zr8P
         HMcqeLLHHvD+oPmlN7oSt46FIAa+ZHF+ScE3H3QQsNkvZhSRZLY4BhZ3n5CHummFTR35
         Iw0VjB+2nBKOoXMXXMtiDJrksL4gGi/oqlQgUC8biAtEQQFx7ImvTCD7o/52qZK5g+Rx
         PmMBKGHLRdMcAR5fr8qxoWPkResk7OPn9zSW4681K6UdYXfh9o4z5HtIyIfk7c5UVQMl
         nwlA==
X-Gm-Message-State: AOAM533MKPLjoUmQLDUj15EeVaYzwCe3uMLbxo1H33B5KAhlAOph5oQ/
        E0NlyBd9Y3lO9ztpg5/oOlIj6afcuaOS2IMDypVH+MLNbYsCzaWE3Xx7lTAqNHq+j9QPzAuhGP7
        UDjvLNs0ZbXY8PLKYwHmj
X-Received: by 2002:ac8:c7:: with SMTP id d7mr30400201qtg.235.1595355861661;
        Tue, 21 Jul 2020 11:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5OPDtOL+vQse+EIZ+qb5SVhRfGv2p/Vv3U6BZWjtbTj7sJmsbB+3Na09bYDi+UjZ28Uz31A==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr30400169qtg.235.1595355861423;
        Tue, 21 Jul 2020 11:24:21 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id x12sm510481qta.67.2020.07.21.11.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:24:20 -0700 (PDT)
Message-ID: <a80a591ce61b632503c9ed52adc7c40faad8b068.camel@redhat.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
From:   Lyude Paul <lyude@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Tue, 21 Jul 2020 14:24:19 -0400
In-Reply-To: <dc7a592219f58f9a5df7fa7135fa3fc87d9450f0.camel@redhat.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
         <20200716235440.GA675421@bjorn-Precision-5520>
         <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
         <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
         <20200721122247.GI5180@lahna.fi.intel.com>
         <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
         <20200721152737.GS5180@lahna.fi.intel.com>
         <dc7a592219f58f9a5df7fa7135fa3fc87d9450f0.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-07-21 at 12:00 -0400, Lyude Paul wrote:
> On Tue, 2020-07-21 at 18:27 +0300, Mika Westerberg wrote:
> > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > > Sure thing. Also, feel free to let me know if you'd like access to one
> > > of
> > > the
> > > systems we saw breaking with this patch - I'm fairly sure I've got one
> > > of
> > > them
> > > locally at my apartment and don't mind setting up AMT/KVM/SSH
> > 
> > Probably no need for remote access (thanks for the offer, though). I
> > attached a test patch to the bug report:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > 
> > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > anyone would have time to try it out.
> 
> Will give it a shot today and let you know the result

Ahh-actually, I thought the laptop I had locally could reproduce this bug but
that doesn't appear to be the case whoops. Karol Herbst still has access to a
machine that can test this though, so they'll likely get to trying the patch
today or tommorrow

> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

