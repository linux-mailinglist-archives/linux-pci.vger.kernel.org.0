Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211C132DE46
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhCEAXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 19:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEAXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 19:23:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69825C061574
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 16:23:10 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bm21so117225ejb.4
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctssx0s49lGSAdWUyMh3xnPoBsxWYBpSg2BkeSWd3Yg=;
        b=L/Iucm4tZynUDeC8hzZbGLAFhLfUd4/O9i4UUcFwGuhazBQRxsfx7XfODc90AilQBT
         GcgxXvPqez0oomVo98w07QAeR21mzYiexh3+dmaIxns0mORlJx1bMi6w/KmrTWmYYZIF
         8oblHjDjVZsrglxYHKV31vpXmwWxUP95fUTmJw8fAWBHLvqtxObYbOji99u7UFGJEVrR
         SVPEJAplsX93MWHleDsQEmouisnwWYeShr27rGTeO/alVYYWnM9eLv+hhzlT58o8E9ob
         MfKQXeWXI9Hb9dJ9NFbsLsFznuePef09ws+U4pqG6SFHI1Ur7qZoi2vy0ZquauzMpYqE
         32aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctssx0s49lGSAdWUyMh3xnPoBsxWYBpSg2BkeSWd3Yg=;
        b=Sj5mAhCu45OWU7iDYUguq9OMvs8ZnbfGTjqMnxZR+HLKynuwI2iTaT8C9C58432OyZ
         ZQnbgomNdLH6sEpoGXtJDPgU+nAj6k0IeOtJ5Y5eOt1LjP2qkga0BeFuIwyLdUJNugKL
         RFxYxHLT/anah2s+rqoF0uHz2eSE3lj2bjvfEZ0lA73QjIHtnAcwmxRrpBmI4zNifH6D
         YnODgQmBzFK3CoqmNZ0mpKGIVc1PrHqNJHUEdAE8cs8NFT0s+M467ogkfSaI1q89CopL
         IIB37UOI7nlrZm300HGBBhCIy3XFgF4FzfsXaS5AnWaLrNJK7HidSv+ExdRBsGpHkq74
         7wjg==
X-Gm-Message-State: AOAM532ZJQ07Ns9YTJl8X+AxhXSduEHaD0GzCCFiEHoiRXOtuFIUAQeb
        cRxBDFiojW7cDOu24uZPL4LoFG8GT6BqRhZdH3Rmyg==
X-Google-Smtp-Source: ABdhPJyxr2cBOdYkx5EjuJxO78gFkTGCiHaIIJJyb1Z2zQSr7PJkEkj51PBxjq4cHXLryrlmgghQZvnYarkgrNrvk74=
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr85804ejc.472.1614903789176;
 Thu, 04 Mar 2021 16:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20210104230300.1277180-1-kbusch@kernel.org> <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com> <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
 <CAPcyv4gZPc3izOaRBx8sBBM_1YV3F3OMjjZX8Ha0m3PxzJhiCw@mail.gmail.com>
 <23551edc-965c-21dc-0da8-a492c27c362d@intel.com> <CAPcyv4jFYtNeA7TdeCBh5v1S=Pw2BGvdv91SMjX0MTj_0VE4DQ@mail.gmail.com>
 <4c2a799f-c4e9-b203-3487-f9c117fba5e7@intel.com>
In-Reply-To: <4c2a799f-c4e9-b203-3487-f9c117fba5e7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Mar 2021 16:23:01 -0800
Message-ID: <CAPcyv4iHPEtpftGMMqkvKW5_SaLJN5R=kVV8urnqibJ5-Lo=_A@mail.gmail.com>
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
To:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 4, 2021 at 3:19 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@intel.com> wrote:
>
>
> On 3/4/21 2:59 PM, Dan Williams wrote:
> > On Thu, Mar 4, 2021 at 2:38 PM Kuppuswamy, Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@intel.com> wrote:
> >>
> >> On 3/4/21 2:11 PM, Dan Williams wrote:
> >>
> >> On Thu, Mar 4, 2021 at 12:03 PM Keith Busch <kbusch@kernel.org> wrote:
> >>
> >> On Tue, Mar 02, 2021 at 09:46:40PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> >>
> >> On 3/2/21 9:34 PM, Williams, Dan J wrote:
> >>
> >> [ Add Sathya ]
> >>
> >> On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
> >>
> >> Overwriting the frozen detected status with the result of the link reset
> >> loses the NEED_RESET result that drivers are depending on for error
> >> handling to report the .slot_reset() callback. Retain this status so
> >> that subsequent error handling has the correct flow.
> >>
> >> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> >> Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >>
> >> Just want to report that this fix might be a candidate for -stable.
> >>
> >> Agree.
> >>
> >> I think it can be merged in both stable and mainline kernels.
> >>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>
> >> Just FYI, this patch is practically a revert of this one:
> >>
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6d2c89441571ea534d6240f7724f518936c44f8d
> >>
> >> so please let me know if that is still a problem for you.
> >>
> >> For what it's worth I think "6d2c89441571 PCI/ERR: Update error status
> >> after reset_link()" is not justified. The link shouldn't recover if
> >> the attached device is not prepared to handle DPC events.
> >>
> >> I added that fix to address the recovery issue seen in a Dell server
> >> platform (for EDR test case). If I understand the history correctly,
> >> In EDR case, AER and DPC is owned by firmware, hence we get
> >> PCI_ERS_RESULT_NO_AER_DRIVER when executing error_detected() callbacks.
> >> So If we continue the pcie_do_recovery() with PCI_ERS_RESULT_NO_AER_DRIVER
> >> as error status, then even if we successfully reset the link we will report
> >> the recovery status as failure.
> > But that's the right response if there is no handler.
> If the handler is not available due to AER being owned by firmware,
> then it needs to be fixed. In EDR mode, even if DPC/AER is owned
> by firmware , OS need to own the recovery part. So I think it
> needs further investigation to understand why it reports,
> PCI_ERS_RESULT_NO_AER_DRIVER

As far as I can see the only way to get PCI_ERS_RESULT_NO_AER_DRIVER
is when there actually is no handler, or the device io state has set
to failed. I notice the hotplug handler sets the device io state to
failed while processing link down. If the device is actually missing a
handler definition then disconnect seems the right response.
