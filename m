Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E24A543A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiBAAoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiBAAoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 19:44:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48FC06173B
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 16:44:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h12so15546858pjq.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ogo17UqARJL4p9/LnCmhjKJqbXuqhpyXuwxM70OGXlE=;
        b=c/376VNugm56bLwLAeXVu2BkqPu6SjdkyjMHwccQMq8pothhH4fO8WLySebdQcMD4H
         loG6kUDzEYGhQa82gRKpqVhOUHGnewKq/WNZn4MLGesAnoMvnvbQhu1Ccmfzorl7/cV7
         OEZ8a+Gyd+zal9oBz2vk+PJQ1ZFd02wAtzvnV1tAbXuSUFE0uiKuvI42UmDmm80R1WgK
         qZraj11WiDcWOoImxxnH99Y/W4JqELiqXkCQspluqqhexUHlEUIM4J7frzjmYmFoBaye
         9hOQk1hvkjH22urQF4Xy+PUpnHRRP/n5r+l7X+ZI4MhAcXNBPDWUZF2VpwBzSt0a41ob
         E1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ogo17UqARJL4p9/LnCmhjKJqbXuqhpyXuwxM70OGXlE=;
        b=7LbFgcaoTjnJCHlsP546ndlOYcOg/jtSgzYo8G8E2urccbnN6jyIjat29sWUA8Gi3F
         CA5X5L4uOZZEIwwnd+JLB5q1xmR5Du7/oTb+8lYzi47l4nWgl4fUvs16QO8Jlycwj/TA
         WIaGVQksd6jZJIyKtOgcKl5ncm0OgrtWDWeL02gCzv64P8+Lsm2aYovof/dTwfIeXWCu
         09bzKIQPT8Ec7djZ/c9K7HwN6xcZHk68zEb6nAPyUV5p27yL2ZFL1P9IygRguCx19Crf
         xJL46fWssuPtlk3urzbuSKwn9X12pkzJRJbRnBI7GEY8b8kKj8ydfG2OffueT0bTk0PK
         Xd6A==
X-Gm-Message-State: AOAM5332kNIy77ysY2vZJPkC2bsxnCrhtaI3ir+dQnBGHTHNuh8NpkE8
        RHmNa8oDDXAxptxXC8KIYEAJiolqEEGEcapOFJfCUQ==
X-Google-Smtp-Source: ABdhPJwvfdKe0O3cEdLQmli0XryY4gO5HzlQNdngTCrUOV66YWmpQb/QY9/oJXGJogWtu0TkcS3vUNlsGbmDbUQ6wDg=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr22672490ply.34.1643676245916;
 Mon, 31 Jan 2022 16:44:05 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298422000.3018233.4106867312927858722.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131234740.bzg63pqyf2wl3din@intel.com>
In-Reply-To: <20220131234740.bzg63pqyf2wl3din@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 16:43:58 -0800
Message-ID: <CAPcyv4gAJO+eqep1Ba1TtHUccfCw2yEjaHSV8iDhHJ9H8oADUQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/40] cxl/port: Up-level cxl_add_dport() locking
 requirements to the caller
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 3:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:30:20, Dan Williams wrote:
> > In preparation for moving dport enumeration into the core, require the
> > port device lock to be acquired by the caller.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c            |    2 ++
> >  drivers/cxl/core/port.c       |    3 +--
> >  tools/testing/cxl/mock_acpi.c |    4 ++++
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index ab2b76532272..e596dc375267 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -342,7 +342,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >               return 0;
> >       }
> >
> > +     device_lock(&root_port->dev);
> >       rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
> > +     device_unlock(&root_port->dev);
> >       if (rc) {
> >               dev_err(host, "failed to add downstream port: %s\n",
> >                       dev_name(match));
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index ec9587e52423..c51a10154e29 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -516,7 +516,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> >  {
> >       struct cxl_dport *dup;
> >
> > -     cxl_device_lock(&port->dev);
> > +     device_lock_assert(&port->dev);
> >       dup = find_dport(port, new->port_id);
> >       if (dup)
> >               dev_err(&port->dev,
> > @@ -525,7 +525,6 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> >                       dev_name(dup->dport));
> >       else
> >               list_add_tail(&new->list, &port->dports);
> > -     cxl_device_unlock(&port->dev);
> >
> >       return dup ? -EEXIST : 0;
> >  }
> > diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
> > index 4c8a493ace56..667c032ccccf 100644
> > --- a/tools/testing/cxl/mock_acpi.c
> > +++ b/tools/testing/cxl/mock_acpi.c
> > @@ -57,7 +57,9 @@ static int match_add_root_port(struct pci_dev *pdev, void *data)
> >
> >       /* TODO walk DVSEC to find component register base */
> >       port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > +     device_lock(&port->dev);
> >       rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> > +     device_unlock(&port->dev);
> >       if (rc) {
> >               dev_err(dev, "failed to add dport: %s (%d)\n",
> >                       dev_name(&pdev->dev), rc);
> > @@ -78,7 +80,9 @@ static int mock_add_root_port(struct platform_device *pdev, void *data)
> >       struct device *dev = ctx->dev;
> >       int rc;
> >
> > +     device_lock(&port->dev);
> >       rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
> > +     device_unlock(&port->dev);
> >       if (rc) {
> >               dev_err(dev, "failed to add dport: %s (%d)\n",
> >                       dev_name(&pdev->dev), rc);
> >
>
> Since I really don't understand, perhaps an explanation as to why you aren't
> using cxl_device_lock would help? (Is it just to get around not having a
> cxl_device_lock_assert())?

Whoops, this gets fixed up later on in , but I rebased this patch and
didn't notice that I inadvertently dropped the lockdep stuff. Will
rebase this hiccup out of the history.
