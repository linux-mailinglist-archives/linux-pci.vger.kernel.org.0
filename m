Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6C29CA0F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831324AbgJ0UUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 16:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1831263AbgJ0UUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 16:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603830037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLLUHtoNNVXydeEp2g2EgAGhu6OPOYqOmE0/xrVewMA=;
        b=TKhi+s3upStnOhAWlif4lYDgcknsbuaW/fJ3Ft9arGtfYL+Dv/IL4v4njQ2FUknxmjYFoQ
        cMjR+4zY6bEnYBoTHLBRm6xKTrVPI1KV7ms2AboLK5R9LLOkAXT9J7+8qx5CNhCzlJoFhc
        5EhPGh8JoFt6+QDY2tJ3RbBKtCnbiPs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-AoX0hv8gP_e9Zlb0Rb_NvQ-1; Tue, 27 Oct 2020 16:20:36 -0400
X-MC-Unique: AoX0hv8gP_e9Zlb0Rb_NvQ-1
Received: by mail-il1-f198.google.com with SMTP id k15so2033698ilh.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 13:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sLLUHtoNNVXydeEp2g2EgAGhu6OPOYqOmE0/xrVewMA=;
        b=SNetIMsyBucQybVLadcTWZ6OI6U1xef10S3uPqCkaltNQLukoWSbMHqa+jM6bvPq7h
         hSApozlcTs/lPc9BaCevwooMphV1W6KuVuWleRhy009dG78mooOQDJwV6cFBzpNGb2+U
         Ql0wcu2KxxYVJF28Si5/M30CjQsUe/54arS6lObCQ082GG5MRIWqnkMjYk9yN/Ec2Uao
         xYZVPOY4laTQv1d2sjidDfMv39ADZ0IUxPogNN3Ih+d4ajWPsV2FPpLI+EjI58SCw1MI
         Ao6VVVIlBs5HRqSdwV2+Of6RlI2Wkko1o0aoRbPikq0Hc8FJEjdNbj3nGSSvN7IRA/qX
         eEqw==
X-Gm-Message-State: AOAM531GhncIsl7fexBSA2AYz13nP/rpjhAQS3QtkHYab3Pj6GOjr6dp
        bh/yff0wDVp6jGeji8ylac9O+zyKIvGiyGHIZ0AA+YdQsaINRcszMoxHgdZFPhJPEeUp+9AZo0E
        5tcjDBg9ojfBfJM2OE9zK
X-Received: by 2002:a02:c952:: with SMTP id u18mr3973069jao.139.1603830035594;
        Tue, 27 Oct 2020 13:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/R/wlZoViUuoXivKLOUBw7DJP0BdcRmMvQD202ibRRyJvcuuCgPkB5VIAxWP3QgJycG0gwQ==
X-Received: by 2002:a02:c952:: with SMTP id u18mr3973056jao.139.1603830035418;
        Tue, 27 Oct 2020 13:20:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u8sm1420051ilm.36.2020.10.27.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:20:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 073F6181CED; Tue, 27 Oct 2020 21:20:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     vtolkm@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <87d013wl52.fsf@toke.dk>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 21:20:32 +0100
Message-ID: <874kmfwhdb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

>> Note: related issues - workaround compile ath and cfg80211 as modules
>>
>> (1) https://bugzilla.kernel.org/show_bug.cgi?id=3D209863
>> (2) https://bugzilla.kernel.org/show_bug.cgi?id=3D209855
>> (3) https://bugzilla.kernel.org/show_bug.cgi?id=3D209853
>
> Yeah, I had noticed the regdb failure but put off debugging that until
> the PCI issue was resolved. So guess that's next on my list - thanks for
> the pointer (although I'd rather avoid the module approach as booting
> the kernel directly from my build box over tftp is quite convenient...
> Let's see if there isn't another way to fix this)

To follow up on this, everything seems to work just fine (ath10k init at
boot + regulatory db load) if I simply set:

CONFIG_EXTRA_FIRMWARE=3D"ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988X/hw2.=
0/firmware-5.bin regulatory.db regulatory.db.p7s"

-Toke

