Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D789449E061
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiA0LOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 06:14:39 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42944
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240028AbiA0LOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 06:14:39 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A338C3F1D1
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643282077;
        bh=ei0q12+pTEkVCSC3KLPxXTL3wN1Kz2V2e0OB+SXoUME=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZVHblktjtJb4zmm6qxwYNHV/E7IVKctDR0Xi8qhJjDB9XxuUw2/ozucX3kxsw+ncb
         Y3Xc0KKMAhz22VhYK8dx0SRyyzxfVrErXNb1H/9QWMDfBI1xxUkWFCrZ3DtQU3DdmP
         mLAklBFPcsfBWrffkhFrObBGbJtGYvbWSwjvvB85emFAp/8e9N8tpy8jV/9sJS2nv1
         bU6LBlOPog3l8BC4T0Ws5kkL2idbGUyURXVgFHZ89pUONKQHgpiUuWfcHKZLR6b+tK
         1/+oKNm7LzK8Ftw3lL71MkqcG/Q4o0O5mCp9dJ89Kz3WIXKr5EpehGLeb0LjG/oVWU
         orjXazh0AY2Gw==
Received: by mail-ot1-f71.google.com with SMTP id y20-20020a0568302a1400b0059ea94f86eeso1416856otu.8
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 03:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ei0q12+pTEkVCSC3KLPxXTL3wN1Kz2V2e0OB+SXoUME=;
        b=vCWvmhmcqPCxoJ7q11jfHrR9rBsVu7bP8XoM1ZJ2A8jaxv+lniI6EvVTkD89IKjeKb
         //bH6pkLt1S2BXH56O/iEB6QcpNZ15hgPln3RjrOBagJ47pvrrqYAxPXBQd36AjJ1eAh
         /MKE0n2+mtT6mxRFi+4ly5gIQULoSn0e1hlaOiXB9A38ouXPk8BvcbagNaKLUBaGwkif
         YSCGCqzvTTlmBnbAtchQPru6nY6N9fK/uwrrE6CvTdOujEXeQWEbdCRFWWWo44mV2dNd
         bJOnH2BKXOGiNEbwm9PidH1N+qqlYH/2YZBw8IFRNL+r/wZIguXOpsjjCe0n+1HJ+beQ
         E1tw==
X-Gm-Message-State: AOAM533kgnfafqA+etGpRQ8nXrCNtbiZp/shRJkuL1h0ikAyQ17nCC+4
        XtaFDmqzgAChDMAe8bk5FDGWRhvz/F4u0N0oPTIklVJrtL3iTUfyvH1U3uyuJWFQ4e6h/jJe/wG
        9qKFyo6GT8o9JcOt8wmBusRpFAg1stZgHo2mJOb9G779gcpvecsc1Iw==
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr1968524oib.57.1643282076596;
        Thu, 27 Jan 2022 03:14:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxEE5Ap4FJ4cUst9yvbfsRQokijydzPA6OcoO6QyYWtnn1PDvaX7TZkZkLGBEICFTLx1JnuD/+0yw+QuDnNaE=
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr1968509oib.57.1643282076282;
 Thu, 27 Jan 2022 03:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com> <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
In-Reply-To: <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 Jan 2022 19:14:25 +0800
Message-ID: <CAAd53p6+KPAJchh9Jx59Fkkj5FidSxsW0yHjLqooFjvu-Y9u7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 3:01 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/1/27 10:54, Kai-Heng Feng wrote:
> > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > hint") enables ACS, and some platforms lose its NVMe after resume from
> > S3:
> > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >
> > It happens right after ACS gets enabled during resume.
> >
> > There's another case, when Thunderbolt reaches D3cold:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > So disable AER service to avoid the noises from turning power rails
> > on/off when the device is in low power states (D3hot and D3cold), as
> > PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> > transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> > with aux power) and L3 (D3cold).
> >
> > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
>
> I don't know what this fix has to do with the commit 50310600ebda.

Commit 50310600ebda only exposed the underlying issue. Do you think
"Fixes:" tag should change to other commits?

> Commit 50310600ebda only makes sure that PCI ACS is enabled whenever
> Intel IOMMU is on. Before this commit, PCI ACS could also be enabled
> and result in the same problem. Or anything I missed?

The system in question didn't enable ACS before commit 50310600ebda.

Kai-Heng

>
> Best regards,
> baolu
