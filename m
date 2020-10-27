Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35F529C80F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371412AbgJ0TBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 15:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1829213AbgJ0TBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 15:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rr+cHsG0jvP4KeU30I8ODamRBgqIOL0eiWSW6ndYZIs=;
        b=Au8fCNG9BgcmFW1SRNP2KtWMTOPTkJHc/AgTorUMDzDUJrgM9x9nL5kaXPa34YjwhbBgV9
        RU3v9OeCzDttLqaGFh3sVNVWNCMtffxxegXoBihd/jbdpwAgaxiald1ZthvgehEHZ4W3LK
        EUPTD15jQTbtOYsI4q8JLE8vaOcFZp4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-g4uRN95YOLKqMNij9HYLdw-1; Tue, 27 Oct 2020 15:01:01 -0400
X-MC-Unique: g4uRN95YOLKqMNij9HYLdw-1
Received: by mail-qv1-f71.google.com with SMTP id d41so1440630qvc.23
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 12:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Rr+cHsG0jvP4KeU30I8ODamRBgqIOL0eiWSW6ndYZIs=;
        b=ZnYnL7djNQJnO589KSC7WKEPZIDb3b8ib3lX/w5leJqWYqgSydhd2Xtb13QxAyE3vG
         f3+XHM0c5Ww3iFJup5m7pCz+OR8jhR+I3IQ9y68hPqi/hxvcbiQQQbKZYqsRUMF/f+Ne
         0EajpbBmjfP12ao1xQkteuB9mPhm1/lAkthdXL6U+t7noClLceAk3iTc7K0778XtfErP
         RQeTLpgvEKZxEMrg5ORrkZ7lsqXYIqNyyrpwJ3cSmGQGkzS56zh8Xifti2QzZxRBZf4m
         lB4sB9Z0yDi45lnKUVa8TiHEGlj4YoNd7udI75Iv4Tyu5rSDVgqcN6a9HZKb2Miv3Dwv
         H9Qg==
X-Gm-Message-State: AOAM530HBJsczDWRIVSOZtPmN278Np1mCITQ5LNGMKjtysQs5LuxN+qX
        6RQtiiJlC6YsVwYx2eAtmLaz54nktJ3nO2rQQYoej/bU0pls9ljpDSTIF63gaLkWFbQwjhIX8g+
        MmIpqt67RehXVlR9gtjqt
X-Received: by 2002:a37:401:: with SMTP id 1mr3758142qke.285.1603825260869;
        Tue, 27 Oct 2020 12:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMqSbRDGPogsW7kx9XIp/ciEpP2JhMmrHfSuSGJ2fdI6PcRfU6XH5Ax5rxFutO9TqYJarVUA==
X-Received: by 2002:a37:401:: with SMTP id 1mr3758089qke.285.1603825260237;
        Tue, 27 Oct 2020 12:01:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 8sm1358548qkm.0.2020.10.27.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:00:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3BE4A181CED; Tue, 27 Oct 2020 20:00:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201027190344.4ffd9186@nic.cz>
References: <87imavwu7b.fsf@toke.dk> <20201027190344.4ffd9186@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 20:00:58 +0100
Message-ID: <87a6w7wl1x.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marek Behun <marek.behun@nic.cz> writes:

> Are you using stock U-Boot in the Omnia?

I've tried both that and the latest upstream - didn't make a difference
wrt the PCI issue. Only difference I've noticed other than that (apart
from being able to turn more things on when using upstream) is that the
upstream u-boot can't seem to find the eMMC chip on the Omnia. Any idea
why? It doesn't matter right now since I'm just tftp-booting, but it
would be kinda nice to get that fixed as well :)

-Toke

