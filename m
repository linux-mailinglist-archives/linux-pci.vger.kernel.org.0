Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476CA32B25E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhCCB6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574473AbhCBPQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 10:16:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBDC061356
        for <linux-pci@vger.kernel.org>; Tue,  2 Mar 2021 06:44:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ba1so12170514plb.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LN47YQRLXAfp8nIdMqhDzM0X4bI1obU+R6IhTtEL2Io=;
        b=a+pZDevbRMBzVHeyVrUO9js4WTarj30oxeztG1eQ/JH7bSHlNTEgfumDapN+L1xUBd
         thkX0uJmPfv4AiDasKw99D5O4jWj3bMshkghODPCVcqXhd1EUV3Hn2/ilJEmrKZDPehA
         T/xbhdm0wr8I2T4sf1xq1KGxy10gCsMDfr2mbmlqUX2ySIOYC5sTV1IpYP38qB2LVytv
         efRwChaOd7/aLOzypxV2f8N0GGdxCGuWsbOcyiO8KVtIF39B68Y3Z10gqihSZiyW+tBh
         3nh1ppaJC+A63UdxcgA66Cb1usc+ut9KZ9FINzV4iEW0gksDjtUXhSUskbVbHMrl7zER
         eIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LN47YQRLXAfp8nIdMqhDzM0X4bI1obU+R6IhTtEL2Io=;
        b=LZ9H2rZcIYkIwI9OjRSHhxZMk8j+rZXhJgPryipsU+LZxfPUPz0EVEdJ+xcF5jhWdX
         WAxKstQtvjNvCBM5mKJ9k2gSxt3RHUDRiFOcOfEl4yP3uAXYHlKlh7c/lJiCYTlEIwGW
         ydiK5tIdR5e9x4rcQdi114h7KjrbOKpIlxYGidp6w92aX2zs9HSw90gnk9JZUkyeUsgu
         TIszxHeYAGDTbXOsLBOfOPG3qvVcA6GvpAYDj7ici//ad/I5cO7w4z5dUIy8vskgEj7c
         XsH+IgHMwy2lAFsmIvN+I7dzAaVnXdRrqOtdegCATQ9h0WoqsA1SPfgTz2cqTrn9xO5D
         MYBA==
X-Gm-Message-State: AOAM530WFIFWUxRduaQLBgciysm5xFdM12pd0ljgdP4jzOR7eMv4P5wF
        TNb2QS+Vh57zD8SypOLROmVLOZsYNM1t8lz5keyW1A==
X-Google-Smtp-Source: ABdhPJx4KB3uDOfcVX2aHG/MRoxaLduQ1Apbymam8qtnXkHoi83pWR8tDMhX7mZ+LUCn3l7asUrDrvx4IQV7v1XDe8M=
X-Received: by 2002:a17:90a:1463:: with SMTP id j90mr3963527pja.205.1614696264461;
 Tue, 02 Mar 2021 06:44:24 -0800 (PST)
MIME-Version: 1.0
References: <CAMZdPi9PGWcPOHKk3cNU3Nw+hdVOsivLeXzqyd2FQ7nn8dDfvg@mail.gmail.com>
 <20210226222225.GA164608@bjorn-Precision-5520>
In-Reply-To: <20210226222225.GA164608@bjorn-Precision-5520>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 2 Mar 2021 15:52:05 +0100
Message-ID: <CAMZdPi-mmwYa4CqTtaNW3X8RrMzE8F0QchzqkB4SQ0QHCQvPVg@mail.gmail.com>
Subject: Re: PME while runtime suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, 26 Feb 2021 at 23:22, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Dave (author of 42eca2302146), Vaibhav, linux-pm]
>
> On Fri, Feb 26, 2021 at 11:37:12AM +0100, Loic Poulain wrote:
> > Hi Bjorn,
> >
> > Trying to support runtime suspend in a driver, which puts the device
> > in D3hot and wait either for host/driver initiated resume
> > (runtime_get), or device initiated resume (PME).
> >
> > But, given that old change: 42eca2302146 ("PCI: Don't touch card regs
> > after runtime suspend D3")
> >
> > PME that was enabled from pci_finish_runtime_suspend() is not enabled
> > anymore for almost all drivers in case of runtime-suspend. The only
> > way to enable this is by calling pci_wake_from_d3() from the PCI device
> > driver's runtime_suspend() callback, but this function fails if the
> > device wake_up is not enabled, which makes sense since it targets
> > system-wide sleep wake-up (and wake-up is user/distro policy).
> >
> > So is there a proper way to allow PME while the device is runtime
> > suspended, without having to tell the user to enabled 'unrelated' wake_up
> > capability?
>
> pci_pm_runtime_suspend() calls pci_finish_runtime_suspend(), which
> enables wake-up, unless "pci_dev->state_saved".  IIUC we should be
> enabling wake-up unless the driver has called pci_save_state() itself.
>
> So I infer that your driver does call pci_save_state() and the PCI
> core does not enable wake-up.  Right?

Right.



>
> Why does your driver call pci_save_state()?  In most cases I don't
> think drivers should need to do that themselves because the PCI core
> will do it for them.  E.g., see Vaibhav's recent eb6779d4c505 ("e1000:
> use generic power management") [1]

Thanks for the pointer, I was storing the PCI state in order to
restore it when the device is crashing and lose its PCI context. But I
can do that one time once the device is initialized. I've applied the
same changes as you pointed, and it works as expected.

Thanks,
Loic
