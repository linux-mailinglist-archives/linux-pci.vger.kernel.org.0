Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F33701677
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEMLk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMLk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 07:40:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E82701;
        Sat, 13 May 2023 04:40:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so16729359a12.1;
        Sat, 13 May 2023 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683978024; x=1686570024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ9as5crGNXR2voKPpqJxT4w6t/Cg57+liuts81XblU=;
        b=QRZQDrrRh/JBWK+hNSXx3B4jHQtsZr3D8XA54ZDF/liiCBQhLHlFFB0kxkf0X/VpaG
         9AAXjiguK739cj0tJMYka+SeciWYqTO8FJPQBkEQ+I7OvW2HBmcgFtlzeKO/FigHqmSl
         TA31DTqXfn0XNziPt/VOkjOf7VdUy2giSFyT6FdlMkRSjE03II/hscWyNOBpVxm/+1kv
         T0vNrBQB8rH8VJ0T/EkMJe9odlIg61z7Z5nVRb2d7FQPApel2NXaxa9ri5VuaE2D2haP
         agwTwNQMBOaXitVGPIsR6gL5p6te2GcyW3jDkfBQpLePktCKyWCQ80kjVF48jy+E3TCm
         fCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683978024; x=1686570024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZ9as5crGNXR2voKPpqJxT4w6t/Cg57+liuts81XblU=;
        b=NorQNlRpT6iBBci6vFGeyHTgNJSvj+Ndnt8wASDs3M/SN51gylnexcvgx0i97AauPq
         tBCJQjAloVwZaZqciK7qqDeJQWYt1MFRDh83sOd9JsMw5JBu+yeaxhJ/ZfTiRSgQqWtb
         iCqvNFZLwauu2nhnZxlA3w5jfewvm/1eTnN+qkvht9TBFAufb9DrvOvW40TMbOCE/Br7
         fDIbMe103xgJ7W2Wddc6rIqnQM06lANabUw/9H6KCbnm3SdBuhqDxKtzpJnRnrmoZwGe
         jf2fpkSACU2/Tuf2cKREhM1zOmy78oArkVWY+F+R+4gc6qHMth4nmkL8DQLfBiRckIku
         B11A==
X-Gm-Message-State: AC+VfDzqsooX2CGY+82S67sOTW8CLPvqfAIdHcdKXsRIGgfmH3H0iTuI
        CfoaCZ7m/+nB6R3TrNL29Ye20DChzum02z9D6gQ=
X-Google-Smtp-Source: ACHHUZ4MFzhA6lWlkhasxKlMtmwM5Hv/840hxpapsCu/tRKKN98PijFTddvJ+mCdeHQTPkuB8j5ZtG/lWGwZlfMpGq8=
X-Received: by 2002:a17:907:7dab:b0:96a:4f89:3916 with SMTP id
 oz43-20020a1709077dab00b0096a4f893916mr8403783ejc.58.1683978024297; Sat, 13
 May 2023 04:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <CSK8M39MQL2C.3S7JO031H0BA2@vincent-arch> <ZF7m1npzLZmawT8Y@bhelgaas>
In-Reply-To: <ZF7m1npzLZmawT8Y@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 13 May 2023 07:40:12 -0400
Message-ID: <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>, kw@linux.com,
        heiko@sntech.de, robh@kernel.org, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
        broonie@kernel.org, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
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

On Fri, May 12, 2023 at 9:24=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc ARM64 folks, in case you have abort handling tips; thread at:
> https://lore.kernel.org/r/20230509153912.515218-1-vincenzopalazzodev@gmai=
l.com]
>
> Pine64 RockPro64 panics while enumerating some PCIe devices.  Adding a
> delay avoids the panic.  My theory is a PCIe Request Retry Status to a
> Vendor ID config read causes an abort that we don't handle.
>
> > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> >> ...
> >> [    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
> >> [    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MAN=
JARO-ARM
> >> #1
> >> [    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
> >> [    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=3D--)
> >> [    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
> >> [    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
> >> ...
> >> [    1.229939] Kernel panic - not syncing: Asynchronous SError Interru=
pt
> >> ...
> >> [    1.229955]  nmi_panic+0x8c/0x90
> >> [    1.229956]  arm64_serror_panic+0x78/0x84
> >> [    1.229958]  do_serror+0x15c/0x160
> >> [    1.229960]  el1_error+0x84/0x100
> >> [    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
> >> [    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
> >> [    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
> >> [    1.229968]  pci_scan_single_device+0xa4/0x144
>
> On Fri, May 12, 2023 at 12:46:21PM +0200, Vincenzo Palazzo wrote:
> > ... Is there any way to tell the kernel "hey we need some more time
> > here"?
>
> We enumerate PCI devices by trying to read the Vendor ID of every
> possible device address (see pci_scan_slot()).  On PCIe, if a device
> doesn't exist at that address, the Vendor ID config read will be
> terminated with Unsupported Request (UR) status.  This is normal
> and happens every time we enumerate devices.
>
> The crash doesn't happen every time we enumerate, so I don't think
> this UR is the problem.  Also, if it *were* the problem, adding a
> delay would not make any difference.

Is this behavior different if there is a switch device forwarding on
the UR? On rk3399 switches are completely non-functional because of
the panic, which is observed in the output of the dmesg in [2] with
the hack patch enabled. Considering what you just described it looks
like the forwarded UR for each non-existent device behind the switch
is causing an serror.

>
> There *is* a way for a PCIe device to say "I need more time".  It does
> this by responding to that Vendor ID config read with Request Retry
> Status (RRS, aka CRS in older specs), which means "I'm not ready yet,
> but I will be ready in the future."  Adding a delay would definitely
> make a difference here, so my guess is this is what's happening.
>
> Most root complexes return ~0 data to the CPU when a config read
> terminates with UR or RRS.  It sounds like rockchip does this for UR
> but possibly not for RRS.
>
> There is a "RRS Software Visibility" feature, which is supposed to
> turn the RRS into a special value (Vendor ID =3D=3D 0x0001), but per [1],
> rockchip doesn't support it (lspci calls it "CRSVisible").
>
> But the CPU load instruction corresponding to the config read has to
> complete by reading *something* or else be aborted.  It sounds like
> it's aborted in this case.  I don't know the arm64 details, but if we
> could catch that abort and determine that it was an RRS and not a UR,
> maybe we could fabricate the magic RRS 0x0001 value.
>
> imx6q_pcie_abort_handler() does something like that, although I think
> it's for arm32, not arm64.  But obviously we already catch the abort
> enough to dump the register state and panic, so maybe there's a way to
> extend that?

Perhaps a hook mechanism that allows drivers to register with the
serror handler and offer to handle specific errors before the generic
code causes the system panic?

Very Respectfully,
Peter Geis

[2] https://lore.kernel.org/linux-pci/CAMdYzYqn3L7x-vc+_K6jG0EVTiPGbz8pQ-N1=
Q1mRbcVXE822Yg@mail.gmail.com/

>
> Bjorn
>
> [1] https://lore.kernel.org/linux-pci/CAMdYzYpOFAVq30N+O2gOxXiRtpoHpakFg3=
LKq3TEZq4S6Y0y0g@mail.gmail.com/
