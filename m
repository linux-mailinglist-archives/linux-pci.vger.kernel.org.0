Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E781F51C2E5
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiEEOwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiEEOwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 10:52:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558445AA7E;
        Thu,  5 May 2022 07:48:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so5475144ede.8;
        Thu, 05 May 2022 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd70nvC/kGik6EimE0pvtKLSK3cMZ3QY965UUQGAHsQ=;
        b=p0TmC0ikJBR+grxIKAFpjv+/t2z7SoAaG5Iu3Qrp4QMC6iCbAqOESWe7xp7EEYFcyd
         Idu0mWp1LoxM+JsyihAomcyyxlSbeGy7fao6qKpPs2GXv59BjQ+/UOrJojMDcjjJRi6u
         hmip7B2MRWaZPJNQDi0xuRJFygjW/25N2iJP7SUWmM5IFUQ9budOFDrNgYDTdoveHU/O
         YwUMYcURtUL/ivq5S06bEO61NFk0MQsawbiq8Jwfms0TGH91hV7TV3p53xvAVF5rOKx/
         0i3zmR1SBdfyRXIEypmk3GIAt9zYmYZnFfAD1BN9EQAsqV9Lp2l/fvGx4YJEfuIf7QQy
         z6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd70nvC/kGik6EimE0pvtKLSK3cMZ3QY965UUQGAHsQ=;
        b=qoBQ+nVTVzm0iKuv/e2zq1b7oWzi5Ya+6IQ5NxdW/k8ArZfTc3SBOnek26TAjllK6C
         WgBobh8tBxgxyrNji1YTxcoVboDef9LqYQ0t2xxZvf5BCI67tn/7C1nsNYtDZGZYvRU8
         EbSuO7kTjnWNyK5yL+JJYBKgTun6lx5N7a6Z4EZ/TM0qX6QIAeaAn8e5MDiqvWR6oiI0
         gXxznRYHyiMeUfqcUEPFcv21p+WD3hSipnuNf857pYND4xj1/KenwOqSUA4L3iJsk6cB
         Ydri7LbUcmiJul2o3HpPnj51H3i/hFSqq8P+84A/0Rx1xWI0/pYmOjk4KH1eBgqyR9bu
         tvtQ==
X-Gm-Message-State: AOAM53299+C3oKSzF0z+tXkMxfmhZ7eWQHUmm697xoM4ETvmgGoD3kFu
        27j+gj8djSHxoiuEIDfWR/cumjkXRp+9OV2mTm3Laz4n
X-Google-Smtp-Source: ABdhPJztF1kabtWoNgLYmA+4ymkpEypoqrPwztbeQVyiCrSsOKjATNMfHr7gY5SFRAQc1JI9cKYW54+QjT+6jlc720U=
X-Received: by 2002:a05:6402:515:b0:425:bd3f:1ad4 with SMTP id
 m21-20020a056402051500b00425bd3f1ad4mr29884789edv.381.1651762108721; Thu, 05
 May 2022 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220429105627.GA28438@lpieralisi> <20220429192825.GA82239@bhelgaas>
 <20220505144347.GA19346@JADEVM-DRA>
In-Reply-To: <20220505144347.GA19346@JADEVM-DRA>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 5 May 2022 16:48:17 +0200
Message-ID: <CAH9NwWcU71gZ2woZ7ePRvuwz=_T+F7V6VOYLyAqPhTy1j6xxPA@mail.gmail.com>
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Dominic Rath <dominic.rath@ibv-augsburg.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Do., 5. Mai 2022 um 16:43 Uhr schrieb Dominic Rath
<dominic.rath@ibv-augsburg.net>:
>
> On Fri, Apr 29, 2022 at 02:28:25PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 29, 2022 at 11:56:27AM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Feb 22, 2022 at 07:40:54PM +0530, Kishon Vijay Abraham I wrote:
> > > > On 18/02/22 6:50 pm, Bjorn Helgaas wrote:
> > > > > On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> > > > >> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > > > >>> Update subject line to match previous conventions ("git log --oneline
> > > > >>> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> > > > >>>
> > > > >>> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> > > > >>>> This enables the Controller [RP] to automatically respond
> > > > >>>> with Response/ResponseD messages.
> > > > >
> > > > >>>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > > > >>>> +{
> > > > >>>> +    u32 val;
> > > > >>>> +
> > > > >>>> +    val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > > > >>>> +    cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> > > > >>>
> > > > >>> I assume this is some device-specific enable bit that is effectively
> > > > >>> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > > > >>> Capability?
> > > > >>
> > > > >> That's correct. This bit enables Controller [RP] to respond to the
> > > > >> received PTM Requests.
> > > > >
> > > > > Great!  Christian, can you update the commit log to reflect that
> > > > > both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> > > > > respond to received PTM Requests?
> > > > >
> > > > > When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> > > > > and the PTM Responder Capable bit (for which we don't have a #define)
> > > > > read as zero?
> > > >
> > > > I see both PTM Responder Capable bit and PTM Root Capable is
> > > > by-default set to '1'.
> > >
> > > Without this patch applied and with no other SW setting
> > > CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, correct ?
>
> Yes. The capability bits default to '1', even if
> CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared. Strictly speaking the current
> behavior is wrong, and the capability bits should be cleared instead.
>
> > > > root@am64xx-evm:~# devmem2 0xD000A24
> > > >
> > > > /dev/mem opened.
> > > > Memory mapped at address 0xffffa8980000.
> > > > Read at address  0x0D000A24 (0xffffa8980a24): 0x00000406
> > > >
> > > > And this bit can be programmed through the local management APB
> > > > interface if required.
> > >
> > > Which bit ? CDNS_PCIE_LM_TPM_CTRL_PTMRSEN ?
>
> I believe "these bits" would have been more correct. Since these are
> capability bits, the AM64* TRM lists them as read-only, but of course
> they can be modified. To write them, you need to set bit [21], e.g.
> you can write the PTM capability register at address 0xD200A24. At
> the TRM address 0xD000A24 it is read-only.
>
> > >
> > > > But with this patch which enables PTM by default for RC, it
> > > > wouldn't be required to clear those bits.
> > >
> > > Yes but that does not comply with the specifications as Bjorn
> > > pointed out below.
> > >
> > > We can merge this patch but it would be good to investigate on this
> > > point.
> >
> > I *think* this is OK.  Correct me if I'm wrong:
> >
> >   - We're talking about a Root Port.
> >
> >   - The Root Port's PTM Capability reads as 0x00000406 (PTM Responder
> >     Capable and PTM Root Capable set).
> >
> >   - Without this patch, setting PTM Enable does nothing, and the Root
> >     Port does not send PTM Responses.
> >
> >     This is the non-conforming situation because the Port claims that
> >     it implements the PTM Responder role, but it can't actually be
> >     enabled.
> >
> >   - With this patch that sets CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
> >     Enable bit still powers up as zero, so the Port does not send PTM
> >     Responses, but setting PTM Enable enables PTM Responses from the
> >     Root Port.
>
> This is correct.
>
> >
> > So I think that after setting CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
> > capability works as per spec.
> >
> > I think the proposed subject of "Enable Controller to respond to
> > received PTM Requests" is somewhat misleading, though, because PTM
> > responses still aren't enabled until we set PTM Enable.  I suggest
> > something like:
> >
> >   PCI: cadence: Allow PTM Responder to be enabled
>
> I'll ask Christian for permission to resend his patch with the subject
> changed.
>

I will send a new version tomorrow with an improved subject line.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
