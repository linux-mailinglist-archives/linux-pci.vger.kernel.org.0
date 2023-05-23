Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3970DE63
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjEWOCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjEWOCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 10:02:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE1E118
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 07:02:44 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6af6db17a27so1312317a34.2
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684850564; x=1687442564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnVkTFNhh/4epOPAyS89EhWDABLaRCDNblah5EYE7V4=;
        b=NbuKUufbSf5ffEiWN66zk1hgl7ip59fF0nL2J0+2PRT0uG+0KrzLnYpgnUy6WK8QDK
         xRLfN4ajEerlad1KYPMKenHnVivgrzmIIIhv5BXVsPYvlF2s90d6c0/LIVv8EDaAD3N+
         6ZQYx1TWziMbyW19PEXNuJ37EgZWypm3vLFTIXARWkKKNuWLm0RFDP5Zx88iPhCv15UH
         qqdaPumm5lmqsH+N8oSUYZQmt+SNsMgnIaJGitlxEtv06Wv/9xZFGfgCarIaNUY/Zkl1
         wKMU3Vzf+l71G7HEcfr6XrlkPYxD+LOa1DFeXvj5N0nTSyEatnmWh+oxm94RjESGStIE
         CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850564; x=1687442564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnVkTFNhh/4epOPAyS89EhWDABLaRCDNblah5EYE7V4=;
        b=OzkAE7U5GcV+u+7E91MiB+Mxa21sNuWGPJFKKFANAsEJsiwMpZobGF6D+wiPYLl/Ev
         NT8p1a/u2KTjh//n5otbXAfhahOl9jGNuWLjjBc1war20ORvXYIRM71ixnOdTe7OxTlk
         s966eq+7cJCWoyKVHQ1S04VZKfLAt0BrEv+Aq5RSo973RRTRna4lHlhDMsbJlfLiVp9V
         hQk0ZL1WHtdtHolK/wcA+EDaY5EJwi+d9zTxBSXmxQm1LKpnPnOaDEkQM5RwIBMhIZBA
         cqwmPiV695VEQsLnRJsg8tDd6KFb7RoFZQMgERaj9z908Np3nV9PMGqCzAfFiCxC+SVc
         7CfA==
X-Gm-Message-State: AC+VfDztw46nRagef3SUKNVenpH9dOkpMPb3exC5XCESk5KjJYHR2+WR
        7lp14nfSY2gtoiEbJPpbnTNzZuaVX5yfTRRuCik=
X-Google-Smtp-Source: ACHHUZ4JjEpDGOK+rFBUUxfs8Yj5NZ99gphZlukK7yyMdYPJg9S/fAzUTsWxnlAdxNaPnkjj2aRHTapYf7uLQUIm2wY=
X-Received: by 2002:a05:6870:8545:b0:187:e288:9279 with SMTP id
 w5-20020a056870854500b00187e2889279mr6680056oaj.19.1684850563960; Tue, 23 May
 2023 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230523040232.21756-1-shiwu.zhang@amd.com> <ZGxfEklioAu6orvo@infradead.org>
In-Reply-To: <ZGxfEklioAu6orvo@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 May 2023 10:02:32 -0400
Message-ID: <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shiwu Zhang <shiwu.zhang@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org
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

On Tue, May 23, 2023 at 5:25=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> > +     { PCI_DEVICE(0x1002, PCI_ANY_ID),
> > +       .class =3D PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> > +       .class_mask =3D 0xffffff,
> > +       .driver_data =3D CHIP_IP_DISCOVERY },
>
> Probing for every single device of a given class for a single vendor
> to a driver is just fundamentaly wrong.  Please list the actual IDs
> that the driver can handle.

How so?  The driver handles all devices of that class.  We already do
that for PCI_CLASS_DISPLAY_VGA and PCI_CLASS_DISPLAY_OTHER.  Other
drivers do similar things.  The hda audio driver does the same thing
for PCI_CLASS_MULTIMEDIA_HD_AUDIO for example.

Alex
