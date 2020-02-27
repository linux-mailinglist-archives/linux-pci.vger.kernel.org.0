Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48839170E57
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 03:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgB0CTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 21:19:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38755 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgB0CTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 21:19:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so1335696edr.5
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2020 18:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcoWdnerPpa+zK/P0vhU/glnANAYYkOXJMkEDIK7xws=;
        b=wzbCuA9QiXCM7mHhhSCgncYM8569BHI6sWQ+xH1QRtBzu+lzaH6WeTEIwDfMt7p0Ve
         kiY32WrT84HIo+OtF8SQZxzonFiHqkdMXF+IGiI0YU70fn3Yak7fPKNlAClyc6Q8jWt0
         HEK20pyCaYwE1yXgb+J8ziQ+apUmgP/QQhi2sMskhkZ4uWJXi3afcJjszVHHTz4U4IQc
         wCD6KMycSs0go0RrEh+g7DdkFYx629BAY2wVNidtyFBhPmfWlg/rsr94w6fi+L/XuC6i
         2rcv5mv0bve+MGvrg4j1uXlpC00w3blFDCELnEdT9hyZIKkFoqrGsjdBTeeUyYTXa6Nk
         w+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcoWdnerPpa+zK/P0vhU/glnANAYYkOXJMkEDIK7xws=;
        b=hzdXGGDLNkI7vQGBXAG9uD4RD1god9TpisKXRfwLhbG2VGSIkWreejJX66yvqiFVVX
         8gUUC5aCsz+r0g5RKjSL19ieosZo15VQnhMwz097vbwoLGDspZZrTrjKj8nLlq3Q+LxE
         UJuBUjG4YPUNA/OcBhVylQGpKq007V4g5ArbUbXrUWqiQwGnZ9jRvDBxe8eAjFApnfvO
         shX+rqokvW5k47gH5QtHyHv3Jj1/kE7NC07KsJYewksRkuz+pBqTfJbmuL7AyGFft1p/
         nHNM95fYdD+8MsrMRuarGKeCKpRTrxthscnrzk37cLKxQLJLGCIY6G1R0+h+vTolSyB/
         +0Hg==
X-Gm-Message-State: APjAAAWEjBIse53unATrj+IPQcYooVnptqhP5DHZ31akjgHwOB8xDqXh
        izM80xOx0E6HSRp2qY5qOsR+4wgG8nJRKCfvGhi4qQ==
X-Google-Smtp-Source: APXvYqxV82iVTF2fjXLhO7hMAa9T8sAAsObqUH93eZ2i9gkhZj1PxFnbPWvO6D5UsLB2NwghFAoAYCwXFQNOl1l1nGw=
X-Received: by 2002:a50:ef1a:: with SMTP id m26mr1299388eds.289.1582769991844;
 Wed, 26 Feb 2020 18:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20200109032851.13377-1-shawn.guo@linaro.org> <20200109032851.13377-3-shawn.guo@linaro.org>
 <20200226113105.GA16925@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200226113105.GA16925@e121166-lin.cambridge.arm.com>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Thu, 27 Feb 2020 10:19:41 +0800
Message-ID: <CAAQ0ZWR0JNxJV=Ly1yONGo-9cYTt8DZPwp+Qsfuger1katEFHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: histb: Correct PCIe reset operation
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Jun Nie <jun.nie@linaro.org>,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 7:31 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Jan 09, 2020 at 11:28:51AM +0800, Shawn Guo wrote:
> > The PCIe reset via GPIO in the driver never worked as expected.  Per
> > "Power Sequencing and Reset Signal Timings" table in
> > PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, the PERST# should be
> > deasserted after minimum of 100us once REFCLK is stable.
> >
> > The assertion has been done when the GPIO is being requested, and
> > deassertion should be done in host enabling rather than disabling. Also
> > a bit wait is added to ensure device get ready after reset.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-histb.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
>
> Shawn,
>
> this looks like a fix, please tag it as such and let me know if
> it has to be backported, in which case also the previous patch
> should I assume.

Hi Lorenzo,

It is a fix, but we recently realized that the problem needs to be
fixed in a way that does not break existing DTB.  So please ignore the
series for now, and we will try to work out a better one.  Sorry that
we did not update the thread in time.

Shawn
