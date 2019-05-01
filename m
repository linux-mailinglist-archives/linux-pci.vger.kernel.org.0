Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5909E10D3C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEATch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 15:32:37 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52298 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEATcg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 15:32:36 -0400
Received: by mail-wm1-f51.google.com with SMTP id j13so244856wmh.2
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hN7pPfFuA5DAqdy1xA+mZ+vwXrbfEuaD/a9O9EtXWTI=;
        b=iP7UPBc0+cXioclu5w12nOCUDrmEPTsrT7rwKSYir8mOF61cKui2joTwd+1/VGNvYz
         Vkg9lyQKyabuZtAH1yIyFVQHk765tI6UGjXRp82GwrCq+uFLY5syIMpJLp693O2LbuKD
         M1IsRpxJCZHGxIoMPCNEq9FVu+4mCoSupWDGPkdTRnJWNpYBxajImuUKqgTD/gHWGr9Y
         aZUtnkZaHCKkfXk9YTAAZMSWocrcNhjPkR/h0wBoWwxkRskOiXbAXlcH5QcCZ21UE7BG
         CETWH1lNF7Rvtxx8Em+NEkO3uJ8YSbRmW5xjKhRJ3S15SEPPQCHuPzAm9eu6tgRces6G
         qSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hN7pPfFuA5DAqdy1xA+mZ+vwXrbfEuaD/a9O9EtXWTI=;
        b=lHY2Af5WlmneAVH1QdKGACsc6FYEEhLEw8jq+pkdaihNzLtU6sji+79uqS+n+p2RMs
         nwhzGJj6j6oPj/WyS3yhrQolA24gg1h9l1j6JNsv4FYD05dvlfPkv7G/C/8yxqatnLSt
         KS9dpnZPjV/O9XMjaI1/kIUczZjapyLwcOXHzXbCunNaGusnmkokuQsHvmn6GgRQkgz4
         mMIR3k5h/4l9b0AbYf/r2A7h54rwza6p4550mOO4NKQNDMNuDKEEw85h5ez0BI2RU7J4
         2ab5OwAp5G9SLk0VumUg+O5Jj2y3sPp6HPvFPk0Gj9outeAEbKMGoHRQjdhk5HqMvU1R
         JVkw==
X-Gm-Message-State: APjAAAWRmz30zQZNo2iIAO5OG1VawYirjjIV/QjIp7yi59xUrBymDDqv
        P1iFySdM+drcbAqw4sR8gRdZOI9qeUUPAGQoFCyPrg==
X-Google-Smtp-Source: APXvYqxq04GzATRqvz8juOs4DErCb6yZuH7I1bIHu8kD23NR8MWxjXWG7pIMqLEW9U4YBl+EewPEc64CLO74BxGqXe4=
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr7814108wmh.85.1556739155024;
 Wed, 01 May 2019 12:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
 <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com> <20190501155813.GB26910@localhost.localdomain>
In-Reply-To: <20190501155813.GB26910@localhost.localdomain>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 1 May 2019 12:32:23 -0700
Message-ID: <CAOQPn8sbDjafaop2+bhB5PrxrhMWOOJ4Y5YMy6Se7+A9zrhrFg@mail.gmail.com>
Subject: Re: NVMe peer2peer TLPs over NTB getting split
To:     Keith Busch <kbusch@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        linux-pci@vger.kernel.org, Armen Baloyan <abaloyan@gigaio.com>,
        D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 1, 2019 at 9:04 AM Keith Busch <kbusch@kernel.org> wrote:
>

> Note that Max Payload Size may not be the same across root ports,
> so splitting transactions may be the correct thing to do under some
> circumstances. Kernel parameter "pci=pcie_bus_peer2peer" should make
> all MPS settings the same, though I doubt that will help for the
> hardware desribed here.

This is an interesting point which I had not considered before. The
TLPs coming directly from the NVMe drive are on a MaxPayLoad path of
256 bytes. When the TLPs get relayed from the Host Bridge, the
originating Host Bridge (BDF=00:00.0) has a MaxPayload of 128 bytes.
So, perhaps understandable that the TLPs would get broken up, although
going from 256 bytes to 1 byte TLPs is rather extreme, but perhaps
that's how this bridge deals with it.

Thanks,
Eric
