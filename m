Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531A29F8F2
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 00:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgJ2XQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 19:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgJ2XQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 19:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604013363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDzhIwz3SU8Sz2IfnKwo6SqdwTl4+6iL2g2rAqYfz8k=;
        b=YK41PmfOljRYjR4MSPPUY9iSSJiUSkwBZFjZ/agLViEvFsPBXqIPN+6gCYB8kaJq8bvKtp
        YzyeSqOEIXqMoreeE2DG+TMte2YChSdq3kt3bTZboXnrR89/s4wOFdz4ZJBcZ1GTFWJFan
        O9QjOW8Xx7EjdPnOQKv7D0ArTCU7viI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-UZAwYUwMOVe6oFmZQoB9QA-1; Thu, 29 Oct 2020 19:16:01 -0400
X-MC-Unique: UZAwYUwMOVe6oFmZQoB9QA-1
Received: by mail-io1-f70.google.com with SMTP id z18so3076244ioz.6
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 16:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pDzhIwz3SU8Sz2IfnKwo6SqdwTl4+6iL2g2rAqYfz8k=;
        b=t/3PXqWp8BXm8akdr3MGzHGeTUEUbTH6Q1wjed5kMwdwlPP6/1NvTBgVx7yZsEHoS7
         4XYwJ2XukgewPvtVd4Bl9zYu5k1aNNNF2UajmgZwIBq7STWLfSTh2s8imGshPOq/VkTI
         hKRsVi1iF4iw302CpELBQN35euRhijSs9/2kpVbJy9bU2l281E+TSeqELSHIFzmi8XZ5
         NWL3J16JsGhQjn49ctKPgGeOCcgpcRuYENaxzOHONfVBCqRv2VHbs+j9oYCGFP038Yeo
         UO44gaoEnMHWrQ5GYUOybfQLGGJMD0ux5trk8gEx79IhQzMtrirhIdzJzTyPcEJq6lcn
         fCNA==
X-Gm-Message-State: AOAM533nrAFvg3zrvf/XyUkqFfLFQtvg7vcWb5NM0JeSBjJSOxRe79Kd
        S+EKxjM/IRlEmmAolvZhfSsC4C3NKnL2WHo82dwdBuprMymzfV674HL9YWcYAty6pXSVZwZnJ1K
        Ind4QNmZnUZI08U7jm3sv
X-Received: by 2002:a02:a395:: with SMTP id y21mr5936803jak.58.1604013360966;
        Thu, 29 Oct 2020 16:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Z4jlORGS3ePAxURBF+suifIZBQK75oOLjC+LuWqq0SFUHz2u3IzguJBFFDjrBwnqz6Bg0g==
X-Received: by 2002:a02:a395:: with SMTP id y21mr5936789jak.58.1604013360813;
        Thu, 29 Oct 2020 16:16:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m66sm4690441ill.69.2020.10.29.16.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 16:16:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6E1DD181AD1; Fri, 30 Oct 2020 00:15:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201029225409.2accead3@windsurf.home>
References: <871rhhmgkq.fsf@toke.dk>
 <20201029193022.GA476048@bjorn-Precision-5520>
 <20201029225409.2accead3@windsurf.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 30 Oct 2020 00:15:57 +0100
Message-ID: <877dr8oc7m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Petazzoni <thomas.petazzoni@bootlin.com> writes:

> Hello,
>
> On Thu, 29 Oct 2020 14:30:22 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> We could quirk these NICs to avoid the retrain, but since aardvark and
>> mvebu have no obvious connection and WLE200/WLE900 and MT76 have no
>> obvious connection, I doubt there's a simple hardware defect that
>> explains all these.  
>
> aardvark and mvebu have one very strong connection: they are the only
> two drivers making use of the PCI Bridge emulation logic in
> drivers/pci/pci-bridge-emul.c:
>
> drivers/pci$ git grep pci-bridge-emul
> akefile:obj-$(CONFIG_PCI_BRIDGE_EMUL)  += pci-bridge-emul.o
> controller/pci-aardvark.c:#include "../pci-bridge-emul.h"
> controller/pci-mvebu.c:#include "../pci-bridge-emul.h"
> pci-bridge-emul.c:#include "pci-bridge-emul.h"
>
> I haven't read the whole thread, but it is important to keep in mind
> that on those two platforms, the PCI Bridge seen by Linux is *not* a
> real HW bridge. It is faked by the the pci-bridge-emul code. So if this
> code has defects/bugs in how it emulates a PCI Bridge behavior, you
> might see weird things.

Ohh, that's interesting. Why does it need to emulate it?

And could this cause things weird interactions like what I'm seeing,
where a somewhat buggy device in slot 2 affects the ability to retrain
the link also in slot 1, but only if there's no device in slot 3?

-Toke

