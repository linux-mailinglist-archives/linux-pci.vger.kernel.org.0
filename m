Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFAB29CA98
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373319AbgJ0UuA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 16:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373318AbgJ0Ut7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 16:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603831798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaUcF7VQKHjl1YmIn8JcXXvxwqcur3oGWi5KlWcjsTc=;
        b=fTjT7Vq6PxMtBtm9fWdzNSXb+gO/p3ZWPJukWbOy6Gzq5eJ1a7KzD+OT74qkJMF1AMQiyk
        VYnzYeU8n9icy81125EJ12GEBOI8nZ/oWgfZKCbvFkiA3Dwdsxu4IOK1uuxwxLYOXZhuwo
        JnHOjCDIB08fcswdJ7/ovTWAvOEp0tk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-5c2B3dx9O6qlBa_LTqiF3g-1; Tue, 27 Oct 2020 16:49:56 -0400
X-MC-Unique: 5c2B3dx9O6qlBa_LTqiF3g-1
Received: by mail-io1-f72.google.com with SMTP id m25so1822085ioh.18
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 13:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vaUcF7VQKHjl1YmIn8JcXXvxwqcur3oGWi5KlWcjsTc=;
        b=SLT4CnJJIiaB79dJDPfX5H89+JitrPHzEluUtPu0ivevCa6tKXYfnw8R2lwwUMGTcv
         ACHeIO6YsWzSmbGOalgaSxJmBH1S8wNw/QbZFnXSgUbrhWFa8uoOSSgfVLsm3rELAxeY
         0PQv1UgNjyHTgMkf1KgIBAXtUfhEnmrsTL40rcV+2FzyyHbkilKpP0fjOI8S7X1YRCL8
         v/T7qlCHmybqXhsW0yHc2SZkNnLHoxHqel/qflzgkLsp2/EncOusmCJLNgEH0g8fbh5d
         DHMhrjsJnnId8ECn5LfpPfntk2f3knDSOQKIGiI3i7iGJfWZOtMbX3S2ewjA9pCmLTF5
         6BtA==
X-Gm-Message-State: AOAM5325nnBQrNbDTuN4IMKy9/woIzpXfLWvUEp+b3q0oAtogGgBChac
        eisTcUyT7yqJWMFRXOgkxt4fKlfefdM6C50sJHtgJNME85aaShSqer+1PrZV50hcnE4FxSmqPat
        u7ey7cD8a57ay3FmKmbNC
X-Received: by 2002:a92:1548:: with SMTP id v69mr3003093ilk.68.1603831794727;
        Tue, 27 Oct 2020 13:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs1vCCKhv9RjtXFNfkIfNX3udg1FQImCi7IiwcD13TqMFxgDerYoXTJkc6UKHScFhxFzjSSg==
X-Received: by 2002:a92:1548:: with SMTP id v69mr3003060ilk.68.1603831793969;
        Tue, 27 Oct 2020 13:49:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r3sm1372066iog.55.2020.10.27.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:49:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 10DE5181CED; Tue, 27 Oct 2020 21:49:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201027211949.1f25d3b9@nic.cz>
References: <87imavwu7b.fsf@toke.dk> <20201027190344.4ffd9186@nic.cz>
 <87a6w7wl1x.fsf@toke.dk> <20201027211949.1f25d3b9@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 21:49:51 +0100
Message-ID: <871rhjwg0g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marek Behun <marek.behun@nic.cz> writes:

> On Tue, 27 Oct 2020 20:00:58 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> Marek Behun <marek.behun@nic.cz> writes:
>>=20
>> > Are you using stock U-Boot in the Omnia?=20=20
>>=20
>> I've tried both that and the latest upstream - didn't make a difference
>> wrt the PCI issue. Only difference I've noticed other than that (apart
>> from being able to turn more things on when using upstream) is that the
>> upstream u-boot can't seem to find the eMMC chip on the Omnia. Any idea
>> why? It doesn't matter right now since I'm just tftp-booting, but it
>> would be kinda nice to get that fixed as well :)
>>=20
>> -Toke
>>=20
>
> No idea, I will have to look into that.

Please do! Would be awesome to get it working :)

-Toke

