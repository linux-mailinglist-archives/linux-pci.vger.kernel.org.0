Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805A62996B2
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784379AbgJZTVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 15:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784322AbgJZTU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 15:20:59 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDA620878;
        Mon, 26 Oct 2020 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603740058;
        bh=7TZphWKrs9mpj6vBHq6b5Odzyi6d3f2ELzDlWmITbIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eS3BiTVbxrf8IEwpOBXElPJ1aMbbSy1ydYRFpps3DkiJ6BIslZLhGPzmz9MNHOEDC
         pJfnfhxLd6TbKbVvARLG8ML/0KCNkfwESVRfRWgoqenJ7deqTidrZ7iTu/q4YMZNxy
         N9LTbphNXXuqrONqtRrDsRe36wK21IwcXboINmps=
Received: by mail-ot1-f43.google.com with SMTP id h62so9021229oth.9;
        Mon, 26 Oct 2020 12:20:58 -0700 (PDT)
X-Gm-Message-State: AOAM532Sx2Z8nmlxJLYUstlC9lFl6NgrerAXDLVYz94EQEbOZKEXjeiK
        lXSmOPil4ocuojNGMyCuZaTqlEtAk1q01g+qAw==
X-Google-Smtp-Source: ABdhPJxac/RBkl+sziHYXw95BQeG7XDR886hsl+jJA3/pP5fc6MnIhxB21EaZNRN/5NeEz/B4PITTsz8L+ijFWx3mDE=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr14962544otm.129.1603740057640;
 Mon, 26 Oct 2020 12:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930182105.9752-1-nadeem@cadence.com> <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
 <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
 <d2aa5519-e207-c3e5-9d81-14209d856b54@ti.com>
In-Reply-To: <d2aa5519-e207-c3e5-9d81-14209d856b54@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Oct 2020 14:20:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKdAzi4zu=U=DPF_VBjTt9287gsTR1hgDWriMKdsx+MNA@mail.gmail.com>
Message-ID: <CAL_JsqKdAzi4zu=U=DPF_VBjTt9287gsTR1hgDWriMKdsx+MNA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 1:57 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Nadeem,
>
> On 19/10/20 10:48 pm, Athani Nadeem Ladkhan wrote:
> > Hi Kishon,
> >
> >> -----Original Message-----
> >> From: Kishon Vijay Abraham I <kishon@ti.com>
> >> Sent: Monday, October 19, 2020 10:59 AM
> >> To: Athani Nadeem Ladkhan <nadeem@cadence.com>;
> >> lorenzo.pieralisi@arm.com; robh@kernel.org; bhelgaas@google.com; linux-
> >> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Joseph
> >> <tjoseph@cadence.com>
> >> Cc: Swapnil Kashinath Jakhade <sjakhade@cadence.com>; Milind Parab
> >> <mparab@cadence.com>
> >> Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
> >> training defect.
> >>
> >> EXTERNAL MAIL
> >>
> >>
> >> Hi Nadeem,
> >>
> >> On 30/09/20 11:51 pm, Nadeem Athani wrote:
> >>> Cadence controller will not initiate autonomous speed change if
> >>> strapped as Gen2. The Retrain Link bit is set as quirk to enable this speed
> >> change.
> >>>
> >>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> >>> ---
> >>> Changes in v3:
> >>> - To set retrain link bit,checking device capability & link status.
> >>> - 32bit read in place of 8bit.
> >>> - Minor correction in patch comment.
> >>> - Change in variable & macro name.
> >>> Changes in v2:
> >>> - 16bit read in place of 8bit.
> >>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 31
> >> ++++++++++++++++++++++
> >>>  drivers/pci/controller/cadence/pcie-cadence.h      |  9 ++++++-
> >>>  2 files changed, 39 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>> index 4550e0d469ca..2b2ae4e18032 100644
> >>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>> @@ -77,6 +77,36 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>>     .write          = pci_generic_config_write,
> >>>  };
> >>>
> >>> +static void cdns_pcie_retrain(struct cdns_pcie *pcie) {
> >>> +   u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> >>> +   u16 lnk_stat, lnk_ctl;
> >>> +
> >>> +   if (!cdns_pcie_link_up(pcie))
> >>> +           return;
> >>> +
> >>
> >> Is there a IP version that can be used to check if that quirk is applicable?
> > There is no such provision.

Cadence just gives out unversioned IP? There may not be s/w readable
version, but there's still a version. Look at DWC.

> hmm okay. Can we add a DT property to indicate the quirk then since
> AFAIK this is not required in future revisions of IP.

No, add a driver quirk flag, but set flag that based on compatible strings.

> >>> +   /*
> >>> +    * Set retrain bit if current speed is 2.5 GB/s,
> >>> +    * but the PCIe root port support is > 2.5 GB/s.

Though wouldn't setting the retrain bit be harmless even if not needed?

Rob
