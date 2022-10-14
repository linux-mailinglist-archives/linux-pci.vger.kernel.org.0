Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECC5FF301
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJNRdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJNRdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 13:33:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A91D20CA;
        Fri, 14 Oct 2022 10:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BD5B82276;
        Fri, 14 Oct 2022 17:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3E7C433C1;
        Fri, 14 Oct 2022 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665768792;
        bh=nzxnAJmocdVc0OIXHQF2dyBHBQZ9Fu8WY7GVAZagNUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=likyj8YjIMlqVk9KW3r5cko4Fj12v8lDNAsGddB0G/NGi1ZB8aL2Hghc0kaNi5mM+
         fEKzoCvoRs7mwRPwr9aF/hVIamu1anooV3NHQpfw1wLwyraq3cKVyOQwUZOEWN4CdU
         O4i/pZbA2ydrQcQ+cgRJdxIqHhNVTJc/1KQS1u8tyPKtW/8GIohVVw/7QCx31vgOkP
         FTI3pIs+mY9NHdtHWGaYKn00Rjhbd+nU0EBiAbMMXBK2wrFH96YByQBGiliA85tcjW
         arCMZajX2TTmSTeRs9YxnNxFubUSf7ZKncsD1AgzP9sh2ST1XJvUe0wza8XNIJzQYM
         oOeLfghCUQCsw==
Received: by mail-vs1-f43.google.com with SMTP id p7so5611580vsr.7;
        Fri, 14 Oct 2022 10:33:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf06KehpSvr5xUvL6+wCkCpOVVqO4Syx2hjC/4OMpNQAyhUxf8mB
        X00+c8LFW6jDDj20Rr9TXiyArMkbpVQSOK7fBQ==
X-Google-Smtp-Source: AMsMyM4TP4PjzqDTN2tC9wkFDi4o8DRDf1izbn9qxHFhrlkY0MPOw7TSTVhcsKNcluXzcdSyMSLAqc7I/2UNzUCk2do=
X-Received: by 2002:a67:3c7:0:b0:39b:45c2:6875 with SMTP id
 190-20020a6703c7000000b0039b45c26875mr3248666vsd.6.1665768791744; Fri, 14 Oct
 2022 10:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com> <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com> <20221010104210.68edf825@fixe.home>
 <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com> <20221013100245.14c509ec@fixe.home>
 <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
In-Reply-To: <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Oct 2022 12:33:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
Message-ID: <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 12:28 PM Frank Rowand <frowand.list@gmail.com> wrot=
e:
>
> On 10/13/22 03:02, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Thu, 13 Oct 2022 01:05:26 -0500,
> > Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >
> >>> This would also require two different descriptions of the same card
> >>> (for ACPI and device-tree) and would require the final user to create=
 a
> >>> specific overlay for its device based on the PCI slots the card is
> >>> plugged in.
> >>
> >> One of the many missing pieces of overlay support.  There have been se=
veral
> >> discussion of how to describe a "socket" in a device tree that a devic=
e
> >> could be plugged into, where a single device tree subtree .dtb could b=
e
> >> relocated to one or more different socket locations.  Thus in this
> >> case a single overlay could be relocated to various PCI slots.
> >>
> >> I don't expect be getting involved in any future efforts around socket=
s
> >> (see my following comment for why).
> >>
> >>>
> >>> The solution we proposed (Lizhi and I) allows to overcome these
> >>> problems and is way easier to use. Fixing the potential bugs that mig=
ht
> >>> exists in the overlay layer seems a way better idea that just pushing
> >>
> >> It is not potential bugs.  The current run time overlay implementation=
 is
> >> proof of concept quality and completeness.  It is not production ready=
.
> >>
> >> I got an opportunity for early retirement a couple of weeks ago.  My f=
irst
> >> inclination was to continue the same level of device tree maintainersh=
ip,
> >> but I am quickly realizing that there are other activities that I woul=
d
> >> like to devote my time and energy to.  I will continue to support Rob =
with
> >> minor patch reviews and testing, and potentially finishing up some
> >> improvements to unittest.  On the other hand, bringing run time overla=
y
> >> support to product quality would be a major investment of my time that=
 I
> >> am not willing to continue.
> >
> > Hi Frank,
> >
> > This explains your position on the overlay support and I can
> > certainly understand it ! Regarding the fact that it would enter
>
> No, my position on the technical aspects of overlay support is totally
> unchanged.
>
> The only thing that has changed is that my time will not be available to
> assist in future overlay related work.  The burden for this will fall
> more on Rob than it has in the past.

s/Rob/someone that steps up to maintain the overlay code/

> > "production", the devices we are talking about are not really
> > widespread yet? This would be a good opportunity to gather feedback
> > early and improve the support gradually. We could probably even be able
> > to support improvements in the overlay code if needed I guess.
>
> That is avoiding my point about the current implementation being
> proof of concept.

I think it would be better to talk in terms of under what conditions
the overlay support is adequate (for production) rather than a blanket
statement that it is not-production ready. A large part of it is
really outside the code itself and related to going from static to
dynamic DT. There are certainly issues, but dynamic DTs have been used
in production for a very long time. However, that usage has been
constrained.

Rob
