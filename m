Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89766FE90A
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjEKBHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKBHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 21:07:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9912B;
        Wed, 10 May 2023 18:07:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ddb2093bso1112357966b.2;
        Wed, 10 May 2023 18:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683767251; x=1686359251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBFVTTTsvzVv70iU9CVp0O8INXKx7ewdVL5aIiLNN2U=;
        b=e/mCx6wL3ikdgTkS6CB5+AVSzY4AVgz09Ncp5j58wkv/kquL+YWrSzaTyVxy65cQd7
         hwY2Un1NQ08yARrzLLKz7yXreB4720ev8/4z3mObwXkBZQpaF/xg1FRlw0PpSr9thGio
         J/rMAkjKaW+igQx2qDn13145BVNx/b00JiUoV+ntYjE7+hxLWiN9dsT/CV2bu4mnwx5t
         4s6uxOvkS/GhP2V8nrCPsJip/UkimPiJQhWL4e4D3Ob5+5KgTen0Yl6loO96I5pjO2e0
         qe1F73CjbQVkIs2zR3d8nNSK6ggGno2VoqGrpHEmpaSkp2yp3cDjIkWqMqbDC0pPXsZs
         UAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683767251; x=1686359251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBFVTTTsvzVv70iU9CVp0O8INXKx7ewdVL5aIiLNN2U=;
        b=jAlNzPglAzqhvrNK1NknG0KHr9lQ32J1HY7reAlY0yThDouU6ZSNjvKwvBEwn6DEZg
         sCF3xc1Aonbjoje3iscKDTx5RVdcG07ToCRmGwO9L1eMAqpx8W3Nmv8ZYDe2tFDIpWDJ
         Bs4zKBzK63IR9jcREpDQ269N1HKWOxh4eSJCYFdAPc+9/iu8mlCv/M8ea0EjvBzqLRNS
         RDiCIFblj2XJwpurI3nhA8ob2gZI2sAAdztLu5q3mnAtfubX3g/y0iaYc+IYXeMcbrl7
         Qix4q0eitjcagq3TLY9Onlphqh8vagHkYdWX2zbrcIvSTPIql/cgHINqcg5+d8yFUJPt
         q6pA==
X-Gm-Message-State: AC+VfDzXbh6vPe8sNBHOd5ZbscL3uk+CA9IWHDsp+SV+JX/iN9ufDGVM
        r9CqcgKp2iT2gRCQ8Lm6s33RV8o8Y1nNXJUkH50=
X-Google-Smtp-Source: ACHHUZ6y6d+r8/mc7BzoqQn93iv7U0535yE6s3qi/zBmO1f5IIMiJ71mfO3Nu/tyuP/FMMc2KDvKzoU1AAH9FLH3804=
X-Received: by 2002:a17:906:fe01:b0:94f:322d:909d with SMTP id
 wy1-20020a170906fe0100b0094f322d909dmr17099288ejb.63.1683767250852; Wed, 10
 May 2023 18:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
 <ZFwC/seTfSoaLn0v@bhelgaas>
In-Reply-To: <ZFwC/seTfSoaLn0v@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 10 May 2023 21:07:18 -0400
Message-ID: <CAMdYzYoa8dhmBx5MUG0yBPwVVXPXHrYNnR0QvKHXvV=JaKuMfw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-pci@vger.kernel.org, robh@kernel.org, heiko@sntech.de,
        kw@linux.com, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com,
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

On Wed, May 10, 2023 at 4:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, May 09, 2023 at 08:11:29PM -0400, Peter Geis wrote:
> > On Tue, May 9, 2023 at 5:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
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
> > > ...
>
> > The main issue with the rk3399 is the PCIe controller is buggy and
> > triggers a SoC panic when certain error conditions occur that should
> > be handled gracefully. One of those conditions is when an endpoint
> > requests an access to wait and retry later.
>
> I assume this refers to a Completion with Request Retry Status (RRS)?

I'm not sure the full coverage, the test patch from Shawn Lin that
allowed the system to handle the errors has the following description:
"Native defect prevents this RC far from supporting any response from
EP which UR filed is set."

>
> > Many years ago we ran that issue to ground and with Robin Murphy's
> > help we found that while it's possible to gracefully handle that
> > condition it required hijacking the entire arm64 error handling
> > routine. Not exactly scalable for just one SoC.
>
> Do you have a pointer to that discussion?  The URL might save
> repeating the whole exercise and could be useful for the commit log
> when we try to resolve this.

The link to the patch email is here, the full discussion is pretty
easy to follow:
https://lore.kernel.org/linux-pci/2a381384-9d47-a7e2-679c-780950cd862d@rock=
-chips.com/
Also:
https://lore.kernel.org/linux-rockchip/1f180d4b-9e5d-c829-555b-c9750940361e=
@web.de/T/#m9c9d4a28a0d3aa064864f188b8ee3b16ce107aff

>
> > The configurable waits allow us to program reasonable times for
> > 90% of the endpoints that come up in the normal amount of time, while
> > being able to adjust it for the other 10% that do not. Some require
> > multiple seconds before they return without error. Part of the reason
> > we don't want to hardcode the wait time is because the probe isn't
> > handled asynchronously, so the kernel appears to hang while waiting
> > for the timeout.
>
> Is there some way for users to figure out that they would need this
> property?  Or is it just "if your kernel panics on boot, try
> adding or increasing "bus-scan-delay-ms" in your DT?

There's a listing of tested cards at:
https://wiki.pine64.org/wiki/ROCKPro64_Hardware_compatibility

Most cards work fine that don't require a large BAR. PCIe switches are
completely dead without the above hack patch. Cards that lie in the
middle are ones that expect BIOS / EFI support to initialize, or ones
that have complex boot roms and don't initialize quickly.
But yes, it's unfortunately going to be "if you panic, increase the
delay" unless a more complete database of cards can be generated.

Very Respectfully,
Peter Geis

>
> Bjorn
