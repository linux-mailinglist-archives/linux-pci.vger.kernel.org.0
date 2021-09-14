Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8448940AFA0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhINNxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhINNxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 09:53:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBEC061574;
        Tue, 14 Sep 2021 06:52:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso2060157pjb.3;
        Tue, 14 Sep 2021 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OBuM8TqJ0Hiy++w0Eg3iCTeKL45+UH97Wc5WiqGlxYk=;
        b=eEN/Cjx/RaHtIuifTzIWtuTNXKn8gN7MXFN1fkI/BBhKK6N8yNK1egUZx6Da0ngWPm
         4CyFlthWnBdrVPGH5fxFgu6g6VUQH6THmXauJJaclzQFID3Pl9tghRPKFiTU2b+vAXjY
         4wQS8Z3dv3uWNA8aW2T612eXFIiVHtj8zvmt5CkuuDOdsI94bnDB9Lz8ITLswRwz9YYJ
         KGugdCwyd2t2b0XfFKZ7EXIeFO9Mhxpu7rxald7qSmyebUL8sMUjdQXjTkZWVLcDnxVS
         W6U4CBI0RrTWjUbcWgpbwcfy8ZllzRSNNTlBna4UpU1ilh3mx80C67OXU86/9LAFygfQ
         YUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OBuM8TqJ0Hiy++w0Eg3iCTeKL45+UH97Wc5WiqGlxYk=;
        b=ED93Yvt1rORh9azeDQ6BB0lfXwSUO8e6cFBtWP1rosSwIyuIiuOkaTvIXRh5KSxg3G
         mynN6gp82oNmpaunOY08sY3UovhAq91zUOQb4FPY0yvkp6N8iA0dN9LlRHmeXNDHmBYt
         yQoQqxI5H9n7dNhPyC6h49Yzg8W7cwfTkL+/vQCUb01LRnBv4IEHSN3jfKiSD1K7QlMy
         nN8QY+Js+oP5U/vhEDaP4rD+dRUZecPYStIycjZX52FoLDonf90FR2M99+GshrIVjELp
         UG9Z3RzJmZNOCFx25eEJWD9jrAS9KQN3QbB2mLQIi+0AnzidhayevndzLefuhbinuYGv
         OhHQ==
X-Gm-Message-State: AOAM5320k94w8oiyr9sUKNkenn08XhKSZMjvraOn44ZXruCsBeDh00cS
        OPZNkwUTyaY6LfYcaJoL2HBGF/MWCWWRPyIrd4Zxoh16
X-Google-Smtp-Source: ABdhPJzi5Dur2NFQQ5T9iQZsUMijQaMGcr7v2R5hGtdc9r2AmXXaZFZAwG4BBUqObGzm+ZSWsJkvmPKgtEDaJpkN2U0=
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id
 x5-20020a1709028ec500b0013a2789cbb0mr15236406plo.60.1631627540581; Tue, 14
 Sep 2021 06:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <CAJZ5v0jqwgvmRrRts4Nf4ySmrp5gwmv_iJWBh3OjN54ZU+qneQ@mail.gmail.com>
 <CAJZ5v0hn5EvwjPggCeUw+kjDNjdzx3eLP2PRBGKRAyo2eYECyQ@mail.gmail.com> <YUCodXHfHmap1+la@8bytes.org>
In-Reply-To: <YUCodXHfHmap1+la@8bytes.org>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 14 Sep 2021 08:52:08 -0500
Message-ID: <CABhMZUV50Tp6-UrRnm_E55QiwJvtLQ64qp7Tn2h+pw_uu7M=iA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 8:50 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Mon, Sep 13, 2021 at 06:14:38PM +0200, Rafael J. Wysocki wrote:
> > Should I assume that Bjorn will be taking it?
>
> No idea, checking git-log on the file shows mixed Signed-off-bys from
> both of you. Bjorn?

I'll merge it, hopefully this week.  Thanks!

Bjorn
