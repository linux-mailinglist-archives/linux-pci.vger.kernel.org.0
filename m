Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF46787F63
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjHYFn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHYFn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 01:43:27 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966D1FD5
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 22:43:24 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 068A43F232
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 05:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692942203;
        bh=LJCUcg31UklNFHV2Q+2OejZ1G9CU8oFqGaaQwsHgWIM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r4j0gkK2lmB1b4MfHQOsHl5g3vkkqISVjrYrq73myMczc4Z53tAnK7lMJDVS+TiL9
         EPqvAEGioO7kQLxwwjyUun9GDC9g99CwgGhCeFc3DTHpZZGfTPRYfOPHdQixP+s4qn
         8OQYTTJFChBAwg0jCiBrm5/Dc6fxld77A3fu6gqCVSRyMLrv3l60uzMoRsX+xHdFFn
         TlNeGVFsVl6gL4IR9MTcCiEzNFGlhA7ximOxn5vem6EBUX4e/KuS/MSL4j/zCTDoxO
         HrE07R+TPFWsqEaG8OSwBqSvEC6Il88SyoNuS2ZdnqrGoY4IF3FUIa5pPHb53CWO3U
         gTh0nIq0b2zlw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1c8d1a33eaeso622796fac.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 22:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692942202; x=1693547002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJCUcg31UklNFHV2Q+2OejZ1G9CU8oFqGaaQwsHgWIM=;
        b=RqvCcBxYWyQR9QhBP9pYzg1mRbafuxQvWYJcaBLYD/4vaZRR4EsQqMn8XO69thdN8N
         FuTPk5C6m3zLF+O5H+gFAyV4yz7RGF/e9WPy3zk0TDf5XgKnsPx/fFVoOJ+fAhYXReoC
         82Cnk1MT5rMIAMAYYWMr7GcyYC7xlsNcQy2YTFHbZUL1nG9UjCkniUAw1gjmssmevvGW
         A3SnBD2jhOiTtbPOdRNDgsOz5lI4WqJyCgzfN/8nz2B2aDrA8wWL8x7azuQZFIX2y0ID
         IYnnRxSrqXxyXBs87F2YeZv6eTZsCeZNNrFzX+4zZvgJH4QclnaK8+Vfc+Tfh2wg98bF
         rENQ==
X-Gm-Message-State: AOJu0YzkngYP89EYKMEUfr85ZzLDz/13RS5j9n3k4w5MjpTV9ddePch0
        fX4gllvXvmPY11H8/4QVIkOeYyNvx+rDv/xiRU7vIuRxnL4AGgT7XxUHulXWC8sEC8tZ7/OTKpE
        QxEQLOT3gJcjJV7GwOcoo2MqAEg8vrItHRdWjWlh+94IKparVVKReru23+6ap7w==
X-Received: by 2002:a05:6870:818f:b0:1bf:acf:c1bf with SMTP id k15-20020a056870818f00b001bf0acfc1bfmr2093967oae.38.1692942201902;
        Thu, 24 Aug 2023 22:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEdy5NqUU8ce15yI3fHR8e6lh4+thS3wKMlbFd2kzAgOfDR7NRbVZUVYMML67fU3gNYcqgb/hJIicV7FaLM3g=
X-Received: by 2002:a05:6870:818f:b0:1bf:acf:c1bf with SMTP id
 k15-20020a056870818f00b001bf0acfc1bfmr2093954oae.38.1692942201718; Thu, 24
 Aug 2023 22:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
 <20230824115656.GW3465@black.fi.intel.com> <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
 <20230825052946.GX3465@black.fi.intel.com>
In-Reply-To: <20230825052946.GX3465@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 25 Aug 2023 13:43:08 +0800
Message-ID: <CAAd53p71gLHq71WtnWBXOaX6K6rXyZ=nrGND5x8ZKXvyNsWBtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 1:29=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > Hi,
> >
> > On Thu, Aug 24, 2023 at 7:57=E2=80=AFPM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> > > > In addition to nearest upstream bridge, driver may want to know if =
the
> > > > entire hierarchy can be powered off to perform different action.
> > > >
> > > > So walk higher up the hierarchy to find out if any device has valid
> > > > _PR3.
> > >
> > > I'm not entirely sure this is good idea. The drivers should expect th=
at
> > > the power will be turned off pretty soon after device enters D3hot. A=
lso
> > > _PR3 is not PCI concept it's ACPI concept so API like this would only
> > > work on systems with ACPI.
> >
> > IIUC, Bjorn wants to limit the AER/DPC disablement when device power
> > is really off.
> > Is "the power will be turned off pretty soon after device enters
> > D3hot" applicable to most devices? Since config space is still
> > accessible when device is in D3hot.
>
> Well the device may be part of a topology, say Thunderbolt/USB4 (but can
> be NVMe or similar) where it initially goes into D3hot but in the end
> the whole topology is put into D3cold. The device driver really should
> expect that this happens always and not try to distinguish between the
> D3hot or D3cold.

What if the device is not in such topology? There are cases that the
rootport doesn't have Power Resources associated so the rootport also
stays in D3hot.
I think what Bjorn suggested is to keep AER enabled for D3hot, and
only disable it for D3cold and S3.

>
> > Unless there are cases when device firmware behave differently to
> > D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> > and system S3.
>
> Yes, this makes sense.

I agree that differentiate between D3hot and D3cold unnecessarily make
things more complicated, but Bjorn suggested errors reported by AER
under D3hot should still be recorded.
Do you have more compelling data to persuade Bjorn that AER should be
disabled for both D3 states?

Kai-Heng
