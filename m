Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE75F28DE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJCG7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 02:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJCG7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 02:59:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633865AB
        for <linux-pci@vger.kernel.org>; Sun,  2 Oct 2022 23:59:47 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B0EBA3F849
        for <linux-pci@vger.kernel.org>; Mon,  3 Oct 2022 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664780382;
        bh=UHiuVEKc94OUJVqIYBM7NGy3SMjIJiq4PorrDzTuUAM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QWwL9mF/BDTGeh3ElZLUaDY0e1YiRDSFnnqkIr0V0eV3kAzajh3Y4ODJFkjer2P3M
         aCNB4X9b5w4YC5EBCT2Lw/Yoc7RGXcmpsKs0/dtAKQO66T9nOK4dKQnVwcODpdkAhi
         CRQaVoF4wjCyKsFGA94hZT85vV0j+SJYQ6A+7C22ogM+B+Az/pJneUgdcCV2YgwF3B
         GI+BagCPYO4dKBNepY7VvtxIyEks2vt4xItlu2xbvmgNqvfryo2GpmzFfv+b0rU+wI
         QGoc0NGdU+IMcoPU3xW7tbcTlFiKzeS1W3r7XfK/eWC3BvfB/P7pgRMOHu+oNQS8RO
         rwsTMNT6Cqtkg==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1327c2ef805so891061fac.21
        for <linux-pci@vger.kernel.org>; Sun, 02 Oct 2022 23:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UHiuVEKc94OUJVqIYBM7NGy3SMjIJiq4PorrDzTuUAM=;
        b=UZvxKrNJQmiCUzy0YX8TiGjl8bdP9cKlKpmchpSSCyYcoVUHANWYZWFnFnXmj9ES2Y
         KzNBqwhD9Ha5Br/PhzCTKG67m1N5h19lYoN65zARCdjdxnD28qEiCRasJrL6tM6htYfI
         zJy0hEkF/cACjtEu/7cRVcYvZWnvabLdatXheGXWXoPDpwHR1BC8nhYD8/hhPETPmIjx
         BTdYCIebCPz5w9hKrIwOG69MYvlzLGyIhapj9tzIxIdrB6l0firV1VVqITzSBs+EVjYG
         XauRo8HR1z9HOf82flBsN9iX2Hif0T4sTXVCQv/bxLEre3EqvCYKS63nJQHN6jtfDdNy
         YboQ==
X-Gm-Message-State: ACrzQf0/5fUlis0PdL1xk6u7BR75cvLEsGAjzEx846dVfO50Px44qlLc
        pIsj878JlR3yO9PC7FkbsGzIm8Sk155FlatbwvO/DKpUgpgZeSBWBEZrikQE9aimyyIbAWRUut7
        H6b1Z124ONCAfcugqSvsRwx+EucPNtRMfPiOGwhz+oO8LdOQ/SvFDYg==
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id h11-20020aca180b000000b003528bdac428mr3470638oih.13.1664780381371;
        Sun, 02 Oct 2022 23:59:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zdCtBQ3UdibMD6yNa4by2Yri2tdCrhDWrQ1u1+t1VIRLpocsG5334oeh4l0FV+NxHnTdijt2a8h5owzuT180=
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id
 h11-20020aca180b000000b003528bdac428mr3470629oih.13.1664780381066; Sun, 02
 Oct 2022 23:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220930091050.193096-1-chris.chiu@canonical.com> <20220930151817.GA1973184@bhelgaas>
In-Reply-To: <20220930151817.GA1973184@bhelgaas>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 3 Oct 2022 14:59:30 +0800
Message-ID: <CABTNMG0SbnYc1LkPnrNLB-MTVyEkutO0vwW+8GhuHaQOw__Zxw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Make SUNIX serial card acceptable latency unlimited
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 11:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 05:10:50PM +0800, Chris Chiu wrote:
> > SUNIX serial card advertise L1 acceptable L0S exit latency to be
> > < 2us, L1 < 32us, but the link capability shows they're unlimited.
> >
> > It fails the latency check and prohibits the ASPM L1 from being
> > enabled. The L1 acceptable latency quirk fixes the issue.
>
> Hi Chris, help me understand what's going on here.
>
> The "Endpoint L1 Acceptable Latency" field in Device Capabilities is
> described like this (PCIe r6.0, sec 7.5.3.3):
>
>   This field indicates the acceptable latency that an Endpoint can
>   withstand due to the transition from L1 state to the L0 state. It is
>   essentially an indirect measure of the Endpoint=E2=80=99s internal
>   buffering.
>
>   Power management software uses the reported L1 Acceptable Latency
>   number to compare against the L1 Exit Latencies reported (see below)
>   by all components comprising the data path from this Endpoint to the
>   Root Complex Root Port to determine whether ASPM L1 entry can be
>   used with no loss of performance.
>
> The "L1 Exit Latency" in Link Capabilities:
>
>   This field indicates the L1 Exit Latency for the given PCI Express
>   Link. The value reported indicates the length of time this Port
>   requires to complete transition from ASPM L1 to L0.
>
> Apparently the SUNIX device advertises in Dev Cap that it can tolerate
> a maximum of 32us of L1 Exit Latency for the entire path from the
> SUNIX device to the Root Port, and in Link Cap that the SUNIX device
> itself may take more than 64us to exit L1.
>
> If that's accurate, then we should not enable L1 for that device
> because using L1 may cause buffer overflows, e.g., dropped characters.
>
> Per 03038d84ace7 ("PCI/ASPM: Make Intel DG2 L1 acceptable latency
> unlimited"), the existing users of aspm_l1_acceptable_latency() are
> graphics devices where I assume there would be little data coming from
> the device and buffering would not be an issue.
>
> It doesn't seem plausible to me that a serial device, where there is a
> continuous stream of incoming data, could tolerate an *unlimited* exit
> latency.
>
> I could certainly believe that Link Cap advertises "> 64us" of L1 Exit
> Latency when it really should advertise "< 32us" or something.  But I
> don't know how we could be confident in the correct value without
> knowledge of the device design.
>
> Bjorn

Hi Bjorn,
    Thanks for the clear explanation. I understand your concern and
I'll try to reach the vendor for their comment about the device
design. But the value "unlimited" for L1 exit latency with specified
L1 acceptable latency on a self-claimed "ASPM L1" capable device
really looks weird to me, I'd rather assume the 32us limit in DevCap
is actually for LinkCap (L1 exit latency), and the acceptable latency
is actually unlimited.

    I'll try to ask SUNIX if they intentionally program the latency
this way and expect the device is unlikely to enter ASPM L1. Or they
just accidentally program it with the incorrect value. Will keep
updating here. Thanks

Chris

>
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4944798e75b5..e1663e43846e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5955,4 +5955,5 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5=
6b0, aspm_l1_acceptable_latency
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptab=
le_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptab=
le_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptab=
le_latency);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999=
, aspm_l1_acceptable_latency);
> >  #endif
> > --
> > 2.25.1
> >
