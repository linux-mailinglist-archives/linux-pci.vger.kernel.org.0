Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492EF228468
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgGUQA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 12:00:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729999AbgGUQA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 12:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595347254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0UrEz/GvXR1ZZ5iVqJP3qWd7bx+Q5rlrTYnl3WPpZ0=;
        b=i8Qu/OYQZkaq1Irfx0chJjTxyFvUK0hIK32enmue9E2SVCq/O5k2JrNARdI/PTWxPxOmBk
        JOwnJiINoMEWI+1OEJa2oppSvlf7XuwnA3aXmaWht5w3rbTitzc7KD/LQIUojHAfT18L5M
        LL3+Sxodvt46qE5nDhzLHBGW/5ddrso=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-yKIRjsp0OFy1ghJoXhrVHQ-1; Tue, 21 Jul 2020 12:00:52 -0400
X-MC-Unique: yKIRjsp0OFy1ghJoXhrVHQ-1
Received: by mail-qv1-f69.google.com with SMTP id r12so12682355qvk.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 09:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=P0UrEz/GvXR1ZZ5iVqJP3qWd7bx+Q5rlrTYnl3WPpZ0=;
        b=uT54vjnLANM6SzdzDr1CbaKoMw8fJVt/ppMsT9tZKBo7LpmHjCYFZQ6d1l1H2cPwed
         zyBSPAp+efc+dPkKEBBcUKiCwU8G6fTBbMD2lRM3rpiXBbLUlYv7SQa+63yx1xS8cD29
         EH8BP3VAwRUDKtd20+XfKv9ePxDGmq46Av2slWbTAgcIbCUTcFhOPfGvbRo3d1JCXOKB
         wpH4iOpKSsiSVVKGdt0vcOX2TgmaN2gzrDPeYPnp7LgyOmQoxp16v1U5lXYQiL4A9zJj
         cvVeh2LtkLb6QvyfMpDP4kpTJyitoVmh77aElvmRuO2mbUF1yqV3YX/l3KgJmKLPULDr
         pI+g==
X-Gm-Message-State: AOAM531xuuYKkn6ulYA2Pub6BSnpO6mYrFcm3n1SiJLTnEpqr/O3ltgG
        jLjgTz7Qv648JWkZbEQoMzkCxCB83qW2XlZe2OXyv/wJkJ0obMXgyXlSz/xbjP3coGe1bdFIUEs
        OCmofdRzsvXnfrec2EinI
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr12959439qkg.326.1595347252176;
        Tue, 21 Jul 2020 09:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyinIbVabueGMXoafK8P3B2fbzczvS1OyYVVhBZSVm9JqHV5WA7XsG5FVGYoO3j+1QlROT9pw==
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr12959408qkg.326.1595347251931;
        Tue, 21 Jul 2020 09:00:51 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id x29sm21891103qtv.80.2020.07.21.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:00:51 -0700 (PDT)
Message-ID: <dc7a592219f58f9a5df7fa7135fa3fc87d9450f0.camel@redhat.com>
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
Date:   Tue, 21 Jul 2020 12:00:49 -0400
In-Reply-To: <20200721152737.GS5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
         <20200716235440.GA675421@bjorn-Precision-5520>
         <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
         <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
         <20200721122247.GI5180@lahna.fi.intel.com>
         <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
         <20200721152737.GS5180@lahna.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-07-21 at 18:27 +0300, Mika Westerberg wrote:
> On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > Sure thing. Also, feel free to let me know if you'd like access to one of
> > the
> > systems we saw breaking with this patch - I'm fairly sure I've got one of
> > them
> > locally at my apartment and don't mind setting up AMT/KVM/SSH
> 
> Probably no need for remote access (thanks for the offer, though). I
> attached a test patch to the bug report:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> 
> that tries to work it around (based on the ->pm_cap == 0). I wonder if
> anyone would have time to try it out.

Will give it a shot today and let you know the result

> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

