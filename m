Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66AE4BBA3C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiBRNmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 08:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiBRNmy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 08:42:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AC43EE4;
        Fri, 18 Feb 2022 05:42:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm8so5922145edb.3;
        Fri, 18 Feb 2022 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJOctJ2qXUwbbeXOREiTkqIgHkzXZIrQ6OyODZ9qd4g=;
        b=iwxtqfJrO784JKI2KrBHQn00Y4o/MhAc0WQ1o6LXzdeAONAwj0uBpG8as56KIQkiYe
         CIrTElXf45qohLTn8Y+jGW9+HTu31/enXU2XmozR21H1dx4c2dogREGSbOKkL/JWD+br
         QvWAMpSrFpGVOue5feXHmhMOokInDQJYfUuhcxXCETc5d40MxILhBWHWcmPCJ5E9Gt6P
         KTsFa3BbdpE3rMJgo4ibuh0PWPJaBiN2FyxOLsLJ4488pnxqJ9cQ6lYLOHMERR0FdwG4
         pK+e61oVl33L57sdOUMxpLo+PsEfKrmjyryrTB+pW5NvmBL38C7/+fSiMXnxBKw/sNF0
         5Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJOctJ2qXUwbbeXOREiTkqIgHkzXZIrQ6OyODZ9qd4g=;
        b=0XpafGVLW0/pfwcapn67vOEwaGYLx/TahuwwwlR0V/OnWYsOzoga/YVgwZMTFIwNxl
         Q9gaCFaZEwh9FBhkYsAtRGhJUC1EUPs8pDSqOrzXsOJdLzFPyFAMLrxrFpR3FOGOYpxS
         cTp1OSXLFZXE00jUpSuTYiwhPj6LRrWgaf3Lw5ISaZAAcglyNmP2s+gFzx5Dw8GAcBeq
         V+uy5ogHo2I1/utYg1ewE77uEHHt7i0Qg1uluHyFXP8CfDpb/Qjfruq6CumL2AHaCvt3
         9jen4LGuFdrnl2KZj0ltcmManJugPVvrrUnkeQL/TW9gFgvfjQUZkO3aPhnALXck4oj7
         OvdA==
X-Gm-Message-State: AOAM532ELSgkEd9b2MORPY/m7BOThREAdgLShzP0IzewgGVmKMVY4pyr
        e6DKBiTmUxRUfTYPOfGRmNRM4z6EbGoYV52YhZo=
X-Google-Smtp-Source: ABdhPJyojQoMCwsme8o2/W26q0tAz7GxRBwV7MY1BwEo5kXruZodolakWrGFlPcK6boKSaUBRi5ADBXoswVMLy8NpiU=
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id
 a10-20020a056402168a00b003fb600e4cc3mr8259972edv.32.1645191755984; Fri, 18
 Feb 2022 05:42:35 -0800 (PST)
MIME-Version: 1.0
References: <bac4cc7e-f81e-82e6-9b60-e5e3199637d7@ti.com> <20220218132037.GA345784@bhelgaas>
In-Reply-To: <20220218132037.GA345784@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 18 Feb 2022 14:42:24 +0100
Message-ID: <CAH9NwWc_c=Cow9_9qp27Q7gtXFdCekQuEHUx+E9g5HivS82MAw@mail.gmail.com>
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

Hi Bjorn,

Am Fr., 18. Feb. 2022 um 14:20 Uhr schrieb Bjorn Helgaas <helgaas@kernel.org>:
>
> On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Bjorn,
> >
> > On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > > Update subject line to match previous conventions ("git log --oneline
> > > drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> > >
> > > On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> > >> This enables the Controller [RP] to automatically respond
> > >> with Response/ResponseD messages.
> > >
>
> > >> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > >> +{
> > >> +  u32 val;
> > >> +
> > >> +  val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > >> +  cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> > >
> > > I assume this is some device-specific enable bit that is effectively
> > > ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > > Capability?
> >
> > That's correct. This bit enables Controller [RP] to respond to the
> > received PTM Requests.
>
> Great!  Christian, can you update the commit log to reflect that
> both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> respond to received PTM Requests?
>

Would something like this work for you?

---8<---
PCI: cadence: Enable Controller to respond to received PTM Requests

This enables the Controller [RP] to automatically respond with
Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
and PCI_PTM_CTRL_ENABLE bits are both set.
---8<---

> When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> and the PTM Responder Capable bit (for which we don't have a #define)
> read as zero?
>

I can test this out if needed for this change.. but that won't happen
before Monday.

> I think that would be the correct behavior per PCIe r6.0, sec
> 7.9.15.2, and it would avoid the confusion of having the PTM
> Capability register advertise functionality that cannot be enabled via
> the PTM Control register.
>
> > >> +/* PTM Control Register */
> > >> +#define CDNS_PCIE_LM_PTM_CTRL     (CDNS_PCIE_LM_BASE + 0x0DA8)
>
> Other #defines in this file use lower-case hex.

I changed this in V2.


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
