Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30F832DD7A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 23:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCDW7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 17:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCDW7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 17:59:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57255C061574
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 14:59:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r17so52637589ejy.13
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oaxzDaAGTES0vYpNeOOnbfAZRF/yUFb0r97L7fvwis=;
        b=1GFjigifn4yzgtgvQY5lao7Uo32d7N++2U5dYqzRbewHBBKJb5085LKY/NBI5fkPNQ
         +tnfuGr58Ws4VrjaqBm9iRt+eYiQ4+kZb9lJNBRgS3EGvhWNLMWCmmx7fV5DvoVPh2FR
         rfY4u0hK5DayBefgsgjmnFtmjUCGPigStHqkm/lwqKRQNdwVtTkIlwLTgBtF8xFvcLZt
         h44hzT49JLYBQv+xlzuv1nwFxFrDtghMVX/TRzKBhG3MNspwWQ32p2tZ+bO8AI+aA1Qm
         UWi2EmzBJ8B17JziD4K3DjyMjYwB2xuxYZSzQl8mhyi5GVFVWMmH/8n2Q2wJfqIc0Asp
         vyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oaxzDaAGTES0vYpNeOOnbfAZRF/yUFb0r97L7fvwis=;
        b=AJo9QzJSAfA/cHWmMAdIiiogINkFhklTfsFGS56T1zTtIO6jr2zlxDcA/GNhEAR01D
         vtDDxfUuRUrUriouF5+VBOUL5mdGxVLb/DqMG9pGi3ozi21rx2Ky8S9nTLotz0MT5FEs
         TSvQ3yPuMxaBaY1bK//6MB73oxm2UQkpIe8taHraeMVTdhuAXo1E2pW4H+D4688nkWNk
         d7/xFZaw4BUa4r72WSRcRbAPoJ0jcAqsOaElF4Vmokn9spqQs5UkniOfuFYOADWCTzpF
         K1MmE5kE0qbl5tAU8K01mDVYxAbIcFW5f8bmZzncD31S4D+YwNW51Xc5gLcDAcTHA5Az
         LnHw==
X-Gm-Message-State: AOAM53303HnFhKodZGfHwKoMSnQeqck2tPpYXHKUjw/MmBl2BWk839Fw
        sZcHN7k1bMRxBd3JQJs5B8YeS58zA15P3ppUgW8dZw==
X-Google-Smtp-Source: ABdhPJz1tyftUde1A4pZ0dEih4S3DIMij0ElrbpFjkCV9RD1GUNaIoFdSjlRiOF77fwsBn/aJ8DeghejkXn9055BHYk=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr6525664ejc.45.1614898753044;
 Thu, 04 Mar 2021 14:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20210104230300.1277180-1-kbusch@kernel.org> <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com> <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
 <CAPcyv4gZPc3izOaRBx8sBBM_1YV3F3OMjjZX8Ha0m3PxzJhiCw@mail.gmail.com> <23551edc-965c-21dc-0da8-a492c27c362d@intel.com>
In-Reply-To: <23551edc-965c-21dc-0da8-a492c27c362d@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Mar 2021 14:59:05 -0800
Message-ID: <CAPcyv4jFYtNeA7TdeCBh5v1S=Pw2BGvdv91SMjX0MTj_0VE4DQ@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 2:38 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@intel.com> wrote:
>
>
> On 3/4/21 2:11 PM, Dan Williams wrote:
>
> On Thu, Mar 4, 2021 at 12:03 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Mar 02, 2021 at 09:46:40PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>
> On 3/2/21 9:34 PM, Williams, Dan J wrote:
>
> [ Add Sathya ]
>
> On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
>
> Overwriting the frozen detected status with the result of the link reset
> loses the NEED_RESET result that drivers are depending on for error
> handling to report the .slot_reset() callback. Retain this status so
> that subsequent error handling has the correct flow.
>
> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
>
> Just want to report that this fix might be a candidate for -stable.
>
> Agree.
>
> I think it can be merged in both stable and mainline kernels.
>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Just FYI, this patch is practically a revert of this one:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6d2c89441571ea534d6240f7724f518936c44f8d
>
> so please let me know if that is still a problem for you.
>
> For what it's worth I think "6d2c89441571 PCI/ERR: Update error status
> after reset_link()" is not justified. The link shouldn't recover if
> the attached device is not prepared to handle DPC events.
>
> I added that fix to address the recovery issue seen in a Dell server
> platform (for EDR test case). If I understand the history correctly,
> In EDR case, AER and DPC is owned by firmware, hence we get
> PCI_ERS_RESULT_NO_AER_DRIVER when executing error_detected() callbacks.
> So If we continue the pcie_do_recovery() with PCI_ERS_RESULT_NO_AER_DRIVER
> as error status, then even if we successfully reset the link we will report
> the recovery status as failure.

But that's the right response if there is no handler. If there is a
device attached that was not prepared for the link to go down then it
does not matter if the link comes back ok that device will be
thoroughly confused and should be disconnected.
