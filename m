Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817016FE492
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEJTqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEJTqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 15:46:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5753596;
        Wed, 10 May 2023 12:46:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so13625476a12.3;
        Wed, 10 May 2023 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683747980; x=1686339980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1Ax+C4uVpShkrhGJuWjnQ32NyLaUTtPNx+vaWWWtRo=;
        b=qKtDqwcdFt3Z+xjetBlVll3ql6lmXwZ3cZaMEO7+qOH50NSVWdMVREhDc20U80fTyz
         +wMBDiofE9h/RnnjIf9E90ZqTvCkVtp1jkOJf8JL8V5cczXOrC0GgO4YlnC2uhten5D2
         3F9dHcFhisygtrTq9+dHqR6szwodWTBmEm/mjMF/N0RPmlVWPhmEB2Uz7DGlg5DTaH70
         8qPZduFC19NIF56VzusFy83xPpZQkwD2P0IoL3s7q7NbA4tpj7Jlp8eCjzZDcZxs2RBI
         lHKsqpAJHl6BnA5EDqjY35rF3GBBb3PO0gi2DaloEZAJjLZCHQsBM1/UCD+wN1S7PrPi
         PN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683747980; x=1686339980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1Ax+C4uVpShkrhGJuWjnQ32NyLaUTtPNx+vaWWWtRo=;
        b=W1OMCe8aJ2dLu2fSggnFSYYSCCtbD/NHbH9RjcaJTNMha31R4iaQRBPh5UKpAHXZTW
         w0WRNikFVFkR3gcWRDM5MXMtmUd8u40Pz1SOFuWPHoHOnuPC1MJ26CQqI6pz6jsZP23B
         e6GqIcsMn9Xnt+cYibdF71u4mPh7zR8tKiFuNXrDtIylLVqBoHhSqMmL4FvB8ckDuECg
         rlK+UkOnqnrkjBDazeB/7KtqtYmG3U02FWnmXe33aLRwGq6DJmN45O1FURWg1WqZfCwv
         /egQRIOrd7RwU7KcbCulL3sw0I/GBTiouq8AZX0df+pjokZQQkb8kuSR6FDz0+NbYO8A
         N2hg==
X-Gm-Message-State: AC+VfDzLFFXn1ge66CaVobK9aMJAg6fJ2Jz5iJsb2rNlaJCcq3lHKfsa
        wJyncu4TYOG0E+odpKgGqtG9ceQMRknI7YVn73M=
X-Google-Smtp-Source: ACHHUZ71b7omNvOYvmXMlT5h+vZxL1cQOXXwSCWfa8NRKmoq3Ab93DsePztpxij0ZcDDi+9V49IW6SYFiysEQeq+vz0=
X-Received: by 2002:a05:6402:203:b0:506:a561:b0a9 with SMTP id
 t3-20020a056402020300b00506a561b0a9mr15705456edv.14.1683747979721; Wed, 10
 May 2023 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
 <20230509211902.GA1270901@bhelgaas> <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
 <CSIJZYWBC38N.2M99O6W1PLR4B@vincent-arch>
In-Reply-To: <CSIJZYWBC38N.2M99O6W1PLR4B@vincent-arch>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 10 May 2023 15:46:06 -0400
Message-ID: <CAMdYzYrPNwq7OC-_9PE18coO-y_NZuu9bAj4XX1r8q8Gy_EofA@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        robh@kernel.org, heiko@sntech.de, kw@linux.com,
        shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
        broonie@kernel.org, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 7:16=E2=80=AFAM Vincenzo Palazzo
<vincenzopalazzodev@gmail.com> wrote:
>
> > On Tue, May 9, 2023 at 5:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > Hi Vincenzo,
> > >
> > > Thanks for raising this issue.  Let's see what we can do to address
> > > it.
> > >
> > > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > > > Add a configurable delay to the Rockchip PCIe driver to address
> > > > crashes that occur on some old devices, such as the Pine64 RockPro6=
4.
> > > >
> > > > This issue is affecting the ARM community, but there is no
> > > > upstream solution for it yet.
> > >
> > > It sounds like this happens with several endpoints, right?  And I
> > > assume the endpoints work fine in other non-Rockchip systems?  If
> > > that's the case, my guess is the problem is with the Rockchip host
> > > controller and how it's initialized, not with the endpoints.
> > >
> > > The only delays and timeouts I see in the driver now are in
> > > rockchip_pcie_host_init_port(), where it waits for link training to
> > > complete.  I assume the link training did completely successfully
> > > since you don't mention either a gen1 or gen2 timeout (although the
> > > gen2 message is a dev_dbg() that normally wouldn't go to the console)=
.
> > >
> > > I don't know that the spec contains a retrain timeout value.  Several
> > > other drivers use 1 second, while rockchip uses 500ms (for example,
> > > see LINK_RETRAIN_TIMEOUT and LINK_UP_TIMEOUT).
> > >
> > > I think we need to understand the issue better before adding a DT
> > > property and a module parameter.  Those are hard for users to deal
> > > with.  If we can figure out a value that works for everybody, it woul=
d
> > > be better to just hard-code it in the driver and use that all the
> > > time.
> >
> > Good Evening,
> >
> > The main issue with the rk3399 is the PCIe controller is buggy and
> > triggers a SoC panic when certain error conditions occur that should
> > be handled gracefully. One of those conditions is when an endpoint
> > requests an access to wait and retry later. Many years ago we ran that
> > issue to ground and with Robin Murphy's help we found that while it's
> > possible to gracefully handle that condition it required hijacking the
> > entire arm64 error handling routine. Not exactly scalable for just one
> > SoC. The configurable waits allow us to program reasonable times for
> > 90% of the endpoints that come up in the normal amount of time, while
> > being able to adjust it for the other 10% that do not. Some require
> > multiple seconds before they return without error. Part of the reason
> > we don't want to hardcode the wait time is because the probe isn't
> > handled asynchronously, so the kernel appears to hang while waiting
> > for the timeout.
>
> Yeah, I smell a hardware bug in my code. I hate waiting in this way insid=
e
> the code, so it's usually wrong when you need to do something like that.

Correct, it's the unfortunate way of arm64 development. Almost none of
the SoCs implement all of their hardware in a completely specification
compliant way.

>
> During my research, I also found this patch (https://bugzilla.redhat.com/=
show_bug.cgi?id=3D2134177)
> that provides a fix in another possibly cleaner way.
>
> But I don't understand the reasoning behind it, so maybe I
> haven't spent enough time thinking about it.

That is a completely different issue, unrelated to the PCI crash.

>
> > I'm curious if it's been tested with this series on top:
> > https://lore.kernel.org/linux-arm-kernel/20230418074700.1083505-8-rick.=
wertenbroek@gmail.com/T/
> > I'm particularly curious if
> > [v5,04/11] PCI: rockchip: Add poll and timeout to wait for PHY PLLs to =
be locked
> > makes a difference in the behavior. Please test this and see if it
> > improves the timeouts you need for the endpoints you're testing
> > against.
>
> Mh, I can try to cherry-pick the commit and test it in my own test enviro=
nment. Currently, I haven't been
> able to test it due to a lack of hardware, but I'm seeking a way to obtai=
n one.
> Luckily, I have someone on the Manjaro arm team who can help me test it,
> so I'll try to do that.
>
> Cheers!
>
> Vincent.
