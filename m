Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145C07E86B0
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 00:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjKJXuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 18:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjKJXuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 18:50:13 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D23C39
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 15:50:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so2043952a12.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 15:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699660210; x=1700265010; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZYhPiKUGI3usn76HYsWDt0VbRfi/1VVQFT0yJkbIqI=;
        b=OhyPp+4GBUd/OkB7LLMQx1IvC/MZS8GDRDS+uSjKjKu2s2vzps9sR0bSqVfbf9/mLi
         yJiAnk3a/OyCAqj+PyVJ0ZauWrj70j2yVlCsC4O6pm2jn8XAhH2DH9q91+JMFguI/w2D
         MXIuzLseQqiOZ9vYEVdtStqiU4b/Pxty8fthXDL8LfwB+z6EFwiDdzPU0o1oUboH47OM
         qiTmwQ1su2s5+pCBXwBGKe5lAj5PSbxkXt/aOCSr1dbheScGLhPOLzlSnyUW6mb+IEQt
         rmaVC0wEm7fSB/7AzJRWMQPbXEsrG976w3kZ/3EE2YckDIbedv2lnQ5SqKsLjM3zueP8
         OByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660210; x=1700265010;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZYhPiKUGI3usn76HYsWDt0VbRfi/1VVQFT0yJkbIqI=;
        b=jjfNF6WjhI7Dsudn4dkINEfAe4kIBJ75+FzMPP/st6uCfmcnDqg4rTomryvkZNcBM8
         ySQGtnZxjhYHvtqNEcBqRRdn5DJnWGL7WimmrMExMUN5veVLUZSGRdoSULg0WbtMp7Ua
         BSQXRvR6def3Rbr1a4mCDyWI9hHnP655rcgphm99Ub/d32qm+zKNpFGh5qCksKnnuUB9
         QPzLB4NU8hQjhBZt+sxCJxOQN6HuTOboV3JFojMfrYfmys280zOh6Xd9aNKPoyrhgiRZ
         wS2rzNIciXrGHpFgjyfWHZe4BiyHhwnPhFB/v9sg8lZv4nM+aE+QfoLK8FZ3dftBPKU8
         Cpzg==
X-Gm-Message-State: AOJu0YxL9mlHOiHqNhW935A3ooQaIZdvu6q/R5U0Zy6QamNpZn3w4Ym5
        qk6wU2nmc+dVxRGx5pK0557FoFYkNX1WUvtOhlFtPQ==
X-Google-Smtp-Source: AGHT+IF4i/hXkWPjIYKaZct7WSGds1eDliBiNONPp0IQJ+jqzg06E5lFp+uL9tuEMfwjJIQCBcuDlg==
X-Received: by 2002:a05:6a20:1588:b0:13d:5b8e:db83 with SMTP id h8-20020a056a20158800b0013d5b8edb83mr695762pzj.9.1699660210541;
        Fri, 10 Nov 2023 15:50:10 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id ng4-20020a17090b1a8400b002635db431a0sm284840pjb.45.2023.11.10.15.50.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 15:50:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 1/1] switchtec: Fix stdev_release crash after suprise
 device loss.
From:   Daniel Stodden <dns@arista.com>
In-Reply-To: <3916e092-201a-401c-b6f9-e3a5732308b0@deltatee.com>
Date:   Fri, 10 Nov 2023 15:49:57 -0800
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CB550C8-71A9-4A49-8320-8C63DD89FB4E@arista.com>
References: <20231110201917.89016-1-dns@arista.com>
 <20231110201917.89016-2-dns@arista.com>
 <dc15dc87-d199-4295-96b4-b972f4965bd5@deltatee.com>
 <531029E9-0321-4E5A-8C65-3378B8DCB5E2@arista.com>
 <3916e092-201a-401c-b6f9-e3a5732308b0@deltatee.com>
To:     Logan Gunthorpe <logang@deltatee.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


I don=E2=80=99t mind all.

I=E2=80=99ll remove disable_dma_mrpc(). That will make things about the =
size as the old stdev_release() again.
It=E2=80=99s pretty gratuitous.

I=E2=80=99ll keep switchtec_exit_pci(), because it helps =
switchtec_pci_remove to remain a carefully ordered
sequence of one-liners.

I looked a little more through the code, and noticed that the two =
non-delayed work structs,
mrpc_work and mrpc_timeout, are not cancelled in stdev_kill(). We seem =
to stop the ISR which schedules them,=20
but do not stop the bh before teardown.=20

And these handlers do not recognize stdev->alive (ok, they should not, =
because they do not hold a strong reference to stdev.)

So there=E2=80=99s probably more coming soon-ish. Just mentioning it in =
case I get hit by a piano until then.

Cheers,
Daniel

> On Nov 10, 2023, at 2:49 PM, Logan Gunthorpe <logang@deltatee.com> =
wrote:
>=20
>=20
>=20
> On 2023-11-10 14:30, Daniel Stodden wrote:
>>=20
>> Hi.
>>=20
>> [Sorry, sending this twice, again, hoping this time it won't bounce, =
because html]
>>=20
>>> Nice catch, thanks!
>>>=20
>>> The solution looks good to me, though I might quibble slightly about
>>> style: I'm not sure why we need two helper functions =
(disable_dma_mrpc()
>>> and switchtec_exit_pci()) that are only called in one place. I'd
>>> probably just open code both of them.
>>>=20
>>> Other than that:
>>>=20
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>=20
>> I'm fine with it either way. I added those mainly because of the =
enable_dma_mrpc/switctec_init_pci
>> counterparts were already there. And likewise single-use, as would be =
usual.
>>=20
>> So the subroutines would maintain symmetry between probe() and =
remove().
>>=20
>> So.. just don't add the new remove()-relevant ones? (One alternative =
would be to send another change right after,
>> which goes after single-use pairs altogether.)
>=20
> Ah, I see. Just because it's single use doesn't necessarily mean it's
> wrong. I would say switchtec_init_pci() should not be inlined because
> it's rather long and keeps switchtec_pci_probe() a little more =
readable.
>=20
> enable_dma_mrpc() more questionable. I'm not sure why it was done that
> way. Perhaps something changed.
>=20
> In any case, I'm not all that concerned. If you want to leave it the =
way
> it is, I wouldn't mind.
>=20
> Thanks,
>=20
> Logan

