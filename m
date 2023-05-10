Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26976FDC6C
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjEJLQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEJLQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 07:16:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F831732;
        Wed, 10 May 2023 04:16:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f475366514so4905665e9.2;
        Wed, 10 May 2023 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683717384; x=1686309384;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBsIndB/0JBmV2qr33mCTEeeS4Iy2jxh4GLVwKZXMKo=;
        b=iqcXJrveVHEU+GGtZG8f4wqg4YspiZKIHvie8TtfVwGgTD3tvMR0xvGhZZ+HoWynG1
         tiWh37AR3cI3KXwzfwrmATe8liUZzPRsaQLrv9r3X6DcTCVriQERbmMMBZGgl/7kcokv
         ZTmlvGG/OnxLo/bHNt58wE8sPHrH517gvo60eesWA/laL4yfQWxrhP8K23wwBsqFP/eS
         e3JNZjcp39c37KFewemN05oTv2E3O2YfBbIG8ZA+6YohNs8VXkFR+MlEo2UiYcS7z1E3
         6Fb8VqHQEPXdWhcLUA6EMPTN/ycQSFiNTSC988uv0nuS9Th3TSGI/kGQYg7Ng5A8MnL1
         iztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683717384; x=1686309384;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBsIndB/0JBmV2qr33mCTEeeS4Iy2jxh4GLVwKZXMKo=;
        b=FpjIr0u0uzLTrwXfoMfWATMV1E8mP9/kxzLKGVEscT1SZW6xdtkYxGQCYJh+OcaPrO
         j+4MCYf3DyuD4zeab4Ah14qwnphYKiLjAK6AsulQcNHzFDFAf/7NZeWRMB3HWwS2HitZ
         jMpDEk/hg/UW+gORS2qpJ7esw8kUltR+qFCO1L61Ivx1fpJG6QIo3sQYoxIfv+Blo+e+
         Q728IL3iZp1/9rsU5iKzJNZDDUCCuaFumCeOISzitWU2IIBtBB9RI0MN91MVb6xUmrI7
         97kGPazjSidSX2VSlbYCyjhjCm9AyQK/tQbaY1bI9oHF2neSzykkSvEeDdMIu4mcRyLo
         v7nA==
X-Gm-Message-State: AC+VfDxtR0aUGSksexddjT8n1pgzmAWDSfQBBfQ4Y9lsMXCSmvSCp0ge
        bg2D78GdJ1ShbM8dIRxPj0I/UdXoFwVWFdSMKyw=
X-Google-Smtp-Source: ACHHUZ6CkBmwDOlHCbYrI/mphVqzmMF7zFthMe87Sh8XjvMWEmrUJjFgtJQjuQrwXn/I0+sYY1bmIg==
X-Received: by 2002:a05:600c:28f:b0:3f1:8430:523 with SMTP id 15-20020a05600c028f00b003f184300523mr12094415wmk.14.1683717384131;
        Wed, 10 May 2023 04:16:24 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id f4-20020adffcc4000000b003063d83a168sm16937426wrs.26.2023.05.10.04.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 04:16:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 May 2023 13:16:21 +0200
Message-Id: <CSIJZYWBC38N.2M99O6W1PLR4B@vincent-arch>
Cc:     <linux-pci@vger.kernel.org>, <robh@kernel.org>, <heiko@sntech.de>,
        <kw@linux.com>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Peter Geis" <pgwipeout@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
X-Mailer: aerc 0.15.1
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
 <20230509211902.GA1270901@bhelgaas>
 <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
In-Reply-To: <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Tue, May 9, 2023 at 5:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > Hi Vincenzo,
> >
> > Thanks for raising this issue.  Let's see what we can do to address
> > it.
> >
> > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > > Add a configurable delay to the Rockchip PCIe driver to address
> > > crashes that occur on some old devices, such as the Pine64 RockPro64.
> > >
> > > This issue is affecting the ARM community, but there is no
> > > upstream solution for it yet.
> >
> > It sounds like this happens with several endpoints, right?  And I
> > assume the endpoints work fine in other non-Rockchip systems?  If
> > that's the case, my guess is the problem is with the Rockchip host
> > controller and how it's initialized, not with the endpoints.
> >
> > The only delays and timeouts I see in the driver now are in
> > rockchip_pcie_host_init_port(), where it waits for link training to
> > complete.  I assume the link training did completely successfully
> > since you don't mention either a gen1 or gen2 timeout (although the
> > gen2 message is a dev_dbg() that normally wouldn't go to the console).
> >
> > I don't know that the spec contains a retrain timeout value.  Several
> > other drivers use 1 second, while rockchip uses 500ms (for example,
> > see LINK_RETRAIN_TIMEOUT and LINK_UP_TIMEOUT).
> >
> > I think we need to understand the issue better before adding a DT
> > property and a module parameter.  Those are hard for users to deal
> > with.  If we can figure out a value that works for everybody, it would
> > be better to just hard-code it in the driver and use that all the
> > time.
>
> Good Evening,
>
> The main issue with the rk3399 is the PCIe controller is buggy and
> triggers a SoC panic when certain error conditions occur that should
> be handled gracefully. One of those conditions is when an endpoint
> requests an access to wait and retry later. Many years ago we ran that
> issue to ground and with Robin Murphy's help we found that while it's
> possible to gracefully handle that condition it required hijacking the
> entire arm64 error handling routine. Not exactly scalable for just one
> SoC. The configurable waits allow us to program reasonable times for
> 90% of the endpoints that come up in the normal amount of time, while
> being able to adjust it for the other 10% that do not. Some require
> multiple seconds before they return without error. Part of the reason
> we don't want to hardcode the wait time is because the probe isn't
> handled asynchronously, so the kernel appears to hang while waiting
> for the timeout.

Yeah, I smell a hardware bug in my code. I hate waiting in this way inside=
=20
the code, so it's usually wrong when you need to do something like that.

During my research, I also found this patch (https://bugzilla.redhat.com/sh=
ow_bug.cgi?id=3D2134177)=20
that provides a fix in another possibly cleaner way.

But I don't understand the reasoning behind it, so maybe I=20
haven't spent enough time thinking about it.

> I'm curious if it's been tested with this series on top:
> https://lore.kernel.org/linux-arm-kernel/20230418074700.1083505-8-rick.we=
rtenbroek@gmail.com/T/
> I'm particularly curious if
> [v5,04/11] PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be=
 locked
> makes a difference in the behavior. Please test this and see if it
> improves the timeouts you need for the endpoints you're testing
> against.

Mh, I can try to cherry-pick the commit and test it in my own test environm=
ent. Currently, I haven't been=20
able to test it due to a lack of hardware, but I'm seeking a way to obtain =
one.=20
Luckily, I have someone on the Manjaro arm team who can help me test it,=20
so I'll try to do that.

Cheers!

Vincent.
