Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4096167D018
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAZPZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAZPYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:24:52 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929D14497;
        Thu, 26 Jan 2023 07:24:34 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15fe106c7c7so2744458fac.8;
        Thu, 26 Jan 2023 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag06Hb9qIk6ptR42BWFbeZ8DVLKjhY0QP30dT9rCnf4=;
        b=cyjF7viABigh+M4VRRLEDTZqNRkAo8TG5GENzKKvOJivxXG3OFSyboWyDYIw1On5Rs
         bSu8FUdAzd2l96kLWaZgrdgPDbFGfszBDoG/1jhKyWVqtVjdwf3Cydt6fqlKQfAXT1DH
         HmHPpPKk38guaELzr4/dRmO5rHHpuYl3rROoo+T+Mb/dNJHP6tk45svYziP1IVLYbjeG
         gTjMw9ZGM6Lz1TcopZPqF2lcrMIQb+/TgRhmGnSqiQ6jtwWnOul0EuwtY5D/xnlIEuvP
         dUuTBvK3lRpirXty55CGl3zOu9Rr+TZJrBk+9QdFXeoWzXPr9MvtdH2TPlPAb5NhNqRd
         660w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag06Hb9qIk6ptR42BWFbeZ8DVLKjhY0QP30dT9rCnf4=;
        b=Eul4MASqN9xek1Evt81GcjaLfbGhkjZwJKXdl4Sn6gO+KSbMBU1+CFrpE7CZdN9iQK
         r6zCmAshvLkIN6eGqDHtwW98/zuZWoq4mVNZ3PoPh9mjAZFSckDNbhuzr3ox9WYrz8Uh
         ir2QD0824eh/9sbgvI5th7pepfjv2/t61MPSXI0X0ghNr21XurOom84HCILilRfFQgfZ
         02eEUqSjCDHBzbNKufT0256K4rkgXaRKzcgnLJgFIvFqnvTLJdiVk6CmoliHU9i6ku4p
         JZLmuVRR7BB7iXy+9aR/8OWo7nHfymFm8kPUmNQ52cFuoA3xHYWd0Br+0oM9OI9TxpnF
         64hA==
X-Gm-Message-State: AFqh2kqYmFQleBKTvtNyefhJYQlAM+5+N5YbpSpZM2En0GRexJsC07x0
        f1cQ7PoqkfB+5a7Y6xV9BtaubwDZpyWm/SaqJWU=
X-Google-Smtp-Source: AMrXdXvcV4CLcI1gQfSKDu7AQMnOiuJgSHIzx3ort5jv5k0l30wji9hXaAQ67eTJ6qlWKa39m8pJ7cRETaJ4R+DKjgU=
X-Received: by 2002:a05:6870:9728:b0:148:5512:23c0 with SMTP id
 n40-20020a056870972800b00148551223c0mr3457750oaq.265.1674746674128; Thu, 26
 Jan 2023 07:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com> <20230126145200.GA1270846@bhelgaas>
In-Reply-To: <20230126145200.GA1270846@bhelgaas>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 26 Jan 2023 16:23:57 +0100
Message-ID: <CAAEEuhq9X0ppqTMp7fnZapbubf9k8xhH=u3gPva3hEpAdawK3w@mail.gmail.com>
Subject: Re: [PATCH 0/8] PCI: rockchip: Fix PCIe endpoint controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, Bjorn
Thank you for your prompt reply and helpful comments.

Le jeu. 26 janv. 2023 =C3=A0 15:52, Bjorn Helgaas <helgaas@kernel.org> a =
=C3=A9crit :
>
> Hi Rick,
>
> Thanks very much for your work.
>
> On Thu, Jan 26, 2023 at 02:50:40PM +0100, Rick Wertenbroek wrote:
> > This is a series of patches that fixes the PCIe endpoint controller dri=
ver
> > for the Rockchip RK3399 SoC. It is based on Linux kernel 6.0.19
> >
> > The original driver in mainline had issues and would not allow for the
> > RK3399 to operate in PCIe endpoint mode. This patch series fixes that s=
o
> > that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> > endpoint.
>
> So we merged cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip
> PCIe controller") when it actually didn't work?  Ouch.  Thanks for
> fixing it and testing it.

It seems it wasn't fully tested, the code compiles and kernel module loads,
but further functionality didn't seem to have been tested
(e.g., lspci, and with the pcitest tool and pci_endpoit_test_driver).

>
> For the next iteration, can you please update these subject lines and
> commit logs to:

Thank you, I will prepare the changes and add them to the next iteration
with changes from other comments that may arise.

>
>   - Use imperative mood, i.e., read like a command, instead of a past
>     tense description of what was done.  For example, say "Remove
>     writes to unused registers" instead of "Removed writes ..."
>
>   - Be more specific when possible.  "Fix" conveys no information
>     about the actual code change.  For example, "Fixed endpoint
>     controller Configuration Request Retry Status" gives a general
>     idea, but it would be more useful if it said something about
>     clearing config mode after probe.
>
>   - Say what the patch does in the commit log.  The current ones often
>     describe a *problem*, but do not explicitly say what the patch
>     does.  The commit log should be complete in itself even without
>     the subject line, so it usually contains a slightly expanded
>     version of the subject line.
>
>   - Split patches that do more than one logical thing.  The commit log
>     for "Fixed MSI generation ..." talks about a u16/u32 shift issue,
>     but the patch also adds an unrelated check for multi-function
>     devices.

I will. I tried to split everything into the function it was related to, bu=
t I
now understand I should split even more so that the commit message
and changes are more tightly linked.

>
>   - If a patch is a fix for an existing issue and may need to be
>     backported, identify the commit that introduced the issue and add
>     "Fixes: " lines.  This helps distros figure out whether and how
>     far to backport patches.

Does this mean I should refer to the commit cf590b078391
("PCI: rockchip: Add EP driver for Rockchip PCIe controller") ?
Because it wasn't working in the first place ?

>
>   - Refer to the device consistently.  I see:
>       RK3399 PCI EP core
>       RK3399 SoC PCIe EP core
>       RK3399 PCIe endpoint core
>     I vote for "RK3399 PCIe Endpoint core".

I agree.

>
> Notes about imperative mood:
>   https://chris.beams.io/posts/git-commit/
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3Dv6.0#n94

Thank you for all the pointers, I'll take them into account for the
next iteration. This is the first time I actually submitted a series of
patches to the LKML so it's all relatively new to me.
